Return-Path: <linux-wireless+bounces-10348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D21C934BD6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 12:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0AB2846A8
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546EC8286D;
	Thu, 18 Jul 2024 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="hAHI4cvD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F843839EB
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299459; cv=none; b=poXGnwc9rHSzo0vuM6BQ4OBadiKy6sfE0r8gnxjskIp7/Av6lvVgCdkuoDqdVlbrEDz+Zj0jPqLr8DMEYzMF7rOVYMZpnfLmbD84oDEfigZhIX/KtteVmF+eI5vLNCu5CcpMlTV50BIyJo4ZVDaDq2XAiCdfzB5zwjOEcdja9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299459; c=relaxed/simple;
	bh=PL8eGs3p9sbmrz2+nfDasqPwINb9jB5Ji+zhdE7EhoE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OdJiUX9oOztCj8jaIMW09fwdZFmCV9qBdSoM1Vqe9jx+/2bMd2eK0McKHx5Yab1VUqSErcDwYuQhRCjjZ3lPItt44aGXoS0gpli8buSFMDSrzpLuYhY9A7fkG2j0Hj7aVE6Na0I0JUX4jjTDAYGC2lhWuxDHECvzjeJFlzPeadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=hAHI4cvD; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721299424; x=1721904224; i=spasswolf@web.de;
	bh=9ehcEZ3ZqTGFKCqFJksb5S1t2k/S10rcVu5i9dkq9CY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hAHI4cvDUQaOeImOBhCCDEctdEodeNgb7+iEID3OJLOei0AS7Ey6IXH6VdUsJMI3
	 mMoUanCIJ0q/NIcAwXAILRPvXtWh9SPbcCvJxkl1sSNREfWx35F8Hhp8xEkkTTNgc
	 nlZ+Fqb6sy85Li0EyqgMZAo6Usw1vCM/JlRvb1S+r3NjyyfSdDgj3pPDW9xAuB1X0
	 Bzw/T5jKbuta4q9faXvQzNh958JXZnneNyORYy14S1MP0H/baVLs+ADzfr+9Jxcmr
	 FyDYU+i9OdyFzai00wtsia1Bj+TpfAlxhTGcQ3s2xionSmqnb1iqR6ab0eZDGEgfb
	 eOptZLn5itVKfnw/ow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MV2Ka-1swLaA2BU6-00SRgt; Thu, 18
 Jul 2024 12:43:44 +0200
Message-ID: <2fee61f8c903d02a900ca3188c3742c7effd102e.camel@web.de>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
From: Bert Karwatzki <spasswolf@web.de>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	mingyen.hsieh@mediatek.com, sean.wang@mediatek.com, spasswolf@web.de
Date: Thu, 18 Jul 2024 12:43:43 +0200
In-Reply-To: <308958f4c5689fd920c3915f4878850a09310b18.camel@web.de>
References: <20240711175156.4465-1-spasswolf@web.de>
	 <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
	 <adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
	 <4e943a62736f955af5d9cd1aff7e2b9c084c8885.camel@web.de>
	 <2599b886-9c63-4989-a08a-7feab28f7c49@nbd.name>
	 <9fb7ac97d2ca472db469aefefbfeb94e0f886508.camel@web.de>
	 <308958f4c5689fd920c3915f4878850a09310b18.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0TSoC0GQldjw10NePlY+xljFhTr7f/cL4xm+YTGY9RSJw+uv/nt
 Avr6ST0AF4l2w14rW6jjNu8kJUUKaZJ4s5N+hhCqcALws1xHtsMqw98NLsfqAah5fNmaNTS
 +5iNj8RAShkav2D2ZG3zIFE/0wYyxaKu7YyxHjNzQwf04yNmwjfsTny4SD5rECusIWN/TBl
 ZEt6F2TRd7P2+YSm7c0CA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7u4UlcLKQfs=;GI3AbUFi+RhUQHtInBWIYjyYqXF
 d7j24FakUCvXi2Pi6WNLSgRHXHsQbhuNvnwEx72gW4/v4LHuqclcsEJcYEhb3ANGqDXDXwxmX
 fpdy0RC0X4zEkvXJ3/lZAtt5T1SjoQY5IB9A3JdiCFemVY4pxQ12P7BpVc5XSxVfKvfuH6rv2
 iOFz7kkZXJGlvYJkR9Io4xNkuZiPXPBe+WOEx+/2vFkChLmXWXGP1fi6yVaCork/QwJDcBhzb
 eFJDrGTmXL5xDdXUkA5/pHq94HuDmGeSR2sm4BAKNBhUu5BN828nrVMvou0zgdiZ+bN7c/Y2a
 +4/kGbVr6otqbeimdednvFUXGVv9lpil47hyevMU5ZFUZOOtfcsvuLriLo727F8SWI/AKspkY
 6qO1wA7XolcSpxjcn2rwCX7kHa9c3Eq6RnT43zFTDExZw4310Fe8VcZiioZpLv1u537pOqxSF
 43cAUdunLAtZ8m+HbGPPvcaBfc4MT1NXM2tcxQTTjSjv9fqM/a93jUpxu8X7Brqa9lFMfcpYd
 Lcbq1PGwlQebw/mwpFO56Wq0jfEOivZGGWPydLn8GJ3Qk7f80rgiqBDOqCIh7DinOd7rjVRMP
 995vi+2Eavj/NlFNSwuc0y5NASN70PtcP6O63w17ya46EeGU7t2y8GlTasfxFXdiY/slYCeIg
 PE+aI/7po+yd2Jv0CA+0WmXPIJIi+TSakvvCIV2Bdu0PGbCGuNZcV4jt46Aa/O1Xv85nkRl5+
 s/Wcg/zo8PQRybLvriMvQV0KR9wINi1aQp2SSI+kFNorX9tZltVYVsix3VJ+0MD/S1pl2mbNF
 6OaziLyxVQTF82Vp6r37E3Zw==

I looked more close at the call trace of the warning and it seems that the
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
ch
uses mvif->phy)
and ieee80211_do_stop (which zeros the private data including mvif->phy).

Resend with fixed formatting.

Bert Karwatzki


