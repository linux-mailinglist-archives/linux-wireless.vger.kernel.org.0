Return-Path: <linux-wireless+bounces-14800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAEC9B894E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 03:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F511F22DFB
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 02:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A8F1369BB;
	Fri,  1 Nov 2024 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VbuAIGfr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7258C13698E;
	Fri,  1 Nov 2024 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428066; cv=none; b=M6o6NTKvlIPYPyKlm8Cxy67ENsc0pHjsZKSEba/iGMk53GySj+QruhIcFFU/xWM4QNjvTyLTbmUUCQxiDsAV0wF3JR0TNFoaIqJTcx1j7NA4VeAjwcjIWNw2vOKfmBYw08OAjlZA29OoMgQvwj+YVHpY+VmZG9gPNR0SrLZng3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428066; c=relaxed/simple;
	bh=HpwZ5+wE8mAXiePj9iNiQVheI3qF36Rh4NC1/7WX7vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=siYrkFuXAxMpIM0ReSQYzGYtdWafk8OVzS6X5SErogQkLQJU4jS3VFP9PW7GAQZvAjTGka8tSyUAk5nj55w8ZL0bPUYrGCKah+27znQdynFR3FMtBD7r+VlCCnw/HTgJKKN85X2MNS6xeKUAwlKpL6bXvB1xSMkuhf33Y3KtNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VbuAIGfr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A12Qv4622375000, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730428017; bh=HpwZ5+wE8mAXiePj9iNiQVheI3qF36Rh4NC1/7WX7vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VbuAIGfrEgclMY2XBccXQFpMc1T3cUDhyVvPfvxbI7ZfYUN0TzKLKXc6ebZEMzaoK
	 FSbW5WyZ7G3xU0VHli8D8VNF0uZFOMO/qRPWOb/tORisklNOEoBFvzh2nHr4m/GPwd
	 pJKSLGKtQ1KMzpbkEwwmp4mbV880cJ9/Of+E+tDfJYBkzFYTMOzgbLbrS2FlQ1yApA
	 xkok37NS7IfJaT2i5D8YBvBMcq6FpIByexe2qro6FrchWe73fi6nSeOts7Y/v+iY9a
	 EQGim3SqJ96kFlbCs7Gu7QgmSZ1+oAWgvskfy9RJ+1H17mb/3qRqyzAKjcR4U4zwfw
	 VTLFkXIywX7jQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A12Qv4622375000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Nov 2024 10:26:57 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 10:26:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Nov 2024 10:26:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 1 Nov 2024 10:26:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
	<syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
Subject: RE: [PATCH V3] wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures
Thread-Topic: [PATCH V3] wifi: rtlwifi: Drastically reduce the attempts to
 read efuse in case of failures
Thread-Index: AQHbK62jzL4hMAZxOk2XHUy0QNETw7KhsrTQ
Date: Fri, 1 Nov 2024 02:26:56 +0000
Message-ID: <ae95544aabe74d1da801fed6cc73896e@realtek.com>
References: <20241031155731.1253259-1-gpiccoli@igalia.com>
In-Reply-To: <20241031155731.1253259-1-gpiccoli@igalia.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>=20
> [0] Commit 15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach=
 race").
>=20
> [1] A note about that: this syzkaller report presents multiple reproducer=
s
> that differs by the type of emulated USB device. For this specific case,
> check the entry from 2024/08/08 06:23 in the list of crashes; the C repro
> is available at https://syzkaller.appspot.com/text?tag=3DReproC&x=3D1521f=
c83980000.

Have you run checkpatch before submission? Above two information can be in
formal form as suggestions of checkpatch.=20

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit desc=
ription?)
#55:
in case of failures, restricted to USB devices (given that they're inherent=
ly

WARNING: Reported-by: should be immediately followed by Closes: with a URL =
to the report
#72:
Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

WARNING: The commit message has 'syzkaller', perhaps it also needs a 'Fixes=
:' tag?

total: 0 errors, 3 warnings, 0 checks, 28 lines checked

>=20
> Cc: stable@vger.kernel.org # v6.1+
> Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>




