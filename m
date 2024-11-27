Return-Path: <linux-wireless+bounces-15744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90209DA269
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 07:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED67285670
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 06:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C97FEC2;
	Wed, 27 Nov 2024 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="M9XfStWV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0965EF9DD
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689588; cv=none; b=QWz3UR/puLWHQqE7AuaentSBBeTtAq1WjrzLMRUpiwkrGfvm5WgRTnLQKrrivBYCovCk5DwgRrF2mierKbt9VjrJyeYZQfsLcfD9vWBiBNhqaXGfqtxTK9L8F8LEQaEIVOJejRtQq/u0INziWeaZk23WbXHwbPFwc4FLX1KmmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689588; c=relaxed/simple;
	bh=Sv6hO+fj/cQnzdd/HEXja/ZoCUhMYJd8RQOVZPlzQ14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bbzHhVVtTQU0g/+jWyQqnnBl4y1W+c+dQxg4oeKJEjW6vV++qVsVUWId2BZbuEXO92og+MC3zSFXg49Lx5PRvYSeD/u/oyOIL5CgEUBbc1UcjUohzZbP5diI6tD5eET/wcEGI/+LCHme2nL/SHKDzgIcM0yPIwuovn3qJt3zVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=M9XfStWV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AR6dPR212311882, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732689565; bh=Sv6hO+fj/cQnzdd/HEXja/ZoCUhMYJd8RQOVZPlzQ14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=M9XfStWVg5JDXZ7CB38UdpjJp4YwOlx0YohtKC5eE2KInSqmJ+cS0NvyfkGkHw2u7
	 yl9HGMzdbQguH27tajlQ/xJRsnkwFLX97DHDItk4MM5waqNfRkpOEpO6SFmQ5j0lIn
	 i2dyb6DO65MOBfNuUPr0U22hWQ1ycIjcp7BNRk1jMdPinDS7Fh6Lo87dwF227bZw5r
	 gi9y+GbwK+WbsJ2HLILYycn+pfSgeY6gP4lgmnroUlsLtwEbKpVXtBvUdAX6Bxsv0q
	 lfPYEsRnA9ZbonaPsG3xeIF6Vi1k9nAnUHniDV5SJ53szrlf41Vm+AaA3BWf/3T8cK
	 F473WgcSDL2OA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AR6dPR212311882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 14:39:25 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 14:39:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Nov 2024 14:39:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 27 Nov 2024 14:39:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "kernel-dev@igalia.com"
	<kernel-dev@igalia.com>
Subject: RE: [PATCH 4/4] wifi: rtlwifi: pci: wait for firmware loading before releasing memory
Thread-Topic: [PATCH 4/4] wifi: rtlwifi: pci: wait for firmware loading before
 releasing memory
Thread-Index: AQHbPQPxSLtonmvGgEuzFG38gMGsIrLKs/pg
Date: Wed, 27 Nov 2024 06:39:25 +0000
Message-ID: <7b7d0e46a6c545b79a076b98f7ebda7b@realtek.com>
References: <20241122172718.465539-1-cascardo@igalia.com>
 <20241122172718.465539-5-cascardo@igalia.com>
In-Reply-To: <20241122172718.465539-5-cascardo@igalia.com>
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
>=20
> At probe error path, the firmware loading work may have already been
> queued. In such a case, it will try to access memory allocated by the pro=
be
> function, which is about to be released. In such paths, wait for the
> firmware worker to finish before releasing memory.
>=20
> Fixes: 3d86b93064c7 ("rtlwifi: Fix PCI probe error path orphaned memory")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



