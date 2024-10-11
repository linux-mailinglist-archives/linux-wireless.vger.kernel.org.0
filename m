Return-Path: <linux-wireless+bounces-13909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0284299ADBB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627DB282365
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63C31CFED3;
	Fri, 11 Oct 2024 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHZq1VC0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F96199231
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679844; cv=none; b=RnwMAj1Hi0coZ+t1OYqfpqi7ixeEVWQ6XptQOfpWlv7YV15aUGAPZIVnUQS7KZ6ztHkOt4W2O0s62vkBbX1depGNV5OcQxQ0EHR1z71I61/5wWjExQDqJHUUiuqCok89+9nz3ytNxyIsQJI1mmhGdiwDNugLd5gq18I2DFQxco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679844; c=relaxed/simple;
	bh=wD4kh0h+Vv2D1tU6eDk36d1nV3BxQ/nIx3hEMZsCw+M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YuwxWG77OMxhtdho8dZj/mEO3Smltrxvcp0orGEFlb5PCo+38yo1jFHdlbLuXdkUDF7mtw/zFLaSpt02lW6l48Mxk+tiHRZJaK6J9XkiDXFzhSU2WFvipw9LocXTeOnd/GpwclJhBB5WkqLgnV87sEhLmLJnhJ+Fd53VwNNPaSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHZq1VC0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so22209285e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679841; x=1729284641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4lWOpTIAqn07eSNq8Zzh9/5GfXDgd0p7kF8WG8BH6ys=;
        b=JHZq1VC0WKSdKTcsCujuOIdz4h42pME9lEeDblvd91BFN6L+2BXrYVzt1PXw0WwrLS
         jrBNYkyS8SQt18jzQbjGswlXnHdo2px5UdeD3oF1AUe5l3vcoMfFmqABWTlfRXotpjSO
         ywc/FSENERb4StkSpHu5Jwl1lRyiRPgAxxMgQ+VYVcN6M+b1IjmG3xoVUGgyAunIHIwb
         P349zCoQqB1tKDezSfl/9QZDR8yS7flo26CqFhBs3TBRjSuvNmxEKcppCN6uLvOGGEzW
         4Zh1w6fbO5DZAulEo8YZO7cpns5UN+sP2N3C/WYViUty90s014DqP2xmcQgCJIyyl4h4
         Ni7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679841; x=1729284641;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lWOpTIAqn07eSNq8Zzh9/5GfXDgd0p7kF8WG8BH6ys=;
        b=Q8aCxXxcG/t/TndfD/VwpfYhwL2+9V2MtUcLvaNZLZIQuJp6CUly0NuWW1bAI5ZN4o
         1JLUVYgTNS9bmKFD5Opa/3Ciqez5KibzAZ/8mUjV7jFVLZbOgtzaZAhwJczpKZt9nMU5
         Kp7FPtBrJkaXSbffBn5E/cbkDnU4pemr+b4b5YNYvOe2Wwc9K7l72ahn2vKPBTbfKUar
         PH1XKZ4K3wNcgutjVAf9OJYaNb22z/k5kNij5hEBDuBmoX1bccDuNP+y6aSgALpvYfpw
         4I9OaohCwfOe0AbejqfjosC97Y3UiwJyyKvoB0aES+3Xi0xbXbfEkansIeu2wetGatur
         7qNQ==
X-Gm-Message-State: AOJu0Yzq4abbWVBWmHdTK3NSbWIWUV/9aV9/F17/d1RmfkLb9jeE7gBy
	/JwE1WNRLy5mXA5nVeoXK5ATVMtCl1h92wUtm0+133bu4JQLGhKF2TwGWg==
X-Google-Smtp-Source: AGHT+IFv5ciRmkievYZJduFZ6maJhlQiFOjI+/ejbwjyMvvMLYJndKpI4Q1vHvf3F9NXMbjdXdpivw==
X-Received: by 2002:a05:600c:4f07:b0:426:5fbc:f319 with SMTP id 5b1f17b1804b1-4311df55cffmr30435825e9.33.1728679841183;
        Fri, 11 Oct 2024 13:50:41 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183062b5sm50588045e9.26.2024.10.11.13.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:50:40 -0700 (PDT)
