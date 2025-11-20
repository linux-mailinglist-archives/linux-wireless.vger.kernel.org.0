Return-Path: <linux-wireless+bounces-29166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 732C0C7472A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BBBBD28D4B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619C73376AC;
	Thu, 20 Nov 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhkxRduW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86EF289374
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647713; cv=none; b=oiomkMh1d7y221NtpEXczLT7QNfqzPgxoWaG/KH1Qct3jItnIxoyjZiGW/QhTeU35CyeTRDzFUWLR7yfBNJI8G/m3ECbrrCaAMU+gF/Ui95UhWnFvl7qmTqmL2eD37Z9SzttFr3dHwPkm63oUdy2yTWuAANUXyDlGQEPOnCqYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647713; c=relaxed/simple;
	bh=e3DzCpjY89lTjvHu7rbQadhAF1LGwALXBSU+OnSLgDw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Pn9DZaJ8oUncQ/2fIql/m8rbf9Pgjdb5y8J5XjJ9RAKKcGVEzCoiJFlxYtRwhgGKY92lhohsaQfpo6BWv/6CFJ1uBVgyXS8TzEzTmaLoF/VqyIxrGbO8eijzloV6rpIiOf/jkfiMZBfilgbqWIG8YhqDAcMisxTvRqWNqVrDiZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhkxRduW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso750242f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 06:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763647710; x=1764252510; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO5QXev6+2NqrkqwY5n8OLQMXZZXnt7yZUTvj5d56JI=;
        b=AhkxRduWSZ8vE12FgZBkvo+7FEP0RNqd/Z1Li8Qoy8z7dQcZ/Z4VLb5qdsOt63aMJ8
         cKgial+5L+1HJCJkHKLH+JzCsf0R73ZY2ccmNrFMbKvAfYneHCSrfxg8e4IM4wFIgkmt
         v0H5n5ueFIdYqD+Te7kG5Xk+xs5x7j7TVmdddQqffxJZI3C+QmI8BOyXznBNtDH5wY0W
         Tyfz5TDMZLk4roqHdvqoTdtHdoMO/72c5GfAuL+WGr6Vm3P5g0K5JJJFbYUXK2FafoUu
         GAFYTqla72s/Ho7BihJfbT7W4zVl2DEu7nAq6VmWq0A22Rv+oCFxRb1vHesEwKMd9VF0
         ZmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763647710; x=1764252510;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mO5QXev6+2NqrkqwY5n8OLQMXZZXnt7yZUTvj5d56JI=;
        b=IqCVuHKzDiOeUE9ArFfDAVnihczx6dboiOmERkh3T8BPr9YFgwZfjtphZCtZ1o23rY
         RwZcnwTzF1uNDqYyqLkI2gL+iFLbyWjAoVL1ZwEdt0RxEGY/tYtVeC+UkWz8WduuwZ9G
         hKm3bqmjOkPPP93zOS//goGghWxsLTelM6ptLvjR3DDvT80gi0nkZBlyipfJPhNqaGsh
         Bi0XniVjHwx2B/DDGGXtDf6NI0LkZ0zXyB/XiN0z6nqo09LmLq1If8ujCLZD9vZYPA6B
         VYTThTH5X40f7ZqTxZk2dGGtojm8V39C+dRHNGI8+4oZEJKDVoIVy3zt8FWeJL10hvY2
         +jRQ==
X-Gm-Message-State: AOJu0YyrFR2jZFAzbwDZFAN1iC5TOQmzRuoF8lnt8vu8KWPA5FkxLF4n
	iH4fiuWFdWa/Xfw+XrecaJ8GFNtywJY3tXfYbGF+NjVhO+fpPyTt32poxR2/XA==
X-Gm-Gg: ASbGnctz4YQ6qRQ2I56Rh0kRq8iGxTwA4l0m3oJYQ+e+anav11YvUDRFgSQgcL7inKy
	MADDkXlTFLOCBx+GppYlbkVpATf5s9YP1sXioqhFzr1b0CiE0wXCrJm5Pg0OX9AKnUokpuS5Acu
	OD7sTZAIoFj0yFC0zD2wfKjFSVr+t9sKZqjqcI/9QrRr/m7XBqnowykFA1QDlFxYiLTKId+ZElu
	QJI9FKrhOyxuHrksUfcH6c/xVMAzFzjLAZ7CvEzcYyuR6a6TXSXKhRmON+YyYx4yYRcNR8SRt8q
	BoVYieozL/KaQnI/N9RmpJeHwtWYwv5ZW4N81cXExzUJqqzS1qcFTsh3NGqcnHZ4wnAS+O8z4UD
	WcHXvkU1zKS7PKZtETEWdxBocJc/EdIVUm75Vv2O0IizQ8PB3Jq5q579c1mkuqZg9+JReTsMINc
	B1PL8rrM3Qoxhk3FR1trQ=
X-Google-Smtp-Source: AGHT+IG5UyiMI9sFj4lDqju5+e/RAX0Iik73CNwVEngvqxAuF/J3EPq90+Y2c/g7yYS3fSxltNDVWw==
X-Received: by 2002:a5d:5f93:0:b0:42b:3e60:18cd with SMTP id ffacd0b85a97d-42cb9801060mr3198393f8f.11.1763647709768;
        Thu, 20 Nov 2025 06:08:29 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm5621715f8f.32.2025.11.20.06.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:08:29 -0800 (PST)
Message-ID: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
Date: Thu, 20 Nov 2025 16:08:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next v2 0/5] wifi: rtl8xxxu: 40 MHz fixes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All the chips should work with 40 MHz width now.

v2:
 - Patch 4/5:
   - Compare rxmcs with the legacy OFDM rates for better clarity.

Bitterblue Smith (5):
  wifi: rtl8xxxu: Fix HT40 channel config for RTL8192CU, RTL8723AU
  wifi: rtl8xxxu: Make RTL8192CU, RTL8723AU TX with 40 MHz width
  wifi: rtl8xxxu: Fix the 40 MHz subchannel for RTL8192EU, RTL8723BU
  wifi: rtl8xxxu: Fix RX channel width reported by RTL8192FU
  wifi: rtl8xxxu: Enable 40 MHz width by default

 drivers/net/wireless/realtek/rtl8xxxu/core.c | 52 ++++++++++++--------
 1 file changed, 31 insertions(+), 21 deletions(-)

-- 
2.51.1


