Return-Path: <linux-wireless+bounces-14764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A11CF9B7609
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 09:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C612B22F62
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5665314B976;
	Thu, 31 Oct 2024 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L2fKUInm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372212CDB6;
	Thu, 31 Oct 2024 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362016; cv=none; b=XxjNgEIyFrPyJD03OlBTlKg6qW1PQNGwEvqU1y1znSITyIj2lhlqAjpyRxYdMUMxZhz/UmqgoXKiO1lIuds16P/Dvvfg3SAVZ9gDeRUbAlsEHBMlbCjyoonXzr8U+niqRlYnTkfwmcIxflUvHOfyRK3/uKHbBxRyJhdTKXMzJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362016; c=relaxed/simple;
	bh=JshBYHnAdXkkdibADmLAopnBhhJnB+6PF+Xrg/aavks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aVKx16QlEqVW8x5YI/ZlHv6syUqUsU3pImZb3TNVj5K3fg7CNCAQ3NxwNiwbmrM9a5Ly9/tGxKz/xkDidnWTnvTbnP6rzk2psGczKgEvy217UmBODSCfYAqFiOu1ms/Jz9ab9qn0Egaac01hm0X2cbPruxmveGEwZuSQbEBUGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L2fKUInm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=24AuO80wjvZozr8N8J3CkNyuIKUrNV1vyAER/sIwQtg=;
	t=1730362014; x=1731571614; b=L2fKUInm8AuQYxI7x/PQBGrhrY7hDi+AVC+ZdCSj9O9GCL5
	rNyosN3Gf81uZW0TDmvb624eK7WXfrjETeZn2JyxVKGmiXVE/JX5vcdEfqztEjul36+DwO6H0HSSz
	i5B7//CxkJDAu9RIhQFFElywNkXaRXVLy8Jqk1MobI2hPGAndJ4LGtrBt7xTsj9ektUMqYE1V4aC7
	HW7nc4L7ZXiRs0/+DBhF/uI0dATNdqlaYJ/sMd++Wfjhp67Me07h8Y2iOOcgSJK7rgpsDMicYiyTl
	sU2WQcXoNlE30cg1DevW0TsVhn2w9O7uX/VUViTjpDdb+4pMmjJSF8rosQEQ+ISA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t6QCg-0000000ALco-1cgV;
	Thu, 31 Oct 2024 09:06:50 +0100
Message-ID: <7100cb98b8e46793cfb1197c3af0f151a9628c9d.camel@sipsolutions.net>
Subject: Re: Issue with iwlwifi Firmware Loading When Compiled into the
 Kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Gang Yan <gang_yan@foxmail.com>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 31 Oct 2024 09:06:49 +0100
In-Reply-To: <tencent_2C31282B61589DFCC908B3831384D569440A@qq.com>
References: <tencent_2C31282B61589DFCC908B3831384D569440A@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> To address this issue, I have considered two potential solutions:
>=20
> 1=E3=80=81Modify the Driver Code: Implement a mechanism, such as delayed_=
work, to=20
> give iwlwifi another chance to load the firmware after the filesystem has=
=20
> been mounted. This would involve adding additional logic to the driver to=
=20
> handle retries for firmware loading.
>=20
> 2=E3=80=81Modify the Kconfig: Change the configuration to allow iwlwifi t=
o be=20
> compiled only as a module [CONFIG_IWLWIFI=3Dm]. This way, the module can =
be=20
> loaded after the filesystem is fully mounted, ensuring that the firmware
>  can be found and loaded successfully.

Neither of those is going to happen - you should just build the firmware
into the kernel (or initramfs might be enough?) if you want it built-in.
Or set up firmware loading userspace, and set it up appropriately to
only respond after / is mounted.

In any case, not a kernel problem. You need to fix it on your userspace.

johannes

