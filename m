Return-Path: <linux-wireless+bounces-33275-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODTCA4ibt2knTgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33275-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:56:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DB3294E5D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 06:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB3493006479
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 05:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131613E02A;
	Mon, 16 Mar 2026 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZWdg+I0L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D130EF7C;
	Mon, 16 Mar 2026 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773640581; cv=none; b=liNhYnMZ79dgKRaKJ9pIIBq6es97FIAe93CZE4gBDjlOh1QSGwrWIott0Bp/wZgsqi+CIaeWm9pFtb8jx8E7/zEv6SMzsc0Rd9ZZRdACmRBJ89JpAiMiK7e/SskXsR7/p7LqslyoTF6TidJthTd6N20JDTYnvKABitjQ93D1C3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773640581; c=relaxed/simple;
	bh=i4WS2MvDdN/LM5dknBhOqphajZZhCyfiPcRtfdk/DvQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=gphSpZkV70hplyRrG2hVxkgyWuyYLkC2T0ze8+gO2waf/OXi8Q9fyVxzPRkfyv/pvjWIcyMyn1HGoVsDeqLIAHHdKFD21IUaP2pbmBJRjZBXrbHLzWVwIqqK9Z6iXaFP4gceDzrwzC1d61+lPRzd/mVvYHuklHkbBWzlDCeDu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZWdg+I0L; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62G5tXMV11329142, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773640533; bh=JGElMmO1TDsyhnYuyRm/ar9twF8a5imTjnQZXvsgxyg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=ZWdg+I0L0D32tKeGQ4G9hMcx/x9jO5KjUR4DVIAeu4ods5WM1Yuhk2fp+Mw/s9sb2
	 i/uk2ZEboyj6cEw+pb3X6eH9/2YROxHYIS4kN6N49JZDQyLuWMM0xlr38wzb4zU6FD
	 SHwuN/6Ps4++f9HgOKdJmKEUsYIz9h6JaTRih25uO1Uja1DZgeZJsHqypijKuqVMWo
	 wMLh26OTWu20Kb7CAnhBBM+E2YCifHLyr5rGpgMY79Ba8n3d69m3Ji4H2hR4ext04l
	 Jl4WJkKuxZrVceX7O4xdyKdpz/H50/vRiu/4p1WRpANXSKl5kvxP7HQdBBlig81C/Y
	 mA7uXi5ZyjAOw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62G5tXMV11329142
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 13:55:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 13:55:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Mar 2026 13:55:32 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 16 Mar 2026 13:55:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yi Cong <cong.yi@linux.dev>, <pkshih@realtek.com>,
        <Jes.Sorensen@gmail.com>
CC: <linux-wireless@vger.kernel.org>, Yi Cong <yicong@kylinos.cn>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: fix potential use of uninitialized value
In-Reply-To: <20260306071627.56501-1-cong.yi@linux.dev>
References: <20260306071627.56501-1-cong.yi@linux.dev>
Message-ID: <7d04bb47-4715-4f1e-92a5-4d57356fb6e2@RTKEXHMBS06.realtek.com.tw>
Date: Mon, 16 Mar 2026 13:55:32 +0800
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
	TAGGED_FROM(0.00)[bounces-33275-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,realtek.com,gmail.com];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,linux.dev:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A0DB3294E5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yi Cong <cong.yi@linux.dev> wrote:

> From: Yi Cong <yicong@kylinos.cn>
> 
> The local variables 'mcs' and 'nss' in rtl8xxxu_update_ra_report() are
> passed to rtl8xxxu_desc_to_mcsrate() as output parameters. If the helper
> function encounters an unhandled rate index, it may return without setting
> these values, leading to the use of uninitialized stack data.
> 
> Remove the helper rtl8xxxu_desc_to_mcsrate() and inline the logic into
> rtl8xxxu_update_ra_report(). This fixes the use of uninitialized 'mcs'
> and 'nss' variables for legacy rates.
> 
> The new implementation explicitly handles:
> - Legacy rates: Set bitrate only.
> - HT rates (MCS0-15): Set MCS flags, index, and NSS (1 or 2) directly.
> - Invalid rates: Return early.
> 
> Fixes: 7de16123d9e2 ("wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report")
> Cc: stable@vger.kernel.org
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
> Link: https://lore.kernel.org/all/96e31963da0c42dcb52ce44f818963d7@realtek.com/

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

f8a2fc809bfe wifi: rtl8xxxu: fix potential use of uninitialized value

---
https://github.com/pkshih/rtw.git


