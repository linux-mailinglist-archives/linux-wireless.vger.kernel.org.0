Return-Path: <linux-wireless+bounces-23533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F39ACAC51
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 12:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40FE17AA47
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD93139B;
	Mon,  2 Jun 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVs4LqEy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07DE1C32FF
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748859307; cv=none; b=HBkwmcj5yyHqHKfNDdLn5kgLr+3hRx3io8/eYoZKdgffbU6EPqS0VaWqnHdNb2/bVZYrVtF71sNfZWUfzV8t8Y7qVPnJuXx6hkYcr5JcEkW3XH1M33GkNLe1wIJvMvpLMZaRNGaDe9SoUdXTX6CetGJlBlyR+OzqGCVVvHBBNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748859307; c=relaxed/simple;
	bh=aRg01VzWPitoqxYPK0z9xsMS8cnxfIdXn+xbAB1kf/Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m+uofNwjek91507ONbwWkE81xYRQ12orF/WviOL42Oi5SlZsN/78tfqgd7vci7wzUvs0vMuj6ofLy67N4Aj/zP2geN0YNSVIknBBjuRd+s+Lqy6U8U6x8C9mc9FyqO0KaflW64E842Uc5E6S0EZIa5Z/xj408oYSWvwI5UukvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVs4LqEy; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-530807a8669so956576e0c.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jun 2025 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748859304; x=1749464104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+pZ4ibZngU0Ep/xNBg5QbX8BMIOPLddp+EmSkIn5lg=;
        b=hVs4LqEyvgk6UvvAuj98RdHPRCeAyOLfmZGLJeLbE55CK4k/808ltLIagZQ/teyKcB
         bZMCMrXjoWTKk2v86mSsalszoiN5SW2rSZfuZE8nwdpMZHuWCx5wHVOVKwAbRe+pb9fc
         Mzbfi5P6u0ZAUJB+ObYnq9AKjGg1tKGdqpg9X21NMOFiyXcpHN9jjF00s79wAq2n7I9N
         K8U+5rBBfCWKBAR93BYJVH9l8cKzgABdGq6uSzGnrrvAz7d2VWwd/P2z4WD0HdE8q4mo
         irwssI/AtWUzgPvFpq7cldOE97iZKB9eNZ6Xl/jVrGkfgEehsrAEfqFg9+VXK0oGzMDQ
         yklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748859304; x=1749464104;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+pZ4ibZngU0Ep/xNBg5QbX8BMIOPLddp+EmSkIn5lg=;
        b=Vw1UvRr/tZ3m6GFsNtGQQ5kNOhSK5eQBVbhLPZJ64PtiV2CJERG1IDLwnpW+YCtUUn
         tr5TDw4QU06E0HLtWhmKmpeqoBnN7TWps5uoPZiOlFZHp2GuwhDrQywf+yi8nBGgYKXa
         1j2TyOHEVcqF84F76KqojkGMhplwgoFLbblDGURbQ6F4zmwT+bktH+06SMRnQD+5JWhY
         Z71V+vM69SVFygRayc9JZdxkKf7NCSFv+TjdUoHkhM9QZVbj+o0PP3GQrMk42DOzEeM7
         YcbpfSpT8yJUIAnPbT2n8TCFypYIeutWA/pcTBfEU2X84eTNxrq/8N05pJMP2BQGXsR0
         ZMHA==
X-Gm-Message-State: AOJu0YxZGv6a2eSEM8GMjpefOb4SG1ts8hava3YDg6lrZcSJdcKJzYX7
	c58SECIMJmtoqa2fZi8Se/QgBohqJoZF0L8SnIvaiuGOp9WQa17POnTV7U3ong==
