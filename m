Return-Path: <linux-wireless+bounces-10916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A394756D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 08:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02775283691
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 06:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414ED14BF86;
	Mon,  5 Aug 2024 06:39:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457914BF9B
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839991; cv=none; b=vFCnSrN8jIXpZjpUf4PM3hzWBOPvZ9uzKqJyraP40Yv3Wr73za67uAmrOt7unZQ/vh7DJy0VkO/jqZIQ75OexcU6Atrb3PMeE1jjZUjafFVXUwbGH8bI4tUJ/vEYrra45xofNchLcFqmUe3qzOW6NUs1+CKWtc3dM9ash09UpLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839991; c=relaxed/simple;
	bh=TRNV4ubhHsipr5Lxr2FdSIUdP/KKJtbCJAZmfctiF4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dv5R2yng4v775Hdzg0y/U7Lh4txESWQmsEWYR5ABTRbpukaLr6Fxr/AIvcS2Owmdrl+fhib/uRhoMmUjiqlSB4ORyW4ZoqRDifDSEACN28mawvuRYDl1/ysH1E7aEGtjQediuoixhnO0mIgoNBiWL8zC37EcvLblBl/FgigQpgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNI-00039D-Ri; Mon, 05 Aug 2024 08:39:20 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNH-004e48-Lv; Mon, 05 Aug 2024 08:39:19 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNH-000M8i-1u;
	Mon, 05 Aug 2024 08:39:19 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 05 Aug 2024 08:39:13 +0200
Subject: [PATCH v4 1/3] wifi: mwifiex: simplify WPA flags setting
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-mwifiex-wpa-psk-sha256-v4-1-e1eee80508e6@pengutronix.de>
References: <20240805-mwifiex-wpa-psk-sha256-v4-0-e1eee80508e6@pengutronix.de>
In-Reply-To: <20240805-mwifiex-wpa-psk-sha256-v4-0-e1eee80508e6@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722839959; l=2494;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=TRNV4ubhHsipr5Lxr2FdSIUdP/KKJtbCJAZmfctiF4Q=;
 b=GYFCkxAE6as6SqgEl/9NTLCApcbnGmffMLnyQBKtPWFTXqcotgzimMecxgDreERiaXmSi98vc
 aVQTtD02+0rCJ3eCtmpf5s5maXaMvxOKr4AQt0+WlOUdGMplp+BfPKR
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The WPA flags setting only depends on the wpa_versions bitfield and not
on the AKM suite, so move it out of the switch/case to simplify the code
a bit. Also set bss_config->protocol to zero explicitly. This is done
only to make the code clearer, bss_config has been zero alloced by the
caller, so should be zero already. No functional change intended.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Brian Norris <briannorris@chromium.org>
Link: https://lore.kernel.org/r/20240723-mwifiex-wpa-psk-sha256-v3-1-025168a91da1@pengutronix.de
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 29 +++++++-------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 073c665183b30..51fcae8726ed0 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -46,34 +46,21 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 
 	bss_config->key_mgmt_operation |= KEY_MGMT_ON_HOST;
 
+	bss_config->protocol = 0;
+	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_1)
+		bss_config->protocol |= PROTOCOL_WPA;
+	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
+		bss_config->protocol |= PROTOCOL_WPA2;
+
 	for (i = 0; i < params->crypto.n_akm_suites; i++) {
 		switch (params->crypto.akm_suites[i]) {
 		case WLAN_AKM_SUITE_8021X:
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_1) {
-				bss_config->protocol = PROTOCOL_WPA;
-				bss_config->key_mgmt = KEY_MGMT_EAP;
-			}
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_2) {
-				bss_config->protocol |= PROTOCOL_WPA2;
-				bss_config->key_mgmt = KEY_MGMT_EAP;
-			}
+			bss_config->key_mgmt = KEY_MGMT_EAP;
 			break;
 		case WLAN_AKM_SUITE_PSK:
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_1) {
-				bss_config->protocol = PROTOCOL_WPA;
-				bss_config->key_mgmt = KEY_MGMT_PSK;
-			}
-			if (params->crypto.wpa_versions &
-			    NL80211_WPA_VERSION_2) {
-				bss_config->protocol |= PROTOCOL_WPA2;
-				bss_config->key_mgmt = KEY_MGMT_PSK;
-			}
+			bss_config->key_mgmt = KEY_MGMT_PSK;
 			break;
 		case WLAN_AKM_SUITE_SAE:
-			bss_config->protocol = PROTOCOL_WPA2;
 			bss_config->key_mgmt = KEY_MGMT_SAE;
 			break;
 		default:

-- 
2.39.2


