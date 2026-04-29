Return-Path: <linux-wireless+bounces-35554-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOghGxCW8WntiQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35554-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:24:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0855F48F6A1
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4E5C300A511
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 05:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975633263E;
	Wed, 29 Apr 2026 05:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="N2g5q/WQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614929B79B
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 05:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777440264; cv=none; b=WmKsv+9JyWCxZqzYgeTsI4yi+AjS36SunZBY8lfnCjL9xJVWsKMgR9y68MQDnPkH1p031hXEinKiwjdzgQV6l810uGbjbsgiZGT3dsLy3mVxyEc8llXzew09plvP5rp40VE8SXto1VLBILyGjoxupWlOlxheoMiHNRUHcIU9qgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777440264; c=relaxed/simple;
	bh=B1gs/o97qS+QCyYKpH3/HuXGo3uwkBfv1bHGhUSlXVo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=dgYrPtWp1iFYDjhVvE2UHWaNKa8calXPq612LTjqk+IB6ODTp2rPFGpMaG/LAYPKJy+AYQDZqrNotXF/Jrmd8zjvhSEpQcRu2Zb4PbDJ1MwDuo+pFutoPT9qhR4IYAvYoQ605dGIuJqiCtqaWJ4LqesVhaVB5rLTqhquoVpmXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=N2g5q/WQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T5OKU201011250, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777440260; bh=gd+HFKs559rXbhUjvqAU+i5alS6cFrnwEQUizeRcfME=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=N2g5q/WQ8YCkozUIMwAm5Howk68uaxstrakgfY9SVXMf6JIKuWEMzfrKp0/0uPHUB
	 shwaRrfmJVDiCfQ4aATHvEB9nfvpgfdNchaC1oqLSMJDhTBGWY+I/3lCvAGv9c63i6
	 vrL4V2NypfyPsaTj8TWP8pfU8ac+voSoUDKjCKSns/hA6wCBfeRi3hLIh3pE1hzKh5
	 MtXGGRSYIe73WcUETwORWLyhnP656BKuX1kAF00yJKCMQmI88xLov8gU0lYdWq5yxL
	 50AcuyZ1TPtNtP2mqSIHH3818O56mgY3QtjbPHB61hxpPii9lD+pd+gr5kX00IPIiq
	 SJpiHMfd6vwww==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T5OKU201011250
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:24:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 13:24:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 13:24:20 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 13:24:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: Re: [PATCH rtw-next 01/16] wifi: rtw89: 8922d: fix typo rx_freq_frome_ie
In-Reply-To: <20260420034051.17666-2-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com> <20260420034051.17666-2-pkshih@realtek.com>
Message-ID: <ef909647-a8a1-4693-ace5-ded54aad5944@RTKEXHMBS05.realtek.com.tw>
Date: Wed, 29 Apr 2026 13:24:20 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 0855F48F6A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-35554-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The commit 127ea8d0b068 ("wifi: rtw89: fix typo "frome" -> "from" in rx_freq_frome_ie")
> change the struct field to correct the typo, but miss to fix this for
> RTL8922D because it is submitting at the same time.
> 
> As RTL8922D is not enabled yet, this build error doesn't appear.
> 
> Fix it accordingly.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

16 patch(es) applied to rtw-next branch of rtw.git, thanks.

d6a3aac6ed5d wifi: rtw89: 8922d: fix typo rx_freq_frome_ie
fdf0eb355182 wifi: rtw89: 8852a: refine power save to lower latency
3da737c77764 wifi: rtw89: debug: disable hw_scan for latency-sensitive scenarios
bd2d1abf74e4 wifi: rtw89: debug: disable inactive power save to reduce bus overhead
e3ed82f19f13 wifi: rtw89: phy: support static PD level setting
08fdcb529df6 wifi: rtw89: Correct data type for scan index to avoid infinite loop
72b781d3bdd3 wifi: rtw89: 8852bt: configure support_noise field explicitly
ae3d327515f2 wifi: rtw89: add IO offload support via firmware
63586e841cf3 wifi: rtw89: offload DMAC and CMAC init IO to firmware
850216ff7d12 wifi: rtw89: use firmware offload for PHY and RF batch register writes
89058548dd14 wifi: rtw89: 8832cu: Add ID 2c7c:8206 for RTL8832CU
8beba37615f2 wifi: rtw89: use struct to fill C2H recv ack
6a9b4babeb9b wifi: rtw89: check scan C2H event recv ack instead of C2H event done ack
602b58bb45b2 wifi: rtw89: suspend DIG when remain-on-channel
2da590b9ccf5 wifi: rtw89: chan: introduce new helper to get entity current configuration
b465bc7e18a7 wifi: rtw89: 8922d: update RF calibration flow for MLD

---
https://github.com/pkshih/rtw.git


