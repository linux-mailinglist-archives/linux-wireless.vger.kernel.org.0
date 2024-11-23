Return-Path: <linux-wireless+bounces-15618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA619D6885
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Nov 2024 10:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD24161212
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Nov 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BB516FF44;
	Sat, 23 Nov 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ajaYIf4F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031915FD01
	for <linux-wireless@vger.kernel.org>; Sat, 23 Nov 2024 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732355692; cv=none; b=jQfCGcCsu+u4j950l+rRb0uQSUtFcxX1wAg2gbcjfg1kuF7Zy+CmpF9Gab75LtPAE7PLROfKM1nbqrN5+ThdsrHBeMqpl5NsL44pm/fFTnLinOjavGING+coQycqf7eTdqnuxqMTtBZbJdNmIYoX+7eYn2Npw22qE/zzk9imfcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732355692; c=relaxed/simple;
	bh=0xeKW3wJPpF2PUd0ri5LXoi13kAp2hX49JxJZYu9dKo=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=REin669G3+z54FVT2zCUp/APX2KqLKpZkr+0hCN5KuYVFjpCgLqNCGVpiS5e9yKTUQNN5dN1OYlPPhLND0M9T8NLX8HR85af80eERtd6UkxKrFKu8zh211GgmLhdWXqvsdVrbHHENwHK8ajL1i3/HBRzi8gRz/ukydapXxAN8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ajaYIf4F; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso483387966b.1
        for <linux-wireless@vger.kernel.org>; Sat, 23 Nov 2024 01:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732355689; x=1732960489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jskvo10CVA4Da00nnFjYPJVsVIavc3tS0OmXyKuBx5o=;
        b=ajaYIf4FP2rou0UCRS5mgzmZ8ZNCLw15yDEXTp1aouJUKRCYbymSTwxeMDGFxKEv5O
         F7BCrYkPo6l1DfpcO5Wu17ptGRpmdgOj2xuY78XaHglw4pfzpWZeZKLcu5/QYCiNDQLz
         ugHzAqcrRRgmnSpF38OCDDcKPR0Mva/OiGf0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732355689; x=1732960489;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jskvo10CVA4Da00nnFjYPJVsVIavc3tS0OmXyKuBx5o=;
        b=wci7MjENPiKe5mOP2xukERZKWifkvyyBAhgWgKrZFPnMtt8Eu2qAoMo/8/CUURxlPl
         NhlsiaIqNp5yQ0Ffgc9ALW9kom9XAh6sSpfwXUPyPj46dZibNyg1bXk17Jap8MdQPsiO
         LpKnd0+XQp5HpKPgDlTYEt5XSzex1BHbbx7MI2me0xEW2nUfNvXdpLu7qRjgd/yg3ZG9
         CjQ5daYkVqv5/gQYsh2NnAd4wdch3qSGL/mhrzyHusZSny8gbX6eH5maDJYyXw6vMbpY
         Ft1FOI7TgbtY3JSEvwbuvIY3rYGPiBbRLpsk2pNe6c4JOpRMf7qfEcvvn02nwpQ/lbhL
         CN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWE9Ld0aDIcWXcv9lFSHyEtB2qHH57s+v/11vaq+CbeUtuHpkUgRCt85OQZ09DcNMLom8sYHPQnd8Kqm91RfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQs6eZO2/sX+hb5XmnCNBjO7qvgBLTPJGaQ0uk6rfwDW88CfGl
	UQYnz08FbO4QPPt2sKprEZF9rQazM+9nyQXs5YQ+cJ/qLj6j/ZbbjPWJDubnsA==
X-Gm-Gg: ASbGncsV+NriJ8DbtZM02Q/mdRZ0DtjRmAJH/4XLLs8s6uE0P5/w0keKgoBL1nWnvKa
	RKG496K2IkHAYWB49F0JZTyn4Xiz1dGvxv/U+8quP8jtP1fu7fhsLmd57FHvYRIMDc0mZgeTB//
	2eCrWzFbtufvYZGgfJRtg5XeWx+B939HlgRLhD6A3Lo5kRDwu2uuRt5gawUwNHYR1bbs7iwwAQd
	fZrjFzHdjyCu/qFN6zvfbeJz/e4V0gQzJewjrkHFDvRPrU4ch1tliqSm9ZAVyxVAoRncV1MuZZh
	m3z1wuDrq+5/
X-Google-Smtp-Source: AGHT+IHluXPF/pYOS9YSUAOtKPUEudAL91vxuW77YbTnFsV0ymaS3yEhun2Xd02I9CAKgcZ5feUfkg==
X-Received: by 2002:a17:906:310b:b0:aa5:2237:67af with SMTP id a640c23a62f3a-aa522376878mr236531766b.9.1732355688946;
        Sat, 23 Nov 2024 01:54:48 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28ddeesm206271866b.27.2024.11.23.01.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 01:54:48 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>, <johannes@sipsolutions.net>
CC: <SHA-cyfmac-dev-list@infineon.com>, <aspriel@gmail.com>, <brcm80211-dev-list.pdl@broadcom.com>, <franky.lin@broadcom.com>, <hante.meuleman@broadcom.com>, <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <marcan@marcan.st>, <wahrenst@gmx.net>
Date: Sat, 23 Nov 2024 10:54:49 +0100
Message-ID: <19358720a28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20241120091729.57361-1-renjaya.zenta@formulatrix.com>
References: <1268ad6f22b61f1c9b3c7e20c45c1a0050aa3631.camel@sipsolutions.net>
 <20241120091729.57361-1-renjaya.zenta@formulatrix.com>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail, reason -52 - Part 2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On November 20, 2024 10:17:35 AM Renjaya Raga Zenta 
<renjaya.zenta@formulatrix.com> wrote:

> Hi,
>
> I've been observing this issue for a couple of days. I added pr_err (before 
> and after) to debug this to find the culprit
> who change the flags from 0x0001 to 0x80020. Please see below. I used 
> Raspberry Pi 5 with kernel 6.6.51.

This was reported earlier by Stefan Wahren, but the thread ran dry.

So what changed a couple of days ago? System upgrade?

Regards,
Arend



