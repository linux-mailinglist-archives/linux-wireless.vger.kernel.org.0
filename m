Return-Path: <linux-wireless+bounces-15959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0951D9E6831
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 08:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B412A1885AB0
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 07:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A9A1D63C4;
	Fri,  6 Dec 2024 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmyxtJ05"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474813DDDF
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471260; cv=none; b=OAs63mEjwOPb6Yov8NKxygypVlCYHV44AZl0ixNOnVfi9MoKwiR45mrKATl9LlpWiyjLUpZZdVdYksF65BoE0YK8RohvBilR+O7YHY1IctBfk8phn252/jLph4OG1euUAkp9ECsIsPR8ybrPoVm6sI6XUmQLoT7S0jrl44LpcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471260; c=relaxed/simple;
	bh=wfGCMWZ6xexpjcMNpgFhCbMlBLvMZEm37v71W1xQsQs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DuQK4vjHuoF2/Es2obCQjgWIIjMFdO3M+zO2drtv84yAC3x+P5WjIK7SFJGuNUM5MuajMY+4bZvhCgLwOZ0kY7sR/5nusLFeAA16tLe186uRMu/T5SoqS7BUpXNuniae056o3CC6w4et/DfCqpCvgsb51Fh66g5eiLEFWGGB4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmyxtJ05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770F7C4CEDD;
	Fri,  6 Dec 2024 07:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733471260;
	bh=wfGCMWZ6xexpjcMNpgFhCbMlBLvMZEm37v71W1xQsQs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PmyxtJ05QgQtBVF38iApkrYqWtNl1OoPlixogjNxOFhYHlPwInftDxzIL7CUbpOAK
	 62CBRhuxexSDcFlBXTruH1HQKDp6XNcfq99tNlzdUUGa5BWFlDoPqPw5gEgRvw6IBw
	 Mr5UIkh7zH85aBkJ/R10FvZubNj5g6xd1GIy3vcT0UZ9Z34UITslHUReyCwtgKIZku
	 N1OXz5pb1gg7uHeYvpyI52E4DgFvMDkAInvZ8Sr4MtVYbBmD1oMWwOfH3m01xtlWV3
	 V22fYkGvojSuoxXmc7gX46iUfqrpT9Heml6FviVUG463ZTCzSg3akX5wKTNGSuaSxe
	 2M26iyrAhT/Dw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/7] wifi: ath12k: rename mlo_capable_flags to
 single_chip_mlo_supp
References: <20241204163216.433795-1-kvalo@kernel.org>
	<20241204163216.433795-3-kvalo@kernel.org>
	<88e0116c-778f-4861-8751-b30a09d3d2b4@oss.qualcomm.com>
Date: Fri, 06 Dec 2024 09:47:37 +0200
In-Reply-To: <88e0116c-778f-4861-8751-b30a09d3d2b4@oss.qualcomm.com> (Jeff
	Johnson's message of "Thu, 5 Dec 2024 14:32:38 -0800")
Message-ID: <87zfl9jlra.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff Johnson <jeff.johnson@oss.qualcomm.com> writes:

> On 12/4/2024 8:32 AM, Kalle Valo wrote:
>
>> From: Aditya Kumar Singh <quic_adisi@quicinc.com>
>>=20
>> At present, the mlo_capable_flags in ath12k_base is used to indicate whe=
ther
>> the chip supports inter (QCN9274) or intra (WCN7850) chip MLO. However, =
it=E2=80=99s
>> possible that the chip supports neither, especially with older firmware
>> versions. Additionally, if intra chip MLO is not supported, inter chip M=
LO will
>> also be non-functional. Therefore, having two separate flags for this is
>> unnecessary.
>>=20
>> Therefore, rename this flag to single_chip_mlo_supp. At the same time co=
nvert
>> it into a bool data type. Also, get rid of the enums defined earlier.
>>=20
>> For the QCN9274 family of chipsets, this will be set only when firmware
>> advertises the support during the QMI exchange.
>>=20
>> For the WCN7850 family of chipsets, since the event is not supported,
>> assumption is made that single chip MLO is supported.
>>=20
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_=
SILICONZ-3
>>=20
>> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
>
> Kalle, this patch is missing your SOB.
> Please reply with the tag and I'll fix in 'pending'

Oh darn, sorry about that. Here it is:

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

