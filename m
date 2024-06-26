Return-Path: <linux-wireless+bounces-9595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4675E917D9C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 12:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01117285947
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C217D8B1;
	Wed, 26 Jun 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofzZRTTM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A417D8A7;
	Wed, 26 Jun 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397022; cv=none; b=EGdOfUHgTU6KMFub1AomAr9vy50zBejGt1PRknBojpbIEUWnrMkxU0txTZE4XckEkzc5WT/mXtydiTa/3WZEehkSmuBmqnEU7xAo1vZxRUofcKwsnd4TxQNkEoY1J6Vlmkg6xwNIiTsa1drJcSs23GqjnahRKLFLvd7GeC8fT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397022; c=relaxed/simple;
	bh=P5/Tf3Urx+o+8LWDMR3+WnRwI0VEnPvq0a0aA2ULhyk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WOotUXRKtzBBTJtPNII0hMF5Lv6kQZNxN5lip6Skiwy4pq5y+B2W0gnXURQbBx1Hc66m8DEqOy4jwMNb1mQVR/EFYmXeMrojO4qqwwg8IEIhe6VTjR/+fTQr/3ECFzc9GTgOkJhXF9P5J2wC4N7oUCHu4iju1q8+gHu0ult+4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofzZRTTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189E5C4AF07;
	Wed, 26 Jun 2024 10:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719397021;
	bh=P5/Tf3Urx+o+8LWDMR3+WnRwI0VEnPvq0a0aA2ULhyk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ofzZRTTMZiwLnIzFdB9lgnsrTcrmDH/bMtrKNndCo6gngvF2CfHOm7V37ZezlQX68
	 uSmrQaGLYgXbMaDfNLvL+KvIEbUFXgpi/sbsVXJjEO2AImW96+H2foJNMQS+K3bDlK
	 35p1nBsVbWLgA6DOdOBdJzBp+8lyyDjgFG2P/KuembLPOAlo7yHTTdzquelsD2s5zp
	 qjIGKfvF3RO8r/uIhNOoCD5nW9gCXoFqLitCeSYQymu1dAWOScjCyehuh1812VwKZ/
	 mbwHTq+Cz2ej6PEXrOtbH5IHBePZwx0xyVZSDc7XjyhGxpJmE48JKIRzMH3boYSnHu
	 57pSHjTAxrJpg==
From: Kalle Valo <kvalo@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  James Prestwood
 <prestwoj@gmail.com>,  linux-wireless@vger.kernel.org,
  ath10k@lists.infradead.org,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
	<1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com>
	<87iky7mvxt.fsf@kernel.org>
	<37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com>
	<875xu6mtgh.fsf@kernel.org>
	<f7faff80-864a-4411-ad28-4f1151bc1e51@quicinc.com>
	<082024ce-fdd4-4fb1-8055-6d25f7d2e524@molgen.mpg.de>
Date: Wed, 26 Jun 2024 13:16:58 +0300
In-Reply-To: <082024ce-fdd4-4fb1-8055-6d25f7d2e524@molgen.mpg.de> (Paul
	Menzel's message of "Wed, 26 Jun 2024 11:12:15 +0200")
Message-ID: <878qyshuud.fsf@kernel.org>
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

> Am 26.06.24 um 10:53 schrieb Baochen Qiang:
>
>> OK, there are two issues here:
>> 1. invalid HT rate: "ath10k_pci 0000:02:00.0: invalid ht params rate
>> 1440 100kbps nss 2 mcs 7".
>> As commented by Wen quite some time ago, this has been fixed from
>> firmware side, and firmware newer than [ver:241] has the fix
>> included.

I assume this means that the firmware version
WLAN.RM.4.4.1-00241-QCARMSWPZ-1 or newer has the fix.

>> 2. invaid VHT rate: "ath10k_pci 0000:3a:00.0: invalid vht params
>> rate 1920 100kbps nss 2 mcs 9".
>> After checking with firmware team, I thought this is because there
>> is
>> a mismatch in rate definition between host and firmware: In host, the
>> rate for 'nss 2 mcs 9' is defined as {1560, 1733}, see
>> supported_vht_mcs_rate_nss2[]. While in firmware this is defined as
>> {1730, 1920}. So seems we can update host definition to avoid this
>> issue.
> Looking through the logs since May 2024, I have four different logs:
>
> 1.  invalid vht params rate 878 100kbps nss 3 mcs 2
> 2.  invalid vht params rate 960 100kbps nss 1 mcs 9
> 3.  invalid vht params rate 1730 100kbps nss 2 mcs 9
> 4.  invalid vht params rate 1920 100kbps nss 2 mcs 9
>
> I believe it=E2=80=99s only happening with Cisco networks. I am happy to =
test
> a patch.
>
> By the way, is the firmware version logged by Linux?
>
>     ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id
>     0x00340aff sub 1a56:1535
>     ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0
>     testmode 0
>     ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00288- api 6
>     features wowlan,ignore-otp,mfp crc32 bf907c7c
>     ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
>     ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp
>     max-sta 32 raw 0 hwcrypto 1
>
> Is it 4.4.1-00288?

Yes, that should be WLAN.RM.4.4.1-00288-QCARMSWPZ-1. But I don't know
why 'QCARMSWPZ-1' is not printed by ath10k, maybe we have a bug
somewhere.

> How can I find the file in `/lib/firmware/`?

It should be in ath10k/QCA6174/hw3.0/firmware-6.bin.

All firmware releases are available here:

https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware/-/tree/main/QCA=
6174/hw3.0/4.4.1?ref_type=3Dheads

And more info here:

https://wireless.wiki.kernel.org/en/users/drivers/ath10k/firmware

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

