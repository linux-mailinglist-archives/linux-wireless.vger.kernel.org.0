Return-Path: <linux-wireless+bounces-33279-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGJOLvCet2l/TgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33279-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:10:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 457D4294FCC
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B628B3004F17
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC95349B02;
	Mon, 16 Mar 2026 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pCSON54J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202534887E;
	Mon, 16 Mar 2026 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773641454; cv=none; b=p5D1bQGX1NrxRRa+sthBxLR/c2AsOdscNYzHOsxi3gurIjjtpKprmvMkb0wYg0MR/6/EPeOJMdNRXcZw17ij1nmCUjbRoqfH73UHJvej/8iVHnuXi3TrfolEKzXCtJzddIbXEqiHyDf/UdipXpIeHHRiO27ykP+W25Z9ynd+9MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773641454; c=relaxed/simple;
	bh=dS461aDpcv84bUTPWsJkZHw3wAdyDnKETRZJm0mlIJk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=XfjQhVW5vocxa6Q5p1a8OHKENxK4XV1IpSzmW8PRbvok3UWNNhtp4+IZQqeHEl6d0g4u/78PlC0O4BKRBfGaBT/vLEiVixzx0YqPFpAF6ykGh2pmE6abDME5L8rBdRf7r/L0/85qQ0Bnj0Dj0UqHhvo+l+5sdeRdUkiXZiVu5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pCSON54J; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G6AnSR21345777, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773641449; bh=kBH1OMQI4wc8btpy1SGshFQpxC9OEVHbKlDwmnOzP40=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=pCSON54JH1sNWp3eQMaSHDpSqfW8J/ogTqsmgrcSMBFcmBBv2F8pM3X5OWunRwQfx
	 DeeO7u+JWC35G96QBdwjyI76PUbLthKUFEnkdIr1ucW2cF3XRpcaQCZFsAwmzxA0ut
	 tJ2gczKyFwMgI5D+dAU3q3Yr92hzoBnmu7K6+8q0iTsLMYvWbMoKiBOAG+46Sv4wDD
	 hBbq1zKK0nC21GXD6z315MoRhP7ONPCbOTSyML/grGOe5ltOVXWIY/tZSHoCn7J4Rt
	 qUis1WUig73rlGhMjxx/OvGnkbNBlQJ25ZKNqzYcQN+C3gi81E5onWIXKpoQxzUVcn
	 VWNvGmDcRE5Gg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G6AnSR21345777
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 14:10:49 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 14:10:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Mar 2026 14:10:49 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 16 Mar 2026 14:10:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>, <pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jaime
 Saguillo Revilla" <jaime.saguillo@gmail.com>
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192d: fix typo in H2C wait counter names
In-Reply-To: <20260308111850.20420-1-jaime.saguillo@gmail.com>
References: <20260308111850.20420-1-jaime.saguillo@gmail.com>
Message-ID: <0e0025ed-76e4-4e68-95bf-233e40f2265a@RTKEXHMBS06.realtek.com.tw>
Date: Mon, 16 Mar 2026 14:10:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33279-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,RTKEXHMBS06.realtek.com.tw:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 457D4294FCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jaime Saguillo Revilla <jaime.saguillo@gmail.com> wrote:

> Rename local variables in rtl92d_fill_h2c_cmd()
> from wait_writeh2c_limmit/wait_h2c_limmit
> to wait_writeh2c_limit/wait_h2c_limit.
> 
> No functional change.
> 
> Signed-off-by: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

e1b6b5af5d17 wifi: rtlwifi: rtl8192d: fix typo in H2C wait counter names

---
https://github.com/pkshih/rtw.git


