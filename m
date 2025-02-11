Return-Path: <linux-wireless+bounces-18738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD66EA30278
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 05:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743A63A7FB6
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 04:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3D1D5CFB;
	Tue, 11 Feb 2025 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fx4WT9Rc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F6130E58;
	Tue, 11 Feb 2025 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739247062; cv=none; b=ML6T/f5ErOrmvWkJFlyNJhAK/8xzpGxDT3aKMiEEHZCBv89ayhwMmlFKun3pJkAbC1WABMEPnH4Gjw/LEVyP2jLwKnPgBO1yY41J7JTs7oJLejMe+xZmmfW/7LsRonDKEzL0QN/IUnni+9uFUYa+TYaA/zDXu0Zg1YjCglZyliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739247062; c=relaxed/simple;
	bh=5EB8g/uOvyrDBMsmspqSzKjHK8EvUOY35tJ0BHhVOzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=st8vbFQCwZgi7xKKFCnBA3ySXSM5YRPujOCABFz8Mznpi4sRnXvChEUhbezls89XVBncAKMRsu4V8b4rHowAkIb84AP/zYCcLGmklQiZwN6WQq4W18xASR63zzp80t3FVsRLjNFdSG/BSnix9sTkNzsT8eCSh8jgp1uitlaEqeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fx4WT9Rc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51B49ujF63909179, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739246996; bh=5EB8g/uOvyrDBMsmspqSzKjHK8EvUOY35tJ0BHhVOzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fx4WT9RcvBvLOVkQrIkKpy1/oVNIqZoSUTJRFjJ92iEE6IY480+gPqX9CWK3vAkmk
	 fHQD+IN0QOzQbB1aPHWE8M12ds+H09JCchrLsb15H0MuF4dPGN6nML+ZYq87W1xjCN
	 LbEAMMKsW+ZILhAl/FizDuQ7hblxSQ7okOrdaWiFyawlmuFtxC5ifMmfU7Fbww63Sf
	 VCFl0iHKMXr2jhZiyDq1+zIVqvhAxCjX3dS5kXAvQ7NVLgoOTBNERYEzK74vUijcw7
	 WcuAQZr6RlrfdINzZKMkPkBZanKMQf4AuFqUM3TAtr/zJr4ParWVxyFlFSsJ05Jxw0
	 jpcqUk1RIaJHg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51B49ujF63909179
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 12:09:56 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Feb 2025 12:09:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 11 Feb 2025 12:09:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Tue, 11 Feb 2025 12:09:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>
CC: Kalle Valo <kvalo@kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Harshitha
 Prem" <quic_hprem@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] wifi: ath12k: Fix uninitialized variable and remove goto
Thread-Topic: [PATCH] wifi: ath12k: Fix uninitialized variable and remove goto
Thread-Index: AQHbe3V4G+SZHcbSkEu0HsYEXOLAqrNAxeaAgAAWcwCAAJ8zYA==
Date: Tue, 11 Feb 2025 04:09:56 +0000
Message-ID: <94ddba7eff9f4261bf8fa547f1ba4d7d@realtek.com>
References: <20250209-ath12k-uninit-v1-1-afc8005847be@ethancedwards.com>
 <a7ca4e4b-c432-4f2b-81c6-c7b06cd12de1@oss.qualcomm.com>
 <mmutvwbsr3h33hxr364zr6f3whmyxp73od3fihsbynek2pkvjd@6bqaqfkwkf4m>
In-Reply-To: <mmutvwbsr3h33hxr364zr6f3whmyxp73od3fihsbynek2pkvjd@6bqaqfkwkf4m>
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

> > >
> > > Addresses-Coverity-ID: 1642337 ("Uninitialized scalar variable")
> >
> > Is that an official kernel tag? IMO the proper tag would be
> So, it isn't "official" as far as I can tell, but it is widely used in
> other commits, especially by Gustavo Silva.
>=20
> Also:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?id=3D778e2478d19574508861bcb
> 1806d6e34d095587c
>=20
> Coverity-IDs: is another option I have found. I have seen Closes: a few
> times as well. I'm not really sure what the best option is, honestly.

In my patch, I used and treated Addresses-Coverity-ID as a unofficial tag,
so additional empty line is added.

Days ago I have received Coverity issues sent to mailing list, so I used
Closes tag at that time. But recently I have not seen that kind of mails.=20
Instead, I visit Coverity web site to check issues and use
Addresses-Coverity-ID tag, since Coverity link is not visible to everyone.
That is just my thought.=20



