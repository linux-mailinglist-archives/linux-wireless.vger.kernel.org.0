Return-Path: <linux-wireless+bounces-10388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D44B93771E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 13:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E98D1C20CA0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 11:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40FB824A0;
	Fri, 19 Jul 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="bAH24AYz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81011E502
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388426; cv=none; b=pWSHRiFdoGlZUHaCW/WTTJI1N6zCpyJC95eIXtA5tXYBwpcDooF8GvQ3ijJcG4JEBQoJQnthbx0baO9Nbujbmoa6Xmra9wKEI+b6Ept6hrR4UaALD2+1RHTuWQqq+k1aP4YFlSwNu+jvV7YszWZ/wewGsk2T3aeJDNKHOaT9p1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388426; c=relaxed/simple;
	bh=NAHuGRol/HPY39JMl6yxX8+3Hrt0DX7GgLBbkuqi//s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CpgfvDRRO7N4SCWoIA1w0o48U+x6j089Ekp1Qg6u87UwX9RtQJnIRIajI7+y4Q5OEFTzG6vlBVQQP+oVgAXikSj+ObNhya3CJ2RKYrbYLzgGt2hOy9AF2XNENHobEQnM+MvxTaNBOOm5BFEWdrPGOqjieeJYBUFyZ+fR2x57dWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=bAH24AYz; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721388392; x=1721993192; i=spasswolf@web.de;
	bh=9FDPWtZa5BiBTQ3GHY8kUVw1DOEUjjH3tOcbPfWdgNw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bAH24AYzAcxd+AwDKTLwlHBcSse5HmcY/uZFgMzaGN/zvNYKZtqi4oqFoeUEm2X/
	 PgdSCwjAQuEKdo+PnDKyvslDFxwo5cr6n8xVGcnlaz3Fj3gkXyUdn0/ulQs3y/3Mk
	 H+PyAj+XaVBpAN84RQyrRyw77mdUxumpBitRHf0lKe6LHzt0uIsQNw9V4J7bgVLmh
	 1hOAd4P2yX11gvHaXIAbg759RSk/ScJv8sQa3zlsrAopFZuTzCLcfP4MA+r9Ees65
	 nK0TuifYFDm40v7mq/jefTknb4tYJISyO9srMXOB2k1r/LGMO1nTBAc6AAZXGOUnO
	 xuXb9AuNKmdospTDKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjIG-1scURo05fg-0070pW; Fri, 19
 Jul 2024 13:26:32 +0200
Message-ID: <7a4db04f7088a9d818037321412f7ac968d965cd.camel@web.de>
Subject: Re: [PATCH] wifi: mt76: mt7921: fix null pointer access in
 mt792x_mac_link_bss_remove
From: Bert Karwatzki <spasswolf@web.de>
To: sean.wang@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com, deren.wu@mediatek.com,
 mingyen.hsieh@mediatek.com,  linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org,  spasswolf@web.de
Date: Fri, 19 Jul 2024 13:26:30 +0200
In-Reply-To: <20240718234633.12737-1-sean.wang@kernel.org>
References: <20240718234633.12737-1-sean.wang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ALX7alao3XcqIRK5g3lr4ihIgNWuUOosbfoXbMSwe9tamIny5My
 NrgORDm1xdVmF+4uUXA9N2OjXCqTM0NaHwtpomJTAKZAk09490KkyyRX6aSOEaTxRpxpspU
 whqQR4JKT401bVfhW0/VKYzFGwT1vV+6SjxVqK5MIEzRxjyH6A/zU90hoktJTMXXj2of0ZX
 sdaD2lZ/fJOksr6h41b+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HkluRDPJt8U=;xx4jJ3QJkve//VYTaJa1uiL5lo2
 C1U6hcpR4aEQ/pJnbh9hYdFWgKIMJ5JpIibdTLPY4e/l226zfzRifzKidsH0IxsHpzM6Gg6LK
 DG4T7V8HoghaYWk3Pf3FBs/dRxk8he5iwIQ9mLOawbwm9uOaYIbWnNP6sHJT65MhrSwY7SkWe
 HneRfglHpRZ/FvIqWzlfaVYjA5fl8M4VqzJfoOdGVJ7KudzwTQv/hf4+Ht4mpTjeMmPt0msos
 VsuAG7S8PXJnNNbnQwWlnZMq+cN8P2LHGKOwotUibBJoyUfnmvOjOulOF+DrrlW4FGwg4U7/g
 DIt0JHAoaogLah9YHlI9KaosYqgF8h+FFYGxbQ5GtoEjeVFlEoAQDi2uJYYmj9ff3q2zBHgnn
 yBl/zPxzMfuFxDBIueOwfguL37o6ss+KvL00dqhmMORuykoTLDc1WBRfYPhu7F5Lao1LSmZGV
 VLKTzhU6QL4eesVhtKQogAA3krdE/dTlptvyamMCwLuBOBeRaFESSTdkCamyqligvAm++HzF3
 kgSC52fPJ8Qfe9vQR/eTXP95Fp7N86d7RNtwW5TLGIei7Q5IsOdpVEE25OyyxvdKvz1Irh/ue
 mzw0jpQenY0/Jh5F/SGZJGl0fYAzjNHbQmjZ+KRgfM/TSKgBnGUc2OvopZXHKKcPFemEol/x2
 +dbkVEeIZwShtjEejfEGLaJl1kLMk5dNW/u6tq1ppy4MJvw7Ci7O8RlAC9dYr4ui/OqaQs8hy
 3yC0PRlEcdcWuF3V+SiFGkb3jbz7LLIq3jkcK6hfBDsoD9HlxIEdZz1Esy1J6IXZltRZznU2r
 uvM3sz+wfg5028JGbSI3zryw==

