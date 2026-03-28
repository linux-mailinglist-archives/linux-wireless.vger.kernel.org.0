Return-Path: <linux-wireless+bounces-34111-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hGLzDO8syGnkhgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34111-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 20:33:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 915F634FD2F
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 20:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5512130193B6
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170D345740;
	Sat, 28 Mar 2026 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SHeHQm0f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f227.google.com (mail-oi1-f227.google.com [209.85.167.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F75333B95B
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774726378; cv=none; b=kPokCX+QCayVYv0yygSYDsqvX7OPydsEsBVRKBy7VyyoYJsJX7GaeCFt/wHTWOO3buXKWoFbGwU5GeAkBtCn/NkslBQx6hSxz/gOSJc4fB119wd4WowuPoU88lr9ubPvA1j9uYCf8Gjq2LE0Zwi5QsBHB3bP+DZYPbbXb03NG64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774726378; c=relaxed/simple;
	bh=YUf6rSb052BdvGEYf6wJOK6wUd7BqPk40wYKuw6wD8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkQeyrmgjAlpEkMb/P3Ag0mmgOoq9S/Ccprh0bNM7YR00Dl48PSsIJIfDALe/GB5bweNkIRL45HJyzkF6LR6w2yeh0QvmkargGdQgI9Zaofsp/m4tYLI8C2of++uAjq/3tOaDx1JLl1Pu8MhJa+n9r/eVVhwj6+8p9otFdBZ2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SHeHQm0f; arc=none smtp.client-ip=209.85.167.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f227.google.com with SMTP id 5614622812f47-464bba3a9easo2051482b6e.0
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 12:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774726374; x=1775331174;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hbJ9V04+ZWZ+5XnMMOCYY9ggTWoNFS1ISmhMxK+ydVw=;
        b=c1+lmiBp6G883E3oL0RfRQcSv958ErPNQJOGN0JfG2iZZzZjIn1zfyar4klbFo1fUl
         SHg1QFpeEwOGLoJutQb69UbOFIChhP/Rcw0jYJcKmJRrls05JRZFRHLR+yojW2MjtVwm
         NhL+u1a7tWfBgQnsyOooFz9ATj7SbtzRPqmGZuErK6ltLA4CISwx4I0mr7F+B2tz2sbP
         AdUVhXi0YDp7c244aQmWic+HR3f1GBX6c2c9ss+Dz46XuRlv6dU5RStnIIsOAA7GJM/q
         rQqceRvp1DR3icSw9jlkZwHI5e9tq3Nvcy2iamMDN1di/R/rAOuOacYzTtaJ6cTP9X4W
         tLkA==
X-Forwarded-Encrypted: i=1; AJvYcCWWDCMjsuuVWGKbk7MBH9toO+QvDN9KVIydb7rJH3uSjVROWDdIwbjxDXDz9TN7r5vRbBJtOi1JEPHy2umBig==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9fU8sgFFplPNkLprg7x0AB6T1FmLaMhb5sVUnT1hFGfnqyM+
	cLZzSQpAi1sSTM9Q4ZQQPB+6dsgThem5fU61YjGoIrbfduXvDsvFKGWvL/zi5CbTsr4Q1sSBMfP
	GtKHNtC16YpL14lloP8A+A/QKQ/6CkxZP5M3p2zM7mc4DIDL5a01JkPJJyY0YWV+EOI0hyk02oW
	2A0kJMMKcdC34zr8t9I2xeyBoMFQ2hjrU4TnoCYUaDg9KBBgnup1XtA+0wcpSIpNcWlLmon8Mq+
	9oM1PYuMBBA5+crwiW9bn3qR3VV
X-Gm-Gg: ATEYQzwiWYgfAeJwLFY/t0Un76BS+K+Zmr5wtF7qD/vxsWZKG5+SqpLR5HamUKAO6QQ
	Jf3BDG7VwO4bT/GO/jEKNj07cR3nDJxTYp83dZ+Tghg5uD3LBPHxaruiDPpeup36xXu2aTbRocc
	EqeYAhfSNJkP2FSCiM7pU+W+jbe40sddSM2G5Ryt4jFsg48N9viBo1Vu5dClhwhocMhX3CzoTEs
	tTPaBwfNrccx04FD0Yw8IBSkql3uqTb5aKxxtTfrL6Uh5JbTou73nqy99ZmAKmqkRG6mlqNSpWo
	S7kO7M51McQDPaEX6ckyD2inYx0ttli52dHF+JuR13mHBoy7tpIYr591HouJQRrQoC/DqepI5Dp
	l5wBBzqIxm//Yov1ar4SGtGUwbbsRfhYKGEC4jpe9mNgzRpURzF5ZrDHboxj25nMx+VeGHhVejX
	73mUX1nMTSBTwL36t1+AbkHVIvI0a/Ns/KYWA9JUfdRhR0zv6rf5sWpAN1Bq3y
X-Received: by 2002:a05:6808:c183:b0:45e:e4c9:cdc7 with SMTP id 5614622812f47-46a8a596030mr3596265b6e.27.1774726373972;
        Sat, 28 Mar 2026 12:32:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41d04d50e54sm501734fac.10.2026.03.28.12.32.52
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:32:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89cc2d5ffcaso90076376d6.0
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 12:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774726372; x=1775331172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hbJ9V04+ZWZ+5XnMMOCYY9ggTWoNFS1ISmhMxK+ydVw=;
        b=SHeHQm0ftneomdZSg+m+kfT1jy8vV/Asny+OTtBikOjeZHgbC8S068CZM5IU4+IyG5
         7Ld10nB93yGBgnWjzN5iNUYvMDdJxVv6VP3JeQtD8PszrgAKbCUb+x27BgsXJxBkJHOT
         jIjirsP1Vrt7K/nUlk6TMosXf/8ZiRAsr9hDM=
X-Forwarded-Encrypted: i=1; AJvYcCWKpPqO/zNkfa1NtblkaSQQpCBVj3tG28rXrYigFicTg0+cDOE9qlFW3eSTX/+rF3idyNDfMm/m4g8NiSChLA==@vger.kernel.org
X-Received: by 2002:ad4:5aab:0:b0:89f:1423:999d with SMTP id 6a1803df08f44-89f1423b19cmr40054306d6.43.1774726371949;
        Sat, 28 Mar 2026 12:32:51 -0700 (PDT)
X-Received: by 2002:ad4:5aab:0:b0:89f:1423:999d with SMTP id 6a1803df08f44-89f1423b19cmr40053896d6.43.1774726371484;
        Sat, 28 Mar 2026 12:32:51 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ed02364edsm22958286d6.46.2026.03.28.12.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:32:50 -0700 (PDT)
Message-ID: <83c07d92-ca7e-4569-9358-bda3bd774a22@broadcom.com>
Date: Sat, 28 Mar 2026 20:32:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: validate bsscfg indices in IF events
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: johannes.berg@intel.com, chi-hsien.lin@infineon.com,
 chung-hsien.hsu@infineon.com, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, kees@kernel.org
References: <20260323074551.93530-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20260323074551.93530-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34111-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 915F634FD2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/03/2026 08:45, Pengpeng Hou wrote:
> brcmf_fweh_handle_if_event() validates the firmware-provided interface
> index before it touches drvr->iflist[], but it still uses the raw
> bsscfgidx field as an array index without a matching range check.
> 
> Reject IF events whose bsscfg index does not fit in drvr->iflist[]
> before indexing the interface array.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 5 +++++
>   1 file changed, 5 insertions(+)

