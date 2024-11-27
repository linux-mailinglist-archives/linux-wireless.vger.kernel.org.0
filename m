Return-Path: <linux-wireless+bounces-15741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBF19DA1B2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 06:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98675283CFC
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 05:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D31E364A9;
	Wed, 27 Nov 2024 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="v08nGajg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C828E8
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732685599; cv=none; b=XLeNUH9iGlC6MrEiMXwxfF1rmj+jTsg4jOk/buaJ8E03l2egIl7H3vkfMJYN+qx1zL5u5cGOMWpWzDsaqlkSBltZ+x+ppddVVWC/icCVrvByN72p27DDT5stjam+W9XPaCvEOWnHl5VjDTuNZ5WIsSMX7xPeh0NFZ2Q8AKUQcPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732685599; c=relaxed/simple;
	bh=uy7im+w2sB59HaX99wJQRveTaPILi+QkuJRGWfCbITQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EuyGPJkJ1hJo+VgkgunAS9RnCefq1972L92w0wHzvIvtWn8I9Iv6uAbFzRWUST9DVZDDUxcpfdd0bVpLUNgYe/bvEC4EYcPNVaV18eRTuH+GjFXGITOPPgVnj0i3on6u42WF16GftiOM0lcivJwMqRMmOHTk64lJj7afFlYwJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=v08nGajg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AR5WgwX62217047, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732685562; bh=uy7im+w2sB59HaX99wJQRveTaPILi+QkuJRGWfCbITQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=v08nGajg/cka2BXIKCS7RFyNwRKbIvR7vkiNqOy+6FrUQ3ZSgHSSNjNBSjUpHXBed
	 NGDrbFZjMXC5uanSS+Yb4O7PHvKxbTa2O47rkSqRHU1QETpahwndDSUd1WN1lPI5aw
	 W863MN2GZMgmbh20kjazg9cLZe27CLKc+6MbPsdZCB/cZP/OjIiaVSzC2U3NjqZrD7
	 75wPoSQE04g+QlN89ugKkovHb9g1Qk0TLA+xGcZGi0FQvyIgu5yGo+7bfUtADSZeCG
	 /Gq3QozY9s+X9hptrBg9XUg43UU8WXH3sT2blDym0XpUiWgcmPEEnG4NWr9ulKCwLq
	 osEFRSK6hQjfQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AR5WgwX62217047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 13:32:42 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 13:32:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Nov 2024 13:32:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 27 Nov 2024 13:32:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH 1/4] wifi: rtlwifi: remove unused check_buddy_priv
Thread-Topic: [PATCH 1/4] wifi: rtlwifi: remove unused check_buddy_priv
Thread-Index: AQHbPQPtg4JS5AzMC0aqYevBv6s7ebLKoTYw
Date: Wed, 27 Nov 2024 05:32:41 +0000
Message-ID: <65b5fa04242744bc93e26a137f1fbe58@realtek.com>
References: <20241122172718.465539-1-cascardo@igalia.com>
 <20241122172718.465539-2-cascardo@igalia.com>
In-Reply-To: <20241122172718.465539-2-cascardo@igalia.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> Commit 2461c7d60f9f ("rtlwifi: Update header file") introduced a global
> list of private data structures.
>=20
> Later on, commit 26634c4b1868 ("rtlwifi Modify existing bits to match
> vendor version 2013.02.07") started adding the private data to that list =
at
> probe time and added a hook, check_buddy_priv to find the private data fr=
om
> a similar device.
>=20
> However, that function was never used.
>=20
> Besides, though there is a lock for that list, it is never used. And when
> the probe fails, the private data is never removed from the list. This
> would cause a second probe to access freed memory.
>=20
> Remove the unused hook, structures and members, which will prevent the
> potential race condition on the list and its corruption during a second
> probe when probe fails.
>=20
> Fixes: 26634c4b1868 ("rtlwifi Modify existing bits to match vendor versio=
n 2013.02.07")

This is a cleanup patch, so I don't think we need a strong Fixes tag.=20



