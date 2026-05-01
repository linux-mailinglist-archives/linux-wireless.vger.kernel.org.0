Return-Path: <linux-wireless+bounces-35739-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPxTEv0Q9GnG+AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35739-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 04:33:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B511F4A9D1F
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 04:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C5A130312CC
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 02:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02CB223322;
	Fri,  1 May 2026 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaG9zg2E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D840DFBD
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777602807; cv=none; b=pDSgLmiMhyzUm42pKdz1Kl77TG4Iumu2Ym6bhYlyLA60vvu7CWIP/8N3B1Ir/Ppy0yiSXr4EP5zK0K/4GyGpYwzag/MCA/Tk8s5EDL1dGz+iQDVC/hc9qxYC0B7sa+oI6fVw4SH6LbNBL4MSTu58/C6oW7SYqwyGEFXHLKBklfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777602807; c=relaxed/simple;
	bh=koxT9l2Q7stkWkve529WX1LJg1y9Dp8zpLWcfwNwMRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3xamcfRp9L/qao3NDpSeg4vAm8ORFmgn0ieDWhnVE6Bh8+krefX/5Y2xZb6jEt+ovAZUbyilGLEHIPUA5GHMk2I+r1v3bodjpF3dY+xudPSnSsiNeg52VQj8e0VeLG01bYXG36Qd6/N6IsWbC35w1Rsjbzpiikp+3bqWqyOT7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaG9zg2E; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so1252938a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 19:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777602806; x=1778207606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AA9Hj3epCHWvGU5vN67rNW8TyCNNE/GKP+VRm6cQBrE=;
        b=PaG9zg2EZU60c3l/ejFL7bWj4J5VGVwQCaggBDgMmjXLP+Xs4uU4OzA8ONcA+xla8N
         5AqFb4de8fpbEMZAo786kJxlb/4LbZQ+TGVIorRJDSvF3OzAinAsjR7WX1TeB6cOX+0M
         a2JJtM9mHOfJtOWuV+RVX7aDpRxp43u3wOECvbxZRFRq+W9CZuFd60uWhZ+oX5YRqB+d
         eX2UBtD52v6kaILEhP7WMNag9oEjC+phPM0mEm+Gcfc+RcDnNSWASafeoQ21HdL9pc9e
         0Db1dIYaGnQUYphqoQ8e7v5ZDvlz7S2pxekFoRYTMG0c3gjaKfJwM+Qwh1tivZwOravT
         dsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777602806; x=1778207606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA9Hj3epCHWvGU5vN67rNW8TyCNNE/GKP+VRm6cQBrE=;
        b=BlHICqESKZqT3NSo/GM2Kmv4ixcu0KT8mqGHJkv8zu5diPBo0yShBdimDhuR6VUZbb
         3xkMOVuie8xPaYOYmcb2aFF+pA4S6VKzfOyOSKB1MR0T3/Htidyo+VkSb5f93EV8liTz
         f7h3UMAg6Ax7TVVJgJuUQJKJQRlCET2pCwFzGVmw6OmgNQWEcytKjCAHP/M4XwWYw1OH
         nGkS5QTrJdXX7BjOm8vB51tpM1IYVf5pPi2Ktqjsa3+0Yalx5/s1lo+kbrucLKqbOcA3
         5p8gPuCWnoSN/tZP9H55O27zsr4FOWxW634RQB9ecdFz1wPjNS4lnG8cW1PSm+MOFMLO
         WXiw==
X-Gm-Message-State: AOJu0YwHdCqLJYdCRPbHWK3lUMR98xmH02AilWOlmNYOTv/PzHu0JoNE
	vsz9kEkc9CVLEhDOhJ+NVMBc9fAtQXzKcdHAlZDvtw/du0it3kxkyoi0Ze8EkJUS
