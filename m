Return-Path: <linux-wireless+bounces-31498-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFjfDSbggWmDLQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31498-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 12:46:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4EED896F
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 12:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D023F306542E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 11:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D68264A74;
	Tue,  3 Feb 2026 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="De9gCj9K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFC3191CA
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119135; cv=none; b=E+y5DRUPYNyQw4ymMFt8/Am/cNQjNnkmNFls9CSe8ev2ImjOeDvq6YfuEmMsohvkOmmnRUgXwU5VUN4WTlpWfSKH3Xn/Dwex7WMXDbdFPkzmI9rxaKHboyth9W0l3JpdJQcN5AxgrJ9azdeoZSWcxFw7nt2oTatV16QXnO5kupY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119135; c=relaxed/simple;
	bh=h+x+1dnLVzTqk4z4LoCwW366wnW3d0sD2AyCQwPr4WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mn6R2YMmfa92cOLZgjFIsLmBMmil9JZPzYfcLR57L0mDL1poE2ujLJyy9RTRDNGSMCyFSmLZd5xbvSTnQaDWeB6lXLsLDZZwrX6uADCNvYGEp14DJDxi27HekST9KRJahzGO8VCEmRTulLuqCN4cIhhkgIAyK/Vu0OMz3yAro7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=De9gCj9K; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a09d981507so5578035ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 03:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770119134; x=1770723934;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsO4mxJQRQJx5wwfoRnZCOL7vZd5syOyMScGMVLGzdw=;
        b=uHH4IQuE/VDag+ZwZIJaMxVWXeV+hXvX0tL7kiE1r/Dhtznbdwqt/DREJBpwgKhxRL
         rs7TaASeNwWoTsxj0Xw8K6h8YsCivgkk3LyEz2eoaDQdCXmLR3bDnE5w9Yt5EgE87Od3
         /at74cs8lVlZqDd01Kn/xRjety6Js5q+N3Db+RTHy5oiAnTanVeevT6vUomRMX/rQgc2
         q8f4y0/u7QdXj/BCDqGddkupOFUWKAyaUhUewV/QxvZBlWmm5gdbeIBty5+Zou2Dwtln
         QnmQeTOxtIuAi+RqXPHUCD+BoPZ8SsVn64H7HXZKjkImsPF6z+g7j+GB2zAcDWk9GAg9
         ae6A==
X-Forwarded-Encrypted: i=1; AJvYcCXn3Ab16THlKFFb7qwU9W2oY/snmdd6jJk42ZDvXRFi2vMfFvKtyvO9BN8/tBPQHShitcGQHaxu/vJl4tgpAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YylLf1gzXeHaYFNpXbGseKQpKD4eboQYgChwQC0Cv1g8tAFuQN2
	nAcOYy2nBTOHxrnDTDociQ2EC25FZmRxpL7l/V/6LaFfYKjba3PjnreEt0NAtdDF/bSNZDWS4L8
	ryvU9fu+2nJFUc2kEZ9EApV7x5GGEf/UaL9c6QeH/fCNN5dBrum77Ux3MfhfdFcorPp26lD5juQ
	AyT7kiiOhD5AnCxnoAoWEthv/LtPLNZ6o/IXf3WH11Yo8pESAahwg4bDEQaClhmNWdytgKGu4lF
	5jGtRY39ZFzPsXvOSiKdMj1wm5/
