Return-Path: <linux-wireless+bounces-16732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBE9FB02A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E52D16AB43
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0C11F941;
	Mon, 23 Dec 2024 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL6n39uZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A80418622
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964353; cv=none; b=u2t5v0emKJPmbJp4ULRiKzRbZCuUXII93VL7j01qpaOj4zFpXFgXz/kus1Vza/fKc3nRE03ExemI1LcEv5oFoQ31QTUNqQ4HULQQ8esslLX1Wn7pQC9DDcwuWsWRalFd2/v8kBzTQc2AMyFWAPaTeZMgaxG/tC67kmSZRBoE+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964353; c=relaxed/simple;
	bh=honSO1g2qJ85elsKV/S+Uhie2sCmKFhhVOWoyePC74Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sbe4HWseWBvE5J3k9nvbwmY+FQK6AY6nHeiZVSDcT/X+3PIVgJZSC0HDVHPho1TGcFM92HQLGneuSQ8s4j2tHRSpyqR9UMLao2NDNRde1sJ+kE/k5YBJRWR6Iz721XV372dbgSp0gLoJFpkcIZKKL9uU0OMtV8bs+EMQMgnPvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YL6n39uZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso7926212a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 06:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734964350; x=1735569150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqbmweGP4OkjKTS5Z7Bgv0pOh8qhZkH7hrzN1ioiLfs=;
        b=YL6n39uZIoPmH4a/YaWfJQ1HkQLtoplKa+Cu6NbIEd8drfu7N7HCt0TnNmH0uXK0jc
         ED0tOFS4MUmA6f4SRnSxEKkRmhmKqm6fG+JpX5lEo9cCdfC+b39CVBw3OhBeePQjCLeB
         r6E+hudpU9udkgM2bv2lqF6cgtH9ZKIdGq9IgT+cHabF+EMDI5g+7K2YNtm8UCQfCxiR
         e0HacE6ls9/txLV7jJ7v7Aprh3fKzF8FzDHs0Uw5LcUvvi0pQyces3+rf8cwI8Q69PYl
         74nMkE4XWViBvtKlF7Yyt6+a8zZt/mIGmiLhUo8R45Wid31A5ZuQYRTzwKwEPI1tLWp6
         WyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734964350; x=1735569150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqbmweGP4OkjKTS5Z7Bgv0pOh8qhZkH7hrzN1ioiLfs=;
        b=KBtx0+prWB2Sz8yF7XWGFST3EG2FcfCKyoP+neOvlRVf3jC5Jt68Cbywz4m+oqDYFt
         PDKvsdTv+NGzhVAZZgZoSy85+IxzooAfK/CY4SdkVKPh4E83GuBiw0ZK8dXGFCkukiVF
         xE4hq1cstqZRjkjB4nl4B5mcLlvO3gzgQCoqnbOzsY6YefBVTVzGkPLLEHASt1l5lut5
         UOI8yJjWQN+o4A7mdBY4a3IYznaCB9trMMFo8lxIsEnYSuNQJFkXMeLE919ZVZSyvjlc
         08fz1P5jscnuJsu0iHhpQDKMIRp4fe9iK3KX445gNHrw5kuZUl7Mtp77PWGVx/OvemwY
         5ZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxkhiZBEyRXI85/kOG1f+sYokriehplXaph5k/VpYM6nDl/UTIuhzjvzxs93ixkL9hHNo3Ql4R7IYGsBD1Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKS4VMUwyO/ERYvhNBefRJ1LXsz5EjAhVz7zIcYm9ecMsfzvf
	Sr7xkn+Zwsi1ZTAZL/J2gXpMDIBIZjKfE8HTMlBPxBou4epm53O8
X-Gm-Gg: ASbGncv7YywFyYH058MRRhLVAqU46/p4dbo+CUeOfmGzW4y7sr9FMrtvjJT3yFTZcG1
	j9BSyJmgvVdl9LhW9+0/zA+sagRlu/X+r7g9oIYDLN9OgG4PGqb3KuD9iZ7cUDZtM+zYkms6yb1
	h+aCNpIk0tibxaR3fkPRKE2iEfwuPI8ipiRRE1IHdBOZSS+1QbzPN4EHINuMwF5k+YNAO1VdQN7
	AXQCOq8xB9TxwHzm6R7g2VQvf0uoEBUDDLpPjwIn/YzCPihkHxyk29PiR+mHlAf
X-Google-Smtp-Source: AGHT+IE3MoERIFp4sYcmhGUXR4KZlcD2Mns+QpbVkGDAGZsW65LrRdhzusyT8SXYIcW9gwWXl5+Zdw==
X-Received: by 2002:a17:907:968a:b0:aab:f014:fc9a with SMTP id a640c23a62f3a-aac2b383cb3mr992564966b.22.1734964350002;
        Mon, 23 Dec 2024 06:32:30 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4971sm531148366b.107.2024.12.23.06.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 06:32:29 -0800 (PST)
Message-ID: <40530de4-73de-40ef-87d3-66f1da5d3877@gmail.com>
Date: Mon, 23 Dec 2024 16:32:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
References: <146b1077-768a-44f9-86b3-a36814edf92a@gmail.com>
 <99202479-fe1c-4f62-b756-8d5bd818f223@RTEXMBS04.realtek.com.tw>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <99202479-fe1c-4f62-b756-8d5bd818f223@RTEXMBS04.realtek.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2024 10:05, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> 
>> A user reports that the firmware upload consistently fails when it's
>> uploaded in chunks of 128 bytes, but it works when uploaded in chunks
>> of 196 bytes. The official driver uses 196 bytes also.
>>
>> Link: https://github.com/a5a5aa555oo/rtl8xxxu/issues/2
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> Failed to apply patch. Set patchset state to Changes Requested.
> 
> Applying: wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
> error: patch failed: drivers/net/wireless/realtek/rtl8xxxu/8188e.c:1827
> error: drivers/net/wireless/realtek/rtl8xxxu/8188e.c: patch does not apply
> Patch failed at 0001 wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
> 
> ---
> https://github.com/pkshih/rtw.git
> 

Sorry, I will send v2.

