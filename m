Return-Path: <linux-wireless+bounces-35543-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNRHB3By8WmggwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35543-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 04:52:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BDA48E726
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 04:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02F04301CFAE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 02:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683D324B2D;
	Wed, 29 Apr 2026 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="v2MfMUPE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C227CCE0;
	Wed, 29 Apr 2026 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777431149; cv=none; b=feNj7crvHEj7xFy8w/V1IcmoKzZ6TuAOQYgNVgTRIJyKZpo7oC1JHUPCTzt3kDflukOR9ITWRIcDnOVS5AAM5xUxpcuJXAuKzsKFSOSlm6neVriakxw4Vxa0XWEFCQVhBzd4AkgDGB81srjs6Ds/PINJE1SDgZeIqPy6s/woRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777431149; c=relaxed/simple;
	bh=fRO2+weWk6ONkFJWZxh9a6cu+SmV2rbBMN7uVgQT8Ms=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=J3jD6hI4pTB5ZqJSiQk9I/dzKsfcQ8o2wkevVQBcAfjg4wAOfm7JwcfCXoO3y3WYSX0YmGfEyyZ/GIkdcp6QTRU6JxEUVLdybjWqZE9AFnlWbNL3SYrnIntCjHyt9K2Qy3x2PNin3n6NEOUvJvCtYSDOi5ywhZK+eQyM7M2yvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=v2MfMUPE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T2qNs25911152, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777431143; bh=FzidWkoEm9ZwLtkZ6hIACQ8RLpQ6i5ChcbW5zzvI/9M=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=v2MfMUPEns3W8yB3bv3D93XQuIvWoVDt6nu0R9uKva2spzfU7jhAotE9XO1I0z/Ch
	 hiCvvZpjZ3i8+Sxcd92iebzsrSnDiBKm6wQlzBjHJUL9iJValqq/JVN8ibTyu/DDIC
	 PXhP+8WSbgH/3SdnQiEdU5K43jWNnyVu6z35fpJjol8lwpiv6zJupNaTiUF8a6GGfO
	 +PG0G77Jp+pOUrPxSqorvEXzVdXGtWk5gSQ314mOvUKfH6gRWRgPPJb7HaFCvpdfr1
	 s++tOo6DbNlTXIUmxKSRrcu/GQor634If2gHg4h8kMe6TLjYkaWHceiOwSlt/kes0j
	 BfyA2MTkvmTSg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T2qNs25911152
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 10:52:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 10:52:23 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 10:52:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Christos Longros <chris.longros@gmail.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Christos
 Longros <chris.longros@gmail.com>
Subject: Re: [PATCH] wifi: rtw89: fix wrong pci_get_drvdata type in AER handlers
In-Reply-To: <20260329073857.113081-1-chris.longros@gmail.com>
References: <20260329073857.113081-1-chris.longros@gmail.com>
Message-ID: <411d1fc5-bd39-49e0-9b46-1a40daf09bf3@RTKEXHMBS06.realtek.com.tw>
Date: Wed, 29 Apr 2026 10:52:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 66BDA48E726
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35543-lists,linux-wireless=lfdr.de];
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
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Christos Longros <chris.longros@gmail.com> wrote:

> rtw89 stores an ieee80211_hw pointer via pci_set_drvdata() at probe
> time, but io_error_detected() and io_resume() retrieve it as a
> net_device pointer.  This causes netif_device_detach/attach to
> operate on an ieee80211_hw struct, reading and writing at wrong
> offsets.  The adjacent io_slot_reset() already does it correctly.
> 
> Use ieee80211_stop_queues/wake_queues instead, consistent with
> every other queue stop/start path in the driver.
> 
> Tested on RTL8852CE by calling the handlers from a test module
> before and after the fix.
> 
> Signed-off-by: Christos Longros <chris.longros@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

7068c379cf9a wifi: rtw89: fix wrong pci_get_drvdata type in AER handlers

---
https://github.com/pkshih/rtw.git


