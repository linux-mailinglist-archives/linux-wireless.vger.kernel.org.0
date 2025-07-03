Return-Path: <linux-wireless+bounces-24784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C33AF6954
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 07:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C194D1791C0
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 05:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D6622FE18;
	Thu,  3 Jul 2025 05:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtFwTVmJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01243276037
	for <linux-wireless@vger.kernel.org>; Thu,  3 Jul 2025 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519298; cv=none; b=Rqsm/jhdI1zncRofgYw86POTRNQsfkd0SNONVC1LVUP/OjW5jgMvyywW4gEl8BcuWTf+EohIwtyH4q4E7DglzpaGui4aTptO9T0Xcu79S3Grp8CSolMPqJCvY3UtljioU2WinFiaIC3u+RTtlhX3LR/a2JMxBlUES5H4R2JLOw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519298; c=relaxed/simple;
	bh=rxN3oVC5R6PZQEsqn9rQsTDCvAKhHeM1OUBg07edHZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJj/w1X/h0BZKTC5fLU5tWX/YCtndbWlBOOJnBrZUwOaiFUHzLOvdMkmuVnFi1dNDrbV05/LVLMB+ek+JyF23teZ8Q1D1w2bqRQ1yu91mjSkMZrIaaFAqDjQUt3ddRwtQCL7Nzu7F62247q0yDxayESPQTL3+U3pJUQFs9sg1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtFwTVmJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so16136084a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 22:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751519295; x=1752124095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FP+HlsEPFU6TIdf3XDKmfsXJvNv/Rh2JlketkdKIzzE=;
        b=CtFwTVmJy1lMVQlIGA1ghfOk/tig8sDTTuUE6iwUGj8+vkKu4+m3WvJyIkkBS/XgG/
         5+WXDyGEKUmO/b5kiWn8G3QvMaJNKxuLGG4XwqISoZfG8Mj+QvQl0eZTplNKPb0SljFI
         ZIA+g2J2Ou/hUSuoZCyOfVB0z49o/1yYS7SbmpbidiuKCy+a8WxZ5VVs4Q8DDohm/eT+
         3IaVV2OKKkRoIoM6G52NLpGP32boBa/OntwbTOjr9klwbhrafOFlEUcaVWriD3uQdXUz
         WlC7+rjVGOm3feNMefpJyLM3N7vHCuSNgqhsmlxoVyRfBmJzDU0B0i3vatq4881MKGWk
         gksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751519295; x=1752124095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP+HlsEPFU6TIdf3XDKmfsXJvNv/Rh2JlketkdKIzzE=;
        b=b11M2cQanjUBPSal7V8S1V6xg3S0W2OSmcfT7QUPYPVNnAE3dxISyF0yotAb7L1Jp/
         nAi3/6obmSZI4I1mjX/3ZUcsLET7l2EmEMZPB4fmGaEySOSkFkT+ZfDY3HcZc3YMXmLZ
         zKYRdoYsMBecSHOvnONgWp0piJB/7JmGZZ2uO1E97Oy51naihSDlznSKaWQPqAaU0LPs
         z/IqonZMC3khk/QdSNPN2kCYFYHFDFhe41ljw5L9PjgrvajVPMNk8HVxd73/OyMghxnZ
         Aba7cNqEFvhCmLDZPCWSC3PjsfARwJf9Bou6FlNYw5YlqK9qi4lsW060lL4JOnG5+Wkr
         Mgww==
X-Forwarded-Encrypted: i=1; AJvYcCW5bQuwAr3BTzWGpBDzMkWoulh3BdKtbmTutLB7qQNawwv4b+g5laEjGEzDi0ftZRAzY4EJ1MpxUmIomZ/SEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/XcUpUVMsZ+v0wriZjl1sQqOYHPbFcajxTavOYd6L7GUA+w/W
	lH8JwcfUvNermMtfqglXkyFKwf92W7gM4+ZT1JHCIxl+gaI8r0SogHdSafqVX4+9vb4S2LMTUUG
	ZabeQ95OCaWnnzekTFlcNW9wpr6mvPZI=
X-Gm-Gg: ASbGncuCqwVwjDOcpuAqXR0kdOGsCKPqQ7/woj09nlh6U0bqumxWzJHqQnB8Tfv1JQn
	t0i69AGqa7xlfuhhfq8OrYFr0v+zfegVEQYCN/nip+EsrXInW79QmjXRMJwb/OyrEAdhVckBQ+H
	rUfJSK+HFz5h95lS8Zu7C+xAvhUexYTFiMdbfH9hOybBZHh3fTbhf9fm69unHqK8fKJnWrFPxBs
	g==
X-Google-Smtp-Source: AGHT+IHFCdTi82wSUFoZbKhu3bgAxXeueg1CfXdZvxduIvqNncAFIUlZiFD2Q1YAOOrKv5LJWEyUWu4NAZfOJM0teAU=
X-Received: by 2002:a17:907:7e5c:b0:ae0:bd4d:4d66 with SMTP id
 a640c23a62f3a-ae3d8b75196mr153106666b.27.1751519294947; Wed, 02 Jul 2025
 22:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com> <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com> <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
 <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com> <CAPDiVH-xPDmx-KQx7YJY=7+kwJNbGY-rEu-w+cz18p=kjnKFsw@mail.gmail.com>
 <979be2a9-9d0b-4382-8519-2f6fbcac5375@oss.qualcomm.com>
In-Reply-To: <979be2a9-9d0b-4382-8519-2f6fbcac5375@oss.qualcomm.com>
From: Matt Mower <mowerm@gmail.com>
Date: Wed, 2 Jul 2025 22:08:02 -0700
X-Gm-Features: Ac12FXy02ncWee8Jpm5jJeudHeKd8QR02xkANsyNNiyukI5Beylq8Po2B-owL64
Message-ID: <CAPDiVH9Fi3Rw4K4npHMAEcOPMj=iFMEJOyhn5cRaq3+9kBYNZA@mail.gmail.com>
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, will@kernel.org, joro@8bytes.org, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	1107521@bugs.debian.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> in the meanwhile, Matt, could you help do some
> more work to narrow down the problematic change?

I went the opposite direction and started cherry picking changes from
6.15.y, starting where ath12k diverged from 6.12.y in Sep 2024. I
found stability pretty quick and was able to bisect down to a single
commit where stability started. See branch
https://github.com/mdmower/linux/commits/mdm-6.12.35-ath12k-1/ for the
cherry pick history on top of v6.12.35. The commit where stability
started is:
  wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO
  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/net/wireless/ath/ath12k?h=linux-6.15.y&id=afbab6e4e88da68cca94cabfc1604d71db161d42

I know this isn't exactly what you needed (especially since the commit
is part of a patch series, not standalone), but maybe it'll help?

Logs with ath12k debugging enabled:

1. Last broken revision in my branch:
   wifi: ath12k: modify ath12k_get_arvif_iter() for MLO
   https://github.com/mdmower/linux/commit/841b7f4af08f9d80e6db862218d341402dfc9acf
   https://cmphys.com/ath12k/dmesg-6.12.35-cherrypicks-841b7f4af08f-ath12kdebug.log
2. First fixed revision in my branch:
   wifi: ath12k: modify ath12k_mac_op_bss_info_changed() for MLO
   https://github.com/mdmower/linux/commit/931abb9e838e376a53a82c0f638fb63a9d31e737
   https://cmphys.com/ath12k/dmesg-6.12.35-cherrypicks-931abb9e838e-ath12kdebug.log

I'll continue to test this branch to make sure it's not a false
positive, but so far it's looking good.

