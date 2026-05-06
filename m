Return-Path: <linux-wireless+bounces-35994-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOreHFf7+mnjUwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35994-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 10:27:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5CF4D7D66
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E70E3300C925
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 08:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBE03932C0;
	Wed,  6 May 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PD192bID"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E1175A7B
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055838; cv=none; b=EcQ6NR4sWPywVNB/w778cB1WsAi3lXoFhFLX8MKK+CE8BgAsvoBPf1aHqNQA/dCwvHJewHqF07Gv/DInRvclUi4vEQBTxLwOYmyuoOnZm6oNryeqcaLosazz5v/3ai5wK/Jc7Tp8fR1k/EgdQTnjt0mvxd7Iv9dV7FtE1v3w4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055838; c=relaxed/simple;
	bh=GokYZUprmI5E5GH5v2phAPgVFHRWmZ5bRkFNGFzyK+s=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=ifan1s07r8GSmHzWrbu3/Aik/QKW72orIgecVk6Db229IXR4Tw2gna7ZXsvUFkCeppDh9FZ/hBZViRrf0ls2ODlJ9CzoXonwDveyPmN0wvaQtgEGx1FpDZRbhySxHXNqTl6wYTlIiTSErW7nReYa6zxuUNmolWGu8CH5NsDqOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PD192bID; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6468NtBT21857409, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778055835; bh=bDbPudfxK7PQow5lW06xisRv6tT4xFCrBrVQBV2zEdU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=PD192bIDDXY7Ed0OmFKEdzvUrPFM74FJ++edHkupB1lpPZHIytJnu1njt0kbLWwY7
	 3YKatc6Zlq2f+noxAIyfY+dbSGQE9rYMtkVG7kW0vhlZEt1mf6ibs16DtR1VrAEksA
	 HM6jRclBaVqooctnyyeSFqGt+R0BhsmNxNdOrfHKC1GugI1DfOzQSRKySmgtaNEiMk
	 Ad73l5OCqPl+V3dEzCIIWBrQgJt7pZNiktPmkPDF1feP99yCoVGNrEmcWPFxaTcFi8
	 9ALUTW9kV1dHCTRzjn7/D/RM6EGDdg9uMY6gI7Qbe/uOk4lAza4tXbZUACUM/jg9rf
	 1cYKqpHXvLohA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6468NtBT21857409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 16:23:55 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 16:23:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 16:23:53 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 16:23:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: Re: [PATCH rtw-next 1/7] wifi: rtw89: mlo: rearrange MLSR link decision flow
In-Reply-To: <20260429132625.1659182-2-pkshih@realtek.com>
References: <20260429132625.1659182-1-pkshih@realtek.com> <20260429132625.1659182-2-pkshih@realtek.com>
Message-ID: <e90a8b3d-ddd5-4663-a478-11ffef89bc0d@RTKEXHMBS06.realtek.com.tw>
Date: Wed, 6 May 2026 16:23:53 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: DE5CF4D7D66
X-Rspamd-Action: no action
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35994-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,RTKEXHMBS06.realtek.com.tw:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> The original MLSR link decision refers to RSSI, but it should be
> based on the premise of an existing link. Otherwise, make a link
> decision to select a new link from any available band.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patch(es) applied to rtw-next branch of rtw.git, thanks.

7284f5be5d29 wifi: rtw89: mlo: rearrange MLSR link decision flow
09d369c66373 wifi: rtw89: phy: support per PHY RX statistics
523d012f47e7 wifi: rtw89: debug: bb_info entry including TX rate count for WiFi 7 chips
3b851f36c3f1 wifi: rtw89: debug: add PMAC counter in bb_info
419ed7f4a053 wifi: rtw89: debug: extend bb_info with TX status and PER
c77bb66e244e wifi: rtw89: debug: add RX statistics in bb_info
c1ed02655f91 wifi: rtw89: debug: add BB diagnose

---
https://github.com/pkshih/rtw.git


