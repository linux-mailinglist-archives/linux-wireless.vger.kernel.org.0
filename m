Return-Path: <linux-wireless+bounces-30918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F40FD37B20
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 19:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BD1230CE4EB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 17:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D68335067;
	Fri, 16 Jan 2026 17:59:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E342B339857
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768586344; cv=none; b=qQbaQHMiiTRldS0o4aw8lKrtthB1BNRTHPItvtAxm0JOGFuQkyPwao4uRWpDzkWCM19h5ta2XZJe02LSJH+KL2wddq/gGc2EXJcdkEQ2cVp6TTpkmqK6DPqFYOAqm2v1YdLWC4JSDVv2oTb649DdsjgpBU0vJsA7Diju4TlRRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768586344; c=relaxed/simple;
	bh=2IZpIlUseWZrRvz6V4f7L6jDt1QozbXiJns6Zkql7DQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=X8iFHXvogbfVwZoMVaFdSOYMFBBSZrWCkJHb/mFvVdJ6f/IeYtqYfg0AlyOx7IMq3ldEzYtWQnbwoaJ5gTsIKevKgMarto/N0MGvIe1KF5lUvunrRa4607yCg0X/e3VOEtrToLm/9nU31u6Lqk0YDc0VH6i3Qy/Zs8XIvKGfkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 3515F13038
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 18:59:00 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 2944412FCE; Fri, 16 Jan 2026 18:59:00 +0100 (CET)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (h-62-63-215-216.A163.priv.bahnhof.se [62.63.215.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 01FE513037
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 18:58:58 +0100 (CET)
Date: Fri, 16 Jan 2026 18:58:58 +0100 (CET)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: wlcore: Add support for IGTK key
Message-ID: <0d3df7ab-6c41-c3cc-83cc-5ba55fe4e4bd@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1763903163-1768586234=:338315"
Content-ID: <150ca212-99b0-4f90-5bbc-d21e8855eae3@lysator.liu.se>
X-Virus-Scanned: ClamAV using ClamSMTP

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1763903163-1768586234=:338315
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <fa4ac7de-0717-c7c3-64dc-f971791a5f8e@lysator.liu.se>


This change re-applies commit 2b7aadd3b9e1 ("wlcore: Adding suppoprt for IGTK key in
wlcore driver") (sic), but only enables WLAN_CIPHER_SUITE_AES_CMAC with modern
firmware. This patch is required to support WPA3 connections.

Signed-off-by: Peter Åstrand <astrand@lysator.liu.se>
---
 drivers/net/wireless/ti/wlcore/cmd.h  | 1 +
 drivers/net/wireless/ti/wlcore/main.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
index d16afb35f9ee..f8160f372bc7 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.h
+++ b/drivers/net/wireless/ti/wlcore/cmd.h
@@ -455,6 +455,7 @@ enum wl1271_cmd_key_type {
 	KEY_TKIP = 2,
 	KEY_AES  = 3,
 	KEY_GEM  = 4,
+	KEY_IGTK = 5,
 };
 
 struct wl1271_cmd_set_keys {
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 12f0167d7380..dce79bce2e3f 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -2419,6 +2419,11 @@ static int wl12xx_init_fw(struct wl1271 *wl)
 	strscpy(wiphy->fw_version, wl->chip.fw_ver_str,
 		sizeof(wiphy->fw_version));
 
+	/* WLAN_CIPHER_SUITE_AES_CMAC must be last in cipher_suites;
+	   support only with firmware 8.9.1 and newer */
+	if (wl->chip.fw_ver[FW_VER_MAJOR] < 1)
+		wl->hw->wiphy->n_cipher_suites--;
+
 	/*
 	 * Now we know if 11a is supported (info from the NVS), so disable
 	 * 11a channels if not supported
@@ -3585,6 +3590,9 @@ int wlcore_set_key(struct wl1271 *wl, enum set_key_cmd cmd,
 	case WL1271_CIPHER_SUITE_GEM:
 		key_type = KEY_GEM;
 		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		key_type = KEY_IGTK;
+		break;
 	default:
 		wl1271_error("Unknown key algo 0x%x", key_conf->cipher);
 
@@ -6196,6 +6204,7 @@ static int wl1271_init_ieee80211(struct wl1271 *wl)
 		WLAN_CIPHER_SUITE_TKIP,
 		WLAN_CIPHER_SUITE_CCMP,
 		WL1271_CIPHER_SUITE_GEM,
+		WLAN_CIPHER_SUITE_AES_CMAC,
 	};
 
 	/* The tx descriptor buffer */
-- 
2.30.2


Br,
Peter Åstrand
--8323329-1763903163-1768586234=:338315--

