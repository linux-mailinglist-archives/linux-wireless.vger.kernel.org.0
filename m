Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE664191D0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhI0Jw6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 05:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbhI0Jw5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 05:52:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FA2C061575
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=lBDJhU5KTD6ZxBTw9xcA1esWLOPyh87yizlBWAgfm9I=; t=1632736277; x=1633945877; 
        b=q2RdtT2vpSjnAfKZICJtwWEH4z9v41wDuenXbH4KhVHqB6jHiTd6O+NVOqfIuSHnmUhwFJp6NEg
        5tNZnIjTqjUo0s5gXR6uxcZwrdro9ThcGFFXTv22Pjm9PPMihati1oNnhu/tGatq+fwYN02g1tqyE
        JdIhEgfDvgMkTbyenNynrzugl7YJa7iFIC6lOhsPmPOFvrUHjZdv9yW5cTA73Ob7NNDfO/Snk/FwY
        lsw1+Jd8fntuPsy+UTqfjrq4khEGZccyUpM0WJ1N81hW76k3S9rgLcxwAC8uYb3ScGLy6ciTUoPU3
        LiBQ53DukVqxy/DcZL8A60ZFGArtzlWsJAqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mUnI3-00CMvc-56;
        Mon, 27 Sep 2021 11:51:15 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] mac80211: twt: don't use potentially unaligned pointer
Date:   Mon, 27 Sep 2021 11:51:13 +0200
Message-Id: <20210927115112.b6d9b3172285.Ie3de9bcc5dde5a79e3ac81f3185beafe4d214e57@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since we're pointing into a frame, the pointer to the
twt_agrt->req_type struct member is potentially not
aligned properly. Open-code le16p_replace_bits() to
avoid passing an unaligned pointer.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: f5a4c24e689f ("mac80211: introduce individual TWT support in AP mode")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/s1g.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index 7e35ab5b6166..01140dd42a8b 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -104,9 +104,10 @@ ieee80211_s1g_rx_twt_setup(struct ieee80211_sub_if_data *sdata,
 
 	/* broadcast TWT not supported yet */
 	if (twt->control & IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST) {
-		le16p_replace_bits(&twt_agrt->req_type,
-				   TWT_SETUP_CMD_REJECT,
-				   IEEE80211_TWT_REQTYPE_SETUP_CMD);
+		twt_agrt->req_type &=
+			~cpu_to_le16(IEEE80211_TWT_REQTYPE_SETUP_CMD);
+		twt_agrt |= le16_encode_bits(TWT_SETUP_CMD_REJECT,
+					     IEEE80211_TWT_REQTYPE_SETUP_CMD);
 		goto out;
 	}
 
-- 
2.31.1

