Return-Path: <linux-wireless+bounces-22186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158C4AA034C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 08:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEF63BC62A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D92144DE;
	Tue, 29 Apr 2025 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eIMPohmB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100A13EFF3;
	Tue, 29 Apr 2025 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745908050; cv=none; b=r0PPP0U3y/P7Hm5VoJcNhbVcDx92PvsCEzNLLh61yjR1r9BdtgOCajkgNN5nT7dxc7dYaZ2A1JYDV9DBprIMmSW7I3U2GsfZ5s3C+M1ZfPzrol7cmGx72NPrqrRh8ZDouN5NXWaPxyOoYgu0RI/gHjN89+Dvsb+0e7qD/5K6qFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745908050; c=relaxed/simple;
	bh=/0E5wy0bgujjyET/mJT/jbsihDiWoBYfqZqRzpG9jQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hr7p/kGDzg2gsYEjHvegxglLusIL2p8KlHklj0bTkeWD/kXhA0oWZXZhN9SYIhPD2eFwGh57Prf2ESPw2MNqt2Nbvqpe620xegkd9WAFpD3usRrPT71VqHUGIlxGeIim3Mxlsff9em/dR7ceUiupAnTmV4RI/d4aHTLZhzqkKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eIMPohmB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53T6RPFl8227802, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745908045; bh=/0E5wy0bgujjyET/mJT/jbsihDiWoBYfqZqRzpG9jQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=eIMPohmB1YKPDkNtJUVx5l7SaQ9L0RFSR8YdhWUOtDpp41Xz55jdK4Oa1ZCB9iotx
	 AUe7zXu1ZYp5nyb639rqeGx9I95ry3H0o5MD7aCU2UMS/DZ6j449wg5Oc5WnvRQZ1l
	 KtXnHPuHed1noO9ILtMSo4p6xRmLTXsL+5iZ0z/FByqknEa2fh/451IxBe1/BjNsOu
	 WlDdAfb+Txsz9HaTUJSnSY6UUY2kw6zosYVBv8NZpkNd0BeSO+BMSvtv7LCZXTiSWo
	 Af9UOdXUXc6pQhzv46Y9/7k/U1WQacZJh+Ed6NR9IIfdYdmsukxXC+2bnGFAZRjqyT
	 yg32IrpsJYjKQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53T6RPFl8227802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 14:27:25 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Apr 2025 14:27:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 29 Apr 2025 14:27:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 29 Apr 2025 14:27:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] wifi: rtw89: Convert rtw89_core_set_supported_band to use devm_*
Thread-Topic: [PATCH v2 1/2] wifi: rtw89: Convert
 rtw89_core_set_supported_band to use devm_*
Thread-Index: AQHbuK10QCJtHwjOEEKbHrw7c8gWBrO6LOgQ
Date: Tue, 29 Apr 2025 06:27:24 +0000
Message-ID: <971098de9a374ca2b31b77446b9b939a@realtek.com>
References: <20250429022046.1656056-1-megi@xff.cz>
 <20250429022046.1656056-2-megi@xff.cz>
In-Reply-To: <20250429022046.1656056-2-megi@xff.cz>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ond=F8ej Jirman <megi@xff.cz> wrote:
>=20
> The code can be simplified by using device managed memory
> allocations. Simplify it.
>=20
> Signed-off-by: Ondrej Jirman <megi@xff.cz>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

By the way, currently we work with NIPA in linux-wireless community [1].
Please specify rtw-next tree, when you send patch for Realtek WiFi driver
next time. i.e. "[PATCH rtw-next]"

[1] https://patchwork.kernel.org/project/linux-wireless/patch/2025042902204=
6.1656056-2-megi@xff.cz/


