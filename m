Return-Path: <linux-wireless+bounces-8081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 733C88CFC78
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8A11F2269F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30743AB5;
	Mon, 27 May 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOz4ZYnN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286E1A2C36;
	Mon, 27 May 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801009; cv=none; b=G4aszYp43En3JX4Wjlh/eN04bFj5ZEZ/RKwpv+YevBshvxnZCZk05kH8AhBcpbauoXFkC3HLwNcZ+czxdB5QpDHVrcX5fuXDtW53gnZ9MocHnF2ikzI0FY51cS0UtrbxwsiDmxSvY2thi6XhgVBHdxkCv2ViNL73j4pdSVolws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801009; c=relaxed/simple;
	bh=5dfjpuPYXbW2r5fHBvyR6PsWqCxClj4xZLD90HlUIcU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OtwW2QcwZkm8s2EKR+SPVgUaDVoY4znAjusUblQuCarSuS0T6oM2Qdw9KFQTvFasjUf5eD97wG+mIQh7AGlUPSnqIt/dR2LkQUwe6bWMhCMtu+Of2F/JaVlMNJdO4xr87MRJZVmkFJfA5meiTyiAc2GqDpQO4+jcKfYBEXpXRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOz4ZYnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB60C2BBFC;
	Mon, 27 May 2024 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716801009;
	bh=5dfjpuPYXbW2r5fHBvyR6PsWqCxClj4xZLD90HlUIcU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GOz4ZYnNLPQeUXck1rJL8XGc1GgaNol/nvQ867oCfdIO1K3hJi+HuJ0crQd7tItCl
	 Lj2SeG90fwDjE1AgGfPwkwFiVERwhDPeQcSJ7phQNLcKtgh1tZDHiSleY0es/Zn4BO
	 +Cx8rrq6ppXGWuo0G5NdTOZMCd2zwx2QP8xxV7/3mCopGyvRvV25hPDQl6ZKycb4NL
	 FiFGpKXjVphtIuHLwO9klyDD1/dWnZvtM4dOsXM06pEQzRimk/YxFRDHRPVWf4R4KH
	 XZDG6vol+fsqMq0ImxGS6nnUA1oGOoFeyT+RZvPHBKtwnoRO9Pk0itz+fG2ELmiEke
	 8vXHya6m9a8vQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,  <linux-wireless@vger.kernel.org>,
  <ath10k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,  Hans de
 Goede <hdegoede@redhat.com>
Subject: Re: ath10k_pci 0000:3a:00.0: Could not init core: -110
References: <0c544b16-5c0d-4687-9f96-8ff1f3269f79@molgen.mpg.de>
	<e1bc0bb8-a66e-4e03-bc22-3dc506b6fb59@quicinc.com>
Date: Mon, 27 May 2024 12:10:05 +0300
In-Reply-To: <e1bc0bb8-a66e-4e03-bc22-3dc506b6fb59@quicinc.com> (Baochen
	Qiang's message of "Mon, 27 May 2024 17:00:27 +0800")
Message-ID: <87sey38vte.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 5/27/2024 4:42 PM, Paul Menzel wrote:
>> Dear Linux folks,
>>=20
>>=20
>> On the Intel Kaby Lake notebook Dell XPS 13 with
>>=20
>> =C2=A0=C2=A0=C2=A0 3a:00.0 Network controller [0280]: Qualcomm Atheros Q=
CA6174
>> 802.11ac Wireless Network Adapter [168c:003e] (rev 32)
>>=20
>> with at least a self-built Linux 6.9-rc5, on April 26th, 2024, and
>> Linux 6.8.11, today, May 27th, 2024, the error below happened, and
>> the device couldn=E2=80=99t authenticate to a WiFi network until reloadi=
ng
>> the module *ath10k_core* and *ath10k_pci* (didn=E2=80=99t check just
>> *ath10k_pci*):
>>=20
>> =C2=A0=C2=A0=C2=A0 $ sudo modprobe -r ath10k_pci
>> =C2=A0=C2=A0=C2=A0 $ sudo modprobe -r ath10k_core
>> =C2=A0=C2=A0=C2=A0 $ sudo modprobe ath10k_pci
>>=20
>> ```
>> [=C2=A0=C2=A0 49.441618] ath10k_pci 0000:3a:00.0: wmi service ready even=
t not received
>> [=C2=A0=C2=A0 49.523814] ath10k_pci 0000:3a:00.0: Could not init core: -=
110

[...]

> Are you using a distro kernel? Could you check if below patch merged
> in your kernel? if not can you merge it and try again?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/net/wireless/ath/ath10k?id=3De57b7d62a1b2f496caf0beba81cec3c90fad8=
0d5

Paul, if you are feeling brave to try out an -rc this commit is in just
released v6.10-rc1.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