X-Gm-Gg: AZuq6aKqpmTv46dGBUiOs2C8OBdqwOt+nSCsy9tUE8hF5W3koATXimr5GFFnsfjVoXP
	TCgjWCD3E3eicrJ1ATZZNIsKpAfyAJ4VYpggiV77aoAaii0YLoxLZf/tWOJUbu9IC+UndIRilg+
	lKkdNLpnEhz2tdS+3fmQxccwByucDNjJ8mpPO3EgVHSotpUDwbZDYJlFDqdL9ixHxt1bzF6TSGV
	zi6o9LywP6H+ZQe6Omh03KBMK+E7GJ+QZmL8+TJNCvK2FxPgnEiMFiRWodk4dv38vtlyPU4ABoD
	QhDRxm2Cs5owaTjiFtrdmWr6rJ8x8Gis8fFsEiwLI8XAmB27T8+cpdx8AWkilkI3YKC87EqOAGm
	XOEUfubeKpyNO9plwECFSRA0tn0d7S4VAdkmIxSdr1i9Y2uwj58f213NQKawG7qwqn/Ut8eWKuf
	hbx0kkObqqIS/ZIO7T4reDahfxtyA/QFnpsZqS/Am0/RNHcnumLzk=
X-Received: by 2002:a17:902:cec6:b0:2a7:6289:faa with SMTP id d9443c01a7336-2a92458c571mr27618435ad.6.1770119133493;
        Tue, 03 Feb 2026 03:45:33 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b6eb6b5sm26094695ad.46.2026.02.03.03.45.33
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2026 03:45:33 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b713fa927dso444952eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 03:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770119132; x=1770723932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CsO4mxJQRQJx5wwfoRnZCOL7vZd5syOyMScGMVLGzdw=;
        b=De9gCj9KjOxrduim5KEyuoM6miw3VvToLYdYu3moGSjD6TaVo6myY/xekKJRCveUG2
         Lhfst/6wAPscNuMXrWWQ8SxvCdGZaNbCjNRvvx3ZqzWZ0iywk8OaUJY4L3PYPqkXAzK+
         nawyNNaok9WdnIv08hTMNs1wHAVGrX1MOW890=
X-Forwarded-Encrypted: i=1; AJvYcCW++D6/YbL3GlE9zF4bwM0IvT50gUZxx4OioLovx4XLKo2wBbj7yBMXJH6kppbx/77AExJxPo3LmJJkcYy5mw==@vger.kernel.org
X-Received: by 2002:a05:7022:2521:b0:122:3df:fccb with SMTP id a92af1059eb24-126ea8e7c51mr1136912c88.10.1770119131839;
        Tue, 03 Feb 2026 03:45:31 -0800 (PST)
X-Received: by 2002:a05:7022:2521:b0:122:3df:fccb with SMTP id a92af1059eb24-126ea8e7c51mr1136898c88.10.1770119131344;
        Tue, 03 Feb 2026 03:45:31 -0800 (PST)
Received: from [10.229.41.199] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d6b658sm19030762c88.3.2026.02.03.03.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 03:45:30 -0800 (PST)
Message-ID: <b49e525c-6dfc-4cf4-9aae-b22485341c67@broadcom.com>
Date: Tue, 3 Feb 2026 12:45:30 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix potential kernel oops when probe
 fails
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
References: <CGME20260203102148eucas1p10c43be72827d74e5be41fe40a84fbd59@eucas1p1.samsung.com>
 <20260203102133.1478331-1-m.szyprowski@samsung.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20260203102133.1478331-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31498-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AF4EED896F
X-Rspamd-Action: no action

On 03/02/2026 11:21, Marek Szyprowski wrote:
> When probe of the sdio brcmfmac device fails for some reasons (i.e.
> missing firmware), the sdiodev->bus is set to error instead of NULL, thus
> the cleanup later in brcmf_sdio_remove() tries to free resources via
> invalid bus pointer. This happens because sdiodev->bus is set 2 times:
> first in brcmf_sdio_probe() and second time in brcmf_sdiod_probe(). Fix
> this by chaning the brcmf_sdio_probe() function to return the error code
> and set sdio->bus only there.

Looks much better, but wanted to see what was done in the commit 
referenced in the Fixes: tag.

> Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable support")

So that patch wanted to propagate the result of 
devm_clk_get_optional_enabled() call in brcmf_of_probe():of.c to retry 
later. It ends up in brcmf_sdio_probe_attach() which is called in 
brcmf_sdio_probe(). Anyway, it seems okay to me. Will give it a spin in 
my setup just to be sure.

Thanks,
Arend

