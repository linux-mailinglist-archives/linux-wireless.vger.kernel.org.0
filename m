Return-Path: <linux-wireless+bounces-5875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E08898A9A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 17:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546E31C29CA7
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5712AAEF;
	Thu,  4 Apr 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="fJvajIHc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5612AAF0
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242908; cv=pass; b=SBNOTdvTJzXzVrmTWYEJYUBZ9BhCSyNeBUO+fMfgVv5btGyjr54F5yABcV4DxoQXhNlCzQo++D6PL++qs/GQBIWMPDrWSAsgBIY3ahXPN0G6qSAJUgMMScI2gDtniJn8fNKtgI/gWqDBdkKmNn5Em+vVC3eujhZcbm6pl0MoHE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242908; c=relaxed/simple;
	bh=tj4TYIiKTOc1FBIFrjwXSAvF+vYn4GHISzbJrn8wkoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbtApHKjpQSITtWVYU1fNaySWFPLO/fjFwOh2w8yocKkKlmR7VFyH7xEbcfddukv+HcJArm/03IB/K+tYv6EJbf1i4XEaeLQYZPcPzAUdb9tPY/S9/DWUfqPo30egWJSwsMwCun66VPSAgRz7bLhdn7+1YvXqRHoWCh1I9AibyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=fJvajIHc; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1712242899; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LyeWqFYgRJEN0g9mZaSbVkGQpkE1g0OJ0NlVIOSg9sAwp5ee2cCnyCrFXObyNiMXr8Ovys4O9TLe+/y8CQWoPIbadPN3KvGtKNMkVwpq4L/U4xfmpGI+bE/Gmte3PDVIL0YTOVxwBb9jNh+GFD8ML1oBDVUSxCqkoSa0FGGJwG4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1712242899; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=L8+Rw0lsBwXyorvBCYYaQx3uvulAB25rY+XY1LOB9pk=; 
	b=OgcWFlU8Q20KhvkM9CpDei4AawWbh2kOIDAJoQ9cphzrS/9pXkKZERrwskaZdcj0YPkU7vEnsa/hsGej0bfHJccwrlB/vVe7n1KiYsqc6eCQWwtU0OHGN8z21SWk1/Au47cNsDSV4o8NRvFB+8W1lbhe2NidFsb6QreEPJLK87k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1712242899;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=L8+Rw0lsBwXyorvBCYYaQx3uvulAB25rY+XY1LOB9pk=;
	b=fJvajIHcVHgo7xSrHUfalAsN7QIgzpMqdGKls48jMGg5B1SXN1v4RwqU42lMignp
	OygvAO3JwCeQUOBCuSLCgab+8XKeSspLycEVRB4XaqhP+axPXCSx9AsfuvlnqcyRNCH
	xftktzkUo9+q0w/ZOqDQLoRpVcUlWDGRLuG5Ef7I=
Received: by mx.zohomail.com with SMTPS id 1712242897862494.86385693026614;
	Thu, 4 Apr 2024 08:01:37 -0700 (PDT)
From: Chien Wong <m@xv97.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath9k_htc: drop too long USB messages
Date: Thu,  4 Apr 2024 23:01:10 +0800
Message-ID: <20240404150110.13816-1-m@xv97.com>
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

We should try our best not to crash the firmware. Note that setting the
MTU limit may not work: monitor interfaces will ignore the limit.
So we just drop too long messages and give warning on such events.

How to reproduce a crash:
1. Insert a supported Wi-Fi card
2. Associate to an AP
3. Increase MTU of interface: # ip link set wlan0 mtu 2000
4. Generate some big packets: $ ping <gateway> -s 1550
5. The firmware should crash. If not, repeat step 4.

Tested on TP-LINK TL-WN722N v1(AR9271) and TL-WN821N v3(AR7010+AR9287).

Signed-off-by: Chien Wong <m@xv97.com>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 12 ++++++++++++
 drivers/net/wireless/ath/ath9k/hif_usb.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 0c7841f95228..caee35d59ba7 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -103,6 +103,11 @@ static int hif_usb_send_regout(struct hif_device_usb *hif_dev,
 	struct cmd_buf *cmd;
 	int ret = 0;
 
+	if (skb->len > MAX_USB_REG_OUT_PIPE_MSG_SIZE) {
+		dev_err(&hif_dev->udev->dev, "ath9k_htc: Too long regout msg\n");
+		return -EMSGSIZE;
+	}
+
 	urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (urb == NULL)
 		return -ENOMEM;
@@ -381,6 +386,13 @@ static int hif_usb_send_tx(struct hif_device_usb *hif_dev, struct sk_buff *skb)
 
 	spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
 
+	if (skb->len > MAX_USB_WLAN_TX_PIPE_MSG_SIZE) {
+		spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
+		dev_warn_ratelimited(&hif_dev->udev->dev,
+				     "ath9k_htc: Too long TX packet(len=%u)\n", skb->len);
+		return -EMSGSIZE;
+	}
+
 	if (hif_dev->tx.flags & HIF_USB_TX_STOP) {
 		spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
 		return -ENODEV;
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
-- 
2.44.0


