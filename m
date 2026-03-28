Return-Path: <linux-wireless+bounces-34101-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP8ZIW6sx2kFagUAu9opvQ
	(envelope-from <linux-wireless+bounces-34101-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 11:24:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D116634E144
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 11:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8EA93013FE4
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45214386C09;
	Sat, 28 Mar 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H1wNxNnF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC14361DC8
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774693475; cv=none; b=k71yFZFtRysC1y8DP4HMDl2EG34j1CehbMlItPILkbfkZHBAekI268XIa86FAS4bqbc4TQXqQWUWpI9uQwvuDZzhaD0CYuwdKwAFTXHPfWuWKs7ua154ueB8+Tm9VTdAVFsXnazX68XLA0aYJ0w3kz8nzYw7/UUwNGGNSaPgCF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774693475; c=relaxed/simple;
	bh=X63BuHO7l4FwdnjdLvSgeQn4alRbYSwxzGo5a2H4RQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJ/HXgsAmWy70Ychf5E3LhgaQxdpDVPm6TR6ynxAdMk/W0EmawlsFXVp/lYoghaWYQsMk3cXtli7HkwNP3cAATpvE9jMfzbhQ/Y13tIDVgfJKt2bWrHS9Mwts1Lcp0BTL8SVb/IrLkzt4MN0d9YcLJND7TAJQqwTzMPz30z2XFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H1wNxNnF; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2b0afa0210bso14959545ad.2
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 03:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774693472; x=1775298272;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z6XToHzShSbS4z6LLqYdt6ioDXJGQ3ObdhmulepTmGM=;
        b=cR/jq7WhtW3Iu7YvkjGNjGr092hLuXJPm+0qEu3/BHyN2phgfH5dqKkpxHfmo6smG2
         e2W44jqphbayYBfPcyzzzmEcC9rtgD2HV1hKYkd40rmSMqKBOtmYb1q7V+C3PwZ8QIPl
         2NZ97j4Y3wYyT1SVJXSKFXTO7pVYawzWrX7fQKWMSpGrLIbji7f0vEKH1ta+ot4k3rPe
         p8OjuT9LuQbI07tnWGJtDuxaBBqG26Fe5buNX2IvJjUWqcVOfu99BwJhoJde733mPccw
         FTR66rq2Co1QludDgqfI1l7it+i8fWlyaZRSBeXf3Y8q9dILwsH005Ap1PP+2LahJGxy
         G1og==
X-Forwarded-Encrypted: i=1; AJvYcCXxSyw8+IRe/fvZDaAxSapM/xbRVeoGUZBafU5y2O5OzBLeBaAspBJHHUi2+OLnaJ6w4xP339y/0CpRBQB8tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4UI6Py/Xoi0eOAzTeDD+DIxCXTAjJCUYT6eOCxaLfHC0ibsV
	8ZJXIzjbvVdZr7GNTddEJWtE/H3DO3VFH3V/VBbJMiTmodwJQzqDe0odMzcCbKFYOlFWoCMCzcU
	VwvXGN5qD71rwajeILgbzJcy1vJqo3Emzle9/GJtL99NW3fAI0XQmWhW2yCOgUQDnkce5ACbS1H
	XOlhRxuV5eoohbZx/Q/Lm2WWx9Bd1UNGZbpuco2Vg2iPrSDe+zrToFLNUUn5ySyEbiF5fCFOHuC
	DA7hRsCm4CAiE5L1wkrlySJl68c
X-Gm-Gg: ATEYQzzHIYBvQBGYm/31XKVIKkHZ7tTdzYWzaY9fX65zTHMy9JIdsIf0q8CCUz2O5wB
	uidUJKi7JtNf/hZ1qDT+aiMhJdlgZYVtHK7bGKDPOKBmeXb9SuZ9cQ6cGupIFdGhGGFlPe++6oB
	CWTVshnT4OGNaIYSZ9XdLpBkHC281kF3OR404hACQY2Efu/SzIZVeXhSfUhImNI1RFBGsFann5U
	cSwPXxXe2oFKoHvWrvea93XWQB37x0wnQdFCRLpd6X7hlD+D4aDtB7FVcIfo+GW9qaMIoM8aryZ
	oAKxN/m1myVSw0r7ddJ9fCdy9EGPy30FwhZ4t+z08fqkgcifYNMZE+bxamKeUdeX/wL15MON3KI
	TS6GJxNjZqf3H1hPZAilXnR9tzFqVmuLMTKqY0+WQ7CYzY11uuSqcXj0A7XWQEXUbfNWMCZ0pH2
	CMbtGfY024ja7BxcIHkcJl15HUZMwv+L5eNSS0uO7GZOr6bZaHerpdp/9z2BP8
X-Received: by 2002:a17:902:f711:b0:2b0:c4c6:3d4c with SMTP id d9443c01a7336-2b0cdd3fce7mr67446465ad.26.1774693471917;
        Sat, 28 Mar 2026 03:24:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b24276699fsm2147285ad.46.2026.03.28.03.24.31
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 03:24:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-66a25bf6b9cso2544894a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774693470; x=1775298270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z6XToHzShSbS4z6LLqYdt6ioDXJGQ3ObdhmulepTmGM=;
        b=H1wNxNnFCoXu5cv7NGH+1EP9uQnCaSmhJiNUBcXZI/NrzuEry83aMQsIfSGIx4+GfR
         +G4SxOcuACYYCPfLDpKy6s24WMKCxcLnr5TrRtAtPsc0xIzqhzZTGJtm1AouSoMTPvCx
         TRVCowDdCFnkOrX31hxJtzegly25XWVOOiO6c=
X-Forwarded-Encrypted: i=1; AJvYcCXtoZQeaBC8hBSOuwKsK2+ffOaUkMGPFrNt42NPIa0cc4IQYtZPlOUARqfCFms1dfVsIAgeI7eP50jopwox6Q==@vger.kernel.org
X-Received: by 2002:a17:907:98c:b0:b98:4d0c:db53 with SMTP id a640c23a62f3a-b9b502ba4c7mr429612766b.5.1774693469568;
        Sat, 28 Mar 2026 03:24:29 -0700 (PDT)
X-Received: by 2002:a17:907:98c:b0:b98:4d0c:db53 with SMTP id a640c23a62f3a-b9b502ba4c7mr429611666b.5.1774693468997;
        Sat, 28 Mar 2026 03:24:28 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b801bf80fsm53373366b.0.2026.03.28.03.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 03:24:28 -0700 (PDT)
Message-ID: <9eb8c212-4dad-4637-ba77-f6115b2d7267@broadcom.com>
Date: Sat, 28 Mar 2026 11:24:29 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: brcmfmac: of: defer probe for MAC
 address
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211@lists.linux.dev>,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211-dev-list.pdl@broadcom.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260220022739.41755-1-rosenp@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20260220022739.41755-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34101-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D116634E144
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20/02/2026 03:27, Rosen Penev wrote:
> of_get_mac_address can return EPROBE_DEFER if the specific nvmem driver
> has not been loaded yet.

We already catch the -EPROBE_DEFER calling brcm_of_probe() so looks good 
to me.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

