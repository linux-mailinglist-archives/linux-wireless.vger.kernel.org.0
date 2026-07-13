Return-Path: <linux-wireless+bounces-38968-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lVIwG+HDVGq1SgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38968-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 12:54:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B72F574A0A4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 12:54:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=Qu3pxmok;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38968-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38968-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E2D3088053
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A2E3E8C78;
	Mon, 13 Jul 2026 10:51:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1153E929C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 10:51:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939908; cv=none; b=IK5DDs80D0Teqb735IP0JiEdgqFza8E4Gc6d8L3KLfYnEWDEyiKi72dHKt0yGNIBHOvIe4iZxuif0HWuzRR1B13rq3Do2QJYbQ/HZ4dcBT0kH8LAlIuDLIKMebSBw7Yrw+eUfj2bsNu0+VFanzWoy9zvmL9296OBXG+VtiOKUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939908; c=relaxed/simple;
	bh=ztP+Lg5fklMhhuTpaIR9LJ0qNO0Jn8X8jfLGw8P7Y/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuLgKczDE4+0ynxWBbEfwk9bCe2ZbMkop9RN01TCtR4pLOI7+SunRoGBT1SOm7hYUBNlAkKuM86ONHSo1Es3//SCEKJHtTIWh36HXIH3pt9T4Gyo+R48ezRT7TvThsYa72qy/b1UoxwSCde1Z/clxlJlTzjlHJWqDf2os9ycQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qu3pxmok; arc=none smtp.client-ip=209.85.210.226
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so2298202b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939906; x=1784544706;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xAMD//Z3RnvPCQ/mYGTihmrUMMj+M8oLlYOH5HAiHag=;
        b=nwI6P0wFAks/cKUU7WW4uJlByp45WLjgEMbbSuUjao+pFg5YtDjH4KxcBTIT/EMGqS
         oT6w8kmuLB9BkD5CSmg2BbodceaZi/OFuYM+LtC2ZeeDWmXPpqfHmFa/dBt/eh15/XVX
         a/men5QKl7EZsZyIS/eu+VQcfy1sgm5R9oT6SguyFzBsfN5kynpF4Cpi4xPUC5hoTqv7
         RXURjcAE6qdKJFhlYqStYOwzS5dL45+nACmvAv8DvFnR81DIGGfDI26jW4/IrMN4+OEm
         yJaN97qbFRWG3YIS6htA8iNj6kVwxoMISVmIbKVvyOgXvGbVjbKshO5nYJTvPazI0gwn
         KbeQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnZ0Kh+MnNK5gfOR4RQ3d0siFtQoUOOVVuWSucWovXUctdsl4GwCawp/A9jrR8xlVqX6H5J5EcHlTbgdlsBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuYGSHuO0yLwqka7EsJtyZBhouznttgmhDGwhsb6N2AFMkXG3
	3FGfsHxYROh4PAq/qNTa1dzxEr/tPrUeOMLwSzzaXlEzVaiLl9UA7rBgMQbH1aH38iMAo0+EYKX
	6wp4lX7eHGJoZ4BBoOMWSDfnojq3NuIzYlVecMl9gPbCYyGhyiqpcet2tWhXCWSZaqk9b1pjC7H
	SWCZZqaiI85aPeDGotvRsqlu60iaO4vvpRhd5GLwaOQIflqhVTd3EJmXcB+CRyswx5LFP54m2D/
	25n5qjphVeCo0EVe67mxU2QpVKb
X-Gm-Gg: AfdE7clHCEABJIZiGLRJx0s8lvawRKA97wQI0SHmnzovQ008Ou5Fl5F5A3j9/6YaS7b
	ory7oXQnxivTgEvK7wPCk0iTLrkR1aV8aWQfB5aY1XcIgnBzTtif+j5PCpyMooF99isuh78m2WR
	vhEaPpqebUju0jQL3Z32rwshNOGugjOzd/Dh7x4X5X2gBXcgpN/EoXj3y3Oo7F94576aSqMXN+V
	x85APlKABbs4zBtR3UiMVXnSLNx46+u//d3cSkckFJlVMtk50aQTQF5WydVKKEkbZjK6v9kyKmR
	zstr6J5vdCCbxwuHXSBrt7Odlz00+hL3ZykzK6J27+rv5oUYhSxRCsdR9Ow0eoOHTdzavECPwGl
	KUcfUatTnx8bCX6KYymWc/ZkFJ8hu/Lc3+S1+SGjgjqCNClX+ccot6CCLpyv4huzw4lQm26VEM/
	aM23ZdXrpuqYCfPIZqV9Pgr3IBg29iLs+LoJUVD1pENUmV2jg=
