Return-Path: <linux-wireless+bounces-11233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677FC94D723
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 21:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C360BB229A5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6A415921B;
	Fri,  9 Aug 2024 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=aegrel.ee header.i=@aegrel.ee header.b="KBztrJJE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from aegrel.ee (mail.aegrel.ee [51.195.117.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75E156228
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.195.117.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231258; cv=none; b=mux9s2Lj3BuB21JaQBHr8y8k4/tg+sVb0MKtaAfPAw77YLmKhWj7iQ2sewfawFazdF36Ot1/CIlOpaTBywhZ7Nd9B2VBT7LTw4lCb8MzCDUga9RaLd7CepvdDfRC29tnXoVJu37e0YnOZyyl5SqUsdWAXrZbDMaii2xgbKoPERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231258; c=relaxed/simple;
	bh=iDDdqHqmIeQdQTZ1k14UHO58t1Xk1mbnit4grBLKdlU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SjoozH7AcayxZueUwefCgM0j1ACtTm6iuKDdKRDKAET2cx2fAnqRxS5UC3QXj9ChrILfHSg2HdCAguaBlGwdm7YYQLH+KYyCIrzjp3iPvdABIZE2t7mYDc7d5N98hWFwJlwapTA25UAaeZxuAg1olpFJW7XuOUGqH2nQ7iR0psw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aegrel.ee; spf=pass smtp.mailfrom=aegrel.ee; dkim=permerror (0-bit key) header.d=aegrel.ee header.i=@aegrel.ee header.b=KBztrJJE; arc=none smtp.client-ip=51.195.117.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aegrel.ee
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aegrel.ee
DKIM-Signature: v=1; a=ed25519-sha256; s=default; d=aegrel.ee; c=relaxed/relaxed; r=y;
	h=Content-Type:Subject:From:To:Content-Language:User-Agent:MIME-Version
	:Date:Message-ID:Sender:Expires:Content-Type; t=1723231252; x=1725823252; bh=i
	DDdqHqmIeQdQTZ1k14UHO58t1Xk1mbnit4grBLKdlU=; b=KBztrJJE/swILXeCn8idVs7s2SjG
	bOG0TJ9r96dDPipIrfjh0uyNrcSHYUoeBzL6I1sTLkZJ6pyBO90HASJJAg==;
Message-ID: <1670e04b-9d61-4778-9d7d-e0d1c2ebb5f8@aegrel.ee>
Date: Fri, 9 Aug 2024 22:20:52 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
From: =?UTF-8?Q?Taavi_Eom=C3=A4e?= <taaviw@aegrel.ee>
Subject: [PATCH] iw: scan: Improved handling of Country String environment
 values
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

