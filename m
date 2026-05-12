Return-Path: <linux-wireless+bounces-36271-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDpQNCR2AmoYtQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36271-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 02:36:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6585D517E64
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 02:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15043301EB73
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 00:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17B7203710;
	Tue, 12 May 2026 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="EI1IxhMe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49BE2222D0
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546192; cv=none; b=Z87sknBxsOTm6tDn15BMZGpMfsh9YDKnivYBoc9d1DRQobZdUqlJ/Q/77j//JMczfgwC23NZ4QCudv6vmINUwYrhPeqnECECZqtv2eS/hMRTERWbI8iXBwSUNOWXUfwFTZ/HUFN2tQ8x5JRjQySnNS31B9TpGq4BgYK8D317vqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546192; c=relaxed/simple;
	bh=LQS5DFIHB301cUOE0xSXIC9M7nZjy8nhu2ln1Wpu/g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1rZt/QvEq0t8WjxsfRBS516e+GwHBuxgUCeDSc8GVWiRMdRWKJIH8UhijZ/KgLGCXQ5gH8J6JQneZi8bovCxfN/pCBkNrrKt/9uayhje8HTWY7jjY1vSmwtpo2WLHSDyrBKlwmHQYlvRxsQjOMkjM3aMQjfWs0/6bk7FPLHw+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=EI1IxhMe; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1778546178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQS5DFIHB301cUOE0xSXIC9M7nZjy8nhu2ln1Wpu/g8=;
	b=EI1IxhMe53LqTyM7W340zjKVA8UX6G5bzT78qLCKGzZbBUuombOFC339G1iuV/hbYzPr5C
	OFmn98wksW8tF857+euzl6ynGii1O1GMTkP9oMrlHG2UKR8PtWnzylxabIxMFX6ZH7GG4V
	3UX2FNZH1sk2ol1ffzOCebLwBopL/hiAkuO/wUaF25+Q6wltqxB9ChaAv0gi7fdnZIk0Rx
	2g/7y6/4xv98vDpr8xPMsTwOxJlPbFfXOqqF6/V20+xp9gHgV6Pk2ICcLyoawsa7JurP/k
	vA9QIYzTocuiivcCRtx5klEsbmVsrDf8EO5C1rFtWNwZhnv7+rBexJ/N6y3kew==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: rtl8821cerfe2@gmail.com,
	linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: Re: [PATCH rtw-next v2 1/1] wifi: rtw89: usb: Support switching to USB 3 mode
Date: Mon, 11 May 2026 17:35:59 -0700
Message-ID: <20260512003559.44110-1-lucid_duck@justthetip.ca>
In-Reply-To: <2bc415d6-f0ae-42ab-8ffa-19cfb1df5954@gmail.com>
References: <2bc415d6-f0ae-42ab-8ffa-19cfb1df5954@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6585D517E64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36271-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-0.977];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,justthetip.ca:mid,justthetip.ca:dkim]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 01:27 +0300, Bitterblue Smith wrote:
> Good, good. So how did you avoid the crash?

If you mean the crash at
https://github.com/Lucid-Duck/rtw89-usb3-gap/tree/main/evidence/crash-2026-04-11
-- that was BE-gen DACK calibration and is unrelated to this
USB 2-to-3 switch-mode patch. Four AX-gen adapters concurrent on
one xHCI host complete switch-mode and RF calibration without
DACK errors.

Devin

