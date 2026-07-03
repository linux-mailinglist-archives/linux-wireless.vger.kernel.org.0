Return-Path: <linux-wireless+bounces-38541-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7KKtMUQgR2orTgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38541-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:36:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B556FDF85
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:36:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=QYNFW8p6;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38541-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38541-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B23BC302F6BA
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 02:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DFC233939;
	Fri,  3 Jul 2026 02:36:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DC2367D9
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 02:36:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783046188; cv=none; b=O3ZQZyLbJx1SYN6QM2nMrDaupsOeIwaB7gUScpfDD1+FSMUqsLMmg4mfgj90fThiBcoTTUQRqgIUSZYom1jnZRA0W2pVTFY4CQNv5woEGHXLWz0/9OS/4smc8JbK1dIsr9AKxMeiZ/aTuyoQTBfzval5eeDVPaxitdKFPqsFvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783046188; c=relaxed/simple;
	bh=5N8pbfSjctq8kTkjVKbYHyP2NPu0BC9rFrgm8JxyaX4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=mBku2c0cH3oANFqLKDHzKvGOmOfFLf+HSDkO0DejSgcTICZP6p6FEcNxR4OwdeKnPRXxvm1i+SLrgDXBrMhboJ1y/YKffF57Dj/vUy3TxRLAYIbjr70c7COoQaJRI+hDBwyfnoJzwHIYWYqicQpp9H1JEFLlo/dr3/PdqAkMeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QYNFW8p6; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6632aND212392362, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783046183; bh=RrMkQFcHyWG1kA4gXA0b+gHo48D5xyaS/VGCASfAd3A=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=QYNFW8p6HIR/W5nyPBRbDJBF1W9Nmam2O24jWA8uSqbq/8vMkgHuL0a16tDMaAPYJ
	 jN3MZ1ZAzjJfLTWQW23G3EpBqiAAC8gexOaRJBVkC+CN0k6bgOmsqTs9seLkk3FKvP
	 mPYyPKkuJtxVQCq1aVbAq+WBM56kIIsw2V9nkjG8TLv0iUOdgz72LofWU9ulzrqyvY
	 UO0IYfIQKKuP1RTadZTj7u8EX5336m9WoGIonajFMKLjKGO1uAxzEf/3oHMVPNubzl
	 PBlTGrIYprrLpGUXWhGRe4hi+5dFMbUfm+sSeAV+DircPkh0EiukfZDicxZDiFp4HC
	 GNG/coXqQQRow==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6632aND212392362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 10:36:23 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 10:36:23 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 10:36:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>, Ping-Ke Shih
	<pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, Panagiotis Petrakopoulos
	<npetrakopoulos2003@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: use str_enable_disable() helper
In-Reply-To: <20260612223012.504886-1-npetrakopoulos2003@gmail.com>
References: <20260612223012.504886-1-npetrakopoulos2003@gmail.com>
Message-ID: <4fe4527d-1590-41d5-84c3-0c52ef65e029@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 3 Jul 2026 10:36:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38541-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	FORGED_RECIPIENTS(0.00)[m:npetrakopoulos2003@gmail.com,m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04B556FDF85

Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com> wrote:

> Replace "enable"/"disable" strings in ternary expressions
> with the str_enable_disable() helper from <linux/string_choices.h>.
> This covers the rfkill state log in rtw89_core_rfkill_poll() and
> the DPK on/off log in _dpk_onoff().
> 
> No functional change intended.
> 
> Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

2c0810030cf8 wifi: rtw89: use str_enable_disable() helper

---
https://github.com/pkshih/rtw.git


