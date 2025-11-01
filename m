Return-Path: <linux-wireless+bounces-28457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69245C28608
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46FA44E1C94
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFDE224B0E;
	Sat,  1 Nov 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxwsjxMl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3581DF258
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024801; cv=none; b=iEPyihmETEqedMYTmlnAX37XsEF2dWldY3nVSWs6R92TwwqSOJHP2RLaqjl7qqMqEO00/CYejs2sfAF3h0w3ws6HkeqW6RDQ1aGTcU4fQXHb9bMZ+wy4isFKQ8qJ4gXt7gZ9hG7/BJ/n2/GRW//3gV680ZOjybS8OHZ/JvOes50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024801; c=relaxed/simple;
	bh=zpR2fA8G2YVH+ZIpqcNaEUaQ/t0V0LCY2vpkjFDdi6M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m5HmN2Pmdo+q7UCQ3N/mlqE1UuLIW5ckexL1hlUaSDdV+cbu4PxaQOpGSeCzMxOoNHbSDsIg/JGKN37rsRvfcxJUuX4PfMBmicVl0MzAafp8SUlEUc9Y6O+JDjPHB+dk00UKE7OO8LixatJA67koHGr/iIHvbBNksNtVbjKW+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxwsjxMl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421851bcb25so1829685f8f.2
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762024798; x=1762629598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=++3AEd9RT+ehNKItO7LkzPOrwMeYbdGr7VjSOCS7lNI=;
        b=fxwsjxMl7V94geTX3Ahowy020AJw44IYYHRoimyD5q9ECBsrXtH+T/FaeK4V78QGgD
         +S5eDua6k79/4anoQDliTyY23jApoUu9lQ5udm1UvBcfRKjWqGr+FoS/Bhz5I0C2gLS2
         yXW3gwU1BC+erU4HT2Bvm286BCaOjMFKhS+No5UTYEOhdY6dz5VC6lE1y5+2OEHR/dGD
         6Cbj3xG9qx0i+hAHGhMpFlje19TWtFV8VMDKlzmOuMUhnz5lnKVCACya/s7PPsVwREaZ
         lKZkFHuo0W1Ngleq9tUhrxTJytMQHHV0E2FfO9bDwJO/NgWFqL7xPPU6pTPi5bTdZDeI
         ZA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762024798; x=1762629598;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++3AEd9RT+ehNKItO7LkzPOrwMeYbdGr7VjSOCS7lNI=;
        b=Cg96hAHgVas3JIY5Gd5ZWfzUmXIGOCbjzyOsAOdX+OROk072eauzHLBuaa4snde1+e
         Y15cHd7wR056naN/FByqJmQjF/Ctc4d+ok0X+KC+amOHPwowofIl6ym4A+WCCxvMCzdL
         LmyjmoHxzPwoKc9zZRL+DWfx8OgJ1fpXuNb2jBo1hH34rpXjP82IYNra61W0gcybN60u
         BQ1qozh6a+TNbPpek4wpvEOeHb3dPkfPjANN5fMukkGf902uuW7pR3KTArAzvfKRAAng
         Z/8ZBESIgYe+i+Z8JXF+YeI3CE70GimCCI3wkfYnJqoFVn3RYaPN79E4cv/rSJkBaHcP
         Hn4A==
X-Gm-Message-State: AOJu0YxcsFGCiRwYV84JsvPaABXlYhiA7YtBfxe53W4K3yF61bkwPwhQ
	dKZAJK8IfTvAYU0+AY9XocUVjl/oCeXqKu4vzXItI7XknDtfsURfJLaFxAhGgg==
X-Gm-Gg: ASbGnctwjF95JgzSMFOiOXrx0LaVoCX0/07u4HYFo/qY/MCVfuwi5Aixk2B/LFvczoV
	40pXR6tOmgygJ6VOKnfRC4Q8H17KN348LjRX7Z4o6xsOb39hinjz8qhVMZsS3KGvUMwGQ+GOvTs
	LncDrwdEpwKSlK15H9gC7Gztw+wEBv0JfCSUgopebWGHObkZssrDHh/mfoE/Up666xyfu7dP9lb
	SqS8QWIPDEl2Yc6MWnw70g4PfCQlK8EI0kSvEUF3HrC8yrzZWh1lrPmvgVsX3uYqfpROWkTHQHO
	YY3TLqiXH7dOF+KlvMCqNITrZKXp763dGQ4tT9TyW5o6PP1wYU3l3ZcXD/Do/zzEVVcLCEaYYEo
	xJab6Ifv/eu19Hlpa2Qf4Zomux8TZo/FkffR0lW5usR0Hr7t6kG9U0dHPTFD1cg9iagMUQcWRbL
	0LTdKgYMuLvEue//8SvaY=
