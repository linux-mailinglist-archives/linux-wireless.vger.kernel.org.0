Return-Path: <linux-wireless+bounces-13376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1C998BD0F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 15:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D21C2816FD
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB51EB29;
	Tue,  1 Oct 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY1eZto8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC8637
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788136; cv=none; b=SHbDm2LfHElGY/4eWMZjOBQoLsLYDd274tWYpq4inmWPTQrSZxHFOlRRvCLKe49p4pREpaK4GJmAMPDJsOjAcW55KJEo2ErL4V4v1a3kn1Wv3dMdhwfjMYRVC6fp+UcM79g7drSTjTr2+KaPyVJCiK2NpMU2VnJnEXxqVUEm004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788136; c=relaxed/simple;
	bh=STcIcNa6r6btq5wnKZ1MQtyWLey271rai4FBFqrdQFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jY+facuGenWpLJ3UvYOzvXGsdGA/lN0ssIwDKGKf8FUBpVCTf0HxoohHg2Hrc25LTkeEz+p/s4DBkaMxeVlPCDHUeuSsigaV/kEh7Dn2OD0aq5D3G6nZJtArhLoXQjr6u/xaEvB23JuHcBm2SdJBecpmVUbhalV7B2SmPw/5Fqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY1eZto8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b7259be6fso26606905ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2024 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727788135; x=1728392935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MIGn1om5vsgY+s+l6ME+2I5TMskuBo3dAbFkTRDRS0=;
        b=gY1eZto8hOCIuh0xD1eubr/vBTXOiZ4/O5yoJNZdBXzXT6ydoaEhFJF2pzs5M+YVvX
         DCqcNgMucQhixwZ+keFFob1uthR/bJzqPJhjFHiHlPgZqd6fIuImhxypMNNV9WLE01/g
         YKKKi0IEiOTk13Ea9gQjgM8HMbldS7uAhdyzseGMXu25UPYzmXG26Shmk4UNl63lmkrR
         BZqL/nq7N1tW6bKZnV0Z9ZzWvhNw/p0B3o8MgwTrqMd7H7bwZ2msbfThlgVUDnIqvzsF
         SH1DzTbnefM5bxGZervXhO8ASuftP9pxT2glXNoatdSD01RO5iP7Px3tb/rr6X3AZbad
         ja9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788135; x=1728392935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4MIGn1om5vsgY+s+l6ME+2I5TMskuBo3dAbFkTRDRS0=;
        b=tbXl5O7jOR7KAY59MaPwpPckhQRVBklNorvw2UY/48oTobxKet92Qyr7mX/B21xF0J
         9BW6Dw+J743NTUYGsMF29T9kXUKYpLROT7U0jucdVaMs4CT9OIMyEs7DMKYpeBG45iU2
         mkZcHn4wVGdp2wQp9qf+FWIglikmkGdxnCeg5rbp7TumkMoKqK79lnKz/z9jHgUJGHRE
         6ysEsdIVbKDCpwosRgBAJOcxmpMQoVT79fEHPbkOdBPrewQiF8TmRANcs0G4A6o8WP8F
         SB8S2C0U0eg0Q+Y48MyrTayR6ktpYCxtOOUJi9p+JKH3mqSFbqcpRUjUxqP0Zhxb/VaA
         /DUw==
X-Forwarded-Encrypted: i=1; AJvYcCW3VfrNmFlzu8ZQiGuZ+8XoFXTe3twlj8OUqxmdB9E7BGhtxjZsvgN8jdi6rc+wsBQk0Dpc7vuFg5YA3h26Dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoKq3zwAXdqr1hrKv5tWErxGckzZcTwwHiNdzP63llCcxwBwPk
	e4CcNmNxz3QhpnOMFIoPCIdXaiQE8uG2RtZJ3996LmmRNBO459oW
X-Google-Smtp-Source: AGHT+IFVvxiDfLEcCNjs4eYDnzm0XNEaSWnU8WMrXU+geuN613pFT2w3IwE6EFZ9U0gPSTYF5VvoYQ==
X-Received: by 2002:a17:902:ec81:b0:20b:6145:d0d5 with SMTP id d9443c01a7336-20b6145d23amr161880065ad.10.1727788134473;
        Tue, 01 Oct 2024 06:08:54 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4d6aesm69496715ad.233.2024.10.01.06.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:08:54 -0700 (PDT)
Message-ID: <b8afb2d6-02f6-4b6d-ae63-853225c28eea@gmail.com>
Date: Tue, 1 Oct 2024 06:08:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k/WCN6855 neighbor report request made immediately after
 connection gets no response (with MFP)
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <eb41d8ec-c4f1-474e-a938-099f27aa94e3@gmail.com>
 <fd90d471-503b-4f58-ae11-bae2afab08c7@quicinc.com>
 <0d1dab88-66a0-48c1-bdbe-777d07c3132e@gmail.com>
 <70567137-dfb9-4896-9e6c-6c02a97228cb@quicinc.com>
 <15c909da-f01e-43ee-b486-f9b6d5bcc29c@gmail.com>
 <26302980-4cd8-466a-8de1-4be10a42536a@quicinc.com>
 <f65b609c-0813-414b-885d-24257e76e6d0@gmail.com>
 <564bb38f-aef1-4981-b706-926eef5c6776@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <564bb38f-aef1-4981-b706-926eef5c6776@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/28/24 7:16 PM, Baochen Qiang wrote:
>
> On 9/27/2024 7:53 PM, James Prestwood wrote:
>>> here is the sequence I saw in sniffer:
>>> #1 AP send M3
>>> #2 station send 'neighbor report request' without encryption, though 'protected' flag is set
>>> #3 station send out M4
>>>
>>> is this the same with what you saw?
>> When I was able to capture the neighbor report request (rarely) it was after M4, not before. If you're seeing it prior to M4 that seems strange, unless the kernel/ath11k is doing some odd queuing?
> yeah... firmware has some odd assumption on the sequence of key install, causing such behavior.
>
Do you think maybe this has something to do with it? Its just a timing 
issue (both in my case and when you see it before M4) and in some cases 
the keys aren't fully installed and the request either gets dropped or 
just isn't encrypted correctly?

Like I said originally, its not like this issue is severe, we can just 
request a neighbor report later and that does work. It was just an 
observation and didn't seem right.

Thanks,

James


