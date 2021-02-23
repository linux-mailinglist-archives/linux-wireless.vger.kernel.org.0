Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20640322527
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 06:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBWFUS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 00:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBWFUS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 00:20:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FB2C061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Feb 2021 21:19:37 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id kr16so1053145pjb.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Feb 2021 21:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2E0rYvjzrRsJ3lPAAXGB7Y+bwvNys343tjVhh14l2UY=;
        b=BtKOlHIKc44OAj1GOyc5v46l4MmDId5NDZghKLDAt9SY73jKeJdr6DQLicrq4MxUX2
         eF2YU+TLZULbms2+cB0UG++YyC+r28Ds/39FNdw9echG1O1inWEXSMKiesW1hslvaqRJ
         scZt9T6DcRFhJ8tkdn5XhoyWRkKj8UWso/Trw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2E0rYvjzrRsJ3lPAAXGB7Y+bwvNys343tjVhh14l2UY=;
        b=p2Mhe+6tFO8nGC7+sLbkx41Y3ODdWGFxg33A6o0yWav1mI4emPq2XRJjDcbGkEWrCo
         VbShyc2ZkQBUzVYrF741ie87dlBhaTc9ygsJvws3NF2mI40rstbjfNbTboBopBTrBN5M
         tK5qdyk6ytKsvsYZKuIUK85aLFLqAK3GKeru+66kMQFRp4OqYe5X4uO9CzR48niAQ0IK
         PZkQu9/Rf9fS6lpA3vvQ/BvvKx4RcB9CTfkRr/KE1hmrEUP4PlBTKmaUzCX/1azJLvwb
         +KyYSkZgZLQtjllTy4XLn/psygWVmMfGhmDmfE8HWNzCG/xmeocE2vZBGV81oXZF38NQ
         0CLQ==
X-Gm-Message-State: AOAM532+WA69jGgz2eV93NJhMwLZUW1nU/wcQp2DH7kqNeisaZGMYLcI
        akW3TVMTCDpRYKcYIU9c/k+94A==
X-Google-Smtp-Source: ABdhPJxgoMARcAqomYLZ/Q5FUhH6Chzw6TP+xCgmVvfBaDD/IzEee3k4QQw6xUO9EaWdDzMPCA2eCw==
X-Received: by 2002:a17:90a:657:: with SMTP id q23mr27649223pje.192.1614057577474;
        Mon, 22 Feb 2021 21:19:37 -0800 (PST)
Received: from localhost ([2401:fa00:1:b:dc56:d1a1:1f2:1b6b])
        by smtp.gmail.com with UTF8SMTPSA id j15sm1338030pjg.40.2021.02.22.21.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 21:19:37 -0800 (PST)
From:   Yen-lin Lai <yenlinlai@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org,
        Yen-lin Lai <yenlinlai@chromium.org>
Subject: [PATCH] mac80211: Allow HE operation to be longer than expected.
Date:   Tue, 23 Feb 2021 13:19:26 +0800
Message-Id: <20210223051926.2653301-1-yenlinlai@chromium.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

We observed some Cisco APs sending the following HE Operation IE in
associate response:

  ff 0a 24 f4 3f 00 01 fc ff 00 00 00

Its HE operation parameter is 0x003ff4, so the expected total length is
7 which does not match the actual length = 10. This causes association
failing with "HE AP is missing HE Capability/operation."

According to P802.11ax_D4 Table9-94, HE operation is extensible, and
according to 802.11-2016 10.27.8, STA should discard the part beyond
the maximum length and parse the truncated element.

Allow HE operation element to be longer than expected to handle this
case and future extensions.

Fixes: e4d005b80dee ("mac80211: refactor extended element parsing")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Yen-lin Lai <yenlinlai@chromium.org>

---

 net/mac80211/mlme.c | 2 +-
 net/mac80211/util.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2e33a1263518..ce4e3855fec1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5071,7 +5071,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		he_oper_ie = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_OPERATION,
 						  ies->data, ies->len);
 		if (he_oper_ie &&
-		    he_oper_ie[1] == ieee80211_he_oper_size(&he_oper_ie[3]))
+		    he_oper_ie[1] >= ieee80211_he_oper_size(&he_oper_ie[3]))
 			he_oper = (void *)(he_oper_ie + 3);
 		else
 			he_oper = NULL;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f080fcf60e45..c0fa526a45b4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -968,7 +968,7 @@ static void ieee80211_parse_extension_element(u32 *crc,
 		break;
 	case WLAN_EID_EXT_HE_OPERATION:
 		if (len >= sizeof(*elems->he_operation) &&
-		    len == ieee80211_he_oper_size(data) - 1) {
+		    len >= ieee80211_he_oper_size(data) - 1) {
 			if (crc)
 				*crc = crc32_be(*crc, (void *)elem,
 						elem->datalen + 2);
-- 
2.30.0.617.g56c4b15f3c-goog

