Return-Path: <linux-wireless+bounces-39088-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YLolBv5rVmoU5QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39088-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:03:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F0375730B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:03:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=euuod8Fq;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39088-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39088-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86DD83075375
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069CD4EA397;
	Tue, 14 Jul 2026 17:03:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F882E7386
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 17:03:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048598; cv=none; b=W8efJK0/radn/fg+K1yHj7pBlgCPXn8RwlehG1jNtLySCWQ4MEdUXL+ylwEW7eaJ5GMwwmr6arQnvZcEfvygQ0L6GYTVvCb47l+t9ZEMV/EXmKdlzav1XCH5qbV/rTrp/NP/hE+rx/aeqcRec+ye1Le5jJARKGYeT9TtGN+P6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048598; c=relaxed/simple;
	bh=RrM+CrO/r8o7FGUOsnl8gZr1EiYzoxDBKu+JkNQEhU4=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SVrWjJyY9XBnCPyWHhIrH/t1DdDzm6wIb5qvdLicNuwmSkrPtpzn1GRV08l+wZdiPGiIIi6GUXFh0oP3f/+86bZGhYpkF23WXFjdRQqMnl9es2l81tzi0XKPl8K8wBUfEcJ2dh72JaPVNYpJMPa+MYjL95XssWuBL2WxiRfgOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=euuod8Fq; arc=none smtp.client-ip=209.85.222.97
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-9697a691b5fso411160241.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 10:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784048596; x=1784653396;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3XaKw1mZ5safaShnh8fqMEdlQ2rL6BwLt+Z3QDeOIY=;
        b=b92g2fCSzeydQON3E5NNqh8SNMkH/SBCa2ExiJ+OSK1j4P7LQaQgvl42P1zYL+70wv
         sn7IXZELPAs+TcajjIPEowP3XPf+kkU0KcI8M8m6u58BHgtQj9M0SKCVW2X8MD8Iqapt
         5lmQO/u+LUYrygBmGkKpj1XHQVqy6CIE50boRU6UXnjutse8RFhQgaydG0F8jNx8TuCI
         ZbZsDq0ReDwz6Ep7nYjhpabWdtiNF+Cx1FhgtNiZ5qcgePgISrUWxwiFSqMHDAtpjsZ+
         VD7NK3f2yzJdOKFpH54p6vkf0L7uU9vWPPJI9V+FHSGfLP/J8YNr+jsA8YO3nKitOqIS
         unAg==
X-Forwarded-Encrypted: i=1; AHgh+RpXlt4EexhB5moyNJPfT8LD5/MiAviy0V6UkMWlQMmA9//luTjhTgAE6YI2YZkup4xt4Rs20/7iuEP3CLp8YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LWFW2bJJOkCeRWMz6DVMvEh9wESaBLX8wfjnY8PcvIhPszve
	pF5RxMPjmGbp4lLCQQzvKm5Ru8sMIgbvq9SUVS0zT7b9sTnL1+admUVDzAer74gRGirYIaTqMns
	YC9/D75P+yaTin3WkwIMukTZa4UBXGLzns2sn4eIoGoLOm7YVyHZFMeIZRrhJpPuZeQVUSCLIdB
	a9iQ/PxGjs6sqrm1PkhYRwGmWINHEfpAFGStN0vvpa1yIyFB+YtZw/Sho7V3uACyAUQHSfqGquy
	j2zk43GQyV7z5+/O9etedNEGHTS
X-Gm-Gg: AfdE7clVuLSXCFTjf2B/NaA+XAftIdlJ3rNDDTmQfx4TTQc//DfdhF9F0bLJ16rOiuu
	I6Lf6nDBfvm/cBuBDvs5GT+Fu5KkKN/3YDlmjmoQlMyXUHazghYlfEnofPijLnPt2V1VmUzRk01
	EZA0vHODr/4p0ILkZMm94w8752aqYjird1skiJlepcVPQZEmd8+ZubqHt5eF6MHrwkTKdYNuVRt
	tD2rwv9YyiB9/dGsvC8FVxlLX+UcU6yD7ML2vPB79n8b4qo4nemJatxNhARagt1VW6uaYwl3bb0
	Acges85EnH7MB8XzYNYFjIPX71zu+TWyf2uS8EJShFVylk34Dgi7gLzRYJvNG6u1cRI7wHqyOJ8
	M11rjYPT8oDYTErTtVMykYzmGHQkR2AV2ZJreBr1deoRmfNEXvNoYGo2kJ6n2lne0uiU9K6LkT0
	Br0uW8ROMxFWWXRfCwm358XoqjZ0RSwqTC8RQTzwxPv4SsJv0=
