Return-Path: <linux-wireless+bounces-30739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C05D18187
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 11:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C420D30574E7
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A338BDC9;
	Tue, 13 Jan 2026 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z3lieh3p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39D38F248
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300142; cv=none; b=tsPSIvHt4yv6yNkPPcj6FdfDlLsC7IzeMs3M8p4d0u+IVUAo8+r8eMsk+I+XgInnCOHmsXxOU/wxtg9zrLOK0DanE3LJRDbzL1gFAhn4WnYZmBvqzdQiKIh88WVnPcwbwAYCz2NfTzOD7Gw2VJCz5t8/Be90JjjSfCbzXJyE8rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300142; c=relaxed/simple;
	bh=5dpVhXajXznGdiGiZM94cTK9QGQh9etY1qvan6c09ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjeJ32B3HH1j4g6r0ydtk2VgrkFXVHGEdTN6ixVoPYqWzfm+DmHeitvuN+vrJRejn7kOJbgN1Y4enteYl170hk6Wm6pv1BKCdsG8SUiMvfIrdv9S738rcohqnE2jkkcWUxPlcF3cR9Nq67hAjInGRvQt9ioajX1BYI6Bi07DmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z3lieh3p; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b79451206so4597105e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 02:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768300136; x=1768904936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bko6VSh79p+mi26m9+fT4EKQ4pJ6GTWt79WgmUKK+bs=;
        b=Z3lieh3pqXKCpINZlDKgKB5EPDL7nOFS9gs5nL6mlRTIeICjk+DCz4+KvatDuoHYn2
         ZbY0j5NpcMSgjAojUFjly/HQHfPWoeawFp+cD4O6zoPzvXfzdCduUMvBmNLFfTLX/NwX
         ChWhc4a2WKhcL3rRJaoySqBWfHp7gxUs/F3sCEk90Cok3Zkut1T7258mv8odKjJzFN47
         XLt9EfnZeu0oWhhF1ocUqAXQ/PKfTkljiFqzYWk+iVKcanjd3S2k8FhOSGqg8/WDlqNt
         lFwEWgpA+KJmwAfpyURxBLse/U5hT1VWpDllYIYfviwQ1XooeVVCgYFBgmqm4gC2dGeJ
         qWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300136; x=1768904936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bko6VSh79p+mi26m9+fT4EKQ4pJ6GTWt79WgmUKK+bs=;
        b=C5/nGDFvmBFP7R5lDGXntC0T/VDqxtx0pZ3vqWZT09jNmHNo8mtqRovpLFZvUGww2Z
         hE3vJ85ZDuwpE+3npdT7lWYZdiS9qztIFwDetsUxGXpVE0WchIVUbq4G4EbKUdGi/Iks
         agUFyg2mI2CmUJXFbizk9y7hTCRfzY8NtPt+reTeXceOmZgYvv/0hHFjoOjUUPVAPXah
         aacmNFZeOyrp1QaPe4TfX8Mg3sG/p0EnzUtHWRIpRVRUVJI41UUVTYarSC4byCu8zCfK
         1rQc+xne2MEeuhI51/jdl//uR+yOfPqEyT//ChZW5aUvwsre+KbISawwQ6Nrsm9n536f
         MV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa83pXDK2agPfqtXGy3n7L2VGOCAwNtfwlY1AO2vgeGtvGFmtop5Dm3RjLmut3eVBEqipYimZ3XxKzBKMpBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxABQeGLUuuYv/Tn6s0IuDS3Om6xMdsG4Ez4yeZZDpSMnjrm0L0
	uJSLBmJsGuzfN8pmOoVfmeq7tJRoHHY3Y2tbrpkxlOuDJFcqBZAUTr3OS5OLlJBV0nGT3Qnj/to
	A5FCfvjln+5l9Gh88WTZHqK05L00OB8veyuBhXm0nZw==
X-Gm-Gg: AY/fxX5Ofr85Px9k7443smO/LPJy3Kpdk4ciW75oErT1F2hIPI3p++SykoCK6Ixqcjf
	NmdvNFZElk8bxpmLfS4Otw6FyPAxia76DGljFK1nH8Jb7Pqcccovq4sXV8Z0zPUwfRd14lVD1Vc
	teBAlHUueaEs6mgDh1o4kL8BA+AxQrQni+C6V+ZcmA2ze35ddkiosltfHxFvvw6S81d3/U1Elpr
	aoQ7UbzL/+Ws1UJ4c5oRqR+hZBjkgP+x2N9XiE2bvhxQA8fFcUsKplWeJkYl+rGwYPEV1wfjCUF
	JqtnRK8XrKfEKXXcydTQFGuJjdVj
X-Google-Smtp-Source: AGHT+IEs+QAFJs5Ab1L4FaonDmj4SbHGRrZw9ZeT2diRpHjmz6KK5L0aTJw9FkQva/lhecBqEamnZm4Zed/14DHTcrA=
X-Received: by 2002:a05:6512:3083:b0:595:7f66:b6a with SMTP id
 2adb3069b0e04-59b6f031570mr6815948e87.35.1768300136105; Tue, 13 Jan 2026
 02:28:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113162032.394804-1-marco.crivellari@suse.com>
In-Reply-To: <20251113162032.394804-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 13 Jan 2026 11:28:45 +0100
X-Gm-Features: AZwV_Qg6OtAwPcnm1wlKaLaj4JJP_3R-omkyGWYmG7GVQbEasj2uy--t5QnOiNY
Message-ID: <CAAofZF5yenY8Q92taaJW2-=kenDVuc6ABEtbVT5+yzM_pBVZsw@mail.gmail.com>
Subject: Re: [PATCH 0/3] replace system_unbound_wq, add WQ_PERCPU to alloc_workqueue
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 5:20=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
> Marco Crivellari (3):
>   ath6kl: add WQ_PERCPU to alloc_workqueue users
>   cw1200: add WQ_PERCPU to alloc_workqueue users
>   wifi: replace use of system_unbound_wq with system_dfl_wq
>
>  drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
>  drivers/net/wireless/st/cw1200/bh.c   | 5 +++--
>  net/wireless/core.c                   | 4 ++--
>  net/wireless/sysfs.c                  | 2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer

