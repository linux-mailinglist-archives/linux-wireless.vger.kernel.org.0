Return-Path: <linux-wireless+bounces-26983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56B7B42E32
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 02:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692153A6251
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 00:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A34A27470;
	Thu,  4 Sep 2025 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="f5gZKS9I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C769476
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945756; cv=none; b=C2jIlWAFprJuAsronf6dKTstTko3owMWXkP2/AXjL2pFFM23C5Fe61A1Czue7ywobnWrRkGcMBpMuumuUpPwuVrruyz2Wl3M9eXtjqnf7Rtaog5fD2vJtxX8zWyCVETOM6KOdiP1PVuoZ1cdyXXDQaWilvk+oUlCnXV5kAAwYI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945756; c=relaxed/simple;
	bh=j6ghhByX+Xtm6Ftj71AnArC3QcEFM9cQDd0m4aTlLmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBeaXLLmksg2n/0w/M7xmHBhGkRGMLgJS3mPelcntznPP2COwC+JGYuPh2Ir3PcRcLF65lhf88tEPA8xgHPLOMC4xWToTzg18VmN/o/VGQjJJj0+t6LT8diQk2C7IHnaSAUT9edj/BQ4rN8oDqfe2FsbZ7Qfz0Fu44XGww8m+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=f5gZKS9I; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5840T8B002918868, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756945748; bh=j6ghhByX+Xtm6Ftj71AnArC3QcEFM9cQDd0m4aTlLmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=f5gZKS9IHjdNRNdaMuJ5lXdyaGOpqCaQlp9ZlkB59ZidNu3EdG9UwPp95FazHjwLp
	 IUdkrqVewPEGA976RzbirQgvxvF2iwC/o5me1U76zyhQsU6foGoV8WacRbHwdT3rhX
	 JNIcz1VOMdCs0ucoq82V3RqNzguywa3ZfWuflOc/2/V30H0d85H95gYQ5PqkVuNE8P
	 9tFumJMu+heXrT2FDe7s5GXWarputDeXr6HefSdsKPe9BGxb4yO0OVDOiDEqGtoeA4
	 NclyRTbQBoxtkAyq/XgqmGfDKQMM3xuFHlrG8IgwtmCdqKZm1F1ICMYD7nXwaoIye1
	 FRUCPXNcM0kKA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5840T8B002918868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 08:29:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 4 Sep 2025 08:29:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 4 Sep 2025 08:29:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 4 Sep 2025 08:29:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "usbwifi2024@gmail.com" <usbwifi2024@gmail.com>
Subject: RE: [PATCH rtw-next] wifi: rtw89: Add USB ID 2001:3327 for D-Link AX18U rev. A1
Thread-Topic: [PATCH rtw-next] wifi: rtw89: Add USB ID 2001:3327 for D-Link
 AX18U rev. A1
Thread-Index: AQHcHSJz5gJTCERxykawLmSVSNJq4LSCK33A
Date: Thu, 4 Sep 2025 00:29:08 +0000
Message-ID: <27ef8843ce1e4204b1e73da7a399bbc7@realtek.com>
References: <20250903223100.3031-1-zenmchen@gmail.com>
In-Reply-To: <20250903223100.3031-1-zenmchen@gmail.com>
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

Zenm Chen <zenmchen@gmail.com> wrote:
> Add USB ID 2001:3327 for D-Link AX18U rev. A1 which is a RTL8832BU-based
> Wi-Fi adapter.
>=20
> Link: https://github.com/morrownr/rtw89/pull/17
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



