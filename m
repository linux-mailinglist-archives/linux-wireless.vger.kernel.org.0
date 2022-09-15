Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401C35BA1A0
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 21:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIOTz7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 15:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIOTz6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 15:55:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CF095AF2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 12:55:57 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q63so18277750pga.9
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=lFuiqa17cv+dNWmv2faygQb4Aq1P8GzwkTxOnXcWXV8=;
        b=Fbkn+c4Y7O4us9RyFsDr2IcPkKzHEezQ+K+9DyEhJ6WnvRWmeHr2md1hccIfqiAuIE
         XbqfVUCxVAz75Q/H9WjJSLebHdI1ZC3lR/v8L1SsJx+Dm6f6CPLLi2wVhoBYQ+4wpQq9
         0U6pFN0uDt0Vu3/EzFfsJPMAB9ZzycFUvEgHly5FPoMEkSpgu5QD0DEtaiK7armDnhuF
         wy58cQBkWt7EQKn1l8U+k6vpwuwgYChu/MKza86bqbLHsS3hAKBYNtq7+p4kPpAj+uU7
         0UlV2xGnkDBXYU12jDahU0O9rsGV62O2r0QU5XiqhYS9mAZNoiNn195ZyNx+FUwx+6vJ
         6FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=lFuiqa17cv+dNWmv2faygQb4Aq1P8GzwkTxOnXcWXV8=;
        b=rtkH5aVcPrT2fw9NG9+G20kX91ZjXWTbw/gV1+zS+yjQx+i9XaGrIkMFYtP7h6MMGj
         gz/7yAUmHxlMj3Za8tqr1URJdCYhl9TTsNls32b6kn5thUSE9w5Rvg/hj2m9O+oyQ1rT
         KLtlLMWgay8m2cBlkEtbhqCsfvwvkbgseC2Xp4QVa5tMgyKlXkXoNrVHEN2gKAbLEz6p
         lIM4wvTuvhfWTHsH4fSpXgbRpof6yY0lzPTx3YIgMwtv1haXZeKsRy+7yfEeMIqsNlRI
         aNR8o9e+eldo2OBlLSCUXH1RQ8RpQBWEPianEJYroKFXIZfV1qjNc6BQr0ZYIav+5ca3
         LONw==
X-Gm-Message-State: ACrzQf1VzWjATzm1OVOrqj541NYAJxvhH4gtoUpdtHptv3Li7VGNg0U3
        1LYya3pKoEcIDD+crhHopu6mIdf0a20=
X-Google-Smtp-Source: AMsMyM5/oYB+zZ2qmQCS5mP0ND99dhpTCshJOzjy+mtJXTUUuzqDfQLYmwO/mnHyMBxu7bM0DowQlA==
X-Received: by 2002:a05:6a00:c86:b0:542:7c38:4a59 with SMTP id a6-20020a056a000c8600b005427c384a59mr1695681pfv.74.1663271756612;
        Thu, 15 Sep 2022 12:55:56 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id h184-20020a6283c1000000b0053e80515df8sm12831090pfe.202.2022.09.15.12.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 12:55:56 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] net: mac80211: remove/avoid misleading prints
Date:   Thu, 15 Sep 2022 12:55:53 -0700
Message-Id: <20220915195553.1052931-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

At some point a few kernel debug prints started appearing which
indicated something was sending invalid IEs:

"bad VHT capabilities, disabling VHT"
"Invalid HE elem, Disable HE"

Turns out these were being printed because the local hardware
supported HE/VHT but the peer/AP did not. Bad/invalid indicates,
to me at least, that the IE is in some way malformed, not missing.

For the HE print (ieee80211_verify_peer_he_mcs_support) it will
now silently fail if the HE capability element is missing (still
prints if the element size is wrong).

For the VHT print, it has been removed completely and will silently
set the DISABLE_VHT flag which is consistent with how DISABLE_HT
is set.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 net/mac80211/mlme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ff449e0c2e62..97cd70b8784b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4410,8 +4410,11 @@ ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
 					     ies->data, ies->len);
 
+	if (!he_cap_elem)
+		return false;
+
 	/* invalid HE IE */
-	if (!he_cap_elem || he_cap_elem->datalen < 1 + sizeof(*he_cap)) {
+	if (he_cap_elem->datalen < 1 + sizeof(*he_cap)) {
 		sdata_info(sdata,
 			   "Invalid HE elem, Disable HE\n");
 		return false;
@@ -4677,8 +4680,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (!elems->vht_cap_elem) {
-			sdata_info(sdata,
-				   "bad VHT capabilities, disabling VHT\n");
 			*conn_flags |= IEEE80211_CONN_DISABLE_VHT;
 			vht_oper = NULL;
 		}
-- 
2.34.3

