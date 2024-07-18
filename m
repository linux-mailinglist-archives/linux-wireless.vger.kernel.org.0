Return-Path: <linux-wireless+bounces-10347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB46934BCF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 12:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2410E2846A3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD2E12C470;
	Thu, 18 Jul 2024 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="hFpl5k1q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C646F303
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299375; cv=none; b=cZPErUwjBfF6mV61OINmHOycktqPBNrQQNZo8x3jH4/PAgUeapzCiD5H0HhBgzukwtaG9xlQhKQXuIc5UkAUuRCg8FJe9IhUhI4yg+3xYprIB4DUPzVyz9iUomu3J1VNjvfkEC0g0ycqjPA+/Nf/+fMzjwHZu24EIVDvNAL4WX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299375; c=relaxed/simple;
	bh=rb5odAhb8crjoc27dQUCypotYpXxS8ZbbiWkpCniVHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BIMjTbomFoHYy2Z1gni/5nQwYSazrBZbaBOY62vZoUTmohicN6ORytySz1btjY4FRuwc2La3UKNwmSllI3dshbkIiYcJkpM2XxhAjo3aAwUOoQUel0EuF5oXPZ8izuZOvxSWNt+Av6GQW9C62pJWGEO0CPNrFlSLbozERkQgdVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=hFpl5k1q; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721299343; x=1721904143; i=spasswolf@web.de;
	bh=CvWyHxZ99IvPwim7yGGnEO3wJiVr3+x4a+CYEj2uDtI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hFpl5k1qKfIX/68XJJkBtdCFXX7tsWgZUdSafQE/k/yDQcz6KL6ABic0XU+krB9W
	 28v60kw9+bwkSkP+XwXo1pEkhKnJg2kGBakfE/HgNdVJFiAxn+m6vyaHKojt0nUZa
	 WpzNba+i6n8jLiah5+8IjXu+bNhRPewYvmNWqTKuWhlC/fcc43zYZaekZ32su73TL
	 AWovSfoqQlFJgq8ilowmpfc14NnOeIQf61W2iNtAdHcB1HqH9nM1Xl7a/SBaYkKY1
	 XTYOsvMp7d2LltzXKhO6EtZgjxJtbEcZjVpwN61P7DiCw/TTCxAoIKrubhWmVx8dI
	 H3MiOkp4rBjLpDgjdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMp8Y-1sn1w30MrM-00J4CV; Thu, 18
 Jul 2024 12:42:23 +0200
Message-ID: <e2e95f9e69c9cd30af267bc980026e6194742464.camel@web.de>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
From: Bert Karwatzki <spasswolf@web.de>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	mingyen.hsieh@mediatek.com, sean.wang@mediatek.com, spasswolf@web.de
Date: Thu, 18 Jul 2024 12:42:20 +0200
In-Reply-To: <308958f4c5689fd920c3915f4878850a09310b18.camel@web.de>
References: <20240711175156.4465-1-spasswolf@web.de>
	 <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
	 <adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
	 <4e943a62736f955af5d9cd1aff7e2b9c084c8885.camel@web.de>
	 <2599b886-9c63-4989-a08a-7feab28f7c49@nbd.name>
	 <9fb7ac97d2ca472db469aefefbfeb94e0f886508.camel@web.de>
	 <308958f4c5689fd920c3915f4878850a09310b18.camel@web.de>
