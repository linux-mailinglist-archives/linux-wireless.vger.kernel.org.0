Return-Path: <linux-wireless+bounces-3911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AFB85F674
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 12:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01C6287760
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B441C45953;
	Thu, 22 Feb 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEl9ABbk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39C44377
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599841; cv=none; b=OXpwgn5CKZt4y5OSPcZ44kfop27Gx9DppRFcAz4M2VwmJH/PcS63nb2YxZuBelRFodYmNcObCmlCziLSgLXe9dhxs2vpDwm801eRDAtcC6hPhWRmqfQDZl+lNslcoBnFN/bRL5cH+wzFDbRJ3GG+V7/g0i5Q+p4V7D4+Pn6HVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599841; c=relaxed/simple;
	bh=ooTfdMy9rbYkDyC8POkG+mPFbaq8KI7pfWzVFSirO6M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e5LTa4d9VTyDynGiYFLsN+hsR/b+J1OfFgRU91VU7/eG0RemqdPHNpHyJvZlCBIw9Wxm/KX3bFaJspSStz5/1ILHsBXqpgiybNAQ6B+FWg14KwBnCtWTp8cVniZ3QmjOOv+IBhZOsMytD3Ln11Wj4AId2/vGkCE0liB3gpJX3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEl9ABbk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so64789266b.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 03:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708599838; x=1709204638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNu9kyMQj9x9F3+xGj4dwff9omQ4wTIwRIANSumZYHU=;
        b=hEl9ABbkbVtSm1NJhRA4PBZYV92empDuiIeiNpRhdQR+PQCTZz9UpERAG6nT4MwuYL
         nABn0wm7pPu8ELNONXsMfWG2gArIzjy/mjevLFdxeqJwz7Eiqxt5JxnZZ1aa/3Q5qGIq
         2PU4IxtDMnf1pAgqijkb5FHTQW9nVBviV7Ri+8J4n0WjHEvDT3KmhN/hCoy5FVD8yoKz
         wmcpZuGv1N9qX2AvMlg3PWGQ4oifL8xPQzK9IrFj98XDFi58TSsS5gUcuYI5TiRYkn3+
         nwpXYuD3oOJsrDL6Y1WrUNPfbpLzQriFfJskR2BDYjKO3+O2vnVVB6Lnj83c2f4XcmDW
         HufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599838; x=1709204638;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNu9kyMQj9x9F3+xGj4dwff9omQ4wTIwRIANSumZYHU=;
        b=VO2wfTWxrcXftz2/qag6Ob3iIbWTvZR5UovbSJWcJUWFNH805DUOV2qq+FQ4Tq+2rA
         /s3ztmB9IDTx2zMo6HMWAORVF7+JsgLkaUWjUF8BJSoW4M38jgsiHa93DkY2ewTSybzO
         AFXmnbJaO7PLv9Q4bMU7WAHWy14CVX4Xz2DSUrGL7uYXP2emVL/+Rax74vZn6qPmDVAD
         6lWW/iTh8bF+U/AXVDjfRv/p0SXBAQ4K1ZvUZVzp+P9W9FOGFOvklMfdiBbcjy1GvmZI
         QccJxbPcvm1ElMueQ2q02pVQ2WVJnAtatgu7/v8yw6YQPWLsC9ER5Yvvj9Crt1OlRHuX
         NwKw==
X-Forwarded-Encrypted: i=1; AJvYcCVZHrqsa6JvmsRmCG9bEMd0qAohdbZqy8NVsJbfqXvH/z+uOOH+WXuCHSLdr9RLGWg5zQOhg/rVOLg4QzQQ+nswCjXxC20XM4cDoUTxR7I=
X-Gm-Message-State: AOJu0YwZG0yUU8f0NnzLZroi8H82Fo46/xS5NPEXEjtV2OkRGWPL4D7T
	OShANjoOtZlx//Og2UY4m1hsAgjqlvNCGi1MCvleT3x3G8wVTa5d
X-Google-Smtp-Source: AGHT+IEV0BG67FP1qKG/JByu9uTx69/9v3UGsYliRamKUwbT18IUNjtaGK1TmX8qgVJmgdXTSSFmcQ==
X-Received: by 2002:a17:906:e58:b0:a3e:dfce:dae8 with SMTP id q24-20020a1709060e5800b00a3edfcedae8mr6047430eji.42.1708599837923;
        Thu, 22 Feb 2024 03:03:57 -0800 (PST)
Received: from [192.168.68.106] (178-191-200-70.hdsl.highway.telekom.at. [178.191.200.70])
        by smtp.gmail.com with ESMTPSA id tj9-20020a170907c24900b00a3ca56e9bcfsm5863532ejc.187.2024.02.22.03.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 03:03:57 -0800 (PST)
Message-ID: <811e6377-38be-48aa-acd5-2dd37248476e@gmail.com>
Date: Thu, 22 Feb 2024 12:03:55 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Google Summer of Code 2024 - Mentors, ask the experienced
 mentors!
Content-Language: en-US
From: Till Kamppeter <till.kamppeter@gmail.com>
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
 Nicholas Mc Guire <der.herr@hofr.at>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
 Rithvik Patibandla <rithvikp98@gmail.com>,
 Dheeraj Yadav <dhirajyadav135@gmail.com>,
 Deepak Patankar <patankardeepak04@gmail.com>, Ian Rogers
 <irogers@google.com>, Bhavna Kosta <bhavnakosta2020@gmail.com>,
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
 <67df246c-062e-415e-9419-df4cf006409e@gmail.com>
In-Reply-To: <67df246c-062e-415e-9419-df4cf006409e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

And here are all the sessions so far:



Managing inquiries of potential GSoC contributors Mentor discussion panel

Time: Thursday, Feb 22 1600-1700 UTC

Meet link: meet.google.com/gxe-jiqf-pwc



Lessons learned from years of being an Org Admin

Time: Wednesday, Feb 28 1600-1700 UTC

Meet link: meet.google.com/imy-dtbp-had



Tips and tricks to be a great mentor

Time: Tuesday, March 5 1600-1700 UTC

Meet link: meet.google.com/wfy-rdgy-kwd



Making the most of the Community Bonding period

Time: Thursday, April 25 1500-1600 UTC

Meet link: meet.google.com/huz-enjt-ati



    Till


On 21/02/2024 23:07, Till Kamppeter wrote:
> Hi,
> 
> the GSoC organization team is running 4 panel sessions where mentors can 
> ask the panel of 4 experienced mentors. Each of the 4 sessions is about 
> a different subject matter and with a different group of panelists. The 
> panelists are long-term mentors which have stepped up voluntarily to 
> help the new or less experienced mentors (but experienced ones can also 
> learn).

