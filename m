Return-Path: <linux-wireless+bounces-34156-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG9DLLELymmL4gUAu9opvQ
	(envelope-from <linux-wireless+bounces-34156-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 07:35:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 529B13559AE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 07:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7E61300337C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61C4372B2C;
	Mon, 30 Mar 2026 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uwKoAPF+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4C19D08F
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 05:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848942; cv=none; b=gCRyuxhnJUBKXufyCsQ8OO4TpJGVfwrRX2ZGR5KsIcf/3w6dsGr2rnnSHr9kt/WnRUdNvg4pyFByNGbmjYTOPoamnR+OJFNu85AJrPehHNTvkpdBN2xpImEbjxE6piFAAzFaQpvzVcvvjb7+jAnzYzlm0j7pDDas7WkTClUi6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848942; c=relaxed/simple;
	bh=HeokTWib3R5nrDiQgWnMl6Ygsj9z7xVJmfbkOTZyjms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oc08fkXF261uN19XmrMN398OCFSZGRB9mHN6iS3VLU0i2lJpAtXbuSq0BWsbOCZTqjHMh9F8OsKSof34FJnN61sumKmE/fXCobtXcFZXxzvdK7h78bemMqJb7QiVpPI6h2fGaVoTYGHg8RZqGZ2qiTKsLc4UAX+whXY5M1Dvckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uwKoAPF+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U5ZDY10449377, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774848913; bh=Pq1fzyrKCHpsQ1qx2JktckPut3OdQ6/lUTmUGkaS7U8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uwKoAPF+NS3j1tuBJcnh4Fa2wGrJRTkJT2JDq5kSwNKMzTbU9UD3211+QH6vGpL0a
	 xVuGuR81kRPJR6f8SJ47uoew/uAdnpj71fGaqwzk6+IIbL7SvVKS1Lhr2KA9KMDjLN
	 fNYwgyDwksfDYYP88sD/FsHmtM0ihbDVh8ehEyScZqLJu/x0SgUZNUbutqF5mt0p5v
	 tCm9vccvX4VbmfcHKYgtNdWWfzybHLtLiIqkw3LEIHZvxKjhC4btZ+vqEr09qn3ztX
	 wkXJf9Xn4+oeGgcSq8XC1O72XoFLR3xdDMk2KGydYppqowdTz5fA9fZ67XonYsRe6Y
	 dkTucJm1oxhVQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U5ZDY10449377
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 13:35:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 13:35:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Mon, 30 Mar 2026 13:35:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lucid Duck <lucid_duck@justthetip.ca>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "morrownr@gmail.com"
	<morrownr@gmail.com>
Subject: RE: [PATCH v5] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Topic: [PATCH v5] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
Thread-Index: AQHcv/Fuj177y+zz6U2eN7A3kIOA9LXGjfXg
Date: Mon, 30 Mar 2026 05:35:12 +0000
Message-ID: <7d2304e23569410cbafb57d2bb8bfe39@realtek.com>
References: <20260323233347.158745-1-lucid_duck@justthetip.ca>
 <20260330025959.399018-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260330025959.399018-1-lucid_duck@justthetip.ca>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34156-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 529B13559AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Lucid Duck <lucid_duck@justthetip.ca> wrote:
> rtw89_usb_ops_check_and_reclaim_tx_resource() returns a hardcoded
> placeholder value (42) instead of actual TX resource availability.
> This violates mac80211's flow control contract, preventing backpressure
> and causing uncontrolled URB accumulation under sustained TX load.
>=20
> Fix by adding per-channel atomic counters (tx_inflight[]) that track
> in-flight URBs. Increment before usb_submit_urb() with rollback on
> failure, decrement in the completion callback, and return the
> remaining capacity to mac80211. The firmware command channel (CH12)
> always returns 1 since it has its own flow control.
>=20
> The pre-increment pattern prevents a race where USB core completes the
> URB on another CPU before the submitting code increments the counter.
>=20
> 128 URBs per channel provides headroom for RTL8832CU at 160 MHz
> bandwidth. Tested on RTL8852AU (USB3 80 MHz) where 64 and 128 showed
> equivalent throughput, and on RTL8832AU where 128 sustained full
> throughput under 8-stream parallel load.
>=20
> Tested on D-Link DWA-X1850 (RTL8832AU), kernel 6.19.8, Fedora 43:
>=20
>                      Unpatched -> Patched (128 URBs)
>   USB3 5GHz UL:      844 -> 837 Mbps (no regression)
>   USB3 5GHz retx:    3 -> 0
>   USB3 2.4GHz UL:    162 -> 164 Mbps (no regression)
>   4-stream UL:       858 -> 826 Mbps (within variance)
>   8-stream UL:       872 -> 826 Mbps (within variance)
>   UDP flood:         0% loss (690K datagrams)
>   60-second soak:    855 Mbps, 0 retransmits
>=20
> Reported-by: morrownr <morrownr@gmail.com>
> Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