X-Received: by 2002:a05:6a00:b87:b0:848:7cbc:7a0e with SMTP id d2e1a72fcca58-8488961ce8emr7863873b3a.11.1783939905949;
        Mon, 13 Jul 2026 03:51:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-ca647a0fe16sm1384216a12.5.2026.07.13.03.51.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 03:51:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8efe7db1c42so48947356d6.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 03:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783939904; x=1784544704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAMD//Z3RnvPCQ/mYGTihmrUMMj+M8oLlYOH5HAiHag=;
        b=Qu3pxmokRpr0dUl75Pybfv4F386T9ikvdUa6cDG+5ZmSIJ/J+hV/oqxmpAFWCxmTbS
         i/1mI20PdWUWHtMV9Szt9UXqUfYxPtB6rPPesJkknaqbYrhRDMa7n7kGA1sVwOPCYKOp
         TNmEKpbVIHcInRyZ0Q34StMzSHY2vlckNmJHs=
X-Forwarded-Encrypted: i=1; AHgh+RrZrAvpDzkgx/qBQngr9cXXojDTQMosmmsSHPqH2GKLs/YOJqN+ffy2BC674Vct3hLX6IXZIJY3UUKasxTs3w==@vger.kernel.org
X-Received: by 2002:a05:6214:238d:b0:8f2:67bb:a37d with SMTP id 6a1803df08f44-9040471eca3mr96339746d6.57.1783939904544;
        Mon, 13 Jul 2026 03:51:44 -0700 (PDT)
X-Received: by 2002:a05:6214:238d:b0:8f2:67bb:a37d with SMTP id 6a1803df08f44-9040471eca3mr96339506d6.57.1783939904024;
        Mon, 13 Jul 2026 03:51:44 -0700 (PDT)
Received: from [10.176.2.203] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d3acsm124246046d6.24.2026.07.13.03.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 03:51:43 -0700 (PDT)
Message-ID: <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
Date: Mon, 13 Jul 2026 12:51:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
To: LiangCheng Wang <zaq14760@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Angus Ainslie <angus@akkea.ca>
Cc: Wig Cheng <onlywig@gmail.com>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,broadcom.com];
	TAGGED_FROM(0.00)[bounces-38968-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zaq14760@gmail.com,m:kvalo@kernel.org,m:angus@akkea.ca,m:onlywig@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,akkea.ca];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B72F574A0A4

On 13/07/2026 10:50, LiangCheng Wang wrote:
> The BCM43752 is not reliable with the default 512-byte SDIO function 2
> block size: on an i.MX8MP board with an AMPAK AP6275S module at
> SDR104 / 200 MHz, an iperf TX stress test kills WLAN within seconds:
> 
>    mmc_submit_one: CMD53 sg block write failed -84
>    brcmf_sdio_dpc: failed backplane access over SDIO, halting operation
> 
> Commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> set up the 43752 like the 4373 for the F2 watermark but missed the F2
> block size, which the 4373 limits to 256 bytes. The vendor driver
> (bcmdhd) also programs a 256-byte F2 block size for this chip and runs
> the same hardware without errors.
> 
> Group the 43752 with the 4373, matching the F2 watermark handling.
> With this change a 10-minute bidirectional iperf3 soak completes with
> zero SDIO errors at ~270 Mbit/s in each direction.
> 
> Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> Cc: stable@vger.kernel.org # <= 6.16 needs the CYPRESS_43752 id name

Looks good to me but the stable instruction looks confusion. What do you 
mean. If there is no 43752 support there is no need for this patch, right?

Regards,
Arend

> Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
> ---

