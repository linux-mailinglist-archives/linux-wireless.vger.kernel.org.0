Return-Path: <linux-wireless+bounces-10255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930FB9325B4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 13:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46870280E04
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 11:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CD199E92;
	Tue, 16 Jul 2024 11:33:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C41799D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129622; cv=none; b=S3Q5gYioQ+X2fap15L6egRByGKKJtEiEfhzX57GNgeMsOOZg9duw9wbITAWfVcy7rS6pPbU6XhJE6vP0ajeCss4g6Jb1E5/eHPUKp2o8L6EC+DpH3acTtSPCeXyr3OAmlx7gB2ZPpCQ55e5h1fVbiqCH3srIaa0U30y8hOfegxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129622; c=relaxed/simple;
	bh=C0WwSkyU3QLjg0yOS+o7rIT7F22bvDaCzSStjCmIWTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZXOVNKSsGxwJ2821bGDXTcfcGWDeFc9cC+hsOI6CxizH6QO1bURslnvfBKXyIuWnKeoNXvsFFeLmuQlwfSDP6LkpBFyif+FIWdxtjFcJGK4ePi6SCBCswTlklx7/lzsiFNc0hZ+ehEdAVxuipr8qq47xe42rt0KYBYLXt5+atc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sTgQz-0007kR-8v; Tue, 16 Jul 2024 13:33:29 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sTgQy-0007L1-OG; Tue, 16 Jul 2024 13:33:28 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sTgQy-009ho5-29;
	Tue, 16 Jul 2024 13:33:28 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 16 Jul 2024 13:33:28 +0200
Subject: [PATCH 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-mwifiex-wpa-psk-sha256-v1-2-05ae70f37bb3@pengutronix.de>
References: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
In-Reply-To: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721129608; l=1544;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=C0WwSkyU3QLjg0yOS+o7rIT7F22bvDaCzSStjCmIWTI=;
 b=o+eHnx52f+SIRT7a0zcQxWtmFnlwt4ZUzrtlEjBfaaloXLaVJTeAHuAt09IghvR+jZcr4HQ9+
 sjqn0XHh4WUB7nJYhCqDHMBi1l9ZL9YhybYTFuVcSuiPSqPI5A7xHgN
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

This adds support for the WPA-PSK AKM suite with SHA256 as hashing
method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
using key_mgmt=WPA-PSK-SHA256.

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
index 8d0cd84d27698..c07aec67aa0fe 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -59,6 +59,9 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 		case WLAN_AKM_SUITE_PSK:
 			bss_config->key_mgmt = KEY_MGMT_PSK;
 			break;
+		case WLAN_AKM_SUITE_PSK_SHA256:
+			bss_config->key_mgmt = KEY_MGMT_PSK_SHA256;
+			break;
 		default:
 			break;
 		}

-- 
2.39.2


