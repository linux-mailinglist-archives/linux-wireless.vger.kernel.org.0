Return-Path: <linux-wireless+bounces-10142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F67992CC63
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 10:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405131C2265D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 08:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB1C4F602;
	Wed, 10 Jul 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvNsMLRK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B73A8E4;
	Wed, 10 Jul 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598531; cv=none; b=JZvmKrmY9YqFkTefogzk0vJN0d70bzKqRyk5zaRvO4HmIjQFb+xVfJP78mJpKxIznHg6IP0zdpMrKVte7sqFX7ymwbLhjSE8SOdBlePXQIabjbhFhJ5hHXHKFp/nt/mmWRHObxGf9bjKoEU+bur1E7b7lUx9uyZ8E3kOshZxhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598531; c=relaxed/simple;
	bh=IU4zclk/Ulyub3QjR0wMrawi5zxEuiagGVree2vLW50=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qMB4Rmo3O6rhTU4CzT9WPYVj1IXhZ7/maeolm8BL0hkvtW0VpXA07z2zBTuvpcZt4qhd76y+pHuoe33NzwEY7lGYaFOAJm05m7ox5C7E/m/VPTtyRyZtIfGiT0nv8f8OEPk2cG7JHEkGjJstmO7kNHTWlmmVIOc4HB0yhgXYXvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvNsMLRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20F2C32781;
	Wed, 10 Jul 2024 08:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720598529;
	bh=IU4zclk/Ulyub3QjR0wMrawi5zxEuiagGVree2vLW50=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KvNsMLRKkbA5xLGtPHlcEYqkodYQO348rZWv037tyGfeg8xW9NaCsmSlyKRO7UnMK
	 a6HIVFpdZloOSUUkTyEINE9XbDuh2dUOhygTTxFXReY1WTvQCEYe7SDRMOTbXHoVrq
	 3bMc4adbQTYnxCEK28vhhJ9rKX6oTv/1oEp3twX4TeZNz52fTJd7nkq9wMJbsKByLt
	 4879/7iZnjTvF9wGI6TfDmJoPBOmATKnK+TaOIMpALUj+zTQ8uQK1LuT29wipcjsfv
	 U4NWnfOn2nLPJSo7ND8kGrW1LHi88eB/NM+z+AJM01sAPBcjgsVh/Z1UlRGABTjyxn
	 s3tIcCCsyB2LQ==
From: Kalle Valo <kvalo@kernel.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "briannorris@chromium.org" <briannorris@chromium.org>,
  "francesco@dolcini.it" <francesco@dolcini.it>,  Pete Hsieh
 <tsung-hsien.hsieh@nxp.com>,  Rafael Beims <rafael.beims@toradex.com>,
  Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v11 0/2] wifi: mwifiex: add code to support host mlme
References: <20240704033001.603419-1-yu-hao.lin@nxp.com>
	<PA4PR04MB9638BD3D09017A786FC3DAECD1A42@PA4PR04MB9638.eurprd04.prod.outlook.com>
Date: Wed, 10 Jul 2024 11:02:06 +0300
In-Reply-To: <PA4PR04MB9638BD3D09017A786FC3DAECD1A42@PA4PR04MB9638.eurprd04.prod.outlook.com>
	(David Lin's message of "Wed, 10 Jul 2024 01:47:17 +0000")
Message-ID: <8734ohn08x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Lin <yu-hao.lin@nxp.com> writes:

> I found the state of this patch series had been changed to "Deferred".
>
> Since this patch series had been reviewed for a long period of time and
> reviewed, tested, and acked by members from community. I wonder what
> else should I do to let it be merged to mainline Linux kernel?

Most likely the merge window opens on Sunday and I didn't want to apply
the patchset last minute. So this has to wait v6.12.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

