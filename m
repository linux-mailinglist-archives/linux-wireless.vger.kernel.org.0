Return-Path: <linux-wireless+bounces-15835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AFB9E0CEE
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 21:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8E4BA40CE
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 17:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326791DD0F2;
	Mon,  2 Dec 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A4qpiQID"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DC1DE3C2
	for <linux-wireless@vger.kernel.org>; Mon,  2 Dec 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161019; cv=none; b=sq0yIvYd6Zl5oOdrEdMgCI0XuW/D15VBUIXZgvzhmhUDOo8aAh5ZMwOQcRwFP6imBxsGypB83nVP4+aVeQn5gGWvweEwVBHYXIYME7eodAT2Rq5X7za9c3sDNnqrKy6csLcTTPmHprDimG2MHmc+9oR8ok4F09qh/7gjfOEu/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161019; c=relaxed/simple;
	bh=AB1KDsXVKDe8OB9fPY+3OIeGwGUy67ADXsKnRDpbVvw=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UrnpEydiolp9fc5UBe3wpn4RzD1LiM8kXsT0vjnFUz9slsxflV/sCQj11K9cNlFa5FWKBk4KTG7wU1X6jXeTlpJEyGnaGxW+uowpjuuLePXnhEGjVHunc/UW7xJTmeuR6xahXh+hVCvb7vV7ef/ugNwh14QkUsa06yla1InZv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A4qpiQID; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa5b0d8bd41so547633666b.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Dec 2024 09:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733161016; x=1733765816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wzmZyHxcr+0gQchxbMi40JTCsDxCVuurt7d/kzIEn24=;
        b=A4qpiQIDkHinjqAjcADXZLHxNtyvr6I1qBnQj5xTKWAI8et2gUQ2fEhJAN5koXJEA5
         55BXBvEPDT4A4bZKkdcB4U3VyMxOiuxEb/ZikkqLAVCLOz9FpKo6sz30TrufaEmnDnOz
         wjzekNToUrcB/wwC168TW6jkaqfppyT3/crjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161016; x=1733765816;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzmZyHxcr+0gQchxbMi40JTCsDxCVuurt7d/kzIEn24=;
        b=BUFwvjQR9gMMpyA5TRImUYaEWTuVHKO/bdQDT7noMcDncEH55yS1eYb+jY4++lCpYt
         pJCicHaMJORV5O3t2nu1uorLj7+45f/Oqn06vDTkPBGuw6devxUbNna/lLp2A0DJZhF0
         pomV3cXKFWSajlVlgGHhSgXL3puoT4owXdMjTvrD8cTUQ3zNZh5/JvG0BrQjXnnsfXGD
         BGM5VxZ/ABpkFqlHBfopKBEsk65c9PdSimHZDOSw9096UzZy60FWa/ULBtmcwnN7neRy
         JTkc9dCWaUajOnj8fdYQjwyjr8bAX+iBNq+pP82aZCsxaK/iF43cejdfZaD5XrGclARn
         X4KA==
X-Forwarded-Encrypted: i=1; AJvYcCWGUdvPk+a/nGsYl1YTafvQVHOHVoqYPs8a6+xGp2FDZZwtn3nAGUGYFraEbDGb2eVHcNGTgjcR5dzDfFzb9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJoWqGwAe1c30gq7oFTUmC9rsiBYR5NUVAoMahm2qCNIA+KwO
	TiQ6U//2s/1TzDgwizvahNTOe2N7iOjtr+LWs0EdQ6u00czwLoD5EI4ecgFf0Q==
X-Gm-Gg: ASbGnctXDKzMiRzx7WxVQ2kTj5ERuE2hbLYb1Ep4RGut4sZz0cwl+zF51Mnqel6HlEM
	rGOgqfogCXt+dhp1Th07l6HiT0kgj6kNtXshC/yHn+rPNLHPfpUYK3liXAbuPFQ78g2rwZw/Yds
	mUKemcfG8+DbQhHWLa7lS90lVtuEL2GQkJ75Z1vbrubU7C5n5SL28GqmegcfGOk68oUyl18gpGD
	1FYD/hK9o2r1MknOBYCWuwzaqsAjhK6sBAhw93hrdMQCbo75y9IguVystPb12ew1dpQ9wXfM6EK
	dY33o46kd2Mf
X-Google-Smtp-Source: AGHT+IE/KsCt9TW2xiBy8kd8hcH5tSfUDitsk1T2B5R3mDP3TX6XhHtHA/zyIhRSmXikMg2qzLbuqw==
X-Received: by 2002:a17:906:3198:b0:aa5:d06:4578 with SMTP id a640c23a62f3a-aa580f55bb8mr2245950966b.28.1733161015635;
        Mon, 02 Dec 2024 09:36:55 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599953c69sm532361066b.187.2024.12.02.09.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:36:55 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>, <linux-wireless@vger.kernel.org>
Date: Mon, 02 Dec 2024 18:36:56 +0100
Message-ID: <19388725ac0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAG17S_P=bz0DFU71jEnV4RkT-Vxwvb2GpPwvLnjmD_n=2hLfUw@mail.gmail.com>
References: <CAG17S_P=bz0DFU71jEnV4RkT-Vxwvb2GpPwvLnjmD_n=2hLfUw@mail.gmail.com>
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

On December 1, 2024 10:55:26 PM KeithG <ys3al35l@gmail.com> wrote:

> This floods the journal of my Pi ev ery 6 seconds:
> Dec 01 15:51:30 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> 0xd022 fail, reason -52
> Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> 0xd026 fail, reason -52
> Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> 0xd02a fail, reason -52
> Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> 0xd02e fail, reason -52
>
> Is there something that can be done? Is there something I can help
> with to fix this? I can test on multiple Pis, but cannot actually code
> anything. Is this going to wait for the new infineon driver
> development? The latest kernel where this has been seen is:
> Linux pi5 6.6.62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.62-1+rpt1
> (2024-11-25) aarch64 GNU/Linux

You can build and test patches? Is it only those specific channels as 
listed above? Those are pre -802.11b allowed in Japan. I don't think any of 
the brcmfmac devices actually support those channels.

Regards,
Arend




