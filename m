Return-Path: <linux-wireless+bounces-23524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F91ACA7EA
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 03:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA1E173C49
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 01:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3481F19C540;
	Sun,  1 Jun 2025 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixTtCn1s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9A19ADA2
	for <linux-wireless@vger.kernel.org>; Sun,  1 Jun 2025 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821789; cv=none; b=mCqRbstmsJBBAyDLCPu2gDWcwVgmv90zLwNrHhjCH2gEuYjrnQMjF2hLdkJlexe2T0IUltvLyn4WppYVEgHeKuPduhJtXDdlhE3J9DMPLbRO2Ucn8HjALDnfHXrgxzw5xlFDMDgH4nva0t497wN6u+tTwZbVyRViBKcNf1GL+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821789; c=relaxed/simple;
	bh=YEH6BY45a6FkmplK6gSE715Cm9b/dNet5Siq6Wv/7jE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XMWIVpMmZyrqQmK6ezU4D0w+Q67KS/o96j1Oi/8fxPk+ptGJMGyvqGeFv5jcWep3bSkriM5mRX74MMtqbg5HhxyvwZ3fzZxLeUwsYN7hAPTvaR1mCrcWpQRRKNEFjUDNLgDbb8nfmPxIlDAB1ItisRFWSyVHKJrBZSNWzn3uaXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixTtCn1s; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e45ad4ed2dso1133016137.2
        for <linux-wireless@vger.kernel.org>; Sun, 01 Jun 2025 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748821785; x=1749426585; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2CgSy13ZScnq7dO2F3vOd+BoHdjpC/dfBE6NY2PG1I=;
        b=ixTtCn1sMSbUazee3uzjH2Kh3rD1sEsShAOa0E2gdgY2botyX+jjZzhaTT0KFI97Qj
         afyOjXDWDYTMfxhBLn8IOHDgmJ9Onlsvi7QnaipHuUg3kebmcKfKhYkdirLAlJ/Qshu2
         8iDzO8IoflCPMRx8af31HCRAqgAmHKRKaj//Jn4367cX9GkNQiACY6XkvtenxNImyInf
         +Jojvd8OU9VtNRPn1m8DmLBVggO27nZuQ7vM+U97n7m8/pPTG5bVKflrxwNzeaR+HuaB
         HgmTx1u/LKBd97FPpa1vY0L0Y48f81Bjq2tJCeJiT+PhwW+NJtW8P7wAwX04ybnhTFa8
         i2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748821785; x=1749426585;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S2CgSy13ZScnq7dO2F3vOd+BoHdjpC/dfBE6NY2PG1I=;
        b=Px7lloZF0yWksMQH+jcvm5kSgFatnaoEAAYnRDybmL+SMnsQa2s5SdjOp4rfewfsx8
         UQVGaEAur3fN4Flhp7EM4NlbVEO72YpM8dxpkbELGX6SnTgpldVIaThrGcjMvlQCpwPi
         KCzm7FcINNlcQrVH6uH0IJJog3sfgisDVJxa5vk2s1hHQj72BBEOwX8MpNUcm3laIF7M
         fV8UqsuCKGe8PovRnDdgkq8dn8L4Dllc0rA03oOIMKRz5K7dbCyqe6i6EMowoqTLnkT7
         6jvnLtQYhHcSisGM/oqR+x1n2EQUyLzxtW3HWTrHsRBKZ3EHGvbWA8ap7YHzB4oeYkri
         CjHg==
X-Gm-Message-State: AOJu0YwNnFSNW32BdfnQk4vOgOLYHBKMZYeXZAdIpKCCQ3GLZvLSG1X5
	3qGh5Ydk8yjPAPWLQ3XOSq4x0/B9baUFTxJwSf1SMt4gI8T/40PpEOrU6xU7OQ==
X-Gm-Gg: ASbGnctnZ4Hrbuu9NmiEE43iN2agnRR2KAxHpF6gCyvNJ9CZu+EnLhCmdmcGg1A9CvN
	uvSNUXA1Fxk/jx4M4WfCtZZTduKXJWBlOSpxf8eiQ8aGYb+Gpnc7rJZUfGDIbHVMAWuWz2ybdbJ
	vmS/DILUOuYt0/xH4Vjg+BJqmi2ArFzKALP0ADyN4CZr/1mqycmkOh8ks/I/GOu/NEkprNbm+zy
	yeuWBUda0Eu4CanPgT0qTVHGAjx0fE+uB0B7hyZp6K2ZDF1IUI/N7rGfAhNyW/sv+egzMw0sciH
	cu5lgJHAqIPoIndix2Hpwo27Lc1H7AAyNX1zDahYMEVRy8MnwgDf2vArtWe6FlpBJxoGMUpnJQg
	haK7OteemFf1ZLU4zeEgt/Kw0kr0=
X-Google-Smtp-Source: AGHT+IFnCDtvyl/q2zkM4qGm1EDB/tPwvLvLdaGbTU8lTzF8UBazLVL9QZ1Y2QCNwAt7YHjsSTjt8g==
X-Received: by 2002:a05:6102:3750:b0:4dd:b9bc:df71 with SMTP id ada2fe7eead31-4e6ecd66b88mr7559355137.10.1748821784718;
        Sun, 01 Jun 2025 16:49:44 -0700 (PDT)
Received: from [192.168.1.130] (177-1-191-98.user3p.v-tal.net.br. [177.1.191.98])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e6fc6ca062sm3454575137.22.2025.06.01.16.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jun 2025 16:49:44 -0700 (PDT)
Message-ID: <8bc290d6-5687-495d-b5d5-a8ca94cf2f7a@gmail.com>
Date: Sun, 1 Jun 2025 20:49:42 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
From: Marcos Alano <marcoshalano@gmail.com>
Subject: wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The rules for Brazil were based on this normative 
https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680, 
as mentioned in the comments of the entry.

This January came out a newer normative 
https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772,

It allows 6GHz frequencies, so the line:
(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
Should change for, at least:
(5925 - 7125 @ 320), (12), NO-OUTDOOR
The removal of NO-IR is important, since routers Wi-Fi 6E and 7 don't 
work because of this outdated rule based on an outdated normative.

I'm no lawyer, so please if you see something different, like more 
granular control in the allowed frequencies, please let us know.

Thanks,
-- 
Marcos Alano