VGhlIHRoaXJkIG9jdGV0IGluIENvdW50cnkgU3RyaW5nIChkb3QxMUNvdW50cnlTdHJpbmcp
IGNhbiBiZSBhIHJlZmVyZW5jZQ0KdG8gb25lIG9mIHRoZSB0YWJsZXMgZGVmaW5lZCBpbiBJ
RUVFIDgwMi4xMSBBbm5leCBFLiBUaGUgaGV4YWRlY2ltYWwgdmFsdWUNCmRpcmVjdGx5IGNv
cnJlc3BvbmRzIHRvIGEgdGFibGUgd2l0aCB0aGUgc2FtZSBudW1iZXIuDQoNCkFsc28gYWRk
ZWQgaGFuZGxpbmcgZm9yIG5vbi1jb3VudHJ5IGVudGl0eSBhbmQgaGV4YWRlY2ltYWwgcHJp
bnRvdXQgb2YgYWxsDQp2YWx1ZXMgZm9yIGVuaGFuY2VkIGNsYXJpdHkuDQoNClNpZ25lZC1v
ZmYtYnk6IFRhYXZpIEVvbcOkZSA8dGFhdml3QGFlZ3JlbC5lZT4NCg0KLS0tDQogwqBzY2Fu
LmMgfCAxOCArKysrKysrKysrKysrKysrLS0NCiDCoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc2Nhbi5jIGIvc2Nh
bi5jDQppbmRleCBmYWY0MDZkLi44NTc5OGI4IDEwMDY0NA0KLS0tIGEvc2Nhbi5jDQorKysg
Yi9zY2FuLmMNCkBAIC02NjEsMTAgKzY2MSwyNCBAQCBzdGF0aWMgY29uc3QgY2hhciAqY291
bnRyeV9lbnZfc3RyKGNoYXIgZW52aXJvbm1lbnQpDQogwqDCoMKgwqAgwqDCoMKgIHJldHVy
biAiSW5kb29yIG9ubHkiOw0KIMKgwqDCoMKgIGNhc2UgJ08nOg0KIMKgwqDCoMKgIMKgwqDC
oCByZXR1cm4gIk91dGRvb3Igb25seSI7DQorwqDCoMKgIGNhc2UgJ1gnOg0KK8KgwqDCoCDC
oMKgwqAgcmV0dXJuICJOb24tY291bnRyeSI7DQogwqDCoMKgwqAgY2FzZSAnICc6DQogwqDC
oMKgwqAgwqDCoMKgIHJldHVybiAiSW5kb29yL091dGRvb3IiOw0KK8KgwqDCoCBjYXNlIDB4
MDE6DQorwqDCoMKgIMKgwqDCoCByZXR1cm4gIk9wZXJhdGluZyBjbGFzc2VzIHRhYmxlIEUt
MSAoVW5pdGVkIFN0YXRlcykiOw0KK8KgwqDCoCBjYXNlIDB4MDI6DQorwqDCoMKgIMKgwqDC
oCByZXR1cm4gIk9wZXJhdGluZyBjbGFzc2VzIHRhYmxlIEUtMiAoRXVyb3BlKSI7DQorwqDC
oMKgIGNhc2UgMHgwMzoNCivCoMKgwqAgwqDCoMKgIHJldHVybiAiT3BlcmF0aW5nIGNsYXNz
ZXMgdGFibGUgRS0zIChKYXBhbikiOw0KK8KgwqDCoCBjYXNlIDB4MDQ6DQorwqDCoMKgIMKg
wqDCoCByZXR1cm4gIk9wZXJhdGluZyBjbGFzc2VzIHRhYmxlIEUtNCAoR2xvYmFsKSI7DQor
wqDCoMKgIGNhc2UgMHgwNToNCivCoMKgwqAgwqDCoMKgIHJldHVybiAiT3BlcmF0aW5nIGNs
YXNzZXMgdGFibGUgRS01IChTMUcpIjsNCivCoMKgwqAgY2FzZSAweDA2Og0KK8KgwqDCoCDC
oMKgwqAgcmV0dXJuICJPcGVyYXRpbmcgY2xhc3NlcyB0YWJsZSBFLTYgKENoaW5hKSI7DQog
wqDCoMKgwqAgZGVmYXVsdDoNCi3CoMKgwqAgwqDCoMKgIHJldHVybiAiYm9ndXMiOw0KK8Kg
wqDCoCDCoMKgwqAgcmV0dXJuICJCb2d1cyI7DQogwqDCoMKgwqAgfQ0KIMKgfQ0KDQpAQCAt
NjczLDcgKzY4Nyw3IEBAIHN0YXRpYyB2b2lkIHByaW50X2NvdW50cnkoY29uc3QgdWludDhf
dCB0eXBlLCANCnVpbnQ4X3QgbGVuLCBjb25zdCB1aW50OF90ICpkYXRhLA0KIMKgew0KIMKg
wqDCoMKgIHByaW50ZigiICUuKnMiLCAyLCBkYXRhKTsNCg0KLcKgwqDCoCBwcmludGYoIlx0
RW52aXJvbm1lbnQ6ICVzXG4iLCBjb3VudHJ5X2Vudl9zdHIoZGF0YVsyXSkpOw0KK8KgwqDC
oCBwcmludGYoIlx0RW52aXJvbm1lbnQ6ICVzICglIy4yeClcbiIsIGNvdW50cnlfZW52X3N0
cihkYXRhWzJdKSwgDQpkYXRhWzJdKTsNCg0KIMKgwqDCoMKgIGRhdGEgKz0gMzsNCiDCoMKg
wqDCoCBsZW4gLT0gMzsNCi0tIA0KMi40MC4xDQoNCg0K

