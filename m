Return-Path: <linux-wireless+bounces-28100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BACBF120E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 14:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D88594F3D23
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A283054FB;
	Mon, 20 Oct 2025 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4R14mJs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104E3126D5
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962932; cv=none; b=G87GVadC8L+IufvsDaVydLTnByE3/aXztwdP98uVPDvhXh26CSiTLcng+msE8wRi4ov36kdM58E1wyDsoiJAoZ53gzYVyEeubNFNlRK+GHBAxif7cGyZcTh2dpmUC2bxz8fveS5XxdB00AGLLeA3H8dMjJ8REIgVbXhADsG/u+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962932; c=relaxed/simple;
	bh=y7gCXefr60jPNW6Qfn/cEzOaMtV2f4XDa7zZP/7jMSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INgzncJRhEMOcbNhb4s7/alQr/q3BjY0MWknSEPM1sPOK6oTYfNIVzIyUw43PZrII+vrKpDQZAqDyD2QT2QTQpJWZOtT+O7v7HrIhBSKAH3Mhs2a4bbxzZI7LFTw+lUqmuX9qqVOKXuOWYMPvLB9FBBzVgfOsgyNirU32WZIHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4R14mJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBBEC16AAE
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 12:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760962931;
	bh=y7gCXefr60jPNW6Qfn/cEzOaMtV2f4XDa7zZP/7jMSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=U4R14mJskkMoBsKS1uQpDPwlHgbca3UMIKJ6kdw4vDkF7VM38WPHk8l7H+rGrxUsp
	 7810Ytsx+46KWYfipnSK6K/8TOmMGJe4B7rlrOLZoZjP+q2HmHFtOZG1wI4+0DXlXg
	 cTbqYW+t04+Tu7a/cSG4e9kBuMQZKCJeGg7dZvjOBiMH/uHgsdwtXDTntWdWxm+cJi
	 0ttLsEL9DR2CW0PtGPtC5THX1ymBsZ79psr+H/rT3bpuIori9xW9rq1cfGvmXSsSt1
	 5dmicxyxVRNkorbb63ISPZMO/lcv+daArSLB3TaaLoH6KEhcactHMiiOCUEBB+f4ht
	 QRO/Z+i2Izi7g==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63e0c6f0adfso4381333d50.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 05:22:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW86OlGH6vBZ9ElvcdvYd1ICEqU5GzHdjAhAm+/Pl/XI4MVSWGYPn8O0kQbZD59fXnMhZBFFjFB5HBpKJ8QRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYtRmkz/Qy26sdBOHObOm572FrasTtzocIFfV4w19/A+rzrSOD
	grY3y4XHw8vpJtMtXiAaEyp1f23J0M6DZG5t+GAzwHh2tNJlbVHVCPiol1OQkL20eVflWXVxfX/
	1FBtUCFlRKtlhp+E7A8+NRAyXEa/IaTw=
X-Google-Smtp-Source: AGHT+IF8pYZElQaCk4zJXFs/Jlj08M9Xy2MBNe4sbR5o37plVndWm3ke7AXS2nxAGsvLWRCdaq2BXBUk4IXPlErLu38=
X-Received: by 2002:a05:690e:1901:b0:63e:2906:e7f2 with SMTP id
 956f58d0204a3-63e2906eec9mr5800081d50.1.1760962931015; Mon, 20 Oct 2025
 05:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DM3PPF63A6024A9F84E169D8EC641101840A3F5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A9F84E169D8EC641101840A3F5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Mon, 20 Oct 2025 08:22:00 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5FXPSs2-8oZk5wvugsEkAnO6=9OeM9Z4X4HvpZY2EKWw@mail.gmail.com>
X-Gm-Features: AS18NWAr16pDcMtma94Djpf7sTYFhuY_k9hqY34h1uQhN7uJ0bgc90gS7FslKoE
Message-ID: <CA+5PVA5FXPSs2-8oZk5wvugsEkAnO6=9OeM9Z4X4HvpZY2EKWw@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2025-10-20
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
	Linux Wireless <linux-wireless@vger.kernel.org>, "Dreyfuss, Haim" <haim.dreyfuss@intel.com>, 
	"kyle@infradead.org" <kyle@infradead.org>, "Hutchings, Ben" <ben@decadent.org.uk>, 
	"Yang, You-Sheng" <vicamo.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/749

josh

