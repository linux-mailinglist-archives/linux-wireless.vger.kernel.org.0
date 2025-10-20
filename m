Return-Path: <linux-wireless+bounces-28094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B47BEFDEF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 10:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F414D4E27FE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 08:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866422C0284;
	Mon, 20 Oct 2025 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GqhCfyMC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F828489B
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948185; cv=none; b=kP2xlIPk1Pe58UfKeLuo7RDBNvS2FPnE6YA/CHW4nqET6EGwL0nWTTDHLg4b3qwXEtYzLH5Mm5EQwLj08evYSBKP+GvMSTbfr6j8WD4moYkajpm14iVaco04vT7VoUPqZ2cnYZrFUOS8tWLp7MC0gIQ0wn74TJHdD+hawTFANHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948185; c=relaxed/simple;
	bh=HAe2ANNczQ1hQD47t0KQRzbIEvlgjgBQ4sfsg+S1m0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BApQE+X/go/STRfjSwOBbDAicNl3a8Z0xDFJ4qCPJsSs0j8pv9m7CX/o7RUBTCjhNZcTZ7v7dKl3uMKcrPwXn2WjLNcmUgRh3LJV/Md9zY9Epz5gC3lbvsqUPbYfKIUCL3jsjTnaKQW14bxz+4uCjoZ9qxRDBfR4FFzUBgmRKIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GqhCfyMC; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-71d71bcab6fso38614587b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 01:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948183; x=1761552983;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZExFzEY6BbrN3cESb2NgIfxCgGmmIVBR6lSIxOhgXSY=;
        b=U1ANgGATKpetfdPXOwRbM0N0PJKgvJfPzjDB/Wv+x52qyMlbbvdIVBZ6aFhXUzpyCH
         KrtpPd+VErSJYEd59dRqnuVZidEc7OQU7fXZMD1zja3uIp6zBTI3b8AT9JYesF3Bqna9
         ubtNhe1XgF4mbCGIqTju/578C8rDiz658/QGKCMrdEEj78VZIH9fnJDJmbMDLoKECqaV
         6bXVS5yvENb6cStZKtkmlQy5+071WH5dxT1p/6uGra4qXrmN6O4q9L2HYvxrmB2J4x8s
         bKANEfnxaVPb/9OK+6uH+VcLLjCDX4Y5ypL+MFswBv18MN141VVrua4MAyLSawLfLiTT
         6IFA==
X-Gm-Message-State: AOJu0YxANp4Xa3eJj7h7hAdGB0NNufZMUb3ug8EyhspGTNxZMlJlCi8C
	1Fsh6iXqaJdHknTmoodw2FDeXP7uYAWRq7tlbSZBo+waduCumdhzV/J5LF9yJjs8IdnZ7AiI/gI
	xjtK9xf6jT26KLkkJzgRnoK+H+Zzyq8hWc3PbKkUEj1/ShPMl4atU51oK8HtSZL97uKpgGXUb3U
	mI3H+0svMHo541jGV2BzptjBcTo24citliU9sdCFtDMuq/jCA9ZwutD17izg2M6mv4CE3HEFut0
	3SvHN9AKoXjGYYfl4kMyeGxjdOT
X-Gm-Gg: ASbGncvvcZUh2EfAttwdD8DpQ9TvqMLrTzbVkEEnuhXL/zbfOiHN4KyhQtfjJXcpkiY
	cRnuDNCDP4SUmu1lCoifBUHbgOSyFzxO8tAYW7saOQcu/7omjUXWmTvjodCm7nYcgqmMeUTEJDz
	Lp/AhBcflebjvKiuNg3KJyKHS7C3TFnwm+iW1N+mfR87Js2R5gwBwhRNcjPuZkdj1PQZ+qeIeB9
	jTiHPBaQ3yjsR+sbv+b8h0V3APn4PktVsJE9sn6hQULbZ4SlOFUwLL55Xav3APrJWwTuSaezYzs
	fAb8z3fcsctS83k5Ih82VEoB06vvLOpWREMJifKyKokQ8fdiEWSD6hzLlaVO9v5XjoknUSZULTT
	eTg8pmtesHcsgARmq/lnj5MsyfepeBMt0pc68fKg8fZStLAVgwdHCAr4bebUWH77A0TSUihs2qN
	gvUqVuxBKpJKQ/3AMP0X9Y4m2+W3wwlah8O/k=
