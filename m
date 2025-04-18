Return-Path: <linux-wireless+bounces-21728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A178A93BDE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 19:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67583465D1F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25A184F;
	Fri, 18 Apr 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hB+hrTwW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7F1BD01D
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996820; cv=none; b=IC4ZxwqashqfqJsRM4xBShVIxxFWCvY+/+zMS2pzw62qOTK+AN62BrYRbunqmdRy7qklJnwlqWz8QfIVKbTTxZggBPOOgd+Y8KHBQpk2g+aVP0kCKp94Lvb0R6ANyWVdoAVyaueIloh4bTKgbBBtE8Tu6Y38fJCJJbCPIBsUmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996820; c=relaxed/simple;
	bh=gdt/NV9Glf7Fy9xwm9CRlRigMSp/rqvVs7EFkYy2f7c=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SoHGS7lTFwAfa29m4VZ79qpwoZOzEqxrOMgCD3xnbZWO0Z3r4fQHFgyKH0ojEeKbDEOAvdSXJ9bJCgUBhhW5s8jglHitbs9CqjxArycqE09nLWmGkC51+50B3L49dyFhfbge/LiYeci5xeRjxDX17/HkVnDykDo5HdR3sAi8qb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hB+hrTwW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac345bd8e13so314030566b.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744996816; x=1745601616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aae0yNU6qEtMnT9iszupHMKlGwdOca1yf9jTD5h0zYo=;
        b=hB+hrTwWW5cndhhIHWTmLIIYwcR2ptAXRQcHfOXbfBU7tekCqRr8XDda8jzh4VIS39
         +t85NfDjAhMQLPedHhrxDfJ1fc+rtw8viTi3Bcrse1AOje3Svbtysj+nZI8P5ghvsoQ3
         Q0fPPvPyRY2KQRQSF3T50inJJxxN5zeJA3IdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744996816; x=1745601616;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aae0yNU6qEtMnT9iszupHMKlGwdOca1yf9jTD5h0zYo=;
        b=Q5uqT7aodbS9frHOfEuJhGMx2j9f3thOijU2VOGsyFaw7uqrTQf2dfQl6CEu6yHtE/
         o4bYkXEcM0Mtq1FgRyaEV2f6MTrevFJ+EA8vCtqMcER1msSDIPj3+CGtOF7w+3bnjxe7
         5ZmMIHvhQ3hb7pBS5IBstY3+4/upd4qMUlZ5h2vy0UFE+hw4N9DzHapKvDnwvpS6w/X+
         U83MMk9TQ3hk3/m837ja47uTXAMv2VyO9QL8M5ujYQ2fPvoYdtj71TdWNYp6KHrIJz/4
         3TW31XLpDiwR2QTLh1dlODfM/zCNXR5bynlfN/v0jjQrfmlSA8NskKcvrKoqHLe/whip
         67Gw==
X-Gm-Message-State: AOJu0YyYpic5Zq0muCGyPJab1+Iq5a9rwhdUouZc8Xw/X9ubNYkotf87
	dLyV7tYiWzieSnQrl10IFptsp7D1Erh0oDjZEjdE3SKtABR/kradt7PEVCJN5Q==
X-Gm-Gg: ASbGncvQxsYonTvudcrB3hx56fF1vGmjqiVb46H6jkYKoiRETTGN5f33ADR1BhwOH9m
	eP9BV2q2C4/lb+SwaOK//fB32Awj6NIcMQkSt69bDv+D246ow0tDn+dl85X4uxkjZcAfvhkvnKQ
	DG0i4nExC1CMtmPzxwKAL59gwNc6GdEo8zT+EHu/1ko4/jJ/sBA0heL3XGnW+vYtmohgza6FApz
	Epsx1+vLcLzcarGFQL2JbcqsOkTPzjj/FDSsGwgBnFH6Wy/I8HWm6aFpTJWdUofz6IJeLqHN7QY
	qh5BFPq8YdJF1BxasJQNayHlcs/Guk71PGTA6MMlt9xeJ/Y08L54dP5cUWomqEfNutBlSK7WEWz
	zpvk=
X-Google-Smtp-Source: AGHT+IGmpeW9BuVDPsEIwdhBrrIRV6HcZFEw9qtB3nQkxc4APEStoRLK1oRuRA+PdwXu+7SAr+cdgw==
X-Received: by 2002:a17:907:f80f:b0:acb:88ac:e30f with SMTP id a640c23a62f3a-acb88ace3b6mr42279466b.20.1744996815959;
        Fri, 18 Apr 2025 10:20:15 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec0bfd9sm143393466b.29.2025.04.18.10.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 10:20:15 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Simon Horman <horms@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>
Date: Fri, 18 Apr 2025 19:20:14 +0200
Message-ID: <19649ea4cb0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250415-brcmsmac-spell-v1-1-3e1375586883@kernel.org>
References: <20250415-brcmsmac-spell-v1-1-3e1375586883@kernel.org>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH] wifi: brcmsmac: Spelling corrections
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On April 15, 2025 6:06:41 PM Simon Horman <horms@kernel.org> wrote:

> Various spelling corrections as flagged by codespell.

Have to admit I merely scanned through this patch. So for what it's worth 
it look okay to me so...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c     | 6 +++---
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h     | 2 +-
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c       | 4 ++--
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c     | 4 ++--
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c         | 2 +-
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c | 4 ++--
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c        | 4 ++--
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h        | 2 +-
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/pmu.c         | 2 +-
> 9 files changed, 15 insertions(+), 15 deletions(-)



