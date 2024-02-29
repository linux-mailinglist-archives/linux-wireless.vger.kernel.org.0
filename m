Return-Path: <linux-wireless+bounces-4273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B886D6E7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 23:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB541F23A3D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 22:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEEF20326;
	Thu, 29 Feb 2024 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efaYidMa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC83200D2
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246163; cv=none; b=txLh8KVJzaeHyjV8UD/w2vHzItGprac3uWQ10QHEzfGTrbpfGy5wQ7ulA8iNar/xQ9GoEyDmVNJVZv2ZEzmXLu80F/BTZ3zpZFeNIE9khZiKPTGW6JaoqWMNQ/k2C9+ZUpGWVs4mO/gCJcWhscCbzzvok2495FRdF9vQJix8N+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246163; c=relaxed/simple;
	bh=cb97msDWtnE4Qdtc6BLZ22e1WsjXWlfwXBJTw4CYFRs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UH4pCAVHFWylxz7Z0hRQXDvGkE7TdOkfh0z5chOsBYCe0z+6+DG9VrdtzzPzdicEEkSMDIIPDfrxin+yu0bpPz5MILuRMgK+3tsv2UCs5ldmJQ6lHoItRo5Nkz2GekouFhDWSnV2cwUGgV5iHRoyK3d2vH/ceWRIiotuGV0ZyvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efaYidMa; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512b3b04995so1314275e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 14:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709246160; x=1709850960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zb66jO9LcwwLFlmdvbIbnbvhJ5fEvEL6G6MxWHGK/k=;
        b=efaYidMaIWhOPBV3+2OCIyan3rQQByM53+EWs3lFU+ZQsUgsS4fUqVhXwz2tSYFQ0z
         +fZCkqWa/sjR800pM0u1XOnnBuYOsoJdXtGxYbUPQXwJpo16YQrW5l9kbCqfi7qVIspE
         KEWAJPdps/9zONlFn12PBong4RmZ2l1CVsd7Knas0jSMUyfP0wLdjyZ9Nc0OdvyDkeg7
         5VcUHo8sH/Dfsw8NUTNabwBv2gRHg/oIXODpW54j1Apy+R0MEMWZYf5mLWskd/vOjEer
         L1KQkqfNagXiLDFbS9FDkmntsgiLx6raJYt+H1hHBj4YBWCj4NnYOGPfId98++rPWVNK
         bpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709246160; x=1709850960;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zb66jO9LcwwLFlmdvbIbnbvhJ5fEvEL6G6MxWHGK/k=;
        b=GQ6B0C8LCzJkr0t1TXz25rU4edbc7m50N/WIqhrxkRzRf7u4R0FwSTrLZYhmUjIQ6/
         f4eW0bvJxaMwlWxqjCV0ovejpKpt8tcuy9pzMbWYi+IKm5Ezkf/6ohAcuMsfiBFXsg1g
         5dXE/yi99IFMONiCi4/uIy9RA8p6+JthU0yjZ0xjNLVGzpk7xh70HNFI97p+GDurkUrq
         L2PqENTUO8paOgIrgh5ml+XNbjbVpL96RbWwKVM80KRn49uh340dwIam94C2mAN6dc13
         /pGK112YJqBG8614L0GzUj93ZwJsu4RKWpl9A1Vt09S8Tvrs/+c/wOiTN1VuV0QPvjZ3
         G4Uw==
X-Gm-Message-State: AOJu0YzFeMIJSHtoRDo93Pyyt/+nhY3LYUNbdJPpf0jE8oCfRwpl7ghS
	A/i0QZkP2yfC8SL2SAmZFzjp4/7dzBH2zZBHBun12ROsvPyHj8mf28ynxueq
X-Google-Smtp-Source: AGHT+IHPdx0h6C9/1YI82SIjFjjWLHR+hJF4wwYNY5zbwE6g1qRczLH3d7sgx88cGUffntyfUO4jHQ==
X-Received: by 2002:a05:6512:619:b0:512:e85f:175b with SMTP id b25-20020a056512061900b00512e85f175bmr1907773lfe.16.1709246159954;
        Thu, 29 Feb 2024 14:35:59 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b00412b68cc169sm3360442wmg.16.2024.02.29.14.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 14:35:59 -0800 (PST)
Message-ID: <f3cb6d17-e4e4-44a7-9c9b-72aed994b5c9@gmail.com>
Date: Fri, 1 Mar 2024 00:35:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/4] wifi: rtw88: 8821c: Fix false alarm count
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
In-Reply-To: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

total_fa_cnt is supposed to include cck_fa_cnt and ofdm_fa_cnt, not just
ofdm_fa_cnt.

Fixes: 960361238b86 ("rtw88: 8821c: add false alarm statistics")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 429bb420b056..fe5d8e188350 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -773,9 +773,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
 
 	dm_info->cck_fa_cnt = cck_fa_cnt;
 	dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
+	dm_info->total_fa_cnt = ofdm_fa_cnt;
 	if (cck_enable)
 		dm_info->total_fa_cnt += cck_fa_cnt;
-	dm_info->total_fa_cnt = ofdm_fa_cnt;
 
 	crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
 	dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
-- 
2.43.2

