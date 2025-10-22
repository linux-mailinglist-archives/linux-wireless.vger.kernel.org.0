Return-Path: <linux-wireless+bounces-28173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC8BFB5A9
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 12:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 999294FDA67
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B13161A0;
	Wed, 22 Oct 2025 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtWmdAbe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF635315D41
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128090; cv=none; b=WVl64Kadp/ud1c1eR2cjE7pMseZK7PrjI66TCojBnxAc/9ig5u2SLYxac2cGqNezsd7479++tq/SO4rom+Qnepao7IM1VkNoQPfhmODOvZey8f1+oezBcidple4/Gmx9QpprQVFb6/mq297qKo78FSZkmnE0vxH6Ff4g8eViRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128090; c=relaxed/simple;
	bh=fmPj26op52izc1UGOmKv4+NJ1O9NjhtbeYL3VjKEnGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=redepqsh0sczMZietWEEaNfWH97lg3//mJ/EpqEzfzjrCsCtPQzqJmgvdCxtZsfmKxv1P8KwUhlIlEw2AptrkQfwooYsFRybU1J0vP2ZDnPNaAXCaMmwH70uKSZznfwOs4V7Hbqh492WDIIzhhAuVABJmoCDdZdo6rLiprAIcq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtWmdAbe; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37777912136so64808241fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761128086; x=1761732886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmPj26op52izc1UGOmKv4+NJ1O9NjhtbeYL3VjKEnGE=;
        b=NtWmdAbe7H0XSxfB6NH+1E5h/jePGLR0I+f/mhb7ZzAgxL9fykIIVwdKubU6kofX5j
         8IvzuHN83uW+Ok8ZiHmCv6rKGZ3rNGzYKF6ynIwYXcu5PKYMsAsOBnF3pI/Kn4o2eWZD
         XZHwC3RUr+yGFUTCS4hTagwRWF/J5FBhiGo28Y8WDyZa2Xv05GFR6PRGBIqZZPPkvrid
         ApjDU7cgoNk6qdL6pj2sC4uI/08xB0mSR0fwPsRCkQepshnxTgun2ojN3uyShk6YqHne
         JwhAkm4LtUTSqwvTvvfZbfuhXOStBXs4M7m/d8RppTcheVfHuOR305G60sIDftY5h8oi
         gpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128086; x=1761732886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmPj26op52izc1UGOmKv4+NJ1O9NjhtbeYL3VjKEnGE=;
        b=M4+3cGyYKptsZg64DENqO1Ayt0KTyPm1Ix4TKGT/+HwH6H3kA/S8IXKdz0P/fp6gvn
         jD4rbqUspLxJNxOUXEWbWzMbp5i5mf+dGBifRCfQwnM+3YkvfPMt32D2wCeTYW0xWVlR
         xpmXKe8AV8ehPMiZignuFVGsTRvO7xbtnNbXGRVyWDIuzBYjkIwyZuEpwzcfBSZ1G0tb
         691dOYUznEB6SVru5oQBp5LlKcO4mOJfZRTZ22m7lCi4JJUUBwR359eCyybluOQ91PbK
         fEE5j+PSrEf1VEek8RH6neeAI99fxAPoC25ZVXXZLeWrgislBmmv9WDmEPjYVBNehjOS
         Uqfw==
X-Gm-Message-State: AOJu0YyNAMUwj8vTzR9h+7AwXAAmCZSWurqF+sSpNQEhOG8kMkb9GLQ0
	layzBOD9a7QCudCRawHWGLk/pG38uo+zMJrshNiao8uuNcHATGwjYfwg1v9zZAmNFCC4CNgYC3C
	VW/fQju0DxfZuhlu5TGyfywpLSm1VzuI9EDAX
X-Gm-Gg: ASbGncsWSxCpa3GJ8AU3CH5yLZiWOKWXGZkONiFAqWZu03u221Qj7Jfo2ZsHs9CnFFF
	PCJZm/ksN/L99np685x0GVQoanR4Euuinc3E3dGX5OcvoBUKglRwv+j+vGbIUOQZY+LoQnJHB1N
	5zqP6JLIO3Q876pjfj7wtKmos7fFHAvLeIjz28s++6Cwmi9Fjysj92CUuMXAasMYpOkiEM0nLZJ
	YXn4bdHSgA7DlBF4NXwrqEiOko3TIulDmybuWstpPQ50Vx+IILK+PlVjz79DoCW5MA9YJm3PMnw
	FMaQfB+0iz1BHRuGjQ==
