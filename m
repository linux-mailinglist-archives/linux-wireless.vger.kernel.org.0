Return-Path: <linux-wireless+bounces-27838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D20BC00C6
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 04:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBAE3BD016
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 02:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21C21662E7;
	Tue,  7 Oct 2025 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MhAJLGcu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776A34BA3A;
	Tue,  7 Oct 2025 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759805692; cv=none; b=peRcYAZK1yZpiTVSdQevvmBbFdcdUObW1lfnX91RytyjePecaqEEGIJY++7z62KqH0wEuPg0aLkO86ou/C18+XNWm+ksr9j4EvUUbj1cjhy9KyHkg6+n+T03RpYiKUA7qURH/8eh/TpaJSuWSowvnlzYy2UoPeFvEYV9c87V6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759805692; c=relaxed/simple;
	bh=WcJXy/2FJ2h1H8JMNa6Dwt5GuKlmnshTmL15oQl7wjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I96AGtcPBsZPJzLh02zHHSlj/LLoVS2IAVSXY1A09rHKanIf46STu34tZjUty69UULn5LEB4cZRZt2nqazEHFDnY4OmIJzfgvwGx5nPch6u7rIWPH8QKyIu9M+9sY+MeH3fIdm0jl1dcE2K9XElF7MTq3FLumCsfmwNk9kkxJPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MhAJLGcu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5972sYHg93416320, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759805674; bh=LFm4O1fTLwWRWovV73MhrJLgzlPTFNPdGzXUNQeEKq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MhAJLGcuhZLtL8D3uv8ThdM/mxqKTstbtl2JP1pRhqo87EZuv9PPCMPhm2mTixDNV
	 mgDabBGTwmAQcgUPhz/PfZqgM+MAVRT/i3d28WEv9+emgKNrlqI/Cg75raAmhwIYNr
	 94K8h8SpeB79z/gYC9HhEBkw5Wa2SJF5lVFvzjQ2z3oLLoQA8mCXqCie0/qf8WpF3J
	 k1EG9LzMqudM4LSMSCWD2ZKz4Ty3LeLLMfqQjfZxLcsL2uah85o2wkgZL3ao4a37Vp
	 hqATDLLWPPMnI6bKcFOpwkvbPCY6xgGIsEB3e6HEXTlkB5zE30WHvSqZAPSjr4wT08
	 L5Qb4blteYpQQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5972sYHg93416320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 10:54:34 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 7 Oct 2025 10:54:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 7 Oct 2025 10:54:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 7 Oct 2025 10:54:34 +0800
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
Subject: RE: [PATCH rtw-next v2 4/7] wifi: rtw89: refine rtw89_core_tx_wait_complete()
Thread-Topic: [PATCH rtw-next v2 4/7] wifi: rtw89: refine
 rtw89_core_tx_wait_complete()
Thread-Index: AQHcM9iSxli3kaZlWUiko8DF/FrRYLS2A6GA
Date: Tue, 7 Oct 2025 02:54:34 +0000
Message-ID: <a26ecaf61a5d4c16aa7fb23b80cdaa79@realtek.com>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-5-pchelkin@ispras.ru>
In-Reply-To: <20251002200857.657747-5-pchelkin@ispras.ru>
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

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> Pass TX status value directly into rtw89_core_tx_wait_complete().  This
> will make it a bit in sync with further patches and will give flexibility
> in future work.  Also use scope based RCU locking which simplifies the
> code of the function.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



