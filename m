Return-Path: <linux-wireless+bounces-6818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F28B1B3C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 08:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4842D1C20FE0
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 06:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6296941C76;
	Thu, 25 Apr 2024 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWUqTRPq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF33BBE8
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027693; cv=none; b=Xr0dWJV3g2KpkTeR5MdBG59Nip1TI6rUPqJCu6cW2o5LjYH05OdlSl6E2eElwKC5qdHjEA9RcjAG4H34aV05jHMeJ5xRWlJNNawhnTKDqfhBWpDhu3W/C5yPA4cqiVzZ0LiYdNlRIdQAYPwiV0eKFgkzjlI17UDgBupiPcRp3ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027693; c=relaxed/simple;
	bh=5iHJGEOJ8jIsQ7snxgIS8MN0TzmEToKi0gU9u6fhNeg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PUvUjQQCUXNwhdwT3uMKtDLkrvUCW70mfUbAudx7Wx0BDe2FnP/OKixg2za9Ib3fCn7lL4AcqEd+G1tk87wvg9mKbdHiEwTLqJ0E7cwKXaQJh5TTDfG6QLoSET8E/26mnAZIoFzxu3jwQeMEh1S99utJ16rZM1hXZ6nGNmEAODU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWUqTRPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A32C113CC;
	Thu, 25 Apr 2024 06:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714027692;
	bh=5iHJGEOJ8jIsQ7snxgIS8MN0TzmEToKi0gU9u6fhNeg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=IWUqTRPqVbv2zuVB7maP078BHs0oMArTfdXmFIDFQWJ2NqwAv4QuyUFN3FtXaF3CO
	 8y/qQAWN5SEz25L04hVWvv0Th0nyM1aieOB3KwnVcJTnZv9ZPTy0Pv1ehrEwofRCEQ
	 /KpssjBe11ffrq/ahAYvc4IJC+GFv7wt6mbxQoPAhX4xSrX95MTlKB1VLsZ1Rm3bJF
	 YPjc2Cz9C0dfKuTN0Kg1449Gx1qQq6Rry3jizd936hRf/nm+sR8tXQIq8xsPPGNU4D
	 14Llic2T+xgkbFeqSlJ+dc+otgN1Zs7e/vQApgSCASWAByB1XXnsfP9ka+aynQqvRD
	 bRB9b/ID0NtEw==
