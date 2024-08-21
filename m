Return-Path: <linux-wireless+bounces-11718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C55959369
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 05:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D4B1F23AEA
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 03:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE8208D0;
	Wed, 21 Aug 2024 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="szMUpwLA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE4418E34F;
	Wed, 21 Aug 2024 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724212008; cv=none; b=SmXDwGkKiBCNRd0Ji5q43qRyavoHfF3XG9fireYN1eiqLY4DvVTBUPbB+Pn+jFgWitGm01RctboH5L3nT2k7bBwiqztc1cXOIIfucUH5fyWAuT0uMJRHNApyJJYNnpACdpRIL32SLPLszuHW19bvULl+zGPUSFc6WhtSWQxgh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724212008; c=relaxed/simple;
	bh=R3jVslqYcebjFefTUBHMZ9itwtoJ/PWvlbJZcxu13D8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K8MU/OIfPhlYmzPf6v0NJytCItC4lsKjHqRTzFn+6DYP3zgt20FvionHOiq8HZJ7nIMw8ziHOgaEXH3SNRNk+vyUJoEMDUsSkhidGFRaebnwFYnkQaOxyLpTDxV7wqNhNg0un0mpCK/9OlxU3i0kGhSCEMN84fcVyVBBkNhhCgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=szMUpwLA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47L3grRP32250940, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724211773; bh=R3jVslqYcebjFefTUBHMZ9itwtoJ/PWvlbJZcxu13D8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=szMUpwLAzUOkxHlVrGYbu47MyInj4zZzLOFmI7XMMr69r0TUCVlbkSYbkcD0rejzj
	 523hmkS9QoHQCuKXUpvEjKnaAEW5P7RxMah3Mxk03+GWJ2lj1TeV/S0dNOKEIkqO1u
	 Ut6TBMKilR/hXBR9uPQLf6ZrNTM9Ij/c0gzOCi6hjuGGM2QZeNy3XSTASbjnrqjlmZ
	 m+f6cWhxh+Ri9EpPG/WKET66XxoR1b2YjuNcMXiH9cZRevcsbdD/tfKHJUZ7tr+RVh
	 KUZKZEVR3nsm1HGFgQEEwy9Mcw4hI/UpvED1OmOHe1JiKxw8GDk2xf4LHCWDZUkNK9
	 LyA958pXkeH4A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47L3grRP32250940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 11:42:53 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 11:42:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Aug 2024 11:42:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 21 Aug 2024 11:42:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>,
        "arend.vanspriel@broadcom.com"
	<arend.vanspriel@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "emmanuel.grumbach@intel.com" <emmanuel.grumbach@intel.com>,
        "erick.archer@outlook.com" <erick.archer@outlook.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
        "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] wifi: mac80211: Use kvmemdup to simplify the code
Thread-Topic: [PATCH -next] wifi: mac80211: Use kvmemdup to simplify the code
Thread-Index: AQHa83GEvlUD1o2kZE2cQXXHd/yI9rIxEPdA
Date: Wed, 21 Aug 2024 03:42:53 +0000
Message-ID: <af2157863e684ab3b4a9d345e26b3408@realtek.com>
References: <20240821023325.2077399-1-ruanjinjie@huawei.com>
In-Reply-To: <20240821023325.2077399-1-ruanjinjie@huawei.com>
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

Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>=20
> Use kvmemdup instead of kvmalloc() + memcpy() to simplify the code.
>=20
> No functional change.
>=20
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c | 3 +--

Subject prefix should be "wifi: brcmsmac:".



