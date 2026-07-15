Return-Path: <linux-wireless+bounces-39136-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WnoMAHRQV2p5JAEAu9opvQ
	(envelope-from <linux-wireless+bounces-39136-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 11:18:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA24F75C5E1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 11:18:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=boH+e22f;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39136-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39136-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E51B1301AED1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7812741D627;
	Wed, 15 Jul 2026 09:16:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717441D4D4;
	Wed, 15 Jul 2026 09:16:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106978; cv=none; b=qZ//N8EaQiDAxQieVtnfeWZMClwlX9Cz9vgot3HJbtEH58ylboNi3OTnYcIQHU9c72E+T4bNUn6UR32SNtCoDF+9uylyfR+5B9K+s8wIeXV+zEsngvTDBBGGEija4wHnjjttFXpYsWxOb6GHLe/3bQM3oRno26ly7jeXpB2UGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106978; c=relaxed/simple;
	bh=yPC3C4swHscMzHlQfJXkzjHARANzt45RWUIUYKAA7IE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JrVfyyz8AKR8ktQ+KNtuQKgc5WCO9q7v1yqd/vMSCm3trTmTe0tJyVkDgXg7ux3h+1C/cq3LNoB9lbJkpkbnRoGEFM1iLiaNflbOLHWv+d7gQAjFsi03uT5jujL5QbXOz9F8ZfpfiAcdAUZ/3ZOSGDWAA+2Dr8wi7QtiguX9Zi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=boH+e22f; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66F9G9hD42825203, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784106969; bh=yPC3C4swHscMzHlQfJXkzjHARANzt45RWUIUYKAA7IE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=boH+e22fwPqpzmZ5ZiV4EgHWkCbwT5nDFf2oHu4nibVPKHbJnvz51cTzlzQczDZIK
	 cs6t3OtE/ujc8HilmalQCI5InQymPlNp2B1RdBJRRHDY6t8qeVdmGAwNPrhAYahFAD
	 t8nPbBiOB2QwNxs4JYuDHhFBcCN7/ljDxP3vwhjfCb2WWKlAMqF1kvdnx7cOWCo6fI
	 C/UQuyzdYb7vpEcy3UvAKtmTeY9ZZUbwalaRY8MepJHE14/SktNape+fJEwwlAEoz/
	 E0TpOhlg0q7gF1qDMjchdeWx1cblnKnLksSAKZpV+thmikO1fuaLEgIGmSb31/5w+5
	 +pteE1Cs5AbQQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66F9G9hD42825203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 17:16:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Jul 2026 17:16:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 15 Jul 2026 17:16:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8852au: Add support for Mercusys MA72XH
Thread-Topic: [PATCH] wifi: rtw89: 8852au: Add support for Mercusys MA72XH
Thread-Index: AQHdEBhgIKLF4XCqRUOEqFLTRQ13TLZpIRHAgAUzM4A=
Date: Wed, 15 Jul 2026 09:16:09 +0000
Message-ID: <8fb9ced500144618b7f43e54c12a25ff@realtek.com>
References: <20260710030055.57438-1-abhishektamboli9@gmail.com>
 <9bfdb983981d4bb98a4692ac6f1711f6@realtek.com>
In-Reply-To: <9bfdb983981d4bb98a4692ac6f1711f6@realtek.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39136-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:abhishektamboli9@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:mid,realtek.com:email,realtek.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA24F75C5E1

Ping-Ke Shih <pkshih@realtek.com> wrote:
> Abhishek Tamboli <abhishektamboli9@gmail.com> wrote:
> > Add the ID 2c4e:0124 to the rtw_8852au_id_table to
> > support the Mercusys MA72XH usb adapter.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221738
>=20
> Not sure why I have no permission to access this. Maybe it gets broken.
> I'll wait a while to see if people will fix it.

I seems that my Windows desktop can't access this link, but
Ubuntu is fine. I have not idea why.=20

Anyway, the reporter is still not confirmed if this patch works.
Can you post the update here when getting acked?

Ping-Ke


