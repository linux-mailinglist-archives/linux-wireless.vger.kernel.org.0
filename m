Return-Path: <linux-wireless+bounces-2668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8416E84051C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 13:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76171C21E8B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B476560EE5;
	Mon, 29 Jan 2024 12:37:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271C160EDA;
	Mon, 29 Jan 2024 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531875; cv=none; b=skUSP5RNzhBusRJ8Gvgizymj+sSZL9motDDHAD5xBcRYsnyy9ahz/g4QRXf8oOq1l/YiECyxj9ztCkOujya61NE6CDyjUq7k6op0bIuKpzn/1UD2FBAUz1ZyaM3tuKhIhMK5rMS+f+6JCbV6bfJoT9+07dIIvQcSoNoEa86o3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531875; c=relaxed/simple;
	bh=E20ljoxsFmC9OjWcrOT5PYxf5yi1ZSxFrX5OnrOJQR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftqAlj02tdm0gfMrL/8L8fW0OD4qVgD+iq0WGjSxlOyzyPNJ0Vv6B0r4T3PkyIvwQfPN9slh1Plt0g15JTp0ft3qlPwqZ0nv6calHKI/AFmWGl3GPEa2ukvCBcZxhfWRgjUmMZqi3dnqyhcKVgroG/QBKFtTXmIF3VfYCfxDqaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5958d3f2d8aso336866eaf.1;
        Mon, 29 Jan 2024 04:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706531873; x=1707136673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E20ljoxsFmC9OjWcrOT5PYxf5yi1ZSxFrX5OnrOJQR0=;
        b=X27/zzsFx/mj5JWsrVR7baN7kVjO/KHSec6eeJL4XA9XXRGSca4jDRVWKVrOpO9BAt
         25igCkM0Z6PJQvkLOjXdab67xp5KyF7offzaXaSmYBnZs2aCbfKfXHs6wPVPYshAoHGx
         pLU3qwYR6rYeencomw9Ldc8u9ZowXGIXRqxLXB+fMDV6JXtEw7nEWSpMZvKXx4E8cuX5
         WAULMKsbHJUIRJ8BJKivNwP1W47DNT+PcVkAHjcCgujVtRfnTisDcpYZJQ/rDFY3I3c9
         GMuSorqo47p2lg2836v5e0yTgHE6dNrIJK6jQmDpYWx/9jZNr3jlV6lIYKsVLp4Mhplz
         fXLA==
X-Gm-Message-State: AOJu0YxsVa48crIo1DJmIDR5A7F0SVQWOTgEOxqtmOxNZbFKOpQdOtll
	zuM+ji3jN3lrelSAEneefdK0goGouKuVMcf9S2XdAoZ4bnp+w8OvYK+H3GOnrISkfA3n+CJ15d1
	gpTjUmxTRc7NHfRJKGyh1ZFn13ew=
X-Google-Smtp-Source: AGHT+IF4TzOQyKTVq1JITmCvWQkFxvLTGWLetNQry01izCJUwI6kK2DrPgFDaO//y+LspyrAmDcjxe6YOJSABBKvBVU=
X-Received: by 2002:a4a:c48a:0:b0:599:fbcc:1c75 with SMTP id
 f10-20020a4ac48a000000b00599fbcc1c75mr6123515ooq.0.1706531873159; Mon, 29 Jan
 2024 04:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <21cd2098-97e1-4947-a5bb-a97582902ead@quicinc.com>
 <CAJZ5v0inw7pZR3-fNz9H4BdAXtVawN8m7dsDi6CeBxK2tnNGVg@mail.gmail.com> <20240129123112.GA22617@thinkpad>
In-Reply-To: <20240129123112.GA22617@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 13:37:41 +0100
Message-ID: <CAJZ5v0jQOgK==fpYjoQ3+=1oOzPHCasYeTyKW9NniwYUpXZE=Q@mail.gmail.com>
Subject: Re: ath11k resume fails due to kernel blocks probing MHI virtual devices
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>, pavel@ucw.cz, 
	"Kalle Valo (QUIC)" <quic_kvalo@quicinc.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	linux-pm@vger.kernel.org, "kernel@quicinc.com" <kernel@quicinc.com>, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 1:31=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Mon, Jan 29, 2024 at 01:22:27PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 29, 2024 at 11:10=E2=80=AFAM Baochen Qiang <quic_bqiang@qui=
cinc.com> wrote:
> > >
> > > Hi Rafael and Pavel,
> > >
> > > Currently I am facing an ath11k (a kernel WLAN driver) resume issue
> > > related with kernel PM framework and MHI module.
> > >
> > > Before introducing the issue details, I'd like to summarize how ath11=
k
> > > interacts with MHI stack to download WLAN firmware to hardware target=
:
> > > 1. when booting/restarting, ath11k powers on MHI module and waits for
> > > MHI channels to be ready.
> > > 2. When power on, MHI stack creates some virtual MHI devices, which
> > > represents MHI hardware channels, and adds them to MHI bus. This
> > > triggers MHI client driver, named QRTR, to get matched and probe thos=
e
> > > MHI devices. In probe, QRTR initializes MHI channels and finally move
> > > them to ready state.
> > > 3. Once MHI channels ready, ath11k downloads WLAN firmware to hardwar=
e
> > > target, then WLAN is working.
> > >
> > > Such an flow works well in general, but introduces issues in hibernat=
ion
> > > cycle: when preparing for hibernation, ath11k powers down MHI, this
> > > results in MHI devices being destroyed thus QRTR resets MHI channels.
> > > When resuming back from hibernation, ath11k powers on MHI and waits f=
or
> > > MHI channels to be ready in its resume callback. As said above, MHI
> > > creates and adds MHI devices to MHI bus, but they can't be probed at
> > > that time because device probe is prohibited in device_block_probing(=
),
> > > finally this results in ath11k resume timeout.
> > >
> > > Now there is an potential fix to this issue which would needs changes=
 in
> > > MHI stack, i.e., don't destroy MHI devices while hibernating.
> >
> > Exactly.
> >
>
> During hibernation, the power to ath11k could be lost and in that case, t=
here
> will be no channels available from the device. So keeping the "struct dev=
" when
> there is no real device attached to the system, goes against the driver m=
odel
> IMO since we would be messing with the refcount.

But this is system hibernation or suspend and the reason for the power
loss is quite different from device removal at run time.

The device is going to be back during resume (or at least it is not
expected to go away in the meantime), so it is pointless to destroy
its representation in memory.

> For instance in the case of USB, if the device get's unplugged, would it =
make
> sense to keep the "struct dev" for the device in kernel in a hope that it=
 would
> come back again?

At run time - no, during system suspend - yes.

It is not even recommended to free IRQs during system suspend.

> The driver model as I understood is, once the actual physical device gets
> removed, the refcount for "struct dev" should be decremented and it shoul=
d be
> destroyed.

Not really.

Thanks!

