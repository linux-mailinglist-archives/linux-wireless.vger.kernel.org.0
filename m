Return-Path: <linux-wireless+bounces-28121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B15BF4A70
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 07:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 432454E7015
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 05:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419AE23D28C;
	Tue, 21 Oct 2025 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="t/I+VyMD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB621DE2B4;
	Tue, 21 Oct 2025 05:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761025174; cv=none; b=LgkswBVEiW4rQWvCAuwrt5R/HQKh75htzmMHQ2aMlrDcMxC3pV3SbNxOWL1zxtgwq4MOcmOZ6lwkDw0tikv1cm3LR5oMTsORDftqXgbDHCrFc/ejCddeH/n8CxagGbprR+djFy6aQkNej4etJrGr/HSQPyakWGuAsWG2auGpplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761025174; c=relaxed/simple;
	bh=cjRHQNrimilRSaOgbS0Q6HnXr8qOt5kl4nozO1ryvW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fj0dsV3WxxxCeVb3DVrIIjKVKVotywhLRoih4uBbPlbHawcsm3UEhOD2hqaHvf/TqSHteNPa2eAPoYllUUH3ZgbmDr8ITudxTLXdgyyjPEk1Ds5VOPDWsVZySiWM9Iw4o+2t+EQgFiRAA4ABRajlzBc+oBgm/Qa7QR/XNANI3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=t/I+VyMD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59L5dR2J12487462, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761025167; bh=cjRHQNrimilRSaOgbS0Q6HnXr8qOt5kl4nozO1ryvW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=t/I+VyMDqSRJ1MHL3JzJOH1T3Pgpmzh+V3lzvPTsC7krWNk4a1J2WghsK9d9Quiwv
	 EKNCvSsiMjl+Q/J4aOFWteRWCeD/b7bsd7GM5O+ln+HUvd+hjlfp5rirYRftOLHgug
	 lIHL00dx1hfaGsff5dW0VGWWbhmz84ES3SCtgZdM5DDym7VbiawsbjPXFcRuK8Y9eq
	 ylGEsEZan0DKUC4luXcAVBNB0txx/lR9R4Ce2RnCtlMLrLl95UoMeJeFRy1KAnYY3m
	 /c3jeSHXRbpdLa8K+yXvpjOqK4okMtYvNdNe0pQYrPQ0EzgBOxsAh3bpAyRyVQvzHL
	 zFBDW3Fjc+Dpw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59L5dR2J12487462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 13:39:27 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 13:39:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 13:39:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 21 Oct 2025 13:39:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Add USB ID 2001:3329 for D-Link AC13U rev. A1
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Add USB ID 2001:3329 for D-Link
 AC13U rev. A1
Thread-Index: AQHcMPU5hCUM159tz0WqTXkJwzs92rTMOCeA
Date: Tue, 21 Oct 2025 05:39:27 +0000
Message-ID: <c9a3af8155d848aa8812c97d699c11f9@realtek.com>
References: <20250929035719.6172-1-zenmchen@gmail.com>
 <20250929035719.6172-2-zenmchen@gmail.com>
In-Reply-To: <20250929035719.6172-2-zenmchen@gmail.com>
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

> Add USB ID 2001:3329 for D-Link AC13U rev. A1 which is a RTL8812CU-based
> Wi-Fi adapter.
>
> Compile tested only.
>
> Cc: stable@vger.kernel.org # 6.6.x
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

b377dcd9a286 wifi: rtw88: Add USB ID 2001:3329 for D-Link AC13U rev. A1

---
https://github.com/pkshih/rtw.git


