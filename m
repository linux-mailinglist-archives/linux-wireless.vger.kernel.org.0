Return-Path: <linux-wireless+bounces-23055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B0EAB957D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 07:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CDFA04080
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 05:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CD121FF3E;
	Fri, 16 May 2025 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MndJNK/X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827242165F3
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747373274; cv=none; b=peIyf4PbwEIQd1TNp4FHjNpWHdlRy8GBUmDWl4zX8AusKbnFo/KU4xi69d3HiNVJPfR1AUlKRUR0woqqbZ1LNFuJHp0pjml97EP9ASKezqeunFGDuIXMmkHRlNVPDJvay9jVHaIPG0ae1iwuRn4RHHvYE3kpVDizmmGvWTwUA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747373274; c=relaxed/simple;
	bh=1oSZB6Mh1Am7IMLdTq+rGuRVJdFYyBZOmT8eJB3H1zI=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oAsg2MgrqHJVe+0p7CWNFMXQn5PeV5ORfcQEPUfaGgS8Rst1ubnfn++f5a6yB359/vJ+wS+shB3wXQV/bbfUOELVUUvZzrqDKfEBmi+waKpwfMEB55l79lnbqHRQ6yjOEkvYkXdZADXZKmufk9omVRWm0PJ5SfltrOqYttg3ggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MndJNK/X; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e16234307so18472245ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 22:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747373272; x=1747978072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZBuwCPrPwQtjwCCR2X3I/7gHQ/hXUDgt194Kz7I8QY=;
        b=MndJNK/XmbAhEIHrLn4mdEucmJwFeFV6//1qVpXToKWOH3GqD69nSHBWYtoRUjFDYs
         JP+RRc6QsoqzWH9e/W6rHr7prSOsnfx9O/fVIJsl8LeTb+NFV8TQRkEQn/rdH/9kqQTc
         vzSw2CuqrexmZwka296cQkDzURV3JF6x+CRB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747373272; x=1747978072;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZBuwCPrPwQtjwCCR2X3I/7gHQ/hXUDgt194Kz7I8QY=;
        b=UZO4tvKoOerq+znXG4vUP7b9kx7sunMIFvH4TeICaNHvkbt01hC0PEPX2PGJqtNyvX
         lUtO/m9uiBCaRpRmcH2r/HlFopKXvbZNeLywHKxOSJFx/YOHodkNEYyEGxLDNyYDNR9S
         nKGxQFGNGU8IOQ+HEb/xhDHVZgPTV02OMLxEtYoN0uNwZXm+CGUKvCvfpV7V+khh2hTt
         GFzomNiwlzrjr0xjayqQVKLOV30KioxiCHr/sqrSJ9Vcro7oEs0umchohY2RKDEfJnBH
         AcgsMuwhPXJJ07D3ied/Vem4rluk9TDmv29TGxuEktvgU7yOBS12MzhcI6ksEugahoZl
         Titg==
X-Forwarded-Encrypted: i=1; AJvYcCVb+mULNFtDXwL+QXUgbsCGCHriGT1FI6mZNbtMBt6YDP+lgceVsX/MyXLCLtxTmYt+R7RcuG2zcwEJnq2INA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZyQo4Zu64m0UVsVCHfPaaA5OavuIvXhwNdKqYm8vXCfFL28H
	PqW7Ut2gRQtPZxQahznZw+nY1QFSFqv2h/PiQJ+xXw1hU5hbkJcgFNLA8XU6MB0HOg==
X-Gm-Gg: ASbGncskb2XMFhCFNqmePEQs3OUIdKPFEVvOCI1QjxgaPgkCGQITy5DlwAriSpj8jWf
	tTw7CahuvvCA0XY6cizgPKLK401wx+MfSJeQsZ+OETi2jQXcSw0f461MxiS01WbY8cVHeKWK2+A
	WdnHm9H5DhgABExmFuMTwha00L1Fa1x6iKmJQTeZGPwfuA9E9bWnZGiikESZE2yguoL7jgcmgcd
	xtJpa/pP81xGHuOhY0o7ZXIlkFtISFmG00Pfo/FtuHMd6WDAzNYstpyhdDi3m8LgCMpHCDL/zK3
	Rx5EbMqw4/761EVh/+bdfiL6HU/Q28XkSyeL1916G/rhp7RNaww2cB16/YKwOV0FlgVB345fmqy
	hBz34ri7SfbP/ag==
X-Google-Smtp-Source: AGHT+IHzdRkavZNG2fH2v8Z0BOuTPgetkh5gljeFa8VxHHd/7/RqRh+tQvkq/QvGyYWTH/y9hSthyg==
X-Received: by 2002:a17:902:da91:b0:215:a303:24e9 with SMTP id d9443c01a7336-231d4ae1de4mr23968985ad.3.1747373271695;
        Thu, 15 May 2025 22:27:51 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231e76b4d5bsm1643655ad.111.2025.05.15.22.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 22:27:51 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Tim Harvey <tharvey@gateworks.com>
CC: <brcm80211@lists.linux.dev>, Johannes Berg <johannes@sipsolutions.net>, "linux-wireless" <linux-wireless@vger.kernel.org>
Date: Fri, 16 May 2025 07:27:45 +0200
Message-ID: <196d7901068.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAJ+vNU2pLJd696Fc_98arrzs8QK70HfstPrZv6zVJm3G13REHQ@mail.gmail.com>
References: <CAJ+vNU2pLJd696Fc_98arrzs8QK70HfstPrZv6zVJm3G13REHQ@mail.gmail.com>
User-Agent: AquaMail/1.55.0 (build: 105500550)
Subject: Re: [PATCH wireless-next v3 0/4] wifi: brcmfmac: external auth support for Infineon devices
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On May 16, 2025 2:38:51 AM Tim Harvey <tharvey@gateworks.com> wrote:

> Hi Arend,
>
> Thanks for this series! This allows WPA3 Personal in STA mode on a
> CYW4373E based module we use on our boards however AP mode with WPA3
> Personal does not appear to work. Do you know what is needed to allow
> WPA3 Personal in a CYW4373E AP?

Hi Tim,

I did not look into AP mode (yet). Are you using hostapd as authenticator. 
Can you provide the conf file?

Regards,
Arend




