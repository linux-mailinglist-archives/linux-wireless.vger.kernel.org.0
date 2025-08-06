Return-Path: <linux-wireless+bounces-26187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70BAB1CC6C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 21:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815E2627086
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 19:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE2C482EB;
	Wed,  6 Aug 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtTn6aD4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB37846C
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507939; cv=none; b=Gx+mMgVKq7Q/AvuyYe0KlubVdvYyuEFDBhBcDiYsXC7F+lfA3uoVylzBDJV/+9kqYDogRAFnqjVBY6krXyl6YGbmFllK8mr2cHjwGREQKD703qAyc5R9rDTue4XgR06jvksfcmt1jSZK789YLHETD4R9sxI0DlxmkcoN3J5XbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507939; c=relaxed/simple;
	bh=GzGjuxWtKqcqG7Rp7vG/TfgqQxO5U6u2y+XzK2NJAO0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b2iGa0soWmgggu34HJZmuhwNP5WH6gTqCk/PTYnLojdONC3f51vl4BugigihoQU68TORZ+OQ228lvwxDwEd6XVp/M6CG4vLcQvu0i9KeqMZl0rymqK6PaKPHfOHxQZBWi616QzZ6fiZIiYb7W+FEp/8sIyhIlUfi9BwwI1efWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtTn6aD4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so2433585e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754507935; x=1755112735; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzGjuxWtKqcqG7Rp7vG/TfgqQxO5U6u2y+XzK2NJAO0=;
        b=JtTn6aD4VnZCP5GDl7ug8cqW95bHAr5N93gCyr/3I3hlRzOqTZ2DEos6a5ryHKaM5t
         N9U/63UCrY8ZcKQ6BhT930UKIvfAry63/5jwu2oS2cRe7x1aPPLKy6hSdmulMOItREPg
         kAR2wOdeawxeRsvYG0dP+9JfPjYT44Mii5koU82k7Y7zbl1v7Ai2h9mhEDPv+CES0xqC
         KZpJ0Drks/Gjg9GsN7AyXyBWEgMWiepZnzuNMkTokMuiMpx73WQc8SXATqZ6pNWFeyIq
         y1JZLVO2baDjOskRF1HhBiWLgCaS7udzXtq/CrG/RQI2zLp+MxvhAej8T7qn+VxIPNgl
         aNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754507935; x=1755112735;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GzGjuxWtKqcqG7Rp7vG/TfgqQxO5U6u2y+XzK2NJAO0=;
        b=bBLSYGQlwKlASTd1rmZZoukX6dXSeNk1nRo2M03Lndq3msR4a9CyFYfRJ42m1yCkns
         0Zk2i/2MvwH2cnY3BZmUBJ6Qyie8ih86qIgceDgu/3JQzaPFEvTdAZaE6lGp1kRHmxD8
         FJWjqUHa8PQu1ryEK8Rehh6+cNWo+/8h/fR/HKU1t8+4L85dHD+PlDf2ZayDYulp7V+K
         0KeFiNbjDcx2wc6jTAw3St7keLw7wjJRgralPDsVBpYSxsUI74q2IbbX0sjxgb/5pRH+
         jIXZzlcjkWWrUQaFAr35OEfUhr3nuOa2rHQc+d02wrf8MyUlt5QbS58fh7c2E+gw0vJU
         +J7g==
X-Forwarded-Encrypted: i=1; AJvYcCW1uaerQeWRF+iTe0RLa15uglNgiTSxL1ofgUzTUR1QFxlx73n9t9Ia1mLOty0gbB1oktafeT8aG1AODPKRGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6siV6vGKGsB6nac44C1bX500v/jZ3shQ2Gf6EZh2rMsL01nA0
	aDTgGiO4T3uV9KHlGH/PN79Aby6OnVWzIHR/80cCogB+6O5DQeth0DlX
X-Gm-Gg: ASbGnctN0Y8VbHxRWH7ufGfrvP7AA1y9XCoPjFg2zChbLS5rtVzzsDuHeeMbCyY6/lV
	aRuzMGCIe6n4r95peqitLElSugEy8DhxY0WNjgHmzECMTlzljtU4UvIE7Mkehn8AswpQ4Pu5ZAk
	T6mAleMLdi7q3uOFMhZsj2CIq6t13IX9K/wvfjEoU9WV7kiMhOUNiugByhxewEd+kILcXGv50Mk
	h4EMkfiTxPeNNNFvLU41yr5yi6jzuf0iboMG4Bvdlw6PuQaBjelJ9ocobm+5iw5xJMiu55CVNyz
	xE3IpQpQkq1CmZn7VFr06ricHxSqpA70Atub6lg+bc2ZwCz8CAX0NzunMCveaG6gkTWHFaJrcLf
	26v29GjRAkmtf+o0kQ5XwsLVnvWxYHcZMeuODroT9
