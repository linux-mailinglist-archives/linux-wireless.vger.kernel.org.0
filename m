Return-Path: <linux-wireless+bounces-8092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6168D01FD
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368B028C6B8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B1515EFC2;
	Mon, 27 May 2024 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEDZjgd8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6815EFBF;
	Mon, 27 May 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817335; cv=none; b=HxB0wlTpbofxJwy18S4/HE+SeHhBgJkLlM9skAkZHfZ7HPPsS6MldVWR/JRH5QUU+t/cWIADkao15GTD3PBFQf1yCg7/aGBEN1CWUCVn/jx49hyKtC5fg/m0UkQM7cYgskINnETOBLsuRIoALgwgyOqgNRRCfBANHsefvjRCZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817335; c=relaxed/simple;
	bh=cHdLFNG7QdO/v0uCoRD5sykZrNWbsVKGxrYwZl/Gm2I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VstlXPsEs+3ujHkjvdzL5j/sNVa96OD2oI3xXFheJy567Z6o4iIaSoQx6dzgNZVhNIGKLQwKHbJgAPBtxup2cq8gETCOM/I9SQqM2xLbkyEQvse9YDZ6YGWDZX73YNKyseFe6+edFutjS0I2uXMDqq5N8i0/M4Vj+eJHUfF+Kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEDZjgd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4212C2BBFC;
	Mon, 27 May 2024 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716817334;
	bh=cHdLFNG7QdO/v0uCoRD5sykZrNWbsVKGxrYwZl/Gm2I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=vEDZjgd8DAMhfS2OaiAJd2CijDT/iN7Xx2TV20FxpdqzX21MTy1203CgyyhSYahHG
	 dBP6g+ga7MWEZP3QQeGa3TcBOXDAEyY/iHcvZiaFMkNXdg8vwbZhQmlPxjTyOTNs1C
	 X+gtNeajxlStK0bLkZay7GELUUAiSde2vHdJFDlNb4tu6N032q79seFK/7k3xJBj+3
	 cZEfHKff/1dx87vhGkW3ug5WJ5H7zqrH3eRXkTP0VUhgtnagtUcbOjSZJep8vgTesL
	 snV1uXiwUYSIiacJWWElX53EUpQiEniY4pFHJj7V/XsvFKZ/iWv4z1xIltRlhGn3y9
	 w4evBhrDdhNWw==
From: Kalle Valo <kvalo@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
  linux-wireless@vger.kernel.org,  ath10k@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Hans de Goede <hdegoede@redhat.com>,
  James Prestwood <prestwoj@gmail.com>
Subject: Re: ath10k_pci 0000:3a:00.0: Could not init core: -110
References: <0c544b16-5c0d-4687-9f96-8ff1f3269f79@molgen.mpg.de>
	<e1bc0bb8-a66e-4e03-bc22-3dc506b6fb59@quicinc.com>
	<87sey38vte.fsf@kernel.org>
	<96828117-2cf8-4a34-a8e6-78ace96b32d3@molgen.mpg.de>
Date: Mon, 27 May 2024 16:42:10 +0300
In-Reply-To: <96828117-2cf8-4a34-a8e6-78ace96b32d3@molgen.mpg.de> (Paul
	Menzel's message of "Mon, 27 May 2024 12:24:59 +0200")
Message-ID: <87o78r8j7x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Menzel <pmenzel@molgen.mpg.de> writes:

> Dear Kalle, dear Baochen,
>
>
> Am 27.05.24 um 11:10 schrieb Kalle Valo:
>> Baochen Qiang writes:
>>=20
>>> On 5/27/2024 4:42 PM, Paul Menzel wrote:
>
>>>> On the Intel Kaby Lake notebook Dell XPS 13 with
>>>>
>>>>  =C2=A0=C2=A0=C2=A0 3a:00.0 Network controller [0280]: Qualcomm Athero=
s QCA6174
>>>> 802.11ac Wireless Network Adapter [168c:003e] (rev 32)
>>>>
>>>> with at least a self-built Linux 6.9-rc5, on April 26th, 2024, and
>>>> Linux 6.8.11, today, May 27th, 2024, the error below happened, and
>>>> the device couldn=E2=80=99t authenticate to a WiFi network until reloa=
ding
>>>> the module *ath10k_core* and *ath10k_pci* (didn=E2=80=99t check just
>>>> *ath10k_pci*):
>>>>
>>>>  =C2=A0=C2=A0=C2=A0 $ sudo modprobe -r ath10k_pci
>>>>  =C2=A0=C2=A0=C2=A0 $ sudo modprobe -r ath10k_core
>>>>  =C2=A0=C2=A0=C2=A0 $ sudo modprobe ath10k_pci
>>>>
>>>> ```
>>>> [=C2=A0=C2=A0 49.441618] ath10k_pci 0000:3a:00.0: wmi service ready ev=
ent not received
>>>> [=C2=A0=C2=A0 49.523814] ath10k_pci 0000:3a:00.0: Could not init core:=
 -110
>> [...]
>>=20
>>> Are you using a distro kernel?
>
> The 6.8.11 is Debian=E2=80=99s current Linux kernel in the suite *unstabl=
e/sid*
> (*linux-image-6.8.11-amd64* 6.8.11-1).
>
>>> Could you check if below patch merged in your kernel? if not can
>>> you merge it and try again?
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/net/wireless/ath/ath10k?id=3De57b7d62a1b2f496caf0beba81cec3c90fa=
d80d5
>> Paul, if you are feeling brave to try out an -rc this commit is in
>> just
>> released v6.10-rc1.
>
> Thank you. I haven=E2=80=99t found out yet, how to reproduce this. I=E2=
=80=99ll keep
> an eye on it.
>
> As the commit message says:
>
>> This results in timeout issue if the interrupt is not fired, due to
>> some unknown reasons.
>
> There are reports from 2016 to 2021 with similar symptoms. These were
> supposedly fixed with
> `/usr/lib/firmware/ath10k/QCA6174/hw3.0/board-2.bin` [1][2]:
>
>     $ md5sum /usr/lib/firmware/ath10k/QCA6174/hw3.0/board.bin
>     /usr/lib/firmware/ath10k/QCA6174/hw3.0/board-2.bin
>     cb37c63d9ca28f53fea1ff09ad7c7a82
>     /usr/lib/firmware/ath10k/QCA6174/hw3.0/board.bin
>     651e921b372848b3928621e6f1d34b01
>     /usr/lib/firmware/ath10k/QCA6174/hw3.0/board-2.bin

Most likely that's a different issue from yours, just with same symptoms
(firmware crashing during firmware initialisation). I have seen also
cases when the firmware crashes when using a wrong board file, but I
suspect your board file is correct.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