Message-ID: <5dfb2493-cd39-4c89-be22-9b04f21610a4@gmail.com>
Date: Fri, 11 Oct 2024 23:50:40 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 09/22] wifi: rtw88: Support TX page sizes bigger than 128
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All the chips supported so far have a TX page size of 128 bytes.

Change the type of the page_size member of struct rtw_chip_info from u8
to u16 in order to support RTL8821AU (page size of 256 bytes) and
RTL8812AU (page size of 512 bytes). Also change the types of several
related variables and function parameters from u8 to u16.

The TX page size is used, among other things, to construct the beacon,
null data, QOS null data, and PS poll templates which are uploaded to
the chip's reserved page. Each template needs to be aligned on a
multiple of the TX page size. Power saving can't work if the TX page
size is wrong.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/debug.c |  2 +-
 drivers/net/wireless/realtek/rtw88/fw.c    | 11 ++++++-----
 drivers/net/wireless/realtek/rtw88/mac.c   |  2 +-
 drivers/net/wireless/realtek/rtw88/main.h  |  2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index c26a6905fd15..364ec0436d0f 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -308,7 +308,7 @@ static int rtw_debugfs_get_rsvd_page(struct seq_file *m, void *v)
 {
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
-	u8 page_size = rtwdev->chip->page_size;
+	u16 page_size = rtwdev->chip->page_size;
 	u32 buf_size = debugfs_priv->rsvd_page.page_num * page_size;
 	u32 offset = debugfs_priv->rsvd_page.page_offset * page_size;
 	u8 *buf;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 19de5ba555a9..95258b9597bb 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1293,13 +1293,13 @@ static void rtw_fill_rsvd_page_desc(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	rtw_tx_fill_tx_desc(rtwdev, &pkt_info, skb);
 }
 
-static inline u8 rtw_len_to_page(unsigned int len, u8 page_size)
+static inline u8 rtw_len_to_page(unsigned int len, u16 page_size)
 {
 	return DIV_ROUND_UP(len, page_size);
 }
 
-static void rtw_rsvd_page_list_to_buf(struct rtw_dev *rtwdev, u8 page_size,
-				      u8 page_margin, u32 page, u8 *buf,
+static void rtw_rsvd_page_list_to_buf(struct rtw_dev *rtwdev, u16 page_size,
+				      u16 page_margin, u32 page, u8 *buf,
 				      struct rtw_rsvd_page *rsvd_pkt)
 {
 	struct sk_buff *skb = rsvd_pkt->skb;
@@ -1607,7 +1607,7 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev, u32 *size)
 	struct rtw_rsvd_page *rsvd_pkt;
 	u32 page = 0;
 	u8 total_page = 0;
-	u8 page_size, page_margin, tx_desc_sz;
+	u16 page_size, page_margin, tx_desc_sz;
 	u8 *buf;
 	int ret;
 
@@ -2013,7 +2013,8 @@ static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_probes,
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb, *tmp;
-	u8 page_offset = 1, *buf, page_size = chip->page_size;
+	u8 page_offset = 1, *buf;
+	u16 page_size = chip->page_size;
 	u16 pg_addr = rtwdev->fifo.rsvd_h2c_info_addr, loc;
 	u16 buf_offset = page_size * page_offset;
 	u8 tx_desc_sz = chip->tx_pkt_desc_sz;
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index daf23ccf6378..cae9cca6dca3 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1138,7 +1138,7 @@ int rtw_set_trx_fifo_info(struct rtw_dev *rtwdev)
 
 	/* config rsvd page num */
 	fifo->rsvd_drv_pg_num = chip->rsvd_drv_pg_num;
-	fifo->txff_pg_num = chip->txff_size >> 7;
+	fifo->txff_pg_num = chip->txff_size / chip->page_size;
 	if (rtw_chip_wcpu_11n(rtwdev))
 		fifo->rsvd_pg_num = fifo->rsvd_drv_pg_num;
 	else
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 45f0e8fff453..ef82e60d5c19 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1187,7 +1187,7 @@ struct rtw_chip_info {
 	u32 fw_rxff_size;
 	u16 rsvd_drv_pg_num;
 	u8 band;
-	u8 page_size;
+	u16 page_size;
 	u8 csi_buf_pg_num;
 	u8 dig_max;
 	u8 dig_min;
-- 
2.46.0