X-Google-Smtp-Source: AGHT+IGieqEukQRrLNWIjzHYvjNirqHsk+ZT+0J0mkGk5pz8L02tuWamV2NVrPC1hflqG5AW4SfXz5v6KD7M
X-Received: by 2002:a53:edc2:0:b0:63c:f5a6:f2de with SMTP id 956f58d0204a3-63e1626c69amr7670735d50.64.1760948182577;
        Mon, 20 Oct 2025 01:16:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-63e2669f01fsm615521d50.7.2025.10.20.01.16.21
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2025 01:16:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88fec61f826so1471769485a.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760948181; x=1761552981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZExFzEY6BbrN3cESb2NgIfxCgGmmIVBR6lSIxOhgXSY=;
        b=GqhCfyMCJrfUqnI8p46+BllMIPpfBAfC/+l/t+za3I4S2e22JcgQrLIE9KHRDSS/xQ
         O1jn4vEM93NOFyD/wN9AvquPXpTEpwoIOi8UsWKakNZO+wGncB13EHdy4Ouih3DS7rXS
         1v1wzjqFIUb/jZP/0lnUu7Yuvo0tBbYIvNn70=
X-Received: by 2002:a05:620a:1a9f:b0:884:f411:1962 with SMTP id af79cd13be357-8906ff0dff6mr1326052885a.47.1760948180876;
        Mon, 20 Oct 2025 01:16:20 -0700 (PDT)
X-Received: by 2002:a05:620a:1a9f:b0:884:f411:1962 with SMTP id af79cd13be357-8906ff0dff6mr1326051485a.47.1760948180352;
        Mon, 20 Oct 2025 01:16:20 -0700 (PDT)
Received: from [172.29.0.98] (161-51-84-2.static.ef-service.nl. [161.51.84.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf0af3f3sm516545885a.37.2025.10.20.01.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 01:16:19 -0700 (PDT)
Message-ID: <98a614cf-0016-4cb2-9109-84dec84b535f@broadcom.com>
Date: Mon, 20 Oct 2025 10:16:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New test release reload driver
To: Berkem Dincman <berkem.dincman@gmail.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, brcm80211@lists.linux.dev
References: <CAC3nzgJ9uX3rREGQGbLA+oJMzDh0Bc-Fs5sP1sM_4DGScgq=3w@mail.gmail.com>
 <977b67ef-ef6f-4ae4-99db-eeb921a17e3f@broadcom.com>
 <CAC3nzgJM6azT8T4StreR874h5sUarLH62mgHvRZndV_XEOBEgQ@mail.gmail.com>
 <199fc3250e0.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAC3nzgJxowTjrJJppahVMg1iLVXad38D5ZR38-rzsDQm8daUTA@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAC3nzgJxowTjrJJppahVMg1iLVXad38D5ZR38-rzsDQm8daUTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/19/2025 1:50 PM, Berkem Dincman wrote:
>     [ 17.288032] Bluetooth: BNEP socket layer initialized
>     [ 17.319081] Bluetooth: MGMT ver 1.23
>     [ 20.068465] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
> 
>     As Bluetooth resides on the same chip as wifi I find that suspicious. I
>     would like to know what happens when you disable Bluetooth. Can you
>     test that?
> 
> No I turned Bluetooth off and restarted the same error messages would be 
> printed onto the screen

Ok. Thanks for testing. What do you mean by "turned Bluetooth off"? I 
want to assure the bluetooth part of the chip is not powered on. This is 
probably not the same as "turned Bluetooth off". Please provide logs for 
each test and/or verification done. It may save going back and forth 
over email.

Regards,
Arend


