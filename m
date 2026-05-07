Return-Path: <linux-wireless+bounces-36080-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA7+OHi+/GnSTAAAu9opvQ
	(envelope-from <linux-wireless+bounces-36080-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 18:31:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 863284EC42F
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 18:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E43803001FF0
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF54336EAAD;
	Thu,  7 May 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVbHTPAV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189803B776D
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171510; cv=none; b=nMcpy/wHuHhRl0B6nSbGOgkmSEIup+X0NzzYf8f3QoQoDPp9CyJpqLyVLlNyLk/0P2HtOWwoKwcM6bfJLA6r1LFdNU6vj5WCAZra5xJqhaAqvhv2GFsznCIDJithxhQ//Ny6cCU6umvvEcnoNj6K/qF6TjKXgIEWiNLupUhqQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171510; c=relaxed/simple;
	bh=pXaSTwr6SF5+9EYapof1jJc5b5kisnmHUKIU9Ei24MI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Kzb6rKsjkJ2++OUgrUF/MoaIRxChQXOoBZtQwydMNItpv7V+RAqsfw8E31T9XsOXmjb8dFfOJiregL8r2XWdYB5JLBbCPMbFFMvHV+QiUZmCneC5rJWhEiHgI0OFs2rwP/MkXfhgVRzZ3EKTnaZFMNkHGwn9XhmmtO905nojq7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVbHTPAV; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 07 May 2026 18:31:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778171506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENtXVSGTxn1voqd0nkqw8w327Dc3JzFVnzwPTKRp1rY=;
	b=ZVbHTPAVui49HJehuFLz41RN5WTw0FQfGRP7oPtbVoRdR96XcsjBfVS5WCgtk7aPvMHwW3
	fQZIVzDQz4NYss0OSOTD8owsRzNzj6HqmDP0fPOZCAhwiH08I+VtYMjMlUGa3/1P+Ag4no
	J/YI3dq8qu2P8L/MsiYy9BEtV4tjbiM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/2=5D_wifi=3A_rtw88=3A_usb=3A_?=
 =?US-ASCII?Q?fix_memory_leaks_on_USB_write_failures?=
In-Reply-To: <20260507162827.69168-1-luka.gejak@linux.dev>
References: <20260507162827.69168-1-luka.gejak@linux.dev>
Message-ID: <DBEAB6DF-B4E4-4C4A-A570-0CC0392B0406@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 863284EC42F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36080-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On May 7, 2026 6:28:27 PM GMT+02:00, luka=2Egejak@linux=2Edev wrote:
>From: Luka Gejak <luka=2Egejak@linux=2Edev>
>
>When rtw_usb_write_port() fails to submit a USB Request Block (URB)
>(e=2Eg=2E, due to device disconnect or ENOMEM), the completion callback i=
s
>never executed=2E
>
>Currently, the driver ignores the return value of rtw_usb_write_port()
>in rtw_usb_write_data() and rtw_usb_tx_agg_skb()=2E Because these
>functions rely on the completion callback to free the socket buffers
>(skbs) and the transaction control block (txcb), a submission failure
>results in:
>1=2E A memory leak of the allocated skb in rtw_usb_write_data()=2E
>2=2E A memory leak of the txcb structure and all aggregated skbs in
>   rtw_usb_tx_agg_skb()=2E
>
>Fix this by checking the return value of rtw_usb_write_port()=2E If it
>fails, explicitly free the skb in rtw_usb_write_data(), and properly
>purge the tx_ack_queue and free the txcb in rtw_usb_tx_agg_skb()=2E
>
>The issue was discovered in practice during device disconnect/reconnect
>scenarios and memory pressure conditions=2E Tested by verifying normal TX
>operation continues after the fix without regressions=2E
>
>Fixes: 87caeef032fc ("wifi: rtw88: Add rtw8723du chipset support")
>Cc: stable@vger=2Ekernel=2Eorg
>Tested-by: Luka Gejak <luka=2Egejak@linux=2Edev>
>Signed-off-by: Luka Gejak <luka=2Egejak@linux=2Edev>
>---
>Changes in v2:
> - Use ret =3D rtw_usb_write_port(=2E=2E=2E); style, and check by next li=
ne (in
>   rtw_usb_tx_agg_skb)
> - Remove unnecessary comment
> - Use ieee80211_purge_tx_queue() instead of skb_queue_purge()
> - Add testing details to commit message
>
> drivers/net/wireless/realtek/rtw88/usb=2Ec | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/wireless/realtek/rtw88/usb=2Ec b/drivers/net/wir=
eless/realtek/rtw88/usb=2Ec
>index 718940ebba31=2E=2E1bb922cc2928 100644
>--- a/drivers/net/wireless/realtek/rtw88/usb=2Ec
>+++ b/drivers/net/wireless/realtek/rtw88/usb=2Ec
>@@ -399,6 +399,7 @@ static bool rtw_usb_tx_agg_skb(struct rtw_usb *rtwusb=
, struct sk_buff_head *list
> 	int agg_num =3D 0;
> 	unsigned int align_next =3D 0;
> 	u8 qsel;
>+	int ret;
>=20
> 	if (skb_queue_empty(list))
> 		return false;
>@@ -456,7 +457,13 @@ static bool rtw_usb_tx_agg_skb(struct rtw_usb *rtwus=
b, struct sk_buff_head *list
> 	tx_desc =3D (struct rtw_tx_desc *)skb_head->data;
> 	qsel =3D le32_get_bits(tx_desc->w1, RTW_TX_DESC_W1_QSEL);
>=20
>-	rtw_usb_write_port(rtwdev, qsel, skb_head, rtw_usb_write_port_tx_comple=
te, txcb);
>+	ret =3D rtw_usb_write_port(rtwdev, qsel, skb_head,
>+			         rtw_usb_write_port_tx_complete, txcb);
>+	if (ret) {
>+		ieee80211_purge_tx_queue(rtwdev->hw, &txcb->tx_ack_queue);
>+		kfree(txcb);
>+		return false;
>+	}
>=20
> 	return true;
> }
>@@ -518,8 +525,10 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev=
,
>=20
> 	ret =3D rtw_usb_write_port(rtwdev, qsel, skb,
> 				 rtw_usb_write_port_complete, skb);
>-	if (unlikely(ret))
>+	if (unlikely(ret)) {
> 		rtw_err(rtwdev, "failed to do USB write, ret=3D%d\n", ret);
>+		dev_kfree_skb_any(skb);
>+	}
>=20
> 	return ret;
> }

I accidentally sent this as part of the patch series but it is clearly
not=2E Resending as a standalone patch=2E Sorry for the noise=2E
Best regards,
Luka Gejak

