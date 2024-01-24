Return-Path: <linux-wireless+bounces-2439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E283A59F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 10:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 398BDB23D2A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB8D17C66;
	Wed, 24 Jan 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="hrSEJ/FM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D2117C61
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088908; cv=none; b=WTZkXTBUhQb5Keug1uofkCvFMRoMNnyg1h4yte7ZZ+J+IMqOoOeG3Lf0idvxJVnghkNbTOWw1hVnLAO/3ZBh1jUK03YMLHKvCTubyPaUu2O/3Ph+ZA/CxxgivNAnTeotWHJlodYN4tGXyaYYpdBVzvgX/5XFaLlvbOih2NO+R3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088908; c=relaxed/simple;
	bh=3w+hThopr5uSPj5MyTyQ5i5842p8UB0cQuNz29k6bFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbmJwQcLNSbcDRDS9Prx25EF0k715GUoHd6cIPbNxGpkmrWOklA7zdwAfgMIVuxPSDA8VSpQXp8jAsypglnJkIX1WBI9Wm3lGGaFnAHYsxoH//RuqCzT69lpwT6P3m4ml2CNvHcus3WUV/JdTaysupVpxGwKDOWgocqAg6KMnwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=hrSEJ/FM; arc=none smtp.client-ip=178.154.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward201a.mail.yandex.net (Yandex) with ESMTPS id 1325965A0B
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 12:28:46 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:60a:0:640:350:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 4E1BF46DD6;
	Wed, 24 Jan 2024 12:28:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bSPeea8tBW20-Cqh5uxgC;
	Wed, 24 Jan 2024 12:28:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706088517; bh=cesAyBb0bW7huJsgM4N6GBgeG218teWj0mvUcQtX4Co=;
	h=In-Reply-To:Cc:References:To:Message-ID:Date:Subject:From;
	b=hrSEJ/FMIO7/+t3M36OTAicZV+XpT8PeqoPPHjX2JaS+8nZAowHndeuCc0VUUdUWN
	 vVes+458HoP2Y8FF3OOXsIVblr+61geRw2ljshFhatvUR+rFq4aVXw1eat71zhjfgS
	 +hmFX/pdpznN9enGDp3c5HMkJo5OQeJ1YyP5hHbw=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] [v4] wifi: brcmfmac: handle possible completion timeouts
Date: Wed, 24 Jan 2024 12:27:09 +0300
Message-ID: <20240124092738.186493-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <18d3a47bb20.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <18d3a47bb20.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle possible 'wait_for_completion_timeout()' errors in
'brcmf_p2p_af_searching_channel()' and 'brcmf_p2p_del_vif()',
fix spelling and add comments where appropriate. Compile
tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: unchanged since v3
v3: adjust per Arend's review
v2: rebase against wireless-next tree
---
 .../broadcom/brcm80211/brcmfmac/p2p.c         | 36 +++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 6e0c90f4718b..a346c5a6e602 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1151,6 +1151,7 @@ static s32 brcmf_p2p_af_searching_channel(struct brcmf_p2p_info *p2p)
 {
 	struct afx_hdl *afx_hdl = &p2p->afx_hdl;
 	struct brcmf_cfg80211_vif *pri_vif;
+	bool timeout = false;
 	s32 retry;
 
 	brcmf_dbg(TRACE, "Enter\n");
@@ -1173,8 +1174,10 @@ static s32 brcmf_p2p_af_searching_channel(struct brcmf_p2p_info *p2p)
 			  retry);
 		/* search peer on peer's listen channel */
 		schedule_work(&afx_hdl->afx_work);
-		wait_for_completion_timeout(&afx_hdl->act_frm_scan,
-					    P2P_AF_FRM_SCAN_MAX_WAIT);
+		timeout = !wait_for_completion_timeout
+			(&afx_hdl->act_frm_scan, P2P_AF_FRM_SCAN_MAX_WAIT);
+		if (timeout)
+			break;
 		if ((afx_hdl->peer_chan != P2P_INVALID_CHANNEL) ||
 		    (!test_bit(BRCMF_P2P_STATUS_FINDING_COMMON_CHANNEL,
 			       &p2p->status)))
@@ -1186,8 +1189,11 @@ static s32 brcmf_p2p_af_searching_channel(struct brcmf_p2p_info *p2p)
 			/* listen on my listen channel */
 			afx_hdl->is_listen = true;
 			schedule_work(&afx_hdl->afx_work);
-			wait_for_completion_timeout(&afx_hdl->act_frm_scan,
-						    P2P_AF_FRM_SCAN_MAX_WAIT);
+			timeout = !wait_for_completion_timeout
+				(&afx_hdl->act_frm_scan,
+				 P2P_AF_FRM_SCAN_MAX_WAIT);
+			if (timeout)
+				break;
 		}
 		if ((afx_hdl->peer_chan != P2P_INVALID_CHANNEL) ||
 		    (!test_bit(BRCMF_P2P_STATUS_FINDING_COMMON_CHANNEL,
@@ -1209,7 +1215,7 @@ static s32 brcmf_p2p_af_searching_channel(struct brcmf_p2p_info *p2p)
 
 	clear_bit(BRCMF_P2P_STATUS_FINDING_COMMON_CHANNEL, &p2p->status);
 
-	return afx_hdl->peer_chan;
+	return timeout ? P2P_INVALID_CHANNEL : afx_hdl->peer_chan;
 }
 
 
@@ -1580,10 +1586,11 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
 		  (p2p->wait_for_offchan_complete) ?
 		   "off-channel" : "on-channel");
 
+	/* timeout would cause the code to proceed in the else branch below */
 	wait_for_completion_timeout(&p2p->send_af_done, P2P_AF_MAX_WAIT_TIME);
 
 	if (test_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status)) {
-		brcmf_dbg(TRACE, "TX action frame operation is success\n");
+		brcmf_dbg(TRACE, "TX action frame operation has succeeded\n");
 	} else {
 		err = -EIO;
 		brcmf_dbg(TRACE, "TX action frame operation has failed\n");
@@ -2371,7 +2378,7 @@ int brcmf_p2p_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
 	struct brcmf_cfg80211_vif *vif;
 	enum nl80211_iftype iftype;
 	bool wait_for_disable = false;
-	int err;
+	int err = 0;
 
 	brcmf_dbg(TRACE, "delete P2P vif\n");
 	vif = container_of(wdev, struct brcmf_cfg80211_vif, wdev);
@@ -2403,14 +2410,15 @@ int brcmf_p2p_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
 	clear_bit(BRCMF_P2P_STATUS_GO_NEG_PHASE, &p2p->status);
 	brcmf_dbg(INFO, "P2P: GO_NEG_PHASE status cleared\n");
 
-	if (wait_for_disable)
-		wait_for_completion_timeout(&cfg->vif_disabled,
-					    BRCMF_P2P_DISABLE_TIMEOUT);
-
-	err = 0;
 	if (iftype != NL80211_IFTYPE_P2P_DEVICE) {
-		brcmf_vif_clear_mgmt_ies(vif);
-		err = brcmf_p2p_release_p2p_if(vif);
+		if (wait_for_disable)
+			err = (wait_for_completion_timeout
+			       (&cfg->vif_disabled,
+				BRCMF_P2P_DISABLE_TIMEOUT) ? 0 : -ETIMEDOUT);
+		if (!err) {
+			brcmf_vif_clear_mgmt_ies(vif);
+			err = brcmf_p2p_release_p2p_if(vif);
+		}
 	}
 	if (!err) {
 		/* wait for firmware event */
-- 
2.43.0


