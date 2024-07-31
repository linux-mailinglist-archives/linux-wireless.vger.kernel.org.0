Return-Path: <linux-wireless+bounces-10726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A9D942A70
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96681B2198A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308CB1AAE0F;
	Wed, 31 Jul 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4onOUni"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09C1A8C06
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418078; cv=none; b=sLEAekUwpnccX+XL3fYSUHXLJ3L8HPxKuys9jVgissXdzKpYD+gAZsbTtKKb/eDa68+Xhqpn7GXmWhCDseiH0rCxHhabOY1QzRRjs2O/R5378yXdozNSVymSesSdRUsnMJLvH1sTPkSY5ewfgzeyaJmwFeXS/bOHQb5EdKfY7R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418078; c=relaxed/simple;
	bh=Rn6na6PNCFTWkJ1lJK9Ax3UMrRw5R8x+o7r/bX2fhTU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BxQ9JNT49LTb5XO4K1ylQxQxzuu1upo6KFzxHqVeSMn1MLAC+5895znLSNZPBkSiLnHQGOA8hSLAUj9baPYiNtWZoqVPAlFSdBssSr2+TDC3WZ6AGXQ7IMXz4GB7A0LBVYDc6DWMKx8f2FO3AvFf9A/4O11pQTUnARkHY/QU51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4onOUni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5396C116B1;
	Wed, 31 Jul 2024 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722418077;
	bh=Rn6na6PNCFTWkJ1lJK9Ax3UMrRw5R8x+o7r/bX2fhTU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=V4onOUniYD3dw6fMeiEEAumaQePjQ9qOkgVALtEprEYpOzPLP7Ed7n9vE4H2f6kHa
	 z1S5FFXn7qiDUPKbIElvVvWvcOE0/d5gv2ROZShOUrTccAqxCXWiLNGbug2SHSnI6g
	 Fcf0Bm/xKT94yyKGb4U9t1gBdYndUmFHSII4MccK3g0ZEMtYPZp3MFYjATaQQx5P/P
	 CDGq9XcngiIzCOLpLbXaflULOaaJljRdQE69yFnNcsQUrS6jtDh9I/PoOdAJtJvpv5
	 gxtEShSWQ4G+yS97F7pK0Zyl8btc2YZX+g4WIxcP0zJGqR+jR9ajtZPaX27n6Dj3pZ
	 euhA7QKALFPrQ==
From: Kalle Valo <kvalo@kernel.org>
To: =?utf-8?Q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Cc: linux-wireless@vger.kernel.org,  linux-mediatek@lists.infradead.org,
  Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] wifi: mt76: fix oops on non-dbdc mt7986
References: <20240713130010.516037-1-bjorn@mork.no>
Date: Wed, 31 Jul 2024 12:27:54 +0300
In-Reply-To: <20240713130010.516037-1-bjorn@mork.no> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B8rn?= Mork"'s message
	of "Sat, 13 Jul 2024 15:00:10 +0200")
Message-ID: <877cd1lxlx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B8rn Mork <bjorn@mork.no> writes:

