Return-Path: <linux-wireless+bounces-38684-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nu9WJTieS2pnXAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38684-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:23:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 374DF710799
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:23:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=akCXFGFt;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38684-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38684-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C7973003D37
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD429409613;
	Mon,  6 Jul 2026 12:22:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F2424665
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 12:22:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340554; cv=none; b=fexzsMqNXXEzfCCvBL596IscuYWuOAczZojWNsQoQbUCaCOYWi6I3yyGQw/YRm8bSK4BKyRC+/FYj4/Ag0QZJmZFhQlyffuoNWlieFzOWqj2EXFVra5S55t7nIqHib7oBbfuVdvArs4wDdWs3Ybokc+FM/ZBCTAcwH8e/xxH9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340554; c=relaxed/simple;
	bh=9puO4WzhuQqvAPvccPQod0OtAEMgHit/NnWCitCv3nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Elq0/Pq/gEd3mkq404eJJN+HaZz80LcVvpV895UYuCvcmHEh1rRfIc+rR4MvEemSH2NjeBCv5i7YSZtTwpAejkGoW5wm1hKqBSafYiz1aylcWH5W8wUrvk5GHcp+sCGnt5xbadNBODnRSAo9KV70JXK8dqGwDEIWYneu4z4kvjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=akCXFGFt; arc=none smtp.client-ip=209.85.216.97
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso2046029a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 05:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783340552; x=1783945352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLVgC6cNDTSB1HzIGOHtutMGeBSADJe23erI5N8jSv4=;
        b=Hx1mqykuZCbhZIGuLVCXdbE1z3F/4Xyyknql2zQWha7nH1rdw2Lwod7qwUlXiuzQPP
         DeIRQpW7WI2Qqi/S0NpTqfvESb2+TNcz1DqfouycsVCXvT1s/2HJgvR2RvM3W+gwSkSC
         99SVj10Sz1o/EeiOBD2LTu+Va6VtPwbsQwP1rM+PcFG2lse0WA5mHyXJaXH496pazq+A
         0LeNNE8e3O5M+eEQsV+ZhEg/13GycthJeidaqCGViYxs/oKLqkLTUkCM33Aljw9bl2Cd
         Gwk/NM1HgwXYm6S7prlZS9xCBculadPwWlGEEDtwioqgPRjVTt5Fsqqf88nF6Z7kBEkf
         s55g==
X-Forwarded-Encrypted: i=1; AHgh+Ro7nrm/coTQqsaq+MhhvLfD4UWNtbJvNtUae/MtZserF5IXvrCh81eDIkfVacDqEgUXbyGezqv8IhqaCqKxAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqW5VzsYmDpMGOB/kYZnz2zi/DJ2DkVQ3megZBXv465mdHmJaB
	lNlLW6AiHgpUW0R99wge1c0Oc4vYaxonqCNqLqAUIuqQAxdERRaM2Ffs0ih5xcwyge8Ix5kybTE
	HNsGJOn5f/MOzQN7nF+KFzAJ9wm3vIpXeP6rbx7KSEcZmTQXm4ccYKF7xVifg5qxGCQgQ9bVOww
	xXPGgvww/OZoij46ntmIw+I+1xD7ato3oiB0wG3KIAM6TZ38VG5OlDXhFSgy7OB2PNtjjJZ8660
	E2K+pdtkggqgi3VM5xAhH5bs4LK
X-Gm-Gg: AfdE7ckww29qeprxWiQAlXJXGs0iPkFub5Xm07YHI0Z/23l+FGZhdAPAI1rdRWv4Dit
	7JQkS5IlB+Th4KMMkP4pNY2ZVoP6doc9xtZLQsvrJkQhaFumCcsGCrk9QbOXMOo29DNuDZqyFgG
	a4KxLGfb2iKs2r2MgzjdNjK3Uc3xJKEbyQlE0JnwZJSD7jM3YwdGEISlFntBrH6kEznfuCtS34C
	/CPx8nc7S/dUhO+tWyV9zmkz67oHX+orDog0ctBrkWRVvz5ymO8vc9ppRrBaCFYfG/FU0Z/ehyz
	wsqjtBH/NvbLUq/1gCyRgnqpRnTZly255PLGKRxf8AJFEMbc8c7EiCIhYSLJLJJxLnMFknm765z
	haOR2fh7k8pyYstwBLZsno5dmX1tdh/e0d6vvU5gs8DWO/4w/hVEulItKsreiV+iQRQ8QyVqB1K
	Fy27TBQ1ZYsByQz0rP7vb2Ini+ePa/x31DK5FtDq/xEtpwIzmml9Y3
