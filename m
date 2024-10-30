Return-Path: <linux-wireless+bounces-14734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8FE9B63D0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 14:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3395B1F219B2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8420E1EABA0;
	Wed, 30 Oct 2024 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU62l/wz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6551C1D1E7A
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294076; cv=none; b=iME9SkUo7W1fFhWVbzTCstEVM1U37gZ+Lvw9bBys4OY/CaiH5IC4DOAC052HPEz5SsLymN0xsZQRC9zoxcNeCA5Ua+8fwxvoax5wfkoIeeSxXZddp2ejFlZwHcWvUP2iIulbM3yQSCEFGUyDzwXl0Q1GrQD1RkmmXlAamTBo4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294076; c=relaxed/simple;
	bh=5/fxIJrUykTtDRzf0tcSwxs2fdhS7Jf90SjXZPD0USM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mOYCXE058DrSYW647PEIy2W1YLQPUXNNtf/KIcET8mEi5lBvzwTZWZ+sR8sJJhkIvHTqNqraRECV22l9Z/wPuvJ9jOgwaAUTVGSHBnWfaGVNcHXj8KZSyUgY5s1mm/vACT9H5ayRt7QIixv2BB2p2N6XwKd36GSRHtTUHskzaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU62l/wz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f58c68c5so11030045e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294072; x=1730898872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6GUQc42A4VnqEiRxw8lXuvKP02Hpdh/IezW9cz3O3OA=;
        b=BU62l/wzN6v2HC5BScv/p0CkE859pO7Xo6oQC6SL7WMhjOt83pz4EKzrsD1tA4LfBs
         nLZosXxrPrsQxIiJq+gJAu15NPJw9eEzoY/WF2MLRtGCL6gYrOBKWXsUUi8xWPENCBJJ
         lQ34H2+CAMRDOyKn2DipUF/uhdH18pYuyuMXMlh80z6HNUglFRGxcQ01QNQy+W9W+Mdj
         xjPq2jpgKUa+CXW1MNt5iWciQBEHlI20F6IppIwDZl2dgdpBjzlEewRITxYx3ullWRb5
         +M5/D4mptaaYn4pKF/Ab4cEciEy2EpM3yZ5c2jNclLK/DBoYZYTKwNEzuWmaTuBOVYvk
         UdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294072; x=1730898872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GUQc42A4VnqEiRxw8lXuvKP02Hpdh/IezW9cz3O3OA=;
        b=O2Vmi5W6S+eBgY7STIibsPp22mf2G5RLf0W3VwYFEfW8X4Kn1LHo8IioTBDGCWn5OO
         GQoSybTNJYHq4awXpcFxaIo+3XITVXUSdTukNz5438g5NGl9/FT6TrpoGdAuQMtLg87R
         M70oF66AjWpFSyV6UwSnTG5JTrIdI7Gzh/kR1We/3JkCmQ8ElrGmWKY92uBGK1xAYxGg
         rH8E7gqEywSpHqHr7rkd5busdg/Y6dIoHHMHlmgZZNIkNAWATJ1MhIC1+2wz0SiHwYji
         LlCTQkP7iPUihntKdADNy9fbZCOwJDEjYklIZgUyS11xeoJZGUjMy+EnGL/ez+HYG83w
         1r/w==
X-Forwarded-Encrypted: i=1; AJvYcCXOy0KR1trsClQEXbc6V0UYN07hYPFiUit+5Ys7pvkuCisO0IiaiG1BHPP2iBCekCNIA61VzhJEIa2BlNT/Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9zD3pS2x3HClGJJxCAXeU/ZT/nKg81cxgW1sM11rEsaM6v5S
	PCKObj27TximVl3dtz9gZFe8AUHNr+Jlo1yYByLlfxib7cqZtS8rY7H7iA==
X-Google-Smtp-Source: AGHT+IGshx3dephbOdobVDL8xyk/u2krlIze/Lb3pdllyDZuZ3/K/TdgV89H6QLw6gv0rN42EwW/rQ==
X-Received: by 2002:a05:6512:a92:b0:536:53e3:feae with SMTP id 2adb3069b0e04-53b348ba12cmr12581979e87.11.1730294072168;
        Wed, 30 Oct 2024 06:14:32 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f029874sm571644766b.79.2024.10.30.06.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 06:14:31 -0700 (PDT)
Message-ID: <d6995456-0997-4606-b5c7-63a0da412593@gmail.com>
Date: Wed, 30 Oct 2024 15:14:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/22] wifi: rtw88: Add some definitions for
 RTL8821AU/RTL8812AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
 <9279a9cd-6f86-4dc3-a095-7c36cb9b9d06@gmail.com>
 <808c66fa-60a2-4878-b1f8-65d064735692@RTEXMBS04.realtek.com.tw>
 <207adc8d-06db-46cf-a87b-6dc2a1efd6d0@gmail.com>
 <092a85f224a3459baa6f86da653179c1@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <092a85f224a3459baa6f86da653179c1@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 04:54, Ping-Ke Shih wrote:
>>>
>>> Smatch warns
>>>
>>>   drivers/net/wireless/realtek/rtw88/rtw8812a.c:619 rtw8812a_iqk() error: uninitialized symbol
>> 'tx_x1'.
>>>   drivers/net/wireless/realtek/rtw88/rtw8812a.c:621 rtw8812a_iqk() error: uninitialized symbol
>> 'tx_y1'.
>>>
>>
>> These are false positives. The variables are initialised inside
>> rtw88xxa_iqk_finish(). But I'll initialise them when they are
>> declared.
> 
> I see, but the setting under conditions. 
> 
> By the way, tx_x0 and tx_y0 are very similar pattern, but smatch doesn't 
> warn them. Please run smatch again after you fix tx_x1/tx_y1.
> 
> 

Yes, I expect it to complain about all those eight variables,
but it doesn't, even after I fixed tx_x1 and tx_y1. But I initialised
them all just in case.

