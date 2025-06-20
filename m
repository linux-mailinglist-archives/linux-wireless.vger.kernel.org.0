Return-Path: <linux-wireless+bounces-24287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8669AE1A76
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0F0188DF47
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 12:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF448235056;
	Fri, 20 Jun 2025 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="acnDhKlJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FE17E
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421170; cv=none; b=FQ4SHcHNuMZcMsddnwRzdJ0PU4fPEPxH7IDICQOuKqmR8Pxs4UwcudNnhZlLFs0mKdsUABZWHQh9ZefSdDt01w9Q6vB8yHt/MSaNdfrMfenYae9V2eXxdjMmLJDvdBWKg8IS/9a3jUdN1h7NMTdfnrYPPn2rLY1/KX1ckBzoy40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421170; c=relaxed/simple;
	bh=aZe3M3OT0KDWKneHYkr7rYNVS1F/f+AhwnnXXYF2HPU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Dfi3Gve5axghu9ufpcmrQzIBA5bM0Z2fzi7xtGtTqR7snr6sR8+1ZwkUngLhptnMPRZ34yykCmMwXQS4yOLEgLQQvZT/nug9ZyGBxwUTdj8gdBRoUtPtu9UJIRYdnI4SbOke+Z7ATDAA18WmsWi3b0ocffTsLLIRQN9Dt5PYvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=acnDhKlJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so1688769f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 05:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1750421165; x=1751025965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QP1Z0UZb1uUg2L12+ZqhqtLHpt/BBjTVaoznzpnQbw=;
        b=acnDhKlJvV04EOAHz1sNw7fx/hdpPGeNYNSM7V6SVY8RyxlT+gVnD1CaML5tmsz/d8
         5I0OMdS5vuZDNDplJ8/jqgq9yQs40/SAF6sp91wyf5OEHw5N1PMCC2UkdAPp4EwxQIwJ
         XtZ/g8CPO7D7ePMkvPExtgsx0qRBq0IPwSNXtW6SCdcZtn1T8WUQxgpCADjY6MOQ+qJd
         y+Yce2HrbeZ25i7tfAl+ossnuC9kdO1Tyvk/GqVzmAuqH2jCs3ADObY/l0689emgMguA
         BBKZD7q3mJj0TuoaDFctj476gpzYyW85BHM01nul6xWso5dOAP6n8NfR59hYP734JIvk
         O7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750421165; x=1751025965;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QP1Z0UZb1uUg2L12+ZqhqtLHpt/BBjTVaoznzpnQbw=;
        b=YzEKaHCl9JJHb6tz6U/Rua9ZxJ1hi66FoXRh0ezl4dn0yGELs1P5JBSY/R7hEPh7Bu
         jwukTVYnw2vlO8J1livNovhH028sYsjYQ960KOpDt59NUmx55ESfkFVBEHqrJ29scLuI
         FqhLN5/Oulgg1WPRKFqjFleRGz7FEZGiFzDLxy5Yg+sI0GIRmS6F/0EUUJxUrRHUEETR
         sR2xeHfA7/7F66je9enk/qTcD0gRrR4MP3Uw1hRhYVY9mSgZp86IvhEpbWfwthrOD8rX
         +SSuixzCY6y1oXGSeZDlZodxGeuINQbJVzpahCW31caeeO1TF3K8s/TarRIp4oF8vG5v
         SWHw==
X-Forwarded-Encrypted: i=1; AJvYcCU/+WK8Oy3GCTFWL4DBkBGZhKGSV1LovnRwTrNtSlIKBGp8oNaQ121hs7ibYG21Hio9KfBYTJfX4UnkvFB2aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMjc4wVwW4HnrOD1ttRnQqdEZaAIurlFOxbvvl97sINm57IO8c
	wTJRhe3Tp8c3jf+dRlZQgQbAAKnB1Q15/YOQ4IRmEssdrv5x02P+Hw/NP2jGH0kHTHQ=
X-Gm-Gg: ASbGncvX/lqljwC7BbOmv20fis478V1e183drxmLLe/0IifvfaNq9ykW/+ao/FipNU4
	c6i/ulb/Am0EBargGpDYWrp9hEIUdhbZBwJvFfssVJG7VBFvLWWhoWfhB7L8zqtyGkMssWGIE6Q
	xXOsUEt7G+/+B27g+7PlbMQbRKDIJo62QwLyyzsyx41VpNpQDowPikkhW0Zp3v+X27p31zvYaOF
	3emSg7z5rGBmbkEvvTPIvZhnZYJlhQt+lLgVR6+fQGQekzgMm5OBUmq6lCSuPoI3lFaUuuYZIWv
	PNIK2RmbIuN+nSgMnZd2vNcuHGcQdIMqQrnSkWiGTvPBBr2ealo2MSr9jrTUA7Zgch2GtyrOjmt
	+nE0NrTve6P3anJXBxlBEX+TgQXER
X-Google-Smtp-Source: AGHT+IGptzPczS7rok+CfAHy5MJMmghXoYqx88HjwgUiLqmliYLa27p1kOnafRJeGI5zbk1fdnezdQ==
X-Received: by 2002:a05:6000:651:b0:3a5:39a8:199c with SMTP id ffacd0b85a97d-3a6d13129demr2192576f8f.53.1750421164718;
        Fri, 20 Jun 2025 05:06:04 -0700 (PDT)
Received: from [192.168.108.121] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d128d063sm1864357f8f.101.2025.06.20.05.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 05:06:04 -0700 (PDT)
Message-ID: <4d9d30d3-a011-46a3-b970-3ab0d647df39@freebox.fr>
Date: Fri, 20 Jun 2025 14:06:03 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: johannes@sipsolutions.net
Cc: j@w1.fi, linux-wireless@vger.kernel.org,
 rameshkumar.sundaram@oss.qualcomm.com, ramya.gnanasekar@oss.qualcomm.com
References: <4a1c89a13b299588bf9c94dd545eda3e30fb5491.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix 6 GHz Band capabilities
 element advertisement in lower bands
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <4a1c89a13b299588bf9c94dd545eda3e30fb5491.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 20/06/2025 10:39, Johannes Berg wrote:

> Re: [PATCH wireless-next] wifi: mac80211: Fix 6 GHz Band capabilities 
> element advertisement in lower bands
> > > But does that make sense for beacons? Not really? > > Feel like it doesn't. Shall i make this patch to restrict this 
> only for > mesh beacons ?
> Not sure? I guess what I'm starting to think is that if the language is
> all the same across all the frames and says to include it "when
> dot11HEOptionImplemented and dot11HE6GOptionImplemented are true", but
> the beacon clearly doesn't make sense - is that a bug in the spec for
> the beacon, or does it mean your patch is actually correct also for the
> client?
>
> Jouni, maybe you have some spec interpretation opinion? :)
>
> johannes

I'm not sure there is any actual STA that does this, but in theory, a HE 
6GHz-capable STA could do an extended channel switching procedure 
towards a 6GHz channel, and include an Extended Channel Switch 
Announcement in its beacon. Having also the HE 6 GHz Band Capabilities 
element in that same beacon makes sense.

Pablo MG


