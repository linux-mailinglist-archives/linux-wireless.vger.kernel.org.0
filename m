Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA772F720
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbjFNH7J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 03:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjFNH7E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 03:59:04 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F44D10E6
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 00:59:03 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2d23:0:640:2dd6:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 4BB516003B;
        Wed, 14 Jun 2023 10:59:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id owVk0cNWxSw0-1VSHv1yR;
        Wed, 14 Jun 2023 10:59:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686729540;
        bh=+WR/c4jPrbplUAvIWrC+3q2lfmmDjDlJYI7FptCT3B8=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=rNVuiAMg9H25S1G/7l3kXoQX7bMQJYXbaDRXv/1xjhqCdgWJuB75w9sxRmKoXVR+5
         r2UKKeLC8cEGjfihSnxJhDJbE5/P4UDycwdlol7l4yll5FqZseCWgS2N/vIsVGX2XK
         QI0szW7za+auaTxtdzcxB54vrz1EGB4M0PbNCyzo=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] [v2] wifi: brcmfmac: handle possible completion timeouts
Date:   Wed, 14 Jun 2023 10:58:47 +0300
Message-Id: <20230614075848.80536-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Handle possible 'wait_for_completion_timeout()' errors in
'brcmf_p2p_af_searching_channel()', 'brcmf_p2p_tx_action_frame()'
and 'brcmf_p2p_del_vif()', adjust related code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: rebase against wireless-next tree
---
 .../broadcom/brcm80211/brcmfmac/p2p.c         | 31 +++++++++++++------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index d4492d02e4ea..e43dabdaeb0b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1151,6 +1151,7 @@ static s32 brcmf_p2p_af_searching_channel(struct brcmf_p2p_info *p2p)
 {
 	struct afx_hdl *afx_hdl = &p2p->afx_hdl;
 	struct brcmf_cfg80211_vif *pri_vif;
+	bool timeout = false;
 	s32 retry;
 
 	brcmf_dbg(TRACE, "Enter\n");
@@ -1173,8 +1174,11 @@ static s32 brcmf_p2p_af_searching_channel(struct brcmf_p2p_info *p2p)
 			  retry);
 		/* search peer on peer's listen channel */
 		schedule_work(&afx_hdl->afx_work);
-		wait_for_completion_timeout(&afx_hdl->act_frm_scan,
-					    P2P_AF_FRM_SCAN_MAX_WAIT);
+		if (!wait_for_completion_timeout(&afx_hdl->act_frm_scan,
+						 P2P_AF_FRM_SCAN_MAX_WAIT)) {
+			timeout = true;
+			break;
+		}
 		if ((afx_hdl->peer_chan != P2P_INVALID_CHANNEL) ||
 		    (!test_bit(BRCMF_P2P_STATUS_FINDING_COMMON_CHANNEL,
 			       &p2p->status)))
@@ -1186,8 +1190,11 @@ static s32 brcmf_p2p_af_searching_channel(struct brcmf_p2p_info *p2p)
 			/* listen on my listen channel */
 			afx_hdl->is_listen = true;
 			schedule_work(&afx_hdl->afx_work);
-			wait_for_completion_timeout(&afx_hdl->act_frm_scan,
-						    P2P_AF_FRM_SCAN_MAX_WAIT);
+			if (!wait_for_completion_timeout
+			    (&afx_hdl->act_frm_scan, P2P_AF_FRM_SCAN_MAX_WAIT)) {
+				timeout = true;
+				break;
+			}
 		}
 		if ((afx_hdl->peer_chan != P2P_INVALID_CHANNEL) ||
 		    (!test_bit(BRCMF_P2P_STATUS_FINDING_COMMON_CHANNEL,
@@ -1209,7 +1216,7 @@ static s32 brcmf_p2p_af_searching_channel(struct brcmf_p2p_info *p2p)
 
 	clear_bit(BRCMF_P2P_STATUS_FINDING_COMMON_CHANNEL, &p2p->status);
 
-	return afx_hdl->peer_chan;
+	return timeout ? P2P_INVALID_CHANNEL : afx_hdl->peer_chan;
 }
 
 
@@ -1580,14 +1587,18 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
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
 		brcmf_dbg(TRACE, "TX action frame operation is success\n");
 	} else {
 		err = -EIO;
 		brcmf_dbg(TRACE, "TX action frame operation has failed\n");
 	}
+clear:
 	/* clear status bit for action tx */
 	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
 	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
@@ -2404,10 +2415,10 @@ int brcmf_p2p_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
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

