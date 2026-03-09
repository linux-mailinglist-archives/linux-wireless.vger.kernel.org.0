Return-Path: <linux-wireless+bounces-32764-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIL4CGidrmk7GwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32764-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 11:14:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7303A236D8D
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 11:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66689300A66F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88038E5F2;
	Mon,  9 Mar 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XAHZhKtB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2038E5F1
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051232; cv=none; b=AwzkOrs8/kaPUW5X/HZEBgz4p8sjeXMl6C9JKeMUj1EhKbqI8FjR6WQ0VjWm2+astzkusepH6jAtyMC6B0qj8bptmCJqtZTQgfK0VTL96zj6EK5p3RgGqJ7E4uKsHWcu0OGT/e4Z0vHtDJRlWUbthz9watxwAx9COCUi0DfpcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051232; c=relaxed/simple;
	bh=3O1ClvcZ/+xdFWhZrdKDY/UU6nQgrAeoxASJuPuB6+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSIjb/uxQL3vtFgALgs30YsM7L4FwvWyDK+l6zh556wW5X3EeRg0zQiQR9vHGyg9Y7agH9fYQyEV30TXQ60YnLfk0xVBVC1z+d1H2xmcpbTtkfDyG3ResTwUFjMdMbwhoT6TMUypdN3wWRpiJtNXZuGAV6p1XJ7h2YhqfLBWIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XAHZhKtB; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-40427db1300so4318192fac.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 03:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773051224; x=1773656024;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lWxTf/SoHGlgnYNSR0D1m34rvOQjt2x6+PCGENJ03Zw=;
        b=ri2JDObddYbYtSQC3GINieC8MJCyKlh3LWuZCZrzWOCIOS8w9JlqDJAzkDz27zj3f5
         qLh9YQZiR0ElJM3UF5VQnWB22ckw/p771yfUPA1XU5WSi6e8scDDiNJQXnO4df+rzbGx
         QZNMmdEPEoq8g2BZpCB5m8bxfzEw8MORz5dNCMo7seHEaV3WK0keTe82oLzXdsfo4vIM
         h/fL/vJ3VZ01psP+EWVETeYHqyiBPxDk5xdL1e4PhWZnpW1j7GN4FjXoxzhE0AtuVrhq
         wxShsr5Pf2eeJKQm5k7a4zUFGv/zDSZrfijcupnGmgNl5/Bkt7r/q7HgN6+aH5UnWaJt
         HvnQ==
X-Gm-Message-State: AOJu0Yx19JsiKj/0LwZIDVEb9kPs0XakMqQ1BYMFSF6lIzZmgezYoSNw
	0o6rqi4nYmozr9EwOjzXbgyWbrilYqsaudEtRx7GMkQTnVXHbOvu9ZOSvXizZqfhV0otN9IOmhV
	yn5TJ+bZKysXht/V4RHTzlWVCyIlJzjaR02NpwgI/I2EfdeQ1VsyPcvx/TYcJ8BUce5/F8ZcuTP
	8NzgYBEsF64Of4s7uDzeeZ6qnQYMKbWd+Y6qnVphq76JZc12BLUdjv+YTUIJM0/5NCprFyewrNE
	D2TbiZo4PEAV8JVqHbMkkX2BQ==
X-Gm-Gg: ATEYQzyhMI4IiDMMFpPsDiIiNp3UTsaehycWMY+ggzLa/RVdLeCGrYapmAW0a5Zhh/9
	BCiSErT831PFSXBtDD1X3Fr7ZUg1nlRqxZcxvZKw/0sTPvERBQJLmofNENnZxhk6QlBgQe1uvD/
	CZANs7nlcyibDLtfI+u9l2OaY3J1VtWtGvrAIUJKADMfAZJk1jNbvC0UXHyxONkHvK7Jpc+pamr
	KNBf0saB93C3kJqJ4KWKSki+NmJ0sQCbi25kNLtLOHeWl/eThoU7c/frDJwfMs8IxLzg0zy59Yu
	NkfOh0S9ikDWisE+hmTZh7tGypEmGaHwZCHlucgtTwJytiHYSTsVCH35WOBUkVMOgnhXmqh0dL1
	MdYazq5FEPoABZZ/QrPoVCAFaltm0u/OrsYOLbgu/rTs3IIw3DIRObb0cUj3cAgaiUMyZzrx9th
	H31lAMX5B7ZnN4MWl8Y76OuJcb6OAIVQaBcGn0ERqW9oyeAeccGd+neBsRov4jEao=
X-Received: by 2002:a05:6871:7d86:b0:417:3148:c4ad with SMTP id 586e51a60fabf-4173148dc03mr1390341fac.28.1773051224046;
        Mon, 09 Mar 2026 03:13:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-416e67bec61sm1497855fac.12.2026.03.09.03.13.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2026 03:13:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7f6ac239so852447085a.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773051222; x=1773656022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lWxTf/SoHGlgnYNSR0D1m34rvOQjt2x6+PCGENJ03Zw=;
        b=XAHZhKtBsfjs2qq5+PB3aFU1ozbND+rZ9xnVSgMxbWW2W6jfQJ1IOJWvUbNPi7Ywi/
         uYB7h26RFCGBya1NMXMfdsw7ETopXxqZxKBCCxoYBbGn+fSeESipNIr84A2u8pLZknHi
         CSx8So/9YGJn5nmWXBqQi2Xn/fQm1fTbQrW0k=
X-Received: by 2002:a05:620a:4445:b0:8cd:8f41:d939 with SMTP id af79cd13be357-8cd8f41dc97mr79908285a.7.1773051222045;
        Mon, 09 Mar 2026 03:13:42 -0700 (PDT)
X-Received: by 2002:a05:620a:4445:b0:8cd:8f41:d939 with SMTP id af79cd13be357-8cd8f41dc97mr79905985a.7.1773051221522;
        Mon, 09 Mar 2026 03:13:41 -0700 (PDT)
Received: from [10.176.2.68] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8d4cac0esm111942685a.36.2026.03.09.03.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 03:13:40 -0700 (PDT)
Message-ID: <1cc4caff-41fc-4827-8b29-18964b41b49a@broadcom.com>
Date: Mon, 9 Mar 2026 11:13:40 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: Fix error pointer dereference
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 johannes.berg@intel.com
References: <20260217023043.73631-1-ethantidmore06@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20260217023043.73631-1-ethantidmore06@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 7303A236D8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32764-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.939];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 17/02/2026 03:30, Ethan Tidmore wrote:
> The function brcmf_chip_add_core() can return an error pointer and is
> not checked. Add checks for error pointer.
> 
> Detected by Smatch:
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c:1010 brcmf_chip_recognition() error:
> 'core' dereferencing possible ERR_PTR()

[...]

> Fixes: cb7cf7be9eba7 ("brcmfmac: make chip related functions host interface independent")

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>   .../wireless/broadcom/brcm80211/brcmfmac/chip.c   | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