From: Kalle Valo <kvalo@kernel.org>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] wifi: ath12k: add MU-MIMO and 160 MHz
 bandwidth support
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
Date: Thu, 25 Apr 2024 09:48:09 +0300
In-Reply-To: <20240424201959.935-1-quic_pradeepc@quicinc.com> (Pradeep Kumar
	Chitrapu's message of "Wed, 24 Apr 2024 13:19:49 -0700")
Message-ID: <87edaugcpi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> writes:

> Add support for
> 1. enabling MU-MIMO in HE and EHT modes from hardware
> 2. setting fixed HE rate/GI/LTF
> 3. 160 MHz bandwidth in HE mode
> 4. extended NSS bandwidth support
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> changes in v3:
>  - address review comments for fixing ath12k-check issues.
>
> changes in v2:
>  - Amend mac80211 patch description as the patch is not specific
>    to AP mode.
>  - Amend EHT MU-MIMO patch description to specify future support
>    for STA mode.
>
> Pradeep Kumar Chitrapu (10):
>   wifi: mac80211: Add EHT UL MU-MIMO flag in ieee80211_bss_conf
>   wifi: ath12k: push HE MU-MIMO params from hostapd to hardware
>   wifi: ath12k: push EHT MU-MIMO params from hostapd to hardware
>   wifi: ath12k: move HE MCS mapper to a separate function
>   wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
>   wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
>   wifi: ath12k: add support for setting fixed HE rate/GI/LTF
>   wifi: ath12k: clean up 80P80 support
>   wifi: ath12k: add support for 160 MHz bandwidth
>   wifi: ath12k: add extended NSS bandwidth support for 160 MHz
>
>  drivers/net/wireless/ath/ath12k/core.h |    2 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 1043 ++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/mac.h  |   17 +
>  drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
>  drivers/net/wireless/ath/ath12k/wmi.h  |   98 ++-
>  include/net/mac80211.h                 |    4 +
>  net/mac80211/cfg.c                     |    5 +
>  7 files changed, 986 insertions(+), 207 deletions(-)
>
>
> base-commit: 1a17b8f9196db4d5b9f81f69cac885ba8c832da7
> prerequisite-patch-id: 6cb82354d93f2d3d0e61dca59b7939e1bae2f263
> prerequisite-patch-id: b93a6cfb7a9caa843eb4a1df2d400b56b548188f
> prerequisite-patch-id: bbf8aa44334b11e860f4b68c22607110e81498a1
> prerequisite-patch-id: 70140f291ade3c2db0a0f36fe1c7c7d93eedfdeb
> prerequisite-patch-id: c52742e59bc5db2742ab66ec16175e983b88fb72
> prerequisite-patch-id: 8f9c43d387ec6bcf807f53dc17dcaaaa21c8a03f
> prerequisite-patch-id: a36bcb4e892019e5dcc39854088371e1c20e4ebf
> prerequisite-patch-id: 42864cd08f6d37e14f1794d29e13f8a094e489cc
> prerequisite-patch-id: 67eb3991126edab717635666297a6a910adbb8c1
> prerequisite-patch-id: be513e07c8fbbc556d3b61f2356d0a4391901ba5
> prerequisite-patch-id: 6dd663b6660f5f8d49fbd3e49023d0fd851100dc
> prerequisite-patch-id: 77ba10656791f90eeeb88ef749829b1474de4280
> prerequisite-patch-id: ec4c06aca44fecabfbdbf305581c60587cf23e63
> prerequisite-patch-id: f24c686941a9136ff7d800a726fad8c5d5d3b1b1
> prerequisite-patch-id: 14c827bfdc875273056194059bcd0cb042db123a
> prerequisite-patch-id: c1adce3c611529902e3a19a74f775cfffbba69b3
> prerequisite-patch-id: a4ff79eb14ba0e59508ce72e0d0eca56da2b6060
> prerequisite-patch-id: 66d93f366737e1a4b1e3c0a10747994b39bdd49a
> prerequisite-patch-id: 4890b86b151fad62b5a37688d813696f507cd9b1
> prerequisite-patch-id: 58918f67d676fafe5c527c83d1401da8cd30cb41
> prerequisite-patch-id: d6acc523424cd3049f471191406d456625a903ee
> prerequisite-patch-id: ce6f394abfaa9dbf2e818379850b911ea380e8ff
> prerequisite-patch-id: 92fc0dabdc596b6d1f4940a8be86f9558dabede9
> prerequisite-patch-id: 34f4bf81393b8f035604eca6fb13a964dc933fb0
> prerequisite-patch-id: d14a14bb3e1b22afdce181eab811e4151b837b7e
> prerequisite-patch-id: 275f221e85124f4cccac788a2d109dd71bb611f8
> prerequisite-patch-id: a68de371d003e45f93defbadaa164ce016f62b43
> prerequisite-patch-id: d156ad9d641c02cb2b00bb2a9bb3952f1ee1eda5
> prerequisite-patch-id: 022d675781d55b377befb1bfa73cdd13eb544919
> prerequisite-patch-id: cd0f4fc60b3e60fd5daed4c4aef5ff836a1d6afe
> prerequisite-patch-id: 2d8e31915fb462a006aa36a878afc722dae702f1
> prerequisite-patch-id: 6db9ebc02e7aff5b0dd6a791bcb56b174b8f5075
> prerequisite-patch-id: 8ab4b749c404278c6f3284e7626f7fc34f4c168c
> prerequisite-patch-id: 3132da2b7c8c7c62e27c995c81a2805898bbecf5
> prerequisite-patch-id: 47954405bc0dd7a3b89981a1f62b2942c6690321
> prerequisite-patch-id: 9394e4f195275a48ccc6feb79a69391bd5a081ac
> prerequisite-patch-id: 73a8dedb5b3270e36d08453ecde5a1eda1d488df
> prerequisite-patch-id: 0b51e47032752aff3d731c060f9ec63de49d6efa
> prerequisite-patch-id: de40f7811a733a0e14e2bb9e263e632a488c350a
> prerequisite-patch-id: 018f54a2e185dac93eb3ff126a3dcfe830797da7
> prerequisite-patch-id: 65c73a3902c82ed46fd45ba3e02477746b80f43f
> prerequisite-patch-id: 0a3e374a2927cc6b36aa886562ea74197f3e31e1
> prerequisite-patch-id: 197d9f2f52a4f397bcadfb097f66026aec7d8531
> prerequisite-patch-id: 0d2aedbe585ef88c171a8e6e07c88cdbc4269194
> prerequisite-patch-id: 445f5b16f72a183fcf92eadbd1329902267ecfc5
> prerequisite-patch-id: c753615aebcfe5d7419d00f11ef94c41618032d1
> prerequisite-patch-id: b15f736df11c88fb96a180e0d928a6e1cd0c0f34
> prerequisite-patch-id: 6eb961cc481ac73a4e17b2338814fb2f86b02b2a
> prerequisite-patch-id: fdddada4c012b7d7cc79d1e17caccac67ee63bef
> prerequisite-patch-id: ffd8fb7974d49d06574ab4b97b0ca74a3b2e5e21
> prerequisite-patch-id: d56eb0552657a692d6db25fb1badba1f06769c07
> prerequisite-patch-id: 468fad8de3fef4b8c470408fb1db12edd4a195c0
> prerequisite-patch-id: 9f816eb8e25fa683f06c2f5e5317ac7a51d57ab9
> prerequisite-patch-id: 734bba56b6da8d0ba773c335e1da4926fe8b8035
> prerequisite-patch-id: 8db71e2c9424eb2d1296c73100d34c8f9bcdde0b
> prerequisite-patch-id: bdadfa11d95682aeb60202635ce434c98e451c20
> prerequisite-patch-id: 3af02179828c0bb21ab1d4bd9ff61231ef091162
> prerequisite-patch-id: 861aa5786a781f71cf5adfabc531ca6b61ef1c72
> prerequisite-patch-id: b3df68b21838ded80f002482f69d7a458776cf99
> prerequisite-patch-id: 11d0c8923fe6f22cebf2afcd57e3bf7c8f36b4f9
> prerequisite-patch-id: 599e5c0a6a6c9e9a12ee422f4af9340c0b465f67
> prerequisite-patch-id: 13952e429c380cd716c6f449df3dcedaae109479
> prerequisite-patch-id: 07c9ff6fcaf4ba464be993caa19eb49113eedbdf

Whoa, what's this huge prerequisite-patch-id list? There's no mention of
dependencies in the cover letter.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

