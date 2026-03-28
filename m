Return-Path: <linux-wireless+bounces-34112-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dSjxMqwwyGnMhwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34112-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 20:49:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22834FD91
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 20:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B6C4301648F
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2604633A70F;
	Sat, 28 Mar 2026 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aJcZ9W7h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AFA32E6B8
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774727336; cv=none; b=SAd9jWdbwCuqr7XOBff8cLD5pJdd7bnzs/5f6M+YzU+cpmXHBkRHoftmJbsYRJp22zxZ8dlG12FN++WO0fjZvyyxxXYxdJPm1AKag/BwqbrLQ7NjVGEAdWX4F9HRVtn0EAxQjSX64OZGi6ogDxHsqIigTHzvO2DiIhjfKM1r9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774727336; c=relaxed/simple;
	bh=8U8obALdl8hGap4gvKVuMEO9Fn8+jHp5B2BOuQBgut0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cu2zVmHu19rm+sp6NrpuJk0V/ma+F1YPM6bi2SkoE/UgaCFS0qsRkjsA97iyXT2MGH8oquNzC+qlVBcojT/kgcPsS9XPVw9rVmfh8n6IK5+76Ldj8F+0fqPiFJsQ9XG8ktuIWq8OkQ//YBWkThHLNUlqQLxlzmDTBvzfHukew/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aJcZ9W7h; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so60758a91.2
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 12:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774727334; x=1775332134;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3JcaKbNOQTHcXjxE/HgutiisVcwo5nY/ouFHpDs2PKc=;
        b=picmsS4O8w5J+rLpri6n32IXbKbh1N0T9xaEPfGN3yGj5q8BDtYMi5VNlAzxTPgLz/
         xXdpa+MvE4+B8tR5EVoz4QT3veCdX2aTUegRKh6DuGcIKjuJ9NzO2BQ/KHj4PI3Upsx6
         dsZaAxDU87QcDDne8iEV8rXBTmgQ96aziNl2Hdwr0LhjYJKyA3bYUq3IymSaUipd1vAN
         06h85dbum1qUgDAcFAzmbElA2/zGdkg2010RJIgssPWPf7c/QvqhsaO5o2T7LPbuCwr4
         z8LzX1hLpmIbwRjdLOKyAwMWusEAm9FnacwHpotiB6kojXCr9ryClveHgaTNf0EXAeG6
         /fBw==
X-Gm-Message-State: AOJu0YxHuo6bvJQuQ5/4adqQpGIFY5Wr9Ycp5aEbbGBSav0JKap1hTm6
	n6ccpN6kLWd26WtzH7PObBWudT9VJonWXfg7TrWJD3HGtdwZ/ccdkI9q6hm90LqFVkU4pBCwlVi
	JOBxAPwbHrXGNVE/1UfR9YGuRrFSG4kPCbN2OwhbOWOJBsVo2OyLCL1xK0D+EljeLX1kmscyTx4
	MkgBuXPXjSrgZF1ra7KPgP3mXAN0NDinQR2duA8Mb7javDtbZV3z6PpbFgLKKZX3sEDRyt5oXDU
	FfXq9PFI1FIGchppYCsJq1QdGy0
X-Gm-Gg: ATEYQzxIwhZ2pxa00Yuo+VLFq3eDauPa0OnX6M9EQUl3fKfx209xOsp8lg/ICiWyUVQ
	3Ov6bnWON7JjbvjGzWh1uzs0cBRUOcOiCffPO0ybS2Cw+Ihrhy5HtuUHOTH0p3f3gK1vmDPBuxM
	oA4pGGF0dNbJIRXffU4zDYOjTtf9U0w3rexTNKhZXqkqFx0Fv7l9Y70sHggqJp3L5v0HjeLTu/f
	mnz+bSPy+AOgsDn/SQePaTxtM27GA2IOiTVkoUt/CTYbtv/mGitSXcWWT/ZmuBVcNaUKATD8Awt
	/5b9Kmam4WPqN/1Jj4+Fla07Ji6HZH8xO9dR/nW8mXWMiB6H8VfcmoJi1lU+3lJhX/IC7rGbG7+
	OY5SO3T5h0ZoqcEJDNH+xY/tiUZMFj5JP1fvvjH0YWKOdZ6aZjKEHRMkw0vgBYfvTw1ZctTgdnU
	xy6/dxX9JYyAddnqVpXGvPcKvKf1f3+MoV/VqCmEMsP1BmWOSOCxMJYP0tHsDc
X-Received: by 2002:a17:902:e742:b0:2b0:58a8:5fc0 with SMTP id d9443c01a7336-2b0cdcfa1e3mr71791625ad.44.1774727333715;
        Sat, 28 Mar 2026 12:48:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b24507fdb4sm2587025ad.36.2026.03.28.12.48.53
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:48:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so3459887eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 12:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774727332; x=1775332132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3JcaKbNOQTHcXjxE/HgutiisVcwo5nY/ouFHpDs2PKc=;
        b=aJcZ9W7hhUn+fUEUbSJnojcG/I3BOGVaju6+/gkyLkDwSsPjqg1gCKDhnB0yEZOPWr
         TN7kl0GYAgRc+qqS9nJx9B+o2Znti9wSmSU4CATSAmoGca2v8qVhBB0Fjrpe6KdX01pi
         5D7o95SZXhCPyKnNzGa8MV9HLfRzM8E7ZVUrc=
X-Received: by 2002:a05:7301:d0b:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-2c185d557e2mr3319851eec.5.1774727331726;
        Sat, 28 Mar 2026 12:48:51 -0700 (PDT)
X-Received: by 2002:a05:7301:d0b:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-2c185d557e2mr3319837eec.5.1774727331132;
        Sat, 28 Mar 2026 12:48:51 -0700 (PDT)
Received: from [10.229.41.221] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2ff2sm2791550eec.18.2026.03.28.12.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:48:50 -0700 (PDT)
Message-ID: <1f658b09-a293-4a38-9ff0-c530fda7c501@broadcom.com>
Date: Sat, 28 Mar 2026 20:48:45 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] dt-bindings: net: wireless: brcm: Add
 compatible for bcm43752
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260327-add-bcm43752-compatible-v2-1-5b28e6637101@aliel.fr>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20260327-add-bcm43752-compatible-v2-1-5b28e6637101@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliel.fr:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34112-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3B22834FD91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 10:36, Ronald Claveau wrote:
> Add bcm43752 compatible with its bcm4329 compatible fallback.

Looks pretty trivial so no remarks from me here.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
> The Khadas VIM4 board based on Amlogic A311D2 aka T7 features an AP6275s Wi-Fi/Bluetooth module with a BCM43752 chipset.
> This patch aims to add this chipset with its fallback to bcm4329 compatible.
> 
> The original patch series is here:
> https://lore.kernel.org/r/20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr
> ---
> Changes in v2:
> - Add netdev in CC.
> - Link to v1: https://lore.kernel.org/r/20260326-add-bcm43752-compatible-v1-1-b3b9a58ab38b@aliel.fr
> ---
>   Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | 1 +
>   1 file changed, 1 insertion(+)

