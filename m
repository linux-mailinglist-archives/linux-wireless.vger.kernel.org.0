Return-Path: <linux-wireless+bounces-37688-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zAo5OaplK2o68wMAu9opvQ
	(envelope-from <linux-wireless+bounces-37688-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 03:49:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2D3676315
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 03:49:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="MH6Z/wDu";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37688-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37688-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8835B30E29A4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 01:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E2B33F8D4;
	Fri, 12 Jun 2026 01:49:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE288189B84
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 01:49:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228963; cv=pass; b=coV6nBXNeoFjw5/GpGXIq46upKtyuDwmoVuZmFGG+VD4E4kZJV6vD8HwFl1FhxGRefsZKmlPuAPaInFaLDbRPHLBmCUe0KXjfDv+mXJm9g5CfWNAiKTTRJZg+Syq0EsVMhZrhEb2AZ12TVde69NRyrTnd27jNedZriRk3oZCJNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228963; c=relaxed/simple;
	bh=k/yLg8s0XHQpVqmfSBCS15YOtA/IhmtQG6SpKrCU07E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsvDDt798UHk25iSQjf7WgXG6N4M78FNjP78qzg6+qfKNSuLvFhcxlQM8bSLzZlxm9POCDYDCiXPsAXx1gfZSm7eWLdVsfocSD1SkmM/1llAlfueadbfbacKmmNNVq8FKZ/6rcXr7FxSzRvV41yaAP/hevjMLkBpSh1AS751my8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH6Z/wDu; arc=pass smtp.client-ip=209.85.161.49
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69e46524711so354128eaf.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 18:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781228961; cv=none;
        d=google.com; s=arc-20240605;
        b=Ep6WUuB24O3FVHi6Ncnd7hBElgd9q++OQKtBIEAHgHUqhqnlqEfZOnQ3pmqRdbYRLC
         zR3ub2flqUNMOsp4s7FKDg2mfPyzC3qYF/XNtUg95ujBMQVAy5LLpw9pPbmBgrCgAhnR
         KsAwQsa7wivx6mdA6TAuDV4XQqeqeQ8Xahbd/pncleKyO4kxh2z/Qy+HPGpAEbDk3Qr3
         mQXWqL97E79Iw1ZptWlbjoUvudN74K1gyn5PpTtUt17GFgHh4Y0RgvwY4yRcmGFUPMxq
         xGnzJjHwuGlnFUctFaV/UVi3QpsjHAIZayaoV6Hqp9jMwTONt+94HVuVPmll6d0IuFCY
         5gWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k/yLg8s0XHQpVqmfSBCS15YOtA/IhmtQG6SpKrCU07E=;
        fh=FNM59O5jNIF7oAThOYQ5nqtYPcI9hnlxdOohMrOh+fk=;
        b=SDeXJsRFMqpEb7trq3g6v1gSsWtFxc+6vK0Lcgek1rI03BSzEYsuI/IOgdB30lvH0x
         pZalErsFr54MP0PBKUxA8j9XXXUqUsaRMizR9lFVmpWnuTtmlX6RDOGdgdyHsyoJ49Ue
         Wu+88wqUivNlY6Ptfdd7WDQELstQhHN7Cm4N+6/UMEkBIW3TJVS/TDszxfk+75Y/Kfbc
         7RuLSd6uwwtdxHUz/8Vkn+5+4xJ8l7PyUiu3W+giWCLGdjJK02He8gD0UpSfQaaRYZlH
         8hE7gz+8I2BUb4iFMdx2xU/AzHdvC2bVx/MtKjCMjurFQl76xG3RFb3ZoGQnkwxQVfB1
         riYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781228961; x=1781833761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/yLg8s0XHQpVqmfSBCS15YOtA/IhmtQG6SpKrCU07E=;
        b=MH6Z/wDuWf6v/N4yU/YtExRt3oA6EMxHBlQh844tQVwNUZsYmIHCeoaAMcyw3x+yTX
         GFcvn6Ro9Rj7aQaHhKCvCt9pS93Qcmj1TCplpTFKK00l2RZP12xINBpfLkpqWQSaVg17
         DS3Z7Cj6H9w0OQVCFG0aURUzr1hCfBvpuvwnfQUrv0YQEjUD/Yc2L8UH8A002PPC5GMe
         PKfmrLnmwt6HPyf5VPWXm8dwc2Ob5qanv62AVao+YvfpYkGMeG00JKf/I8ruMhc62fDB
         xbJcdbEqpEh5xAkScqx4fsRyO6yKIBMNKwt5P3hFK3krrgwI/O7wC/rcU0Y5f3Qp8XTm
         miSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781228961; x=1781833761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k/yLg8s0XHQpVqmfSBCS15YOtA/IhmtQG6SpKrCU07E=;
        b=Fi7k2ZELTml7S03RAV0ivyHNgAiWeGavL2e4CfARrRxwkgsxzMvILtzBM0cceWPN88
         ju3h0MZXInKQCR8UE29RepzkSqkReIbwx4DbslAZtxxB5NHhKcXLtkmNVpgAdkMf8r8y
         6PXV3MTRfh0HG6AwYb23JMMoFKLYxP9K5yy77IUsELSbI7No2ycnqeC0xF+/nUulE2es
         RkRYvO5KH3Y16OjyvyDdnzFnS0uPI4RBmuun+5vyHspUPow8wLwCtziW/x2i6IPnZqLl
         czKdWHMbjD9y0R0joqEDRo2kGoUTcds63T9FFgMlVELPHy5fS4gzshztgJ/1EjRhCkr3
         frjg==
X-Gm-Message-State: AOJu0YzatHXPBIHwGm7hMwhj0GW+tW8laHvVaKWsNhRinHSL653th/CV
	eSHoFKcD2+RfSop3oBwyo4FzVI+5v82m4tC0Awzt/wm+rWufj1ygbyBcI0yVHjs1HWwTQsJAP/Z
	zTF+7NwH5XNEFu8JYRFsnm1fd2tYM1OyVWc/aqLfawkevVr0=
X-Gm-Gg: Acq92OE83HJ3PoPGTVGQoO9ddJVq///CRCJsc1lcb2GKJiJRge/dogpVjf43BiQbr8P
	RxVtY+tPoL7cxXDhS2LSwtr5j/vP7WSBogZIJX/Rh5TGiK1zAh1/XG74/EALm6jNEGJbhEqYtZ4
	n18orsqB8KfIx01PylIl7LFQuC2HBHU+Q5LLMZFdPcw5VA7ZaiLf67vTwWHh5QmzUZSsbCWOCtz
	IqSj1gSdZhUmYTC/N6b5VFGxWFDCcupvLCmPvfT+TXHjGOkmkBlb5Bue1Rn/Zpix/+vojzrB6h0
	bEeV7923
X-Received: by 2002:a05:6820:1ca4:b0:69d:e2fc:361a with SMTP id
 006d021491bc7-69edc6f436fmr591736eaf.35.1781228960782; Thu, 11 Jun 2026
 18:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALaig7Pf++Hqn_c4hEa8zXHKkJpbmfSk=Bet_W574o7eBKF6Rw@mail.gmail.com>
In-Reply-To: <CALaig7Pf++Hqn_c4hEa8zXHKkJpbmfSk=Bet_W574o7eBKF6Rw@mail.gmail.com>
From: Zitong Zhao <zitongzhaooo@gmail.com>
Date: Fri, 12 Jun 2026 09:49:39 +0800
X-Gm-Features: AVVi8Ce9Ncz2jqaxVpmhTCw9AKNqguzmtwufqUXZ5nQfclbNp2-nmox8y2xjVAw
Message-ID: <CALaig7O62JGRYW_dR7V0JqCBaZfDktfTUcJRx2DSWkB23yr3+Q@mail.gmail.com>
Subject: Re: [mt76][mt7921] Question about host-visible deterministic TX
 scheduling / TX completion timestamps
To: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, deren.wu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37688-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:deren.wu@mediatek.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zitongzhaooo@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zitongzhaooo@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E2D3676315

Hi,

Just following up on this MT7921/MT7922 question.

A yes/no answer on whether this hardware/firmware stack exposes any
supported host-visible primitive for TSF-scheduled TX, firmware queue
admission, or reliable per-packet firmware/PHY TX completion
timestamps would already be very helpful.

If this is not available through the public mt76 driver, could you
point us to the right MediaTek documentation / NDA / direct-customer
channel?

Thanks,
Zitong Zhao
Cyber Physical System Lab from Shanghai Jiao Tong University

On Mon, Jun 8, 2026 at 1:28=E2=80=AFPM Zitong Zhao <zitongzhaooo@gmail.com>=
 wrote:
>
> Hi mt76 maintainers,
>
> Resending as plain text because the previous HTML mail was rejected by
> linux-mediatek.
>
> We are working on a deterministic Wi-Fi TDMA research prototype using
> MT7921/MT7922 with the mt76/mt7921e driver.
>
> We would like to understand whether the MT7921/MT7922
> hardware/firmware exposes any supported host-visible primitive for:
>
> 1. TSF-scheduled TX or hardware-timed queue release
> 2. firmware TX queue admission / queue pause-resume
> 3. reliable per-packet firmware/PHY TX completion timestamps
> 4. TWT service-period control usable for deterministic UL/DL scheduling
>
> From the public mt76 driver and our local diagnostics, we currently obser=
ve:
>
> - RX MACTIME is available and useful for RX-side timestamping.
> - TXS can be forced for diagnostics, but coverage is partial/asymmetric.
> - WTBL_QUERY returns only a short status-like response in our setup.
> - TWT_AGRT_UPDATE returns ACK/status, but we have not found evidence
> that it provides host-controllable deterministic queue admission.
> - We did not find an exposed TSF-scheduled TX path in mt7921e.
>
> Could you confirm whether this hardware/firmware stack supports any
> host-visible deterministic TX scheduling or reliable per-packet TX
> completion timestamp interface?
>
> If this is not available in the public mt76 driver, is it a firmware
> limitation, or is there a documented MediaTek interface available
> through another channel?
>
> Hardware/firmware in our setup:
> - AP side: MT7961/MT7921e path
> - STA side: MT7922/RZ616-family, mt7921e path
> - Driver base: mt76/mt7921e with local research diagnostics
>
> We do not need confidential details on the public mailing list. A
> yes/no answer about whether such primitives exist would already be
> very helpful. If this requires MediaTek confidential documentation or
> an NDA channel, could you point us to the right contact/process?
>
> Thanks,
> Zitong Zhao
> Cyber Physical System Lab from Shanghai Jiao Tong University

