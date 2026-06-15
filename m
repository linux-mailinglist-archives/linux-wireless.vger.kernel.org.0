Return-Path: <linux-wireless+bounces-37821-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l91xGMIEMGpiLwUAu9opvQ
	(envelope-from <linux-wireless+bounces-37821-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 15:57:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C66FB686E2A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 15:57:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=neat.no header.s=google header.b=BBrlMJrh;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37821-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37821-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=neat.no;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 132353004277
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF91990C7;
	Mon, 15 Jun 2026 13:55:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B88C3F23CC
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 13:55:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531756; cv=pass; b=EJSafbMPBAWQ1wHzAkWGCJ/Vz/25yG5e3TGl2hs0iVDUDZwbIPPvlZr0dYT7ti6d9DkqgmMQG8FUxNkfi2DqlWsGGE+DUa09IiE2f9+A8eLFieIoYvLAiYxuVJMyIqtENOguiem4qkCZ4kJfbomDQom7HWHqAqKuaEPAn6ZVzpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531756; c=relaxed/simple;
	bh=tYDIDYmmfodx29k4MPH+z/baLBL7bv66zPRJnPP1uvc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TMCkl9HQ1OKGsNOSX1sVwYk7+j4SetaBZ+j/ZCt6oB5NcvZVXBNwjDvhQpDUucEBTUj3uwaGzZhxFYupIsc3fPSfKTsZWE5de+HFgEwtG7jceQTZTf98eocWHhzTMChT4qV1qgvcPWYf7LakH0DBw0aQ1PwfWgOeM8gClUAvug4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neat.no; spf=pass smtp.mailfrom=neat.no; dkim=pass (2048-bit key) header.d=neat.no header.i=@neat.no header.b=BBrlMJrh; arc=pass smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e1c3f47d78so35385707b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 06:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781531753; cv=none;
        d=google.com; s=arc-20240605;
        b=g6l3GSEMDw0DSyfqpXov2bAajBpnq86pgKNbC9SyJtWezuM/J6Ryq3P00agcL6feiZ
         YSBSC7XMJNV7YYCLpCx/BKJRqHUwlvuQlgGU8zclHMn2Kjjc02PrwOerbtUd2+OZOH1C
         PZ9r0+uAxOw5OHStuT71/UFKD1wHhFCOWotFcuaP+OqxyDTekagdEcRRifk9trB1+Usi
         vIXSsgZPziLYb9shUD1u9+P33KP056AiPgj+FFuvthy+0yJd/1opri4dCTxWup8cHUnV
         CVfxVuZOqCcscqKuvPSxDIYcwOiJz/8cpO4mWQ1bfTLZHuv/KESifML65iq18fy5gnEn
         zlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OKU2fS4WHk0JiCO3vb8oiP/9KqipJ03iGGp0qNTfG3g=;
        fh=fNx1FSe3bM0x7jlYBd1zfXQPzQcp/Mml9XnxCq/2bkE=;
        b=AcspV8QEs8sDbkIyRPm8mz/GLws15oN3uNDQqRTSBirDEX7bnZXKZp7NabTZz9cVsr
         yrRoybQdXH2SUYwFiVLnsCeoDSKbomyD+hERNLYP/+pzmCeVXmm/lySa84Rx63SqsbTE
         Fw/5iBGRGLj6SorF1NFSPLQ8OVxDivqrqpXRkj2W4fW++FJC3J+NHYyBIpFzcb81Yonu
         psB7R+zHWQRuRBV1a0DNIIx97kk6xURVEjc+w34hUsyPsTPgIfw5vUVg8tjEur7e1gBu
         YslzFZ3xMY8qkePD9zCr5/EdJr70US+icxVOLDxF656bueKLK1dJtdI1Sf1KrSK//51V
         /ZVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neat.no; s=google; t=1781531753; x=1782136553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OKU2fS4WHk0JiCO3vb8oiP/9KqipJ03iGGp0qNTfG3g=;
        b=BBrlMJrhQ2s7FkwyocLfOGOTlQBaLXsOXmqgXJm+jFhKVi4deZFBrBSYnbtf2dl38g
         flGeQgXO8EQU7e9Ok5BTnJNgcDFILPE882PPxeMRfIiR/v3koNib/zT7givCM2L8sm8G
         s8Kh9UeMtqS9LMGDxszyGYL95nHKtqPrIyd6gCsYsZn1400lrYbl5GYwGdWjenNvD7fI
         MU046+HKaqBpwW/7FGqdYCuHrMTdKdAmPA4fo6E1qX6vlHpD5F+qCGKrEyyCQpQ0Y8ce
         5Ei0GTLW6BGt3Ur2R+XmPxJf01kcxjOBwFee4QHT7tfIMvhua4PC8q1asmOp+ZSEqYPm
         JOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781531753; x=1782136553;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKU2fS4WHk0JiCO3vb8oiP/9KqipJ03iGGp0qNTfG3g=;
        b=leFwfutbFdyGqQwa4IUQIcz5UyKSN91M/zQF2jo/zitek8P3hkyq7V48pznl9C+lcS
         Pw0VQtt2Oh5tniTqV8l3L1ZeciorecGEOnO4jOkvNCMp2L0T74kyR5X33BD5dvVT8HZU
         F3c1qbNt+lqstDe2H+KHOcMliq/qKgi7XaooXH10smAYHiwey3BYiCOr7zoSWng0ifoX
         hRFXAufNv/WGCQu1oqFwoFHDls5ztczEKDjqDhW2ElogPlJvokEpDyVN6/yH8D4Xs1o0
         /tIM9aghU7PUdCOBd6YRuYTV7M3PkNa7EvyrF6sNTC1f9QO/joOy7L/BAtc6ZDqAToGo
         urWA==
X-Gm-Message-State: AOJu0YwVtbIiOv+hL8lWv0v5wABcOdmlA5FCePOlENw3Du98lCjTmw5X
	BZ+CVcvdjzKixMgx3UdNOJeh7uKT/soiXylb/3jo+WTsRxDlIpffrZa4p2VSaD8ll4JIYnBHa6U
	dc5Cmo8gYSjHjjHTyTzZjlxBVwgkVvvfm57XildMxog==
X-Gm-Gg: Acq92OEo3732QKV/Py1AtxPBYaIR0r6/8l8zG/6zkjQ5FyfxPZsKckeeGvn/GvdwPVU
	MjrlQFHhGX+jiQtQwdeg/8PSCfYu62+dhWdcRFOGFF5UaQ/7E5ROfnuWPUgnxY6t9n/HzVgpZEd
	KITRN1YOZUU9BQv8+FtTQJs9mdPTDEAIOJjN2rRmt2yYySZ6TheECy6X9YW1co/SqcNL2N9XXXm
	T8ulyY75yCAyyqeUu+3HzX9nTibIAxL3gKMSmBcHqQ5wbYp5LnlihJ13wjKgxvF+hQX4RwaTeDH
	lpJ65g==
X-Received: by 2002:a05:690c:9c12:b0:7be:fedd:726b with SMTP id
 00721157ae682-7f7b9414a4bmr153711167b3.42.1781531753459; Mon, 15 Jun 2026
 06:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lucas Tanure <lucas.tanure@neat.no>
Date: Mon, 15 Jun 2026 14:55:42 +0100
X-Gm-Features: AVVi8CevtUtbIEY1DyJqbdpFEeGrLtPdlZM9coI2G7IJ2tPJti6o6zOWXNG4R1U
Message-ID: <CALt7t=EDVdn7eGbXgXWU8rgbek52+frbbeYMHwzbH7J0xGXWzg@mail.gmail.com>
Subject: wifi: rtw88: 8822cs/bs: Issues migrating RTL8822CS/BS from downstream
 to upstream driver
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Opasiak <krzysztof.opasiak@neat.no>, =?UTF-8?Q?Anders_R=C3=B8nningen?= <anders@neat.no>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[neat.no,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[neat.no:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzysztof.opasiak@neat.no,m:anders@neat.no,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lucas.tanure@neat.no,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37821-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucas.tanure@neat.no,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[neat.no:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,neat.no:dkim,neat.no:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C66FB686E2A

Hi Ping-Ke,

We are bringing up an RTL8822BS / RTL8822CS combo on a Rockchip PX30
board (kernel 6.1.118), Wi-Fi over SDIO, BT on the same die over UART
via btrtl + hci_h5.

We're deliberately migrating off Realtek's out-of-tree SDIO vendor
driver to mainline rtw88: the vendor driver hits memory-corruption
bugs we've been unable to get support on, and mainline is the better
long-term path.
That migration leaves us two gaps I'd appreciate your guidance on:

1) Power-parameter tables. Mainline carries the TX-power data as generated
   C arrays in rtw88xxc_table.c, while the vendor driver ships the same
   data as text files.

   The TX-power limits look like this (TXPWR_LMT.txt):

       ##  2.4G, 20M, 1T, CCK, //(1M;2M;5.5M;11M)
       ##  START
       ##  #3#  FCC  ETSI  MKK
       CH01  16  15  15
       CH02  16  15  15
       ##  END

   and the power-by-rate like this (PHY_REG_PG.txt):

       #[2.4G][A]#
       [1Tx] 0xc20  0xffffffff  18 19 19 19  // {11M 5.5M 2M 1M}
       [1Tx] 0xc24  0xffffffff  18 18 18 18  // {18M 12M 9M 6M}

   Is there any way to convert these .TXT files into the C tables? It
seems the vendor driver and the mainline driver power configuration
don't have anything in common.

2) Is there an upstream (linux-firmware) RTL8822BS firmware that
supports the UART transport (rtl_bt/rtl8822bs_fw.bin + config), or
does the 8822BS firmware still have to come from the vendor BSP?
   Is there a problem using vendor firmware (not released at
linux-firmware) with the mainline driver?

Thanks,
Lucas Tanure
Neat