X-Google-Smtp-Source: AGHT+IHxvW57SiNdcyvgwfl2jMzjM6r+hMeiGssjjfrnWxRobn0puQ2J2xbPfNosoXmndruPed/DSg==
X-Received: by 2002:a05:600c:840f:b0:456:25aa:e9b0 with SMTP id 5b1f17b1804b1-459e745c61amr42860255e9.16.1754507934546;
        Wed, 06 Aug 2025 12:18:54 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453d6esm24091921f8f.37.2025.08.06.12.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 12:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 21:18:53 +0200
Message-Id: <DBVL5LLQ6PN7.3UAL98HQ7TMIU@gmail.com>
Cc: <jjohnson@kernel.org>, "Remi Pommarel" <repk@triplefau.lt>,
 <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>, "Loic
 Poulain" <loic.poulain@oss.qualcomm.com>
Subject: Re: [RFC PATCH] wifi: ath10k: support flush_sta method
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Zhi-Jun You" <hujy652@gmail.com>, "Jeff Johnson"
 <jeff.johnson@oss.qualcomm.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250806070005.1429-1-hujy652@gmail.com>
 <29ef8aab-06a3-48e2-a370-86b1b2107143@oss.qualcomm.com>
 <CAHGaMk_rMCoWDzKtxgsg9GkH0s-U540zYq_AOC9HpBo_JF7qJg@mail.gmail.com>
In-Reply-To: <CAHGaMk_rMCoWDzKtxgsg9GkH0s-U540zYq_AOC9HpBo_JF7qJg@mail.gmail.com>

On Wed Aug 6, 2025 at 5:51 PM CEST, Zhi-Jun You wrote:
> On Wed, Aug 6, 2025 at 10:23=E2=80=AFPM Jeff Johnson
> <jeff.johnson@oss.qualcomm.com> wrote:
>>
>> On 8/6/2025 12:00 AM, Zhi-Jun You wrote:
>> > When a STA is marked as no longer authorized, if the driver doesn't
>> > implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
>> > flush hardware queues to avoid sending unencrypted frames.
>> >
>> > This has became a problem for ath10k because ieee80211_flush_queues()
>> > will stop all traffic and call ath10k_flush, which waits until the
>> > whole HW queue is empty. In a busy environment this will trigger a
>> > timeout warning and stalls other STAs.
>> >
>> > Fix this by implementing flush_sta method using WMI command to flush
>> > frames of a specific STA.
>> > Flushed frames will be marked as discard in tx complete indication.
>> >
>> > ops->flush_sta will be set to NULL if htt.disable_tx_comp is set to
>> > true.
>> >
>> > Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00157
>> >
>> > Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
>> > ---
>>
>> There is already a patch from Remi pending for this, see:
>> https://msgid.link/cover.1732293922.git.repk@triplefau.lt
>>
>> Please see if that series addresses your needs.
>>
>> First Kalle, and then I, held this back due to lack of internal validati=
on
>> across supported platforms, but it is actually still on my TODO list:
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D91185=
1
>>
>> Let me make one more validation request internally since I know there is=
 at
>> least one ath10k-based project with active development.
>>
>> /jeff
>
> Hi Jeff,
>
> I am aware of the series and glad to know it's still on the list.
> I did test with it but the warning can still be triggered easily with
> the instructions in Remi's series.
> And according to other people's reports it can still block sometimes. [0]

Well that's to be expected with this implementation and the use case descri=
bed
by remi. You have a station that is out of range or powered down without te=
lling
the ap, and you wait for the firmware to tell you that it did managed to
transmit to the sta or that it has given up transmitting. So clearly you wi=
ll
have the warning.

The goal was to not block trafic pending for other STA when that happens.

What I recall, and sorry if this is vague it was quite a few years ago, is
that when issuing the WMI command to the firmware to drop all frames for th=
e STA
it just did not, and it was still trying to transmit them (checked with ota
capture at that time). But I do not recall if the firmware tried to send fr=
ames
encrypted or not (as we would remove the key right after the wmi command an=
d
before the firmware had given up on transmitting the frames) which was one =
of
the reason .flush_sta() was added in the first place I believe.

>
> drv_flush_sta() is called before clearing the keys and Remi's approach
> still waits for the frames to be sent which imo isn't enough in this
> situation.
>
> [0]: https://github.com/openwrt/openwrt/pull/19427#issuecomment-310279479=
3
>
> Best regards,
> Zhi-Jun You


