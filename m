Return-Path: <linux-wireless+bounces-34914-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPllHOWU4WkVvAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34914-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 04:03:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5A4161C2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 04:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 509DA308CAC2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 01:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BC3274641;
	Fri, 17 Apr 2026 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PdbqkqCd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752521B9F5
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391181; cv=none; b=QuBuwlL5lu6jmnLFrczYq+V+KFPSiIK7da0T/Nrm5D1fO32ZGvOOBj2UZpfGlbTewdROQAGF+RTYYuiel+pnSLRTiRsoyAAMwcPTSGMDgsn6KX0HIYTG84b8fX3g5PmKPJApbzQyk4qyfvlHuIjafC0SBEUmYHU59A9Y44uLXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391181; c=relaxed/simple;
	bh=3k5lGO9cI2sCqWxSLMx6gfmbNLtNbeUTHQFaRGLzc44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h5FDX1DnYx6YU0OppF8AzqavJePKJFaSUPWvNzvP7eDcdU5XEWTDCOP+nQawF7wf/hUpuVS4chgGR7rSJjW5bhHGkv9M/wH2bQLfkaj4SPqKu6EqKjuwmJmbInP1w17vrjy2jzv0Gq01uQOIApiwgLdG6Bp13Af2uUY6hEGVU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PdbqkqCd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63H1xFFB13010490, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776391155; bh=3k5lGO9cI2sCqWxSLMx6gfmbNLtNbeUTHQFaRGLzc44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PdbqkqCdvfJUaxjz7JzhHA56YEKMh+gWo8+Nu3gsb4de5FsZqSYX62Uz9Vtyyfsfs
	 Du87/2RLMI1pzY2FZE5CM0IvMVKR4uQiH5e7Ygcd3nvqVc6SPovHnfjI8NroNbku9J
	 aYd2QxA9VUJOLYNjiBGs/d8P51qYaYd5mbzdA2WXluatm/kLYc3I1BC9a9bVYLwmpJ
	 3Zde8r786rWRK+ERdondV4ViTKgwAzNjqIddaTnCBY3a5/3p1CPbkOui2twPVsXX8D
	 /D5ruG4BD4rTaHSaqZxXjHQc64UBNgGiLZ1uiG5WmwF7DKMEvZvoFPnBtgzV8DKjX/
	 ueFmUSLY5+LBw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63H1xFFB13010490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 09:59:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 17 Apr 2026 09:59:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 17 Apr 2026 09:59:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Fri, 17 Apr 2026 09:59:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Devin Wittmayer <lucid_duck@justthetip.ca>, Louis Kotze <loukot@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v3] wifi: rtw89: phy: increase RF calibration timeouts for
 USB transport
Thread-Topic: [PATCH v3] wifi: rtw89: phy: increase RF calibration timeouts
 for USB transport
Thread-Index: AQHczV1OAZ5R5iT3WkCIsKtA9OM+YbXheLuAgAEHOxA=
Date: Fri, 17 Apr 2026 01:59:14 +0000
Message-ID: <7a3710adef4843f38223c18f71bffdf1@realtek.com>
References: <20260416045536.817930-1-loukot@gmail.com>
 <20260416181355.24099-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260416181355.24099-1-lucid_duck@justthetip.ca>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34914-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[justthetip.ca,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BEA5A4161C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Devin Wittmayer <lucid_duck@justthetip.ca> wrote:
> Thanks for driving this through three rounds, Louis. And thanks
> to Ping-Ke and Bitterblue for the review cycle. With v3 applied
> the DACK timeouts stop across every rtw89 USB chipset I had on
> the bench.

I also thank all you for patch and test. :)
I'll merge this patch after merge window (~1.5 weeks later).

Ping-Ke