Content-Type: text/markdown; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J25o4Q0oMig9NQWETK90TuC4zCnVcNsPH74hXDl6SroiuiOSpxS
 6pA6eZrTbdrIx+MfEFQfFbPTxlQj5KP2gHn9lHfxgoUQcZ+8um/RF+2XNs8cYRf+CkSHy9J
 xhTeCO+g7JVW1JGiAlUUKh9oybkE6Y0/LkaX0Yc6/xCG5Qqk5yFYOg2j+FQGaFOy2LnVpXP
 rnNxPmIFlEAtFga0ONNJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LfX2v8KSRYo=;bisTn+IPouirnVge06mK6CJi3NY
 2QCyD7bMhvBYsaufkuw3ae3Ul53R2uYq/VCZsrnIMEr9EmaZYSNIY361kjQSzrIiZakWeC1oy
 EjpG0RqFs9R9rWRwcuKLVfcLKvNnCjSstwIUVH2oviW4zjvtGh/3kRzP94XXA6E9BTIaeHPXC
 OJTO7sCPup4wNB8jyEHz56g3KClQKyYVLEFz9BaOe1pyaDdG6b/+xJnJgXrEhzhibbPhIg7Em
 Fkq/eOoRI8gOX4wQXLQ9BaiV7Q9vrzNI5tDxjqCQVKaS32wps1FpNJgAqMW0gZzDzm7p9NdwK
 /IpC9rXwHUAVHSZmK1OkHnnHFD+hIXKBs3sKApe9I2Juxu9TN59VCdbKV10lQceJ9y6XDA9k/
 uckBRrsNvt9kSXUsfDnrlu56ZTUN61jnuXtauyDIY9r1kNaCiZqBi3Awqj1JzWKgPXcWTALfZ
 hgAiMb/On7NHy2conzqfBQu1CE8S9UxO7wleTZcIXu0XG+quNf2HRRozx7sz1/Ux7SzQGTROO
 88ohKbLKt9wd2/k54uluGut1upw5kC9T+QqxGZS39dEAvBWG+IB9LwCZu8eCecYlcMyoXZiM2
 jAD1K6X7ed11tl7cfH3fFlE2Nqsk9dluLWLKLgpoHefwU0C4rdDGOHXJr/0KFXkDH/YXS+d/L
 lHzYbRmqDFB8Wi4BHQjWCRv1+JZR+lmRNWygPnWOvEyItToE5Rb22P8nvL+1+mruAEm0rZxl6
 uMkA1ZeZWDg0CZOk4LQIoLTOGybKtrrN24V8ea+q6U3Wk6zvWUmIPzEykwYo99QjSVH1d2hb3
 iMXaSQ0+mgTXPYeO0xD6IH+w==

I looked more close at the call trace of the warning and it seems that the=
 problems=C2=A0
occur when shutting down the interface:
[  T847] Call Trace:
[  T847]  <TASK>
[  T847]  ? __warn+0x6a/0xc0
[  T847]  ? mt7921_ipv6_addr_change+0x1d0/0x1f0 [mt7921_common]
[  T847]  ? report_bug+0x142/0x180
[  T847]  ? handle_bug+0x3a/0x70
[  T847]  ? exc_invalid_op+0x17/0x70
[  T847]  ? asm_exc_invalid_op+0x1a/0x20
[  T847]  ? mt7921_ipv6_addr_change+0x1d0/0x1f0 [mt7921_common]
[  T847]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T847]  ? __ipv6_ifa_notify+0x16f/0x4d0
[  T847]  ? ieee80211_ifa6_changed+0x5e/0x70 [mac80211]
[  T847]  ? atomic_notifier_call_chain+0x51/0x80
[  T847]  ? addrconf_ifdown.isra.0+0x43f/0x810
[  T847]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T847]  ? addrconf_notify+0x15d/0x760
[  T847]  ? __timer_delete_sync+0x70/0xd0
[  T847]  ? raw_notifier_call_chain+0x43/0x60
[  T847]  ? dev_close_many+0xea/0x160
[  T847]  ? dev_close+0x65/0x80
[  T847]  ? cfg80211_shutdown_all_interfaces+0x48/0xe0 [cfg80211]
[  T847]  ? cfg80211_rfkill_set_block+0x25/0x40 [cfg80211]
[  T847]  ? rfkill_set_block+0x8f/0x160 [rfkill]
[  T847]  ? rfkill_fop_write+0x14e/0x1e0 [rfkill]
[  T847]  ? vfs_write+0xf3/0x420
[  T847]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T847]  ? ksys_write+0xae/0xe0
[  T847]  ? do_syscall_64+0x5f/0x170
[  T847]  ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
[  T847]  </TASK>
[  T847] ---[ end trace 0000000000000000 ]---

I think there's a race happening on shutdown between ipv6_addr_change (whi=
ch uses mvif->phy)
and ieee80211_do_stop (which zeros the private data including mvif->phy).

Bert Karwatzki