On Mon, Oct 20, 2025 at 7:44=E2=80=AFAM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> Hi,
>
> This contains the firmwares of core98 for all supported devices.
>
> Please pull or let me know if there are any issues.
>
> Thanks,
> Miri
> ---
>
> The following changes since commit 8b4de42e3432d1cdea4df82b2971486e143258=
f9:
>
>   Merge branch 'amd-staging' into 'main' (2025-10-18 19:50:58 +0000)
>
> are available in the Git repository at:
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it tags/iwlwifi-fw-2025-10-20
>
> for you to fetch changes up to d7efac218dd5dce4d74b2f72c78618461ed7683f:
>
>   iwlwifi: add Bz/Fm and gl FW for core98-161 release (2025-10-20 14:36:1=
7 +0300)
>
> ----------------------------------------------------------------
> Release core98
>
> ----------------------------------------------------------------
> Miri Korenblit (4):
>       iwlwifi: update cc/Qu/QuZ firmwares for core98-161 release
>       iwlwifi: update ty/So/Ma firmwares for core98-161 release
>       iwlwifi: update Bz/Hr and Bz/Gf firmwares for core98-161 release
>       iwlwifi: add Bz/Fm and gl FW for core98-161 release
>
>  WHENCE                                      |  40 +++++++++++++++++-----=
------
>  intel/iwlwifi/iwlwifi-Qu-b0-hr-b0-77.ucode  | Bin 1406572 -> 1406572 byt=
es
>  intel/iwlwifi/iwlwifi-Qu-b0-jf-b0-77.ucode  | Bin 1323292 -> 1323292 byt=
es
>  intel/iwlwifi/iwlwifi-Qu-c0-hr-b0-77.ucode  | Bin 1406588 -> 1406588 byt=
es
>  intel/iwlwifi/iwlwifi-Qu-c0-jf-b0-77.ucode  | Bin 1323308 -> 1323308 byt=
es
>  intel/iwlwifi/iwlwifi-QuZ-a0-hr-b0-77.ucode | Bin 1406716 -> 1406716 byt=
es
>  intel/iwlwifi/iwlwifi-QuZ-a0-jf-b0-77.ucode | Bin 1323376 -> 1323376 byt=
es
>  intel/iwlwifi/iwlwifi-bz-b0-fm-c0-101.ucode | Bin 0 -> 2225612 bytes
>  intel/iwlwifi/iwlwifi-bz-b0-gf-a0-100.ucode | Bin 1837024 -> 1836712 byt=
es
>  intel/iwlwifi/iwlwifi-bz-b0-hr-b0-100.ucode | Bin 1584684 -> 1584620 byt=
es
>  intel/iwlwifi/iwlwifi-cc-a0-77.ucode        | Bin 1368096 -> 1368096 byt=
es
>  intel/iwlwifi/iwlwifi-gl-c0-fm-c0-101.ucode | Bin 0 -> 2209924 bytes
>  intel/iwlwifi/iwlwifi-ma-b0-gf-a0-89.ucode  | Bin 1752072 -> 1752072 byt=
es
>  intel/iwlwifi/iwlwifi-ma-b0-gf-a0.pnvm      | Bin 55128 -> 55128 bytes
>  intel/iwlwifi/iwlwifi-ma-b0-gf4-a0-89.ucode | Bin 1600024 -> 1604120 byt=
es
>  intel/iwlwifi/iwlwifi-ma-b0-gf4-a0.pnvm     | Bin 27836 -> 27836 bytes
>  intel/iwlwifi/iwlwifi-ma-b0-hr-b0-89.ucode  | Bin 1539788 -> 1539788 byt=
es
>  intel/iwlwifi/iwlwifi-so-a0-gf-a0-89.ucode  | Bin 1736108 -> 1736108 byt=
es
>  intel/iwlwifi/iwlwifi-so-a0-gf-a0.pnvm      | Bin 55208 -> 55208 bytes
>  intel/iwlwifi/iwlwifi-so-a0-gf4-a0-89.ucode | Bin 1590688 -> 1590688 byt=
es
>  intel/iwlwifi/iwlwifi-so-a0-gf4-a0.pnvm     | Bin 27876 -> 27876 bytes
>  intel/iwlwifi/iwlwifi-so-a0-hr-b0-89.ucode  | Bin 1522860 -> 1526956 byt=
es
>  intel/iwlwifi/iwlwifi-ty-a0-gf-a0-89.ucode  | Bin 1677976 -> 1678176 byt=
es
>  intel/iwlwifi/iwlwifi-ty-a0-gf-a0.pnvm      | Bin 55052 -> 55052 bytes
>  24 files changed, 24 insertions(+), 16 deletions(-)
>  create mode 100644 intel/iwlwifi/iwlwifi-bz-b0-fm-c0-101.ucode
>  create mode 100644 intel/iwlwifi/iwlwifi-gl-c0-fm-c0-101.ucode

