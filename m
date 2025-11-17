Return-Path: <linux-wireless+bounces-29058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3856C65AA6
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 19:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A04764E53A3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A375305962;
	Mon, 17 Nov 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFAXISe5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC83016F7
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403040; cv=none; b=OWtqV1R8Uq/1sZ63JhDfV7MGlZ1fIaUJ1AeS6SZzXBJ5ICruTvXUu8x4D0ANhiwAyw+6xk7r/2j/X2YQvJEhec4TQ9kUcrMlImG93+ceED3humqEXK4HBSfq0cqNT2e8Criog0Bj5e+IzrgITdLDC5Gklhl/74ELjKoq2lZZ0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403040; c=relaxed/simple;
	bh=a9uJXhk+AJwKISsv20iyfSfymlaY41/HxcHxsS8s4Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr+DNlbejeXgvKerF8s9mc25Ejja1zEzPXnOVSuq0R8XP3SkHEv+ideEYr9bas2cN3Jc1SR+fAESP6N2ZjrqkWIxWyj/+o50ZIuOLZM1YocStwzvqJ/QxUDu8hyD/J+m2xaNKFv9uKs3fSLa9EpFFBe5L1uFp4nPi89yIk1dUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFAXISe5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8826b83e405so70232356d6.0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 10:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763403037; x=1764007837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WcAzmspmOGoWMLmEdWzg8Yok+8luZgzQGZNM8oLo9Q=;
        b=YFAXISe5Xj4CMUYeSAeJx46Lf5tvXK7h22kNoK+dxQNDSx10o0wooEP4mBrNswfCu+
         9k8DYGiGnDwO3AAO844n/lPDNHqhY2xIzqlySQ7/xUkCEHi8ffe/R7h/5EThcyv4B2c/
         5VPcmfjjI0/muJzdQnalKV86BkpSFgwVixa3lYnzIcqK13paYQieBu1vHZHUMOMUQw8Z
         R78B3T240qSnPmmsp/f+lGhNNOnkMpZtXoGaMGb4inFfRBlYF6mvaifoPyFErqvSFXvV
         sqZiz8w4VC2kHggbItw5d/SaWFZVeGGbaCsc9ayH4sxY6J5jArkZ+WdsX6tLeScodXoF
         Pbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403037; x=1764007837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WcAzmspmOGoWMLmEdWzg8Yok+8luZgzQGZNM8oLo9Q=;
        b=GFxJwaepVG2RfoDuoPNZsSJuz7xJZo+eHFMinikfZOnUClJJUlM9jHBiHuCMEVczsK
         nIV0ec06TFj+1qwSr1vfT80uj4vA4bEqscefXHj96gTByr1Fqk/E6gTDW1lDulrI2lIQ
         JOPdYAwuT69pl9ZBCggPxu2vDe1v4Q19c/wDLCB/Fq+eE+LbGL7WU/hoFR+EvgGKJsv0
         BY4eIbcesPk87ml8JDhRkQYTzkXeBjBpqY3rxHRJNmvdpgEThQugmYR/PQqKjHg6n+gn
         TcOnhMsfut/YNDXZ7aF+5YQV0rEE9EHyw6ves54TdTGgGYVl8Mt02gMe4k/gKiXbwvUJ
         6t2g==
X-Forwarded-Encrypted: i=1; AJvYcCXtgu+IwGFJIy7fVMdnHmRvZG+xUdLuK6gkXA/hSrJY5IuPkacm+ex8NyDvaM8ckGddEztpFBTXY2iu9nhJ1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yykfs7Ja17J4KbzFnAHHhZ9Iy9xqxeS6aIy3bbfFsye2GZdxvrE
	Mj2I9jox1FPsdCj7MZSq9f+79yVSSfXLz6yNiClpa+q9Lwi1wvPOGYv3
