Return-Path: <linux-wireless+bounces-38217-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zW82KeucQGquggkAu9opvQ
	(envelope-from <linux-wireless+bounces-38217-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 06:02:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2D16D31D3
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 06:02:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38217-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38217-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E846E3013039
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 04:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12FD346771;
	Sun, 28 Jun 2026 04:02:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC1234405C;
	Sun, 28 Jun 2026 04:02:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619354; cv=none; b=liq7PhfEAfO5safbbhi8oei71XAQzZrg87Hb/Aj8QtLS5j/oMw6Fb+R/aNqMjs1OtEeG72qacV4QLWwL6h7FBIjkipR8OQFDtfywALIOVmqO0Yf60nbLJYosDa79hC7U5qjTFGVzGfRede5Jw8CNEhzR2ZNnWN0VJB+u/nOXZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619354; c=relaxed/simple;
	bh=vc4XTNmJz1rEpHrXNp2XuTBwKB28ZOC8/y8X5mdNf1E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Rzc0Iv6a6ZgTiuMEMxZRfvuOTTIOFrJJQsyYTQ13j6vwWFfHAhSf1d7CRnCMSPBYq1oKwCmZHCRkyyNQ1OB67dCErBrgPq+pJrkfVZkPZf1k91b4+jTlQuBqDqLUZYT+yX9B3os7KHTwYXzfRUhqP3QUtpN15DH42g2yd0uLoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S8;
	Sun, 28 Jun 2026 12:02:25 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: ath11k: ath11k_ahb_fw_resources_init: fix
 device_node reference leak   on setup failure
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626153619.52954-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:02:14 +0800
Cc: Jeff Johnson <jjohnson@kernel.org>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8107F859-E8FF-4A06-BAB9-51FE11249930@iscas.ac.cn>
References: <20260626153619.52954-1-vulab@iscas.ac.cn>
To: Kalle Valo <kvalo@kernel.org>,
 linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S8
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1UWFyfGFWUZFy8tr4Dtwb_yoW8Jw43pr
	4xGa9FyFy5Aa1xJa1xZr4fZFy09a4ayrWYkrsYy34furs5AFy3tF15XFyUXr1rJF48CF4U
	Xr42yry5GF90vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5zVbUUUUU
	=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEMA2pAixEc4AAAsF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kvalo@kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-38217-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C2D16D31D3



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:36=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> of_get_child_by_name acquires a device_node reference. When the
>  subsequent ath11k_ahb_setup_msa_resources call fails, the function
>  returns immediately without calling of_node_put, leaking the node
>  reference.
>=20
> Add of_node_put before returning on the setup failure error path.
>=20
> Cc: stable@vger.kernel.org
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax =
devices")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/net/wireless/ath/ath11k/ahb.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c =
b/drivers/net/wireless/ath/ath11k/ahb.c
> index 08d3a0c8f105..8a08275db40a 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -996,6 +996,7 @@ static int ath11k_ahb_fw_resources_init(struct =
ath11k_base *ab)
> 	ret =3D ath11k_ahb_setup_msa_resources(ab);
> 	if (ret) {
> 		ath11k_err(ab, "failed to setup msa resources\n");
> +		of_node_put(node);
> 		return ret;
> 	}
>=20
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=


