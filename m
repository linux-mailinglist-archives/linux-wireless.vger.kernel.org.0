Return-Path: <linux-wireless+bounces-35547-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLMMH1x28WkxhAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35547-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 05:09:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF048E911
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 05:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA1BC305812B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 03:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BFF3803F0;
	Wed, 29 Apr 2026 03:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QOyuDbOD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AB36DA13
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 03:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777432134; cv=none; b=N0k8V75DoPFfaApLTVAfsWwmZCaewugx64V9CwJHl7ov0X5UxghafjN6Cz0Bm3b89EMi/BeVvO9EzXG+kYtgVCjWysNNv2f2A8fSmFoeLphDwPqhOPUwWlIEpbltURFQIieZNalmR2XgJ/YpQLw8zF8HFFOCDxmLhw8HZYYXgbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777432134; c=relaxed/simple;
	bh=+kNb3Xhx9cW3FsOxbzPihV/ZQlNIPm2NuC14pxJTiFo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=KJHfkQisUl2FUWWtKw63UReNo3+MMQx12h3KqoH3JpkqsRJdqWzr7a8q4qJQobcK0JwCw1JiIkDj4mrZEP8iN+mQ8rYwukMWgf7imSrj/XcigvK2Hloef2tyiwjOkuzrFJ6fK77nOkA7KgCUEiLc3z9vwHnrNI5GHgIPGZmMKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QOyuDbOD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T38mMQ2918743, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777432128; bh=fZclANPthNPa53ZTPcibc4pPkB3FDqCaIx9xQojrCFg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=QOyuDbOD6kj9qLLbPjvYgZ5uYs0Kdo4/bMgSXAsrlFUptWXe/gG3STDuil60yh9pQ
	 K9sx36TwRO0PY6fdTGKPSS/e6/h/k9BIJrcj/0Xa8J++NgGrhMrrNp6Ny44EYHhYet
	 4J3EbWZ4CNro5Z6y+0UtsJClA4GL0mKbLYe6CiQIPEgI8CZSPX90aMVbwlXvZC3PJD
	 iPhnyVtkXAO7ig3ugUJjTWrMKwGxnpS2IZm+GBA+G7CHKZ7HEBMLwV8/eK0pksqtnh
	 DOk63UE4Ro6Ug9dKylkuzlEdW4jIdfLdZeXGQgS/5OFkyaodchrv5jRDYNq4UkMUTd
	 AN6wCL8Fc3eQQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T38mMQ2918743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 11:08:48 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 11:08:48 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 11:08:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>,
        <pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>,
        Panagiotis Petrakopoulos
	<npetrakopoulos2003@gmail.com>,
        Oleksandr Havrylov <goainwo@gmail.com>
Subject: Re: [PATCH v3] wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()
In-Reply-To: <20260415052959.14844-1-npetrakopoulos2003@gmail.com>
References: <20260414194757.163339-1-npetrakopoulos2003@gmail.com> <20260415052959.14844-1-npetrakopoulos2003@gmail.com>
Message-ID: <bc8fe854-f605-4e2f-a9cc-59d18bd9491d@RTKEXHMBS03.realtek.com.tw>
Date: Wed, 29 Apr 2026 11:08:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 23AF048E911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-35547-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,RTKEXHMBS03.realtek.com.tw:mid]

Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com> wrote:

> It was recently reported that rtw_fw_adaptivity_result()
> in fw.c dereferences rtwdev->chip->edcca_th without
> a NULL check. The issue is that devices with the
> 8821CE chip don't define edcca_th in their chip
> info. As a result, when rtw_fw_adaptivity_result()
> tries to dereference it, the kernel triggers an oops.
> 
> Add a NULL check for edcca_th before dereferencing
> it in rtw_fw_adaptivity_result() in fw.c. Placing
> the check at the function entry avoids logging any
> garbage values.
> 
> This change does not address the root cause for
> this behavior, but it prevents the NULL dereference
> and the resulting oops while a more permanent solution
> is developed.
> 
> Tested on a 8822CE chip which defines edcca_th, so
> this issue is not present on it, but it still uses
> this driver and I can verify there are no regressions.
> 
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221286
> Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Oleksandr Havrylov <goainwo@gmail.com>

1 patch applied to rtw-next branch of rtw.git, thanks.

d5e6f353 [v3] wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()

---
https://github.com/pkshih/rtw.git


