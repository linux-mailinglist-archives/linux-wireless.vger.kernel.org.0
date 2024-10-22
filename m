Return-Path: <linux-wireless+bounces-14290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 858229A9A64
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 09:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28EA2B21654
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 07:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9197450EE;
	Tue, 22 Oct 2024 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UujTTw5L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4007ECF;
	Tue, 22 Oct 2024 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580533; cv=none; b=pD7fRMk5iA27hTmnCLk9m9/fMzAnmp0y043NDkHTp1+jpHipZXn7X/qsZjtSWmhgC5/7lQqalgIwnNrxjRr5oq9LXzx+cWjzf9fwH/cnSpguCt8pXiwfaHwF5UiAQBJ4sHnW8lnPu50uv6V2Z5I49QEVjoheIG0DxmtvFWzzSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580533; c=relaxed/simple;
	bh=dyrGwMan4H/kztgk0P8s+ilEAdT66GF/kqBU40DpcJI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mz3wn8vwCa9qlPZCxYHO7BI0MvHWkzsfsKg/bILIKHGZeHs8IeKqsXsqU0BvC3ESb/jH1JR4JgnYVk6jTRZveoGllwVpnKskl7jGUC8zAkc18d7B6nSDFe5fFVZiTQUdWwG+QlryIZNExeqaNAbU3GhTOuCRe5fSjRsdV7BekfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UujTTw5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482B6C4CEC3;
	Tue, 22 Oct 2024 07:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729580533;
	bh=dyrGwMan4H/kztgk0P8s+ilEAdT66GF/kqBU40DpcJI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=UujTTw5LSiPlS/rShRmXW+Culj8ON2Qp6aYd9EYFg6BnWBcoIkIWCUmiXCc9DKKCL
	 UQjLbl1IiYxdUp3737WKxiaTngxtKH1jpWPDf4zgF7ab/6WVzCKNsvOMuxc3nKJdgZ
	 RKnOTasj6YaL28VteJguD5BrrpVtQ1AntHCcKplJ6XsB8J+3nPEQKTnC+B1u2bxwaG
	 xtdYdJAXg2bkR1XbhjvOfyQtHugr6uQD2uvpcGWb11Y1mme9bZsKV5gbyxDxZdqapC
	 thdDo9hmF2Ody5nMJ2oFsa3NtCIjVfr/QkLASaSE95ux8SyMfpBd/ePapAsoyNi9w/
	 7lybAlwK2F9jA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: toke@toke.dk,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath9k: add range check for conn_rsp_epid in
 htc_connect_service()
References: <172631439319.3042536.1475962432679276880.kvalo@kernel.org>
	<1D787F7E-08E2-4F21-B7D3-68A9F345E79E@gmail.com>
Date: Tue, 22 Oct 2024 10:02:10 +0300
In-Reply-To: <1D787F7E-08E2-4F21-B7D3-68A9F345E79E@gmail.com> (Jeongjun Park's
	message of "Tue, 22 Oct 2024 09:36:37 +0900")
Message-ID: <87ldygoc25.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeongjun Park <aha310510@gmail.com> writes:

>> Kalle Valo <kvalo@kernel.org> wrote:
>>=20
>> =EF=BB=BFJeongjun Park <aha310510@gmail.com> wrote:
>>=20
>>> I found the following bug in my fuzzer:
>>>=20
>>>  UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc=
_hst.c:26:51
>>>  index 255 is out of range for type 'htc_endpoint [22]'
>>>  CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.11.0-rc6-dirty #14
>>>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 0=
4/01/2014
>>>  Workqueue: events request_firmware_work_func
>>>  Call Trace:
>>>   <TASK>
>>>   dump_stack_lvl+0x180/0x1b0
>>>   __ubsan_handle_out_of_bounds+0xd4/0x130
>>>   htc_issue_send.constprop.0+0x20c/0x230
>>>   ? _raw_spin_unlock_irqrestore+0x3c/0x70
>>>   ath9k_wmi_cmd+0x41d/0x610
>>>   ? mark_held_locks+0x9f/0xe0
>>>   ...
>>>=20
>>> Since this bug has been confirmed to be caused by insufficient verifica=
tion
>>> of conn_rsp_epid, I think it would be appropriate to add a range check =
for
>>> conn_rsp_epid to htc_connect_service() to prevent the bug from occurrin=
g.
>>>=20
>>> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
>>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>>> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>=20
>> Patch applied to ath-next branch of ath.git, thanks.
>>=20
>
> I think this patch should be applied to the next rc version immediately
> to fix the oob vulnerability as soon as possible, and also to the=20
> stable version.

ath-next is fine, the issue has been in ath9k forever so waiting four
weeks or so to get to Linus' tree is not making any difference.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

