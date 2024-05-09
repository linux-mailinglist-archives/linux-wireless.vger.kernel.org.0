Return-Path: <linux-wireless+bounces-7367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB0E8C083C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 02:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB781C21117
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 00:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC93E63D;
	Thu,  9 May 2024 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHPxWM+l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B929AF;
	Thu,  9 May 2024 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213262; cv=none; b=fC87fcK0PPwSoe4NqCexojROfKSTE1yfq/1yGUOG2snUcfIAkcAvPnxRg24PKZT76SRFkh22sSSA0wh/Q9imROZkucXiCkqu7ccoGAcqqqhsko3vOywTijAmHSibA7B9IUNTOh2ot4vMK17WPHHzGjyyGLFFN4f/8EXiSPYQPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213262; c=relaxed/simple;
	bh=ziz23AkMGWZ+RssWHGSdyXLJGozhK/cIidFihX1yxa8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hhBg3pHi540P4EYrffvn8LkLR60+GaBX18PHgLIm4Mz8SY2E9wcDt6gMzm3K604mpSZW225WHG2fo0l+wcUWmJq5pqA0cUJZuA4bC752XNk2Xhr7DSPuUPHG4Dqk75uXfuw9a8yzpuoXq1TWPLtpTXibkcevJz6ZCBZB819849w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHPxWM+l; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ee7963db64so1962795ad.1;
        Wed, 08 May 2024 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715213260; x=1715818060; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGEElrW4zdUy7dtECvgDhnXjdZon9OGFjF5E8y51Mh4=;
        b=jHPxWM+l0LDiY9itrBbyBPXwBa6oj6toOb0Id4Ckt8+VIfLq9tiKsxU51Gmi+w9O6h
         qZ1IpsQOzp4vIMWCCuZWVkHS1ZEWWO4AnrdfRl/Pc1/xQLA6wJ//5HQAswwmhdPhFsax
         FZpdt6XarsJu9kFVmleTuhXRL6UdUMrJXwpYRiVh/jPJRHOR9stL98lIsKD+TbWSFMze
         tZzw4cWVKXAf1vEMQzsrTTF0jHtcuqM9hC6mXQt0F3puc8Hzv+dIt9Dct4R/yGSXfctD
         eFq1Fx8uO+0vgs/wnchdyAfG4UQtFLE52mitlKM0xa3ivGBF6IblXZdk6Yj2JFLFSb1q
         NuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715213260; x=1715818060;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGEElrW4zdUy7dtECvgDhnXjdZon9OGFjF5E8y51Mh4=;
        b=OQL5qH8X0edG/R8oPfJ6IcQF25resY69Ix9R1u1lh/Glri3esmWgoA5nm1zluXGMbr
         n4W7thw09Av+KcSSh3LPoOMSuyY1MsdWQny/SF50tCN/GHhNmv+rjRSS3HzLpSMJU5kg
         68q/RSxkfjZ5fPshSCV8PFvnYtsUW/ctxsK+1QyoLfEaVggDbsJmYmy+G+GaGD2h70fx
         JIhj6O6HXs1d3lpiFWJCPfZU8CDftbkZRXDR7+LAQCPZyzDG1JPYcVI2tcgFjszNcJzC
         aZvvy3u6Xhrujxlb1ybiHSpPGWvhzMWiNFS4h5n0QYb9/wlRrU7zyt4uI9K1saC59XfD
         VMQw==
X-Forwarded-Encrypted: i=1; AJvYcCWt3FnWJtOivmWYSHCLoqjtIP++GxRJflyPhzl9jn1jQnxYZolYcFTrubmun0X/uMh3qGGzfkfg4k1upfXF5vl3N9d9ZIocKLnFo2fU6dLSYJpJsg6kD6VUDUAhaTvkqm5GX3uVskU=
X-Gm-Message-State: AOJu0YwRI+rQ2ZwM/Goj6eOzZFc41KBHLvB9FuX0O+0Nm7m8TD0uUlCP
	IPQXPi77rAsrMjp6M7yog1msn8l6TeRNoQemksU3z09c2ILlxpSupbM7AQ==
X-Google-Smtp-Source: AGHT+IGuTfY4dxsdyAj7jPrFPVNxHB3OtFAT9jeLcvtOyffxMoM6l3jz7Z94QMuju6OtLpGNBYkDZg==
X-Received: by 2002:a17:903:120e:b0:1eb:7bc7:8855 with SMTP id d9443c01a7336-1eeb017cf52mr49536975ad.2.1715213260040;
        Wed, 08 May 2024 17:07:40 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2566ccsm1166555ad.294.2024.05.08.17.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 17:07:39 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C785018462DC5; Thu, 09 May 2024 07:07:36 +0700 (WIB)
Date: Thu, 9 May 2024 07:07:36 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Wireless <linux-wireless@vger.kernel.org>
Cc: Jouni Malinen <jouni.malinen@atheros.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jannik =?utf-8?B?R2zDvGNrZXJ0?= <jannik.glueckert@gmail.com>
Subject: Fwd: UBSAN: array-index-out-of-bounds in net/wireless/nl80211.c and
 net/mac80211/scan.c
Message-ID: <ZjwTyGqcey0HXxTT@archie.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uVq9w8jupfQiwLWt"
Content-Disposition: inline


--uVq9w8jupfQiwLWt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Jannik Gl=C3=BCckert <jannik.glueckert@gmail.com> reported on Bugzilla arra=
y index
out-of-bounds catched by ubsan along with full kernel trace dump (see
https://bugzilla.kernel.org/show_bug.cgi?id=3D218810):

> I am seeing multiple array-index-out-of-bounds related to `ieee80211_chan=
nel[]` iteration.
>=20
> This is with a Mediatek MT7921 chipset.
> I have only tested with kernel 6.8.9, but I don't see any channel index r=
elated fixes in master.
>=20
> This was discovered as part of Gentoo Hardened enabling CONFIG_UBSAN_ARRA=
Y_BOUNDS
>=20
>=20
> [  106.194465] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-k=
ernel/gentoo-kernel-6.8.9/work/linux-6.8/net/wireless/nl80211.c:9203:29
> [  106.195063] index 42 is out of range for type 'struct ieee80211_channe=
l *[]'
> [  106.195599] CPU: 11 PID: 4166 Comm: wpa_supplicant Not tainted 6.8.9-g=
entoo-dist-hardened #1
> [  106.196038] Hardware name: ASUS System Product Name/TUF GAMING B650M-P=
LUS WIFI, BIOS 2214 01/02/2024
> [  106.196485] Call Trace:
> [  106.196913]  <TASK>
> [  106.197439]  dump_stack_lvl+0x71/0x90
> [  106.197899]  __ubsan_handle_out_of_bounds+0xed/0x160
> [  106.198420]  nl80211_exit+0x7c3f/0x21f70 [cfg80211]
> [  106.198917]  genl_family_rcv_msg_doit+0xea/0x150
> [  106.198922]  genl_rcv_msg+0x234/0x260
> [  106.198923]  ? nl80211_exit+0x40/0x21f70 [cfg80211]
> [  106.198930]  ? nl80211_exit+0x7290/0x21f70 [cfg80211]
> [  106.200847]  ? nl80211_exit+0x290/0x21f70 [cfg80211]
> [  106.200854]  ? __cfi_genl_rcv_msg+0x10/0x10
> [  106.200856]  netlink_rcv_skb+0xff/0x140
> [  106.200859]  genl_rcv+0x28/0x40
> [  106.200860]  netlink_unicast+0x265/0x390
> [  106.200862]  netlink_sendmsg+0x381/0x440
> [  106.200865]  __sock_sendmsg+0x94/0xb0
> [  106.200868]  ____sys_sendmsg+0x1c3/0x250
> [  106.200871]  ___sys_sendmsg+0x293/0x2d0
> [  106.200873]  ? do_sock_setsockopt+0xf5/0x190
> [  106.200879]  __se_sys_sendmsg+0x102/0x140
> [  106.200882]  do_syscall_64+0x8e/0x170
> [  106.200884]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.200886]  ? do_syscall_64+0x9a/0x170
> [  106.200889]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.200890]  ? do_user_addr_fault+0x506/0x6b0
> [  106.200892]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.200893]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.200895]  entry_SYSCALL_64_after_hwframe+0x78/0x80
> [  106.200896] RIP: 0033:0x7fe10ad2fde4
> [  106.200911] Code: 89 02 b8 ff ff ff ff eb af 66 2e 0f 1f 84 00 00 00 0=
0 00 0f 1f 00 f3 0f 1e fa 80 3d 85 e5 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 53 48 83 ec 20 89 54 24 1c 48
> [  106.200912] RSP: 002b:00007ffe72950598 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000002e
> [  106.200913] RAX: ffffffffffffffda RBX: 000055e0ceb8d180 RCX: 00007fe10=
ad2fde4
> [  106.200914] RDX: 0000000000000000 RSI: 00007ffe729505f8 RDI: 000000000=
0000005
> [  106.200915] RBP: 0000000000000000 R08: 0000000000000004 R09: 000000000=
0000001
> [  106.200915] R10: 00007ffe72950688 R11: 0000000000000202 R12: 000055e0c=
eb8d090
> [  106.200916] R13: 0000000000000000 R14: 000055e0ceb8d180 R15: 00007ffe7=
29505f8
> [  106.200918]  </TASK>
>=20
>=20
> [  106.200924] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-k=
ernel/gentoo-kernel-6.8.9/work/linux-6.8/net/wireless/nl80211.c:9252:5
> [  106.200926] index 0 is out of range for type 'struct ieee80211_channel=
 *[]'
> [  106.200926] CPU: 11 PID: 4166 Comm: wpa_supplicant Not tainted 6.8.9-g=
entoo-dist-hardened #1
> [  106.200928] Hardware name: ASUS System Product Name/TUF GAMING B650M-P=
LUS WIFI, BIOS 2214 01/02/2024
> [  106.200928] Call Trace:
> [  106.200929]  <TASK>
> [  106.200930]  dump_stack_lvl+0x71/0x90
> [  106.200932]  __ubsan_handle_out_of_bounds+0xed/0x160
> [  106.200936]  nl80211_exit+0x7643/0x21f70 [cfg80211]
> [  106.200947]  genl_family_rcv_msg_doit+0xea/0x150
> [  106.200950]  genl_rcv_msg+0x234/0x260
> [  106.200952]  ? nl80211_exit+0x40/0x21f70 [cfg80211]
> [  106.200960]  ? nl80211_exit+0x7290/0x21f70 [cfg80211]
> [  106.200966]  ? nl80211_exit+0x290/0x21f70 [cfg80211]
> [  106.200976]  ? __cfi_genl_rcv_msg+0x10/0x10
> [  106.200978]  netlink_rcv_skb+0xff/0x140
> [  106.200981]  genl_rcv+0x28/0x40
> [  106.200982]  netlink_unicast+0x265/0x390
> [  106.200985]  netlink_sendmsg+0x381/0x440
> [  106.200988]  __sock_sendmsg+0x94/0xb0
> [  106.200990]  ____sys_sendmsg+0x1c3/0x250
> [  106.200993]  ___sys_sendmsg+0x293/0x2d0
> [  106.200994]  ? do_sock_setsockopt+0xf5/0x190
> [  106.201000]  __se_sys_sendmsg+0x102/0x140
> [  106.201003]  do_syscall_64+0x8e/0x170
> [  106.201004]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.201006]  ? do_syscall_64+0x9a/0x170
> [  106.201010]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.201011]  ? do_user_addr_fault+0x506/0x6b0
> [  106.201014]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.201015]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.201017]  entry_SYSCALL_64_after_hwframe+0x78/0x80
> [  106.201018] RIP: 0033:0x7fe10ad2fde4
> [  106.201021] Code: 89 02 b8 ff ff ff ff eb af 66 2e 0f 1f 84 00 00 00 0=
0 00 0f 1f 00 f3 0f 1e fa 80 3d 85 e5 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 53 48 83 ec 20 89 54 24 1c 48
> [  106.201022] RSP: 002b:00007ffe72950598 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000002e
> [  106.201023] RAX: ffffffffffffffda RBX: 000055e0ceb8d180 RCX: 00007fe10=
ad2fde4
> [  106.201024] RDX: 0000000000000000 RSI: 00007ffe729505f8 RDI: 000000000=
0000005
> [  106.201025] RBP: 0000000000000000 R08: 0000000000000004 R09: 000000000=
0000001
> [  106.201026] R10: 00007ffe72950688 R11: 0000000000000202 R12: 000055e0c=
eb8d090
> [  106.201026] R13: 0000000000000000 R14: 000055e0ceb8d180 R15: 00007ffe7=
29505f8
> [  106.201029]  </TASK>
>=20
>=20
> [  106.201036] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-k=
ernel/gentoo-kernel-6.8.9/work/linux-6.8/net/mac80211/scan.c:364:4
> [  106.201037] index 0 is out of range for type 'struct ieee80211_channel=
 *[]'
> [  106.201038] CPU: 11 PID: 4166 Comm: wpa_supplicant Not tainted 6.8.9-g=
entoo-dist-hardened #1
> [  106.201039] Hardware name: ASUS System Product Name/TUF GAMING B650M-P=
LUS WIFI, BIOS 2214 01/02/2024
> [  106.201040] Call Trace:
> [  106.201040]  <TASK>
> [  106.201041]  dump_stack_lvl+0x71/0x90
> [  106.201043]  __ubsan_handle_out_of_bounds+0xed/0x160
> [  106.201046]  ieee80211_sched_scan_stopped+0x42a/0x720 [mac80211]
> [  106.201062]  ? vprintk_emit+0x2b4/0x340
> [  106.201064]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.201065]  ? __kmalloc+0x1e8/0x430
> [  106.201068]  __ieee80211_start_scan+0x4fa/0xb90 [mac80211]
> [  106.201081]  cfg80211_scan+0x22d/0x1270 [cfg80211]
> [  106.201091]  nl80211_exit+0x7bde/0x21f70 [cfg80211]
> [  106.201101]  genl_family_rcv_msg_doit+0xea/0x150
> [  106.201105]  genl_rcv_msg+0x234/0x260
> [  106.201106]  ? nl80211_exit+0x40/0x21f70 [cfg80211]
> [  106.201112]  ? nl80211_exit+0x7290/0x21f70 [cfg80211]
> [  106.201118]  ? nl80211_exit+0x290/0x21f70 [cfg80211]
> [  106.201124]  ? __cfi_genl_rcv_msg+0x10/0x10
> [  106.201125]  netlink_rcv_skb+0xff/0x140
> [  106.201128]  genl_rcv+0x28/0x40
> [  106.201129]  netlink_unicast+0x265/0x390
> [  106.201131]  netlink_sendmsg+0x381/0x440
> [  106.201133]  __sock_sendmsg+0x94/0xb0
> [  106.201134]  ____sys_sendmsg+0x1c3/0x250
> [  106.201136]  ___sys_sendmsg+0x293/0x2d0
> [  106.201137]  ? do_sock_setsockopt+0xf5/0x190
> [  106.201142]  __se_sys_sendmsg+0x102/0x140
> [  106.201145]  do_syscall_64+0x8e/0x170
> [  106.201147]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.201148]  ? do_syscall_64+0x9a/0x170
> [  106.201152]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.201153]  ? do_user_addr_fault+0x506/0x6b0
> [  106.201155]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.201157]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  106.201159]  entry_SYSCALL_64_after_hwframe+0x78/0x80
> [  106.201160] RIP: 0033:0x7fe10ad2fde4
> [  106.201162] Code: 89 02 b8 ff ff ff ff eb af 66 2e 0f 1f 84 00 00 00 0=
0 00 0f 1f 00 f3 0f 1e fa 80 3d 85 e5 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 53 48 83 ec 20 89 54 24 1c 48
> [  106.201163] RSP: 002b:00007ffe72950598 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000002e
> [  106.201165] RAX: ffffffffffffffda RBX: 000055e0ceb8d180 RCX: 00007fe10=
ad2fde4
> [  106.201165] RDX: 0000000000000000 RSI: 00007ffe729505f8 RDI: 000000000=
0000005
> [  106.201166] RBP: 0000000000000000 R08: 0000000000000004 R09: 000000000=
0000001
> [  106.201167] R10: 00007ffe72950688 R11: 0000000000000202 R12: 000055e0c=
eb8d090
> [  106.201168] R13: 0000000000000000 R14: 000055e0ceb8d180 R15: 00007ffe7=
29505f8
> [  106.201170]  </TASK>

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--uVq9w8jupfQiwLWt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjwTwQAKCRD2uYlJVVFO
o3WkAQCHGn43HO2WTzTmn+NztzAimlbwnmkbpLDeCML2Zk/qjwD/bBw/OzIlKi+V
2WLVY4dUrX8Ha8koZlcToM1iGNsbSAM=
=JIIK
-----END PGP SIGNATURE-----

--uVq9w8jupfQiwLWt--

