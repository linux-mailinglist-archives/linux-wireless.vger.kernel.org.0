Return-Path: <linux-wireless+bounces-15120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4579C13D5
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 02:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B529283E16
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 01:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6574F12E5D;
	Fri,  8 Nov 2024 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EiFm3Y2M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D2EAD7
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731031127; cv=none; b=jZtXQOOQ73QGDdWe4kOPgJfPcx1cfr766qfk/kiu+uTSRdFNlKu2wi++3CDFfWcgnKmx7JcPTi+i6/U7VUepyuh1m2/kX1uDbY9m4Pvr+rVy+sFmxA5bZ1tkF6vpqFTh23fRcE/FPCtBNePz0PI5AhBiZ4/ss4IT2mHVbNYAJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731031127; c=relaxed/simple;
	bh=JhvFPQTGTG/Sx3IwYPMdUMqalwY9VkwXJ5yxME2HUdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fr+D7IwVWTWdR8zQKbxv8iIKJV07TZ+CNbaGCxX/kMJ33Dh8UngddGyt5TY0PHrLuYS1c/uaVDH9hkRZ0NwZNzjCEnUed45KUwzyzML9RM2SBWZfI3VVj8pvlTFWSQJAI+gwvGQe5TMMFvKJiishMKjhX2bSG3MzLsDq9Bk/TtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EiFm3Y2M; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A81wRNi91183965, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731031107; bh=JhvFPQTGTG/Sx3IwYPMdUMqalwY9VkwXJ5yxME2HUdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EiFm3Y2MgcCGgTRZ4mk88VO2ZZbGh4fBDQatYAPyhcr/VreoMYCgpWpqcYCMFBa0S
	 MNZI7mYeXYpkryOkHNSmgi7hP6Yudamkedq527+PH/BQ0iVV/kQKail8flzvabvwLq
	 s8YeC6TN35bADgXajAYWUT0yOhN97RD+nZHYrgFBlU/2cwC5SHxpSzAq7Olsun77Rk
	 tcFqdgfbCf63fK4MFgpNKQd6FZubZCGMhazd64JMvqNCQ0k99ObFJd/cb1RdM+7Jci
	 /g5eYj705sP4+pEbVLSav36cIw/3SoplPymomP9o/0tfP24AepSbK0HBsj1rrAHa40
	 AHdFHD5pYxgXA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A81wRNi91183965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 09:58:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 09:58:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Nov 2024 09:58:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 8 Nov 2024 09:58:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH net 2/5] wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last step
Thread-Topic: [PATCH net 2/5] wifi: rtlwifi: rtl8192se: rise completion of
 firmware loading as last step
Thread-Index: AQHbMRmuqnVXb3HGc0Wae0gGFsYhibKsoR9g
Date: Fri, 8 Nov 2024 01:58:26 +0000
Message-ID: <592ce269cce94d2e919ec3221bd0eefa@realtek.com>
References: <20241107133322.855112-1-cascardo@igalia.com>
 <20241107133322.855112-3-cascardo@igalia.com>
In-Reply-To: <20241107133322.855112-3-cascardo@igalia.com>
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

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> Just like in commit 4dfde294b979 ("rtlwifi: rise completion at the last
> step of firmware callback"), only signal completion once the function is
> finished. Otherwise, the module removal waiting for the completion could
> free the memory that the callback will still use before returning.
>=20
> Fixes: b0302aba812b ("rtlwifi: Convert to asynchronous firmware load")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


