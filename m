Return-Path: <linux-wireless+bounces-34130-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC6kNGvUyWlj2wUAu9opvQ
	(envelope-from <linux-wireless+bounces-34130-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:39:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F733549E9
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF9B300B47C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 01:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090F6261B8D;
	Mon, 30 Mar 2026 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dq4nh+nm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A221771B
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774834774; cv=none; b=TyUFQ0veBN6EA8T0RZ0Rb+PUInZSnqSB7Ld5Uoe97M2CudOv1IUMa1ZETBMJNzKgxuyUO21VCiV4O+aZsWksNo7sW3oJtiT6/USN/V7N22af6vBwAxM/8JDr4kJWo6irT+T7q1hznLT+3C/10wkx08TYASxVQnipxp4as5oVkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774834774; c=relaxed/simple;
	bh=Q/tgnE9CTxTMbj1XZMT2qr72f3CmQwnvdcIl/NRIP0c=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=UeQurb1RMBDhMUK7Itf5FXf3k75Wk/5f0rkS1sqHOM0GsXq9CfZZ7nwOb6c/+ODbeZFMyIPI9y0wiK+gviH0GtB0VsSwIaPiEBzOOmKnzDVlN448/FIzLnm23LWFBm1i+em1faHFPPdYClFo/knnNLeG7zcn6IZXStQ6x6Chqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dq4nh+nm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U1dSWr9059486, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774834768; bh=1fYjeY58ZE0BrCfff/6i4aOjAVVp1A3U49/NDSNZDIU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=dq4nh+nmSv9gp8x1r9SpsVl8Sgij8k999NCtXWNYSe28CswG2DL2aLPrjdryJEaRU
	 KSyufw7JZaNNRRXFn8uvIifBwpE00SaDu9Li51X1pNFr9hHVp70LZ0jmmXqTaPSc7C
	 JI69j6HaxKW5suNHIU1bQXKMCxo42ahY/efep7cNv10PNh6wsCwZbtvqyIVgA115Kc
	 8SK2nR3fWsIVLpF5YQMYIBhjCkjb1nacMD8ir6jJW836yXIRXpg7+Ar9vThMKVvL9t
	 XbEljY4wsjXSZ8jTRvbSl6Kr5f7rLy7MVaGDp6SG5+fElU/PvcwF6YRwAUapAy6xS7
	 vNI4AR7n5PqBQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U1dSWr9059486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 09:39:28 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 09:39:29 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 09:39:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <goainwo@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: add quirks to disable PCI ASPM and deep LPS for HP P3S95EA#ACB
In-Reply-To: <20260316035635.16550-1-pkshih@realtek.com>
References: <20260316035635.16550-1-pkshih@realtek.com>
Message-ID: <c81cd8d2-8b9e-4ca6-8ce1-429602655e24@RTKEXHMBS03.realtek.com.tw>
Date: Mon, 30 Mar 2026 09:39:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34130-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email]
X-Rspamd-Queue-Id: 51F733549E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:

> On an HP laptop (P3S95EA#ACB) equipped with a Realtek RTL8821CE 802.11ac
> PCIe adapter (PCI ID: 10ec:c821), the system experiences a hard lockup
> (complete freeze of the UI and kernel, sysrq doesn't work, requires
> holding the power button) when the WiFi adapter enters the power
> saving state. Disable PCI ASPM to avoid system freeze.
> 
> In addition, driver throws messages periodically. Though this doesn't
> always cause unstable connection, missing H2C commands might cause
> unpredictable results. Disable deep LPS to avoid this as well.
> 
>  rtw88_8821ce 0000:13:00.0: firmware failed to leave lps state
>  rtw88_8821ce 0000:13:00.0: failed to send h2c command
>  rtw88_8821ce 0000:13:00.0: failed to send h2c command
> 
> Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com/
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

b2bf9d61e14a wifi: rtw88: add quirks to disable PCI ASPM and deep LPS for HP P3S95EA#ACB

---
https://github.com/pkshih/rtw.git


