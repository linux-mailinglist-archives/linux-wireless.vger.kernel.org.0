Return-Path: <linux-wireless+bounces-29071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C86BC670BC
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 03:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0ACA6289B0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 02:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC8B3148A4;
	Tue, 18 Nov 2025 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZG17blvj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409482F39AB
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433886; cv=none; b=V361bbcwFrs1yaRrmWl38oqgddc0JfiT+hRQmqhZlOi+drVkGpuC+rmHVH50GpcXFg/BdEbJjgzVzVLvUBgfTXESdbyEJ5V3MO2H0ENtN+md8mYzlZrvVfT6cXQSELwpfDdd53iFFMyqEhZzoJBOubsn3t72UetRCpTS3xgsApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433886; c=relaxed/simple;
	bh=fHoc9WTVRGNrQ3qwbXcc6Cwr9gqX5RrGOdtd64Mg5NU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dJbjifgioKy4UKZmHDpb8G+BKuqKlq//7Er36OeBVHpsdKa3RYExm4AI9Wy+IgZPVKKuZrhtWpp5SqH240GhV1bxS+oEwl6VUn6vzLlhzo+cfMEUB63+rhl4vq9qhUIeG3axV3GJb8FsWgTAWJN4XI5AACjQ3QpFJhaB/6xzdA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZG17blvj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI2ifTtB661041, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763433881; bh=fHoc9WTVRGNrQ3qwbXcc6Cwr9gqX5RrGOdtd64Mg5NU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZG17blvjtsXDM5LCvpj3r27XWZWP/eGWEzEmo+3NO47yDL8m1MqP5fsVZsd2NzSuV
	 a1CX+ZBaPIzLoHB4TAawHtdoUErxRb8oYXrCaIQqMBPfhg0TsHZ17IUULWgLp0b4Wp
	 NVPVfmjR3xzLSfgIwhb6T+L7lfMRdjYuMem5HhjDorZj3E/3gG4RPmILLlZNVDcSWl
	 C9rJqRz0Aeu6ycok/36EeymVYU4j9Z8e6HRQJkCkXDCyjoFI/4erB//x2lha8HAdC0
	 iF4//Vv0BcRW3eBG7oPeOeDe6UGIyX41xWSXpr2LzJIljtd8GPUBZyrRiiHrTkUJSY
	 +Fz1HMucTZlpA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI2ifTtB661041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:44:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:44:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 18 Nov 2025 10:44:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next 1/5] wifi: rtl8xxxu: Fix HT40 channel config for
 RTL8192CU, RTL8723AU
Thread-Topic: [PATCH rtw-next 1/5] wifi: rtl8xxxu: Fix HT40 channel config for
 RTL8192CU, RTL8723AU
Thread-Index: AQHcVzdlBBVdq3to4EGmLkiiRx+BjrT3vA1A
Date: Tue, 18 Nov 2025 02:44:41 +0000
Message-ID: <b4551d52d3b24637a64251c19ddc7a89@realtek.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
 <8bad19ac-f649-4949-a407-b727e043c6b6@gmail.com>
In-Reply-To: <8bad19ac-f649-4949-a407-b727e043c6b6@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBGbGlw
IHRoZSByZXNwb25zZSByYXRlIHN1YmNoYW5uZWwuIEl0IHdhcyBiYWNrd2FyZHMsIGNhdXNpbmcg
bG93DQo+IHNwZWVkcyB3aGVuIHVzaW5nIDQwIE1IeiBjaGFubmVsIHdpZHRoLiAiaXcgZGV2IC4u
LiBzdGF0aW9uIGR1bXAiDQo+IHNob3dlZCBhIGxvdyBSWCByYXRlLCAxMU0gb3IgbGVzcy4NCj4g
DQo+IEFsc28gZml4IHRoZSBjaGFubmVsIHdpZHRoIGZpZWxkIG9mIFJGNjA1Ml9SRUdfTU9ERV9B
Ry4NCj4gDQo+IFRlc3RlZCBvbmx5IHdpdGggUlRMODE5MkNVLCBidXQgdGhlc2Ugc2V0dGluZ3Mg
YXJlIGlkZW50aWNhbCBmb3INCj4gUlRMODcyM0FVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0
dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

