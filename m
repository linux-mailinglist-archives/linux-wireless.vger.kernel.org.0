Return-Path: <linux-wireless+bounces-15714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8086A9D98BD
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 14:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C00B22A1A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1051CDFA7;
	Tue, 26 Nov 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Pyp7gdG4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A3B652;
	Tue, 26 Nov 2024 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628698; cv=none; b=i/Qu41oz884zcql5T+5oEvGZvM6VjlG+S7C8rI4ZyGM/0wYl9dGVjbFgr0OyIOXcOVrNNgzS03x+6zSzxZ1CwSr1G7qRsedrSVEJc1z2cO0hq1veF3+YLUu5kTroAnvokbo/EgUXBXx/pIqGR/dyGuVJB0M0ZevKwhlxJblWJqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628698; c=relaxed/simple;
	bh=Wo98UZ03rJ4ph9vGG0mj88f90tnP38UMs5ZY21JIVRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLWplVhw94f4dsp3C18S8CAPtKHH9Uj038+gI4BuP/+CGvEqw/mk5ID0UtdyRWnR/E4KDmLzwobfia32y1EUzvjm7aSDb9XBp27mso2GRVrU5I9OpyH7Mk/88bXOcOLQEmdLucWuRdCwU0aaHyqNCFK9LBErGuHk+YErdT9OkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Pyp7gdG4; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732628682; x=1733233482; i=markus.elfring@web.de;
	bh=S+3lhfowuHUDjDqZ7fevoqD7+4vMhYt2ikMvfvG4nUA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Pyp7gdG4nFptFLC2iJZlXEA9JqWF9Uha5mAVWQ6PIa42RuLQGCA/qcoBa5AtfOKm
	 995Z1wk9oA0Pan03QvcMBDA/R3XmmBfjiIPqIVMHFkKWHiq9zjBbgC5usbxhV0djh
	 D19Yj/iZuC6aaA5oSMgz2byloViAquMmGoHLdSAP6eCm4ACgeqH16yUoTEG9RMp+H
	 luLyJiJrEs4AILw2CyMfNWaG9Vxywg8Cvdrr+UCgNsvm3HIs07WvmiYyJ8xrcQSJ4
	 mkQosjx02gkuHvjnboZvWpMlwzxiOtnEgAWd671pV2fsmUrzb3zYnBkzxX12s4fmV
	 oXajm7h0f0uycxh/TQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoNV4-1u4Pv02MlE-00ozsu; Tue, 26
 Nov 2024 14:44:42 +0100
Message-ID: <a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de>
Date: Tue, 26 Nov 2024 14:44:41 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Fix NULL pointer check in
 ath11k_ce_rx_post_pipe()
To: Baichuan Qi <zghbqbc@gmail.com>, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Johnson <jjohnson@kernel.org>
References: <4b1b5c12-3f81-4004-8eb4-44a9fbcc7223@web.de>
 <20241126023349.46421-1-zghbqbc@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241126023349.46421-1-zghbqbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xb09GLcy7iN1LTFduA2WL60gcNOz8k/VgMDjmiDYpH8s1JlYBEM
 F45rME3zaiWi3qpRliexFTq0e9R4Uh6zb4jO/OEc9zW+o+QnxdbDk/uQ93sdFogN/hQp8Y3
 ef99SrtJQ2gTvxYKgxGwNV7KGBULMMJ7vMnedy1xbqRckZosFgG6wSePVrkoPzRXLkpNE2Z
 gC2laZgpGwoLFXSDPSO1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2l3Gn42M+Zs=;+gf0qVuRTnfaDwbr6tIlNLetJ23
 DuTN6W7pT9Uldu+dE6BpRy6x5nfudDHl5cCwcCHxtlb651vzgDJfcRj5r0NgfYLUxSk2/D7v1
 2t/1hxKMSjZqAmp4IKDyR5wav0gp9L6BbA4PvdtoVxYEsDMVLQNj5zRgvJaSI5QfpO1srd7cZ
 Wj7T5niqjE3F1/yJscEEQ/Bf1Xk2PqXvzbab9YgDrkt9aiPoSIo9lmA/lhYhfgVqvtYMnq8n4
 41wxYkuxOWXoRsREOavSHUzQk3PIqehrvSOSOop/7jZ73CsIrpKqOYCSMJPKuq2aRc9AnSPSS
 quSkZC9AFV7Kjwt02ol182vihslDiY5flyw+kUo74djBmYqqudByObdJYEwPcmNXKpe064nut
 ijx+VyIB7FOrgY4D8wyaWadf7vvdz+BX/f1cIrRSqeolcglg2HNP5BUYmtsXnlF1cnjscFdtO
 +E4oHyF6Q+P87j24GVu7fO1C068IGCB4F3gOuAlpHQXw2BQ0tCaRdfpUGZNDqYBa3nfJ1iFxB
 znjNUlzA+9QiYCjuLCMuWk4YJRS6zNwggOzx0lyjdMmxl9NRbEg4y14M358r/00aNwtWkr4dy
 3qauRRssOkpk0GpLJLx1nRSgv2naSiQBkFdKG3ghN7Q7zFGLYDMLf4D96G3bC44t5IrfAUrlh
 LIFjlIivDboGbk2iRYPp0UIJo9l7RutbeJdFv9F42YYcOWk9nVGzZGwghSEdbLs5diJ+IyZer
 SnBlWb23Xx3K7zAB1Ju2fJ+N6LBHS5GnEcHsNGJZVQJrKSU5ZeWkwBl+kiCczkKNfQxTUzXlx
 v3tN9TwfLOIDf1Z3cTz1cl+bacftXf5F+jmZA7qP6FrZEOoN3kKc8kcagV2aUZVUeJdzAMA4V
 FG29w5mDgC1nyNwpGhNb7uS+kO8B8HOrgirvxiMyCaEUuWIa0vf8ITAeH

> Change the OR to AND.
> The previous code =E2=80=A6

I would appreciate further improvements for the change description.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12#n145

* See also:
  https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+p=
reviously+submitted+patch%22


=E2=80=A6
> +++ b/drivers/net/wireless/ath/ath11k/ce.c
> @@ -324,7 +324,7 @@ static int ath11k_ce_rx_post_pipe(struct ath11k_ce_p=
ipe *pipe)
>  	dma_addr_t paddr;
>  	int ret =3D 0;
>
> -	if (!(pipe->dest_ring || pipe->status_ring))
> +	if (!(pipe->dest_ring && pipe->status_ring))
>  		return 0;
=E2=80=A6

Is there a need to reconsider also such a return value?

Regards,
Markus