X-Gm-Gg: ASbGnct7wqmDr2KtCo24i/9Kq8Qg4NMrbDvTGOBhzH4+uQyo288mokRVGdr3ImOQMeY
	zJUhigNRh7gCZzrby+ayBGn61yiGK53Fb7oUD5yN0yDgRaFkcMpddfzw+vQO2nC1+VdZr0vqXQa
	iidcQJ7S6UlLF3nDIzcdgWqkAOM2PGSyOJW6bDGH7nUrFc+5QfES2aMsOg3Kr+UyCLSLs4mOayg
	BNppfeQIaSW5+wbW9l/ffeWmQibNfPgxCzi0/8WeHfRukshKiA4LUq7RZeU/xtTAQIcUVbm28LZ
	t6Ff4GxEZHtrTPDTONTw50t31PW3+nGgFj5ipUK2DYhQYRknjsOBYG05zme5jXkrf/W6K1DDsVH
	IglxOE+0p1AxYk1oAGj4IZ+rRnPo=
X-Google-Smtp-Source: AGHT+IH0WL0xwzki2yFzazOGPV3eR1o34uIuSU/swFMBOCrrWo+AjdoJtKHq+OSn0RRN6319Wl1n0A==
X-Received: by 2002:a05:6122:2a0a:b0:529:373:fcb7 with SMTP id 71dfb90a1353d-530937f716amr3692280e0c.10.1748859304037;
        Mon, 02 Jun 2025 03:15:04 -0700 (PDT)
Received: from [192.168.1.130] (177-1-191-98.user3p.v-tal.net.br. [177.1.191.98])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074ad91aasm7204562e0c.19.2025.06.02.03.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 03:15:03 -0700 (PDT)
Message-ID: <028ac59f-b0d9-46c7-885f-642810b65c50@gmail.com>
Date: Mon, 2 Jun 2025 07:15:00 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
Content-Language: en-US
From: Marcos Alano <marcoshalano@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
References: <8bc290d6-5687-495d-b5d5-a8ca94cf2f7a@gmail.com>
In-Reply-To: <8bc290d6-5687-495d-b5d5-a8ca94cf2f7a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Hi,
> 
> The rules for Brazil were based on this normative https:// 
> informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680, 
> as mentioned in the comments of the entry.
> 
> This January came out a newer normative https:// 
> informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772,
> 
> It allows 6GHz frequencies, so the line:
> (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
> Should change for, at least:
> (5925 - 7125 @ 320), (12), NO-OUTDOOR
> The removal of NO-IR is important, since routers Wi-Fi 6E and 7 don't 
> work because of this outdated rule based on an outdated normative.
> 
> I'm no lawyer, so please if you see something different, like more 
> granular control in the allowed frequencies, please let us know.
> 
> Thanks,

Hi, I created a patch to solve that.

 From be7b64050691e85490f8adf1a39dd63a4c2192a4 Mon Sep 17 00:00:00 2001
From: Marcos Alano <marcoshalano@gmail.com>
Date: Sun, 1 Jun 2025 21:07:00 -0300
Subject: [PATCH] wireless-regdb: Update regulatory rules for Brazil (BR) on
  6GHz

Change rules for 6GHz in Brazil, removing `NO-IR` and adding
`AUTO-BW` so the 6GHz band can be used.

Add the relevant normative in comments.

Signed-off-by: Marcos Alano <marcoshalano@gmail.com>
---
  db.txt | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index e331d4f..3b0adbb 100644
--- a/db.txt
+++ b/db.txt
@@ -321,8 +321,8 @@ country BO: DFS-JP

  # Source:
  # 
https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
-# 
https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
-# 
https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448
+# 
https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772
+# 
https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnicos-de-gestao-do-espectro/2024/1920-ato-915
  country BR: DFS-FCC
  	(2400 - 2483.5 @ 40), (30)
  	# The next three ranges have been reduced by 3dB, could be increased
@@ -331,7 +331,7 @@ country BR: DFS-FCC
  	(5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
  	(5470 - 5725 @ 160), (27), DFS, AUTO-BW
  	(5725 - 5850 @ 80), (30), AUTO-BW
-	(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
+	(5925 - 7125 @ 320), (30), NO-OUTDOOR, AUTO-BW
  	# EIRP=40dBm (43dBm peak)
  	(57000 - 71000 @ 2160), (40)

-- 
2.49.0



