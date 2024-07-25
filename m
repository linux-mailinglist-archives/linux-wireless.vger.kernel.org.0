Return-Path: <linux-wireless+bounces-10526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C26A93C948
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 22:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E08F1C20E68
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16A5381E;
	Thu, 25 Jul 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb1k7k++"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0DB3A8C0
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937849; cv=none; b=WdZQPA+Viv/XQomDiVxFYq+gXHszRN6nEhKgpEG9ALQLLk6RSDg14gBl+QzJXO0zMl7LGlUVaAfDtlY7Yy0ziiuAOnxeBLNOKwqFSYeBdaWhXtMsSqm9rDyCNOJxcdvcQD5kB1jAfk2F5NM4Yj1pbVj1BmkFb7b2q0W/c8WRGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937849; c=relaxed/simple;
	bh=FGFdOGUs6vnV8uH7fubUl3VOiYyO2p6PFoVQ+dWtZfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEcxfKoqGQRHgVyZ2CZ0nxBIsr2G/CqvPz61CO8j71OWo+e1IgwOYgsZGv9I5ZHd8vg1lSY9EODI0AjLkx9zQVsFiCcmfEQZlbYLHUYO7EvQBgamh3GqssppqE1E327JHIwxb8XO5GkgsXl9thheD581AFaaNDvunQxspS1QTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb1k7k++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A938EC4AF0E
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 20:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721937849;
	bh=FGFdOGUs6vnV8uH7fubUl3VOiYyO2p6PFoVQ+dWtZfY=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=Rb1k7k++emt+IczlrhZ+E6Fi7dmuKanA9xvZUJedJpPuQ/3aM26nqrCsR8VK3wUDg
	 Bbv8aI8pnijHS/t/RGjkrzYIe0LDgdAZpXyLXxe+smrOshmSwvnuRX3GK8ZO21zSf7
	 CGaPFqZTQngqw7vv/xDZtKHtw6G0RG60hbzvXIiU/LUVzRi07+LrCxYUo5eWQ3kbhl
	 xlscTdcXmkihtEndARK14u9vGAZs0q28VBys5IQZYceWZjBAi19+Y+MGACF53WOKYx
	 f1j0TqC+zqU7W8SL6pZ1IvQ+EJxnbNuWfUAVocsJWTra9qgxR6dU7KTa96LnUkNxhs
	 YT8PlBUZQYpnQ==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66acac24443so15527777b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 13:04:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+vutAKeecvtNzH2uNrq+5yGFXEodwSAB4G5IRycUU2GiB3yHriGemBnqj8egI0pAjB7bTHKrd1cJGmBeK7hGc1rB9pV4OgMBZCRWdnEs=
X-Gm-Message-State: AOJu0YyGLvZbUKaJ4jRj12bna9DBOscVxRHH8nCUN0k9OjQR2RUhr2wz
	/E4Mn6pPymrNkrtOGCIKAJYL0/fspQVf1dzhO9Tf3s11MiLYiEGPROigpDEaM459vr/V5mRl3Wm
	TLW2Qu+ekPao45Gmd4il4u+Z5NNU=
X-Google-Smtp-Source: AGHT+IFQrNNgWClgGET66ahdMkh8p2XT5FFZylFHpU9xLAAVZQpAtG5Kef+u5mLu4mbLsYK5v7E4J/mvrjaZHvBA3Fw=
X-Received: by 2002:a0d:ee44:0:b0:61b:3304:b702 with SMTP id
 00721157ae682-675b3a11661mr32940127b3.5.1721937848927; Thu, 25 Jul 2024
 13:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR11MB581002D586D332CACEB335BAA3AB2@MW5PR11MB5810.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB581002D586D332CACEB335BAA3AB2@MW5PR11MB5810.namprd11.prod.outlook.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 25 Jul 2024 16:03:57 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6zGFMsV16BhmbB9QnZQ9UsUw1-44MK6gOc84MnhroDXA@mail.gmail.com>
Message-ID: <CA+5PVA6zGFMsV16BhmbB9QnZQ9UsUw1-44MK6gOc84MnhroDXA@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2024-07-25
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, "kyle@infradead.org" <kyle@infradead.org>, 
	"Hutchings, Ben" <ben@decadent.org.uk>, "Ben Ami, Golan" <golan.ben.ami@intel.com>, 
	"Yang, You-Sheng" <vicamo.yang@canonical.com>, Wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 11:15=E2=80=AFAM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> Hi,
>
> This reverts the firmware updates for So/Ma/Ty.
>
> (an unexpected API change went in these firmwares, that isn't actually co=
mpatible with all drivers supporting this API version.)
>
> --
>
> Thanks,
>
> Miri
>
>
>
> The following changes since commit f032eea14345546dd09457358413b186c08006=
bf:
>
>
>
>   iwlwifi: add gl FW for core89-58 release (2024-07-23 13:17:27 +0300)
>
>
>
> are available in the Git repository at:
>
>
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it tags/iwlwifi-fw-2024-07

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-fir=
mware.git
tags/iwlwifi-fw-2024-07
fatal: couldn't find remote ref tags/iwlwifi-fw-2024-07

Did you forget to push the tag out?

josh

>
>
>
> for you to fetch changes up to f1e56cc8218a35770f1c1fd3756912297258d750:
>
>
>
>   Revert "iwlwifi: update ty/So/Ma firmwares for core89-58 release" (2024=
-07-25 17:52:22 +0300)
>
>
>
> ----------------------------------------------------------------
>
> revert core89 FW updates for Ty/So/Ma
>
>
>
> ----------------------------------------------------------------
>
> Miri Korenblit (1):
>
>       Revert "iwlwifi: update ty/So/Ma firmwares for core89-58 release"
>
>
>
>  WHENCE                        |  14 +++++++-------
>
>  iwlwifi-ma-b0-gf-a0-89.ucode  | Bin 1746904 -> 1746844 bytes
>
>  iwlwifi-ma-b0-gf-a0.pnvm      | Bin 55112 -> 55112 bytes
>
>  iwlwifi-ma-b0-gf4-a0-89.ucode | Bin 1599332 -> 1599272 bytes
>
>  iwlwifi-ma-b0-gf4-a0.pnvm     | Bin 27828 -> 27828 bytes
>
>  iwlwifi-ma-b0-hr-b0-89.ucode  | Bin 1539360 -> 1539360 bytes
>
>  iwlwifi-so-a0-gf-a0-89.ucode  | Bin 1739424 -> 1731172 bytes
>
>  iwlwifi-so-a0-gf-a0.pnvm      | Bin 55192 -> 55192 bytes
>
>  iwlwifi-so-a0-gf4-a0-89.ucode | Bin 1589924 -> 1589864 bytes
>
>  iwlwifi-so-a0-gf4-a0.pnvm     | Bin 27868 -> 27868 bytes
>
>  iwlwifi-so-a0-hr-b0-89.ucode  | Bin 1530624 -> 1530624 bytes
>
>  iwlwifi-ty-a0-gf-a0-89.ucode  | Bin 1681292 -> 1681232 bytes
>
>  iwlwifi-ty-a0-gf-a0.pnvm      | Bin 55036 -> 55036 bytes
>
>  13 files changed, 7 insertions(+), 7 deletions(-)

