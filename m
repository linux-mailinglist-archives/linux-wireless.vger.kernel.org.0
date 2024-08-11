Return-Path: <linux-wireless+bounces-11285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA6F94E336
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 23:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBEE1C212FC
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE27157A7C;
	Sun, 11 Aug 2024 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKSXkKaR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD42595
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410270; cv=none; b=H4JigwCZ9+a8aPjgMGU5FqTA9Qo0uSlBjGn10Ejsx5hswSpKPhGBoSVsp3hOlATBKm4P1n0TEsEUZU9czm9w7bUGJWrfMSiEGruVOHjh2kouEgX1BdgKxkB9AOj/7bX/PmR7rxns0azqpLXFzjhrwMu3Wn/poCuX7N0OxpfGlik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410270; c=relaxed/simple;
	bh=Bk9VQKZUWhB3Npx+8gwZMVwDqxNkV/yIEmMs3QwcReg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t4LkPfHi0Nv/16ChfNkBYFaFVjRrEPS8mxOAIHymAhz+VNFaB5SidoLexY/7GUwNDcdPEZMrV8UlQJhq4/i46flrmBvThGEj9cRntdj+Gs4lP3LSeZHasgqQZkSo1QN3UXpPvjchRMC4vCKKFQBnTwjorfCJuSrmkYF7GXqw8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKSXkKaR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a9a369055so298223966b.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723410267; x=1724015067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZUFyopYQ1E+l+JYhV8iu/SPiIIYYIRIA9KVzGX7/pqM=;
        b=OKSXkKaRum7FsNiT6d+ft3HiUX55V6rrQaJHUUa7DwkH1J/vDDWp7w/7IjAO49V0ys
         QYf1J7FaUVM30oFD5BWtV+n/axAX9W/LzOiy5kAhXl7bYLVh7H7Zzup4rnQT/q6AgWz+
         /M+aRuEn4ZbKNrd47CQuA19DKNOpjx19cs84OeU9iGfRrQuDp16DBZdbTXWss6CwnGji
         voz7Mdesv49OJVNculpYIOEzdBu2bHDWpUbGDRTEY3cfhNlLmC7MhevJIwhcZk5d3/Aq
         UMNamSWvVdGEg+ytBRDYDNrLLspA78ddLcxsNakNV6+ysyygVLxq2INhPx5qVGk5WYyM
         nsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410267; x=1724015067;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUFyopYQ1E+l+JYhV8iu/SPiIIYYIRIA9KVzGX7/pqM=;
        b=V394PdjpLfv48UyNsZDWwDASYrny/dlf2OsPIy1ZsEuMSkS3Q+eZCaxA9Jky8IS80C
         Kd3Daf7zoOSCT+C5k7A4zHObwM1K0mkSEk9oFhUExpl17ySvB7hZKAgcw9LkCDA31vjT
         JVYpZPG9dJWewLLYCVW9hJsy1N0uIzWNIzt4Lpa7FgxXUYOFXUHjSwXuaqX691ljpS91
         0fseojk4wOgZHvugLcK9329i3JwEokDnI9pL9HtLGyZJScljpnQTXZfDLmN9P7kzhi3V
         ZP0xfscFvp1jcQCkFiTYJXGK+2Tu459oxLCFFBJM6C6UO5jDUqUiiPEBmuGw+p2bmNWN
         4wFQ==
X-Gm-Message-State: AOJu0YwjEutiuKn6TeKon8PyOl3Z8tm8V2PgkWaJrbxy2vFi7bxKJUX4
	yaK9fAUt5+fzKMpvJ9/GBthcTfY1EdSMmB51nU16fqQ/IFxKfBBMCB7dZA==
X-Google-Smtp-Source: AGHT+IFlxlxgp6sjLD3Bd7dJnKCkt136CPusSeRr5bbPomgeiiRY8vyMVN6IpwZIUusbgcGyDQJebQ==
X-Received: by 2002:a17:907:3f92:b0:a7a:bc34:a4c8 with SMTP id a640c23a62f3a-a80aa6eadcamr476907066b.69.1723410266777;
        Sun, 11 Aug 2024 14:04:26 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0dffccsm172848366b.54.2024.08.11.14.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:04:26 -0700 (PDT)
Message-ID: <bd23d618-3f56-4729-ba23-8c14e9873ef9@gmail.com>
Date: Mon, 12 Aug 2024 00:04:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 14/20] wifi: rtw88: 8821a: Regularly ask for BT info updates
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The RTL8821AU firmware sends C2H_BT_INFO by itself when bluetooth
headphones are connected, but not when they are disconnected. This leads
to the coexistence code still using the A2DP algorithm long after the
headphones are disconnected, which means the wifi speeds are much lower
than they should be. Work around this by asking for updates every two
seconds if the chip is RTL8821AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 2 +-
 drivers/net/wireless/realtek/rtw88/coex.h | 1 +
 drivers/net/wireless/realtek/rtw88/main.c | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 39fbc5ef82f8..91e21bdfb569 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -446,7 +446,7 @@ static void rtw_coex_check_rfk(struct rtw_dev *rtwdev)
 	}
 }
 
-static void rtw_coex_query_bt_info(struct rtw_dev *rtwdev)
+void rtw_coex_query_bt_info(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 57cf29da9ea4..b6400e87e78d 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -384,6 +384,7 @@ u32 rtw_coex_read_indirect_reg(struct rtw_dev *rtwdev, u16 addr);
 void rtw_coex_write_indirect_reg(struct rtw_dev *rtwdev, u16 addr,
 				 u32 mask, u32 val);
 void rtw_coex_write_scbd(struct rtw_dev *rtwdev, u16 bitpos, bool set);
+void rtw_coex_query_bt_info(struct rtw_dev *rtwdev);
 
 void rtw_coex_bt_relink_work(struct work_struct *work);
 void rtw_coex_bt_reenable_work(struct work_struct *work);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 62d9abc04a34..699870ca1a9f 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -261,6 +261,9 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	rtw_coex_wl_status_check(rtwdev);
 	rtw_coex_query_bt_hid_list(rtwdev);
 
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821A && rtwdev->efuse.btcoex)
+		rtw_coex_query_bt_info(rtwdev);
+
 	rtw_phy_dynamic_mechanism(rtwdev);
 
 	rtw_hci_dynamic_rx_agg(rtwdev,
-- 
2.46.0


