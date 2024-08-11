Return-Path: <linux-wireless+bounces-11280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AD794E32F
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 23:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B318281F61
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 21:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66042595;
	Sun, 11 Aug 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqS5Kiyn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E9718E20
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410054; cv=none; b=c9tQmIIj6jCPxf9gUhpBNXi9p2jBTdVuLkAy8LmmLDllMkcAIt9KaG0qhmhZX2Sq9EXLGMYYkpsBzoSPAmZIUCnqll8krPH2N/eSHwNn77viyz7Mt6VBrm7Uap5U1R7d1EoIT2e0vkVaS/rxjutnaNcEzJcg51KAH2/VGZvBa6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410054; c=relaxed/simple;
	bh=YAT+AGDH1VY4/4V+QDvXUildPNi8o4U88d+GKmcvkGA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g1Pup6ISFu/fBx4xrgA41PKlIWgaLJrpFw58ZyHa5QEOvbGzXPIyz5BXgp5mM78s3n2NSaT0OEjqO6l90UOWeo8ba0gv0cs8UCp0IrZ44cVENdclm2HtFj+ZwC6OjLarNGa72RPyy+dYhQKmeAQWgccXGcEtrewN9YKh9IKx5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqS5Kiyn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so4152232a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723410052; x=1724014852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d8LjJo7UEhALBhdcDKhBpGAwhWUBD/TlP0+piO6KJnw=;
        b=ZqS5Kiyn9jUnCu24od7eELE4SnqDI1WldeU9kff9uC2PsOoIThGGAINx30yt+R5uVs
         L0vIH+b8SZYOOsAdr/6FFx0W7zkzUPi0DKwFI7nUL23XYsmCTZ1kVB/qAPcb9Evb/ejK
         IUQ941/1QD0KnXwcgft8giXoh40cvnB0gT94/TjrBo4GesYyl1eJA9k8ChPSpQiWjeld
         OTh1mzSi5wYtcMTieXr7OQG75adn4RGLdgq79P4QNge9VlRPV2OiNMafCTxbl96VIrYS
         tpdFqLlvPVmRL65b7l91nnqQPtkfMvkoCNS6z7eMgWcIp6kVFEZORmEwfhZktiGVF4gH
         bESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410052; x=1724014852;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8LjJo7UEhALBhdcDKhBpGAwhWUBD/TlP0+piO6KJnw=;
        b=Oi0YNvG7o6UNbHmF/uECdzjxE1yMA+7grr1ibsRp+KR4JfL8YY5mf7JU9UlcA/+zgC
         TGM2M8hMnWrCNQ/bDHB9abroNMiN8JXkoVIsMNWFuhFL3LMbLEIQbu0z1nMAiHDeJ2mB
         g8s/07eF+hCkgu37Kw1N0ETN/XbpJEUVo2cByuBLIE3G0/B1arQL+550JN2O1kqi4dxk
         zl0j1qcgnpL2LwNQUwKb3G65LiBICvXIN1e+/BUtGEW2sI3uyk+aWHNO+orLqENv//Bb
         GcEnEoHwUGiVhGNYz+VfPGIyfWwJcFiG+SfYSdZprtdhfubOt8FCWOVIBGAB9Y69mGgV
         mIQg==
X-Gm-Message-State: AOJu0YwvvFyf7VrhfYkmpkF4P8o6G7vX67FvK4pni234U7PVi/cNMz4B
	Vt2k3hnoc/jM1pOOXbDKwlvy6V398DW894wouv15BRrP4Pg0A7L2MltG5A==
X-Google-Smtp-Source: AGHT+IHcTmNWwDTxAi+3iU68iiExwAwGztwHq5+Thoi75SYJnsH2+kPKeQoz18lOXL3iOsTAm6EnCQ==
X-Received: by 2002:a17:907:3f89:b0:a7a:93c9:3925 with SMTP id a640c23a62f3a-a80aa5411a8mr573225466b.6.1723410051512;
        Sun, 11 Aug 2024 14:00:51 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb241e49sm169838966b.202.2024.08.11.14.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:00:51 -0700 (PDT)
Message-ID: <3d35cd9c-3625-40ae-806e-dacb2fe0039a@gmail.com>
Date: Mon, 12 Aug 2024 00:00:49 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 09/20] wifi: rtw88: Support TX page sizes bigger than 128
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
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
index 69ebddf69dbb..19231082329f 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1288,13 +1288,13 @@ static void rtw_fill_rsvd_page_desc(struct rtw_dev *rtwdev, struct sk_buff *skb,
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
@@ -1602,7 +1602,7 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev, u32 *size)
 	struct rtw_rsvd_page *rsvd_pkt;
 	u32 page = 0;
 	u8 total_page = 0;
-	u8 page_size, page_margin, tx_desc_sz;
+	u16 page_size, page_margin, tx_desc_sz;
 	u8 *buf;
 	int ret;
 
@@ -2008,7 +2008,8 @@ static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_probes,
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
index ed7e95d5d11c..c4c2501e27c4 100644
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
index e737cff2e1cc..c78f9138d1bc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1189,7 +1189,7 @@ struct rtw_chip_info {
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


