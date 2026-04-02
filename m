Return-Path: <linux-wireless+bounces-34311-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKoQBDgIzmkwkgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34311-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 08:10:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BEC3844A2
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 08:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2B333015461
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362A28E0;
	Thu,  2 Apr 2026 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SeLrjPVN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA52D978C
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110196; cv=none; b=Re6qLgK8YUW9a1laqksD2evNRHJOPsw1qnKvO4XJitA+8qZDDAC7ci+vj/LHhpA0F66NnUH8rZ7uSENGQJ8ShnMa63y+BIupp6xtPMmeMpRmsh5TSsW/XzoazPGnYiaiuwTB8xj4kWfoaWziEvJrJ2BBQ9k0UcvZzmQOJ1xB6Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110196; c=relaxed/simple;
	bh=n6j7oCxpaGg7M0Aosl3qvWo4C43nzkHP8a2wTAomQnY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=Px9Wy5L7MJYFSfBgeURNWbQRVcHymAXSclNKnIREnCe0o+EC/yLFG5O8xMXEVFgLKMkIwW67NfXN7iINvkgQZnf3xsKGHEBagxI/AWHMC+Bq2XaEIBzLqW5Fi9of+wVAv9clVRBrYyhx5FKgT+Lt6ZaGl/GLB+3mPFje3adjfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SeLrjPVN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63269ZpaC2581303, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775110175; bh=d891u1pSRdlVB8cA+pG3/NRl7EhpiO9N78w7wsCSFuM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=SeLrjPVNcPlX2kUGruWqoWdlNK5VGmbWcIXt5qOAmdrxS4xMpyjA2/t+tyacZdaOT
	 yzdZKr8f8c5QEZQe0fGA3DBdfViy3538/qc8ekuqCH7+RdMLcEkk1kgXA9JQJKo0RG
	 hDO8qYQKHbdVuy1EGeT+UP4e9bIpTLJXFYhlWh/HmtmXVZpgnDQrGWqmmjPoIYdtwB
	 tAoSFAHVXd0LmgkYvtzx8Vl297HeB4pRyVrABeU7+lWskCEZxglo6YCgE73WbKm/7c
	 N0hUZo+3jUVAmDwqhBWcpXDNcbDqw1Z9SPnS+KQzteN4cl4s1rHdiivwzEna3IOSjH
	 LmL7U6pFmQTfA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63269ZpaC2581303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 14:09:35 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 14:09:36 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 14:09:28 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 2 Apr 2026 14:09:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Lucid Duck <lucid_duck@justthetip.ca>, <pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <rtl8821cerfe2@gmail.com>,
        <morrownr@gmail.com>, Lucid Duck <lucid_duck@justthetip.ca>
Subject: Re: [PATCH v6] wifi: rtw89: usb: fix TX flow control by tracking in-flight URBs
In-Reply-To: <20260402052216.207858-1-lucid_duck@justthetip.ca>
References: <20260330025959.399018-1-lucid_duck@justthetip.ca> <20260402052216.207858-1-lucid_duck@justthetip.ca>
Message-ID: <69e45cc6-fe17-4ccc-8785-0e2527c6a166@RTKEXHMBS05.realtek.com.tw>
Date: Thu, 2 Apr 2026 14:09:23 +0800
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34311-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,justthetip.ca:email,realtek.com:dkim,realtek.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A2BEC3844A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Lucid Duck <lucid_duck@justthetip.ca> wrote:

> rtw89_usb_ops_check_and_reclaim_tx_resource() returns a hardcoded
> placeholder value (42) instead of actual TX resource availability.
> This violates mac80211's flow control contract, preventing backpressure
> and causing uncontrolled URB accumulation under sustained TX load.
> 
> Fix by adding per-channel atomic counters (tx_inflight[]) that track
> in-flight URBs. Increment before usb_submit_urb() with rollback on
> failure, decrement in the completion callback, and return the
> remaining capacity to mac80211. The firmware command channel (CH12)
> always returns 1 since it has its own flow control.
> 
> The pre-increment pattern prevents a race where USB core completes the
> URB on another CPU before the submitting code increments the counter.
> 
> 128 URBs per channel provides headroom for RTL8832CU at 160 MHz
> bandwidth. Tested on RTL8852AU (USB3 80 MHz) where 64 and 128 showed
> equivalent throughput, and on RTL8832AU where 128 sustained full
> throughput under 8-stream parallel load.
> 
> Tested on D-Link DWA-X1850 (RTL8832AU), kernel 6.19.8, Fedora 43:
> 
>                      Unpatched -> Patched (128 URBs)
>   USB3 5GHz UL:      844 -> 837 Mbps (no regression)
>   USB3 5GHz retx:    3 -> 0
>   USB3 2.4GHz UL:    162 -> 164 Mbps (no regression)
>   4-stream UL:       858 -> 826 Mbps (within variance)
>   8-stream UL:       872 -> 826 Mbps (within variance)
>   UDP flood:         0% loss (690K datagrams)
>   60-second soak:    855 Mbps, 0 retransmits
> 
> Reported-by: morrownr <morrownr@gmail.com>

I think Link for this case isn't strictly required, so apply it.

> Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

80119a77e5b0 wifi: rtw89: usb: fix TX flow control by tracking in-flight URBs

---
https://github.com/pkshih/rtw.git


