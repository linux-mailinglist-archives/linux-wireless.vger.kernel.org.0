Return-Path: <linux-wireless+bounces-21089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACA5A7922C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C53B1889C14
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558AD2E3372;
	Wed,  2 Apr 2025 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miP6urUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBC10F9
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607835; cv=none; b=NMkBWAq9xh89XwCxheKjo255CwuodkHNANBN1jNyxEdrEhO0VGRawOKe/XJqJbrWv66nk1io4QTnKNgvINz1B52Bbdk5IiLkW+qiPISkWVy2RagY5y+wlBI25R1zCdEji1u908ADXZf3PNCKHgimDYf6SxfDL/U0hGjyAFgTjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607835; c=relaxed/simple;
	bh=Ge3m/gPwwUEjdSMeftW4WANHX+g63Zh0yutEyeuSul0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GYwaYoBrsn/99HOiQ/M3tcUDGvnCixOJz0429KSVJrQc4fquTqVjb5OoWOITybZYG0CRmkWYYVLlWjezhJqPKM3mJvbq+LeZtF4s14OKKnCprQVx8XcD62keFvve73mrX+ZTOGUhz+/D2By2bj+rfsel6uIT8I6QnC89C9xR4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miP6urUt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5eb5ecf3217so12806258a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743607832; x=1744212632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bK1aEY8utmYSlmnJKSiDFu2TdR+wkC6ga5wZEqtixYk=;
        b=miP6urUtvcdViW+4IoOZQgz4AYPDXWMouNKaRJTDjdF8JoXeawyRSJ+9CeIWJSALu5
         Q+soOJs4ECY+DnlUEdDDSO3EETmCfE+ReaAvyFgbuta5kpXRYMqF7FQr1jlbOnkxcwPf
         s2Lne8ynrn6nnAEgHIBSKNaVP13xi1YQKbBbiJOzD1pqioVAf/lZXWo1ieGVMaKZouxC
         6O50hi+/YbZ33V2eWeQxLMRriek7Rw7/ruhKSjznYYLWa0KWxMQP5FiRrW8jc9nA0quj
         pQ4s84VIvAHJ0DIEaEc6n4w5mTTBP/9H4U/HB7AUeMnD6sUbIE4H80ndYQOtzb02yXYK
         6fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743607832; x=1744212632;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bK1aEY8utmYSlmnJKSiDFu2TdR+wkC6ga5wZEqtixYk=;
        b=O74kQdIH+SofCwuCMgboEkgT/Ls2nOJXLmdfblu5o1PeqRFK7ZuXwwXKdZxSIZpFf8
         SGpSJyaEH9YyjyMhcrbg2LADOuUzUH/qtx/HXNnx/mGPv/7ukt1ZWAZyJUvOpZfu1S80
         suVYQhR/2oGEMa1NGQb8TUSkLPYeH5JZ2926QWuCyEZ2FkiqUuC7kDAdoq924lU7zaor
         hLMYUdqAcKzrhfJV1cZxnNJPhsc12UQnsDkbu5bruiI9qmsvv4m9RAwybnrmp7Kfs2+P
         5iYRSVNz3IBSx6g7+g3IeUWTyU9pojtgrtLzYss9RZvUTSqT3sGMRUsmB9S7WP3lh7Mt
         s1GQ==
X-Gm-Message-State: AOJu0YxYyOskeWT7bkS3VkKECiyD/dooVcpncVdZnSO0uNotlaYjOo9t
	eLecRMMPII2Ynt1omQhQTbtHiqiLrnc0Y/cNEV71VopRqB+EJ+FnHvqXUA==
X-Gm-Gg: ASbGncuWzR5o+xYIf3vC1R09tnV7/YeZ65NqZDB+qlDvuia+v1Qap/i/qnENiZ/aTco
	ASODapXm2B4Pfln13nYvufjtqx/wXTs39e3YymLAIGogNex0sNKXX1l1Ksk6W6mHlvDcUpHNNlu
	zukru36ZiJQgrsbYVPdoPZ5maNF7rMxFwm17UONnp8RBYDVOI98KvPIZ7t30S6AYOfHQfU68fMP
	lsKM7bCSwGBBYuZdaBUWrKSxQmAtYFg9Uibffo0Tdn/tva/mDmtTuEpBEihfKboslRLSu4jRVV3
	RETS+ECT10vgyXRJJd110RZWWTPBNliel/3UvpWN/Y6xCofHjcINpA==
X-Google-Smtp-Source: AGHT+IGDJ6kkz4mhEPE/GwwGl/F60sngBZQkvzn+pQY5ZyY2AGLImy4xds3yyoJ4nKQJ6lArgxwFpQ==
X-Received: by 2002:a05:6402:2789:b0:5e5:b3cb:38aa with SMTP id 4fb4d7f45d1cf-5edfd6ff9ebmr16446366a12.25.1743607831471;
        Wed, 02 Apr 2025 08:30:31 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d3320sm8725313a12.20.2025.04.02.08.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 08:30:30 -0700 (PDT)
Message-ID: <672397ac-dd4d-4420-8b3e-7011578e2243@gmail.com>
Date: Wed, 2 Apr 2025 18:30:28 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 2/4] wifi: rtw88: usb: Enable RX aggregation for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <257632d8-4347-45bc-ab39-4e88d87cdb3b@gmail.com>
Content-Language: en-US
In-Reply-To: <257632d8-4347-45bc-ab39-4e88d87cdb3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Let the chip transfer several frames in a single USB Request Block.
This is supposed to improve the RX speed.

It can use the same code used for RTL8822CU, RTL8822BU, and RTL8821CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 4994f5934e80..204343ac2558 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -866,6 +866,7 @@ static void rtw_usb_dynamic_rx_agg(struct rtw_dev *rtwdev, bool enable)
 	case RTW_CHIP_TYPE_8822C:
 	case RTW_CHIP_TYPE_8822B:
 	case RTW_CHIP_TYPE_8821C:
+	case RTW_CHIP_TYPE_8814A:
 		rtw_usb_dynamic_rx_agg_v1(rtwdev, enable);
 		break;
 	case RTW_CHIP_TYPE_8821A:
-- 
2.49.0


