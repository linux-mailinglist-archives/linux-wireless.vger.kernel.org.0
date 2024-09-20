Return-Path: <linux-wireless+bounces-13054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A2C97D5A4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAA1280CA7
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E21514DA;
	Fri, 20 Sep 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEwDveRM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F014F9D9
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836296; cv=none; b=QWgCyKFo8KS+Sl0/IhWDcJQD4RmZ/1+g35N/YW/3aL8iZLfQwhfw0lNEoE59MFYkO4pjkP0iQJ3164HYD28kOokwKnEaACxbeJgB+Q1xG532HrlJKLqkGYKAvE/PZOjbh17OPhfAwAoB8xzvCcIagE/a99RPm0FseO+ZQ+lZqao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836296; c=relaxed/simple;
	bh=cl5HxYihvTHMnRR1Qajd6WQjEFrLPxp6/Koau8koHHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jSniK4s7cgTIcM5OMrOh7o4zjLoO4Buv0l3WA3kl4xDz/5pfaB0MKcPjz2vnssbx6lL4bJ6qT/kFShFn6Vl4D7WNa6SSjFgFH9foSmYrVhi7O7uPTrB7aSoJ9e9lBOnHMYVcKKB7K3jgvCc7DDIcJLtVf3twQ3EoFaxfWiE9QYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEwDveRM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so16815285e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726836293; x=1727441093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dnfEX5CV40feFY5JpnkcEd582X0LveuhJZSl5Y+eYf8=;
        b=BEwDveRM4zjga0BSLVbzlYvYQGqebaj3Pz/SBXCjhqvPq+Z0ts5zMl7OFj1Kc4L82x
         2JzIcxrTDYuzBcBIkaPCug/Jwzvam2RUUazQwPbUsEedYWr009LD2o+bRdpg1i4GaziI
         83Nh1+r0zuuEGANE9vlsbb7KN9oNHGEkns1nbkX2+6ckBb0R2Ig/KmmxlTeD2FR9M2CC
         BPGL9SXUYHTw0hV5WYB0JqqbSx36gfIzHOlZsYcQ9k4mqtho5zbJCD5Sloy3wW1+0euY
         pG8DgWXn9k5hEdGfH5T8yg5mryXfrzQ/JB/YT9iRfcfQTzTJLuLeMFsOu1B0Y93FnI76
         f0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836293; x=1727441093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnfEX5CV40feFY5JpnkcEd582X0LveuhJZSl5Y+eYf8=;
        b=ozp+icBpzocpeap4kJRPhhmQY628cirF6YmbYcval9RoWwJv4aZrv0BGkKYURSfW2F
         SZ4IhqaB7uMuKWrkyuPDBCV9IOtKZ4TkJM3vGu6hVHXLWXGLupHMaagH21Id/H23c4W0
         uE+lE9ZRqQbTTGGMJvozKASynbZgsi4xLDbd6Fgy9tJQ/zBe18oOAqa5gBUhtVh2N++E
         gasHYwbADm7H9a3F5O+7RKcWETMTOy/MbgYUoY0jhdT1P976Id/yGESjMY+fbQNW0U2/
         D80K1GMYz6PNj/tCkUnvCobuX/+/2HcKYyW958/LtlR+pWQAAk8CBMbDxM5nGMP5q721
         4Zyg==
X-Forwarded-Encrypted: i=1; AJvYcCWteWpARpMhdj/4Oy46agme33cu7jIrU7nM/29kpZ1oJrwlRU+jinzhQnCLg7vFjot3VbV2flaZc07EF2PXsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIw0jt+zVBFxMl3KOFRD6of2tpUu9KpOlidFI29fIfGQzASAK
	WXRNwIGwKJEnLliYGsVtrknNgivOCViPgut9E0eP+WE2wSFvbj+7
X-Google-Smtp-Source: AGHT+IGW7mhydODS76OjipDx2sunxFo0s1+ipWmoPYekJoTzjxs4MSyEdliGl7w+bBSUgNnS1Qsksg==
X-Received: by 2002:a05:6000:18ad:b0:371:9121:5642 with SMTP id ffacd0b85a97d-37a422bf182mr1953981f8f.30.1726836293267;
        Fri, 20 Sep 2024 05:44:53 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7543b0f9sm48821855e9.14.2024.09.20.05.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 05:44:52 -0700 (PDT)
Message-ID: <052fd3f6-8c0d-4195-9f2a-cf3c87fcabe3@gmail.com>
Date: Fri, 20 Sep 2024 15:44:50 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: rtw88: Parse the RX descriptor with a single
 function
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <dae7994f-3491-40de-b537-ebf68df084bb@gmail.com>
 <6efd784f-d07f-42c2-a84f-4beba2db25dc@gmail.com>
 <47452b48615a4c4699ac86ccf2ab1a19@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <47452b48615a4c4699ac86ccf2ab1a19@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/09/2024 05:21, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> rtw8703b_query_rx_desc(), rtw8723d_query_rx_desc(),
>> rtw8821c_query_rx_desc(), rtw8822b_query_rx_desc(), and
>> rtw8822c_query_rx_desc() are almost identical, so replace them all with
>> a single function, rtw_rx_query_rx_desc().
>>
>> Also, access the RX descriptor using a struct with __le32 members and
>> le32_get_bits().
> 
> I have tested this patch with RTL8723DE and RTL8822CE, and looks good.
> Please also describe which chips you tested. 
> 
> [...]
> 
>> -
>> -       pkt_stat->drv_info_sz *= RX_DRV_INFO_SZ_UNIT_8703B;
> 
> For now, RX_DRV_INFO_SZ_UNIT_8703B isn't used anymore. We can remove it.
> 
> [...]
> 
>> +       .query_phy_status       = query_phy_status,
> 
> All existing chips use the same callback. Will it be different for coming chips?
> 

Yes, it will be different for the upcoming chips. (The existing
chips also use different code, only the function name is the same.)

> [...]
> 
>> +
>> +void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc8,
> 
> If you use 'void *' as type of rx_desc8, we can avoid most casting. 
> 
> 
>> +                         struct rtw_rx_pkt_stat *pkt_stat,
>> +                         struct ieee80211_rx_status *rx_status)
>> +{
>> +       struct rtw_rx_desc *rx_desc = (struct rtw_rx_desc *)rx_desc8;
> 
> like here. 
> 
>> +
>> +       phy_status = rx_desc8 + desc_sz + pkt_stat->shift;
>> +       hdr = (struct ieee80211_hdr *)(phy_status + pkt_stat->drv_info_sz);
> 
> and here.
> 
> 
> 


