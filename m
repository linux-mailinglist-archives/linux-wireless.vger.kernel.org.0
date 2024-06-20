Return-Path: <linux-wireless+bounces-9281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD1910026
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF27E1C2091E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5219DFB4;
	Thu, 20 Jun 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQJsd33S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320DF19B3D7;
	Thu, 20 Jun 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875131; cv=none; b=WvhbqaQH6jHtH3KwWlYzMbMzAkeMIX6MPAD6C+OWUYgywxlmtBFSjVOu7aghyL1T7zBRLdok9jWJA4k98UwseHgyQD05rpilQiABRs+hC+JOOpNRtgVJk8MmlbUkNtbCNsjNMkr4lkiufTtY0owDD5YXZqLdPdxVpUjKKKWWwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875131; c=relaxed/simple;
	bh=TaHCvfOFH+3vpjfZrPlNFRdLiZNVG/mJY/+EObT4Dts=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=avE6lxWWxUnCBgzc6+q0VoxciAzEp3R7zBguHZpdaipomaTi1xbKjJa2kmTSuyzIKmSS8q7y4i3rxlpGfnoKsZhNk1BgH4AirnGjgkyVkCUa8W9S/xQFsHuTQNQ2PJQEDNhLWghl4AmsaxaJxDCOuT/iSI06DKd6m5HxDtQu+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQJsd33S; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7041ed475acso665160b3a.2;
        Thu, 20 Jun 2024 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718875129; x=1719479929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TaHCvfOFH+3vpjfZrPlNFRdLiZNVG/mJY/+EObT4Dts=;
        b=XQJsd33S7K1oEWvHBRYazXAOFepZVer9MEC9H561GjiagPvL0ZrC8YoH0B6eUYg+0V
         S93rUnntQPD2vJYIpu8fuBQ1QufbQy4IfLQeQFv23rKhz3Ce8pYDn5ASAzgxmPq9Bp9L
         ti49wmZk047yqhyuFCX4vGT4/AJJlKJ6OmeI2uxarSZpsn3W+D65tawvGIWbF1cbymns
         J9riJprrqgxCpP6AdBuogf3f6q7F9F7IJwwUEw1S58OFl8NS+rytxZBCww3RmyYpj8uu
         4Ni/o8VYoR1pp/y0vTD7Ypg6MQDAGWABVRTGSHZ2KXIHEaNA5sgvWn7cq2LT7Um3hESf
         HuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718875129; x=1719479929;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaHCvfOFH+3vpjfZrPlNFRdLiZNVG/mJY/+EObT4Dts=;
        b=iJFokQqSCqISVJKRrH254v7lbt6vSmmKuZzDCJE5nqUIPn9J+Zgnpj0yGlA9Qcout+
         TJqHRevGPmM9q9kjB/SGXhzv6vwsV/uqH7SspykUVhdzxb9Pnug99Dor5rRp3P8Lph4O
         ljmSWcz+2LdC0rLH47GLQIU79Mncy75XvhPZ0yL9dm2B1FIu7WA5DCfu16MlXm8di0+H
         zIRPjo2g4Jf2nTdOg5qGd+683lZ3M29lsm1KMhZifAk+HEJSBiAaw45gW15IIYS7T2V7
         vR6WBf/Y7mO4scZysgDYEylL2Unjdh4AqQzZTocefk2th2zCP5OHcKaO9mlF/DOwxWvz
         Akxw==
X-Forwarded-Encrypted: i=1; AJvYcCUsY6mlxBRl+Wg0wvXrgedF/dT/uxm8sinvbcG/SVbRJxnbb79gUBfxOpszsF8lXtecip4zfT4q+vcuD3hZPoRB96nxtG5ybAM=
X-Gm-Message-State: AOJu0YwUXdAXPHeVCwkjsXLCliDh430tRk1dn46GwfJmY17fzuPK1QzI
	kzJaN9T4XJQWUz9mghw3Z2j7LkAPwsc1waJ3YBSv9UP5542zLgUU
X-Google-Smtp-Source: AGHT+IGSszKMR6kxdDqkkw9T2kQ7mzXZt5CHH4aWTPnMWxJrPY+GZvR80YnGPSmspG2jBn8bD059uQ==
X-Received: by 2002:a05:6a20:b211:b0:1b5:69cd:87e with SMTP id adf61e73a8af0-1bcbb5915eamr4050697637.21.1718875129399;
        Thu, 20 Jun 2024 02:18:49 -0700 (PDT)
Received: from [127.0.0.1] ([49.205.38.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9c85f4229sm11260885ad.156.2024.06.20.02.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 02:18:48 -0700 (PDT)
Date: Thu, 20 Jun 2024 14:48:45 +0530
From: Mathew George <mathewegeorge@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Bernie Huang <phhuang@realtek.com>, "kvalo@kernel.org" <kvalo@kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
User-Agent: K-9 Mail for Android
In-Reply-To: <6970398610c546b1b62e599902c67572@realtek.com>
References: <87tthpwkqf.fsf@gmail.com> <2ce41d4129234ba9a91d5b4dcd8a40ee@realtek.com> <87sex93s63.fsf@gmail.com> <6970398610c546b1b62e599902c67572@realtek.com>
Message-ID: <E3FF7BC1-725B-40E2-AAF0-CA41A44B9DF9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Please share Arch Linux image you are using=2E

Not sure what you mean by 'image'=2E As you can see in the crash log attac=
hed to my
previous mail, I built the latest mainline kernel (445e60303883 at the tim=
e) with your=20
patch applied=2E I used [this PKGBUILD](https://aur=2Earchlinux=2Eorg/pack=
ages/linux-git)=20
to build it; the file `config` contains the kernel configuration (I did no=
t apply any other=20
options), and there are no patches applied except yours=2E

> Could you please help to collect 2 or more crash log?=20
> So I can check if there are
> more than one crash cases=2E=20

When I am back at my system, I will reproduce the issue a few more times w=
ith=20
this kernel, and attach the logs=2E In the meantime, you could have a look=
 at the logs=20
linked in my first mail=2E There are logs for most of the bad commits enco=
untered in the=20
bisection=2E

On 20 June 2024 13:46:21 GMT+05:30, Ping-Ke Shih <pkshih@realtek=2Ecom> wr=
ote:
>Forty Five <mathewegeorge@gmail=2Ecom> wrote:
>> > Please try [1] that fixed "wifi: rtw89: add wait/completion for abort=
" for
>> > certain cases=2E
>> >
>> > [1] https://lore=2Ekernel=2Eorg/linux-wireless/20240517013350=2E11278=
-1-pkshih@realtek=2Ecom/
>>=20
>> Doesn't fix the issue=2E I get a freeze on the first suspend+resume=2E =
I've attached the crash log=2E
>
>I tried 4=2E10-rc4 + the patch on ubuntu=2E Never reproduce the symptom=
=2E
>Please share Arch Linux image you are using=2E
>
>Could you please help to collect 2 or more crash log? So I can check if t=
here are
>more than one crash cases=2E=20
>
>

