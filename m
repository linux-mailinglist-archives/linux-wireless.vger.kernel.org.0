Return-Path: <linux-wireless+bounces-30743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8550D187BC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 12:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F948307B82B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7038E120;
	Tue, 13 Jan 2026 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JWxG236J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635AD38BDDE
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303482; cv=none; b=RYzU5q56nggw9T9T7IY7EhlCrRwEr1WPr4bCXVFt8rsbfTxa7Ni4ydfuLqiEoSfOfg0eLOcssFMjxMKM7G7xxlu1DY3/je+dflfWk+SNBNo3fJrOZpjgAGK+G1WxB8oTH3WlZrndGV8+eX7dM5u4BMCohRsAsUil9uUQpksbUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303482; c=relaxed/simple;
	bh=U51l3zRfSZ0RqGrSACbdTYN1MFWue6X9ubXzqF2OlVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUkYsLxf6m3aZlWnediXO2atoRQMl5ncQwZNq8eCeUW/joDR4BbtctLgRddcHDzPZ6XilBGzqAFTTy1lG00G9DuziqCfspmXyXcU3s5Wy3yU3Dq0bAzbIz9JSL6XvfLXADAKIDvUKiqWL+skddW+Iqixf87gclN1PuepaQ6moDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JWxG236J; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b685d2b79so7151732e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 03:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768303478; x=1768908278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U51l3zRfSZ0RqGrSACbdTYN1MFWue6X9ubXzqF2OlVc=;
        b=JWxG236Jbp+kDb0wwBEZpRBiBRnRPDL1SaB4Arwdcyaz0KLPVS8h2VhhXl7gJw8JEM
         KowsM3D5u3k18GXSKr/D3gtb7e8fGkJrBfMoh3OF79n3XLIc0bgd/cn+nJCwtYT+37P7
         yGf/8NMOIz2C9dM8pbsC5N3yyTebTrRYsdKBoE+Ne+HXkA2SgIuV44/+Agm+OiJJdJBO
         O3FJwirvi1lPb574BeSkArHqZ9ayylC5qJuK09BHf+6BSFENicfuGBi6CYEq6MGUkN3b
         e0i6cMMYhEVtxGqJvzDPxlmvxIGJg3TKBG0xu+IvKwggvMCb2vt7wGOffWiHbTcq+GCW
         0OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768303478; x=1768908278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U51l3zRfSZ0RqGrSACbdTYN1MFWue6X9ubXzqF2OlVc=;
        b=vYIMMNbI1glSIKkQoFtWcm7eMd92hwifEo/mZafFiuZ9Z3wOEW1/nQOk5hwkPJNFog
         jEgu3bi1b2IGNhDxXbPrK+PghWJUqh1ohNr7i91oI81VeZqoLzBcErKX1OUn7vDlsTAE
         LfaxabSX+fYWWp7DE2nOzR+Wd348vyDv/e+ESVFhYIFYLu19sN0hEaXQd7fU8WcuCOQq
         /UtgwfSm7HPWXkKcoCwFKkaqa/4TNeIsK6KTdzPZUkyqnO2+9vTSw8TnnhASwGWk5SFn
         19ZJF/RaJdiQOZTAKRjgs3KYZHEpjtz6J/iM37hliWeOm/9Hy3dylLP2pjV6JuURDERd
         PKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxu2MfrJbDqOLeetTfP/lNJI79EPmUG06IHCZgro4mAfKf796EXubOECGDeAsYIXSCY12n21vkhbbj9hU/3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKW/XNYggOIDz2eBzMeaIw3nHNUVKPRTJyoPYEGm59aDyie6c
	ayQWycqlNxpnhWgoxFig5xfzIGsMCMgHrySuUd5owRy23zV+RC2KvVVOxSixgc+53FXf7Xacvqn
	vlp/7odo3E1qPGE+lnqZeJhI+jymec5JUmqeZht1NYw==
X-Gm-Gg: AY/fxX4B5jDQ/PahcEDv8exRxBm3g+3iAV6ZAQL22ccYtuI5o9VVreQOeUgRU1mHL4D
	H5JaYdXN2fUyVb0gWUjNyJq6q5wonqLMTQasgjgsnZaP2F202Vhd+jr+rdmcdVy7ryh7w47WhXQ
	4fVIWtAO5eReCiWN9GUUzMs0fF6Gg/TLppzpMVffLPkD8ry9kzfdSwud0dFThF7ZepmU6UVfVNE
	awWmdpfdErDB2SHpSmJtGmQFMhcjG3Ys5boBLqFeP526XEKrKvmWC1gIRUfayoQVwDmeq/GXhci
	P8FAy4a172Hfg4oFvTeBFnIJJY4b5FptpnkJBYw=
X-Google-Smtp-Source: AGHT+IGKNF7RRCf7hAkyZALVClccGcj2u/HYtrYuJ3YZTIEvuq+yQ9zMZsY1ZUid8O46FhfRzXK8n7UD3ZkxuwRzSOM=
X-Received: by 2002:a05:6512:401a:b0:59b:96f7:3ab4 with SMTP id
 2adb3069b0e04-59b96f73b96mr1574082e87.43.1768303478389; Tue, 13 Jan 2026
 03:24:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113162032.394804-1-marco.crivellari@suse.com>
 <CAAofZF5yenY8Q92taaJW2-=kenDVuc6ABEtbVT5+yzM_pBVZsw@mail.gmail.com>
 <2f4c22558d20b42615adde772551c1bfb346da47.camel@sipsolutions.net>
 <CAAofZF4Ptjmo=7taHuw_rdya-kGhEZGqXbQn8yPCi1pgA24mkw@mail.gmail.com> <ed1279c6d79e13f9679ac33ea47201d5eea2d1c4.camel@sipsolutions.net>
In-Reply-To: <ed1279c6d79e13f9679ac33ea47201d5eea2d1c4.camel@sipsolutions.net>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 13 Jan 2026 12:24:26 +0100
X-Gm-Features: AZwV_QhXko5ucUy1BlfE9eL-RJyKzXsMp-mEIVnO9UhWHnuk4cWCm0bfTh-_EwE
Message-ID: <CAAofZF7BkX4hy=Sp2Yjq=aGrYL4wPj_vuoMRxPKpnU2Gs2eQbA@mail.gmail.com>
Subject: Re: [PATCH 0/3] replace system_unbound_wq, add WQ_PERCPU to alloc_workqueue
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 12:19=E2=80=AFPM Johannes Berg
<johannes@sipsolutions.net> wrote:
> OK cool, no worries. FWIW I might have even more in wireless-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.gi=
t/
>
> If you want to see what's pending, we have it in patchwork for wireless:
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> The ath6kl one seems to be pending still on Jeff:
> https://patchwork.kernel.org/project/linux-wireless/patch/20251113162032.=
394804-2-marco.crivellari@suse.com/

Aha, nice, many thanks!

--=20

Marco Crivellari

L3 Support Engineer

