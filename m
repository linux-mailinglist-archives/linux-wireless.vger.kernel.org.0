Return-Path: <linux-wireless+bounces-24299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61957AE2297
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042964A1D61
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 18:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844292DFA49;
	Fri, 20 Jun 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOC1c6Kd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6B1FBEA6
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445931; cv=none; b=aNsUfMHlipvCxV5JbCOqJNxXxB1hKE9WwfmmtYoCcShyTQStIcWnWXtMpxieZQdkTmsKZxBNlz2bXqTci+pg4hUwjdvB4UiKRiKXDTL7HkpKLCFGBhU5bTdo3dbtjrXVEvcYqr91i1q28z1aoJXhXs8Aak98ibuDhjWXSthS+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445931; c=relaxed/simple;
	bh=9sqLpphQeiX5REXkjGlh6iKjte7bjrSIpXvPru4xZ6s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N6yBVgHSQaXVG1m+oOh0w/ilbnb0MMu7sUPhOqgV96Lu6aMFj2ZhrtrUggzEPKE6bdTHAhw+YC2mgcoxNnwwxiAIAC4BKePBW8DzPvevLxM3uxqtVq1X6abVaV0KZE4UO5ePbInEjxx/UvpPb5aMZ91mk5GFv9ka+8GThc7jefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOC1c6Kd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450ce671a08so13984875e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445928; x=1751050728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qQq5TQhX9cBKqp+1teF0LLEEs+6lZd5UajxK+DbV1dE=;
        b=lOC1c6Kd550XcfuRcm8er+V7hJMKXM683RZfewuRDnrNjDjgKvcuSBKLDvGUTLGpis
         bcijaycxDTfwlr54HV9YZmUTTMR8y/LN6OUCArp42W/nvDgdn41yxhbiUxicW7Gc7oXV
         qh68rpvDePnYi+g9cRMqvURD2GWZG3JlC3i9uEXDlwkpowRFGg1wJSABqlTJFba3gWkC
         PN/X4d7eev8tl478xXobnjIHYIFRenTddaw01vw/rf21AHsJ6FfKZjLd79eLRyfdKBFE
         92o7mMp2tVl0A+oFqMdNaxgVh0jUaq8HPKgyIJr1XDKZ5A9qeDflwFs/hcDujMfjQKHy
         5d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445928; x=1751050728;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQq5TQhX9cBKqp+1teF0LLEEs+6lZd5UajxK+DbV1dE=;
        b=OwTX8qy/7WSTCDcxi5IGFGH7oUkLL7MDQK40qt0MMyZV61rxPlkk2nBxLSkWleZeZC
         1LSPWgmC9dn4KJ17pTe3cEgL8//BZq6cUYZOY+FgC7TzlvrGxnFpx24iWXz+CVOLz4Bq
         aNrGcLEgS2xoG0lmACqb6XrOkNgRQokZAx0oONrBibyr/YqjVhRfGKeX2F9EFOQ6UPtI
         rbXK5KVBjd0Elm8/xSk5BT61769E35mrPyIXMjnoU1g1GNxzcQ9Ezqk5VNXa0skJjFIR
         aCaGLiH2LUiRrUENqln2nDV8wQSK9PHas6FXs+ISx3g1Br93580mdOa43x3qY4aH6uiJ
         0SGw==
X-Gm-Message-State: AOJu0YxpNMa7buKC6L+0eG5I4rFUrkQdm1i7P3njYp6p4aZ7bpG2+h3m
	VmRwvN0NivGYNv6QdlZuwPzE3hsy0ihfdwVmrPElWR0TsKtydicqiXXqCAoaRg==
X-Gm-Gg: ASbGncvvpKZGc2i8+dE9q2sRLuH0CfeHXw0+/USNesk+yhtzaF/BZJot/+SlVTWKgdc
	H5DiqeeLDL+HOVgi9WzW2BAj0bb+tjVUETvxkddRqB2CmXxzJEk0iTGoRY5uwaQ6j9voAe6gRR2
	tXvYt2BrOVTQFIFX62Eemk9wc9EaSnhxGBwV37Tgmv90kwAM6fdYp4SWW3BSS+ybvLLNXlmJZWA
	nDVxa0Nnu6rxW7F4VNlqftsQMRRpnCrnQ/BZ14otG5+tJiLMxI3zaulUMNsNZXdAlMTaJ21V44t
	BrmtM4n3QwZL/ZLHh7WwZCLo+FmKNWxZuFUQxoI9ZWPqlVXQj9eGfwmHbg/k2nzLqsH/tA==
X-Google-Smtp-Source: AGHT+IFNqURPkExQYBFmDPeswK4nh3bUgSaRvY4UGxhK0fUOYqkOzIcbD8SkYov3QSAKxzHGDvAzgA==
X-Received: by 2002:a05:6000:4028:b0:3a3:7387:3078 with SMTP id ffacd0b85a97d-3a6d12c2a02mr3718189f8f.4.1750445927007;
        Fri, 20 Jun 2025 11:58:47 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1011fsm2769351f8f.7.2025.06.20.11.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 11:58:46 -0700 (PDT)
Message-ID: <c637fa22-d4ab-4462-9ef8-c04eee4bb27b@gmail.com>
Date: Fri, 20 Jun 2025 21:58:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 06/14] wifi: rtw89: Disable deep power saving for
 USB/SDIO
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Disable deep power saving for USB and SDIO because rtw89_mac_send_rpwm()
is called in atomic context and accessing hardware registers results in
"scheduling while atomic" errors.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Disable deep power saving for SDIO also.
 - Don't disable rtw89_ps_power_mode_change() for USB/SDIO.
 - Disable rtw89_mac_power_mode_change() for USB/SDIO.
 - Call rtw89_ps_power_mode_change_with_hci() only for PCI and call
   rtw89_mac_power_mode_change() for USB/SDIO.
 - Update the commit message.

v3:
 - Disable deep ps from rtw89_update_ps_mode() because it's simpler.
 - Leave rtw89_ps_power_mode_change_with_hci() for later.
 - Update the commit message.
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4026cda04ef6..bc7af6117709 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2871,6 +2871,9 @@ static enum rtw89_ps_mode rtw89_update_ps_mode(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE)
+		return RTW89_PS_MODE_NONE;
+
 	if (rtw89_disable_ps_mode || !chip->ps_mode_supported ||
 	    RTW89_CHK_FW_FEATURE(NO_DEEP_PS, &rtwdev->fw))
 		return RTW89_PS_MODE_NONE;
-- 
2.49.0


