Return-Path: <linux-wireless+bounces-12391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B040F96A115
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 16:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596621F264ED
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D508514A4E0;
	Tue,  3 Sep 2024 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qfs7ZYZo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA4153BE4
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374866; cv=none; b=Dq4gdyfOnVy1sAaQNGiT9E6vM0kyu+phG3Gq8SPaqQKlcJdIFzIi5GHK2/dqc6hnnZVSTQz/qYqmiYE/h2OhI7Vt3g3JNLepz3pG5z3nQZzenFHtDLlfLYL1I2dBOgfJQHcjm33ZBfz/rgz4BC6OWmEAnUGUpUDF9F2GNvA2mYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374866; c=relaxed/simple;
	bh=s0qNyF8Z0L2RIYLiNDrEXtPAa6gWe40+lDGzeOQdiK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S71dxVBS3hwvHPeREQrXoQCaAhrLqEaaJVaK/DdhR4PukL6EtYoSah/pVnhayMJ6FQ9pTtaLh3RVPV1K2BWVkRzyzwBNX0tfjJp0yrvCoMUMVqfWOJZmcRhgVPAPqfxZAsdEyCpirPZ2IRkwezm7Ztmxay7LXmlOn+nLFs2dzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qfs7ZYZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47094C4CEC9
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725374866;
	bh=s0qNyF8Z0L2RIYLiNDrEXtPAa6gWe40+lDGzeOQdiK8=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=Qfs7ZYZoELaqff2wInrDbw8CGiFqpGy5gMjNDId9vzv1cWC4sWPuc1az/Em5LqHBm
	 BdIp5aDMJucrzG8sdQqSHTLDG0p9BMuAkoAWgYvMwO9RrUIq0EPTiauWZGUXrq7H2W
	 2hbglOWxlAyodvAhHFFK1QUrVcLLRE74mIYIv8BLxeQsyOsR9nRdFrhqZXgRBw9+Y+
	 7hdhwIQOJUrDEBUpNG5k1Kjw4S2QuB4RBzIbMKDdqPNO2aSEXTYpZWmkNqB0RYswBR
	 8+qNLYYb6agf+piik5WpSZSWsaG1FOrndQKCPYZBXbzg6Y4VePeIJjILS4Ro8hKuGP
	 b6f0soinorp4w==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6d74ff7216eso18763907b3.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Sep 2024 07:47:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHojnxjRaNvEdW9P702B9N/QerHTyQU8+fXXFlWpgcbaEYYAe9Dzn/nkHzHv+GC8kGlhkF1IuLFbNd9DWVrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnbySNE/L5e1SpPD+Izi63Ril1W4/1WQ2NmX9NAKh6nVoNiF8x
	+6PHCMmuyoAIAHXpoN1wV29U1XId9Dl4LEtIF37iOcJit/BtSLQ4VaaYATCfF0jmj8yu0+4t6hK
	UXihSsSsh80DTwhBHdYRRnf3tP/A=
X-Google-Smtp-Source: AGHT+IGmaP9BZ7tNhCzK5ZmT/pxf5wR0cHZ6gHfjqAkqJ4GKH+UKpeV3xtl/RHlSRE4O+beoVCJ9pfTzeTvPmazgh5c=
X-Received: by 2002:a05:690c:3245:b0:6b0:a6f0:b0da with SMTP id
 00721157ae682-6d40f340af9mr126775307b3.12.1725374865447; Tue, 03 Sep 2024
 07:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR11MB5810E786AA5A366E2DD412ACA3932@MW5PR11MB5810.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5810E786AA5A366E2DD412ACA3932@MW5PR11MB5810.namprd11.prod.outlook.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 3 Sep 2024 10:47:33 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6EOXPTb0dQwyV9q1-bqmdfp5_OHqEwaALG0PTwRk+i+g@mail.gmail.com>
Message-ID: <CA+5PVA6EOXPTb0dQwyV9q1-bqmdfp5_OHqEwaALG0PTwRk+i+g@mail.gmail.com>
Subject: Re: pull request: iwlwifi firmware updates 2024-09-03
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, Wireless <linux-wireless@vger.kernel.org>, 
	"kyle@infradead.org" <kyle@infradead.org>, "Hutchings, Ben" <ben@decadent.org.uk>, 
	"Ben Ami, Golan" <golan.ben.ami@intel.com>, "Yang, You-Sheng" <vicamo.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:23=E2=80=AFAM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> Hi,
>
>
>
> This contains the new firmware for Bz devices.
>
>
>
> Please pull or let me know if there are any issues.
>
>
>
> --
>
> Thanks,
>
> Miri
>
>
>
> The following changes since commit a0ff525ced1ebcaae1ace6c4a431242c39667c=
ba:
>
>
>
>   Merge branch 'rtl81261-3' into 'main' (2024-09-03 11:24:33 +0000)
>
>
>
> are available in the Git repository at:
>
>
>
>   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.g=
it tags/iwlwifi-fw-2024-09-03

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/288

josh

