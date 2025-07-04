Return-Path: <linux-wireless+bounces-24812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CA0AF873C
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 07:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5034A3A488A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 05:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F91CD15;
	Fri,  4 Jul 2025 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VGB7EEib"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77111CA9
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751607087; cv=none; b=TLQx5NGLOsmuG2bC5LB/xAhb+sEPZ+4Bn6SqWn56R1vjUmWaoLE7l6p1NxTDSOvfY0Lkj1atSptRHTmOxjmJP0nIQqaMK+ygIMfWS96edhGSpi4h7Ww676LFqXYP0f4/qdBpPN3ANlOGXytSRYnf6gId1l6TFVUvdVA1Pp9w80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751607087; c=relaxed/simple;
	bh=0GZ01dLnrMzp+EQunmI317qogjDVTbep5iSgXKt3D2Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=deLXJ9dZ6IC1wFeET5SENWadU/7lj+0EW240fiIUhSQomBalkeEByTzPB8AMcC/Zx3sOSvs1n5CJe9FHpqMGRPW801e3B3+LY0IyO/mWYfoAbX/XQSLQJB0HQmlZcFmbXQSAkEK79I0zN7Xa75L+8+m31HafCeXu7Xm7PXKThrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VGB7EEib; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5645VLAx83797846, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751607081; bh=0GZ01dLnrMzp+EQunmI317qogjDVTbep5iSgXKt3D2Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VGB7EEibhvHPfdKLCQ66NXJWbp/wlJWqj2Um+IaRxs1lhDt6QGWbhQIX8i+nhaj0q
	 iGSe+9pWkpvVH6wAO9zktLHCde1riVh6fbiPqwyK5LZzJ2BUBWdSIx2aZzDtGgBemu
	 swx6gIokRqEHPbp0Z+85pdhNu12eQcXJHyyuB4qT4qu/KwX5dkxg1QW/owBdmF5sZ0
	 9lx7RE4CQUMkroI8YbsAJ8pGD9d0Ke/yfF006/9nTtx4ovV72CS6q80Rv+Y5im3tbo
	 JvyuX+EIsS/VzNI+msqRfxvkLJe7rgwse9TXVIcOGakJkVA+PfI4D17U77HmuXJYQ3
	 sgAmSWicE3vxQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5645VLAx83797846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 13:31:21 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Jul 2025 13:31:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 4 Jul 2025 13:31:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 4 Jul 2025 13:31:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 4/6] wifi: rtw89: 8852b: Add rtw8852b_hfc_param_ini_usb
Thread-Topic: [PATCH rtw-next 4/6] wifi: rtw89: 8852b: Add
 rtw8852b_hfc_param_ini_usb
Thread-Index: AQHb6qHTp3XLnpNjFkaqaKPkYNVXNbQhdIOw
Date: Fri, 4 Jul 2025 05:31:45 +0000
Message-ID: <50efd8ee5b694e32aaa1500f0a24e28b@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
 <fccb1b00-8c8f-43e3-afcc-6466ae25da6b@gmail.com>
In-Reply-To: <fccb1b00-8c8f-43e3-afcc-6466ae25da6b@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiAiaGZj
IiBtZWFucyAiaGNpIGZjIiB3aGljaCBpcyAiSG9zdCBDb250cm9sIEludGVyZmFjZSBGbG93IENv
bnRyb2wiLg0KPiBUaGVzZSBhcmUgc29tZSBwYXJhbWV0ZXJzIG5lZWRlZCBmb3IgUlRMODg1MkJV
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4N
Cg0KDQo=

