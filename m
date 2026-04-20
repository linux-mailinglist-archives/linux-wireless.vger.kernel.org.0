Return-Path: <linux-wireless+bounces-34990-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FDED3aB5WmZkgEAu9opvQ
	(envelope-from <linux-wireless+bounces-34990-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:29:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9252E42604C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06C1D300B9D3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 01:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A473257828;
	Mon, 20 Apr 2026 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="t0Q8a/wh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90A246782;
	Mon, 20 Apr 2026 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776648562; cv=none; b=SwgyXfpiljMVsM091gWS9A9XizTEn/EGJagDEXC3iw+V3InUQl6vp2RuAFd0EmMtnt59OqmJh2BslehOLsP5zpc++fPl0fmRkFApEYQKupEye6XxCK1x2FSTYbEAJskYQVCrnORKQ+pT92NEG9NHBozOZxJCENhbRRDBTOGor2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776648562; c=relaxed/simple;
	bh=9+Z/Vm7E4+weRUKFRTdATUJme8yCUzrAwn9U/m7rSvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+h0QJXmrJRmgcO8biwUXEsNmvS9AwjR5tGLDtiB/xFvVRYAIgKaH1oGvQIrSXYu/eFrvwiaFJWdiXIIJaRZgBchabdPik3WgTOlqCXznxsggPw8n48DaAeCjoZqyOcdvkY0l5zti13UV0fpXw/r/ZguzZpZoVulQWAXfT157Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=t0Q8a/wh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K1T9Bt8216492, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776648549; bh=9+Z/Vm7E4+weRUKFRTdATUJme8yCUzrAwn9U/m7rSvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=t0Q8a/whzBsFr0y8W5mAPwzE0wojb35C5aoG9UWygJZm+ecZ1i33LgZJ3M9aJmn6A
	 rFY2EgcMdQdTjJ2R4tvv1tKULPhmDWHm1dDlTLAg4DNsnQEHapXGbFDHJXfYwgWoIQ
	 VmDsGtalmcVtN2vJioP4JBBdH+OOVmnwcELqgCFE8LMFWpZLD8Kc7zLhLZlWsNf1Vw
	 boPXdRoiZ4O/LuU7b5eD/GdLlJ1nPKOc8c0920gdg4NAlhMWhWQxiz7QaYi/B47U7t
	 QZRvAJdl0NX7Ub6BU6WYUtCO52E4V9X6Fg9CWZFIBQfqKTlJDzj7r7f6zAGTKmWzKc
	 w9N63zVZLX4lg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K1T9Bt8216492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 09:29:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 09:29:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 20 Apr 2026 09:29:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>
CC: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 4/6] wifi: rtw88: Benefit from
 sdio_device_id::driver_data_ptr
Thread-Topic: [PATCH v1 4/6] wifi: rtw88: Benefit from
 sdio_device_id::driver_data_ptr
Thread-Index: AQHczmu35g1HrUmCcEqeFn3O1So0VrXnLTiA
Date: Mon, 20 Apr 2026 01:29:09 +0000
Message-ID: <603706ca09334395b9ff411ff4339018@realtek.com>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <eca8679e2145e698ed674e343ca357788c3d6de6.1776429984.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <eca8679e2145e698ed674e343ca357788c3d6de6.1776429984.git.u.kleine-koenig@baylibre.com>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34990-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9252E42604C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpVd2UgS2xlaW5lLUvDtm5pZyAoVGhlIENhcGFibGUgSHViKSA8dS5rbGVpbmUta29lbmlnQGJh
eWxpYnJlLmNvbT4gd3JvdGU6DQo+IFJlY2VudGx5IHN0cnVjdCBzZGlvX2RldmljZV9pZCBnYWlu
ZWQgYSBuZXcgbWVtYmVyIHRvIHN0b3JlIGEgcG9pbnRlciB0bw0KPiBkcml2ZXIgZGF0YS4gTWFr
ZSB1c2Ugb2YgdGhhdCB0byBnZXQgcmlkIG9mIGEgYnVuY2ggb2YgY2FzdHMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyAoVGhlIENhcGFibGUgSHViKSA8dS5rbGVpbmUt
a29lbmlnQGJheWxpYnJlLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPg0KDQo=

