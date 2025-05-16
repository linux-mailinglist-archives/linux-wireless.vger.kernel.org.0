Return-Path: <linux-wireless+bounces-23061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD669AB9728
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 10:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD9F3B5652
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE222A4D8;
	Fri, 16 May 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZd7yk37"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C8225A36
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382800; cv=none; b=lDez08DMfO8bFDNNyTwMusQ+1C/ZIQcOTF8CNoXo4y5EMd+WEEBouhBSoPDr1URyeNU18IjKiJePXP62oVpKM6P7VGEk2vKCBnyLTC66ijr9wQmLYlhBfae6cUYaBvsl4ATvrtHfxrOC5dVZMM3LFoUsbHwyu+NmLkh2BS4zp+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382800; c=relaxed/simple;
	bh=y2FmrTpq5qO+ynB2zbZ/yHGzPUXDuBcfOytFW88D3ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9KOt5bmyg3PP7+UovHL5SrQVPeXnrFgWfZnlnzi0eo3mX/iFuRcsiEroMVTml5kpUwj8Kg79+R/JzQYDCwANmpJPMO0BH750gCehzHn3+O6TYGo3Q6XrtUvnhPmdLwfGoR/OS4VkAbmG4nUQuMtDZkRvS4RfV5HZdIX82STbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZd7yk37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F89C4AF09
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 08:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747382800;
	bh=y2FmrTpq5qO+ynB2zbZ/yHGzPUXDuBcfOytFW88D3ts=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=gZd7yk37uC2dPqqgtYd9HGUWYxgvFO+Sq2NS9fGt/OEvvKueiEP5gaj5rn0Kdz5K5
	 9QjyzT+94Ixe0RKeptZMzmDTD2MWkpB81j72X3gzl9PUdtBgv8F3360dVlZ40sdzvG
	 CSEgJst829Hk/gq2s3ZEp5F7lBWf/Lc+SCTMMHdDnTBarVsaEl6RgDh5eA1Z62+hLA
	 F0Ohzpo/A92oBR7M73Xflbizs+tC40YlF23iLDjLxkwi/PHCmqYfxnRg9Y2l6xZ307
	 WghJ1iBSlnae2a2VNk5MASgeh5A+a5GqTz1FWbvBK0wHLfAl0uHMHaRO5QIFgpp5iG
	 MTfa1s6bDhTMg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso16037931fa.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 01:06:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YwnNO3mNEQmmpOU5ttY0CMs8wV4XGfxUAk+5B0OdM58SXaewywr
	b2dUboTajqdZf9WSn9vSP/D9vebtBZ1i1PCpJ6FeMGZUuSZCwfLbSqWKF0dw8cjEIPfx0unFx91
	6xMmYHf5ZlxZAdN1ralbz3RxUFfPIf0U=
X-Google-Smtp-Source: AGHT+IEYT5K6NfsjBzUNGkk4Dl1sgXXb0zXwKytE47oZnbluhUjF99fwYCaOoVF1F61tfs93AsdL2P6Bnlxd6e4Q7Ok=
X-Received: by 2002:a2e:a9a5:0:b0:30d:b3f3:bcc6 with SMTP id
 38308e7fff4ca-328096dd6aemr5628841fa.21.1747382798138; Fri, 16 May 2025
 01:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2199341745004929@mail-sendbernar-production-main-32.klg.yp-c.yandex.net>
In-Reply-To: <2199341745004929@mail-sendbernar-production-main-32.klg.yp-c.yandex.net>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 16 May 2025 16:06:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v64+zxuEr609OPZ+kDHiTU=KuC1fjg23BD+sa5vs+hzUgA@mail.gmail.com>
X-Gm-Features: AX0GCFsARbd5o9HZF8YIR6AnokxEa-j_NfdqxKR-BgAiBas48peWh4LKM8PYc2M
Message-ID: <CAGb2v64+zxuEr609OPZ+kDHiTU=KuC1fjg23BD+sa5vs+hzUgA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Vietnam (VN)
 for 2025
To: Duy Hoang <duy@etylix.me>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for taking so long to get to this.

On Sat, Apr 19, 2025 at 3:35=E2=80=AFAM Duy Hoang <duy@etylix.me> wrote:
>
> According to [1] and [2]:
> - Update frequency range to match with Circular
> - Update units from dBm to mW to match values listed in Circular
> - Add AUTO-BW flags to allow the use of 160 MHz based on other rules
> - Update to allow use of 6 GHz band
>
> Detail:
> * 2400 - 2483.5 MHz
>   - 200 mW (23 dBm)
> * 5150 - 5250 MHz
>   - 200 mW (23 dBm)
>   - Indoor only
> * 5250 - 5350 MHz
>   - 200 mW (23 dBm)

If my translator app is working correctly, this is 200 mW if TPC is
implemented, and 100 mW if not. Since Linux currently doesn't have TPC,
it should be 100 mW.

>   - DFS
> * 5470 - 5725 MHz
>   - 1000 mW (30 dBm)

Same here. 500 mW instead.

>   - DFS
> * 5725 - 5850 MHz
>   - 1000 mW (30 dBm)
> * 5925 - 6425 MHz
>   - LPI
>     * 200 mW (23 dBm)
>     * Indoor only
>   - VLP
>     * 25 mW (14 dBm)
>     * Indoor and outdoor
>
> [1] https://datafiles.chinhphu.vn/cpp/files/vbpq/2021/10/08-btttt.signed.=
pdf

This document also lists 60 GHz usage, would you consider adding it as well=
?


Thanks
ChenYu

> [2] https://mic.gov.vn/van-ban-phap-luat/25099.htm
>
> Signed-off-by: Hoang Pham Anh Duy <duy@etylix.me>
> ---
>  db.txt | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index e331d4f..eb882de 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -2001,12 +2001,16 @@ country VI: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> +# Source:
> +# https://datafiles.chinhphu.vn/cpp/files/vbpq/2021/10/08-btttt.signed.p=
df
> +# https://mic.gov.vn/van-ban-phap-luat/25099.htm
>  country VN: DFS-FCC
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (17)
> -       (5250 - 5330 @ 80), (24), DFS
> -       (5490 - 5730 @ 80), (24), DFS
> -       (5735 - 5835 @ 80), (30)
> +       (2400 - 2483.5 @ 40), (200 mW)
> +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> +       (5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW
> +       (5470 - 5725 @ 80), (1000 mW), DFS, AUTO-BW
> +       (5725 - 5850 @ 80), (1000 mW), AUTO-BW
> +       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
>
>  # Source:
>  # http://www.trr.vu/attachments/category/130/GURL_for_Short-range_Radioc=
ommunication_Devices2.pdf
> --
> 2.46.0.windows.1
>

