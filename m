Return-Path: <linux-wireless+bounces-29060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0665DC65D2B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 19:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE91035E0AD
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E68331A7D;
	Mon, 17 Nov 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kUfpnopT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F475328604;
	Mon, 17 Nov 2025 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405548; cv=none; b=Apap0AphS5bhqC/BR7j58Duho/NAQ1dPMm7uE2qbZW1qPilhtNKoucdlaZnD8VfBzxvzJ0sNmwzg0cwpaFL6pX06jQdx+A3X7C7SWnsSyXt3yyqsxZ29mQ8JYjRXz9kSAr9Y3eexmdvFwNaxLg7Tnwtsgdn2IW8zXHwiiTbFSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405548; c=relaxed/simple;
	bh=n+iQrGP/xZhChOCsEjAIOM16ZiIUOS8b+KcHFWaPeuw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FlRFeMzwVxTF0BarRtJPLQ+nKFetNHn3SL3o5KscKb7UbbsR+U9BIdV7GC2piyKIb4Z1xbEQX5LQG8zB99khfpHsY/1la1v7JFHpW406bUsB9nBMunWhC4Wfg3C6eg8irkOIzTY/miT7nAW9WxaRPI/lAq1JIl550WucyLY1NsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kUfpnopT; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763405544; x=1764010344; i=markus.elfring@web.de;
	bh=LTxnLJkc0QXxGidC6w2t7wH8/9tceF7uhmhGEoLKRcY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kUfpnopTmYJPrxq8hXXpkKZl3vgeiAy9RuiiTtvzOlI/lMqXccRoBJp1FMg01c/x
	 excQ+F7Be6D+B8F3Ij6cligvxWz9coDOm8YgIYtRc0YjJHKsWfbOXIWpoBQjB1UKJ
	 1bBu3zFUTJ4cCP+iNbnzrQ01LMe7OxW0YJiY+IFOT1yEhtl1jg+RH8xufoHvC2xB/
	 Bb4RfrwFPCGaf4W6g6ecLBIWOWAToevEJ3VinbSM/1qmgfezYXO/zAm0JcsNGRgrG
	 XzU3affc/IdZlX1+7RR4+1VMAgLzXMQ6SamIwNSwGkM05dU1keMfgm8nUZirU0U6L
	 dAQOXW8nyQ2yew6Qdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.218]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mho04-1vq1NH3ze4-00lfw3; Mon, 17
 Nov 2025 19:52:23 +0100
Message-ID: <aa04fd38-a1df-4d16-bf16-e24a848a00f8@web.de>
Date: Mon, 17 Nov 2025 19:52:22 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seungjin Bae <eeodqql09@gmail.com>, linux-wireless@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Hin-Tak Leung <hintak.leung@gmail.com>,
 Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>
References: <20251117180955.1710801-2-eeodqql09@gmail.com>
Subject: Re: [PATCH v2] rtl8187: Fix potential buffer underflow in
 rtl8187_rx_cb()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251117180955.1710801-2-eeodqql09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O0ku9cG2skmN9kIDUeLvSc5RzUX+puVFW2dUAb/PykaVQlQKEBV
 +Kf7NvpdnRi75l2SnX5hTUjXKcZsNPByPGbJz5xuSQq1WZ6I/PIOsz2oozLdaFzd3Yn9bBV
 guhsfNxOAIwPn0EC4PdQE8LZMEBB7b60FJnbELrZ4zs+8BrazUt0dp5Hd5CtFO2Lj3ZSFTd
 9awkyB1QbuDKhSjsDCaGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QV8Tc9ygyxI=;XlKVifFrUxSAiQECRhspwYIWVPu
 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

=E2=80=A6
> +++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
> @@ -344,8 +344,13 @@ static void rtl8187_rx_cb(struct urb *urb)
>  	}
> =20
>  	if (!priv->is_rtl8187b) {
> -		struct rtl8187_rx_hdr *hdr =3D
> -			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
> +		struct rtl8187_rx_hdr *hdr;
> +
> +		if (skb->len < sizeof(struct rtl8187_rx_hdr)) {
> +			dev_kfree_skb_irq(skb);
> +			return;
> +		}
=E2=80=A6

You may avoid duplicate exception handling code by using a corresponding g=
oto statement.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.18-rc5#n526

Regards,
Markus

