Return-Path: <linux-wireless+bounces-5912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E9889A039
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 16:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486B71C231A6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C88B16F82A;
	Fri,  5 Apr 2024 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="Ae1monSs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067616F825
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328747; cv=pass; b=d212EQQ1sWYokDAhXVXpERDn5K5gOPpVawP4dyxk+qJG6LltTOlC0Hctiawt04VSBIdc9FlLtUxogwhUkVOgcykIMy47aihYaYFQfpbpqvbMiZIAEbR9Fg2RV6eT7wYZunW8dVo88sS3BSC62gsPfHUWJcVeqqreDQhBS8ZhZ3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328747; c=relaxed/simple;
	bh=/mMP4oZOStxgvFXgl9Ijz5yUss9I0L8re95SxYOp8vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S36JBAPqS8zldEciQh4hW74w/9P7vmO4Afpwj43/xVNfu3QzlzoTjhwcBZVpnC7TVf0TXm5I3gmrNIDKBKhj3vQcCw/vbGjuO/I4YWa+0bj9uPDuOrOypdHi5fa0+oaj70Yg8uT/61jb7+hWsGJfW4K7XxolSyLEOkCSNTylANk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=Ae1monSs; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1712328741; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ir+ERVEXvHJxbKK7OzojT4TL3opVpy91yybDhfcRTvRtHUb4ay8lY9Vzyt5AAf9EzicXRnRkbdWtrO6XnSksfWa0zGYmbbuASiIN7oMqMcfcsTwckA7CsaV5zB/rpgZKdULRGKNa4eui/zRmtx6spdJ9lZPJN6RsFuQW5Coq3M0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1712328741; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JxyZ4Ypwr8wq7/mymPwJVkdDsjC9kwDZyPQ5wromgGk=; 
	b=RD2fu9G0Z3DuPxn46E3MXDTubll3losx7QwsFzDCl6QAByQf0j73YLzjft5/QbO6TgiTSfmS1b3JncnpDqph+wdHEW07bc9I/7dnCuTO1uu/0320p8fkQkREnvYMbT5TnZlWE5lIwwOXXhaKB+IFPzlDwMMtdgyD/PiFUPmKAPk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1712328741;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JxyZ4Ypwr8wq7/mymPwJVkdDsjC9kwDZyPQ5wromgGk=;
	b=Ae1monSsrFfA8xnn1FSypz45/XjSPzUyIgBzFSXFHV8NvjZUUSsl60HIu5AuSbke
	algjHf6EHzNk9ubhLF9kTbT0EV2sdtdmnE15dCKgX/QKWeSks5ZSTJoXqd/Qr2WqejB
	C6I/AeSl08geNZJAcSMssCp4m5khCz0x+lHKGao8=
Received: by mx.zohomail.com with SMTPS id 171232874006858.24631876384751;
	Fri, 5 Apr 2024 07:52:20 -0700 (PDT)
From: Chien Wong <m@xv97.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath9k_htc: limit MTU
Date: Fri,  5 Apr 2024 22:52:11 +0800
Message-ID: <20240405145211.15185-1-m@xv97.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Currently, the length of USB messages sent from host to Wi-Fi dongle is
not checked. Without the check, we could crash the firmware.

The length limits are determined by _HIFusb_get_max_msg_len_patch()
in the firmware code, located in k2_HIF_usb_patch.c and HIF_usb_patch.c
of the open-ath9k-htc-firmware project. The limits are 512 and 1600
bytes for regout and Wi-Fi TX messages respectively.
I'm not sure if the firmware crash is due to buffer overflow if RXing
too long USB messages but the length limit is clear and verified.
Somebody knowing hardware internals could help.

We should try our best not to crash the firmware. Setting the MTU limit
will help prevent some too long packets from being generated. However,
doing this alone is not enough: monitor interfaces will ignore the
limit so other measure should also be taken.

It's not easy to choose an optimal limit. The numbers that come to mind
include (1)1500, (2)1600 - sizeof overhead of shortest possible frame
and so on. For (1), it's too limiting: the device supports longer
frames. For (2), it won't filter frames with longer overhead.
Why bother considering higher layer protocols? We could just consider
the driver layer overhead.

How to reproduce a crash:
1. Insert a supported Wi-Fi card
2. Associate to an AP
3. Increase MTU of interface: # ip link set wlan0 mtu 2000
4. Generate some big packets: $ ping <gateway> -s 1600
5. The firmware should crash. If not, repeat step 4.

Tested-on: TP-LINK TL-WN722N v1(AR9271)
Tested-on: TP-LINK TL-WN821N v3(AR7010+AR9287).

Signed-off-by: Chien Wong <m@xv97.com>
---
 drivers/net/wireless/ath/ath9k/hif_usb.h      | 3 +++
 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.h b/drivers/net/wireless/ath/ath9k/hif_usb.h
index b3e66b0485a5..f8fd78309829 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.h
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.h
@@ -50,6 +50,9 @@ extern int htc_use_dev_fw;
 #define ATH_USB_RX_STREAM_MODE_TAG 0x4e00
 #define ATH_USB_TX_STREAM_MODE_TAG 0x697e
 
+#define MAX_USB_REG_OUT_PIPE_MSG_SIZE 512
+#define MAX_USB_WLAN_TX_PIPE_MSG_SIZE 1600
+
 /* FIXME: Verify these numbers (with Windows) */
 #define MAX_TX_URB_NUM  8
 #define MAX_TX_BUF_NUM  256
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index 3633f9eb2c55..3fad9cd4b1e6 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -760,6 +760,9 @@ static void ath9k_set_hw_capab(struct ath9k_htc_priv *priv,
 	hw->extra_tx_headroom = sizeof(struct tx_frame_hdr) +
 		sizeof(struct htc_frame_hdr) + 4;
 
+	hw->max_mtu = MAX_USB_WLAN_TX_PIPE_MSG_SIZE - sizeof(struct tx_frame_hdr)
+		- sizeof(struct htc_frame_hdr);
+
 	if (priv->ah->caps.hw_caps & ATH9K_HW_CAP_2GHZ)
 		hw->wiphy->bands[NL80211_BAND_2GHZ] =
 			&common->sbands[NL80211_BAND_2GHZ];
-- 
2.44.0


