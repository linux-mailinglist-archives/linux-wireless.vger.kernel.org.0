Return-Path: <linux-wireless+bounces-10915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBBC947567
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 08:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDED5282F03
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 06:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADEF146A8A;
	Mon,  5 Aug 2024 06:39:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBBD146D79
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839983; cv=none; b=DkzTwdsZRSdTN+OOyev4PgXtG4CVo8pLTy4pK58ocWazpdu8ZFe7FgbhtYOT96tvn6KHDEv0L3JvU0NiNfbhumXkvIo/pAmpCo3IytEmO5aeGwWwZ2Soz8W13X23rw3tvzV+tjHibfluOfmjEn+NAdni6QKjX+YTmk0f2ZFDVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839983; c=relaxed/simple;
	bh=8xROGRY7f/VoLCybDt94w0BGHi2D02d5jGFRhfXMhlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GaBstLAKqMppVKV6oT+p0tIHzbc0By332cpr38cxrq7IobEhMnFvxp9p0nJnnYSWv+SDDRHFY91U6duJgqNY06Y8C8gnZDOV3cTTlgUsUHjL/SlEr8tGAPwyj6z/TSugRbVRa9xRGIJ6Meef9LRJBNOELAa2uHM2ttUq0Wa13PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNI-00039E-Rh; Mon, 05 Aug 2024 08:39:20 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNH-004e49-MI; Mon, 05 Aug 2024 08:39:19 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNH-000M8i-1v;
	Mon, 05 Aug 2024 08:39:19 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 05 Aug 2024 08:39:14 +0200
Subject: [PATCH v4 2/3] wifi: mwifiex: fix key_mgmt setting
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-mwifiex-wpa-psk-sha256-v4-2-e1eee80508e6@pengutronix.de>
References: <20240805-mwifiex-wpa-psk-sha256-v4-0-e1eee80508e6@pengutronix.de>
In-Reply-To: <20240805-mwifiex-wpa-psk-sha256-v4-0-e1eee80508e6@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722839959; l=2065;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=8xROGRY7f/VoLCybDt94w0BGHi2D02d5jGFRhfXMhlc=;
 b=zq+SceW6JZDRBXhBD9qPbbb6tzjLIwDMgrK/4dAyCjZdXynyKM68rV9lTAik7EsCaohtDrLg8
 kTK6pgENcazAXRfEKgcJUzixPafb26OIROxJx3uBPI8WBEk2Z6wOriO
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

bss_config->key_mgmt specifies the AKM suites that are usable in
hardware. This variable is set to specific values while iterating
over the advertised AKM suites. This means the final value of the
variable depends on the order of the entries in the AKM suites
array. Instead of setting the variable, just set the relevant bits
in the key_mgmt bit field to make us independent of the order of
entries.
This behaviour is derived from the downstream driver that does the
same.
Also, set bss_config->key_mgmt to zero explicitly right before the
loop. bss_config has been zero allocated by the caller already, but
do so again to save the reader from following the code path.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Brian Norris <briannorris@chromium.org>
Link: https://lore.kernel.org/r/20240723-mwifiex-wpa-psk-sha256-v3-2-025168a91da1@pengutronix.de
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 51fcae8726ed0..7214b6cf304a9 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -52,16 +52,17 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 	if (params->crypto.wpa_versions & NL80211_WPA_VERSION_2)
 		bss_config->protocol |= PROTOCOL_WPA2;
 
+	bss_config->key_mgmt = 0;
 	for (i = 0; i < params->crypto.n_akm_suites; i++) {
 		switch (params->crypto.akm_suites[i]) {
 		case WLAN_AKM_SUITE_8021X:
-			bss_config->key_mgmt = KEY_MGMT_EAP;
+			bss_config->key_mgmt |= KEY_MGMT_EAP;
 			break;
 		case WLAN_AKM_SUITE_PSK:
-			bss_config->key_mgmt = KEY_MGMT_PSK;
+			bss_config->key_mgmt |= KEY_MGMT_PSK;
 			break;
 		case WLAN_AKM_SUITE_SAE:
-			bss_config->key_mgmt = KEY_MGMT_SAE;
+			bss_config->key_mgmt |= KEY_MGMT_SAE;
 			break;
 		default:
 			break;

-- 
2.39.2


