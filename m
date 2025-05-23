Return-Path: <linux-wireless+bounces-23351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50633AC1DA1
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 09:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C383B7CFE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 07:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B4220F4A;
	Fri, 23 May 2025 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="lFcWqwSi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4614B08E;
	Fri, 23 May 2025 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985180; cv=none; b=uW1yBAximkXX1M5IEmOWhHBI25t0s1pstGPmErV2KLqyiz4eyXQno6NGyhdlGt+CVNv/x9sh2LhH828UHbyz9GhrgrEPV4QPNChRmPQygCGYLcMXudfHL5l2WkVqgEPq9ZcvVA8zN55Ezs2kdJNS4eISJUxbGkVzIJzLiPYeShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985180; c=relaxed/simple;
	bh=DwnQfnSMOItXUm+nDKLtGVpXrHoxllqSJGKceJyda0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6RaoJCBxLQtfKtrJcODkYcP4VOzUCwGm+R0ZmkTJkHQcQKqDBTbPaDPKLgSgShYgrmfu1Rb/yvmQ44hWTxzLvA1szrZS7V+5KUGvG63xKYB473VRJTW50vHlcy/9AgnnidEfLaDRXNN/vI1aG2V5mzos5rdTjRyi9RiAO5YAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=lFcWqwSi; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 27DD41F9B6;
	Fri, 23 May 2025 09:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1747985168;
	bh=921gKtORq+R00la3WfxZeEyYE8YC1dY4t7ERpznsFU0=; h=From:To:Subject;
	b=lFcWqwSiYiEPiN1D0BU2e1wIPO6VVj/aYmou/mIubn7twAkGr8htcnakAAObQ4u7K
	 hWsbWXlNHOQ1/MvUhs5CcQcFjbP5l8ZNivmJ8iBiA6QP+mivAo5XCobcCgmuMJefPM
	 t5TRYAketgCZIQKJ0yd3/ymezcfFaxJ5Lq5HU0KsW/IS2mpB06a0/tdTlGP9XAsyMT
	 SF6ClGMtSIAdCJuK9rp8xSeZxGtP38I+hQc/ixiJqXV+bQn4y9UgmijrsNYVwI2GK3
	 QuD3NQI3yt/NmvFxLpSn/p4juC+XMMU3oTmRGDG7AlM949oe3JMAkak/1Lslq4ZqaU
	 MaJDsvOLUb83A==
Date: Fri, 23 May 2025 09:26:04 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Brian Norris <briannorris@chromium.org>
Cc: rafael@beims.me, Francesco Dolcini <francesco@dolcini.it>,
	Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: enable host mlme on sdio W8997 chipsets
Message-ID: <20250523072604.GA14001@francesco-nb>
References: <20250521101950.1220793-1-rafael@beims.me>
 <aC9dvv6Ki1T5RsHF@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC9dvv6Ki1T5RsHF@google.com>

Hello Brian,

On Thu, May 22, 2025 at 10:24:14AM -0700, Brian Norris wrote:
> On Wed, May 21, 2025 at 07:19:34AM -0300, rafael@beims.me wrote:
> > From: Rafael Beims <rafael.beims@toradex.com>
> > 
> > Enable the host mlme flag for W8997 chipsets so WPA3 can be used.
> > This feature depends on firmware support (V2 API key), which may not be
> > available in all available firmwares.
> 
> Is it available in *any* W8997 firmware? Or particularly, is it
> available in the firmware in linux-firmware.git? Judging by its git
> history, the answer is "no", in which case this is definitely NAK'd.

mrvl/sdsd8997_combo_v4.bin, from linux-firmware GIT, 16.92.21.p137
version. From an off-list chat with Rafael he confirmed me that this is
what he used for testing.

> users on the old FW version. So, we'd need to teach the driver to know
> the difference between v1 and v2 API here, and choose accordingly.

This is already implemented. From mwifiex_ret_get_hw_spec()

```
        if (adapter->key_api_major_ver != KEY_API_VER_MAJOR_V2)
                adapter->host_mlme_enabled = false;
```

To me the patch is ok.

Francesco


