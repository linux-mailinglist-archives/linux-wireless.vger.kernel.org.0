Return-Path: <linux-wireless+bounces-19680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C06A4B6DA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 04:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C09816C867
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 03:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F3B1C3BE9;
	Mon,  3 Mar 2025 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Bf8BRCmo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8B7DA6D
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740973495; cv=none; b=iliePlW2pMG4bjYca3DeNVAA8Dln+fQCKHKafjxk7v2OfWa+TTVIuzoduYHW+NrRu3U9kDBJ2aQlda2VkaVSMNxlfDN9cjneFbM/TP3+Z6SLKYvU8C+1M+8vcr9TIDgEV2IdDp44HHNHex+UMRQYIjXRaPBBgBsqVzte/bxIz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740973495; c=relaxed/simple;
	bh=DDhZRF6TCeVlWcRprtlVRsnDdF4kFmyedJEvQc+xFrQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TuEcM5sKUnuSVRBjpc3c1Ef4yXoSK4RlSXJ4MmyfjXjIaewV1m/a5HOANbu+pmyT1u4DCUOFtLwhNAkIrimgeA/RH2OXeLJh2aZKCiyZY6pghwK8wbPheV0tomxd0amLJobSRlD0MVGa4EBnsKEOOpXOyRdo7ttZvEMIea0yJww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Bf8BRCmo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5233imGF3556236, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740973488; bh=DDhZRF6TCeVlWcRprtlVRsnDdF4kFmyedJEvQc+xFrQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Bf8BRCmohxlco6fGHngZs+s90i0GR7/PE01IU1gp3T9QorE0gPtLibm+5kV50qnnV
	 PX5JoWqnOe7vQwYsOENbwxSzneaEYYXgRxGtLYkwg12DKiSs6F81ZjtwM63kB5YGIU
	 wqzNs6GvV/Hi496vhNGrdfCilgUCfpSo0s3aVvaWuYkKhceYvUh1f8RlWWXGHIW+e6
	 n735WnEMhJe8TcaOFBCckZcpit8Lo9UZl/zuP7w8oMz2T0Pur3qWkjWUmx6btEgd00
	 oqCEqYawlGxZXDAZ9UJf+g9OrTcxiWeaXZwcqWNa8vn1FssM5c7lNVBABYO2GPg2Hz
	 owD0YzAGxJyug==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5233imGF3556236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 11:44:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 11:44:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Mar 2025 11:44:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Mon, 3 Mar 2025 11:44:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 5/7] wifi: rtw88: Add rtw8814ae.c
Thread-Topic: [PATCH rtw-next 5/7] wifi: rtw88: Add rtw8814ae.c
Thread-Index: AQHbiLBo6z+CUSbiQk6pCD39SP7JybNgy70A
Date: Mon, 3 Mar 2025 03:44:48 +0000
Message-ID: <40a9400531004034b6360e9a4a103310@realtek.com>
References: <8e9d900e-0721-425c-8466-bd57742c9f86@gmail.com>
 <b1768755-1468-4ba6-8782-1017853525ec@gmail.com>
In-Reply-To: <b1768755-1468-4ba6-8782-1017853525ec@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IGlzIHRoZSBlbnRyeSBwb2ludCBmb3IgdGhlIG5ldyBtb2R1bGUgcnR3ODhfODgxNGFlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQoN
Cg==

