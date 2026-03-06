Return-Path: <linux-wireless+bounces-32620-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHfpIzahqmlLUgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32620-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:41:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0482121E19A
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 10:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 950BD300B861
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD4A345CC0;
	Fri,  6 Mar 2026 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cnM5KIvl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293CA345754;
	Fri,  6 Mar 2026 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789965; cv=none; b=WeXPFs7NRe8wcjhFyTKHx1/ZlATAais6+mgblhhZoylckWBZs+52jqDymQfjXVqQy36z13AeUOvcnXH6Q0HIHqd48sJbHhOA6LrdlKeZAyDKaDAWxm2z0APZZIur88OJU7+0s/DccqBIPf19SVjNn5yEFtau6UmRSDKM4VXTHI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789965; c=relaxed/simple;
	bh=GC4j5Z1MlMvA1X35MayiZsjaBJSH1xqQdU49XjEfXaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1Pq37dPid0OW4RTVQrSxoDSjTmpyJ7ZlDOX9ofPtyC5b7eABzMB0jY7edSlOOtg4QGxLCI3QQMdENFufTEtOXA7sc9kZyk8/vrXrXE4ddwnQmXMdsjCYqBoIB1U1wrpOwbNS9Pad2HznsZr5XTaQPdPiVHVJNk8HeL6pXVdxw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cnM5KIvl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6269aAdA53125422, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772789770; bh=ozseJMHqTsmobHL0f8bn7llWSwocImruoCga+B/PiPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cnM5KIvlfBppXMrD/s3zf7To2hm5CSWmbA21szG4/l7XlKEONjREuumtZDjAf5TQO
	 +dNm60iKIZOZ6XI1baBIqqr6SRl7fr0Z/TQ7yU9kFWZfNTXoxaGvwKrgHUQ2fRXw5b
	 AO3A78upRJglvTLUQu+ovRa+f6Fs+riaRIJKaPbcU2Ym4jXvvVD/OQ4QI7xBRkcfp2
	 WW6jvoL9NYAaxFchBrirz6u7epr0Ofsps6tZBCx5LbrbU91Kjhx1623lB/kM5HD+oI
	 s4l64hH2XRmaTmYrEI7OPCiIcWDN0OrqOvoH4ODv+uNTJZ1MaUFTxmj9R76S5xdgcR
	 7PeCoE/rrQ25w==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6269aAdA53125422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 17:36:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 6 Mar 2026 17:36:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 6 Mar 2026 17:36:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johan Hovold <johan@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Brian
 Norris" <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Ryder
 Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Sean
 Wang" <sean.wang@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>, "Stanislaw
 Gruszka" <stf_xl@wp.pl>,
        Hin-Tak Leung <hintak.leung@gmail.com>,
        Jes Sorensen
	<Jes.Sorensen@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea
	<claudiu.beznea@tuxon.dev>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "libertas-dev@lists.infradead.org" <libertas-dev@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 00/13] wifi: drop redundant USB device references
Thread-Topic: [PATCH 00/13] wifi: drop redundant USB device references
Thread-Index: AQHcrJBJgpW9edckl0WtWY+w5y49ArWgtZSA///saICAAJSWcP//gy6AgACGTiA=
Date: Fri, 6 Mar 2026 09:36:10 +0000
Message-ID: <75b11eb58542437f975067f5ca64fc20@realtek.com>
References: <20260305110713.17725-1-johan@kernel.org>
 <0c75afbbe7bb419cab648f94191fe47f@realtek.com>
 <aaqL0RdwEjWWjECk@hovoldconsulting.com>
 <81935da1c67a493c8313d906244dd577@realtek.com>
 <aaqfwRTJVswShHSW@hovoldconsulting.com>
In-Reply-To: <aaqfwRTJVswShHSW@hovoldconsulting.com>
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
X-Rspamd-Queue-Id: 0482121E19A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,dolcini.it,nbd.name,kernel.org,mediatek.com,wp.pl,gmail.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,lists.infradead.org,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-32620-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Johan Hovold <johan@kernel.org> wrote:
> On Fri, Mar 06, 2026 at 09:04:22AM +0000, Ping-Ke Shih wrote:
> > Johan Hovold <johan@kernel.org> wrote:
>=20
> > > Sure, I can include rtw88 (and ath10k and ath6kl) in a v2.
> >
> > Can you please also include rtw89? (I saw you have sent v2 though)
>=20
> Ah, sorry about that. I was sure I had grepped for usb_get_dev in
> wireless before sending v2 but apparently I did not.
>=20
> I just sent a separate follow-up for rtw89 here:
>=20
>         https://lore.kernel.org/r/20260306093206.21081-1-johan@kernel.org

Got it & thank you. :)

Ping-Ke