> mt7915_band_config() sets band_idx =3D 1 on the main phy for mt7986
> with MT7975_ONE_ADIE or MT7976_ONE_ADIE.
>
> Commit 0335c034e726 ("wifi: mt76: fix race condition related to
> checking tx queue fill status") introduced a dereference of the
> phys array indirectly indexed by band_idx via wcid->phy_idx in
> mt76_wcid_cleanup(). This caused the following Oops on affected
> mt7986 devices:
>
>  Unable to handle kernel read from unreadable memory at virtual address 0=
000000000000024
>  Mem abort info:
>    ESR =3D 0x0000000096000005
>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>    SET =3D 0, FnV =3D 0
>    EA =3D 0, S1PTW =3D 0
>    FSC =3D 0x05: level 1 translation fault
>  Data abort info:
>    ISV =3D 0, ISS =3D 0x00000005
>    CM =3D 0, WnR =3D 0
>  user pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000042545000
>  [0000000000000024] pgd=3D0000000000000000, p4d=3D0000000000000000, pud=
=3D0000000000000000
>  Internal error: Oops: 0000000096000005 [#1] SMP
>  Modules linked in: ... mt7915e mt76_connac_lib mt76 mac80211 cfg80211 ...
>  CPU: 2 PID: 1631 Comm: hostapd Not tainted 5.15.150 #0
>  Hardware name: ZyXEL EX5700 (Telenor) (DT)
>  pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : mt76_wcid_cleanup+0x84/0x22c [mt76]
>  lr : mt76_wcid_cleanup+0x64/0x22c [mt76]
>  sp : ffffffc00a803700
>  x29: ffffffc00a803700 x28: ffffff80008f7300 x27: ffffff80003f3c00
>  x26: ffffff80000a7880 x25: ffffffc008c26e00 x24: 0000000000000001
>  x23: ffffffc000a68114 x22: 0000000000000000 x21: ffffff8004172cc8
>  x20: ffffffc00a803748 x19: ffffff8004152020 x18: 0000000000000000
>  x17: 00000000000017c0 x16: ffffffc008ef5000 x15: 0000000000000be0
>  x14: ffffff8004172e28 x13: ffffff8004172e28 x12: 0000000000000000
>  x11: 0000000000000000 x10: ffffff8004172e30 x9 : ffffff8004172e28
>  x8 : 0000000000000000 x7 : ffffff8004156020 x6 : 0000000000000000
>  x5 : 0000000000000031 x4 : 0000000000000000 x3 : 0000000000000001
>  x2 : 0000000000000000 x1 : ffffff80008f7300 x0 : 0000000000000024
>  Call trace:
>   mt76_wcid_cleanup+0x84/0x22c [mt76]
>   __mt76_sta_remove+0x70/0xbc [mt76]
>   mt76_sta_state+0x8c/0x1a4 [mt76]
>   mt7915_eeprom_get_power_delta+0x11e4/0x23a0 [mt7915e]
>   drv_sta_state+0x144/0x274 [mac80211]
>   sta_info_move_state+0x1cc/0x2a4 [mac80211]
>   sta_set_sinfo+0xaf8/0xc24 [mac80211]
>   sta_info_destroy_addr_bss+0x4c/0x6c [mac80211]
>
>   ieee80211_color_change_finish+0x1c08/0x1e70 [mac80211]
>   cfg80211_check_station_change+0x1360/0x4710 [cfg80211]
>   genl_family_rcv_msg_doit+0xb4/0x110
>   genl_rcv_msg+0xd0/0x1bc
>   netlink_rcv_skb+0x58/0x120
>   genl_rcv+0x34/0x50
>   netlink_unicast+0x1f0/0x2ec
>   netlink_sendmsg+0x198/0x3d0
>   ____sys_sendmsg+0x1b0/0x210
>   ___sys_sendmsg+0x80/0xf0
>   __sys_sendmsg+0x44/0xa0
>   __arm64_sys_sendmsg+0x20/0x30
>   invoke_syscall.constprop.0+0x4c/0xe0
>   do_el0_svc+0x40/0xd0
>   el0_svc+0x14/0x4c
>   el0t_64_sync_handler+0x100/0x110
>   el0t_64_sync+0x15c/0x160
>  Code: d2800002 910092c0 52800023 f9800011 (885f7c01)
>  ---[ end trace 7e42dd9a39ed2281 ]---
>
> Fix by using mt76_dev_phy() which will map band_idx to the correct phy
> for all hardware combinations.
>
> Fixes: 0335c034e726 ("wifi: mt76: fix race condition related to checking =
tx queue fill status")
> Link: https://github.com/openwrt/openwrt/issues/14548
> Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>

Should this go to wireless tree?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