X-Gm-Gg: ASbGnctKjtX71zczG8kpYS1YESTVcbtyNFfuS5LTXWZUkDae7gIFitc5gnQuDARAU2F
	51MnXC2DNAWRJnFJbvcQwJ1NZQbVVWS1yEi9gXrOok8EjW3puvqZg7VXrOdqIVda/2prD9aKaxS
	th+yjO76juw1LdhcU8bi289jwDjuBhEB1c5fFi724XQAtz3E80kN2O/0GwiQ9JHggcB32fp0JHI
	9cv1jqOXsQmYtr3uAxYDk2STuVrAdZx4A1crIKnnJx472FhEeGDfCdfTP9DlenuJbyrxSdK3+o4
	rR1c4NQAeADn36lXSQToPComqN1PlRE4XY6z1LZFSaAu2e4XmQ83MK8aFByBULClNoY/1eIIK8N
	VspZKFjDyACvVaQwsNdBm6k1nJON0am7URWsOLUewNIlH4ZVvVUeZdyALBSTCBoX5PdQut3nJ3d
	CCXFj6QT6Y6bIpmbLcytYntAdWvSWAwPCz9/bGkExAoUYH1a9LPYJ5piGe9vrrmDhPOsG4U0QVR
	mfJllrqwRLdisETuLUrIh42VelO6HXR/idfSQso+A==
X-Google-Smtp-Source: AGHT+IEUIglhgvo/d5qFkBLi8Fgtj02uQv7ge8aCq9ESXRQHejN8JMAnKSqKiesLLWQ5jVxRlE1jhg==
X-Received: by 2002:a05:6214:234d:b0:81b:23d:55a8 with SMTP id 6a1803df08f44-882927352f0mr210202906d6.59.1763403037570;
        Mon, 17 Nov 2025 10:10:37 -0800 (PST)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828652ce08sm96795666d6.36.2025.11.17.10.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 10:10:37 -0800 (PST)
From: pip-izony <eeodqql09@gmail.com>
To: Hin-Tak Leung <hintak.leung@gmail.com>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()
Date: Mon, 17 Nov 2025 13:09:56 -0500
Message-ID: <20251117180955.1710801-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7012d9a3-821e-44fa-b325-9c4c37c9c26c@RTKEXHMBS03.realtek.com.tw>
References: <7012d9a3-821e-44fa-b325-9c4c37c9c26c@RTKEXHMBS03.realtek.com.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The rtl8187_rx_cb() calculates the rx descriptor header address
by subtracting its size from the skb tail pointer.
However, it does not validate if the received packet
(skb->len from urb->actual_length) is large enough to contain this
header.

If a truncated packet is received, this will lead to a buffer
underflow, reading memory before the start of the skb data area,
and causing a kernel panic.

This patch adds length checks for both rtl8187 and rtl8187b descriptor
headers before attempting to access them, dropping the packet cleanly
if the check fails.

Fixes: 6f7853f3cbe4 ("rtl8187: change rtl8187_dev.c to support RTL8187B (part 2)")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Addressing feedback from Ping-Ke Shih

 .../net/wireless/realtek/rtl818x/rtl8187/dev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 0c5c66401daa..4d0b408b4e33 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -344,8 +344,13 @@ static void rtl8187_rx_cb(struct urb *urb)
 	}
 
 	if (!priv->is_rtl8187b) {
-		struct rtl8187_rx_hdr *hdr =
-			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
+		struct rtl8187_rx_hdr *hdr;
+
+		if (skb->len < sizeof(struct rtl8187_rx_hdr)) {
+			dev_kfree_skb_irq(skb);
+			return;
+		}
+		hdr = (typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
 		flags = le32_to_cpu(hdr->flags);
 		/* As with the RTL8187B below, the AGC is used to calculate
 		 * signal strength. In this case, the scaling
@@ -355,8 +360,13 @@ static void rtl8187_rx_cb(struct urb *urb)
 		rx_status.antenna = (hdr->signal >> 7) & 1;
 		rx_status.mactime = le64_to_cpu(hdr->mac_time);
 	} else {
-		struct rtl8187b_rx_hdr *hdr =
-			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
+		struct rtl8187b_rx_hdr *hdr;
+
+		if (skb->len < sizeof(struct rtl8187b_rx_hdr)) {
+			dev_kfree_skb_irq(skb);
+			return;
+		}
+		hdr = (typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
 		/* The Realtek datasheet for the RTL8187B shows that the RX
 		 * header contains the following quantities: signal quality,
 		 * RSSI, AGC, the received power in dB, and the measured SNR.
-- 
2.43.0


