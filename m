Return-Path: <linux-wireless+bounces-38543-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 484/K4khR2pNTgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38543-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:42:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 053E76FDFC8
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:42:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=BRoFY9We;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38543-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38543-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B12713028829
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 02:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F4F23EAA6;
	Fri,  3 Jul 2026 02:42:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8870233949;
	Fri,  3 Jul 2026 02:42:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783046534; cv=none; b=XlCh08Q7Gv/57xLb0NNi+hqTPDyKXQYdBG5zR+TXN/XtcXnw8V0IwuVOFnvXWmOqsvPmyBO+if22KT2A0qc2Kuy4xYGHuUNf1c6N69Erv96IEWd9o96fMUDekDY9nF91yShJi9YEg6D7GPmcBJWricmmH5K31q9FOTKXrc9grLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783046534; c=relaxed/simple;
	bh=eg7c1CT/hVwTGt5YThgqzONmu9hgvdz3OQKDVotvS2E=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=fdNjQxADOnBYhlM2UKn+Ik0hJUQHBEmxhrJmCwAu0ZLDIP21gYpqJ7g9CX2Bf9y/AjhOLHePrDHeYJQDXPoa+nNRzY4hQisYCXSINhz49WokGPbq1u6qPsXdw63s7gxs82/9dWnTKkG9QGGQKh+u2VN7AOSNQYwtUnyxQ1BqFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BRoFY9We; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6632fdDcB2394910, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783046499; bh=8nIhyMlAwULqvV8BE7UNb7PJkQpHKJyT0PHmLLJ+dns=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=BRoFY9We5XuVbx6kj7XOQnMV9Ua6OgqAg0f+quq31Xo4IMQkLir3uBUlCDI97iaIX
	 CuSZful/JXE55EV9cr/U3JY1lx5jvNGQeAY69lER96aMDzVqpoOWbMP/tOeqp3GN3I
	 vYhCypLgs/awIKKGn/RnuLiIaWvXzDGcL/f1XtCYF02Z6oiZNZo9l/wYYMr6gNX/eW
	 kG1rdDNgLDhojvLkSVkdwqeUZf8GygBCfx+yVUOQae2+utidOH1JjjtoyY/zB575Fe
	 zJJn9krmEn9cGXn64kF1bvmZ9OsN90Wp2o9Kpx43koMCwpcwOAvZr13LrJitP2ziN3
	 FKhV1zKakeTIw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6632fdDcB2394910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 10:41:39 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 10:41:39 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 10:41:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dawei Feng <dawei.feng@seu.edu.cn>, <pkshih@realtek.com>
CC: <leitao@debian.org>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jianhao.xu@seu.edu.cn>, <zilin@seu.edu.cn>,
	Dawei Feng <dawei.feng@seu.edu.cn>, <stable@vger.kernel.org>
Subject: Re: [PATCH wireless] wifi: rtw88: pci: fix resource leak on failed NAPI setup
In-Reply-To: <20260617013502.114057-1-dawei.feng@seu.edu.cn>
References: <20260617013502.114057-1-dawei.feng@seu.edu.cn>
Message-ID: <f7fe49cf-8b0c-4a9e-8e2a-277a7bd15b9c@RTKEXHMBS03.realtek.com.tw>
Date: Fri, 3 Jul 2026 10:41:33 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38543-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:pkshih@realtek.com,m:leitao@debian.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:email,realtek.com:dkim,vger.kernel.org:from_smtp,RTKEXHMBS03.realtek.com.tw:mid,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 053E76FDFC8

Dawei Feng <dawei.feng@seu.edu.cn> wrote:

> rtw_pci_probe() allocates PCI resources through
> rtw_pci_setup_resource() before it sets up NAPI. If
> rtw_pci_napi_init() fails, the error path jumps straight to
> err_pci_declaim and skips rtw_pci_destroy(), leaving the PCI
> resources allocated by rtw_pci_setup_resource() behind.
> 
> Add a dedicated cleanup label for the NAPI setup failure path so probe
> destroys the PCI resources.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing current
> mainline kernels. The tool is still under development and is not yet
> publicly available. Manual inspection confirms that the bug is still
> present in v7.1-rc7.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have a
> suitable rtw88 PCI board to test with, no runtime testing was able to be
> performed.
> 
> Fixes: d0bcb10e7b94 ("wifi: rtw88: Un-embed dummy device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

e779df4806cd wifi: rtw88: pci: fix resource leak on failed NAPI setup

---
https://github.com/pkshih/rtw.git


