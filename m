Return-Path: <linux-wireless+bounces-8073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A038CF980
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 08:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E8C2814BA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDFE17552;
	Mon, 27 May 2024 06:47:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C31754B
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716792423; cv=none; b=tO343spAF2Vx5RYMj6hX+0I0RNBsMXSJztpZujjQThwTkYzBKTyMjycqRkZXMoMOQfkJCG80p7piIn0xANdDWwjUw/iju3dzMxkrl18AkpuHpAbgviu8MIekUJmoLhwPO0XooJfwH5j7jxNTp0EWy8v9VnfMuYZqftPcdvNfFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716792423; c=relaxed/simple;
	bh=KkT4N9rJ20XyHoIXK7ATJmODVv+0L9WkCpVvPzMDsaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V/3JXB+VVlgMl7jFQn6LiIQGAs8h2nTnLVxjbxM+EFrmmE7wiHbwjATrivZRmV+LcQ522H/NfT6SqfieyiZF70b65M2wYbeMy3e6t6GFp3l65lof/fOUus0m9AFNrF70+S/LfuGW86XJevT//vln69j6cBNgm3Qp+jVcRzej0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44R6kdBhB847870, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44R6kdBhB847870
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 14:46:39 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 14:46:39 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 27 May 2024 14:46:38 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266]) by
 RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266%2]) with mapi id
 15.01.2507.035; Mon, 27 May 2024 14:46:38 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: mac80211: fix NULL dereference at band check in starting tx ba session
Thread-Topic: [PATCH] wifi: mac80211: fix NULL dereference at band check in
 starting tx ba session
Thread-Index: AQHarOpgkYVLW/TkN0STRQVqWrvRWLGnuz77gALnDRA=
Date: Mon, 27 May 2024 06:46:38 +0000
Message-ID: <b642c931a087475bb2fc021582e3269f@realtek.com>
References: <20240523082200.15544-1-kevin_yang@realtek.com>
 <874jamnrb8.fsf@kernel.org>
In-Reply-To: <874jamnrb8.fsf@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Kalle Valo <kvalo@kernel.org> wrote:
>=20
> <kevin_yang@realtek.com> writes:
>=20
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > [...]
> >
> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
>=20
> Kevin's s-o-b missing.
>=20

Sorry, I didn't configure sendemail.from properly.
(I will double-check my configuration before sending patch next time.)
But, my s-o-b has been there.

