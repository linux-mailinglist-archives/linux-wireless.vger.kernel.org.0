Return-Path: <linux-wireless+bounces-30179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB5CE9484
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 11:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4441330124C3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A16A3009D2;
	Tue, 30 Dec 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BGsTDedO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFE2FFF9F
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767088822; cv=none; b=czhWXOgCuPNOle692AyxOXHyHaVoRaPXqJ9NXwhaYJ6b4JfvNfyemaqj6rf/OUn2DxlJE8rvOlSX1m7BymlswT3CqSLlw2lPHRR8qq+E6UQJjiwdFS3w0flcQAF16IZB7WHx66piM40JkNJTQL160/x76uzgv+J/0QA+9iIMycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767088822; c=relaxed/simple;
	bh=cZIiGadHG8WfE3ly1HXfica0U3MV0Lc4qrsXyDgBoQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+irhKO+YfKSysfnHyAPRpCbWA8iqKmrmvHoUWMYZEtJMVe15rERy1eFicgaOEI+AGDe9M6FxlqfUBTrFf9Khy+sOHYobUQXt16wC7AQvXTPRjLGD3j+VMsbQB9OVulTUMyU37kiCI3tyjmw84Pr0sYh2X6UumYdxJANNMl7Pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BGsTDedO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-598f59996aaso11898459e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 02:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767088818; x=1767693618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tRxRWQzRmCYnQKX7qKIJ6OMcfRXAAVN0sUWsz8Z3ZE=;
        b=BGsTDedOt1e2IeKnwyvi3/aHeRnjOlVmfW7kCk48kOfo1bCudG6XgtBLoznwqxlhOb
         04ES/GcNvRiLRg8dCeDneTiGSsh374Lxszvz0QtPxTTVrWStzZFWP9j6HCZ2z/yuSLHL
         2QHu5d/ng+X5E4yLjTCL+8jeyBNugsHGQdPk4Xq+Lyv0C7xzKzHoo0GZ7z0cdqVPKa/u
         YuW1h5Af8Dlb4DQbAmGMF1A8BM5Vv+cAYG1OgyhKHXXvXCHktFLVq1zwj8diARmBiuak
         TkeKrl7ZNIW41tY3PC3hqtDR+7IuR6HPaqTfOhe/rCOQ2nGoqfdm2dnIEkgc4X/anCkp
         JRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767088818; x=1767693618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1tRxRWQzRmCYnQKX7qKIJ6OMcfRXAAVN0sUWsz8Z3ZE=;
        b=UOFbUA7lpcyN5OqH+z9C0ofIqAq7qFUeLwsRqNUeg33hWeMQVQi/LEzTIP/zKRmD33
         rRa7tVwLm7MwsiWg0tEJIjvew1W/AOMgL43qzDW4GN+ufd+4oW7bkwnEPDjycxH6veZW
         ToD/EdbTGUX+jaUCeoxCNsjwubr0ZW7qpVLMvmLcQ9JAGgDtArFauIG7xW6SkNBKtHHd
         y+g9DemXVewyjYzqoyxC0Brru35gBF04byScnvks4Y+piylNibhZF8hf9RwYimR3Z21f
         YNFm25xKkjMz30zs5DeVmUI52WzQwA0MfQkuqJhoKInKENdl4PvQ4sqnKubupTBWEdh3
         kLVg==
X-Forwarded-Encrypted: i=1; AJvYcCUEetPuoviZfx6foi8CV3/RBP80MjwPh9aAiRjlFvxRgD5CSQlnGuwkHKUAIKgPqhCf8aYhfRjF08SIHhTDgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+2BwUqY4xfl53fk2kM9GgDcmil2cjs23JnlCUiMig/V1pobov
	EI3uNQ5n4s0BIMp/iyRaJ2r1xFdEwlqLStio36jFLLYwOgaXDXX8swFK+SLy0q/3eTKf+mRsF9x
	qO+X4bhx4BJA7ei4yPuuHOgx51+nsf92GmSwSyllziA==
X-Gm-Gg: AY/fxX6pQZjM9CZIqisQLvVF6WYj0dytqIez5wyyCFKfwcDuTfDoYX3Xs+irBXH5+tj
	7oy4dxYitvdNfBomidLOcdJAtffgX3KgTv5+n9RZInsgUTQIIKwvhpxN14LJGwyYgxJyEIcYToJ
	fsHBCXkJYtk2JOaoLwhbqDDfygQPNG9nDZKm17HvS0VO+wqmwRd5JuaKaegz0q0nRzGQvQg82p5
	1/KurUW34P6OaSN0ZxsG44HHUbrHsO13PCP69ysDc6gDCP3+hN40v2kNWziNEGpXI4b+xH4NUeR
	4lbe6x3VddRZ3QIR0A/9Uxe0a72O
X-Google-Smtp-Source: AGHT+IHBp58C8eJD8jHt03+ooDUgedGd0HZ0sHq7BopU+wSyE8cBf88UU/sRfBN6CkzcQxn+JuN8ykjj+lfX1LiB4HA=
X-Received: by 2002:a05:6512:b94:b0:583:903e:b5a4 with SMTP id
 2adb3069b0e04-59a17d61e3emr11072799e87.46.1767088818024; Tue, 30 Dec 2025
 02:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114104325.116471-1-marco.crivellari@suse.com>
 <CAAofZF51pkOzrg_nO0Mhx6g9b3JPtO3n+0YE=WtSgj_F6wnY4w@mail.gmail.com> <CAGp9Lzoj2jeGF+t-UP0gAykCZ96-OkjummeJRGniYfagvY-BPA@mail.gmail.com>
In-Reply-To: <CAGp9Lzoj2jeGF+t-UP0gAykCZ96-OkjummeJRGniYfagvY-BPA@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 30 Dec 2025 11:00:07 +0100
X-Gm-Features: AQt7F2orGzKXzw6tzrN805-5mgW6Z8EpIc6FGRlg6vkCnPmNQoxfEOSCoRxEkUQ
Message-ID: <CAAofZF7KguhtNs_cXQdWgz8XdaChMG8G_LtEmhKfgC5_yq3iRA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: replace use of system_wq with system_percpu_wq
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Ryder Lee <ryder.lee@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 12:42=E2=80=AFAM Sean Wang <sean.wang@kernel.org> w=
rote:
> Hi Marco,
>
> The patch has been queued in the mt76 tree. Thanks for your work on this.
> https://github.com/nbd168/wireless/commit/ee518f914cd901c16fa08a6f228b266=
551f72a6a
>
>             Sean

Many thanks Sean!

--=20

Marco Crivellari

L3 Support Engineer