Am Donnerstag, dem 18.07.2024 um 16:46 -0700 schrieb sean.wang@kernel.org:
> From: Sean Wang <sean.wang@mediatek.com>
>
> Fix null pointer access in mt792x_mac_link_bss_remove.
>
> To prevent null pointer access, we should assign the vif to bss_conf in
> mt7921_add_interface. This ensures that subsequent operations on the BSS
> can properly reference the correct vif.
>
> [  T843] Call Trace:
> [  T843]  <TASK>
> [  T843]  ? __die+0x1e/0x60
> [  T843]  ? page_fault_oops+0x157/0x450
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? search_bpf_extables+0x5a/0x80
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? exc_page_fault+0x2bb/0x670
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? lock_timer_base+0x71/0x90
> [  T843]  ? asm_exc_page_fault+0x26/0x30
> [  T843]  ? mt792x_mac_link_bss_remove+0x24/0x110 [mt792x_lib]
> [  T843]  ? mt792x_remove_interface+0x6e/0x90 [mt792x_lib]
> [  T843]  ? ieee80211_do_stop+0x507/0x7e0 [mac80211]
> [  T843]  ? ieee80211_stop+0x53/0x190 [mac80211]
> [  T843]  ? __dev_close_many+0xa5/0x120
> [  T843]  ? __dev_change_flags+0x18c/0x220
> [  T843]  ? dev_change_flags+0x21/0x60
> [  T843]  ? do_setlink+0xdf9/0x11d0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? security_sock_rcv_skb+0x33/0x50
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? __nla_validate_parse+0x61/0xd10
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? genl_done+0x53/0x80
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? netlink_dump+0x357/0x410
> [  T843]  ? __rtnl_newlink+0x5d6/0x980
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? genl_family_rcv_msg_dumpit+0xdf/0xf0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? __kmalloc_cache_noprof+0x44/0x210
> [  T843]  ? rtnl_newlink+0x42/0x60
> [  T843]  ? rtnetlink_rcv_msg+0x152/0x3f0
> [  T843]  ? mptcp_pm_nl_dump_addr+0x180/0x180
> [  T843]  ? rtnl_calcit.isra.0+0x130/0x130
> [  T843]  ? netlink_rcv_skb+0x56/0x100
> [  T843]  ? netlink_unicast+0x199/0x290
> [  T843]  ? netlink_sendmsg+0x21d/0x490
> [  T843]  ? __sock_sendmsg+0x78/0x80
> [  T843]  ? ____sys_sendmsg+0x23f/0x2e0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? copy_msghdr_from_user+0x68/0xa0
> [  T843]  ? ___sys_sendmsg+0x81/0xd0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? crng_fast_key_erasure+0xbc/0xf0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? get_random_bytes_user+0x126/0x140
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? __fdget+0xb1/0xe0
> [  T843]  ? __sys_sendmsg+0x56/0xa0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? do_syscall_64+0x5f/0x170
> [  T843]  ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
> [  T843]  </TASK>
>
> Fixes: 1541d63c5fe2 ("wifi: mt76: mt7925: add mt7925_mac_link_bss_remove=
 to remove per-link BSS")
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes: https://lore.kernel.org/linux-wireless/2fee61f8c903d02a900ca3188=
c3742c7effd102e.camel@web.de/#b
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/=
net/wireless/mediatek/mt76/mt7921/main.c
> index 2e6268cb06c0..1bab93d049df 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -303,6 +303,7 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct=
 ieee80211_vif *vif)
>
>  	mvif->bss_conf.mt76.omac_idx =3D mvif->bss_conf.mt76.idx;
>  	mvif->phy =3D phy;
> +	mvif->bss_conf.vif =3D mvif;
>  	mvif->bss_conf.mt76.band_idx =3D 0;
>  	mvif->bss_conf.mt76.wmm_idx =3D mvif->bss_conf.mt76.idx % MT76_CONNAC_=
MAX_WMM_SETS;
>
I've been testing this since you suggested it on 11.7.2024 and it works fi=
ne.

Tested-by: Bert Karwatzki <spasswolf@web.de>

Bert Karwatzki

