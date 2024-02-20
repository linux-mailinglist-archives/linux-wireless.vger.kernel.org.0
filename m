Return-Path: <linux-wireless+bounces-3821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A08785C395
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 19:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64D51F223F3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 18:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2B478691;
	Tue, 20 Feb 2024 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfOzKb/H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9C78665
	for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453575; cv=none; b=Pf5cj6QFHdcEIUFwkUSfHCZypU0c1OMpvs7CFqyE+/2itXyXGR45PzZhT93PDIosTBcigToQ4YFgJELC3dm10feqmi2vfqptqYdPhZzAcXlD14kuyXI4Sc5C2x8udpcv9dHfMlY5a87Hq2+ebzAZIUUOsMWlL3oKBc5RS57oIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453575; c=relaxed/simple;
	bh=0wVxiB2sfr8pII8/cn0+gfPY3a2qH6ez1ggadjqqF48=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XytTiW/B5WHfteuFe0X1r7RTnSQH247upngE4vTIRnxZvp7A3ktTlGr3aK6UaOLN8mtVzI85R+yywQdS3AcLgQynrX8mSiBYV29voCuxSh0Bo0qA2FCSUDAKxGcqvlFnYzBkirlTKp3GpqdLF3HCKDozVL11ZtJXy92jJZi7p4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfOzKb/H; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so8596257a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 10:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708453572; x=1709058372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oKukJOM9dMXvjzIi3ceVmkJBF7dszWbqUfPqY2iRFbU=;
        b=TfOzKb/Hf9VqwndKRDSq1mqwIzPrmoNV8W3MOcb19ozf96n9dKOfdBkDMDf5tch2jd
         4SVaNF+za+kQN/hf1vgnNqlzS7LoMbhmkPcNchPoh6f/5nAyiAGeIFysu7O642lMhVFB
         vhSvVkMG+8iQshtchlPC7vzX9ZO3qrBkx5+OSO1a5mEt9frctJ5M2g2NLrDB5M11LfE2
         h2bRwaTGVwmqRz56G+LVMTR4/hi1gK9t8VOcZL8fbHa0l95gTyzUDU1FxeXdiePrZQ4K
         Eh465tlREI8xV/gIm/E0SbP2/3cS3RigF1OWlPth1l1rrk60JwfIK2IG+arn3XEgiUbJ
         gzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708453572; x=1709058372;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKukJOM9dMXvjzIi3ceVmkJBF7dszWbqUfPqY2iRFbU=;
        b=IlcN63YQWuUWpXMLiiCSBNFuSUooxTvdXFGBxMsLR8YKA1b2M5l9f/qVfQ0UOJ/o4B
         1NsFwDhVUPJ6YQAJZ/Zjn3LKaOUPIkyGtZmv/3Uff0oFxbtG0Oo+OECtEbD+lreB0vSe
         +65tiQVosIiZZua555pbZS5Lsb1JDCo4j1wzQLtsadx+mDKpHG7192OtJBY5LQHaHYsR
         gwg0M//uY9pU1k7sZRyUJeX0LQ3gCj2LTOLHgqpYTb8h//KuCrmcCZtxA9O3YGtjl9UL
         PX3KaAuCljenYATw4+eIpnuZmd7zXUVwIbxfLugw0V2mMlF3T1CzYuWdPX4yQwMoR/Qz
         ESzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXikmyXbVjB+vMSt1K1TXK6R1nGXl5xqXHXpYG/fwHKDCqVmfggql9ZbiKG8qPUlv2arrh++g37nczUqfG2ePkXkYUbFP/Wy6MADqNAGYs=
X-Gm-Message-State: AOJu0YxLizLVBFG0XOwpVHfSnLp4XjaQfZZXad5+X/msVxmeUazUeUto
	XJPac+k8jMqXHp2jlvvXuEpLC/xCUSPRcr/WvXYlyleJFCDJldR8
