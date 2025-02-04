Return-Path: <linux-wireless+bounces-18331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69536A26824
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 01:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF1F1886085
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 00:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541C4EC4;
	Tue,  4 Feb 2025 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DteENgBo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488AC370;
	Tue,  4 Feb 2025 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738627476; cv=none; b=HCj47moLZAlOds9jLSEqn+heAMW40+CZkUBbjDslEBU8fHMm7r9Dwd4xDkQGvZMpk+21Ap43FdxJLjygg7FLgOE0w7/pjhPed09U2k1G6aIUn94KYRGms40+B2xvEA7gPhv4Qxn+m6A+fdf0IW/awhVEcGnr3HdrZN3Ls/lgLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738627476; c=relaxed/simple;
	bh=mQpW2D3sepuCbzbqkPgYTt27Z/psZgYrTXXH3HnFnQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z2Ie1wvPUsorwlWf0RWIW2hNXCi83DougMj4J25lcazG79uMBPXD3Oj9OF7fJgzxBcHFro9XzjTnRyaNU90A7qgCmvhc/zZAo4eE7UR+Ij2J+fTbI8gt0Opv9z4+nfTeRS9VrOQKgebmVdCapYeyJLrewyJkrQ4BD9HDWanaLR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DteENgBo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51404M8H02479672, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738627462; bh=mQpW2D3sepuCbzbqkPgYTt27Z/psZgYrTXXH3HnFnQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DteENgBoonIY8mfMbVPuTHh9vYZbV0cP05UR3RUzAgIXUp6T7StaysQ3Wrw+51bxY
	 coUQYBFSFqzECrekCXMGs1Gc+2Xac1HJfuA+qR4ydgUeVq66Po8GhG8NgdLrio91ui
	 g+y+KnrhOgAVqzFYlF1yPKpZVlryorP/vLGVNeytmHeuPLtCvoZ4I6F+VCcEPCCt+b
	 8B6e5ltjByZY4E5A0K19LINdLzC8FqYQYEyQaqapb1znbys9AYF4svNoUyeVEb0iS3
	 YL/zqFZ0W6m4djiCfrYdbjD+3f6YSfq1SjW1f1ExagB6NXDtOSQfSkM1caO2uRo5hG
	 GJUwPoL+oPzfw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51404M8H02479672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 08:04:22 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Feb 2025 08:04:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 4 Feb 2025 08:04:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Tue, 4 Feb 2025 08:04:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Andrew Kreimer <algonell@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH net-next] wifi: rtw88: Fix a typo
Thread-Topic: [PATCH net-next] wifi: rtw88: Fix a typo
Thread-Index: AQHbdmbCbZV3uAmz40+gZjbWMozJvrM2Qyyg
Date: Tue, 4 Feb 2025 00:04:22 +0000
Message-ID: <59ace70567f544e3b0b9bd601e2a24b7@realtek.com>
References: <20250203180913.5435-1-algonell@gmail.com>
In-Reply-To: <20250203180913.5435-1-algonell@gmail.com>
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

Andrew Kreimer <algonell@gmail.com> wrote:
> There is a typo in debug messages:
>  - afer -> after
>=20
> Fix it via codespell.
>=20
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

To be clear, during commiting I will change subject to
"wifi: rtw88: Fix a typo of debug message in rtw8723d_iqk_check_tx_failed()=
"


