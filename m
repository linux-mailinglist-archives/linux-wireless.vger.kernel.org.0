Return-Path: <linux-wireless+bounces-33274-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB/fMKmZt2nmTQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33274-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:48:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29380294DAB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB573014558
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 05:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F34233722;
	Mon, 16 Mar 2026 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="En2/2W0s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDF78F4A;
	Mon, 16 Mar 2026 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773640082; cv=none; b=DQdbYXVpNeLBca01ne5AmDup8JA4QyIjSDklUDDrk9uWT3dhq1m4StmgIbCr6awqDywi0Y5d8T6vzRhWk2dbC9v9rXiUbz+UCY8WAURE8lE4MG7C7oEl3oAVeWFOaKi0vHFo6uze9e3H4h1ES0YG2u/XeDhYoCV0+TVm0rK2FQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773640082; c=relaxed/simple;
	bh=72NMu9OnPAhOcZr0rq1E3ekaucBQBJHJh2VH3yQ3CKc=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=mlblUyEDtv50yYIc/1fxsgCcUz2p4iSBDHQYHKH5d3ia4FmwGu9kdAeXqFB+Wda7b535+ozgeBs0G05bAJwoISauUYRB7X9wObj9al9xOiLhPg1lchbxOpgVHHjAJB0Zh5fMFfSQ9FsRh6gtf7pmCR8lUn27vKvRucL3TzK9jbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=En2/2W0s; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G5ljP331319711, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773640065; bh=72NMu9OnPAhOcZr0rq1E3ekaucBQBJHJh2VH3yQ3CKc=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Message-ID:Date;
	b=En2/2W0sFxlAM87zHkQ0b+tXLjE1MzMak1H4TAL7mRINyWAwwmbzUauL8QOXIH02O
	 tbsEWIbgf291FwZZXv4T6wtGzNuSehRxSeyNzD/DvGE1AXRxx58PQWlFdubWKWBKTL
	 460xyCyLxQW+BFpTxvTx0OIH1wu1adi9IUfItjueMFt3kcFk9tta91Z8tadDJqDCJ9
	 gH5NDfMb+jBp1jzQxRTDzKsnwKVP0BdoVx5Cp7qzqkP/hzISMdzXymBmFchTpGgXKX
	 9l5aq8VNO5jxMUTIxWF9CXbtuag0FXy5FGKb5VedZ/crtMviKJtPyNTcLzwCHo7Nij
	 D8PmtBIyGcvIA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G5ljP331319711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 13:47:45 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 13:47:45 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 16 Mar 2026 13:47:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Jes Sorensen
	<Jes.Sorensen@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Subject: Re: [PATCH] wifi: rtl8xxxu: Mark RTL8188ETV (0bda:0179) as tested
In-Reply-To: <20260303-rtl8xxx-tested-v1-1-291a38a6ff2f@posteo.net>
References: <20260303-rtl8xxx-tested-v1-1-291a38a6ff2f@posteo.net>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Message-ID: <795832f3-2af1-4208-adc6-9c5d20e1a104@RTKEXHMBS05.realtek.com.tw>
Date: Mon, 16 Mar 2026 13:47:40 +0800
X-Spamd-Result: default: False [-0.56 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33274-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[posteo.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,posteo.net:email,RTKEXHMBS05.realtek.com.tw:mid]
X-Rspamd-Queue-Id: 29380294DAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PT91dGYtOD9xP0o9MkVfTmV1c2NoPUMzPUE0ZmVyPz0gPGoubmVAcG9zdGVvLm5ldD4gd3JvdGU6
Cgo+IEZyb206ICJKLiBOZXVzY2jDpGZlciIgPGoubmVAcG9zdGVvLm5ldD4KPiAKPiBUaGlzIFdp
RmkgY2hpcCBhcHBlYXJzIGluIHRoZSAiVENVIEZlcm5zZWhmZWUgMy4wIiBzZXQtdG9wIGJveC4K
PiBJIGhhdmUgdGVzdGVkIHRoYXQgaXQgd29ya3MgaW4gV1BBMi1QU0stQ0NNUCBjbGllbnQgbW9k
ZS4KPiAKPiBDYzogSmVzLlNvcmVuc2VuQGdtYWlsLmNvbQo+IFNpZ25lZC1vZmYtYnk6IEouIE5l
dXNjaMOkZmVyIDxqLm5lQHBvc3Rlby5uZXQ+CgoxIHBhdGNoKGVzKSBhcHBsaWVkIHRvIHJ0dy1u
ZXh0IGJyYW5jaCBvZiBydHcuZ2l0LCB0aGFua3MuCgoyYTU4NWIyZWZiNDggd2lmaTogcnRsOHh4
eHU6IE1hcmsgUlRMODE4OEVUViAoMGJkYTowMTc5KSBhcyB0ZXN0ZWQKCi0tLQpodHRwczovL2dp
dGh1Yi5jb20vcGtzaGloL3J0dy5naXQKCg==

