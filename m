Return-Path: <linux-wireless+bounces-12271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3288966B2B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 23:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886E41F216E5
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3EE1BFDF9;
	Fri, 30 Aug 2024 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnwc36Yu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B10A1BF7E9
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052202; cv=none; b=YGkJwtlYNjS48NAd6/w5SS1MFcB1eoJrjd/hq/sIxd/EX97DTNwB0omWuqu2VdgDem1El62EWxz7Ou18GqJ3eEea9BnxEH3/xDupXrZs14/2R6soKUHM9zGCvrpogpgg9Ky4Qyj4IhY60wR9Y/gV5hRCQwNL6JENAYL/WNEksyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052202; c=relaxed/simple;
	bh=cTYjMFVOgYyrkngLcUpXkcONj4+fFTtznVi1bqS2uu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUWGjYHWrbS7ojaDe7FzS7fS9nai6GvW94FBejT9LqZ/WGIJWZRdS7fb6syCOwH50BtirObO7S9ILVrewO+TFg3MIjAp7o8XZhxVBzGJd6t8DdUBbnKVM7EBdpXqweS4n9e+sS9Hsfch28L7RQOmOXzQi0/9lVD3b4GRjGr/xBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnwc36Yu; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2704b6a6fe6so1295847fac.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 14:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725052200; x=1725657000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QHhPXpqvc5alpOFw6xonRXbn89iT+88IEMQcmla/uHE=;
        b=Dnwc36YueDDGogfQSYwLzNnI/gftLyZNiZGhUei+TJlirzgO4yEKOBxbQDJ41in5+u
         AVi1VpsSX1HUMecFSSlOMdS647MeIsyfrm3vDnvH5Wq8V76QsCzvXYcbp06FWwAkRDBZ
         2QrqOAbgUE6Y3hTd0N0bV6whszc81QVBg7YOHQMdkFejk3cyOSglCQ+D2iFZB4Fbkngi
         y+VDbWL0ux9LeqOS/Ctr0oPtGODUQlF6CIKWEvTfTjQnGMvGwQwryphmpp2WWW0vou90
         /inMm9dqryQHIBFTLnaEhQOnA9iiSC2bcgAM+OnmUTVlLyMb9FtyvWL8pY8uPa6ChswY
         jKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725052200; x=1725657000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHhPXpqvc5alpOFw6xonRXbn89iT+88IEMQcmla/uHE=;
        b=UP6xl5BJM2cSeBXkFRXGRu7KBrMy6M05sYLLTDSQpyEiDLDe7ISo8wRxaeHpNC9odM
         E5+SRlVhsqfYUVEy7HTMODvPImCTkkeGsAJ5Ax1FHfSyvsVU+9ZixnCZQ72JvXl+5Njx
         SHwBKtwMhFHqb/ajiZJZLTReM6RO4neC1hY6MOXmYBdaxRlM12da1jzVkf+L+mHNc3tR
         lb8QVYxX+9L3f70Diyu8pmWBtSuqioUJdLVcRtZXK6JkoF1hNbT6YY/vC+ddvqn0DUDa
         e21cQUM4MQxZfgasPS+XrcgdS/ASNm1A39m5L3t9Gy3DZ1OGoOmjNqxbMZZFjkhYwH4l
         f//g==
X-Gm-Message-State: AOJu0YzmvpyREXNcPRczdZpirLUyQ1zsV7UZ16vuYWYXooEr8Kuwd1rE
	SWyUHDwLPIfHsOoAUmOUWX5Seo5UUtUdopAX87ERdvxG8valyqTTU6/Z1ywdGXEpdCRlv1PUbL/
	wcOH0+mY40H5dIrTUUZJjhurEm6ugxmiK
X-Google-Smtp-Source: AGHT+IH5p6cw4r5vuVL2C6TTHCqdaSh3ZTFuvaIoaCvK+fn5Ki3inkhobK2kwOGuOX2ijOyJUVL7Q+mEEoAJq6SpSqQ=
X-Received: by 2002:a05:6871:60c:b0:270:f59:420f with SMTP id
 586e51a60fabf-277900f63b5mr8168491fac.15.1725052200034; Fri, 30 Aug 2024
 14:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHrUA36mW-M-5jaqnFguM+3_kc9Uki1b++v4nQOeQ11iba84yQ@mail.gmail.com>
 <e67b169cd27445fdbeb627c5ab6165d1@realtek.com>
In-Reply-To: <e67b169cd27445fdbeb627c5ab6165d1@realtek.com>
Reply-To: linasvepstas@gmail.com
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Fri, 30 Aug 2024 16:09:48 -0500
Message-ID: <CAHrUA34Xps5xhJX8N95t7L2sGPk_mqy6tpz2vkPkfkZ2S487TQ@mail.gmail.com>
Subject: Re: rtw88_8821ce (sometimes) fails to wake from sleep
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks for the suggestion; It doesn't change anything, Just to be
extra-sure I recompiled with .config
# CONFIG_PCIEASPM is not set
to eliminate some odd corner case.

One reason to think it's not ASPM is that the network never hangs
while the laptop lid is open (i.e. not suspended to disk.)  (And I've
left it running for months w/o any problem.)

When I do go to close the laptop lid, the one reliable work-around is
to just disable wireless (via GUI pulldown menus) before the suspend.

Guessing wildly, I started looking at `rtw_core_stop()` in main.c I'm
guessing that some TCP packet arrives in the middle of that sequence,
gets stuffed into some dma queue or whatever, scrambles the hardware
state in some way that prevents D3hot from working correctly. Or
something. I'm just guessing.

-- Linas

On Thu, Aug 29, 2024 at 10:37=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>
> Linas Vepstas <linasvepstas@gmail.com> wrote:
>
> > [  364.001579] rtw_8821ce 0000:01:00.0: Unable to change power state
> > from D3hot to D0, device inaccessible
>
> By the clue, I suggest to turn off aspm by:
>
> Add a configuration file at: /etc/modprobe.d/70-rtw88.conf
> with content:
> options rtw88_pci disable_aspm=3D1
>
> Please shutdown your system to ensure resetting hardware states.
> After booting up, doing 'cat /sys/modules/rtw88_pci/parameters/disable_as=
pm' to
> ensure that above setting takes effect.
>
>


--=20
Patrick: Are they laughing at us?
Sponge Bob: No, Patrick, they are laughing next to us.

