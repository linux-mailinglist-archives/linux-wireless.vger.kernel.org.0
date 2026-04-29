Return-Path: <linux-wireless+bounces-35544-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eb/HAyhz8WnbgwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35544-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 04:55:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9000448E755
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 04:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3F3930185F0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 02:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510BC271A9A;
	Wed, 29 Apr 2026 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="E2b9az07"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF94215F42
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 02:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777431332; cv=none; b=FZOisPqhEMoULRt0LIRGN5EQUVuDpJyTDlPTvM2iqKpjJWpwG0lCZ7IV+s4iA8K1Ux726t3hxtMGm7THAXusJl3bVsaaoGSAwfjmObVpGcXljUGF6+0xbWrzb8qRXDqRei++rWYNF+TopubRj49b2kjv72Ss9L1F4k5uEvzC/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777431332; c=relaxed/simple;
	bh=lH+6WBllpnCmz8XZG73/wBCaczMoA/k3xD9+YAfWNQE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=mVpT96DqRYIWJoy8Ryn2e4O0A3H6Z78Y+f05NdHjLgkt2Bn/Gel5KW2AaP0FEbdLg1TuXGI5qkf8O5Uo+LiIvaJ3NQklhCx84rZbh1qan+ZUjqAcHZMDJ/4OHkXaN6wbg1BKykehm2wN67NpIs7NtSeXALWKLeZH+XV0Z6jAkYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=E2b9az07; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T2tD661912039, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777431313; bh=gIYrxs40KOIzT3bQnTmOxez7QU5v1r2xTLDpLF7GCtA=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=E2b9az076lXDjqc0M7lOX8n5syzSnvAluxuir/kPIs17j9iucb4R7vPk2T49MO2/7
	 0uXj7s+7w+jlJP6d0msm8LHrayS9U3D993G7VbjPdBiw/kDyBgM5vS6bH/uZoUxNOD
	 EnaUqtPbN6C8ZaFq2OwHrNKqbUJ0Zs7GzHAf/bGs8F/XuRoPudpVUtpLcV8rkwuGG/
	 q/an4X+hjJEtY3IeY17drdMN/lF8wshJGc6uq2MzObnua+ewCuRd4nO4qeVcPOBK6I
	 P/FKJi3aFJs7KtBenKjGpRPwJgyl/Q2tKQwVqT/6jhifjU2OIJSgL/goeLfpzWLdch
	 rD6YNXmvRKtWw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T2tD661912039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 10:55:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 10:55:13 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 10:55:13 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 10:55:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, <pkshih@realtek.com>
CC: <colin.i.king@gmail.com>, <johannes.berg@intel.com>, <bhelgaas@google.com>,
        <arnd@arndb.de>, <linux-wireless@vger.kernel.org>,
        Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: Re: [PATCH v2] rtlwifi: rtl8821ae: Remove dead code in rtl8821ae_update_hal_rate_table()
In-Reply-To: <20260407123427.14612-1-chelsyratnawat2001@gmail.com>
References: <20260407123427.14612-1-chelsyratnawat2001@gmail.com>
Message-ID: <5164841d-9ba8-43fa-bb4e-36608118cabe@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 29 Apr 2026 10:55:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 9000448E755
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,google.com,arndb.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35544-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

Chelsy Ratnawat <chelsyratnawat2001@gmail.com> wrote:

> The variable 'mimo_ps' is initialized to IEEE80211_SMPS_OFF and never
> modified throughout the function. This makes the condition checking for
> IEEE80211_SMPS_STATIC always evaluate to false, rendering the entire
> if-branch unreachable dead code.
> 
> The error was reported by Coverity Scan.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d603f2cfa623 wifi: rtlwifi: rtl8821ae: Remove dead code in rtl8821ae_update_hal_rate_table()

---
https://github.com/pkshih/rtw.git


