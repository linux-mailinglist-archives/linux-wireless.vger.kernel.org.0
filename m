Return-Path: <linux-wireless+bounces-19384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D9CA42FF7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 23:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B68F17AEEE
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 22:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4911203710;
	Mon, 24 Feb 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LBCMVcF1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2217BEBF;
	Mon, 24 Feb 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435704; cv=none; b=ApmMSTs03OD8WXnZ07mP6W/3NdLCf02oTZddxQJFYlzuOOXYsKv15Nv7tZfMhugydw7YUE/szIvtbDH9OmIkhu/JkePrWxw+gqlu+ErAXfiWZ8Pj6WXtVgyRAa6vdgpAHL3j5tIzWneA2Kk+MvZRwDveG/1Uw4gT1U3jHYhFWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435704; c=relaxed/simple;
	bh=e+uzfqSHYhHZcuzfPhk6HcqcLJmcDZSMxuGGONwFE44=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cwAtEdS8Qn+RUTbkEK9lccKZtwLakJBvxZ8ri7Hx8HhBbQg0a8CGkqHeYcBS8gyAvwsumbggYOXzpoKqcaMMA6Aqpo+fa2HmDqJD+Qk1HtTBJrkLxCNVlG99wNFcvOYFOxNPt3CvO5naNHyZoSMRKhBNqyRCqIA24smFa3LBBDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LBCMVcF1; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51OMIJ9V935362
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 24 Feb 2025 14:18:19 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51OMIJ9V935362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740435502;
	bh=QVRdF3EAXIHa/WOpzueNrjkWna1IYk5vm0KLQKRBt1g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=LBCMVcF1JBUzSpFQa0NclgZSN1lbJ6R8l4P7gV/GP3OfWksuvJSk8UFAnCLrz2stD
	 zfBgNKQ/2LRfu2C7llD7zbNpCRWed6pOnPU5J/rmByu17lskqRa2z1Rn4bMzv0Gtrp
	 RsTWuEFZFH9XaV0gR9XSqUCDQaZHojh1ozgY06ibIOO0Yqru+WPUEv+njgn02D+BSb
	 AxrPR7FbBtmmBrmKcGPInLjOvNUJ+QE9Q87mz2O2DxJyDTSANU+Lg2qd0d24d46W8Q
	 acNifs2uoGssEaapuK60oCfTN5FpL6SRf+yCzsC/DVfUihJLjByLPlr8GNKX3Z4pU9
	 0NfLcLSzqxqfw==
Date: Mon, 24 Feb 2025 14:18:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>
CC: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
        dmitry.torokhov@gmail.com, mchehab@kernel.org, awalls@md.metrocast.net,
        hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
        johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, yury.norov@gmail.com, akpm@linux-foundation.org,
        mingo@kernel.org, alistair@popple.id.au, linux@rasmusvillemoes.dk,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
        brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
        bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
        Yu-Chun Lin <eleanor15x@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_03/17=5D_x86=3A_Replace_open-c?=
 =?US-ASCII?Q?oded_parity_calculation_with_parity8=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4a_AnP4iqgQs7a6xAsnUFL8oZXxFcAWLmZFMm6MPF_zDQ@mail.gmail.com>
References: <20250223164217.2139331-1-visitorckw@gmail.com> <20250223164217.2139331-4-visitorckw@gmail.com> <d080a2d6-9ec7-1c86-4cf4-536400221f68@gmail.com> <e0b1c299-7f19-4453-a1ce-676068601213@zytor.com> <CAFULd4a_AnP4iqgQs7a6xAsnUFL8oZXxFcAWLmZFMm6MPF_zDQ@mail.gmail.com>
Message-ID: <B5E017BC-8BE4-482A-B1A2-3F3074968B56@zytor.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 24, 2025 2:08:05 PM PST, Uros Bizjak <ubizjak@gmail=2Ecom> wrot=
e:
>On Mon, Feb 24, 2025 at 10:56=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=2Eco=
m> wrote:
>>
>> On 2/24/25 07:24, Uros Bizjak wrote:
>> >
>> >
>> > On 23=2E 02=2E 25 17:42, Kuan-Wei Chiu wrote:
>> >> Refactor parity calculations to use the standard parity8() helper=2E=
 This
>> >> change eliminates redundant implementations and improves code
>> >> efficiency=2E
>> >
>> > The patch improves parity assembly code in bootflag=2Eo from:
>> >
>> >    58:    89 de                    mov    %ebx,%esi
>> >    5a:    b9 08 00 00 00           mov    $0x8,%ecx
>> >    5f:    31 d2                    xor    %edx,%edx
>> >    61:    89 f0                    mov    %esi,%eax
>> >    63:    89 d7                    mov    %edx,%edi
>> >    65:    40 d0 ee                 shr    %sil
>> >    68:    83 e0 01                 and    $0x1,%eax
>> >    6b:    31 c2                    xor    %eax,%edx
>> >    6d:    83 e9 01                 sub    $0x1,%ecx
>> >    70:    75 ef                    jne    61 <sbf_init+0x51>
>> >    72:    39 c7                    cmp    %eax,%edi
>> >    74:    74 7f                    je     f5 <sbf_init+0xe5>
>> >    76:
>> >
>> > to:
>> >
>> >    54:    89 d8                    mov    %ebx,%eax
>> >    56:    ba 96 69 00 00           mov    $0x6996,%edx
>> >    5b:    c0 e8 04                 shr    $0x4,%al
>> >    5e:    31 d8                    xor    %ebx,%eax
>> >    60:    83 e0 0f                 and    $0xf,%eax
>> >    63:    0f a3 c2                 bt     %eax,%edx
>> >    66:    73 64                    jae    cc <sbf_init+0xbc>
>> >    68:
>> >
>> > which is faster and smaller (-10 bytes) code=2E
>> >
>>
>> Of course, on x86, parity8() and parity16() can be implemented very sim=
ply:
>>
>> (Also, the parity functions really ought to return bool, and be flagged
>> __attribute_const__=2E)
>>
>> static inline __attribute_const__ bool _arch_parity8(u8 val)
>> {
>>         bool parity;
>>         asm("and %0,%0" : "=3D@ccnp" (parity) : "q" (val));
>
>asm("test %0,%0" : "=3D@ccnp" (parity) : "q" (val));
>
>because we are interested only in flags=2E
>
>Uros=2E
>

Same thing, really, but yes, using test is cleaner=2E

