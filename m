Return-Path: <linux-wireless+bounces-31352-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCYPCmFcfGkYMAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31352-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 08:23:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB792B7E28
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 08:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBE49302F68B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 07:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B130CDBE;
	Fri, 30 Jan 2026 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jygHZcf4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E820309F18;
	Fri, 30 Jan 2026 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757768; cv=none; b=huUCgmQ50T700dDLMpa/TNlga5/gCeCfTuOrR60hdM7y7rId9hpS73NCt+hUcTolHl5YLulYUsq3LdotcNkDLwYE4PwNfFCcJ+Udfi8MvBWQWUo2EftSSyzBCMDcB+sYCSJwU7AXA986s5gdCjhOoYgXyfC0a+CbfJ1H09E+cug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757768; c=relaxed/simple;
	bh=6QtMk8jxlwojN7fIGb53M3iTqjZIsQCNY8JeUpJ8jgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hYDe09tEBV6IVOYS2pmHFThX41Fql//+qtTH5pN5ZWNEi40nYR7xInmOSfngR3ke9p4ahHPSB9qS1XdNSL25LYiqAExZd8yUmrewxBGkE3NOXGcKE3i02ZiOMQRJ+Pwp9KS/5CTWvIreR8g1nYLbQGhz1R04LQslHlAAsll+fj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jygHZcf4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60U7MUKL0493171, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769757750; bh=6QtMk8jxlwojN7fIGb53M3iTqjZIsQCNY8JeUpJ8jgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jygHZcf419S+6o2cPfA47uR9bKkYPORRZDBqVBU8W10rRoVsoqobtsMlEzBLo188T
	 0O8P7j/8nI7zn++ogBwgXsqzV9WbC5Q3ybL5Sogg9NlzK1xXZYc2vNVnR4ANqaIYUk
	 Zrf2rl8NLyaWlXVX/0CZoNRoeRlnt444KO1I9hogtegY0fbnZHvbO1ekotuWfRvJDP
	 SG9KjiLIFfrcOgngjVMD2bUtov/8LVi+E633r5Mh2VMETIRqsfkTZuDLXk8O5A6rvT
	 APoKhiRdbMFRpCqUcrd0wLU0y9Ev5huvLbLuphxp+xaIELu58Pmxt12YaeWv8vd7qh
	 pyhx7AQ0Rrveg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60U7MUKL0493171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 15:22:30 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 30 Jan 2026 15:22:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 30 Jan 2026 15:22:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 30 Jan 2026 15:22:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [GIT PULL] wireless-next-2026-01-29
Thread-Topic: [GIT PULL] wireless-next-2026-01-29
Thread-Index: AQHckQ6wwLzvQkLKtUm7oOrjBULmnrVoqVcAgACJlLmAARzkIA==
Date: Fri, 30 Jan 2026 07:22:30 +0000
Message-ID: <a3298543662a4ba68395a61d687b5e0f@realtek.com>
References: <20260129110136.176980-39-johannes@sipsolutions.net>
	 <b0d6887f-7946-46b6-986a-bf410b832d66@redhat.com>
	 (sfid-20260129_150854_647905_46B9C6EC)
 <f20c64ea4f4a2d3567ab707d98a5164457b02735.camel@sipsolutions.net>
In-Reply-To: <f20c64ea4f4a2d3567ab707d98a5164457b02735.camel@sipsolutions.net>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31352-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB792B7E28
X-Rspamd-Action: no action

SGkgSm9oYW5uZXMsDQo+IA0KPiBJIGp1c3QgZGlkIGEgMzItYml0IGJ1aWxkIG1hbnVhbGx5LCBh
bmQgb25seSBzZWUgc29tZSB3YXJuaW5ncyBsaWtlDQo+IHRoaXM6DQo+IGRyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODkvdXRpbC5jOjQzOjQ1OiB3YXJuaW5nOiBkZWNpbWFsDQo+IGNv
bnN0YW50IDIyMzg3MjExMzkgaXMgYmV0d2VlbiBMT05HX01BWCBhbmQgVUxPTkdfTUFYLiBGb3Ig
Qzk5IHRoYXQNCj4gbWVhbnMgbG9uZyBsb25nLCBDOTAgY29tcGlsZXJzIGFyZSB2ZXJ5IGxpa2Vs
eSB0byBwcm9kdWNlIHVuc2lnbmVkIGxvbmcNCj4gKGFuZCBhIHdhcm5pbmcpIGhlcmUNCg0KT3Vy
IGxvY2FsIDMyLWJpdCBidWlsZCBjYW4ndCBmaW5kIHRoaXMgd2FybmluZy4gQ291bGQgeW91IHNo
YXJlIC5jb25maWcNCnlvdSBhcmUgdXNpbmc/IA0KDQpQaW5nLUtlDQoNCg==

