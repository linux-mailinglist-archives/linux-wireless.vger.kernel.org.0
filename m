Return-Path: <linux-wireless+bounces-30090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9C2CD99FE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 15:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D88E03017E21
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 14:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54D338595;
	Tue, 23 Dec 2025 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z7ze6LqG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A72302767
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500047; cv=none; b=bam+NYmQe7oaYEPwkCAdLzi0XwHCz5h+c0+mgEHw8bQcjrPMsn/co5eu5MgoVQO5sFDb331OMygANJs3IkuBTRb/7GRszUyThlx5nCsANrOoL4ffzsDRsFgTngqQ5GKf9SanBb2kZ4JCJDRFA5TMsVc2PMekniXIDZDzSHTxv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500047; c=relaxed/simple;
	bh=DRQ6VhqPTf7r0o9hkCZML5i+Qat+jpDdTaf4JHD5j+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrLfKOdNNJkf912TmQXGov+wsOTDMrVpXX0L/ynfxmVXeGP5jQLECakoXC3FB04/J0aBgePLRq+nEGSwVa0nKyIrK/ZcXVLfqEoQPy/p+GdN69qcnY6BBtteuKixw6FKo/xGAbcEhko6MrmUeijxclxCYt9eWXrII5E9tFCXKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z7ze6LqG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-598f59996aaso6439518e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 06:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766500042; x=1767104842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRQ6VhqPTf7r0o9hkCZML5i+Qat+jpDdTaf4JHD5j+w=;
        b=Z7ze6LqGchbHe5a4ZrsWDMAy4Eml3TZ/Npp1Z1DMNnQZcAebRMYQwPLr/WUGwNYQ4v
         SwevlzipJC1N6GT7CdVFoIosVvGKBWPuWrVIq8pmCtG5PT9odSdrR4PtxG7VGVB4BhRX
         eya1irofD9vrHV5k6RoO0GxmBifV77I5ZpCOMUJL+T9Rg47Nq6IKYVN0+CVns26nedeV
         q+T0enO6sRgQUwvA19z+6qPtfs3WWUsDL86HaxgJl+Rf4CPO5lHUSQl3WkbL3Z5Z6pzF
         JOzyrxW6nwhIGujwNbpcwWZQW7gFnbhPI/FMgNUwdPgwagy38RzDDJ9lJjWXiu2M7JL3
         qnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766500042; x=1767104842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DRQ6VhqPTf7r0o9hkCZML5i+Qat+jpDdTaf4JHD5j+w=;
        b=d94EZgiMrb6OaGGjYnnoKGpq3cnouIuuRquuNmki9RGnTYGJHR6gw5DJSdxp/zdUht
         jNHA+AGd3f1YFk8EqOnvXlo9QrgbIeVdBDW6aOUsCfN1CXRyStgHFf4AWEghkzLxz8ER
         ULP55Wrc7zH430bbOrTKhtWfD/0lNf18dAh9rwk5hllmdfX6rlDt/p+zxZSMUE3gNcKf
         Qv3QgSxl7WdKS/yChSAAvHBUnsZjeenvTagdCs15vQdc2gRuGewA87IsVR4bVl9IURN7
         bsuFR1Ee4e2YHWG15O1PtXcq6YdFpbwVqs3A9qZ5/K7gEDCFpx3Df6+91H+4lmp7bL5y
         bpGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKIJbi8oLMVkX/WmI+VP+Rdt01F3F3oz61LVvbWs5X0LclSnL8CorvZk+cdhq6LCaCeNecaHDmtra1dRf+fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbuf+P+6YQrB35Eg1rjODqqdMvlDakT8LF1uBMA4oeNmGjkjKy
	vU8CymVTzK++gIK+bcKuRwCKGFxGaH9Tt68G3I7Uiw0Kd78rqc04FLjIHH1Oe57XtqqhA0pqsMi
	lRvDUG0kHNL2iTM9M164PN0KxUWvVQ/BDxRpbEXsF8Q==
X-Gm-Gg: AY/fxX66wob47W5p/Cr3oaDD4vjnuYsyup3phRZUVtzw+Q02Vsbf/nR4/v3t0ZxfoxR
	20aXvhaqf/CIDtELNSscLQo+w7TW8nWawnkWp8CcWn3VfR9EuPA4J5LPjlNTq+W89iISvw6tmYB
	zICY39OKoL7KLN98Lw1TAOcptJ2ZxAPOVfFzIlTIFU1KcQ++v+O1lj6NbdudNXBMcnCWjBm6bpb
	/63pHHxHoVe7syfU+jOMAkg76TlMijjbEqfXmvjd2/G3QgWcREgZlZjcCXeClqsDL4sVLZlnB55
	a8TYTxbJaNQ+NiBD9QG99gmF0Fam
X-Google-Smtp-Source: AGHT+IFn5qq7xZo0Aawjv53/NEkTrkxAeZalJt43/o6yz+ZJINOQmIc1pKnkNHy72r+L+6oz69ELYs8uUQtnJGEtkwo=
X-Received: by 2002:ac2:4e0a:0:b0:595:90ee:f47a with SMTP id
 2adb3069b0e04-59a17cff32fmr4669301e87.6.1766500041757; Tue, 23 Dec 2025
 06:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210101209.47176-1-marco.crivellari@suse.com> <5fdf75e3-ac2d-44fa-9da2-54f844366dc8@RTKEXHMBS03.realtek.com.tw>
In-Reply-To: <5fdf75e3-ac2d-44fa-9da2-54f844366dc8@RTKEXHMBS03.realtek.com.tw>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 23 Dec 2025 15:27:10 +0100
X-Gm-Features: AQt7F2qvpPXoSSsaVPk2l8kAt-73PSyvSKNbOqCjezHpTdjdgbXCuMEhkyZIFdM
Message-ID: <CAAofZF7aSuG3e==37M4FWHP+Ry6p-TADpaq6Z59LODAAsWKdvg@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw89: add WQ_PERCPU to alloc_workqueue users
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 4:48=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
>
> 36f2deb2f55f wifi: rtw89: add WQ_PERCPU to alloc_workqueue users

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer

