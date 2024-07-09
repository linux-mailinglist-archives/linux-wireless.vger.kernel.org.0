Return-Path: <linux-wireless+bounces-10092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DDD92ADCC
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 03:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144D9282B7F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 01:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788092A1CA;
	Tue,  9 Jul 2024 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="AiYQhnAt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC752837D;
	Tue,  9 Jul 2024 01:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720488396; cv=none; b=WKkOjVEOXpIgx6uckA61dUdf5+Sjo5vEDqohcMzpxkb9RTvP7XXj3GxX7NxhyNAg+i8+kNWFZPxlg1chjyPOW4DpyYSMZGWIlHwDRUywL5iITuWqjfOufnC0d7snMd56MxKqIT+2X4NX4quJ1xBM4RXcofPdEY1gQj0F4ILpjjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720488396; c=relaxed/simple;
	bh=qERHNcKbstqAcRbVW+v/YJtKKuREWAK3ipEl1PmahdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oddAHSXeAE1UjEVW/kKpOGUcogjo2y1OhUKm5bYjYGY3jr17edZsBNX0OuQVngdGD+beGw+5N7FAMw0w1blqtBtD4KN2Ldr8A5bX82y1xHdbdRxUOvm2KRDyvekfMx/6iv0pdpFPIzhAE+/lEiCtXQ/yLYLtyPiD20JTDxqXBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=AiYQhnAt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4691QPMp8104837, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720488385; bh=qERHNcKbstqAcRbVW+v/YJtKKuREWAK3ipEl1PmahdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AiYQhnAtLpqHOpAa5UnW+o7YWt4JklnpHee84o+R23qZLxnSHPZSlQdfDpG+f8ver
	 f3MqdzW1NZhXzwETUTqSanlJLa1YZOPQ3Y0M6VtztsZWIHt2nlZvfMvEUy2xko1C5P
	 jBgLRXQEHYBCj3gxO1uUtk3p+VjOGAA1YjBJwWbVTxOC7FlvC1SflYiM5/6ulcpxxn
	 YxxX8BogT3Vt85pTyq3HaTHdTChk4tvgKyXUVtsZWkcnpuSeVCz93htdVOLKELUXGB
	 YidXhoJTrURIVhKHHoDNF6DCccNdqrARC0k6TxiEc4lTouYqEqYH48u23+LQ5yTAL7
	 Cp6NiaNDxxYbg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4691QPMp8104837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 09:26:25 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 09:26:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jul 2024 09:26:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 9 Jul 2024 09:26:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Forty Five <mathewegeorge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bernie Huang
	<phhuang@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Topic: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Index: AQHa0VQl1ZM9p1UVPU2+rvQ8T/H4+rHtmRKw
Date: Tue, 9 Jul 2024 01:26:24 +0000
Message-ID: <6673a2dc01a941f5900da7393d160005@realtek.com>
References: <draft-87msmrdgkb.fsf@gmail.com> <87h6czdexm.fsf@gmail.com>
In-Reply-To: <87h6czdexm.fsf@gmail.com>
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

Forty Five <mathewegeorge@gmail.com> wrote:
>=20
> > I'll get to work on the bisection, and send the log here when it's
> > done.
>=20
> Just to confirm - I should apply [1], and no other patches, during the
> bisection, right?
>=20
> [1] https://lore.kernel.org/linux-wireless/20240517013350.11278-1-pkshih@=
realtek.com/

Right. Only apply [1] in every bisection step.=20

Thanks for the exp #1 and #2. The results are in expectation. Then the new
bisection will find out another problem.=20


