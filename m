Return-Path: <linux-wireless+bounces-26934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97896B3FDCE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 13:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF78202BEE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CDA272E5E;
	Tue,  2 Sep 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZYKesyS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E5428850E
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812697; cv=none; b=s7dz2D/p4sp+i+ZMqd1raCzlzR/ZNe8Cjh7GrQS/85WxEWrdHAo6a2bVpKjOWkBA6pgPL3djDLg7zzr0sCoN1RTak8FI5DdpB8ujbpLQsBahTkPn7KJXKWT0mQ99ycy4kzlmNKbcxKoeiO5vLVADVV5F+PWM4MjWmwC8+PCIm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812697; c=relaxed/simple;
	bh=/NJ7+9jEvVQiYCCi5dDuURqEfI2p9wpP4UZy1CR/m2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1B8irv4xm1QYRwnF7tm9bUCEC+SUaIdcZpI1nWP2QQlZxDlPY6UHSnVx0qcYh4sq1hjluIiF2PulK25MoaQI71fM+iAbeeNQ5r4aSqdO85YfS8Tlqb5K4HZstlpk8pVvQfIL8D19DRzNDtoWymtaguHDtPoVF3sWBBx5ByF1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZYKesyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FD9C4CEF7
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756812696;
	bh=/NJ7+9jEvVQiYCCi5dDuURqEfI2p9wpP4UZy1CR/m2k=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=iZYKesySyTaq/3fKtezzsavvgbgnFVc1VkXn903/um5QsqAV+U1WsMS6I19vlfNQ2
	 4M+DRobk265m3ZJ1Aiyfis5hOtQrXjG3TfZuFDSGRo/uQ0V64C3xUH6o5nZrQGliln
	 R2Dk1Wd64FeL8QNXLVmkaSjIVjAQd01DNHRzFYxIFraD4Ci3FqGOLFghxuyGjhEiVo
	 6hg7qkWtlc+Nb7jp+IWDG3fU3xIDdJSiLhyW+v3ZorwyHMUeUf0Hdkv7GvcZnilFc2
	 giLvxSoqhmhwdhzqNpsg3uGyslUkgz2uPgfzp1plUNQZ/uLddkdaPSIaEBDy6H/u+4
	 4KG7Y+/0PRngA==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d605a70bdso33418187b3.3
        for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 04:31:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUouUSwLHLh15UzuK+JKGbmGiNqOzt6CJ/am1fQzkbC8N0Ecjawc7L9vi3yBLWQdlJ/Ext17ehLb9UfTxVqAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2atRhn7VWpZZtcOpar2nrl0f7TOXD1BWzXzBCRFGISO0cIbx
	Dl9x8TAQ1Fh2wIcUNh+qnuHqufxyZQph25Uosujija9GkyYw243I8qFf7vxNl2BRW0m7EWJJYiv
	5Er4LG314Xy63vKLxxQ6R1tok6uRIeoM=
X-Google-Smtp-Source: AGHT+IEE//BFy3SEa3+lXQUgK2Q3DQY/WdMlfQqtOqX8Qg1l1PqilmSrj478O0/d4Yo5vg7mo1+jH8lAU1KU1uQU2Qc=
X-Received: by 2002:a05:690c:8d02:b0:722:830d:2851 with SMTP id
 00721157ae682-722830d60acmr88259177b3.18.1756812695637; Tue, 02 Sep 2025
 04:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DM3PPF63A6024A9A398FEA588192B174565A307A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A9A398FEA588192B174565A307A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 2 Sep 2025 07:31:24 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5V2Xq3D3S1_beGnGW8KLbE6E8C=PTWzn+VP9TEbN-xfg@mail.gmail.com>
X-Gm-Features: Ac12FXy6RgDe9mxwldyzRQnJqj4gfUPaY8MQgGglc5mocYwvkDUj_ALs0HCfQBA
Message-ID: <CA+5PVA5V2Xq3D3S1_beGnGW8KLbE6E8C=PTWzn+VP9TEbN-xfg@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2025-09-01
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
	Linux Wireless <linux-wireless@vger.kernel.org>, "Dreyfuss, Haim" <haim.dreyfuss@intel.com>, 
	"kyle@infradead.org" <kyle@infradead.org>, "Hutchings, Ben" <ben@decadent.org.uk>, 
	"Yang, You-Sheng" <vicamo.yang@canonical.com>, Josh Boyer <jwboyer@kernel.org>, 
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 10:03=E2=80=AFAM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> Hi,
>
> This contains a firmware of core90 for BZ-HR. We missed it when releasing=
 that core.
>
> Please pull or let me know if there are any issues.
>
> Thanks,
> Miri
> ---
>
> The following changes since commit 993ff19b553cd4d252fdf99f07c28825ef57b8=
62:
>
>   Merge branch 'main' into 'main' (2025-08-29 17:13:10 +0000)
>
> are available in the Git repository at:
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it tags/iwlwifi-fw-2025-09-01

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/669

josh

>
> for you to fetch changes up to 91fd5ffa1510d6a44c4ac72e8182448c13dbf825:
>
>   iwlwifi: add Bz-HR FW for core90-93 release (2025-09-01 16:51:49 +0300)
>
> ----------------------------------------------------------------
> Release core90 for Bz-HR
>
> ----------------------------------------------------------------
> Miri Korenblit (1):
>       iwlwifi: add Bz-HR FW for core90-93 release
>
>  WHENCE                                     |   4 ++++
>  intel/iwlwifi/iwlwifi-bz-b0-hr-b0-93.ucode | Bin 0 -> 1563992 bytes
>  2 files changed, 4 insertions(+)
>  create mode 100644 intel/iwlwifi/iwlwifi-bz-b0-hr-b0-93.ucode

