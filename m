Return-Path: <linux-wireless+bounces-36738-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHjNAVRYDmpG+AUAu9opvQ
	(envelope-from <linux-wireless+bounces-36738-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 02:56:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 630A759D710
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 02:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BABC301BCFF
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 00:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F5622D4C3;
	Thu, 21 May 2026 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nFdDED1D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9C242D9D
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324811; cv=none; b=CBDxAABbmYMpQ9ITz4eo2tihBZLdMQlxP589ce+rZZL3W2pw6dfMxqggXm+wVoS+yH70OON20GvB8/9qh2mbkJ9TMuSfjItWXxIf1eHYcSnzpSuxEgQQ/r6lLMh4vti8a1QEAC4jeGKCprWYUBtvtIpRhF8s5jqRH0vnSmBbxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324811; c=relaxed/simple;
	bh=4zZ+Lgof8afu3xhN4cu2YBKmWf9U1eBdTrRqXjfRoBc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QLJGX/u/Zz/fgV+7QBNvmYjw8uqfhCrXbkLs2mosBuaWCJ/HMByYf9n7LQlU5oKvI5p8+BFnT+RIuCVv7oJ4yclSg80ltkeC1xQTWJCHVWZLKB6F8r6GJVzXAVaCmPph0tmS26b45/9CQFvkfa5T8ipx460Kiuwaiy32QIqVbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nFdDED1D; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64L0rQLd9756469, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779324806; bh=4zZ+Lgof8afu3xhN4cu2YBKmWf9U1eBdTrRqXjfRoBc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nFdDED1DhYVPwon5vLBhy0AQB/r3zSCbencZ3/g78kJxlIsT4ofPSqky0P9q6c+6D
	 QQUSi0vrwuccf0VINmAwIZpH6fJ83t9yXMkcPLdk1IRP1NtTNBMc0Cc3nGjOi6xOZw
	 02u9AGZk5n5Y9fwrY0zPBvyocraVVdD36QMIqGsQ1GjC9n8CPorimMlXFKDfF+ZB+j
	 QdrwouLQ0QuWPTMciVgg/7ukKSSNpfQ+9l5V1BFNIFBgsom0uUHvNQ2uMvsMKHx2/x
	 Mo+ZEyhRW5tLLLkRF/EcipqizYEoNWTS0bsRsKOAEb4O2xj0YBlmSLF25a3n/PEqCv
	 H2ZS0ekIQjCwg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64L0rQLd9756469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 08:53:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 May 2026 08:53:27 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 21 May 2026 08:53:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v4] wifi: rtw89: usb: Support switching to USB 3
 mode
Thread-Topic: [PATCH rtw-next v4] wifi: rtw89: usb: Support switching to USB 3
 mode
Thread-Index: AQHc6GcxGvBwPoT3MUCUGnsR7zvqXbYXp3EQ
Date: Thu, 21 May 2026 00:53:27 +0000
Message-ID: <78e7cc967057497f98578f03e7ab62b7@realtek.com>
References: <e955451c-93a1-4d04-8024-d224a04f1d4a@gmail.com>
In-Reply-To: <e955451c-93a1-4d04-8024-d224a04f1d4a@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36738-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Queue-Id: 630A759D710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
UmVhbHRlayB3aWZpIDYvNyBkZXZpY2VzIHdoaWNoIHN1cHBvcnQgVVNCIDMgYXJlIHdlaXJkOiB3
aGVuIGZpcnN0DQo+IHBsdWdnZWQgaW4sIHRoZXkgcHJldGVuZCB0byBiZSBVU0IgMi4gVGhlIGRy
aXZlciBuZWVkcyB0byBzZW5kIHNvbWUNCj4gY29tbWFuZHMgdG8gdGhlIGRldmljZSwgd2hpY2gg
bWFrZSBpdCBkaXNhcHBlYXIgYW5kIGNvbWUgYmFjayBhcyBhDQo+IFVTQiAzIGRldmljZS4NCj4g
DQo+IEltcGxlbWVudCB0aGUgcmVxdWlyZWQgY29tbWFuZHMgaW4gcnR3ODkuDQo+IA0KPiBBZGQg
YSBuZXcgZnVuY3Rpb24gcnR3ODlfdXNiX3dyaXRlMzJfcXVpZXQoKSB0byBhdm9pZCB0aGUgd2Fy
bmluZ3MNCj4gd2hlbiB3cml0aW5nIHRvIFJfe0FYLEJFfV9QQURfQ1RSTDIuIEV2ZW4gdGhvdWdo
IHRoZSB3cml0ZSBzdWNjZWVkcywNCj4gdXNiX2NvbnRyb2xfbXNnKCkgcmV0dXJucyAtRVBST1RP
LCBwcm9iYWJseSBiZWNhdXNlIHRoZSBVU0IgZGV2aWNlDQo+IGRpc2FwcGVhcnMgaW1tZWRpYXRl
bHkuIFRoaXMgcmVzdWx0cyBpbiBzb21lIGNvbmZ1c2luZyB3YXJuaW5ncyBpbg0KPiB0aGUga2Vy
bmVsIGxvZy4NCj4gDQo+IFdoZW4gYSBVU0IgMyBkZXZpY2UgaXMgcGx1Z2dlZCBpbnRvIGEgVVNC
IDIgcG9ydCwgcnR3ODkgd2lsbCB0cnkgdG8NCj4gc3dpdGNoIGl0IHRvIFVTQiAzIG1vZGUgb25s
eSBvbmNlLiBUaGUgZGV2aWNlIHdpbGwgZGlzYXBwZWFyIGFuZCBjb21lDQo+IGJhY2sgc3RpbGwg
aW4gVVNCIDIgbW9kZSwgb2YgY291cnNlLg0KPiANCj4gVGVzdGVkIHdpdGggUlRMODgzMkFVLCBS
VEw4ODMyQlUsIFJUTDg4MzJDVSwgYW5kIFJUTDg5MTJBVS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTog
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0K

