Return-Path: <linux-wireless+bounces-35545-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMCVDcNz8WnjgwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35545-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 04:58:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB2B48E775
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 04:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0295030523F6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 02:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D1135CB66;
	Wed, 29 Apr 2026 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HvC8Yjf2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85930215F42
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 02:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777431487; cv=none; b=uOVqOLzu8HOZF0fUs/UTAwhzioZMVkhH8yDT3EvxXdS2ah8Fch/NYpsgWGoaTi0n5n5sJOu9aXLH7sYM/CzCuilgmIf6UJE5lMZFjb+3ib7A3abEqaG+zb/TLM+BbQbMW0NBmwbORyqiUgbn8aP/UEPnAuaYhn/MrRTU1BFYkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777431487; c=relaxed/simple;
	bh=pmCB65GbocIR9cGRvgDcygwo/pQkd5k/kVIeEueXVEo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=W/uBmutldTIfHsT0MvAOl2+ztj771p/b7Rko6B6uj3PFrw1dZNvMguPR4x2jJGTwu9LC/GJjbWw+0GB97zY+/COKEe7Lrbtx7mxhuFn1PBBJ8N6W/rDNP4qJhxu1Qwj9covm6o1jjllnFW8RRG/TkKJ81Jfc/pvNs7Hjkuq0PB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HvC8Yjf2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T2w4Z71912986, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777431484; bh=ZVFD4sS3c3tgphduiBcPT5m3jf8vMvi9Ug9bVzgLSM0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=HvC8Yjf23SRtCo2NaEJ5O1v5O68AtTTziFt7J/hLhyXsxDO47ejJuWpYC7dt2dwWm
	 vpxXuE9mm8w+u4zr5QpU/U6WA16dJyYoA7TM1uoIKNmjpEv175t15RYXW3G9tHGXV4
	 L+NXaXREHCOks297a9eQgyF18LNPzttzPV6v4kYH48diDwMFLk1vjCnw/zYbtNU+sx
	 txOVCWghPWaqElUXw2sGlCsKmniVu/l/JyhjE2B2ngM8Zp3FshkGNcg9Ts56h5GLHK
	 kdD63RcuWbkj4UnZWcF4kBRd4GARRHBYa1SFjd0hedJEnYrPMcyjVDgpeTi8/de/kL
	 iulJyN0zYAwCw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T2w4Z71912986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 10:58:04 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 10:58:04 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 10:58:02 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 10:58:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: fix wrong pci_get_drvdata type in AER handlers
In-Reply-To: <20260413065926.17027-1-pkshih@realtek.com>
References: <20260413065926.17027-1-pkshih@realtek.com>
Message-ID: <41258cbd-eb33-43fd-99bc-47eefa05163e@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 29 Apr 2026 10:58:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 8DB2B48E775
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35545-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,RTKEXHMBS03.realtek.com.tw:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> rtw88 stores an ieee80211_hw pointer via pci_set_drvdata() at probe
> time, but io_error_detected() and io_resume() retrieve it as a
> net_device pointer.  This causes netif_device_detach/attach to
> operate on an ieee80211_hw struct, reading and writing at wrong
> offsets.
> 
> Use ieee80211_stop_queues/wake_queues instead, consistent with
> every other queue stop/start path in the driver.
> 
> Fixes: cdb82c80b934 ("wifi: rtw88: pci: add PCI Express error handling")
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

706183dbef4a wifi: rtw88: fix wrong pci_get_drvdata type in AER handlers

---
https://github.com/pkshih/rtw.git


