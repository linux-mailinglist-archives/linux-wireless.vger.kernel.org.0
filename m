Return-Path: <linux-wireless+bounces-34148-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNg0DRTyyWkZ3gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34148-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:46:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAF63550F6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09B47300F9E2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB48299959;
	Mon, 30 Mar 2026 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="trxmeZE/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37042F5492
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774842383; cv=none; b=PfGzvZZ3Mk+cNuKp94Ti/BAijCzGqxtQYbnzPaj4Ew0NNncPC7uf4XEX2XHU4QTqlMdTs2cKSRBqPA5TB0dIPJlzv5MKSKvLhI1bKgg+NHQS7+cnPn5epZodhRNDgdRCFJy9xEJhZ+SpPaYON4M0vHPGNYCBbSadRl7kMXNxoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774842383; c=relaxed/simple;
	bh=Z1NhF+EPMyMFnecymNYGvXHUbiYu6UTwCtWGDH6db6o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeMYqz+UUQiMKA/K8pawrL8Ldtm5S4dN300umQGG/w/oWRMFrBcU+ds/5sq4FBNtOwmKzP2hD5v+Qd3AoIU8IbdbNS8xHNRYlIVD2YHOnF0wqgL+AwaA6wb7Dd1xBNMfyOLFYDA2Q3n6xe5UahWqdUsI+0+kE5zrcTqO9NRX764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=trxmeZE/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U3kGGB1271447, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774842376; bh=Z1NhF+EPMyMFnecymNYGvXHUbiYu6UTwCtWGDH6db6o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=trxmeZE/1AABtjTpr7+MlkE6FsklQhbVu1bUXaYWFwg3UndmvIc3nVXGlgKQpzN9Y
	 LAISLWbgRprmDAQ98Feq++KdNvVAyQE4pEBKAH3oeVzfcMAYYPtAV7Khgt4lY7vWw2
	 1aQCo63syOv7aHwxsyEdtFx7vmNDgy8E0Mt4+oUOnGwsGN+KzjP6I21n8oc+jDKzU7
	 yrVhZQ49Pc0EI3q244dlWJmCRwUFwK1WZAM41nu8XnpvFj/EtPGBjInVOnubVljJBy
	 SeYThCwM8aMrYlna9t/3VJb0QaxW/CoqK5VOVebrWy+XWk8WpnPdnt9eYGQ7dV0bQy
	 L2cahiK9GIkCw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U3kGGB1271447
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 11:46:16 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 11:46:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 30 Mar 2026 11:46:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 11:46:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 06/12] wifi: rtw89: usb: Enable RX aggregation
 for RTL8922AU
Thread-Topic: [PATCH rtw-next 06/12] wifi: rtw89: usb: Enable RX aggregation
 for RTL8922AU
Thread-Index: AQHcvULjH0ZHfgYXRUKSO7sKIr3WwbXGdBMg
Date: Mon, 30 Mar 2026 03:46:15 +0000
Message-ID: <5853e0d8036840b89080229ed1aa4deb@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <6d7440bc-d463-4d99-af12-181684b87bfa@gmail.com>
In-Reply-To: <6d7440bc-d463-4d99-af12-181684b87bfa@gmail.com>
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
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-34148-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7DAF63550F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBJdCB1
c2VzIHRoZSBzYW1lIHNldHRpbmdzIGFzIFJUTDg4NTJDVS4NCg0KVGhvdWdoIHRoZSB2YWx1ZXMg
YXJlIHRoZSBzYW1lLCBJJ2QgcHJlZmVyIGxpc3RpbmcgdGhlbSBpbmRpdmlkdWFsbHksIHNpbmNl
DQpuYW1pbmcgaXMgZGlmZmVyZW50IGluIHZlbmRvciBkcml2ZXIuDQoNCiNkZWZpbmUgUl9BWF9S
WEFHR18wX1YxIDB4NjAwMA0KI2RlZmluZSBSX0JFX1JYQUdHXzBfVjEgMHg2MDAwDQoNCkhvdyBh
Ym91dCB5b3U/IChJIGRvbid0IHN0cmljdGx5IHJlcXVlc3QgdG8gdGhpcyBjaGFuZ2UpDQoNCg==

