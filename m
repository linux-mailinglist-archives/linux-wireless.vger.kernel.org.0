Return-Path: <linux-wireless+bounces-3885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2430D85EB99
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 23:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0253BB218D7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B9C128817;
	Wed, 21 Feb 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9AEYAcL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F44D12837C
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553245; cv=none; b=ZGGLhwMqGaon3URCqyaj6conNx9mlqQzvSNAoi579n/IyOy4uGvpKvpAuL3fuxWQ6FtXfJQzKFPId4DZypNyFuWJcdks/27p9BnTLCBpe7zEr5e0u7WV633c0KWKj7wPD9YtaqIFJzNAoV5jufTsThmhCYFMyuT7OGdHm7V8xzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553245; c=relaxed/simple;
	bh=+wU68+Fn0YHM9TyUAvM4QWCZtrReh4qx8S7KW8fr3aY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f1Vz27XACEDZoGtjzKCzzzHC9jGr3EpUa+l7yzlYWlBICmK1CwnZcYqyjeUqnAg8eYh3OwQ09XBTCm+m5fkDoGqUjUEW07x+s9S6cjaBgEopJ1QU3TuijOnhHhmfvG8DvFouZHYI9vCPx+vq2JE3qqjukzzdrovhvVXoIVBCFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9AEYAcL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d484a58f6so158095166b.3
        for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 14:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708553242; x=1709158042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eZ/WHUcnQAq86F3bIEEiI4rwakjBYXS5VVc47tl59bY=;
        b=M9AEYAcL9xyHhRBcX7L94wRtnc81AN9PY3cOFEX9vwBarhWwMTPAsmyywzvhQW9lxf
         jxd9iuQ6tQn1M+JH7PfmWSCMS/9+9vSOzXLD0mimqXYq8SWjht7ML2pfbOn9kohSc+v5
         3eCiXdooTepylx9UmrHJ4Ss5GTWk4uIHwKC7lJqUhv60FkfuK+CnaMEQ8MCus3zXWRdW
         QR1wn5fhHXJan1pH8wQ9rMleIfG1LeMHqUkR/hH1v69Rh1278Jl7uW6YqtfzRVt9KJEl
         8vvml5gxSW3f8NzJdW9NKuARlCv2MaejlI1LzYHq6LkOMYqhUhVNvPXOVfAFMUDVK58g
         +clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553242; x=1709158042;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZ/WHUcnQAq86F3bIEEiI4rwakjBYXS5VVc47tl59bY=;
        b=I6ikiWOC+zOSjkLNgXyEGFGtSLbP4x/YmSCo5jg2VbCA1eNOtM2w4OBA9o1HXoohbp
         frmflP9R2sofXMDtV3cPmv9oAYyikHNQRbVSFJHH8VT8y1DsTy+6lj3DOU/Bu6vBVoSX
         QsyRnuGaUfh8lIT+V76i4oXKKxVIhsKEhjiTanDeo/riSN6JfyxdqH1iF8W3iONOsvJ0
         xa7NiJ8zUAUqiFXrKlwJYe0JU+I8PQv0/mSrv35oSal106oIaTm8dSroVGbcxAw+XTxR
         UK814aidoU8vn7M11AWoKjVoI32swO+DeEAC0Z2u9+Fh1m2eMkGzvUchJAKxQllxahRc
         9hYg==
X-Forwarded-Encrypted: i=1; AJvYcCXPoCwJePt1E2mzuHLkTbnmEeGVeWvWCdILe51xk4jZrjp7o1WglDe/N4oh+d5nJTk9qtI1m9CEERYi951GKzMzqHJfplDPRi+kXnL76aQ=
X-Gm-Message-State: AOJu0YxyNmTkBmcdNSMoKJmmpRGmV6bGN0BlJAXBq4LcCuV/KStYrJIs
	j/jAHCZ+ZFyBPh7kyoofJkcVSb8HU2Cp3iCdb/4rYSjDKlaloA3J
X-Google-Smtp-Source: AGHT+IFpcP+pBmHZbhDdg5LQfyFzf+yUUHTkbcJEDW14d/Hw4tMup3ZZ03DCR7VzUXeJM9mLmVJNDQ==
X-Received: by 2002:a17:906:1c5a:b0:a3e:9def:5ed5 with SMTP id l26-20020a1709061c5a00b00a3e9def5ed5mr6512536ejg.33.1708553242211;
        Wed, 21 Feb 2024 14:07:22 -0800 (PST)
Received: from [192.168.68.106] (178-191-200-70.hdsl.highway.telekom.at. [178.191.200.70])
        by smtp.gmail.com with ESMTPSA id wn2-20020a170907068200b00a3e6f22f21dsm3943248ejb.54.2024.02.21.14.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 14:07:21 -0800 (PST)
Message-ID: <67df246c-062e-415e-9419-df4cf006409e@gmail.com>
Date: Wed, 21 Feb 2024 23:07:19 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Till Kamppeter <till.kamppeter@gmail.com>
Subject: Google Summer of Code 2024 - Mentors, ask the experienced mentors!
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
Content-Language: en-US
In-Reply-To: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the GSoC organization team is running 4 panel sessions where mentors can 
ask the panel of 4 experienced mentors. Each of the 4 sessions is about 
a different subject matter and with a different group of panelists. The 
panelists are long-term mentors which have stepped up voluntarily to 
help the new or less experienced mentors (but experienced ones can also 
learn).

The first episode takes place tomorrow, Thursday, Feb 22:

Managing inquiries of potential GSoC contributors
Mentor discussion panel:
Time: Thursday, Feb 22 1600 UTC
Join: https://meet.google.com/gxe-jiqf-pwc

Please prepare your questions, this is interactive, not just to watch.

All registered mentors who did not opt out of the mentors mailing list 
get the announcements for the 4 sessions via the list, but as many of 
you did not register as mentor yet, I am informing you separately right now.

I hope this will help you through your GSoC mentoring task.

    Till


