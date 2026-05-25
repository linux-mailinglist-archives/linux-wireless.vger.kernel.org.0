Return-Path: <linux-wireless+bounces-36850-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /5L3ArqjE2q8EQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36850-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 03:19:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6A35C5284
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 03:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDEBC3006B6D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5190C2B9B7;
	Mon, 25 May 2026 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dc8xV26t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EDE249E5
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671991; cv=none; b=FB1YXemBGl6bZW//TCB+/ITZ916pdz9Izna3pD0G6EsAOa5z6w0bCyxEcPg+WjSLoSFYUo3f4uVHkEiFiorKtDy/ZqadCz1S4bdgyccjG7N1z5IgfVe4ZRJiS3twur7CgOvre8L17CDf2dVOzcGIyK4PvsYWLZXi6QtqqLX3i2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671991; c=relaxed/simple;
	bh=bOqJA/7hvcNPcgADC0XTtYW8bRHmv85YlD7PzyiphUM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NqirnYTox9Lf2KbNNDRYvrS9Q2KJLmFhXBfAhs+qy5hhWcxF2kVo7X2zFZ2EyEzxkwJkruhTXeh98HuSBY0ILkPYDz+I7bYlCz5AphJldiiDj1/OBUSJEfn2Rl3B9jj6HyA4k3ZuaCVEYOI9gup1OnuXpn5F1YQhggJfXF3tPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dc8xV26t; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P1Jir86566617, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779671984; bh=3i8G+lBGkaanBbJJHq2UECzGIJb5aDgUSxBXDEfpwSs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dc8xV26tY34BXecMyYU7wrPWnM4Qnr9eROwszV5/eZDTiCyCXikQxETpR/ehZ420t
	 x61NFu0LPPEK91HAQPb2AGR7eb0kjVbbqL1CCnPgj4nheVMK3gRR5RXFgPLKtejK9t
	 8ogLE6xbSz8X3xThMFiZe3Rq6MsnhaZedLxXR+7akB30ZE/3z9YAECjuHTFDUY10U8
	 LcgkNugmRWv1prOfVP3ZE94+zsYjAkAk5ZrvWiUqiz38+DlxSEWLRlX5/dhFQ2Erin
	 w2mDROSqbiX06fp0iidvQXI0KRu1M5EA6eELatcO1t76kP/IqE56DLrAWcz6H7h9iz
	 cIwYlJNHt2Kyg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P1Jir86566617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 09:19:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 09:19:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 25 May 2026 09:19:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Guillermo Servera Negre <guillem@gservera.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: wifi: rtw89: 8851bu: add Mercusys MA60XNB (2c4e:0128)
Thread-Topic: wifi: rtw89: 8851bu: add Mercusys MA60XNB (2c4e:0128)
Thread-Index: AQHc64mhTYG47q6qJky917WJ4trxYrYd8btw
Date: Mon, 25 May 2026 01:19:44 +0000
Message-ID: <c6af176e57de41b8bcfd4868a6057e00@realtek.com>
References: <418D5F85-B110-4CD2-B733-FEA8D4901EBB@gservera.com>
In-Reply-To: <418D5F85-B110-4CD2-B733-FEA8D4901EBB@gservera.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36850-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:mid,realtek.com:dkim,gservera.com:email]
X-Rspamd-Queue-Id: 4E6A35C5284
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guillermo Servera Negre <guillem@gservera.com> wrote:
>=20
>  { USB_DEVICE_AND_INTERFACE_INFO(0x2C4E, 0x0128, 0xff, 0xff, 0xff), .driv=
er_info =3D
> (kernel_ulong_t)&rtw89_8851bu_info },

I made a format patch [1] by this ID. Please check if it is expected.

[1] https://lore.kernel.org/linux-wireless/20260525011728.6836-1-pkshih@rea=
ltek.com/T/#u


