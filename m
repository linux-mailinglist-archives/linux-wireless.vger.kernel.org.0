Return-Path: <linux-wireless+bounces-36858-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCa3KuHtE2qHHgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36858-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:36:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B68A5C68A4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB846300461C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 06:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C653A7848;
	Mon, 25 May 2026 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="q4PqZqL2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932C361DC1;
	Mon, 25 May 2026 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690973; cv=none; b=doouphZG4FPraHYl44M29A9sYR9OADcnYkpTB8SjPIyLy4vUl4L4j6kdwZO24Y6y6augpQ2RFSx4tzq2GSx5qYiINjyesAE0/iE64sw3qtOt9dhVw4Ww/m/kOjldhiwUt+TpfNYmqpwqfgFnp2Nn5/0F4P2C4vqWPZPm9oPdd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690973; c=relaxed/simple;
	bh=+cA2uzePIoGGi27jZySZOY5L7hK3CBjLbvjyvkHF/z8=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=VHKZhJligmilidYsQt0cP3rWnLapgS05Q9hS0uPL1a8oUGRgqGA2qsUNEazXbO1vVTaKAuuHOmjpAKgUaO3nILhuxWxAMpt8lsCj3kqGHIXkqtvips3yedfOQAHMcXGBrgabIvnNKMiODCTS8GmWuU/1RNcyAQZg7HwbnU0K4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=q4PqZqL2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P6ZuydE852404, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779690956; bh=8CynkIoScNpCQjGL4wFFFYhs7ha12R7kATzXWmfqx4I=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=q4PqZqL2ReJAks7etS0/ubws0Pz1OshfjySDKes6CnmnL13fV0Tl/ixnKvr8Yc8Vv
	 RV0WPwE2e0BgZXvuyeLylmwzBWHRTaQcz9JOxkBYjcWOpUTbW0x5NjK01p0ddSpFVB
	 gTaktDUVIv5+j40n617n6aKyD9Ns/6UKpyGTTLDZDoMcNMuGBgvZlUMRIry4er7xcK
	 a1hcFYYdYjnLpsS9FSHcpvgiF1zIv8cCWfWMW0vq7oO2Dg8x2AQYPu5p/38WQBd9PH
	 DlY4lyH77Ywim/IPPXBAGrAHILAbq0MpPtET7Xg+Co7Xx2wUKtKoHgVLVAS9UJuWmP
	 ucm7Mgwam6SHA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P6ZuydE852404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 14:35:56 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 14:35:56 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 14:35:56 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 25 May 2026 14:35:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <luka.gejak@linux.dev>, Ping-Ke Shih <pkshih@realtek.com>
CC: Kalle Valo <kvalo@kernel.org>, Luka Gejak <luka.gejak@linux.dev>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v4] wifi: rtw88: usb: fix memory leaks on USB write failures
In-Reply-To: <20260518142311.10328-2-luka.gejak@linux.dev>
References: <20260518142311.10328-1-luka.gejak@linux.dev> <20260518142311.10328-2-luka.gejak@linux.dev>
Message-ID: <10fd9682-1b20-4744-9dfc-50353b0aa65f@RTKEXHMBS05.realtek.com.tw>
Date: Mon, 25 May 2026 14:35:51 +0800
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36858-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[RTKEXHMBS05.realtek.com.tw:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:email,realtek.com:dkim,linux.dev:email];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4B68A5C68A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

luka.gejak@linux.dev wrote:

> From: Luka Gejak <luka.gejak@linux.dev>
> 
> When rtw_usb_write_port() fails to submit a USB Request Block (URB)
> (e.g., due to device disconnect or ENOMEM), the completion callback is
> never executed.
> 
> Currently, the driver ignores the return value of rtw_usb_write_port()
> in rtw_usb_write_data() and rtw_usb_tx_agg_skb(). Because these
> functions rely on the completion callback to free the socket buffers
> (skbs) and the transaction control block (txcb), a submission failure
> results in:
> 1. A memory leak of the allocated skb in rtw_usb_write_data().
> 2. A memory leak of the txcb structure and all aggregated skbs in
>    rtw_usb_tx_agg_skb().
> 
> Fix this by checking the return value of rtw_usb_write_port(). If it
> fails, explicitly free the skb in rtw_usb_write_data(), and properly
> purge the tx_ack_queue and free the txcb in rtw_usb_tx_agg_skb().
> 
> The issue was discovered in practice during device disconnect/reconnect
> scenarios and memory pressure conditions. Tested by verifying normal TX
> operation continues after the fix without regressions.
> 
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Cc: stable@vger.kernel.org
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

6b964941bbfe wifi: rtw88: usb: fix memory leaks on USB write failures

---
https://github.com/pkshih/rtw.git