X-Google-Smtp-Source: AGHT+IErTwdKW7tyTLJuefijKIsJGPDFlv2dlNGWnH6jQlGP1jnxNqBrEarRMW62d5ENCjLqM0SCZQ==
X-Received: by 2002:a05:6000:2dc6:b0:428:55c3:ced4 with SMTP id ffacd0b85a97d-429bd680cddmr5740398f8f.18.1762024797603;
        Sat, 01 Nov 2025 12:19:57 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c23b8d9sm71367945e9.0.2025.11.01.12.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:19:56 -0700 (PDT)
Message-ID: <3904dd9f-2178-41e5-95c2-7a9f6268e935@gmail.com>
Date: Sat, 1 Nov 2025 21:19:55 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 01/12] wifi: rtw89: 8832cu: turn off TX partial
 mode
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Ping-Ke Shih <pkshih@realtek.com>

The TX partial mode in USB devices will cause timeout to wait for payload,
causing SER 0x999 and disconnection. Turn off this mode according to
design suggestion.

rtw89_8852cu 2-4:1.0: FW status = 0xee001108
rtw89_8852cu 2-4:1.0: FW BADADDR = 0x18605fc8
rtw89_8852cu 2-4:1.0: FW EPC/RA = 0x0
rtw89_8852cu 2-4:1.0: FW MISC = 0x1010000
rtw89_8852cu 2-4:1.0: R_AX_HALT_C2H = 0x999
rtw89_8852cu 2-4:1.0: R_AX_SER_DBG_INFO = 0x71020010
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f554
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f556
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
rtw89_8852cu 2-4:1.0: --->
err=0x999
rtw89_8852cu 2-4:1.0: R_AX_SER_DBG_INFO =0x71020010
rtw89_8852cu 2-4:1.0: R_AX_SER_DBG_INFO =0x71020010
rtw89_8852cu 2-4:1.0: DBG Counter 1 (R_AX_DRV_FW_HSK_4)=0x00000000
rtw89_8852cu 2-4:1.0: DBG Counter 2 (R_AX_DRV_FW_HSK_5)=0x00000000
rtw89_8852cu 2-4:1.0: R_AX_DMAC_ERR_ISR=0x00000000
rtw89_8852cu 2-4:1.0: R_AX_DMAC_ERR_IMR=0x00000000
rtw89_8852cu 2-4:1.0: R_AX_CMAC_ERR_ISR [0]=0x00000000
rtw89_8852cu 2-4:1.0: R_AX_CMAC_FUNC_EN [0]=0xf000803f
rtw89_8852cu 2-4:1.0: R_AX_CK_EN [0]=0xffffffff
rtw89_8852cu 2-4:1.0: R_AX_CMAC_ERR_IMR [0]=0x00000000
rtw89_8852cu 2-4:1.0: [CMAC] : CMAC1 not enabled

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v4:
 - Patch is new in v4.
---
 drivers/net/wireless/realtek/rtw89/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d837513f4e92..df040b4e8855 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2327,7 +2327,8 @@ static int sec_eng_init_ax(struct rtw89_dev *rtwdev)
 	if (chip->chip_id == RTL8852C)
 		val |= B_AX_UC_MGNT_DEC;
 	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
-	    chip->chip_id == RTL8851B)
+	    chip->chip_id == RTL8851B ||
+	    (chip->chip_id == RTL8852C && rtwdev->hci.type == RTW89_HCI_TYPE_USB))
 		val &= ~B_AX_TX_PARTIAL_MODE;
 	rtw89_write32(rtwdev, R_AX_SEC_ENG_CTRL, val);
 
-- 
2.51.1


