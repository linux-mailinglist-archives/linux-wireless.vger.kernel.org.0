Return-Path: <linux-wireless+bounces-9675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E077191B120
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 23:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137781C209B1
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069AF249F9;
	Thu, 27 Jun 2024 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7F3EzDw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D680A13FF9
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522078; cv=none; b=pw+cVjnclxMxviyxy72WMVaLbrDnDkQZy5KwNPDJpJEKB7gaXJtD3efQr64th2/ttYLtqX5OqFm1fSWQ/gghO5Q8Z0ZnEd4KADUgnetg3chVyZdRLD/oRL9Pxh5RriD91CUZ5c7edZLCFGESirUFdBbawiP7Eta0tRlKmJv591c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522078; c=relaxed/simple;
	bh=D18wy75oZodZsi/i1RVrFgy1DPcVSoFWVimvYoS99MM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eHiasUVPhMv1uSqqBJgQfhFOx3FmQbbcRJ8wdLQdp6utKnwenqJOpmbIjI8ZFgfXK0YlU3Tg6R9PACe7MH4U3c2rMrhDbeAf0tFyh4cHrorXEUJH/ngY7OTGCLjvi7F5oeuFhn9QgUWDds1SQSoPyYHRCA9UToTWRotyjhVCZhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7F3EzDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C988C2BBFC;
	Thu, 27 Jun 2024 21:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719522078;
	bh=D18wy75oZodZsi/i1RVrFgy1DPcVSoFWVimvYoS99MM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=e7F3EzDw0MoMeL0hQHtkv+y6g6Pqxw9xhU15OYeOVXlpb1cGgNmfeBeLGdeVTB1SL
	 XG6oXy6abKIyPU2wdzS/Kyn2wKfj3xmZAUkQ2m8akGaYvfXYzrBloZ9+bPDPIPZecP
	 EimZ2ktYVBMNI0VVqg3jkVWCITcZXPK25ZwDOg9KHE+ZTATdZjGdHV0a7Sf22FdC73
	 FN0qvoLl6TogsNVsV0zRekAzakp7iagw3fgU7zTH6evVXYnPOdNcSU8cQCcDnWTRhH
	 HGa4qb/TSEK9ezSuJfzLf46Omk3z9JCN7vXyOkKFlHH5G3SO9jWioenB4Jpz/zmiXi
	 WmZRvLivRVNug==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kang Yang <quic_kangyang@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: use work queue to process beacon tx event
References: <20240626053543.1946-1-quic_kangyang@quicinc.com>
	<1e69ca99-fb08-4c44-93d8-33689ff62aca@quicinc.com>
Date: Fri, 28 Jun 2024 00:01:15 +0300
In-Reply-To: <1e69ca99-fb08-4c44-93d8-33689ff62aca@quicinc.com> (Jeff
	Johnson's message of "Thu, 27 Jun 2024 12:24:24 -0700")
Message-ID: <875xtugkx0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 6/25/2024 10:35 PM, Kang Yang wrote:
>
>> Commit 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
>> from Feb 28, 2024 (linux-next), leads to the following Smatch static
>> checker warning:
>>=20
>> drivers/net/wireless/ath/ath11k/wmi.c:1742 ath11k_wmi_p2p_go_bcn_ie()
>> warn: sleeping in atomic context
>>=20
>> The reason is that ath11k_bcn_tx_status_event() will directly call might
>> sleep function ath11k_wmi_cmd_send() during RCU read-side critical
>> sections. The call trace is like:
>>=20
>> ath11k_bcn_tx_status_event()
>> -> rcu_read_lock()
>> -> ath11k_mac_bcn_tx_event()
>> 	-> ath11k_mac_setup_bcn_tmpl()
>> 	=E2=80=A6=E2=80=A6
>> 		-> ath11k_wmi_bcn_tmpl()
>> 			-> ath11k_wmi_cmd_send()
>> -> rcu_read_unlock()
>>=20
>> Commit 886433a98425 ("ath11k: add support for BSS color change") added t=
he
>> ath11k_mac_bcn_tx_event(), commit 01e782c89108 ("ath11k: fix warning
>> of RCU usage for ath11k_mac_get_arvif_by_vdev_id()") added the RCU lock
>> to avoid warning but also introduced this BUG.
>>=20
>> Use work queue to avoid directly calling ath11k_mac_bcn_tx_event()
>> during RCU critical sections. No need to worry the deletion of vif.
>
> comment nit:
> s/worry the deletion of vif. Because/worry about the deletion of vif beca=
use/
>
> Kalle can apply this to pending

Yup, fixed.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

