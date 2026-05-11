Return-Path: <linux-wireless+bounces-36264-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJWvIFg2AmocpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36264-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 22:04:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6835156D3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 22:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A31A3009534
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87632E8DEC;
	Mon, 11 May 2026 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="qVYKb7L+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108F328B5E
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529865; cv=none; b=SCqEMCpKOsZMwRTyfuyK72d6ltYishBwQT0NdahlSDH4nQTLw3Ir7gseNW6VYep7d/QiWz61m/dQ4/vQmX+HRz3mcq3b6E0h+Vx7t/WO/hi642+3I7dUHVg1/FnqDxBdfE6DAOUrC8pDQbBNbbtvi5Wd2rXBpz9Ja8bnqWQbGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529865; c=relaxed/simple;
	bh=dA6hLylhlWosG7c58rSUqa8iEFQ5WzADGJf5YNAzqsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZ8OgqmZq8TXOg3k89hruuTln5XPhhLEbCtghjwB28MfNf4JgD8Cb6ZQnls2sHy2pCRALJrhUPtANVP5u/jQT6M5Xp1z0qx23I3kWY6WosB4tdf5t/Z+6GaDh8Y80GJ6CPWWERLS5PxDaAy+s46CCyNsh6ZBv8DqZmu68FcEAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=qVYKb7L+; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1778529860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dA6hLylhlWosG7c58rSUqa8iEFQ5WzADGJf5YNAzqsQ=;
	b=qVYKb7L+oXZowLz+oOsDu9EETXd2eTWNi6ryCVe9XEWlWJZPM/4nNsWW1Ejlxs0goRmVVT
	D8W6OVFO1KXDoYS2xHq5Zo71a+QlhPsOuMrF3HcENUn/an3ylxCHXsbewkKrsWPPkJPtn7
	R7H2CM/BAz37XUmgzE20v4+0mctb6vG4CBdhh+D2UhEzWW/zkEhapnohVKF/7cE0waj6pw
	ZGTw17XmaK7KIk3LWGKlevHa6Vx8tEyc4H8QIbBmZC9OS3n1LD361307EPdfWvqZmsHs81
	NmMXxU0HcILtLbHhKGGqU5GjUoaRqzTlyC7C4fdNxS7MgWY7i8Ag2pkNavl93g==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: rtl8821cerfe2@gmail.com,
	linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: Re: [PATCH rtw-next v2 1/1] wifi: rtw89: usb: Support switching to USB 3 mode
Date: Mon, 11 May 2026 13:03:39 -0700
Message-ID: <20260511200339.33682-1-lucid_duck@justthetip.ca>
In-Reply-To: <639b2f23-bff3-400f-b5ef-e7d0c39196bc@gmail.com>
References: <639b2f23-bff3-400f-b5ef-e7d0c39196bc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 9C6835156D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36264-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 2026-05-11 at 21:14 +0300, Bitterblue Smith wrote:
> Are you quite sure you tested this?

Yes. Full test matrix is in the v2 cover letter (PATCH 0/1) of
this series:

- DWA-X1850 A1 / B1 (RTL8852AU)
- BrosTrend AX1L / AX4L (RTL8852BU)
- BrosTrend AX8L / EDUP AXE5400 (RTL8852CU)

Six adapters, x86_64 Tiger Lake xHCI + aarch64 BCM2712 / RP1 hosts.
60 plug-cycles + 30+ throughput cells captured 2026-04-11 to
2026-05-07. USB enumeration verified at SuperSpeed (5000 Mbps) on
every patched cell.

Per-cell raw evidence for the May 2026 expanded matrix (40 iperf3
JSON files per cell, byte-counter deltas, pre/post link state,
pre/post USB enumeration speeds, per-iteration timestamps) at:

https://github.com/Lucid-Duck/rtw89-usb3-gap/tree/main/evidence/may-2026-laptop

Per-adapter summaries:

https://github.com/Lucid-Duck/rtw89-usb3-gap/tree/main/adapters

If the Tested-by trailer should be annotated with the specific chip
list, I will add that when, and if, a v3 is needed.

Devin

