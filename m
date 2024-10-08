Return-Path: <linux-wireless+bounces-13726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E0699563C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 20:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705BA28B58F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 18:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E85212642;
	Tue,  8 Oct 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfY7+Po7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804821263E
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411171; cv=none; b=QjnBgMQYmngDHYZqmNS0p9OIqa6DISMzjxqd633jYFQWkrEyoKD4j5a+6aZnIM9Z35lcOPD+HEf7vyH9uD0L1kolCVKaawZqbTeMmsP3EzRXONz9TdccM3QNGc+1P78Pr81JJRrKrtKZqbO41YcNyKarPFrlhvHRW/cBKfI2HWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411171; c=relaxed/simple;
	bh=q1B98cCZ67Fnkh/XQ2VC6+w5nCSr6WHrprubAeMB/5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kH+q05Ywcg1jhdoPJAhtXuz6eWam/V9Mo7ejAEPn1iQ7iE4NYLHYjiP1tvDxp1kN6X5bvC15+qEikVOUSAIDUbwIzVq2ef4JYRmtdStFLNL2zBZG0LRwpPWUDbJtq+jshcPTzDI3/jZBzPj8hsTfbExenH53m4/uEI+V9lRYc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfY7+Po7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42e5e758093so52570915e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2024 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728411168; x=1729015968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuFA5j3K6m3lSSbRwdOiQAd6W6LANH+t9PO0kqru65Y=;
        b=dfY7+Po7V7t5a6jwC7+aKxWhRh6SmkPjaT91zjEKCuivUUTAmHryYN2urzdsvYP5CV
         W2uLiFz9EU+OW8WMlO4yoX8YvuBTcquQMgrSfNjMfd3ieWWQ5K9Vk8xtWz9kMGj+fv//
         4sN1cbJpHtn3/OvAZeONKEGfXsWG7DbPs9gifv/oc/4qf4bm737IWwAHUfidKwqVAZbJ
         02zT+ZDhMHqlqnGalUHSNQ73cx/EV/GK8bs/wO3m3jQX2N0rzgJ7yjTL/yT7LqdeFvrG
         5t08QMUZ+LqQ1TvE4R5ggU+dVrc9f1tKElfXZUVXu0AbFWnbbGtTHUbQ6d86wOI2Zmvh
         B2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411168; x=1729015968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuFA5j3K6m3lSSbRwdOiQAd6W6LANH+t9PO0kqru65Y=;
        b=LUYP9TmNwcRnIGSdqXWmuwm7SeQnc/eG9iKuD/K51hwePRh1CmIMqoO8mNLpZRB9iD
         kwrDlSGk3K5ckpxYyFecg5UMv+EHTyxOsiL72hkpef+/tOY109wqu91ho2ZVeWUKxjYH
         394/of8RLhnmxFD1zmUlQl8S5XdiY4wfnkjXwUOW3ZNV6nzzOEQ6uYJMgAUw7TrSxPm3
         be0ULD5hSjy3xSzMkqH5LIZ453/th+6/LkGxtSKU6hz1w0gXzQPm2jM4UmhbErNOuy6b
         j9CNZTVWUGqrcFF1QvPZBqGnaV94li5xI2xDxcGvq3WjCB6i0wn/RD4UHPRkherTXJPX
         HBWg==
X-Gm-Message-State: AOJu0Yw6slrzv0YSG4cMZODe0UUuRvY/SROKrb2sfMc3DWcMFQPyQ0nr
	ZuF0hd7JXNJotItaTBMEeIrVADyjrRzWfJZK3A4HDBSUD2RuJmTZ
X-Google-Smtp-Source: AGHT+IHAhQsN8E22JqPe31C5J5hHO4ciK1+XEy/v2gYO5OeltEasJGb6wY0dvfpOFiUkyuoIWRFOkw==
X-Received: by 2002:a05:600c:4711:b0:42c:d7da:737b with SMTP id 5b1f17b1804b1-42f85ab3accmr125546075e9.9.1728411167824;
        Tue, 08 Oct 2024 11:12:47 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed952asm116343845e9.45.2024.10.08.11.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 11:12:47 -0700 (PDT)
Message-ID: <7855de70-1942-4cbf-bafd-d19e148b7e8b@gmail.com>
Date: Tue, 8 Oct 2024 20:12:46 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] staging: rtl8192e: delete the driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
 Johannes Berg <johannes.berg@intel.com>
References: <20241007182706.66888-8-johannes@sipsolutions.net>
 <20241007202707.d0e59cdd2cdc.I8e4d74a6e1d09eefe1f5e2e208735ba2ccef1d4f@changeid>
 <2024100825-badly-smartness-cf1b@gregkh>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <2024100825-badly-smartness-cf1b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 08:42, Greg Kroah-Hartman wrote:
> On Mon, Oct 07, 2024 at 08:26:54PM +0200, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> This driver is using lib80211 and any driver that plans to ever
>> leave staging should never have done that, so remove the driver
>> to enable cleaning up lib80211 into libipw inside the old Intel
>> drivers.
>>
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 

Hi,

thanks for the explanations. I am fine to remove the driver.

It would be good if the maintainer would find the time to update the 
git, so that we see which patches are accepted and who has to rebase or 
change his patches. Due to merge window 3,5 weeks have passed and I have 
lost overview.

Thanks for your support.

Bye Philipp

