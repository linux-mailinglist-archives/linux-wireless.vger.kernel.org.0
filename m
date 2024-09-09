Return-Path: <linux-wireless+bounces-12658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A31E79716B1
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 13:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAA81C2304F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F001B4C4B;
	Mon,  9 Sep 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="c+7K95Wn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070F38DD4;
	Mon,  9 Sep 2024 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880990; cv=none; b=Kv0Lss2OSXQxCaTEJvUIe16CSlqtgnzA+1X0L0JSsqG5Pn74MnIqVnaerI/TJ2Lg/WmTA4okGgNgDN+DsXCFc7PibmCSmNEk73atdfNs4Gp2ljNdry5MllZ+YyiqzxGvgeJGPu9Dydyx6TB1t0nJXKoM3S+Z5hKNqdPh0WtsbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880990; c=relaxed/simple;
	bh=7McYHbJ1rujuzLwEwekgMXJStMtqlaSw8UOc0xF6C4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MdpD9xA+hYg/AAnCKT59fAOLGZiUYG62r8B+PR/8ygGBvbBXG/MmQEaFqjgXtGqnECngg+zHbaooNI1AtYoF3MQiyqmICaavR+1hEAgafQjB81ijeKBX8coXATZOdSB3iaZQWnwXkMKzWpIGODMuUOEBoSrQZP5l4OEsLtZM+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=c+7K95Wn; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1725880985; bh=7McYHbJ1rujuzLwEwekgMXJStMtqlaSw8UOc0xF6C4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c+7K95WniHvTgDa4mqOmd1ouRCuwKYsziVzgWeqcKRDH89wt2MA0GfWMzESFRjcD1
	 U9oXuO4rvxNHtosHQU95S4K+tuMKLacOUEspi4hkLixKcROqxSfcvgqptSVQaL8HRI
	 3Uu6hHbZZJGrJH8N0AIRPe4jpTwK0HLJLIbDXDIXh1XYpMzU2UNeaE/OSivamIV4Tn
	 2zKJ4LHhvwd5bhOScB4bdr4iA3JOWXH9sN7PsuLpm+WWFcEHZ08YHBB6/ikfIDu+/D
	 b1NRc/mZLEPL9h47tMGPoEAGg/GXwKU+7+h/tsEKXONJL7GKZStoTxaXhc3pJi6NqT
	 vtBJ+IJBzuDKw==
To: Jeongjun Park <aha310510@gmail.com>, kvalo@kernel.org
Cc: Sujith.Manoharan@atheros.com, senthilkumar@atheros.com,
 vasanth@atheros.com, linville@tuxdriver.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Jeongjun
 Park <aha310510@gmail.com>
Subject: Re: [PATCH v2] wifi: ath9k: add range check for conn_rsp_epid in
 htc_connect_service()
In-Reply-To: <20240909103855.68006-1-aha310510@gmail.com>
References: <20240909103855.68006-1-aha310510@gmail.com>
Date: Mon, 09 Sep 2024 13:23:04 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87v7z5oyuf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeongjun Park <aha310510@gmail.com> writes:

> I found the following bug in my fuzzer:
>
>   UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_=
hst.c:26:51
>   index 255 is out of range for type 'htc_endpoint [22]'
>   CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.11.0-rc6-dirty #14
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
>   Workqueue: events request_firmware_work_func
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x180/0x1b0
>    __ubsan_handle_out_of_bounds+0xd4/0x130
>    htc_issue_send.constprop.0+0x20c/0x230
>    ? _raw_spin_unlock_irqrestore+0x3c/0x70
>    ath9k_wmi_cmd+0x41d/0x610
>    ? mark_held_locks+0x9f/0xe0
>    ...
>
> Since this bug has been confirmed to be caused by insufficient verificati=
on=20
> of conn_rsp_epid, I think it would be appropriate to add a range check fo=
r=20
> conn_rsp_epid to htc_connect_service() to prevent the bug from occurring.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

