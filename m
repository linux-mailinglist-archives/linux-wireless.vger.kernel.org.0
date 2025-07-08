Return-Path: <linux-wireless+bounces-24902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9A6AFC1BC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 06:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D418C3A5201
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 04:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A89E207A18;
	Tue,  8 Jul 2025 04:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+4rHUS7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A57464
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949662; cv=none; b=HAVr+qlhhlLCdc3WOd6NIT5XYZ7t+xTixbthCH3KxHDiZVbxr7/Wg/9aAOQUWO4KlSWl7LjzHuZQS8Nrfy9ggrp/G/vSTYinR2JYK6PXR6DeRPZ8cqFEGXEZsSatolXnBmGZi3/qxW6XU1kndDnhKAzihcB+zumFfVy9PODbNm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949662; c=relaxed/simple;
	bh=pZtWdmn+kqDd5bzH+VB6lwo9p3ZNG5Nm28VFl/TVD/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQQqiEbWmoY1bFhv+y83CXt0Zft9cQHqhBOBUXSMkUSgTmx/kts+vZttTzvQYA+gLNWWgEaRCfRudvgHJ9yfgmSIdvISsVhmZFeQaQlgyZBKU8YcykRFWulHuNwy3pUNJ3BlZXU78fVk5Df5gps+1a9x9DCcNkpUIU8+in9nSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+4rHUS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DE3C4CEF7
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 04:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751949661;
	bh=pZtWdmn+kqDd5bzH+VB6lwo9p3ZNG5Nm28VFl/TVD/E=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=f+4rHUS7q4lKwExqhY5NkyuHAOlDNJajvVyhkWfbFljysGfXjug1uRy4UrurLZWRn
	 gSCHOCFqMe50y2YAYh7TV+OtYSF8XT7GW/dY2O1FYbb4tkFK2EtRmRUg5CPzBbbarM
	 gYw1Giu08dV0Uc5du18jLkTgrorsmqciWQiFDcovDzYXLRhg3+oTVkjTmfAz5BzCuN
	 sDDpaLeEEU6OVWEVztYgxazhMhjkgro5M64RG88QQVvwMcRNHTNUQi0fvyNaSf3zsu
	 inopYeoH1dTuL0wacd6bWGhugAaa9lRZIkZnKhCo+Oi3RCvXnBSkiA6aam4VnLOCSU
	 g1Tz1ltbibC1Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b7cf56cacso38741001fa.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 21:41:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWp7fmOVPi/EKYdGVU/9MjfrsFN046CRofrxkaACBc1QFOEjNDVSP7tj/vfW74y6xMSrnQoSgVelOfh7XrpXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyXugT0vYbTRrVPS3KBnR8lAEBMO0lMzjuq9FNbvulX46oG8/C
	+OkuHCSjCugibZMSBjbN8HobU9QhKhyn+pmoD54PjYT4/atPPI+RNxztoINGRRiWlRoCZbFK7WV
	Ayymm7Qi38wb+rxb91YGPeBnTgk69Dsg=
X-Google-Smtp-Source: AGHT+IHPmyk/dpxRRRV/ADdX9INgZR8DymrLu4bMgudGKQYLr+i71hUNTjWYpqdF/vslwfuvMCPwjBAHSqLI6oiBoeI=
X-Received: by 2002:a05:651c:2115:b0:32f:1c0f:fb73 with SMTP id
 38308e7fff4ca-32f39b4c69bmr3560941fa.36.1751949660034; Mon, 07 Jul 2025
 21:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1456091345.1517853.1751948346004@nic.in>
In-Reply-To: <1456091345.1517853.1751948346004@nic.in>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 8 Jul 2025 12:40:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v64awHryO6aPP+Jye_3gxGbT0j71NNnKLtar_Rwue=OmJQ@mail.gmail.com>
X-Gm-Features: Ac12FXzV2zY6rLqWvTwhHF5tzrD46c7UHOUnS_38MRI67px1_6tSimdUJ3oVS7w
Message-ID: <CAGb2v64awHryO6aPP+Jye_3gxGbT0j71NNnKLtar_Rwue=OmJQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] wireless-regdb: update regulatory rules for India
 (IN) on 6 GHz for 2025
To: Gaurav Kansal <gaurav.kansal@nic.in>
Cc: pkshih@gmail.com, linux-wireless@vger.kernel.org, 
	wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:28=E2=80=AFPM Gaurav Kansal <gaurav.kansal@nic.in=
> wrote:
>
>
> Hi All,
>
> One query with respect to adding EIRP values (or max power) in the databa=
se.
> As per draft regulations, max EIRP across different channel bandwidth wil=
l differ in 6 GHz band.
>
> Like, in 20 MHz channel bandwidth, max allowed EIRP will be 18 dBm wherea=
s for 320 MHz channel, the max allowed EIRP will be 30 dBm.

That is basically spelling out the PSD restrictions that other regulations
describe in terms of dBm/MHz.

> How we can add this info in the wireless regdb ? Apologies if i am missin=
g something.

Unfortunately the database format does not support this, so we are limited
to only adding the lowest limit.

Last I asked, the kernel has a PSD field, but it doesn't really do anything
with it. And internally I asked folks working with WiFi to ask our partners=
,
and they seem to handle PSD restrictions within their firmware.


ChenYu

> Regards,
> Gaurav Kansal
>
>
>
> On Jul 8, 2025, at 06:21, pkshih@gmail.com wrote:
>
> Chen-Yu Tsai <wens@kernel.org> wrote:
>
> BQ_BEGIN
>
> I see.
>
> I will drop this for now then, unless Ping-Ke has any more information
> on this?
>
>
>
>
> What I can find is a consultation [1] on May this year. It needs some
> time to have decision then.
>
> Please drop this.
>
> [1] https://www.trai.gov.in/sites/default/files/2025-05/CP_28052025.pdf
>
> BQ_END
>
>

