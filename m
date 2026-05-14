Return-Path: <linux-wireless+bounces-36400-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GJ/GvIhBWpySwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36400-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 03:14:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37053C99F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 03:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 777AB3017E7B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 01:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAB030BB91;
	Thu, 14 May 2026 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="suYSZ/dK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97072305E1F;
	Thu, 14 May 2026 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721264; cv=none; b=pI5aWFCak/oQ70AvycaegM2wDi/gQNGtIXEwngDmKVmICAvUntHTlhcYZOJ1DwyXkECmUAwPx8ycURvIDrk53fj/gQn5W48TEVCQUVDDY9gaIzp5g71CTXAM1yFEs2m/pIf6QSmywRmvq7ddPX0RLEZRoOM0HBq7OYXXqJAhwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721264; c=relaxed/simple;
	bh=2mLnsZ66PoWSs3tc4827VIjXLmT2xgxH5qBeFfq1K9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dGcpEGgEuxAQCBymL4K8xZ9tBtQFXUxSCi0Ihgic0dmjR7MXvLG3w+uHkcFszO0QelPYkDTow65bZckY0flhPWDPytxDCKSmNlLzyhs1Ymg5tuf95iLGc3uEAyWMRPdR5ilAI0RFWp0aTF1AVFG/xw4nvXZXxoyxeZb3f6DW7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=suYSZ/dK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64E1E9Dv81468763, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778721249; bh=fI9ro6RUy59Zipdprr5E2pmXOGlnQu3O4AleVr8SwjI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=suYSZ/dKeCfWg0dz2R9YSdck1d0NZRBVf0dgwgZYIIz+YnSKljn2ByZVGpsoUTsZN
	 BBKvIq16YgWSlRr33qQYFI7MFEZbmj5t/Xk653gXNl97/iJ0cNe47xmA3hKLLIj0fu
	 lmVQ+0DCRx0T6fu9i3SvAGXPuv2RRvKzjgVRg8U52ZmUxedU2d/DI1fEoxpSau+qc+
	 phWQ13nbnXOzAR+wqxANyBnvxMgECGwbKye+bAlEd+0Cp9MpwN2hlUCSN7LFyS2jrm
	 sr6GlWMpSgujjlG/aZmRdfhXvyHBlM4DHbnp/yU9aqrC3TO6HIgGhU1yilQc6H7iSb
	 DkTt+ZLCOH+Pg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64E1E9Dv81468763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 09:14:09 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 May 2026 09:14:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 May 2026 09:14:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 14 May 2026 09:14:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "luka.gejak@linux.dev" <luka.gejak@linux.dev>,
        Kalle Valo
	<kvalo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3] wifi: rtw88: usb: fix memory leaks on USB write
 failures
Thread-Topic: [PATCH v3] wifi: rtw88: usb: fix memory leaks on USB write
 failures
Thread-Index: AQHc4wPL8veVv0IqfU63ijjwNALo9LYMt8DQ
Date: Thu, 14 May 2026 01:14:08 +0000
Message-ID: <58194a9985494a9e947d5220281abab2@realtek.com>
References: <20260513181008.13470-1-luka.gejak@linux.dev>
In-Reply-To: <20260513181008.13470-1-luka.gejak@linux.dev>
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
X-Rspamd-Queue-Id: 0F37053C99F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim];
	TAGGED_FROM(0.00)[bounces-36400-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


luka.gejak@linux.dev <luka.gejak@linux.dev> wrote:=20
> From: Luka Gejak <luka.gejak@linux.dev>
>=20
> When rtw_usb_write_port() fails to submit a USB Request Block (URB)
> (e.g., due to device disconnect or ENOMEM), the completion callback is
> never executed.
>=20
> Currently, the driver ignores the return value of rtw_usb_write_port()
> in rtw_usb_write_data() and rtw_usb_tx_agg_skb(). Because these
> functions rely on the completion callback to free the socket buffers
> (skbs) and the transaction control block (txcb), a submission failure
> results in:
> 1. A memory leak of the allocated skb in rtw_usb_write_data().
> 2. A memory leak of the txcb structure and all aggregated skbs in
>    rtw_usb_tx_agg_skb().
>=20
> Fix this by checking the return value of rtw_usb_write_port(). If it
> fails, explicitly free the skb in rtw_usb_write_data(), and properly
> purge the tx_ack_queue and free the txcb in rtw_usb_tx_agg_skb().
>=20
> The issue was discovered in practice during device disconnect/reconnect
> scenarios and memory pressure conditions. Tested by verifying normal TX
> operation continues after the fix without regressions.
>=20
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Cc: stable@vger.kernel.org
> Tested-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



