Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6778B72659F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jun 2023 18:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbjFGQQk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jun 2023 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbjFGQQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jun 2023 12:16:37 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58EA199D
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jun 2023 09:16:35 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 500C860031;
        Wed,  7 Jun 2023 19:16:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KGX7fTADXSw0-pr1UYybQ;
        Wed, 07 Jun 2023 19:16:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686154594;
        bh=fnlyunCbB9cj/57wkDEeWYriIa21VhOlUzGg1mysQ7Y=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=h0M4h+cX0bidSyHBzqwLZMkqXKOrILm2veHWkN0/zMb6qCSKeXz/xDzgKwOmaLYZ/
         c6APFv+c8H1EQMNp1/Hb9sFalXTfNjdtaLECjvrgy6Q0ftKr+mDc9rHUrh/5FxLkXo
         19+ea8ihzRNshtyn2PE72twN8JIoDX0hGqR7A3J4=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Franky Lin <franky.lin@broadcom.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/3] wifi: brcmfmac: handle possible completion timeouts
Date:   Wed,  7 Jun 2023 19:16:09 +0300
Message-Id: <20230607161611.85106-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607161611.85106-1-dmantipov@yandex.ru>
References: <20230607161611.85106-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Handle possible 'wait_for_completion_timeout()' errors in
'brcmf_p2p_af_searching_channel()', ' brcmf_p2p_tx_action_frame()'
and 'brcmf_p2p_del_vif()', adjust related code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../broadcom/brcm80211/brcmfmac/p2p.c         | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index d4492d02e4ea..9e383e6cab21 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1173,8 +1173,10 @@ static s32 brcmf_p2p_af_searching_channel(struct brcmf_p2p_info *p2p)
 			  retry);
 		/* search peer on peer's listen channel */
 		schedule_work(&afx_hdl->afx_work);
-		wait_for_completion_timeout(&afx_hdl->act_frm_scan,
-					    P2P_AF_FRM_SCAN_MAX_WAIT);
+		if (!wait_for_completion_timeout(&afx_hdl->act_frm_scan,
+						 P2P_AF_FRM_SCAN_MAX_WAIT))
+			/* timed out */
+			afx_hdl->peer_chan = P2P_INVALID_CHANNEL;
 		if ((afx_hdl->peer_chan != P2P_INVALID_CHANNEL) ||
 		    (!test_bit(BRCMF_P2P_STATUS_FINDING_COMMON_CHANNEL,
 			       &p2p->status)))
@@ -1186,8 +1188,10 @@ static s32 brcmf_p2p_af_searching_channel(struct brcmf_p2p_info *p2p)
 			/* listen on my listen channel */
 			afx_hdl->is_listen = true;
 			schedule_work(&afx_hdl->afx_work);
-			wait_for_completion_timeout(&afx_hdl->act_frm_scan,
-						    P2P_AF_FRM_SCAN_MAX_WAIT);
+			if (!wait_for_completion_timeout
+			    (&afx_hdl->act_frm_scan, P2P_AF_FRM_SCAN_MAX_WAIT))
+				/* timed out */
+				afx_hdl->peer_chan = P2P_INVALID_CHANNEL;
 		}
 		if ((afx_hdl->peer_chan != P2P_INVALID_CHANNEL) ||
 		    (!test_bit(BRCMF_P2P_STATUS_FINDING_COMMON_CHANNEL,
@@ -1580,14 +1584,20 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
 		  (p2p->wait_for_offchan_complete) ?
 		   "off-channel" : "on-channel");
 
-	wait_for_completion_timeout(&p2p->send_af_done, P2P_AF_MAX_WAIT_TIME);
-
+	if (!wait_for_completion_timeout(&p2p->send_af_done,
+					 P2P_AF_MAX_WAIT_TIME)) {
+		err = -ETIMEDOUT;
+		goto clear;
+	}
 	if (test_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status)) {
-		brcmf_dbg(TRACE, "TX action frame operation is success\n");
+		err = 0;
+		brcmf_dbg(TRACE, "TX action frame operation has succeeded\n");
 	} else {
 		err = -EIO;
 		brcmf_dbg(TRACE, "TX action frame operation has failed\n");
 	}
+
+clear:
 	/* clear status bit for action tx */
 	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
 	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
@@ -2404,10 +2414,10 @@ int brcmf_p2p_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
 	brcmf_dbg(INFO, "P2P: GO_NEG_PHASE status cleared\n");
 
 	if (wait_for_disable)
-		wait_for_completion_timeout(&cfg->vif_disabled,
-					    BRCMF_P2P_DISABLE_TIMEOUT);
+		err = (wait_for_completion_timeout(&cfg->vif_disabled,
+						   BRCMF_P2P_DISABLE_TIMEOUT)
+		       ? 0 : -ETIMEDOUT);
 
-	err = 0;
 	if (iftype != NL80211_IFTYPE_P2P_DEVICE) {
 		brcmf_vif_clear_mgmt_ies(vif);
 		err = brcmf_p2p_release_p2p_if(vif);
-- 
2.40.1

