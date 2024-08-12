Return-Path: <linux-wireless+bounces-11314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F17F94EF97
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00B92841B6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AE17E44F;
	Mon, 12 Aug 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2cozLGg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D569517D354
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473102; cv=none; b=IIDbV0tmd21PSbGl0AZmwbHRuKMLOFchQotmz9uq9qnz9teAWhtlra/mViOHvzQDobq5YHphFFmKB3YBZoDAuFzDWSHojoSpIJZ7VFA+kbBgr8Q+QJVcbgK6E6Ecq1zNs+0TUpfOu8337e04sTJjsbqJFJa9LZTW+rnnkPY11L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473102; c=relaxed/simple;
	bh=AuZl7KuGPHABtwpk8j5WTBEXEQt0/z7uhp4RN7X4XFU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lcyFiWHlyVSJ/eDH1BYvBydeaZUik9jBWrtkZWE5zlD9JWi/U5N/TBDCLyGW9l2Im4U/KOluLOrp4j7LMBURorHguxsn2RFd/Fpi3iIAjYzUGgsCxgJ9AzBrw/clAzt29V14CDv6k0SU47jlYsvX9RwWhwmeDQgQ8a89/RBXF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2cozLGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85072C32782;
	Mon, 12 Aug 2024 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723473102;
	bh=AuZl7KuGPHABtwpk8j5WTBEXEQt0/z7uhp4RN7X4XFU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=H2cozLGguWUUG21BS1FK/cXXZRdtQy96L00RODJLIU1GyIxTH8um4XGLNAnGpNjDJ
	 80zqrfWn7bQMg0DyGO3Ic0weobLcGTofGxjZBuCPin4ZXRBsLJ4aoPy44nHJnr3+2r
	 J6UgOEWtNHum03F3H63rl1aemCBNAyV4s4YM6sQONR2iWWPL92z5/ciO6B6jtXG9M0
	 hJiDzSyP1E2uotLa+YxnKelf7OJczZEJx3XLEvCDoPMKfd/8bImKNZc9UHctk0V6cE
	 KpajfpEWDj7jd/haKvKJ1kBjqA6kEww5WMyQrgiEiG2jlWmaqir+SPvYtHtmGkg8Rt
	 X5ysYBf7RKdxQ==
From: Kalle Valo <kvalo@kernel.org>
To: MOHAMMAD RASIM <mohammad.rasim96@gmail.com>
Cc: linux-wireless@vger.kernel.org,  ath10k@lists.infradead.org
Subject: Re: [question] is it possible to enable monitor mode /packet
 injection on wcn3990
References: <CACq04CG8WCGDxf6Krx3bjxHU5OtYJJNOtD77TtPQhTfdy6ey_g@mail.gmail.com>
	<56BBE89F-FF40-47C4-A4B9-F492FD8F6E2A@gmail.com>
	<87zfpigr5t.fsf@kernel.org>
	<D802221D-56B0-4CBB-833A-EA548A36FC7E@gmail.com>
Date: Mon, 12 Aug 2024 17:31:39 +0300
In-Reply-To: <D802221D-56B0-4CBB-833A-EA548A36FC7E@gmail.com> (MOHAMMAD
	RASIM's message of "Mon, 12 Aug 2024 16:51:07 +0300")
Message-ID: <87le1124ok.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

MOHAMMAD RASIM <mohammad.rasim96@gmail.com> writes:

>> On 12 Aug 2024, at 10:02=E2=80=AFAM, Kalle Valo <kvalo@kernel.org> wrote:
>>=20
>> + ath10k list
>>=20
>>> I have a device that has the wcn3990 wifi chip that uses the
>>> ath10k_snoc driver, i tried to put it in monitor mode, the "set
>>> monitor" mode command succeed but can't get any scanning working after
>>> that, does the chip support such mode?has anyone tried monitor mode
>>> with this chip or other snoc chips?
>>=20
>> I doubt that WCN3990 firmware supports monitor mode, though just
>> guessing here.
>
> Some people has got monitor mode working under android ( different
> driver, qcacld-2.0, and qcacld-3.0) with these kind of chips:
> https://github.com/kimocoder/qualcomm_android_monitor_mode/
>
>
> Some older chips (wcn3680 think) even supported packet injection(using
> the older qcacld-2.0 driver).
>
> Commits in the newer qcacld-3.0 driver (that supported the wcn3990)
> did contain hints that monitor mode and packet injection should work.
>
> So maybe the firmware does support it?

Maybe it does then, I don't know really. My response was just based on
my past experiences with mobile chipsets.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

