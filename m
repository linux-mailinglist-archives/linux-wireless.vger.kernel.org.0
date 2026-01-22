Return-Path: <linux-wireless+bounces-31053-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P5GAcmEcWk1IAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31053-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 03:00:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E50A60A2A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 03:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A4824EA2BA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 01:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44332BE620;
	Thu, 22 Jan 2026 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Oq51Sobb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E30723E32D
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047045; cv=none; b=U666aQXCluFuZDwj8FoECyUS9/P0yagPmCwc9L6hrwIMp4rORbwN8oqNEsP4We/+XGGCOPtydmYhmQpzVw8yhAe1+Z2OngCtBwnHlUJOJibzoU/nW1+tKcA2yH5HWf7iZVzV8Tgu04dA6nWAwrlLAGUaw2ytEeeGOU/QVkiZkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047045; c=relaxed/simple;
	bh=rZf6lW91Dol68wdih2l96UQx+ld4ukEITwxtsuLc3iM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=Qdl0NBau/K+n7vTvSFmPjGcJ1fb10EkGS4LY8ogNLXqSxecYYUTFsZzHfXG3N+W3OD/ATbm1nbW68lxoiXfnRD0A3e4WIPZvtGtwgNB1FWYZUhYNpjenO4r4RPvjUhEHR2KbxvVNMKOAvYVewmJQq86jSGy/Ye9Hl6eLepGXJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Oq51Sobb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60M1vLLt9098916, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769047041; bh=CFVW44q3MplFCNN1GansSas9yZZ3d0in4w/BKCWoQwk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Oq51SobbyTRTn9WBjljc9sXORTQNp9ZOtMe02swMjUOttJitVxqjB5ZxVSrZE4gOP
	 y3lORQiNDFPbXaS5LES9kV8Z7oEF7QffqoXsnDjlvdeQKmO7IypurifVC1ctBcNPhI
	 w3Nq8fDBwFR0RnByLSiOQYpAE6wkzRxbdKx96oOotagmgbCPJ8up+oWDHp1RTCVVBU
	 +fMHeU58aMDixOQNUYSSN3Nd1q1JN7lntAZKwqwtyCve3i1dFIM/LHav50jR9dmDSK
	 nepaF/D4clMbpRmoCNQtdE2j9tZHLBp3bOETm9Bs08yisg1upiCvGMp3jIFFICjVbQ
	 sQoWCapklkSXA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60M1vLLt9098916
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 09:57:21 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 22 Jan 2026 09:57:20 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 22 Jan 2026 09:57:18 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 22 Jan 2026 09:57:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <isaiah@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: Add default ID 28de:2432 for RTL8832CU
In-Reply-To: <20260114014906.21829-1-pkshih@realtek.com>
References: <20260114014906.21829-1-pkshih@realtek.com>
Message-ID: <b7026c07-f34d-4ca1-884d-448c2ab88356@RTKEXHMBS03.realtek.com.tw>
Date: Thu, 22 Jan 2026 09:57:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-31053-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[realtek.com,none];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[RTKEXHMBS03.realtek.com.tw:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,realtek.com:email,realtek.com:dkim];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E50A60A2A
X-Rspamd-Action: no action

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Shin-Yi Lin <isaiah@realtek.com>
> 
> Add 28de:2432 for RTL8832CU-based adapters that use this default ID.
> 
> Signed-off-by: Shin-Yi Lin <isaiah@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

5f65ebf9aaf0 wifi: rtw89: Add default ID 28de:2432 for RTL8832CU

---
https://github.com/pkshih/rtw.git


