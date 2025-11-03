Return-Path: <linux-wireless+bounces-28474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3973CC29BE4
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 01:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4FE54ECE9A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 00:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302F1B0439;
	Mon,  3 Nov 2025 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ShGYLM6e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A721B0F19
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130935; cv=none; b=Wgi1SGLMnkbBYTb+Rhuqavx9Upsbkv3Wf6eGc3l+cBLlf9Hjfm4Jn2X28A9ATp+vxiHNotYoD4/GmlY3EREVwziPhshAWhRpQau0MwozSHDY5Wh6jDVHpmGT8mObAg6SpSa145/SfCHvXp/FS4vecPGJqk5GRjxMqpjTLFSemQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130935; c=relaxed/simple;
	bh=2D008PBwNmOVmog+EbzDuvN3Fdgt/aneUgh0OKErqBQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WxO9TYXvmUGS0llM/T72g/zdVKAuIR8LmjBYnBXMA14JxJZ1Rd3ZvPcZ2g/TjV6UMxJ3Lg2t7sENewngcwR2ihzBye5AMTKzTuOYgKPOupROtIaDLmkdvCjy471ErTHHc/sqGu02xaS9hbH0xXaH3CfyO3q7XMOkMOoVZwBAlaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ShGYLM6e; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A30mlhO7494879, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762130927; bh=2D008PBwNmOVmog+EbzDuvN3Fdgt/aneUgh0OKErqBQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ShGYLM6eQOfF+YvOACzmNTn5EtxgU7Duo7HVRknbJY+VcglKhvBa2TIVAdwklruzF
	 mysHy10R2ONeRdZ3oy+OB7S73882ZVNes9KtM8vBHQrWNyLVeLJxFVKqQwbah1PB4a
	 AZypiSDafV0BwBC7UfsxZs3HoTQ5KpBXe1Ens7V6C6xxqDs+Zvf3QUpkZrKP23FDCb
	 vcshXxZjKkHH+x81YI+SP0DQDnN6ABD5KDOlBrdeXI00XgGf/9BbSYKIdJMdKpQB8G
	 2SCOtVVX22VA7amHtCErue0aRfhBT6TywFZSTWyS1Hatz6xx3ntTq4G++Ouxmzft2N
	 t4nAZCjiXaVLg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A30mlhO7494879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 08:48:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 08:48:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 3 Nov 2025 08:48:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v4 09/12] wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
Thread-Topic: [PATCH rtw-next v4 09/12] wifi: rtw89: Add
 rtw8852c_hfc_param_ini_usb
Thread-Index: AQHcS2V3lijERMmFjk2HRS0bLVcyOrTgIE0Q
Date: Mon, 3 Nov 2025 00:48:47 +0000
Message-ID: <d6e34f1122d24f25b3801c3a22b250e4@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
 <5b90204c-60ad-4579-b241-b7ac2e1fee91@gmail.com>
In-Reply-To: <5b90204c-60ad-4579-b241-b7ac2e1fee91@gmail.com>
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
bnRyb2wiLg0KPiBUaGVzZSBhcmUgc29tZSBwYXJhbWV0ZXJzIG5lZWRlZCBmb3IgUlRMODg1MkNV
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4N
Cg0KDQo=

