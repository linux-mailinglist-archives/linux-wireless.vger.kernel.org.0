Return-Path: <linux-wireless+bounces-34479-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMeMIA8o1WnB1gcAu9opvQ
	(envelope-from <linux-wireless+bounces-34479-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:51:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D053D3B155A
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06A8030B077A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044B3CAE80;
	Tue,  7 Apr 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="OiTByfre"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8353C5522;
	Tue,  7 Apr 2026 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576548; cv=none; b=EV7jAIcR4sAWQpnhGgjopDiVkiCRmbMensAcSjv7mmxQuG8CRDzV6zGrr4jPNzo/O292NzaFYavhKW5fINq38Z9KoNhHQzEnAv03mHHRDziZmSyvd12K+J8maVFFdSUJKYD9MjujPA1fIfMZHnaa0VbtUpEkDd/PmKO+RdYwrnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576548; c=relaxed/simple;
	bh=ZdukmGPr32uKMT3hUIvJrsG8XDUJH7rwxzNXZ36hCk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V73Bn5TUOZW0DhUgXpawiOh8X6Rqpbbt3L3geMepmK6cAOFYcw9RYPZLl48pyuufIq8sswPBTXbSmWGf36W0txP/6s0m7Aca6JaDKoMsukyMp6p3B9qSi0HDAk8Bn2rpnKuAVKz35wr6WmtJf9/Njn8n6pESQ6k2MYMz2TpcAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=OiTByfre; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 249582C506C;
	Tue,  7 Apr 2026 15:25:35 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 76285A80070;
	Tue,  7 Apr 2026 15:25:25 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.38.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id C900D13C2B0;
	Tue,  7 Apr 2026 08:25:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C900D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1775575523;
	bh=ZdukmGPr32uKMT3hUIvJrsG8XDUJH7rwxzNXZ36hCk8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OiTByfreOgsKqwGFK3UvF3ct58qv0l5gS/Bj15Yf6ZU/oOqFEFl2qHDmo4dx089m2
	 xrQMSd5BZXaAeMV4ivwU32YiXTEAJvC7hwcBQrAdBoL3AmOmhCPc7oBkbwYfLwzrlA
	 EVQJ0lWz0v9Yiaj02NoO8tWeQsL9bUhhBmAe0b08=
Message-ID: <d4622e31-4012-4c05-9288-529b0bb0aebd@candelatech.com>
Date: Tue, 7 Apr 2026 08:25:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless 4/4] wifi: mt76: mt7925: fix RCPI chain 3 mask in
 sta_poll RSSI extraction
To: Joshua Klinesmith <joshuaklinesmith@gmail.com>,
 linux-wireless@vger.kernel.org
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
 <20260406234739.29926-5-joshuaklinesmith@gmail.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20260406234739.29926-5-joshuaklinesmith@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1775575526-qrLPDTSfbSZ1
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1775575526;qrLPDTSfbSZ1;<greearb@candelatech.com>;cd1e1c133c9805f1fc8e076cc471adaa
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34479-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:mid,candelatech.com:email,candelatech.com:url]
X-Rspamd-Queue-Id: D053D3B155A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 16:47, Joshua Klinesmith wrote:
> The fourth receive chain RCPI uses GENMASK(31, 14), an 18-bit mask
> spanning bits 14-31. It should be GENMASK(31, 24), an 8-bit mask
> for the fourth byte, consistent with the other three chains and
> with the RCPI3 definitions used elsewhere in the driver
> (MT_PRXV_RCPI3 and MT_TXS7_F0_RCPI_3 both use GENMASK(31, 24)).

Hello Joshua,

How much of this is AI driven?  As far as I know, mt7925 is a 2x2 chipset
at max.  So while the patch may be correct, it may also not matter in practice
and at least may not need to be backported into stable.  If it is a minor
cleanup that doesn't actually matter, that should be described more clearly
in the commit message?

Some of your patches are touching tricky parts of the code and making
subtle comparisons against how the vendor's driver is written.  How well has
this been tested and reviewed by a knowledgeable human in general?

Thanks,
Ben

> 
> On devices with fewer than 4 antenna chains, the corrupted value
> is masked out by antenna_mask in mt76_rx_signal(). On 4-chain
> devices, this produces incorrect ACK signal strength readings.
> 
> Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> index 6334019249..85e91ca84f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
> @@ -144,7 +144,7 @@ static void mt7925_mac_sta_poll(struct mt792x_dev *dev)
>   		rssi[0] = to_rssi(GENMASK(7, 0), val);
>   		rssi[1] = to_rssi(GENMASK(15, 8), val);
>   		rssi[2] = to_rssi(GENMASK(23, 16), val);
> -		rssi[3] = to_rssi(GENMASK(31, 14), val);
> +		rssi[3] = to_rssi(GENMASK(31, 24), val);
>   
>   		mlink->ack_signal =
>   			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


