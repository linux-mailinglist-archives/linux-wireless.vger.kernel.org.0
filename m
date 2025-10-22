Return-Path: <linux-wireless+bounces-28172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3063DBFB1DB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 11:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB171898A05
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB2C27A46A;
	Wed, 22 Oct 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="s9GU55Lc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082BE30EF84;
	Wed, 22 Oct 2025 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124632; cv=none; b=RVF3JGSzODSRJjCSUEN6NGkOpCMsVTozPbEoH/qndV7j2zd7rqu6zMhXHNAnmvU4UXAIggzwpTCD10qmGGo6GFdf/V3i7Q6rR8N9wmSHUtI8E1/ONiSlD2yzevMdcWKZsQdn/lDuySqAR0osfjgygSzj3sQeHz4r6su/MEdBtOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124632; c=relaxed/simple;
	bh=xGz92sZd9owiqeq2wwVPdHMaKmiDtAU0dL8ZyyOp4qE=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=Ll91Dn1IAHY5u0tiYLveecUvnyXoasgV96FEehIAaYWodf3wBmN/cnmh2tUh8yF9x92DELSnp2+EL6QtVpAZmrzaI2AempIbiMAT+GlL7Hkdb8P1Gpz+igGaIKZzJ+vD4N87lTM4nLibN3MIWK1AMMZBAFWam5rSz8tx3P4tfqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=s9GU55Lc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59M9GrvR6384837, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761124613; bh=xGz92sZd9owiqeq2wwVPdHMaKmiDtAU0dL8ZyyOp4qE=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=s9GU55LcRexK4p5ktdzHFPilPz8fg/+2jwNR8RzxX0PvTKllnlky4nwiNAUNHDmOW
	 lm0pQfrH6xRhvToaFhsT5Y6u6YtGHezVu0wWQEK4B06Gtu86zq4aqu/jIOSoR5wcbf
	 OJLD2O25+U5p5OVk12BSMFIhU6s995PLZTrZuoMFt53BBp3U0/K8B3uMi3kH/UtF04
	 Xruc7LI33zPThqk1MIwfPnv2/h0MIvY5Fve9wePhtm2Vk95BD6VCGMYF66cpsKbd0h
	 IIexLCzm363UH9EKP2PRbmuAImjrDgsMK7qSyn/Zgob05f762PPL+FGsST1el0sUN0
	 8Cb6ENqIuVbcg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59M9GrvR6384837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 17:16:53 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 22 Oct 2025 17:16:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 22 Oct 2025 17:16:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 22 Oct 2025 17:16:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v3 7/9] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Topic: [PATCH rtw-next v3 7/9] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Index: AQHcP03+N98C+NXP40OStTAnFiNodrTNutGwgAAvBeA=
Date: Wed, 22 Oct 2025 09:16:52 +0000
Message-ID: <3aa77693afa44a9aabb4a385d65f55f4@realtek.com>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
 <20251017100658.66581-8-pchelkin@ispras.ru> 
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

Ping-Ke Shih <pkshih@realtek.com> wrote:
>=20
> Also, all are dropped, can't we just call ieee80211_purge_tx_queue()?
>=20

Please ignore this comment. Since you want to complete wait, then
rtw89_tx_wait_list_clear() can delete wait marked as completed from list.



