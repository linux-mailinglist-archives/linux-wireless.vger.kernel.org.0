Return-Path: <linux-wireless+bounces-36780-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHr0EvyVD2qtNgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36780-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:32:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9627D5ACC78
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B1E0302FAC8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA78B345CDD;
	Thu, 21 May 2026 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjS4llBI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72586271A94
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405641; cv=none; b=Ri86L+vooZEfHSb0OVJ1cqwJyw9YY7/tzCDYF4rwdZthYxC4OdoaE0JdQ+5V7qSl1M3aUDCG/8HRcqmav6FvEQSK//qNVI6+8IHjWf9rM2WmVsWTct29TmW4VFH65UxaTyrTQMXm/snW6a09cGNBWCMxKtBPpqv01qJlEMk4fmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405641; c=relaxed/simple;
	bh=5H1p2nl9jnBtQopnZ0n+3qRahfmyAqAzpfyJKBwv74Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2Yym4Ab5ePyIzrxQJIOFtJLUT7495MwYMtSeHWkrVLZbQHN0vQRqN14gRdkYFJksgqUs7Eyxtd3ml8BbwZhsjhV8/R42k+Zlq8po51OFcJGGEgGnpS8l+jDMn1d3BYZAF4LrrbV9EBrLjIRakPKArgdQU1KDrMAt8cuA7i6N/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjS4llBI; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b7105dfb35so85836926d6.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779405639; x=1780010439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AA9Hj3epCHWvGU5vN67rNW8TyCNNE/GKP+VRm6cQBrE=;
        b=GjS4llBI75RuFTfrA1gy83BTc1mM5PcR5Oy8s5Yza1aSpHaPhxe+PBVIWEvFpNVpvF
         g+RylPLsrXSEi4Olmvh5KfP+JsfNJmnAuJtzL9q685YA4xXDJHsIia2M8SkXcERCPley
         1/ZXK4qaarC854TkZJxHz/NdY+p6+RK/xRjpOf/KZtr4HumoZtsndUgR2XHQMjCct8PQ
         3io85LDeE8fzRVF1KNxrb+0EU74oG1matjU7P/vFdO6KQgeycJnIZjnx1lND85moZ/X0
         hDj4lWfqvNq+kII/CtL87u/AZMtG+LFkP5MeCrJM9KyIwQCFexZUyV3svSh1u3/zYwJK
         hyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405639; x=1780010439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA9Hj3epCHWvGU5vN67rNW8TyCNNE/GKP+VRm6cQBrE=;
        b=OHUHHtuOeVXMaKrKOXfDlQ/L13IfNHkMitP7yfDcx7XUmfA5bMXB3W5CKjmjOpTBXv
         IsyMFs5iNNp7gs7+qt2j6nmiu65uLJCcZepB14Sdqa5vmircTWXTFWVsWEb0Nfq6HF9y
         R5qnbnaOWlKkyAaSjQX6oPDJyxRBb5McLGaMnlxclsTNVfNnMGYpyE+onVo0nAvX7/1J
         nMv8URLV+XYcMZ0r45Tdc5VDXMhzfXUf9PPZ/kLAKQ3u9tUDLcxA+0K3gVLr89vebU7O
         ri5Vv1Kan0Cfovr0VhVrLvOCZv8Of8yPXU5LwyJWKwI2R8nHr2/7SvBEtzPHK1xSKMrr
         2ONQ==
X-Gm-Message-State: AOJu0YwzD7yP4BejxYAerfNQDGJLsNmBZKTRkPAMLxvqgzlnIpmefbuS
	X/+czODAlOH4J3T7RzkKvVF5MPoRP4GP3C3DO/NuR88he5ZLlJBnQxyVAnPKQw==
X-Gm-Gg: Acq92OFoLeGfx9oTaL5BFkHLRw8EQqi1fn+iUMniRVDfftu/c09Wi221C0nCuC8ADLe
	S1bOGiitt8MGT8WAm5fCGyT6JKGbdtmHV6n545EmlGZdwfeHvQ1SLLZxKvOhTzPyg4qoCsDR6aD
	BvBOzlXUebxjfTxnK8joo+VUe+UhTDtJbiBjJYChjWFO8VyhZpkpHNzYR6WrU7rZx23CN8Xm2j8
	/zWBfZMommQcnF49eHMtl0G6Ts4oUgSizYHgSRuu8Umxk22GqnZsUhiCUADuSvoSrA6iDxPhItB
	1osSZfnkJFcF4iiP/6LmDg0DzTcuPOlxn8yEiTkp+r4oK9i63l6DDb2CXvD9DyepjR30z8V7KKw
	g+yNnbskEXWqk/htUkGi9HwFNvgL6oxlVCmDFmR97AUv/hWmqA0DHm74GvprGPudlwb5G+21Odq
	WmjLqoesJZnCm273/vHpPfgBnXhgN3QzNJoXAP0cy1g9I2X/+woqpLR6o/xBly8YP1pUBZEN9Dk
	jH/TP+2sO2Mfy6ZGND6RsAavLygNKXLkBA=
X-Received: by 2002:a05:6214:daa:b0:8ca:7f:89b2 with SMTP id 6a1803df08f44-8cc7b56747bmr25806746d6.12.1779405639307;
        Thu, 21 May 2026 16:20:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d4desm1334846d6.39.2026.05.21.16.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:20:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k_htc: allocate tx_buf and buf together
Date: Thu, 21 May 2026 16:20:20 -0700
Message-ID: <20260521232020.261405-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36780-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9627D5ACC78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


