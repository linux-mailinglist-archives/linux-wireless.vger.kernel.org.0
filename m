Return-Path: <linux-wireless+bounces-12256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B96965F22
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270C31C247AE
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 10:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E305417B508;
	Fri, 30 Aug 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5Q8yAg/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35285188CA4
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013641; cv=none; b=mu/aV/AjfCw0FThN9Lo/wWf/1pujhYmJYkBUwzjGP2wc2Yg76+fIWZVoV/j1OaSKMYWm4mtaJQWz57RCJIP28U50aXOMDM9+FtX5dDcR089NT4lbsgWzVEgV2UV0uiFtR/UzMgaMJbmbA+9pcU3vHgQ52LI/bKJY1J4+A8rzKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013641; c=relaxed/simple;
	bh=UY42cwQRNN7a0YU2+GOEQrST6Gq2ZXu34SLh1MtfqiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSSYpS0yw42mj7wGW+ULtiJ7ambbDJDIbZNT9A2DdxyF6soHpeZOHukDdloq+fLl2Mv+5n0wC6XOxII2ywS9NNcHae8QZ2zLaPC888EXcQMV8JrGvDKDZyrXml9EuOzLsmkzhCPJqQzzt+toViemR/Z7Ufhy5x3tbq5PItlKFME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5Q8yAg/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374b686d62dso135303f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725013638; x=1725618438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xl7XLL8qbXk23Z7LYPXUEAMJKJhYJ9383SkrnwRRP4w=;
        b=B5Q8yAg/zZMDzZVW7kV7v4kNgjYRUt3vhToAmOfU2LnPq/zXjqRaAEO/WBePrsdh40
         Y9Hdq1xRYo6ZI2tpwVKcUrPy9Pk4qoIUMlXHB/dMAsm6adD7b26m7fFxV0b5+LUGvnZu
         llGeCBMPfdXJmlwwklBz2z8XXhI0NzFjwZW3NmJGC0c/tKBM936mFFK8RGNSgSTZY1cN
         XX0HSwqMmvuBiKXFFdjUkspeQzzJ/t4fEUH1vOnpJe/kqG1FiZlFn+Ab1KIk/56C+6eJ
         lwGpCMmRGBQoAW62zVduPl9JnteXg7zP+LdyjBItaLbz68y1c7tVd1PDzpnO/tWX0Gs6
         6PGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725013638; x=1725618438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl7XLL8qbXk23Z7LYPXUEAMJKJhYJ9383SkrnwRRP4w=;
        b=sImNwVnHrXmItGlbCu3N0JDnjDoP9JLcGiulPff/raWTK9Un1RRrHidMUK6QFPxNUF
         a7uTv6Tps2yFPuDzu1/BsgaX2SBoO55d0GEm6TVGudNimkdQulnADP0pElwF2FqXJbBV
         60vjTk/MkwgmCEvf9YTELljjB/FMg89l7vLBDYA+IaE5EwfhljRfO9eCpwkIlGo2BE/Y
         v62EmrrTU7E5kqBYIRIbbmMTFKwNo3qJEqxyDAb/dqzMwlFryA7rdac2d/MI8XYMQ7ro
         3AnLD0GLIK8SNizOei2JB8POEVOEQ1lQcNdqarXYqwJ7M/MhBnQ7nb8LkpBBQyv6bFNS
         2duQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTmgytZZ6gfEOsZPS3S2AnahqgUoa8/hSr5wLTzFt0nblTdPSSfhJdcLORFEOI56fHsEjSwbd4cs5xh6fvDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJjGUNfqipUGpIy5x8ufluFrYmMNdhu4TrQG4+CdLDToKkZ73V
	SaKK2cyJx1clKfWqNmV9W3R3vDogMn7OoOK9+GTdRRBAMpFkzO6rNXs5eQ==
X-Google-Smtp-Source: AGHT+IHHt2dB47Xto7Gk3TBG5WctowItNDj2ZMLyu8O5qVbl1euHoFh21yU5QLbdIjpOYNYTyFhgdQ==
X-Received: by 2002:a5d:4bcb:0:b0:368:4bc0:9211 with SMTP id ffacd0b85a97d-3749b557c04mr3934330f8f.17.1725013637817;
        Fri, 30 Aug 2024 03:27:17 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e274c1sm41851355e9.36.2024.08.30.03.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 03:27:16 -0700 (PDT)
Message-ID: <3f49c25c-d99f-4be6-bc35-f94b76c5f5aa@gmail.com>
Date: Fri, 30 Aug 2024 13:27:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: rtw88: Fix USB/SDIO devices not transmitting
 beacons
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <49de73b5-698f-4865-ab63-100e28dfc4a1@gmail.com>
 <1b09a87e86a344c299fe83fc38a9e323@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <1b09a87e86a344c299fe83fc38a9e323@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/08/2024 03:30, Ping-Ke Shih wrote:
> Hi Bitterblue, 
> 
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> All USB devices supported by rtw88 have the same problem: they don't
>> transmit beacons in AP mode. (Some?) SDIO devices are also affected.
>> The cause appears to be clearing BIT_EN_BCNQ_DL of REG_FWHW_TXQ_CTRL
>> before uploading the beacon reserved page, so don't clear the bit for
>> USB and SDIO devices.
>>
>> Tested with RTL8811CU and RTL8723DU.
>>
>> Cc: <stable@vger.kernel.org> # 6.6.x
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Can I say two below patchset are equivalent in your side?
> 
> [Patchset 1: your v1]
> 13744097 New          [1/2] wifi: rtw88: Fix USB devices not transmitting beacons
> 13744098 New          [2/2] wifi: rtw88: Avoid using macid 0 in AP mode
> 
> [Patchset 2: your v2 + mine]
> 13771597 New          [v2] wifi: rtw88: Fix USB/SDIO devices not transmitting beacons
> 13767746 New          wifi: rtw88: assign mac_id for vif/sta and update to TX desc
> 
> If this can make AP mode on USB devices step forward, I will merge them ahead.  
> 

Yes, patchset 2 works for me.

