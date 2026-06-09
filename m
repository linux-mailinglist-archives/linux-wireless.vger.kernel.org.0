Return-Path: <linux-wireless+bounces-37546-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LegJG5pjJ2rZvgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37546-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 02:51:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE6265B6EA
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 02:51:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=iX7VOQNI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37546-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37546-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF6E23008228
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 00:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D378246783;
	Tue,  9 Jun 2026 00:44:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15724BD03;
	Tue,  9 Jun 2026 00:44:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965885; cv=none; b=EGdmkirnozNPHEgZms9J1XrR5MVLRFHGfqN8xG/nN847DuzZ2ByCfXVxxKL8dnMVQ8RvwciHLmDJ5+T46LI010wSAA1FnDiJ1bq80MKzDanx0rCCAd17Pu5r4htfh/fEhy3zpUbcnDlwog8ny426xLXAuLrx4JbADovxrBcuyO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965885; c=relaxed/simple;
	bh=OMOnNf67dhajL95LBndmKkwgnUOwdYU9XDWpBEw6ZcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHgPJarW5k3vZXvYM01ShNmNssKA9Jkxl7nFRXFsqv+BhEW5TN/ZH8J6xurdGhW+dCsAahTavmo6hYKIibUtj8di6MUytMTzNgf7wL7rygR94kLmyWGFRosS+f3T3pnc3aZUeDBQayRlPBR3Pbkek+s6RExDB/qByaqahMKRloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iX7VOQNI; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6590icYG34019531, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780965879; bh=OMOnNf67dhajL95LBndmKkwgnUOwdYU9XDWpBEw6ZcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iX7VOQNIAftuMlYCQBw19C8m7fxpsSsKsWbh49TCnOzVNOJO54NIzEHEAnQ9U7EBo
	 dXGAbuM1+3pofuGQfNbmUPbkvmI5JERhuYQs6f3UbI7J8+j/0U4ZlXIfsr68fJiOw+
	 9t0qlfRiKKsgsRMOfuBFHlZM+eUmrZI21RvtmPBfrAeMg/a7OMvZHALWt3vVf1E6hI
	 HzfSvLwewICm6e40v9voZ6k+LfuqZ4vSM3T+338pm6n5+5mLln1wU7742IUc9CsWGb
	 MTQpPpzBF88pbmAUHt78h/6t7sboo2ITnpihKsFqghX7EgpdvmDnRRQF6odPfa9/Rb
	 TbgJ4+WCieHUg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6590icYG34019531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jun 2026 08:44:38 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Jun 2026 08:44:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Jun 2026 08:44:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 9 Jun 2026 08:44:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dan Carpenter <error27@gmail.com>, Damon Chen <damon.chen@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] wifi: rtw89: debug: fix off by on in
 rtw89_ppdu_str()
Thread-Topic: [PATCH next] wifi: rtw89: debug: fix off by on in
 rtw89_ppdu_str()
Thread-Index: AQHc90NBELWPFUshn0eHlWtcYb9z6LY1Y0Tw
Date: Tue, 9 Jun 2026 00:44:38 +0000
Message-ID: <68c89cedd8d746c7b694a5ec98064d15@realtek.com>
References: <aia25i0ds3B6QF6c@stanley.mountain>
In-Reply-To: <aia25i0ds3B6QF6c@stanley.mountain>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37546-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	FORGED_RECIPIENTS(0.00)[m:error27@gmail.com,m:damon.chen@realtek.com,m:linux-wireless@vger.kernel.org,m:kernel-janitors@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:email,realtek.com:mid,realtek.com:from_mime];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAE6265B6EA

Dan Carpenter <error27@gmail.com> wrote:
> This > comparison should be >=3D to avoid an out of bounds access.
>=20
> Fixes: 419ed7f4a053 ("wifi: rtw89: debug: extend bb_info with TX status a=
nd PER")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Thanks for the finding.=20

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



