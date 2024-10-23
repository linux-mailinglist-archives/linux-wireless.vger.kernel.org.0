Return-Path: <linux-wireless+bounces-14400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6348C9ACBF6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835081C20D68
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5C11ADFF1;
	Wed, 23 Oct 2024 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj0p9AUi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4776D1ABEA9
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692732; cv=none; b=ghh6g2scecAOlfMmh6fX9cKKLi79Wfz+rB+FHLpqprS30lS0ofJ7RqKmtu+t94tLSmzkAre53IScgq6u86As42QaZWmUe+MXnCyraKAW9fTAO1uhZqlGYJx4lY6GiGs/o0VqAYVv0tzoICQyc4XkBXHHdSqjINKrVh+dx+W1PM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692732; c=relaxed/simple;
	bh=QyVtCYr6owxZoqGdqNo28HTBQs/m3I4Xhaw5pyKzV1M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pueQVd8+4ToBmtTNbdwZITIUmlH9WNQgBluPQBS5mvh3JUZZ1Pkq9m2ZxaCghwsKP5V3bSzssAVxYiwOcRIBgc3fxLgRvpN6is6Vo2jQhqnnEp9POKqqI2SbV00y0cdQTTj9O8n58SIpN9sXSRBfj8MQH+dC4vN5F/jHT+0QvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj0p9AUi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so949640466b.3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692728; x=1730297528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k2UVoV5V+JBt9AZv36LHG6BrsbgNbFLVTsuxorC38uQ=;
        b=nj0p9AUiN2srG4B66BZJlysakPT1BU3q0DMgqraUToMiLn0QwgWHMZGPEB0jR8UGDg
         3UwczHpoKS+s7Kn+RagjpRZ3OCmACGmdgLVRem3XHDm1+i0e7pCdvv0CC9K/8ZYNkeK5
         ahOM3SBipH5EMGVIUylhpORjRfaQVCw871MK73Xt81Nd2a9ZH1xivvaiYfYqKdY3SDsG
         UMHdsdk6LI/Q04cY7nWjBO/Bz5IcFr3ZqGwArP+06Ih4ZNnmHbrlF28Sbq9qLSPXAksM
         TefPQSQ9nVkwCwXG3oDQr2Eolwm9+BHk34TDhE0mP5AYiQaGd+QRsA0wdtROzS++quqQ
         j5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692728; x=1730297528;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2UVoV5V+JBt9AZv36LHG6BrsbgNbFLVTsuxorC38uQ=;
        b=OF5PKrOvfTsNt1HQzojw4BHMRcu/HNcudDB23SD8NY/oPY+qsY5xzGHq0piNwfD9zO
         BpRtZUx7pSe2/9RCEhHxgyyyFzMdQsq32O+q3IujG2IxPgeRWCeOZh+vRDZfRMVp84FM
         tY0L6N/wIRO+VD2qs6DXbZvamUaR0I6uIE6RleksO3nGjWbAWrYR2Rp3to4256UWWyAw
         oqMlypoJvNj681Py+FH4cpuyK+FYsHxaBg4xgodot6H8zMqWub8MLUmitfx4U85XcpKw
         zef1U5wUMlu+vsvnL0szIowyHyhRRCN5ciM90j7vMh/cuWOTTHf7nITzDmMV55IGYxA8
         UDkw==
X-Gm-Message-State: AOJu0YxpTXmG+40NBkgUJc4mHO1YhtPedEwEN4KfpE/8e3WEQRHKeDEN
	A+V8IChkyjKe6o2ttZa4ZEyowztaI7ShwYO+jRiMUwGGIlkKDUYmmcfmUg==
X-Google-Smtp-Source: AGHT+IHaXvdFoRYUXy16D6K3H4AJa9sdNK78pskceeiGYnmKYXx92vLQqw52M8+g298fS+5aggVxdg==
X-Received: by 2002:a17:907:720f:b0:a9a:3da9:6a02 with SMTP id a640c23a62f3a-a9abf96f0dfmr267840566b.60.1729692728407;
        Wed, 23 Oct 2024 07:12:08 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a915599dasm480264366b.118.2024.10.23.07.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:12:08 -0700 (PDT)
Message-ID: <acdefbb1-3daf-4349-9e03-9472754d5f1e@gmail.com>
Date: Wed, 23 Oct 2024 17:12:06 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 09/22] wifi: rtw88: Support TX page sizes bigger than 128
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
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

v3:
 - Sort variables in reverse christmas tree order.
---
 drivers/net/wireless/realtek/rtw88/debug.c |  2 +-
 drivers/net/wireless/realtek/rtw88/fw.c    | 21 +++++++++++----------
 drivers/net/wireless/realtek/rtw88/mac.c   |  2 +-
 drivers/net/wireless/realtek/rtw88/main.h  |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

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
index 19de5ba555a9..e6e9946fbf44 100644
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
@@ -1601,13 +1601,13 @@ static int  __rtw_build_rsvd_page_from_vifs(struct rtw_dev *rtwdev)
 
 static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev, u32 *size)
 {
-	struct ieee80211_hw *hw = rtwdev->hw;
 	const struct rtw_chip_info *chip = rtwdev->chip;
-	struct sk_buff *iter;
+	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw_rsvd_page *rsvd_pkt;
-	u32 page = 0;
+	struct sk_buff *iter;
+	u16 page_size, page_margin, tx_desc_sz;
 	u8 total_page = 0;
-	u8 page_size, page_margin, tx_desc_sz;
+	u32 page = 0;
 	u8 *buf;
 	int ret;
 
@@ -2013,12 +2013,13 @@ static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_probes,
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb, *tmp;
-	u8 page_offset = 1, *buf, page_size = chip->page_size;
 	u16 pg_addr = rtwdev->fifo.rsvd_h2c_info_addr, loc;
-	u16 buf_offset = page_size * page_offset;
 	u8 tx_desc_sz = chip->tx_pkt_desc_sz;
-	u8 page_cnt, pages;
+	u16 page_size = chip->page_size;
+	u8 page_offset = 1, *buf;
+	u16 buf_offset = page_size * page_offset;
 	unsigned int pkt_len;
+	u8 page_cnt, pages;
 	int ret;
 
 	if (rtw_fw_feature_ext_check(&rtwdev->fw, FW_FEATURE_EXT_OLD_PAGE_NUM))
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


