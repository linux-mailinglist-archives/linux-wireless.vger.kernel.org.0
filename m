Return-Path: <linux-wireless+bounces-10914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0DC947564
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 08:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F86C282596
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B7F149DE2;
	Mon,  5 Aug 2024 06:39:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C081E4B2
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839977; cv=none; b=ElezzkcD5gStRzrznS1OEzbZBydEWuQaCWMWYw8oFvrd+4NUNj/3+KrHj6YhOMufWH5nFKtCnl7cNHT7AE8FkWlZ/02lU0V1RtEh35TqzaffsI25pCf5oD0/ztl5d8c0APgYpzcmjevYuqsIwo/EoXXXR9yfO9Ve00vKzPhKl9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839977; c=relaxed/simple;
	bh=rDHqS/kVURL2gTGl82KO6UdTC3NaPTLnwlW/E1+VadU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bBZqeL76kaH4HqMRViXCL0R15LDbUufncgOZRzLgkhveqTJ76gzK+NvDWGyi7QpLhcBsWPUR5njCJhvdrzGMO9CoG3xVva5oB+3riuYD6QyouFtM/yZWWw1Vxk4obRnAms9O3M/m1utypaHl0pAaJEy4fDJwthrWfFwMLQq/afE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNI-00039F-Rh; Mon, 05 Aug 2024 08:39:20 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNH-004e4A-MS; Mon, 05 Aug 2024 08:39:19 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNH-000M8i-1w;
	Mon, 05 Aug 2024 08:39:19 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 05 Aug 2024 08:39:15 +0200
Subject: [PATCH v4 3/3] wifi: mwifiex: add support for WPA-PSK-SHA256
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-mwifiex-wpa-psk-sha256-v4-3-e1eee80508e6@pengutronix.de>
References: <20240805-mwifiex-wpa-psk-sha256-v4-0-e1eee80508e6@pengutronix.de>
In-Reply-To: <20240805-mwifiex-wpa-psk-sha256-v4-0-e1eee80508e6@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722839959; l=1911;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=rDHqS/kVURL2gTGl82KO6UdTC3NaPTLnwlW/E1+VadU=;
 b=WwHZbWKf8ooh/sB3mfP82ij81YNBAXRGXGjJIzMOkyWhpmpCJ6vSa4/Ppn7fXm/IfKe0IzQJp
 lvvG/fxjRo7CQvHOSf3Bj7JKsB/EncbCwrVBlO+xucpw+iBLy3QuczV
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
Acked-by: Brian Norris <briannorris@chromium.org>
Link: https://lore.kernel.org/r/20240723-mwifiex-wpa-psk-sha256-v3-3-025168a91da1@pengutronix.de
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/fw.h      | 1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 65799ae3bc723..e91def0afa14d 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -419,6 +419,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define KEY_MGMT_NONE               0x04
 #define KEY_MGMT_PSK                0x02
 #define KEY_MGMT_EAP                0x01
+#define KEY_MGMT_PSK_SHA256         0x100
 #define KEY_MGMT_SAE                0x400
 #define CIPHER_TKIP                 0x04
 #define CIPHER_AES_CCMP             0x08
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 7214b6cf304a9..1c0ceac6b27fb 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -61,6 +61,9 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 		case WLAN_AKM_SUITE_PSK:
 			bss_config->key_mgmt |= KEY_MGMT_PSK;
 			break;
+		case WLAN_AKM_SUITE_PSK_SHA256:
+			bss_config->key_mgmt |= KEY_MGMT_PSK_SHA256;
+			break;
 		case WLAN_AKM_SUITE_SAE:
 			bss_config->key_mgmt |= KEY_MGMT_SAE;
 			break;

-- 
2.39.2


