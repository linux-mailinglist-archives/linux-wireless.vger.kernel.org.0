Return-Path: <linux-wireless+bounces-33049-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMC0FJdasmngLwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33049-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 07:17:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EF026D8CA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 07:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD4D13035023
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09B730EF8F;
	Thu, 12 Mar 2026 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHlrn9Dp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9F2BCFB
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296275; cv=pass; b=fCmneT7KHv2aRIY9kH/7YUpz24OPU3lUOOZWtqNTrgmd5qkYHKUk+hQk3AVu9+CpD4gnUkL2A2doZTPqjmjmSKLd/uNjF+Ht08bqK/w+EGBnxKJVyRVoOdoWoLiea52So2c34ubzaPftoDsI3SknQYG53iHWxkphNocoveC1pCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296275; c=relaxed/simple;
	bh=yzIDOUbOZrk55PQ+M+9XPmNrzWv2y+FHqMA8Lh5aO60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rs+2apZw1Qr9HCyHvtHcD0ISk5+qqzpDz33b8l2AYiV59VNlnPWvm2Ts6sPRRObHpBW/283YNoI5OQ7pej2irSSR+VUv2S7L46QBWl/N9JFhtQ7F8MbEk2ju8JSHtws0ECTOCjbj3e9JLeSqnBkvd0qpPtR03dA5yIMCzlY79i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHlrn9Dp; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so870442a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773296269; cv=none;
        d=google.com; s=arc-20240605;
        b=FVLT2226+lBVmMx4/311SHR1WP/zpfxs5/x89gFNOnaOBhZDIzK+Lm8+ur/vQaQFUK
         UL8WrDEuy12JHPuoYB89Cwf09Mt5d2TWbyk5rds2tVlnGGprqN0jhUvfv5aYgwqPNNnh
         1d3D9ie0HjOM7Qt3yB86Kua1jnRgH5+FMDrfrgLGLSmDNwF7y4mghH33ABDSuxu+j44G
         7/dUxWd2aLwXTYCKHwKYoY3gQt/ub2ReXW0z+Rt+/HSbvHYsMDEyvmHoTh1thpWKnobd
         UUGauOWWvGYY8ROKdLivOJwQMTggFPj7h8t9plgtv/thupdWiP2detdMmL2fXeK7YD2O
         g1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHPzRZcbkDUtrbsriUzk/SzaX/8U3ReA672FYbYTHUE=;
        fh=HTV88vbosctX5LGDsyodr5QQeWv2tSuZnG4fcyQfq9A=;
        b=aDBZImiJnU8WIatcW+58mmnZMnVt5R67ad93AHQAwpVvAyAIrU5zPTGSSzd1ziW7Gi
         3WK2O3zhavW2NXYMFckGVvZyu5xKhOM2QEZZMGQMrhZuAWxwGpa/wsqs3hdZULHEKpSb
         SBiHJC0+zJ5785zLyWOgfWEjaYdfJelYZaIDcI6Km3hTjKh/X/1sHbH7P6nyjXBZQT0n
         SRnkKRNvPbOFoFEao0YrD2czFZjSc6v0m31dKHwO+n2oAsTD3q/YfiGe1SyY+rJPAa2B
         siJQhg7weWegef+r1Da+mQz3ywW5p+dbZ6Lt6qilY4SjYP1yepPwHY0m0xqSAlekmOXS
         oZqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773296269; x=1773901069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHPzRZcbkDUtrbsriUzk/SzaX/8U3ReA672FYbYTHUE=;
        b=IHlrn9DpIlNFzG8+nlcOJkR78TumE01xvPodsKl9s9JIvAwJT3GQ+Cyt/Yv7lz+Sng
         y+wuuMWuZ+ldIpYKXRcNJpUYK2YjsBXo4TS4mEHlY7t74nlzEVi+fAZZdSlwry6x4nUf
         Dpwge/MUmeq5/R/rUybMAmYFc1ephSmVHUhMPhxx6PmmG7lO/L6k5nJUva4RbUYlREFV
         QFqpZxN09t5nvQdr/m8SUEttC9teOPdy2gEox2YE/N9LcdXD3ZDq1y7WFE/woJWZoCP3
         kOIKNjNMC/GCD6mvAf9v3/GXgtWDO/iC4h9tIQA521KPjoG0HKuSnEDIGXH08xVMRz92
         lL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773296269; x=1773901069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eHPzRZcbkDUtrbsriUzk/SzaX/8U3ReA672FYbYTHUE=;
        b=pfbLfUf/yeECN7Eyt5abAecLCr0HhniQdsGDNGhOE+HGyTd9q3CTe9/j/iUbr1s72n
         5vxriCcx3ADXQH9A3qlZ+1/UQydzeZcyaOk/KXAvhqg3mev/ep6a7Pqjv0ET6SeenR6T
         5urJgMP/8nVOW47PvPydCYWQiYd48mYuQ5X92OI0WRls5HkU76Hlk5bXEaXRrjqnzuUP
         Ez/ULmQuE504HBlAY9JFlDNATyCODlxoRsjfV2QIbXKCz9U+Y8lYH5Ubn9+IiUdkrt+m
         tpvE2KGqwCFXgkET1s6DBPIp2A4YYJyb1SFyYfxWQLA73AJOn6qCk7RjeULPblPkaNP0
         +mdA==
