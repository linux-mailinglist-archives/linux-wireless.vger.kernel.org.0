Return-Path: <linux-wireless+bounces-2666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 026218404DE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 13:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC1CB219F0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB385EE89;
	Mon, 29 Jan 2024 12:22:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C44604CD;
	Mon, 29 Jan 2024 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530961; cv=none; b=Wcqj6+I7fKs6U2/2kSjjaL3q2Ct8RKGjxnWYv3AqUn8CIbZwGQ4qR2+yOmqGT/qRM/Hvg2LPxKH+G14ltUCLFbQN/L7g3GNI9IqgP4crsYdoSIE9HD2uH0yajMt5zqtXH5K01pzucOyhxtbZo0knn3JF9i5Gixkf/vHkQtBUA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530961; c=relaxed/simple;
	bh=7jR4sLhFOaf28/S/lK56XEjGNCcduna82E4wAQtQHSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdAmcQhhOfaQegiPk7cSA4xWmvcIr3oxRZe5CFM7wSYDXky0o0WIt8z2JJl0oY59pMA1NObUnPMX75u2u+85f0V3jt8anbcoJgkfpu0wxFAjPkb4RtRxAw++aaBljH+qZt7XMihLKlAr0Dq/sQNZB5vmmgPVuMcxMuwbFwJtr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5958b9cda7aso669890eaf.0;
        Mon, 29 Jan 2024 04:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706530959; x=1707135759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jR4sLhFOaf28/S/lK56XEjGNCcduna82E4wAQtQHSA=;
        b=HQvZC885V7eLdscqTkS7QlWjHGqDCdgfXa9p/W/ZKj/qe/aFynCMr2lafBqk3LFujT
         +BeqFv5DJYUIbdlT+VRS2QmDLc4hK6nK8UnT/82LUzgVv5uWlHNDLUascvS+7UbBtpJf
         I3Ux8TfNfn2SSio1FvE0glu5PwCcYqgXSNNX0i0qtTWDkXKPqtBcdz7FK/dtp1wSyOK9
         ToDYLUnFtzC5Bk7AGjEFVa84wLUq8AONRcOYEL8k4YyQIB90WTY8py3LlHTzDCGUT2jz
         OK/7AjvjpgVYRISuQz2cp5MpJ7kg6sVzYhQHtzr3J/2j+T3EdHyImaqDSjG33OtUyo/G
         FF1w==
X-Gm-Message-State: AOJu0Yyii3hMFjUu2vilraS++ttK94rppzLS7OB9+8k6MoVcqM3bYVeo
	eoBpB5uq/PoeG7wWlWChijSzoyvP3yU0a89ZHurQawI2A2ya3LreCMP31QPFM0mUzjvHFNZe14/
	DoE5FaCGISugOUEFp5yF0LPjO/dk=
X-Google-Smtp-Source: AGHT+IHC5vEWdAaEASgOju0Y7p+W+6LnfFDAlz/L32dm7GY5shRYFtdOnTyhDvpY1xXovAJ1qQu7h2aI9BEM9aV4q/s=
X-Received: by 2002:a4a:bd8c:0:b0:59a:bfb:f556 with SMTP id
 k12-20020a4abd8c000000b0059a0bfbf556mr6398581oop.0.1706530959073; Mon, 29 Jan
 2024 04:22:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <21cd2098-97e1-4947-a5bb-a97582902ead@quicinc.com>
In-Reply-To: <21cd2098-97e1-4947-a5bb-a97582902ead@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 13:22:27 +0100
Message-ID: <CAJZ5v0inw7pZR3-fNz9H4BdAXtVawN8m7dsDi6CeBxK2tnNGVg@mail.gmail.com>
Subject: Re: ath11k resume fails due to kernel blocks probing MHI virtual devices
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: rafael@kernel.org, pavel@ucw.cz, Manivannan Sadhasivam <mani@kernel.org>, 
	"Kalle Valo (QUIC)" <quic_kvalo@quicinc.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	linux-pm@vger.kernel.org, "kernel@quicinc.com" <kernel@quicinc.com>, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:10=E2=80=AFAM Baochen Qiang <quic_bqiang@quicinc=
.com> wrote:
>
> Hi Rafael and Pavel,
>
> Currently I am facing an ath11k (a kernel WLAN driver) resume issue
> related with kernel PM framework and MHI module.
>
> Before introducing the issue details, I'd like to summarize how ath11k
> interacts with MHI stack to download WLAN firmware to hardware target:
> 1. when booting/restarting, ath11k powers on MHI module and waits for
> MHI channels to be ready.
> 2. When power on, MHI stack creates some virtual MHI devices, which
> represents MHI hardware channels, and adds them to MHI bus. This
> triggers MHI client driver, named QRTR, to get matched and probe those
> MHI devices. In probe, QRTR initializes MHI channels and finally move
> them to ready state.
> 3. Once MHI channels ready, ath11k downloads WLAN firmware to hardware
> target, then WLAN is working.
>
> Such an flow works well in general, but introduces issues in hibernation
> cycle: when preparing for hibernation, ath11k powers down MHI, this
> results in MHI devices being destroyed thus QRTR resets MHI channels.
> When resuming back from hibernation, ath11k powers on MHI and waits for
> MHI channels to be ready in its resume callback. As said above, MHI
> creates and adds MHI devices to MHI bus, but they can't be probed at
> that time because device probe is prohibited in device_block_probing(),
> finally this results in ath11k resume timeout.
>
> Now there is an potential fix to this issue which would needs changes in
> MHI stack, i.e., don't destroy MHI devices while hibernating.

Exactly.

> And we have had a plenty talk with MHI community regarding this change, s=
ee [1]
> and [2].
>
> However Mani (the MHI maintainer) doesn't think it's right to fix it in
> MHI stack. Instead, he thought we might need to add a new PM callback
> which will be called after device probe is unblocked. By registering
> such a callback ath11k can wait the dependency driver, i.e., QRTR, to
> probe and initialize those MHI devices.
>
> Your thoughts?

I'm not quite sure why do the pointless device destruction and
re-creation in the hibernation frlo and add a new callback to the PM
core to work around this.

It doesn't sound like a straightforward approach to me.

> [1] https://lists.infradead.org/pipermail/ath11k/2023-December/005098.htm=
l
> [2] https://lists.infradead.org/pipermail/ath11k/2024-January/005205.html

