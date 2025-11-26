Return-Path: <linux-wireless+bounces-29347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB93C87998
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 01:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EEC74E1000
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 00:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D1F126C02;
	Wed, 26 Nov 2025 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FECXW7Ao"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B71C4C6C
	for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764117206; cv=none; b=NAHIhBuCwM2CEyuTb7SLoavUqj6khIOX8h9kuppajVQTTYZXY59d0brQNUgBN7QS31KwfEKIXKYQByIVqyOp5Z0M+QuHP98rgi3qUWCjQEROiLU7oOl35QdEEpRU+94HP0au2UqrtBtK4SssV63tLh70PAxBEOPcD9fX+lglTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764117206; c=relaxed/simple;
	bh=6O5m05lkaYhqjKapzty76TfNMbEbxXtNyx/3wxGfSPM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PKkS7bJjD7pVQn9nv4f5SmvL7vAqosEq3XCkpK6rnmXUsXrUqqrxZeTdRzJoOdHVZfSSerhf5AR9qGBFDQd0s1qfNdw43DqsOr05r1XRju1HsSEbK29NrTSILjSPeQfZwUc5ZegbOxxtKWRQd+V5uFVLSa3VMAWTie1QL+ld1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FECXW7Ao; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AQ0XI1G04012265, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764117198; bh=6O5m05lkaYhqjKapzty76TfNMbEbxXtNyx/3wxGfSPM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FECXW7AoDYPWY35ypvqmDL4vx9qJph8feNMgeJxJ6Oe5rhqQiOHZs7VKGXF+UNQoS
	 E6ZOSiQLsxqzTcgzLs8xFp0LVKDRlSKLcXONe9qwthYDywAOv+c5DOc+m6H4/ZSJUj
	 Rr1bZygGoJ/eFTzmv7MmO/UR1UTWQ6Hx7DN7aSJVx/RqMZCnBW/vzykfSTUgUw/byL
	 ipHB0pJJ7qEMbkPgQZK6ZvjCDG3ddCwgUz2/9Me/JclrCIB566QDoDxVuXbD7XaoGt
	 2OJdcRQ0ZpGj9xYTpRE3Wz6SGOAYp+N+MBSet/vwssyeLe8yuhErvRi+Pco7d4DF8o
	 RnfnGmiA1iKug==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AQ0XI1G04012265
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 08:33:18 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 26 Nov 2025 08:33:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 26 Nov 2025 08:33:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 26 Nov 2025 08:33:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Roman Peshkichev <roman.peshkichev@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: fix DTIM period handling when
 conf->dtim_period is zero
Thread-Topic: [PATCH] wifi: rtw88: fix DTIM period handling when
 conf->dtim_period is zero
Thread-Index: AQHcXjaq/wiUWQk7PEGNI5o8qokgALUEG/8w
Date: Wed, 26 Nov 2025 00:33:18 +0000
Message-ID: <8aec337d3e48428789db9497b2f42e0a@realtek.com>
References: <20251125180937.22977-1-roman.peshkichev@gmail.com>
In-Reply-To: <20251125180937.22977-1-roman.peshkichev@gmail.com>
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

Roman Peshkichev <roman.peshkichev@gmail.com> wrote:
> The function rtw_set_dtim_period() accepted an 'int' dtim_period paramete=
r,
> while mac80211 provides dtim_period as 'u8' in struct ieee80211_bss_conf.
> In IBSS (ad-hoc) mode mac80211 may set dtim_period to 0.
>=20
> The driver unconditionally wrote (dtim_period - 1) to REG_DTIM_COUNTER_RO=
OT,
> which resulted in 0xFF when dtim_period was 0. This caused delays in
> broadcast/multicast traffic processing and issues with ad-hoc operation.
>=20
> Convert the function parameter to u8 to match ieee80211_bss_conf and avoi=
d
> the underflow by writing 0 when dtim_period is 0.
>=20
> Link: https://github.com/lwfinger/rtw88/issues/406
> Signed-off-by: Roman Peshkichev <roman.peshkichev@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


