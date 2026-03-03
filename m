Return-Path: <linux-wireless+bounces-32366-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEfELSxFpmlyNQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32366-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 03:19:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA371E7F1D
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 03:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05DC7305DD68
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 02:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E92364EA5;
	Tue,  3 Mar 2026 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Nmp7LzjE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B531E853
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772504263; cv=none; b=B7PILOU2QVEYTLQ0u9+phIBcSWlfW+09xSGRf08OayjlOKmw5qmbFlsDOMM2uQaEv8Tuqm6Xe7kJy2KeOmvEUI5s+Hz6X166ZapbVPcec/HUWJgP9+AGlDbxAKZ/666SFlzEW4m/kTotQerG4+n6k4VQS5KTM9Q6Z5AZfN15GHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772504263; c=relaxed/simple;
	bh=OAyEBQYRwVpZ/9QLiIj0XXVH99hsDqMiIv7qwiHaR0s=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=rODKp145Zt9WAOjPkOYDHltXzcmakyHEI1hFJ2z3wEEwgDM6JmMWmWeLJS/iRj425TFZeCTBFo6glK/DtfJaYccmL98ur8WMH4Z2sKDAx7JQyCbfUlqR7Jv9wTFoOF1PH0bbvl7C3AxtDUkH6ENv67TsOcyiXs1yiPuvYpbOINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Nmp7LzjE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6232HcmZ6204286, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772504258; bh=asPIwmMu2QRbvEM0SFrNYVYnbOTPyUBuZFY26T7KUv4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Nmp7LzjEy+47WeQTXuFWJVoA3ppE0ypHhH/1NpCKR76JR82j0odvYX58zKnYHha6M
	 i+6VTCbw4rvBb3lPUMPvifpJOFjNaXkYg82+fM/mVZuJkoedpnKUMDZJ6RQ5TD/AeK
	 pBykcc0TZvp3VyjV7R3NXb/e3pWgBYz4/jP5k5v+QhFCE1MiaD7JoAVUEFRz4sKcgg
	 8CirAfmcBsPDujcgjtXu/LKuOI5hTmgcrs7kAtdyYNf8W/rF7QxdTFHskEzdVvsEBa
	 ZEVJxv/lnfyHkaFmC6mJ+Hw1VzlOfsPP1RsTrlGT3fah2eII2cbsJaLUbkK6xP44Hh
	 k7gcJCADZpPTg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6232HcmZ6204286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 10:17:38 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 3 Mar 2026 10:17:38 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Mar 2026 10:17:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: Turbo mode for RTL8851BU/RTL8852BU
In-Reply-To: <88cce107-ff52-496f-bb77-b930e4182b67@gmail.com>
References: <88cce107-ff52-496f-bb77-b930e4182b67@gmail.com>
Message-ID: <e0650548-df01-447f-8e1c-3cbaabdc0774@RTKEXHMBS05.realtek.com.tw>
Date: Tue, 3 Mar 2026 10:17:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 0CA371E7F1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32366-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,RTKEXHMBS05.realtek.com.tw:mid]
X-Rspamd-Action: no action

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> RTL8851BU and RTL8852BU currently have much lower TX speed than
> expected, ~100 and ~300 Mbps, respectively. This is because part of the
> chip's memory is allocated for some unknown firmware features instead of
> the TX buffers.
> 
> The vendor drivers have a module parameter called "rtw_quota_turbo_en",
> which can be used to choose between full TX speed or the unknown
> firmware features. It is on by default.
> 
> Change the relevant chip parameters to implement the turbo mode. Do it
> only for USB because PCI is already fast even without the turbo mode.
> It's unclear if SDIO will need it or not.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

2d85152020d5 wifi: rtw89: Turbo mode for RTL8851BU/RTL8852BU

---
https://github.com/pkshih/rtw.git


