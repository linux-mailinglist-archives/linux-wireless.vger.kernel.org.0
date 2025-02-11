Return-Path: <linux-wireless+bounces-18789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10FBA3188D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 23:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6132D167746
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 22:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F116268FDC;
	Tue, 11 Feb 2025 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFVtncZr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E6268C6F
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312582; cv=none; b=X1Lisdnru2waWZndwT6xVAvMI3PG7mRV2TlCACfMoYJsQRFYPTb9O2+/9A9BzimzmOugp66gNoTDE7fvthKbRg8AJIJrkWx2//aMz+9dfkoILD4jCGbo4QXkdB05XUdlZOEXQkV6NeKgsWQ57sIovkk2aosH1wrx6YzhNfagcUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312582; c=relaxed/simple;
	bh=u+0iscWxOX/frncBLJZD/fTIR1UVTn88WPwh8FDlV1s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TxfI5beQMJvX3AyPyWb1bKSE3bo5DmSEJ3zTMXbkcgDX1GoHkQDibZXa5xIlpRu3cq3Nn6T+PBlcIV/Sv3qnnLG9/GIqFgSuyevxOgQwj3sm/yY/5xE6ljIGuvSU0U0N06zMXUkFlkr5+NnvGTPmZqcxmrpnuAUkKW8OF89hCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFVtncZr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7cc0c1a37so402947466b.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 14:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739312579; x=1739917379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NGDdEz65l/ypbKS6iBlVdY+5xPDO6F9oyP9HxAS0I2A=;
        b=UFVtncZrpqalmB/vmf6pCzwdyQt+fo7rrNTziCnkGxcKyBqgP1Q14rgI5NGRMC4Xym
         YqiuW0edeHARJNFh8tSgukRkA5EuquH8WJ2fl4ofzqjn64GvxWmNrNJgGEl1Zqbdst92
         N8cbQ3GcPp4IbHYh+DbGp77dTMl7WrJprTNtqwExpbVFf/vH3YyDxG3gVJTzmiHM8wkP
         n3oqvEDY1kLYgAQqce4DQSU5Hi20e1waZSpO2MIujxXa52GuoEDjVqWwV+i7/5Mpd/iK
         JqgZ+M1VCWKW08wt6+/Wakwx+uoBQj9mu1IcSffjV14pFHjspDuIV7JVMJsYlKD+5G3U
         BNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312579; x=1739917379;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGDdEz65l/ypbKS6iBlVdY+5xPDO6F9oyP9HxAS0I2A=;
        b=jdXFSqNDooVNU3jurfPYw6tjhIOBtnoy/3cqskUZYt5IMPtOSvV+hVqaVuki7ua9PR
         jsNCOzvdBEpjseKDWNsLH7K5a8drHNWbVjeBMG+uN6g9lwxskd9s5/vCCqosb4V+Ceqe
         p3P9ne5rSajbSXaQW16GxI3xhFj0gqRoICmbRavB0bpIAyg18jJbU9lHX5M7X7SHFspR
         nRlhQPOHaygVARZqI3d/xyQNK3rG7nQxb686qrCi1oSiqW/dTjjvuRbzqwUenk2mDOVw
         1mcCGEi+ilsGOuPJkNOH7BhkQNU8eVDNk0SmBkXA5TPYfa76YaiZMoIYtn8XImNzSbv+
         Sx9g==
X-Gm-Message-State: AOJu0YyLovZrTpWNkGtVsOD28/3jeEalNgeorZJUNP3bC/rek+U1/qNJ
	wPyg7ufuNWnu72lMgW7uIJktbaM4iRfDwjSxgilGxwkldyQJl+bv1s6NRw==
X-Gm-Gg: ASbGncuKE5FbJ1Yk/F2eET2ST/cjhgH1FY5TeKDOMNruoGHVvfl1Qt+6NiyI/2svQ/V
	QjWFwu/oB2fYX7vHOel8JIr2JmfmNZ0D2Kj1xV5yNy98cDf+yPOvx17cO0u7JGtVC0WK/KiLqT0
	nqhEAa2n59W+/3cskJGgljpopf8bTkCNKcgN85c+YtYLY+F1ZmLQoFVi2ifRUXDSy47D8fjZ/LF
	dxCUIeyjtrJCqUWOXGN6j5HwXVrDhBPc6nroPzyb4Xd2hVxhbVTqyfk+Y73sfp2zD8O6h2X8Lw/
	CH8qgPZx6vhXp5i8HNCw1phZ
X-Google-Smtp-Source: AGHT+IHX/n31zZUrNbf89vDg3KXA7pM5VrN6phtjDU9dMCznJs7c0lsivEZVSPRbPdCxTnHmw/vamg==
X-Received: by 2002:a17:907:9719:b0:ab7:e811:de86 with SMTP id a640c23a62f3a-ab7f33a39d3mr51752166b.13.1739312578890;
        Tue, 11 Feb 2025 14:22:58 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7791a4b13sm1092656866b.125.2025.02.11.14.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 14:22:58 -0800 (PST)
Message-ID: <23d28222-8f83-43a8-b312-d5858cf355d8@gmail.com>
Date: Wed, 12 Feb 2025 00:22:57 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Language: en-US
In-Reply-To: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This function translates the rate number reported by the hardware into
something mac80211 can understand. It was ignoring the 3SS and 4SS HT
rates.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index e222d3c01a77..ba02ba72e104 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -101,7 +101,7 @@ void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
 		*nss = 4;
 		*mcs = rate - DESC_RATEVHT4SS_MCS0;
 	} else if (rate >= DESC_RATEMCS0 &&
-		   rate <= DESC_RATEMCS15) {
+		   rate <= DESC_RATEMCS31) {
 		*mcs = rate - DESC_RATEMCS0;
 	}
 }
-- 
2.48.1


