Return-Path: <linux-wireless+bounces-37824-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wVNpG09MMGohRAUAu9opvQ
	(envelope-from <linux-wireless+bounces-37824-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 21:02:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 766C7689587
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 21:02:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.com header.s=fm1 header.b=rlFSso0m;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="M boqqgz";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37824-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37824-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 446AA309D125
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDDD30B535;
	Mon, 15 Jun 2026 19:02:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090721D596;
	Mon, 15 Jun 2026 19:02:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550156; cv=none; b=V7lgWavNb025MPeu4R34Kr1uk21eM5uGuVTvNXLVXAPt8UFDAeP/8pj4sDugj7M+DNAQb3DA84G43aaVOkMX8vBQ/r1LmWAZjzTFUGrmuxJv8TjFhXSlVV8kIxk/0/nZ6lQWrE1KC67sWpxnJp9R9D4+8fuBRKtSEW0G8bHRmBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550156; c=relaxed/simple;
	bh=E2yLV8YrhL6qj5s8UvvSc3RGzPjW1bRM5vI3o/X2on0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NAdDcXQyqfxd+fxy5fgDFlu60D1VwwpksG2ILeD+/uN7sXF+ffP63kBiRYd3k7RZqPdJ1W6kJNYt24PfiJM+GHiHbOdi5l5tcLp4OBCDzkTqupjEonQriwaLkc9woAHQM6PwQESSJJVc6jCfTDRA54yD/B9ZvA+itXCE5OjwZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rlFSso0m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MboqqgzL; arc=none smtp.client-ip=202.12.124.152
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6321C7A016F;
	Mon, 15 Jun 2026 15:02:34 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-10.internal (MEProxy); Mon, 15 Jun 2026 15:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781550154;
	 x=1781636554; bh=E2yLV8YrhL6qj5s8UvvSc3RGzPjW1bRM5vI3o/X2on0=; b=
	rlFSso0m7s1WVs1rN41VPGWJXMQbXURqA0TpREqKV1ekUxTqByRFDos0L+Vm197F
	M6COAOsUsw2R7+i7cqNWF6ZA60tMZsu+f4uDEGdl6Ul2H1Vch7Hokc9IDl1G4dx7
	9czeB74PnfWRD7BWVLvjriNJt7TZrxxgGqSVRF9t4vDhv/eL8dkDHVLj3hR5I65d
	LF8SPG7nxgtB2iij+6uWvkBgbEHOI+zsd9eRg2QsGWzcPwx4p4d1r7+szKV0qkvf
	2wbJMR84A3Pz1VVwirNh2TzxpbVQ6qUEAYzEvv81f2OjnqlEsfYVj3BgxzJMxc9/
	JqCnTZkW1KN1aTT771xWew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781550154; x=
	1781636554; bh=E2yLV8YrhL6qj5s8UvvSc3RGzPjW1bRM5vI3o/X2on0=; b=M
	boqqgzL72VlK/lkRPSXjSdGqmSn1Xoc27hA2CiP0WPemo/Hi10hDFvMdPWfxvdPM
	eBbamWPKjlhqkXP7st/yiHIA5+crFUQBxXAJFNrAeXbSUBDI0Mok60898kzkaVQY
	MS30ERYKLaIp1RQ7PTZ7H3FHQfmkzIYRJNjVewOc/03dUBRgj+MrkN4QsjCAMrgU
	Wz4GFaOh8eR9uRAGHsxcbQzMlr9qPyIOjLGtS3Db9NzyrpSkTBC7SR7Z1ZXe+b5q
	Qz+90rWQFAR6JFAXNsHzzSCdBXg7+pL/eQ5o1oHw+ALh21dQZDIoPHyUSiWE73ik
	IEn87HGs9hVOJB8zn20qQ==
X-ME-Sender: <xms:SkwwaqhoO_OEfZ71vYhf9Sv7xZDqapCYWT0M_YUeYE0mX8uaUV3SaQ>
    <xme:Skwwal1TwfYdNuNVo-0dXpX5Ivs6u-v-873frgDQZb-mvBOTPE9p2JAi9u7c4X75D
    7XXlKji3Ne_wDIbeSZ6ZDtxrID5-nxr0J_USzmqVst6sgdZxjJb_40>
X-ME-Proxy-Cause: dmFkZTFEezTVCnM/vqB4FDlgEqXJQKbNn0Vopkx2v2rDXLnOaBAxZfDhYpxkI1GnKvTBHW
    iFLZqd3oe904LGItPIZNGrmZ566J4B/5R/6GdY6/OfyOxyKyvk9Y+UNq9p/LdiuT4EXx+G
    M5bs/lBQ4ZXGDXBT25cICrFpNaRbIifFfQWl0VQXwMCjXktlE1x/9o/Fo8Iqgg9j6umuOU
    5FZaRbTpOzgnKDaGlg91KMoOkaNTmY7ReFi6plhrlgiOK3dYm5wuq3+L6UEaT84K5GLLA2
    glAXQBJiZMJNj5w3aro0scjVC/asq3VOzFvj2UmxxRutWhMLQ5SaNtWPZVnk8YxdB6F/NG
    rud3dYwXPDhWFrAzjlMRw67D3pxHHXhbz2UhYTG+vcDIiY0RF657bCxWkkED7Hb9DNTqob
    BEIcxKDb/yNXs/hfNBiY8M0UgrNXUS1R9hwM247F+/PML4tzfg6XzRPFryWOSFIRi4ai8f
    rzMwkbMG8fGCLDcR/paL7i8gar3aftsi0t8w1O6F9GEP1Mn53bStmg/KWiWfVLLJL/bQWW
    /0Y84SPE+aYGd2MwICGOn0Y/5/r/MlcqhAcYJpDm9/g0byWZDYsJOjGtTJG9k4jiO7SuFE
    dDGcLvduk3ao6mhGc8X9qGGe+uI1EzD0FBYViSv6qHLE7a1+TVSJb1dI7Orw
X-ME-Proxy: <xmx:SkwwagJFWoBEPEKkI8-4r2kVRHTRRBX7jq6xoLcLr_242yQhHNt2GA>
    <xmx:Skwwarl73Wgrc0WmrghSVCro6QNgAHA3JhKjAK9hWya2gCEMVQ2Y9w>
    <xmx:SkwwakP37KcjkZcasxgHCmWAOFnUpy_BsfoINfADtjdwNz5KmfDsBg>
    <xmx:Skwwah1g_Iw59TMmfrq1BAycASa8Zels7EQBRYsryq9f8sxr4O4dIQ>
    <xmx:SkwwaladntSZI7h1_v1899ZQ8TWQdGtW1A4EJbvXCXJgc31Mkuv5Fthx>
Feedback-ID: ied564b65:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 01942182008A; Mon, 15 Jun 2026 15:02:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jun 2026 21:02:12 +0200
From: "William Hansen-Baird" <williamhb+lkml@fastmail.com>
To: "Ping-Ke Shih" <pkshih@realtek.com>,
 "William Hansen-Baird" <william.hansen.baird@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <0fcacc43-290a-48c1-b936-015d57598649@app.fastmail.com>
In-Reply-To: <eb874df08873478b8f2ad373e8b2ca05@realtek.com>
References: <20260614135508.70307-1-william.hansen.baird@gmail.com>
 <20260614135508.70307-4-william.hansen.baird@gmail.com>
 <eb874df08873478b8f2ad373e8b2ca05@realtek.com>
Subject: Re: [PATCH rtw-next 3/3] wifi: rtlwifi: disable ASPM for RTL8723BE with
 subsystem ID 17aa:b736
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:william.hansen.baird@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:williamhansenbaird@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[williamhb@fastmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_FROM(0.00)[fastmail.com];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37824-lists,linux-wireless=lfdr.de,lkml];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[williamhb@fastmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 766C7689587

Thanks for the review, I'll send a v2 addressing the feedback.

