Return-Path: <linux-wireless+bounces-28475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD5BC29C02
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 01:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A207E3AB98D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 00:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E2E1C5486;
	Mon,  3 Nov 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dULsPH7G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642715667D;
	Mon,  3 Nov 2025 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131513; cv=none; b=nA8tPVwuntbS1o25RVsmJPSqj0CJD1fs1CeOzgxf7uVmwbJoQ+8L++AvoG1ryGFqz26847Z1QfnOoIOA/+qfZy15vcC3cQ6kZBVB9EvF20VEBopzASBWiAUBG6bsNYsLXGHPDYm1JSV3xRxs8n79KfdOjwFUKFbIjXCJLwe9ZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131513; c=relaxed/simple;
	bh=DcIZuvtWamJgq1M0SFlnga3RWDWy13H+3LoOBawxlfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fpnQs3KolNkjS5B+OXk7vTC2FSet0uBjIAvx8vIWBeg3M/4D8a/6Eqgqkyh3v8tDndvKgX1OALZ7kXkeqdOouYgcJ49rUNKLYiY4BQEV+hoILQ8QhTAL99crD5h4uye2MnboJ85cnkSPqoYBcqbGi3FA3ycrdzfVO+XXTJHoqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dULsPH7G; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A30wR6w9503065, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762131507; bh=DcIZuvtWamJgq1M0SFlnga3RWDWy13H+3LoOBawxlfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dULsPH7G4CDTeN1OFkneNhAVKbf+9uLrzAMu14IESnxZMqXELgqvbqBjBIHbZUd+l
	 5TKX/da4WDZ1fOCoLEDsfCtJ9im+y1QOpHOD7PAV0pim22ZLVmoY96EGG+mVSKpAKt
	 JDv3Ihd0IMcNd0QInHxXYu5vEKVGjgXwM/Q5W2A8oFp2UGmDZUfCfoOyGxWfEKRb8y
	 zUiwhcYNaJkFPoK5ib75aw/0tUVmp78PVnQlDvQrGZz2oaE1QEu4KjOIlATNLW5iUH
	 EN503qw9dTsrcqYgfSZZ4xlUv20JShzckF2isOmuZYlrQPC2CHd8Kvp/hCE1FZtAGn
	 novDA/jtbUlxQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A30wR6w9503065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 08:58:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 08:58:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 08:58:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 3 Nov 2025 08:58:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Hiroaki Yamamoto <hrak1529@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: Add BUFFALO WI-U3-866DHP to the USB ID list
Thread-Topic: [PATCH] wifi: rtw88: Add BUFFALO WI-U3-866DHP to the USB ID list
Thread-Index: AQHcSlf+NF9i1h33aEmU2hLd97pve7TgJSJQ
Date: Mon, 3 Nov 2025 00:58:27 +0000
Message-ID: <9b1dbc341cbf4571adfc4ae08f13a39a@realtek.com>
References: <20251031111641.33653-1-hrak1529@gmail.com>
In-Reply-To: <20251031111641.33653-1-hrak1529@gmail.com>
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

Hiroaki Yamamoto <hrak1529@gmail.com> wrote:
> BUFFALO WI-U3-866DHP (0411:03d0) is based on rtl8812bu. I locally tested
> this patch with a retail sample and it worked fine.
>=20
> Signed-off-by: Hiroaki Yamamoto <hrak1529@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


