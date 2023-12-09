Return-Path: <linux-wireless+bounces-589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FC480B38E
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Dec 2023 11:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B95C280FC7
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Dec 2023 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11811C82;
	Sat,  9 Dec 2023 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1pmax2s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED011707
	for <linux-wireless@vger.kernel.org>; Sat,  9 Dec 2023 10:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7AFC433C8;
	Sat,  9 Dec 2023 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702117003;
	bh=dWIBjqLBeqpjGo+oAPpKweCuNNl5EvOMa2oGHRL4JUs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=J1pmax2s6Icwd9T42p5EsJYW3lREjNseGS5oRGoKIdvmQDCeiM7dv+Ktv/CaBmar3
	 DyqeRRagaIiwevcUzFzVqtXoxu9p1vH73LAJH61y0GRNRFqdjaJEi6WoV+2OIULlFJ
	 IVF5oEjLuKNCKeF3g1IzM9stpeuu9UsDt4tDSevnodWO7rveS2/0JIoRrWCdigKLf7
	 UzHDsd1ZM7JOvIJ4t/argjJi2qqbqdJIq7CobItVJ9Fwy9B3paH8I2ZrBF20zFdmjh
	 ZCqT5JsvpUtbDDMhm41URfP6h4qawpjnr1z6QSbAOpbtpTVtcHzDlFh9+45l1DFAR2
	 LqPD7QMiFEhlQ==
From: Kalle Valo <kvalo@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  linux-wireless@vger.kernel.org
Subject: Re: [wireless-next:main] BUILD REGRESSION
 db7fac15eaf0f09d675730d7002edabe27fe9e1d
References: <202312090036.jwmcWv2Y-lkp@intel.com>
Date: Sat, 09 Dec 2023 12:16:40 +0200
In-Reply-To: <202312090036.jwmcWv2Y-lkp@intel.com> (kernel test robot's
	message of "Sat, 09 Dec 2023 00:59:40 +0800")
Message-ID: <87cyvfn0jb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kernel test robot <lkp@intel.com> writes:

> tree/branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
> main
> branch HEAD: db7fac15eaf0f09d675730d7002edabe27fe9e1d wifi: rtw89:
> mac: refine SER setting during WiFi CPU power on
>
> Error/Warning ids grouped by kconfigs:
>
> gcc_recent_errors
> `-- mips-allyesconfig
>     |-- (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
>     |-- (.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
>     |--
>     | main.c:(.init.text):relocation-truncated-to-fit:R_MIPS_26-against-__sanitizer_cov_trace_pc
>     `-- main.c:(.init.text):relocation-truncated-to-fit:R_MIPS_26-against-_mcount

I assume this is a bug in build servers or elsewhere. I don't think a
wireless patch could cause this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