X-Gm-Gg: AeBDiescmOi9oUP5DhGLsBQfNb/YrIwtpLGjqw8C+G75MVnBonwRN6kDplMYW7mVcaH
	9FpgjBxGHPa6EA/sf6Z4otlzykAc3b7b5l84gFUzsDGMeTpZ0JzvhZqH/w+ujkratsNa/sh7nPi
	8ktMB85RjQ9EjYtpgtbt19Ob4Nz/Ij/5mjusj9r819tIZInjqEYhzGYeZmGIE7Xrpext7vvGBJi
	LzRyyZnvPbguaNPBOwdii0Y6vxko5+TyiVyQL553wGB6txgLA+kvxtJfHpwBXmdxNUzxuBrXsNb
	mrAiRkDy2uy3V+kgE5udikG73sDV7eJmfGEU85WD6ENWbd3lTDKlZ7d+uAWCwVsF/0KllPSG3I8
	Gu5QSUrRY2xWYYzWBpDpptybwJUCln/rLNrU4qALXfGEXc7v59geFSmWjDzJT0yQPH1yRsB1/KJ
	xWeuKRAyc+kpHFxbOnyx91JpKZC/xczKgMwzF5UBtmBv5VDuV3BaWhrQ0chL47jz2GcEsBNWLLm
	9yMVpbdNJM52S+ltPaDkiPRL/TPg6safdpkPTJ4v8Otrg==
X-Received: by 2002:a05:6a20:728c:b0:39b:fbb2:5e46 with SMTP id adf61e73a8af0-3a3cf85d7d3mr5989502637.40.1777602805603;
        Thu, 30 Apr 2026 19:33:25 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6f66dsm870418a12.15.2026.04.30.19.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 19:33:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k_htc: allocats tx_buf and buf together
Date: Thu, 30 Apr 2026 19:33:08 -0700
Message-ID: <20260501023308.303507-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B511F4A9D1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35739-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Use a flexible array member to combine allocations. No need to have them
separate as they are always together.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 14 ++------------
 drivers/net/wireless/ath/ath9k/hif_usb.h |  2 +-
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 821909b81ea9..8ae4e5d4fa14 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -454,7 +454,6 @@ static void hif_usb_stop(void *hif_handle)
 		usb_kill_urb(tx_buf->urb);
 		list_del(&tx_buf->list);
 		usb_free_urb(tx_buf->urb);
-		kfree(tx_buf->buf);
 		kfree(tx_buf);
 		spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
 	}
@@ -811,7 +810,6 @@ static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)
 				 &hif_dev->tx.tx_buf, list) {
 		list_del(&tx_buf->list);
 		usb_free_urb(tx_buf->urb);
-		kfree(tx_buf->buf);
 		kfree(tx_buf);
 	}
 	spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
@@ -828,7 +826,6 @@ static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)
 		usb_kill_urb(tx_buf->urb);
 		list_del(&tx_buf->list);
 		usb_free_urb(tx_buf->urb);
-		kfree(tx_buf->buf);
 		kfree(tx_buf);
 		spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
 	}
@@ -849,14 +846,10 @@ static int ath9k_hif_usb_alloc_tx_urbs(struct hif_device_usb *hif_dev)
 	init_usb_anchor(&hif_dev->mgmt_submitted);

 	for (i = 0; i < MAX_TX_URB_NUM; i++) {
-		tx_buf = kzalloc_obj(*tx_buf);
+		tx_buf = kzalloc_flex(*tx_buf, buf, MAX_TX_BUF_SIZE);
 		if (!tx_buf)
 			goto err;

-		tx_buf->buf = kzalloc(MAX_TX_BUF_SIZE, GFP_KERNEL);
-		if (!tx_buf->buf)
-			goto err;
-
 		tx_buf->urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!tx_buf->urb)
 			goto err;
@@ -871,10 +864,7 @@ static int ath9k_hif_usb_alloc_tx_urbs(struct hif_device_usb *hif_dev)

 	return 0;
 err:
-	if (tx_buf) {
-		kfree(tx_buf->buf);
-		kfree(tx_buf);
-	}
+	kfree(tx_buf);
 	ath9k_hif_usb_dealloc_tx_urbs(hif_dev);
 	return -ENOMEM;
 }
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.h b/drivers/net/wireless/ath/ath9k/hif_usb.h
index b3e66b0485a5..c28033ee61ce 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.h
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.h
@@ -77,13 +77,13 @@ extern int htc_use_dev_fw;
 #define HIF_USB_MAX_TXPIPES 4

 struct tx_buf {
-	u8 *buf;
 	u16 len;
 	u16 offset;
 	struct urb *urb;
 	struct sk_buff_head skb_queue;
 	struct hif_device_usb *hif_dev;
 	struct list_head list;
+	u8 buf[];
 };

 struct rx_buf {
--
2.54.0