X-Received: by 2002:a05:6102:50a1:b0:737:d2df:3fd0 with SMTP id ada2fe7eead31-74533bddb95mr7662896137.8.1784048595883;
        Tue, 14 Jul 2026 10:03:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-744d6e8de24sm1554933137.21.2026.07.14.10.03.15
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2026 10:03:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15d4224f9dso226087866b.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784048594; x=1784653394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W3XaKw1mZ5safaShnh8fqMEdlQ2rL6BwLt+Z3QDeOIY=;
        b=euuod8Fqcfp8ICKefFJ9ybVoubYd7r5xnu/Dg4cfK3jG/3XBZ9yz56iRluKr5vx3pC
         dT11B2mAyJpdA/K7r/T7Lu2AmbbxLl+tEHCTXZZ7kZWHXnYfAEAfs7rA360nt8i5QW1I
         VAnFdJ/Whmtriyt4IfE+Wbsam3dXWXxT70Eag=
X-Forwarded-Encrypted: i=1; AHgh+RqdMEj6eevg4mKOMzbReYUN1DySjDpctI/SHiQbDcAo8J9UQbihcKaEW2c0M4ru5fOwa7WZ2hF+WqCbCWBJ1g==@vger.kernel.org
X-Received: by 2002:a17:907:8e11:b0:c16:5b2e:f972 with SMTP id a640c23a62f3a-c165b2eff60mr300352766b.53.1784048594374;
        Tue, 14 Jul 2026 10:03:14 -0700 (PDT)
X-Received: by 2002:a17:907:8e11:b0:c16:5b2e:f972 with SMTP id a640c23a62f3a-c165b2eff60mr300349566b.53.1784048593952;
        Tue, 14 Jul 2026 10:03:13 -0700 (PDT)
Received: from [100.98.74.8] ([109.37.130.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15b7561db1sm1136622566b.12.2026.07.14.10.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 10:03:13 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: LiangCheng Wang <zaq14760@gmail.com>, Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
CC: Kalle Valo <kvalo@kernel.org>, Angus Ainslie <angus@akkea.ca>, Wig Cheng <onlywig@gmail.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <wlan-kernel-dev-list@infineon.com>
Date: Tue, 14 Jul 2026 19:03:13 +0200
Message-ID: <19f61952868.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20260714022859.1849447-1-zaq14760@gmail.com>
References: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com>
 <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
 <20260714022859.1849447-1-zaq14760@gmail.com>
User-Agent: AquaMail/1.59.0 (build: 105900627)
Subject: Re: [PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FREEMAIL_CC(0.00)[kernel.org,akkea.ca,gmail.com,vger.kernel.org,lists.linux.dev,broadcom.com,infineon.com];
	TAGGED_FROM(0.00)[bounces-39088-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zaq14760@gmail.com,m:gokulkumar.sivakumar@infineon.com,m:kvalo@kernel.org,m:angus@akkea.ca,m:onlywig@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:wlan-kernel-dev-list@infineon.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,infineon.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80F0375730B

Op 14 juli 2026 04:29:16 schreef LiangCheng Wang <zaq14760@gmail.com>:

> Hi Arend,
>
> On 13/07/2026 12:51, Arend van Spriel wrote:
>> Looks good to me but the stable instruction looks confusion. What do you
>> mean. If there is no 43752 support there is no need for this patch, right?
>
> Thank you for the review, and thanks Gokul for the detailed
> explanation - that is exactly what I meant, and sorry the annotation
> was not clearer. To summarize: 43752 support has been present since
> v5.15 (commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and
> initialization")), under the SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752 id
> name. Commit 74e2ef72bd4b ("wifi: brcmfmac: fix 43752 SDIO FWVID
> incorrectly labelled as Cypress (CYW)"), which landed in v6.18,
> renamed it to SDIO_DEVICE_ID_BROADCOM_43752.
>
> I also have to correct myself here: the boundary in the annotation
> should have been "<= 6.17" rather than "<= 6.16", since the rename
> only landed in v6.18. Apologies for the extra confusion.
>
> Gokul's suggestion of cherry-picking the rename patch together with
> this one into the stable trees sounds cleaner to me than editing the
> id name while backporting, so I would be glad to go with that.
>
> If it helps, I would be happy to send a v2 with the stable annotation
> in the prerequisite format from
> Documentation/process/stable-kernel-rules.rst:
>
>  Cc: <stable@vger.kernel.org> # 74e2ef72bd4b: wifi: brcmfmac: fix 43752 SDIO 
>  FWVID incorrectly labelled as Cypress (CYW)
>
> Please let me know if you would prefer that, or if the patch is fine
> to take as is.

Cc: instructions to stable should stick to the stable-kernel-rules format 
if possible. I suspect there is a bit of scripting sifting through it.

Regards,
Arend

> Best regards,
> LiangCheng