X-Forwarded-Encrypted: i=1; AJvYcCUBu3JehRgMfNJplVAggpD3giC3RuDYTc8q8P+zg4iaL5jBtqA/RCcQ5RJBmi3ZenXCP5aLsiEKlfdEBMYPUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvum1jdvMKQO4mQrafozCmsVMp3c4/YDdon4UPSKFUMahc8xmS
	ORf6TWC1l6Abxyqb9xoAQLQ6T7er/TvmzYBy626B9fEzFsPRAuz3k8L2AWbkddsGUu35e5klYjy
	2ufm36Y6FySiP9vgILdb/BomLR3qZEDI=
X-Gm-Gg: ATEYQzz7RuPeJaFm3DmXSG7FGmu2asbLUhKBRbyJAIwM130TqddswLyEM2mLF6+YYcL
	s9xGMntugbdltDmSpAZOPdGQS5jSBAA5CZ4ktTajhi7gPRqJDRHZ/sVTWlhmCiWxF8oLcj3u/EA
	ljlKwpWOVWedr/OpWGI7E3p2H5v7+ep7+qRzByBxa1mGn9JdaLexIBIvGlYoYZ+ObcnbMsRGeqW
	qoIgO2cS7E4ItnnKOs3AGRDclHkPrcEDIRDBP4qfZS2RUPxAXg9wHHIoW/YybJ1dvrDEa73EmHR
	04HqZmmLk0UBrw95FLRU
X-Received: by 2002:a17:907:9403:b0:b94:ec:4b42 with SMTP id
 a640c23a62f3a-b972e4f9f49mr285831566b.26.1773296268420; Wed, 11 Mar 2026
 23:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311085141.1634383-1-wens@kernel.org>
In-Reply-To: <20260311085141.1634383-1-wens@kernel.org>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Thu, 12 Mar 2026 14:17:37 +0800
X-Gm-Features: AaiRm50RQXmz4783YruXgbC2HTQFlCfjVKqyAmpl438m2_53WCuMHw0xi3TNFpo
Message-ID: <CAHrRpunHZhCfBwueaXQS46SA5JzAbbW5DVL2MF+m2tKvKyMZAQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for India (IN) on 6GHz
To: Chen-Yu Tsai <wens@kernel.org>
Cc: druth@google.com, Ping-Ke Shih <pkshih@realtek.com>, 
	wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, Gaurav Kansal <gaurav.kansal@nic.gov.in>, 
	Degrader Snehil <degradersnehil@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33049-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,realtek.com,lists.infradead.org,vger.kernel.org,sipsolutions.net,nic.gov.in,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,cra.ir:url,nic.gov.in:email]
X-Rspamd-Queue-Id: B9EF026D8CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> The Government of India has officially opened this band for licence-exemp=
t
> use via Gazette Notification G.S.R. 47(E), dated January 20, 2026,
> published January 21, 2026, issued by the Ministry of Communications
> under the Indian Telegraph Act, 1885 and the Indian Wireless Telegraphy
> Act, 1933.
>
> Gazette details:
>   Title   : Use of Low Power and Very Low Power Wireless Access System
>             including Radio Local Area Network in Lower 6 GHz Band
>             (Exemption from Licensing Requirement) Rules, 2026
>   File No : 24-04/2025-UBB
>   Gazette : No. 47, CG-DL-E-21012026-269488
>   Signed  : Devendra Kumar Rai, Joint Secretary, Ministry of Communicatio=
ns
>   URL : https://www.dot.gov.in/static/uploads/2026/02/88f0ac8c74eb6f69079=
34d17d0015ab5.pdf
>
> The Gazette defines two device classes for 5925=E2=80=936425 MHz:
>
>   1. Low power indoor
>      - Max EIRP         : 30 dBm
>      - Max PSD          : 11 dBm/MHz
>      - Max bandwidth    : 320 MHz
>      - Restriction      : Indoor use only (Rule 5)
>
>   2. Very low power outdoor
>      - Max EIRP         : 14 dBm
>      - Max PSD          : 1 dBm/MHz
>      - Max bandwidth    : 320 MHz
>      - Restriction      : None
>
> Additional operational restrictions per Rule 5 of the Gazette:
>   - Band is prohibited on oil platforms
>   - Indoor use prohibited on land vehicles, boats and aircraft below 10,0=
00 ft
>   - Communication with and control of drones/UAS is prohibited
>   - Contention-based protocol is mandatory for all devices (Rule 4)
>
> Out-of-band emission limit: -27 dBm/MHz outside 5925=E2=80=936425 MHz (Ru=
le 6)
>
> For now, add a rule for 6 GHz LPI. As the database does not support PSD
> information, the EIRP needs to be limited so that transmissions over a
> 20 MHz channel does not exceed the PSD requirements. This limits the
> max EIRP to just 24 dBm.
>
> Reported-by: Gaurav Kansal <gaurav.kansal@nic.gov.in>
> Reported-by: Degrader Snehil <degradersnehil@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Listed regulation in this patch matches official URL page (translated
by Google translation).

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  db.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/db.txt b/db.txt
> index e2842db..d54ef78 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -985,6 +985,7 @@ country IN:
>         (5250 - 5350 @ 80), (24), DFS
>         (5470 - 5725 @ 160), (24), DFS
>         (5725 - 5875 @ 80), (30)
> +       (5925 - 6425 @ 320), (24), NO-OUTDOOR
>
>  # Source:
>  # https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-96=
8f-0050569b0899
> --
> 2.47.3
>
>

