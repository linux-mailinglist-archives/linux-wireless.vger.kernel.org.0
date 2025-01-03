Return-Path: <linux-wireless+bounces-17035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EF4A00687
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 10:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226711881453
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B141CACF6;
	Fri,  3 Jan 2025 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="U3YbVxAT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA11CB9E2;
	Fri,  3 Jan 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895609; cv=none; b=u6G6w0niwkVMNnCizFSBlclnaxHdOIG9OgXSBwVT4/nTQmThJWHrN9ILa3t//rG3Jf8foXB123yegBMIXIKFYie7nr9TZrIrNgrgdc2QuIo4/JI6uNQ73qw9saL/hox4i3AhEw14pUp2wofNcROfwQJki/C8D503qilLp1ozImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895609; c=relaxed/simple;
	bh=mBfGg2mdwaGDRLXzxDp/+2dvjqbxtIk/u98dbtvFfqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gtBMAnSD/X+YOw6duM+Hx1nEnbS4M17reGBAuI/BFlGLY4Nh4dSbWJAxmntzBCnipTxzWqKOwfIoLAsgYz8rJZ4V/tdDHTbOwbD1FOcCYSVK8JLL5xob1z+Zp0aWaxlWcxAZAk88MpU0vQ84bc7yvjHvmC/MygLO53DM53iHajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=U3YbVxAT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5039CxmrE1742500, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735895579; bh=mBfGg2mdwaGDRLXzxDp/+2dvjqbxtIk/u98dbtvFfqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=U3YbVxATtAlDlDiahba7dAEd/PR87s8Nv0qORJZB7uLARz4GJLAbJidHMaDu+2yu3
	 KVHCTreEyMnT63ygToyA1EUkDfXq9j7tK8r6oDlN3E0mhBaLnl9FZAwxm/zq4TlWIf
	 BFpq6Lp1SYWd6C4hJOH49QO3OcarEzkBY/r1Xp12IzPvVx5VQ8XaiqqdI/7pUZh3/P
	 87pT9aXWJv32BNkFyqI0D5TqN9YB769vUa+uXinuzW248tVN6RQrz1cA9g8/FONWOU
	 vc/vdd3tesZiNA9xQlljVy8vcTjDveyJJkmqsarAYyedzB0quWQkulVViJqbaabGQx
	 eCmE9RtRwS+Kg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5039CxmrE1742500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 17:12:59 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 3 Jan 2025 17:12:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 Jan 2025 17:12:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 3 Jan 2025 17:12:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Fiona Klute <fiona.klute@gmx.de>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
Thread-Topic: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
Thread-Index: AQHbXbRT6Xomx6m3pUytS3VuSE/MqbMEwvoA
Date: Fri, 3 Jan 2025 09:12:59 +0000
Message-ID: <f69874f3c11f4c7b8b0e3026796bb452@realtek.com>
References: <20250103075107.1337533-1-anarsoul@gmail.com>
In-Reply-To: <20250103075107.1337533-1-anarsoul@gmail.com>
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

Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> Fix 3 typos in 8703b driver. 2 typos in calibration routines are not
> fatal and do not seem to have any impact, just fix them to match vendor
> driver.

Just curious how you can find these typos?=20

>=20
> However the last one in rtw8703b_set_channel_bb() clears too many bits
> in REG_OFDM0_TX_PSD_NOISE, causing TX and RX issues (neither rate goes
> above MCS0-MCS1). Vendor driver clears only 2 most significant bits.
>=20
> With the last typo fixed, the driver is able to reach MCS7 on Pinebook
>=20
> Cc: stable@vger.kernel.org
> Fixes: 9bb762b3a957 ("wifi: rtw88: Add definitions for 8703b chip")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Is this urgent? If not, I will take this via rtw-next tree.=20