X-Google-Smtp-Source: AGHT+IGr3BPhmEfyOp/Eq4kZJoyJGg9zLFIRAYIUjUG9yo9gmn2BCb75e2UnN8e3iuZ2/GDRgBxjDg==
X-Received: by 2002:aa7:cf8d:0:b0:564:6756:277 with SMTP id z13-20020aa7cf8d000000b0056467560277mr4399913edx.6.1708453571967;
        Tue, 20 Feb 2024 10:26:11 -0800 (PST)
Received: from [192.168.68.106] (178-191-200-70.hdsl.highway.telekom.at. [178.191.200.70])
        by smtp.gmail.com with ESMTPSA id i26-20020a50fc1a000000b005603dea632esm3899548edr.88.2024.02.20.10.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 10:26:11 -0800 (PST)
Message-ID: <3fddb7e8-c09f-41ff-8ddf-13cb8a958bab@gmail.com>
Date: Tue, 20 Feb 2024 19:26:09 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Till Kamppeter <till.kamppeter@gmail.com>
Subject: Google Summer of Code 2024 - The Linux Foundation got ACCEPTED!!
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
 "Luis R. Rodriguez" <mcgrof@gmail.com>,
 linux-wireless <linux-wireless@vger.kernel.org>, dl9pf@gmx.de,
 =?UTF-8?Q?Jan-Simon_M=C3=B6ller?= <jsmoeller@linuxfoundation.org>,
 Daniel Baluta <daniel.baluta@gmail.com>, Vadim Mutilin <mutilin@ispras.ru>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Ira McDonald <blueroofmusic@gmail.com>, Michael Sweet <msweet@msweet.org>,
 Tobias Hoffmann <smilingthax@googlemail.com>, Jay Berkenbilt <ejb@ql.org>,
 Nicholas Mc Guire <der.herr@hofr.at>, Matt Germonprez
 <germonprez@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 Gary O'Neall <garysourceauditor@gmail.com>,
 "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
 Nicholas Mc Guire <der.herr@hofr.at>, Julia Lawall <julia.lawall@lip6.fr>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
 Rithvik Patibandla <rithvikp98@gmail.com>,
 Dheeraj Yadav <dhirajyadav135@gmail.com>,
 Deepak Patankar <patankardeepak04@gmail.com>, Ian Rogers
 <irogers@google.com>, Bhavna Kosta <bhavnakosta2020@gmail.com>,
 Akarshan Kapoor <akarshankap@gmail.com>,
 Gaurav Guleria <b20099@students.iitmandi.ac.in>,
 B20251 Kushagra Sharma <b20251@students.iitmandi.ac.in>,
 Mohit Verma <b20215@students.iitmandi.ac.in>,
 Pratyush Ranjan <pratyush.ranjan911@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, benjamin@zephyrproject.org,
 David de Barros Tadokoro <davidbtadokoro@usp.br>,
 Jon Oster <jon.oster@toradex.com>, siqueirajordao@riseup.net,
 peterz@infradead.org, Zdenek Dohnal <zdohnal@redhat.com>,
 Andrei Iosif <andrei.iosif@canonical.com>,
 Danny Brennan <mdannyb11@gmail.com>, Kurt Pfeifle <kurt.pfeifle@gmail.com>
Cc: Aveek Basu <basu.aveek@gmail.com>
References: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com>
Content-Language: en-US
In-Reply-To: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

some minutes ago, I received the message that the Linux Foundation got 
ACCEPTED as mentoring organization in the 20th Google Summer of Code.

Now everyone of us should

- Get in contact with their communities to spread the news so that 
potential candidates start joining us quickly.

- Speak up for mentoring contributors so that we can register you as 
mentor and you get access to the web app

- Add more project ideas as they come

Please do not yet post in the social media or on your project's site. 
Official announcement of accepted orgs is tomorrow, Feb 21, 18:00 UTC.

    Till


