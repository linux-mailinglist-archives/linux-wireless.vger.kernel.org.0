Return-Path: <linux-wireless+bounces-26072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB23B1780C
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 23:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9EE16F53C
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 21:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D4C265CA0;
	Thu, 31 Jul 2025 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvQGE3Ur"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB55265626;
	Thu, 31 Jul 2025 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996832; cv=none; b=tJvUhAiIaVgccT7Q64qfuAoLz6OqIeUxmo5j2mOxMklcAJ2P3huqviwIOdAmtfhMAi4X3EWx6yDt1EiR1+0QVjTq21amLxa3RcgsUPuijhjk0CYrbRTLQ8p1G4UMNeQvvjaXzqN6Ewt7XUMTRWC9HD3UKAKeYmtbF62DWQ8B5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996832; c=relaxed/simple;
	bh=ymCaajYIOvdIdSPg8VNqjdX25oNynJ9eq49Th9n64yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf9gw9FNiqWyR+cwr0NdclyObukv81why7jHQZ0iAe1ywKhnSGRJ49gwRvfvD4nmaNQG0SUa9aoWjpZNBTMiTWRRH3niS9vFzcRHu8RgiBNMCWAUCuvEA2+VGSg41E8FAPBds5HVVzSWSXWfvoWRMmY9aAXkpcUY4rYK6zQlHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvQGE3Ur; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7183d264e55so16202407b3.2;
        Thu, 31 Jul 2025 14:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753996830; x=1754601630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr78egQa9CU9pRH3DKxqELY+v2oEDMraNPH15ogCD/g=;
        b=lvQGE3UrG90SSqc6pAV5bMWB2SyzQdjDAPSYoATZDvnZNUQ/TRM83RB0Ub2BX2In9g
         yZHHbO6H3Do7uPkrHcMXVP57IOTuBZt2nYZriPE4V+sDOaO4wSmmWg+s9t/3aLh4Lg4+
         FzYsvWU3SO3FyqKv2sl6864FFXAIvJzPOmwPLPr2iCaF3OwspOzseyh9mGSX0RdmCytN
         i4w2gHLqNozNFWELfOs8RH8QK9x5Oc+jN/lSGYfy99Y3qCqhFjB9Cga0o9VLwVfZOmC6
         WM1FlkWkrT2+bIkVs9z7pIn2+2/5UYECmwjDD9Yjcln3rT5PMvVSm0gPyIAixw/t9CRX
         UXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996830; x=1754601630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xr78egQa9CU9pRH3DKxqELY+v2oEDMraNPH15ogCD/g=;
        b=eQ0L6uZMEqcYM8VolGgZM51XfDFX00n0p5PxdOUdr76t1d48htMFl0Ws/cwR1lx9IS
         gteFDJo78odvkhtYQAHF9j/7AOqzVFOLs6SdgkJKAuRK7o9N1dt3s9fVqFujXHfdx9fM
         HragNAQDiv1JDVVfeaHMQUgvyEKo2/81+Ve4s/s+fTXQm7uGPEYnx75HMJaF/Q2j1Sl8
         hlPAmVJVzrYEWm7YrPLKklyWqxTe6hEyxpvKRXmxKB43NOTc98QW3WW+IWR1/wlJL5YX
         nYBPu0L8LhuCml1lqTJZ8k+AphtLMB3Z5DKNt0yg/JJjnx9yFsUfGaN8q2TqdzSCAoZT
         x08Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1ezkIRC2n8OVCInkT6ezYusXCUe8ZWrprT3kLcw8FkUxex1voYzMkWf17kB6BxlDjjX0ds0ytCKa4OoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMq7GpLYWsx2dhEIN+mI7nvjd2/MNAauJ9B7sHDkdNa09nlWG
	xQbr03y5SA8e+LlDT95ew9xRfoI9+syc0SnsqAM7XQeLjaleVgVdOWgm2it7zjfX2vz9UyBY/GV
	aLntYHE6DzKaR+RLsZFX2s4t6xV1RPZdZoziX
X-Gm-Gg: ASbGnctaqFBxSBrTnrZqHoxon+hPZbFhHYet1nabEXUmdpHxra+uY/gAtVPFV8zxPAD
	9G/U8eDkSPM6loLnXOgLbR8aRpqLbHuKggY3+WtVPBmLsJg/zrCOWDG2mLTVUkaB5zp6Z6pmkuc
	oQe77J4luvM956aNTM7F1C8TIWhuGVUvx8wNsQjamYbfpZr51wdfJhYEZFOT8qwvXXipRYViJ7v
	EwzB4Bg4Lz1kf0dohAa
X-Google-Smtp-Source: AGHT+IF6XvaEEsS5J1qd3aGi/yemIaHhoxMrYLWmTrK7aEhBX42m6rTnFpPky9gjAIlGVOuFKcWxdXacuQgdoYbxXVc=
X-Received: by 2002:a05:690c:610c:b0:719:d975:d487 with SMTP id
 00721157ae682-71a466bf172mr128721827b3.34.1753996829726; Thu, 31 Jul 2025
 14:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726025541.11331-1-rosenp@gmail.com> <a2dbed0d6d0e529e4ced7e838455345b1ae11a23.camel@sipsolutions.net>
In-Reply-To: <a2dbed0d6d0e529e4ced7e838455345b1ae11a23.camel@sipsolutions.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 31 Jul 2025 14:20:18 -0700
X-Gm-Features: Ac12FXxmxN5xqdlUqmtyQBOkBLE8mDt4ER_HtkkrvhECiJi7x7gjxeN-XGwCpsw
Message-ID: <CAKxU2N-gfnVFej+AwSSjMZHX54rpRTepyC5o9KCm3w3W4xrPMA@mail.gmail.com>
Subject: Re: [PATCHv2 wireless-next] wifi: ath9k: add OF dependency to AHB
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 1:15=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Fri, 2025-07-25 at 19:55 -0700, Rosen Penev wrote:
> > The conversion to OF missed adding a Kconfig dependency.
> >
> > Fixes: 2fa490c0d7 ("wifi: ath9k: ahb: replace id_table with of")
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: Resend to satisfy bot as the commit is now present
>
> Well, bot points out the fixes tag is wrong :)
Ugh yeah. Will fix.
>
> johannes

