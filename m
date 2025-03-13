Return-Path: <linux-wireless+bounces-20352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D060BA6024E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 21:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE419C649E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 20:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F891F4634;
	Thu, 13 Mar 2025 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1Pig4fh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807F1F461C
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897058; cv=none; b=hGXOvxuWJy1beZwSgw5tAIHaAwKJYJgN1ExfzCzViQC/YyCZP9Dl2+TpausqAuyxglomPC8R4phVZtx+HVEVTQwArPKF17iihC0prQ2YWNANmKQVn9u9I9XHOW9wDhE9IhY8oWjsP7oL6EORJO4yr7jo7qJnff9rqH/SaE3OOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897058; c=relaxed/simple;
	bh=AfaFkyGD3mkREAYunXHNH39o6ucwUpxQhKCl+8HQ3Yk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MQOcrizCnLo2vVFqcaSbYXaZpA8e01QckC0ZM1tBNfBT5/ZrAXQBCOhKO2EcBmCYf3dYMlIGwGi7voT/L5GUiOs44RGINsk99WDVYK6gNQrLjNjV0+Ungum8kZZg2X5R+wQ4u13x2sX+FHeC4ZKj/aFotG6Mb1L2WqHttpirVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1Pig4fh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so2010742a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897055; x=1742501855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CL+OJDnGYN/koRcEsjVUz4MdXxz06WXzKG7cUkYkqdk=;
        b=f1Pig4fhNoIf5ICRrCx6g+pVhZeMCmzeVcE1w1JDXYPXr5O4ZziDsvg7hs6H6FA7eQ
         ofrztqQ0wUVe8/n6W49rOEAnb2F2L0ohKZD1JmVDb58fBkeA91fzSUPfeSQkaGLSofsO
         mSZ3xQCRHDXUzOhDbYLT1/7xEvHM3FxCadJ9E6URvH7QkEeUn6TjLOOxaQt7Ahse+42Q
         iScIQDkVCBj3KPcZ5jMYOdMFV59OiO4/uGeQmFSpkmXuNQESAMqSUhVoELLR63C//wtL
         Iz/UTtC4T2qP20Y3GlMMId5Ri1eFEvO8ptNDny4eh/2VN5k5zpwojZKLLRrFjN+MeRnL
         EsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897055; x=1742501855;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL+OJDnGYN/koRcEsjVUz4MdXxz06WXzKG7cUkYkqdk=;
        b=RscztXB6SD8eIOhI5KXBbludgHUWT86QMU9QKT/pUOiqF2bexAVdadBKxmK8r29Vt0
         c0ha1ntl2WopRsppvVtAcE+tA9Gw9ir90AtRAN6agvlO1vr1GZdU17OCtRoRLkfen1Lz
         ba/3CikWYn59LlFrx0LPJpI13FQUE5IRgIopuvejYf6Va/Nv4ak/eEp4F/Gm625K9yg2
         jlRMhbQBpXqiwLRg+93WaIpUpj3G1DjqhnL0CBzjhNr+VyFVp8sOjmls/FNEj+UumIgK
         P7OkOM51ah0bvZk0Hz9dMmSD/yBPcz84EhvrqzXkAq+VqxAbgPpDWq5QAE9WbF54g+YJ
         JqLg==
X-Gm-Message-State: AOJu0Yx3UxZ9EqRxjVQsX8B61UgEE2w7D7yUpphPWpIuf0L+FvIVM0tL
	M/eMccwnqSUWVj5F7TefsJRwLgQMDg7kV0hmVx95NWGROJiapbN+Umsa4A==
X-Gm-Gg: ASbGncu7L3wI4Qr/WI0L/kkwpvUzfCop0fJF6w/PGgLN2oBMMDl9tm4KmP3aKOf5FU/
	BhTx9XDfXPtEnLl8LeQAP4ID7ZT+kwmU8qWuyShBhN1U/O0liY4nEuIgPkPGOAZbDD5BjLPZm0G
	rn39y3jVHZzr2M0jL/fr+jw0ZBZIKx4OQcm4JDpi7DOiDQeudnU536zukUjxRzm2N6RcVXW3gBA
	Ff49m+erLtbuEJ9EOGY/XC9+v2qE7xbbou/WRcDEpJQLmlfbp+mNVa5+xNdH6ECEAMAQDBv0cbL
	cJ9urfBz8UrD6L5EsdcDQbu5EiB68frW5g58Lwd+MTM8JYLfULx1QQ==
X-Google-Smtp-Source: AGHT+IGxTM8L0LE+idZUJZQLTLkbx0U5qfWqfXICha66Khe4FN0KyRZLEC1LYpKBe9tK6vufQ34OwA==
X-Received: by 2002:a05:6402:50c6:b0:5e7:8efa:ba13 with SMTP id 4fb4d7f45d1cf-5e89e6b1751mr50009a12.7.1741897054630;
        Thu, 13 Mar 2025 13:17:34 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe1f6sm1037666a12.77.2025.03.13.13.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 13:17:34 -0700 (PDT)
Message-ID: <1cf5d430-82c2-4b7c-96f3-035aa5b899fe@gmail.com>
Date: Thu, 13 Mar 2025 22:17:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/4] wifi: rtw88: usb: Enable RX aggregation for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
Content-Language: en-US
In-Reply-To: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Let the chip transfer several frames in a single USB Request Block.
This is supposed to improve the RX speed.

It can use the same code used for RTL8822CU, RTL8822BU, and RTL8821CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index a78f59fcde58..54fb835e65e1 100644
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
2.48.1


