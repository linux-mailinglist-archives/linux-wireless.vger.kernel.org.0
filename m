Return-Path: <linux-wireless+bounces-10287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC279338FA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 10:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF6B284173
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AEA364CD;
	Wed, 17 Jul 2024 08:30:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BCD23A8
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205027; cv=none; b=je/D9E9n470rlY/LJD6WtZbH/dxeGpbSilPtAkUIr6Q9DRFy2Rag0xj/UXLFMpm5ZOv1ccyWqUHgE8Hixv8ykglBa319KyrSuV4CTXG9MU7dCQv8SzOZvxu49hjrAhSfP5V/YRPyXerwIFj/n0n0ivbRbIv9H7eFEKzNGpw9hzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205027; c=relaxed/simple;
	bh=cElIZGVQuEc4yCgQqjOZfJfFWWUg+mqNSGvPESxG9Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=js+kaz28L1ce0sk4EOHCZdoRPitochsFa9myETXkau77J1FUb/6edj1BhUYhMtEmoL0F5fKF/CsS5WMtGwDUv3fRHRV3aDXqvbjHY1V6PIvVnpmBvo2Dir0OUP9d9reaOh5b9l/+/uE/d7h715OslpYRsOWVzLsb4NCnnCFR3uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sU03I-00030f-MB; Wed, 17 Jul 2024 10:30:20 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sU03I-000AeA-6K; Wed, 17 Jul 2024 10:30:20 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sU03I-00COor-0O;
	Wed, 17 Jul 2024 10:30:20 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 17 Jul 2024 10:30:07 +0200
Subject: [PATCH v2 1/2] wifi: mwifiex: simplify WPA flags setting
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-mwifiex-wpa-psk-sha256-v2-1-eb53d5082b62@pengutronix.de>
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
In-Reply-To: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721205020; l=2167;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=cElIZGVQuEc4yCgQqjOZfJfFWWUg+mqNSGvPESxG9Z8=;
 b=SziT5GSTAZFkfcTXiv8zcqG/dwefa8qYromrrTwLFVEdnZrAfhurElCxVqZereJcBVTple21S
 ld4Xd/sdafWAXNv43468dALw58unUkYrHIrtTNMF3H2Eux4Mxvvyo0W
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

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 28 ++++++++------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 491e366119096..7f822660fd955 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -46,31 +46,19 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 
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
 		default:
 			break;

-- 
2.39.2