X-Google-Smtp-Source: AGHT+IGpRAGcgMzpy5zYAGnxQjHRBk5ftHK5R+tVZQ/Nyxg1n0MvYmTnrik3WyVAnbQ+pvVTtL+iVUsWfu9PvldFuR0=
X-Received: by 2002:a2e:a803:0:b0:360:e364:bb3d with SMTP id
 38308e7fff4ca-37797637a81mr62862361fa.0.1761128086241; Wed, 22 Oct 2025
 03:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <32dce695-4b41-46fe-a31e-33d86fefc107@gmail.com>
In-Reply-To: <32dce695-4b41-46fe-a31e-33d86fefc107@gmail.com>
From: Avamander <avamander@gmail.com>
Date: Wed, 22 Oct 2025 13:14:29 +0300
X-Gm-Features: AS18NWA93sEHOCg2WAjgBtT1hAwxhB30YpiD7zoXYbKNt2QS-RRnxet0k-ACDRQ
Message-ID: <CAPLrxsEkpeCLLJtSd1BqVdtYWBrCndVwTJRZzqcCtEefzg=NOQ@mail.gmail.com>
Subject: Re: iwlwifi: bad HE/EHT 6 GHz operation
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have a strong suspicion that "[PATCH] wifi: mac80211: Try to
overcome bad HE operation in association response" might be the patch
that tries to work around this issue.

> [...] they advertise invalid 6 GHz Operation Information in their HE oper=
ation element in the association response. Since the information is invalid=
, mac80211 cannot connect.

I would really appreciate it if it could be clarified what exactly is
incorrect in the HE operation element in the association response (and
why everything else seems to ignore that error). This would make it
possible to actually inform HP/Aruba of the issue and maybe get them
to fix it.


On Thu, Apr 10, 2025 at 8:15=E2=80=AFPM Avamander <avamander@gmail.com> wro=
te:
>
> Hi,
>
> I was trying to connect my PC with an Intel AX210 card to an Aruba AP-655=
 on the 6GHz band with 160MHz bandwidth. Unfortunately this results in the =
following kernel log messages:
>
> wlp4s0: bad HE/EHT 6 GHz operation
> wlp4s0: AP appears to change mode (expected HE, found legacy), disconnect
>
> I'm currently running 6.11.0 (-21-generic #21-Ubuntu), with matching iwlw=
ifi ("driverversion=3D6.11.0-21-generic firmware=3D89.202a2f7b.0 ty-a0-gf-a=
0-89.uc"). The network however seems to cause no issues for macOS devices.
>
> I've captured the beacon frame and it contains the following HE 6GHz oper=
ation information:
>
> Control: 0x03
> Primary Channel: 69
> Channel Center Frequency Segment 0: 71
> Channel Center Frequency Segment 1: 79
> Minimum Rate: 1
>
> There's a very similar (and singular) issue on BugZilla (219159) also con=
cerning operations with Aruba AP-s. But it seems that it's not exactly the =
same. First and foremost, the CCFS0 and CCFS1 seem to be correct in my case=
. 71 is a valid 80MHz channel, 79 is a valid 160MHz channel. (As per 802.11=
ax-2021, CCFS1 must be greater than zero and the absolute difference betwee=
n CCFS0 and CCFS1 must equal to exactly 8, which seems to be the case.)
>
> Commit 91b193d546683558a8799ffb2e2f935d3800633e seems to be the most rece=
nt one that seems to directly adjust this logic. Manually checking all the =
channel/AP parameters against these new checks, everything seems to be vali=
d. But as this code does not log which exact check failed, it's very diffic=
ult to say what's going wrong. (Given the relative complexity of this I ima=
gine more detailed logging would be handy for many.)
>
> I would really appreciate any help debugging this.
>
>
>
> Best Regards,
> Avamander
>
>
>