X-Received: by 2002:a17:90b:2e48:b0:384:8a11:33eb with SMTP id 98e67ed59e1d1-387575abe72mr111842a91.24.1783340552482;
        Mon, 06 Jul 2026 05:22:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-38127f0b35asm781064a91.5.2026.07.06.05.22.32
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 05:22:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e623b0e95so245040785a.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 05:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783340551; x=1783945351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLVgC6cNDTSB1HzIGOHtutMGeBSADJe23erI5N8jSv4=;
        b=akCXFGFta7CZpNsk+jYnOOw25KecStFAIoDK/RKtW4chdOcPY0FOluEoVCpEIMbjtn
         +gLLgr/Fzq3tFlJZC8TYF0ihk7nTM9FXJda+80Zqhf86/TbRwEhRC9uHLy/QMfSAP1xU
         IszTq5gn/3xodSeKi91N3toLvSUMKQZQbTNSg=
X-Forwarded-Encrypted: i=1; AHgh+RoCao5TBzL2jcSeKsOecQwjGlu65PrUSpSuTcmg5/Grd/Zv72cKVVSYbTeAIDkgUU2TXP0sJgnb1BP7vJ2tNg==@vger.kernel.org
X-Received: by 2002:a05:620a:31a8:b0:914:c226:ece1 with SMTP id af79cd13be357-92ebb528f33mr42121485a.13.1783340550881;
        Mon, 06 Jul 2026 05:22:30 -0700 (PDT)
X-Received: by 2002:a05:620a:31a8:b0:914:c226:ece1 with SMTP id af79cd13be357-92ebb528f33mr42116485a.13.1783340550296;
        Mon, 06 Jul 2026 05:22:30 -0700 (PDT)
Received: from [10.176.3.92] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e84e1casm144360916d6.11.2026.07.06.05.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 05:22:29 -0700 (PDT)
Message-ID: <a860b1ca-ca5e-4ac6-b9b8-dc1d35e18aa7@broadcom.com>
Date: Mon, 6 Jul 2026 14:22:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] bcma: support SHIM-attached big-endian SoC backplanes
 (BCM6362)
To: Alessio Ferri <alessio.ferri@mythread.it>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260529-add-bcm6362-wlan-v1-0-722242777f58@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260529-add-bcm6362-wlan-v1-0-722242777f58@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TAGGED_FROM(0.00)[bounces-38684-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alessio.ferri@mythread.it,m:zajec5@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:p.zabel@pengutronix.de,m:florian.fainelli@broadcom.com,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mythread.it,gmail.com,kernel.org,pengutronix.de,broadcom.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 374DF710799

On 29/05/2026 02:05, Alessio Ferri wrote:
> Some BMIPS xDSL SoCs (BCM6362) integrate a Broadcom 802.11 backplane that is reachable
> through bcma but differs from the BCM47xx SoCs host_soc was written for:
> the AXI backplane is big-endian on a big-endian CPU, and the cores bcma must gate
> (ChipCommon, the 802.11 core, the SHIM core) expose no per-core DMP wrappers — clock
> and reset live in a small SoC-level SHIM Control register instead.
> 
> Rather than describe these quirks as DT properties on the bcma node, the SoC-specific
> configuration is delivered to host_soc via platform_data from a parent bridge driver. The
> bcma DT node stays a plain "brcm,bus-axi" and all the 6362-specific knowledge lives in the
> bridge driver. The standard brcm,bus-axi path is unchanged.
> 
> The series is:
>    1/4  bcma: support driver specific quirks from soc pdata
>    2/4  bcma: allow SHIM-style mini-EROM wrapper-less cores in scan
>    3/4  dt-bindings: bus: add brcm,bcm6362-wlan
>    4/4  bus: add BCM6362 on-chip WLAN SHIM bridge driver
> 
> Patches 1-2 touch drivers/bcma (wireless tree); patch 3 is a new drivers/bus driver; patch 4 is
> the binding. The patches are sent together to keep the whole context intact.
> 
> The original Broadcom driver materialized a fake PCI device, i don't think that would be allowed
> in the kernel.
> 
> Tested on a D-Link DSL-3580L (BCM6362, d11 corerev 22, N-PHY):
> - SHIM brings the backplane up,
> - bcma enumerates ChipCommon + the 802.11 core,
> - b43 binds.
> 
> b43 patches are necessary for the last point, but those has
> already been sent in linux-wireless.

Hi Alessio,

This patch series ended up on my patchwork plate for the linux-wireless 
project. However, there is not much wifi specifics going on in these 
patches that I can comment on. So this probably needs the attention of 
Rafał and Florian who are already listed. Added linux-mips mailing list 
here. Hopefully it showed up on the review list in other subsystems.

Regarding this hardware I suspect the rest of the SoC used the Broadcom 
UBUS interconnect so the SHIM bridge would actually be a UBUS-AXI bridge 
of sorts which hooks up the WLAN cores.

Regards,
Arend

> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
> 
> ---
> Alessio Ferri (4):
>        bcma: support driver specific quirks from soc pdata
>        bcma: allow SHIM-style mini-EROM wrapper-less cores in scan
>        dt-bindings: bus: add brcm,bcm6362-wlan
>        bus: add BCM6362 on-chip WLAN SHIM bridge driver

