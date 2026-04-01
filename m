Return-Path: <linux-wireless+bounces-34287-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UASwIzqjzWl9fgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34287-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 00:59:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01231381285
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 00:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88CC330158A1
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 22:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEF73BD24D;
	Wed,  1 Apr 2026 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBixx8O/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF1B3859D5
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 22:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084319; cv=none; b=r7HlyS4gQWwRqMb4pm9qdMCKA7Ioo49/xsqQFnPsB9C/zvXXqwIthL4E6iARFi2S8Zm0a1psnbDmqfUOo04awuyhNjz8Thgb2ajEpGqoyp6NyvZN2KcPRIlZMmVfNcKYjrDRUQNbOTo66kjPvZJFjVbHZ2wWgfGtlrFZeU9qVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084319; c=relaxed/simple;
	bh=8bIAS0+bOkwgPsPLNR9zP29IJ2JqtnsWyFUAJsNFWYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HqGdx8mA7oYzpFRI/7E/HRhahODUlI1z7+2cbb2ctmdQCFe2QwyFVznN23+BY6oW9YS9T0N0Vcx4lI6c+PQz/6Q0ZkdJcmeKdEf7aLaOTezUjov6rTIxM/h5+7FstW7kAuqER0MkRs7G2yYXkY+IidrDOXbw8iWnxKZr8vTEERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBixx8O/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so2524535e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775084316; x=1775689116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+NiT8aph1Oh4THbDCVUM/vvu4eeH7pv0tJ9d9OfH1A=;
        b=YBixx8O/MYTC/TBhVl6vNnfEOuXSK+ciQw0oTrSzQXTlIqrVSOJv8B/DcMA/BGOPRQ
         haXwFuMp79C8PGwE0mV6hf5lytfxDr0qxxpbS1N9xD879w4kTo2sJA97QqgSZNXrzu4s
         WE3HTzcQmgtPzQDW8KyaW9vrGKyqTdtLew8n+iOjcqs1QCZzREp+C48Um0Ananko9sPY
         R69MRHcGI4zJR97dee3GuUYFNHF7bRb9TcxLMwgA1zIN4txUfP7d6ro+C4YN1Hfwl6Og
         WSpNNG55a+ZR+tpPs23LQPa82HC1TzNxUhblovcm8njl9J/jzs+bPplk9WWqqJiaRDlY
         re8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775084316; x=1775689116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+NiT8aph1Oh4THbDCVUM/vvu4eeH7pv0tJ9d9OfH1A=;
        b=mdqqt2xCXoQQcSSqz/QTI9fwhxFhD3IgTq4TlzIsiHPLL7fTTYzCSCubrc4CNseL5K
         5WNtM30VoFdC1FLbrO2/vjBTtsxZgkWH0dBPw8T25Pl81jzJBiS7puOAnZszV8rUcpb5
         4VCKosgzx2d3KZNTANVWwXmkW2zetlq3FzFPWAVDvmJ6Y2OSmbD1yGSelStKeGPZw/sx
         MjjTkQZ5mthu6xgwins+Fs/UORMGDtIc2/QULp1QQbDommO7uqh/4r86YuJAa3IArMAD
         3wTIXc1YnnzO8HMi2FsojMS47yo5GxVQN4HcbyG2H5Ol3uxtCUdvSXzzGePP9ohOrzfq
         2D+w==
X-Forwarded-Encrypted: i=1; AJvYcCXJg/xY4MN2H9Dn5jqsEmeDVN2BQsx7RUcyVkILcxmYLijXFZL4t9Vxap+AQmnHWOVl4UGYTubBBfEdRJRqlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymbxbqP10z1MJJsKvdzBhkxkbNoHjJ4MA/oAlXgQU9EnSacHVf
	8jrf+1GPfC6TpCqehLbcP94a59NUnvSOjNnmal3WGh3BYjFH6L0Dzz5qGead3A==
X-Gm-Gg: ATEYQzzfgEeHQ+8nKtA/o48cRHWqTIQaT/gli2H3j2FaAjIs399JcxUD7QdpGP3BF9X
	fduU0cBgx5JvucFB5jI+p9QM60cUvTbBHsXaRL+eVHioIkizrfYDqkEdc5pbq/4yh3C3L9rT16F
	d2X1zKOPNUl6cShLMdL61lvZt1xz8l+HFTyDhU2gkD1J/rpgoUZTSWaUcVEePSd0T//0FE6fU/J
	MPtW+sdW/m/D4CyM3AIPfiz+1aEp5DlmkbmttvroZQwYWCi1cSBevpJJcxCZvs+EMWxef+MUT8G
	H1bb2l/GNQKE5NHIQ3mVxwv/G6rfWbC8JQRY6i/ZaNIccBIN94yjB7W5JeRSIkVXG3/+gVpPvBh
	VfLG0Ap61oYYb/s7B15j0EnqwRk0VzClrUz81jCHd/fxcQw9Fa6M5TW2A+ud6HUigQTtGAXSwDM
	m6yIAKvXMR4XaUeVYA69rY0LL4PMgUXg==
X-Received: by 2002:a05:600c:4507:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-4888b6eab58mr17464155e9.5.1775084315504;
        Wed, 01 Apr 2026 15:58:35 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad782d1sm51766185e9.9.2026.04.01.15.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 15:58:34 -0700 (PDT)
Message-ID: <b0181475-ec36-438c-b5f9-0aa886ddbe3d@gmail.com>
Date: Thu, 2 Apr 2026 01:58:33 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 06/12] wifi: rtw89: usb: Enable RX aggregation
 for RTL8922AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <6d7440bc-d463-4d99-af12-181684b87bfa@gmail.com>
 <5853e0d8036840b89080229ed1aa4deb@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <5853e0d8036840b89080229ed1aa4deb@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34287-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01231381285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30/03/2026 06:46, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> It uses the same settings as RTL8852CU.
> 
> Though the values are the same, I'd prefer listing them individually, since
> naming is different in vendor driver.
> 
> #define R_AX_RXAGG_0_V1 0x6000
> #define R_BE_RXAGG_0_V1 0x6000
> 
> How about you? (I don't strictly request to this change)
> 

Okay, I will do that for v2.

