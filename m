Return-Path: <linux-wireless+bounces-36857-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBInEHPtE2qGHgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36857-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:34:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8865C682F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D583B301107A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D0A3A7F47;
	Mon, 25 May 2026 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JfoRNAz2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001AA361DC1;
	Mon, 25 May 2026 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690834; cv=none; b=M4kCiY6ujkH0tGTLG7oM0T/jWUVMgK5D/DE+ZUWOZu1NBaPD/3zs+UpNFWXTW6NSjBw9PoAGVpMiIvM1Vf1gAp6I6ocJ5fjJnA1KQzwN4W0d/Ed6YcE9YRM+maduMYgWBFNMFqeYp9+x8imBLLD4abu6OhrT5/AYcHPC6EZ0bBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690834; c=relaxed/simple;
	bh=KHatG7E1vKbMdt7JqhxQl99sIwwEsQNW158fXQzt8II=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=fxaAFyhL5UULpYzgcc/wzj3CvGp7j7Pm13Q0i0igNFycfkr+WfuSh3FJaF+GaRw2vjc1P9MFD7T4KgAI7eayEhRwdw8lRXDVq+dmqkT8aclxrJ7NPB7htVbU/s41fEYzFNFlvJO0/0QPdgOdjj9o0TgS37SaEEGQvWThSuVAFU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JfoRNAz2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P6XEsC4851405, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779690795; bh=AMmJRfJIDwDWgQWDDac+T18qxi5KQ8BJbVqUZdrWcyw=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=JfoRNAz29FYb/U370QrBqjYs2pI+Fjvz+zouHlvWe/WYTS8Pw1AsHYod3qCClRpwc
	 RsD76NCZqvAxlK10VpTd/sLCABFbO6tBWbIhBqTHvDbhOXN+2CcR3UKl6idXIvXVM4
	 dlJFeMO+wPcLIlx9JbOpABnMeTcvtmsOmzhCzPy80fo8embUPZqcrORDFIgRVVqIUT
	 i0Fx9n/9GvnCHZIx78/0m/pBW69mGdD31g1DhosvXiFLkEdj/Ltr0TYmIqhTwccII8
	 eBFmGDOXY+3AtNhsGKEnJ1vDR2xU9cwY3arSS2ysNOhSKmvgB7QosmH+rJcRKtN2GS
	 QPBozBhcu9hyw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P6XEsC4851405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 14:33:15 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 14:33:12 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 25 May 2026 14:33:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <luka.gejak@linux.dev>, Ping-Ke Shih <pkshih@realtek.com>
CC: Kalle Valo <kvalo@kernel.org>, Luka Gejak <luka.gejak@linux.dev>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v4] wifi: rtw88: increase TX report timeout to fix race condition
In-Reply-To: <20260518142311.10328-1-luka.gejak@linux.dev>
References: <20260518142311.10328-1-luka.gejak@linux.dev>
Message-ID: <6d0f9c92-bab7-4d2e-8d5e-30b10e5ddcae@RTKEXHMBS05.realtek.com.tw>
Date: Mon, 25 May 2026 14:33:07 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36857-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,RTKEXHMBS05.realtek.com.tw:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AC8865C682F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

luka.gejak@linux.dev wrote:

> From: Luka Gejak <luka.gejak@linux.dev>
> 
> The driver expects the firmware to report TX status within 500ms.
> However, a timeout can be triggered when the hardware performs
> background scans while under TX load. During these scans, the firmware
> stays off-channel for periods exceeding 500ms, delaying the delivery of
> TX reports back to the driver.
> 
> When this occurs, the purge timer fires prematurely and drops the
> tracking skbs from the queue. This results in the host stack
> interpreting the missing status as packet loss, leading to TCP window
> collapse. In testing with iperf3, this causes throughput to drop from
> ~90 Mbps to near-zero for approximately 2 seconds until the connection
> recovers.
> 
> Increase RTW_TX_PROBE_TIMEOUT to 2500ms for RTL8723DU. This duration is
> sufficient to accommodate off-channel dwell time during full background
> scans, ensuring the purge timer only trips during genuine firmware
> lockups and preventing unnecessary TCP retransmission cycles.
> 
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Cc: stable@vger.kernel.org
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

c80788f7c5ae wifi: rtw88: increase TX report timeout to fix race condition

---
https://github.com/pkshih/rtw.git


