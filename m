Return-Path: <linux-wireless+bounces-10444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3382939B7B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 09:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F9D1F228DD
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 07:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE1714B94F;
	Tue, 23 Jul 2024 07:10:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682114A635
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718615; cv=none; b=a2SeEMg+Y8ZABt03FCXLGCiXl9TyQQCAiTDsGacgO9kwWC+rOu5NdnmLZlANaQ1WjmL7Nz0UkcGOBtxXnFaq1S0e5nYGSSXzNKcHoTN3Dc4slm+VPitFZjnn0RbGS0qa3CsF+l6eSjRppP0sR/tI4JsWa6atGwnFI2guQj6SLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718615; c=relaxed/simple;
	bh=pnxVQ5yr/CRNk0Q3YV7hR7PaOobue4/QloO+PAOzCtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZxIKDmCN/urnZP9i56aSYsuS0wrVThR4Mw6BNOxc4imMI72DaMjYIxrWGgCxOBasUxoRX4R7TKo99KIjYhBmdScwMAGT7sVSqSgbPx0HlstYmMublmGC0rlY0IQN2c5ZA2tjtzYBNO5sR7MKk7Vnklu9r+O5HpeLjuG/sU/gGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9ev-0007O9-Fu; Tue, 23 Jul 2024 09:10:05 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9et-001ZAZ-Kj; Tue, 23 Jul 2024 09:10:03 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sW9et-00FQKO-1k;
	Tue, 23 Jul 2024 09:10:03 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 23 Jul 2024 09:09:59 +0200
Subject: [PATCH v3 3/3] wifi: mwifiex: add support for WPA-PSK-SHA256
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-mwifiex-wpa-psk-sha256-v3-3-025168a91da1@pengutronix.de>
References: <20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de>
In-Reply-To: <20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721718603; l=1708;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=pnxVQ5yr/CRNk0Q3YV7hR7PaOobue4/QloO+PAOzCtY=;
 b=+s253rV1R1j2Y94P5EQGcxcd7m59W4yRcFQZQZ3kTcXVBtRqTKkC1PC4iAscBTIYoghcUv+Ai
 SsbhvbruHHnAIz2QEoWb2SaOkdvHZeAP5+m7FJJUHo1WQrkCUtdcD0O
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

This adds support for the WPA-PSK AKM suite with SHA256 as hashing
method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
using key_mgmt=WPA-PSK-SHA256.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://lore.kernel.org/r/20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/fw.h      | 1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 3adc447b715f6..1c76754b616ff 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -415,6 +415,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define KEY_MGMT_NONE               0x04
 #define KEY_MGMT_PSK                0x02
 #define KEY_MGMT_EAP                0x01
+#define KEY_MGMT_PSK_SHA256         0x100
 #define CIPHER_TKIP                 0x04
 #define CIPHER_AES_CCMP             0x08
 #define VALID_CIPHER_BITMAP         0x0c
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 57280eaae483c..3888c7a86876c 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -61,6 +61,9 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 		case WLAN_AKM_SUITE_PSK:
 			bss_config->key_mgmt |= KEY_MGMT_PSK;
 			break;
+		case WLAN_AKM_SUITE_PSK_SHA256:
+			bss_config->key_mgmt |= KEY_MGMT_PSK_SHA256;
+			break;
 		default:
 			break;
 		}

-- 
2.39.2


