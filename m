Return-Path: <linux-wireless+bounces-38827-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QZ09MBSxT2pTmwIAu9opvQ
	(envelope-from <linux-wireless+bounces-38827-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 16:32:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 305EE732477
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 16:32:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QKIUfyxM;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38827-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38827-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D331C307F9E5
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE25331ED8;
	Thu,  9 Jul 2026 14:25:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E854331A44
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 14:25:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607143; cv=none; b=dK+SQsYl/l/O4Apo4Fs0ODLYZIGpOUg1R+sBoA2M5fjLVQC9MTtzRAuqc4/ArWmELKQzRWXQEEJ2Cc7P6ZE7b3VWf/W5ObNZuho8X/b5VUZAlBBS5naXxDKYXi80cYNAEnNwkT9CKJbTu7FF2P3npEvUWsR+78zKEwr1JD8LEqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607143; c=relaxed/simple;
	bh=hC37SAnEaKZ1enzGWS6yJwj4lDgoNJ651+6O6abj02I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwypmmTLUPE63VhXZqnmt9ajFcmbdcvJKi4/VZ5dxGpSSxzLoaV3tKf0puHgZozxfB3gAjiOmIjZwC+sjLisXf379Mq687rnplye9UE5nyU1FUj0Zxgv5hEbg8YwttE33YemRxyQThgOiae+94PpvuVmX3PQxXPVLpQU3CjJb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKIUfyxM; arc=none smtp.client-ip=209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15ba5b151dso271791566b.3
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783607140; x=1784211940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2bB0tJWH6y8rTql5hZWqkDrLdX8GipZjxHFgd9xpVIY=;
        b=QKIUfyxMDyJ/M8DzvIBhGAoFKcBDHmpspY3mcVnUR9pJMNMav4pbsLd0yd5EyMlGWt
         tvPxiGBzDFvyD8y8IdX4xva7WnmYDFcxYxYE7df0Yqw8i5g7rHg7B2vRwewEnikHeUYI
         xtB3anXkbdY08HnEd/z/JmwqjlvIxjcIrXBdgKe0BeGNPpRkGESa/8Z8FJEbTupRuyqc
         GCQyjow5vXsdoGPDWku/C8skV5jObIxSruEfJQfU6MitENCKK5FdiqqThltBp9x40cwc
         JNGZHIYoT/tlAi5bFsRPvcKA/Am98Ql+tt+5/FhercOXLEB9ek4/+CywOCRUwSl3KcYa
         v32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607140; x=1784211940;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2bB0tJWH6y8rTql5hZWqkDrLdX8GipZjxHFgd9xpVIY=;
        b=ORToHcC4KG4CaXXcdoLtIfBQL8M0HTJP27xLdUAt7VEd1DfT9+VTa7Ig4EiWW1TcN2
         hPtjom4bFRAFSInGeUWCPEoro7A2m48hbmr5G+n3btq68OFN96aJUgarPbwi0OmjpxV8
         Osfcep1y6+v7Ney9qPQTWHzaQ6OcBmo+O6x+pgyBpdi9OIWLgwIzyR7Q/Tr17lY6puJ4
         yuqbTlh2PhZwDgmjxLMJrDBXIy2fLuMIMNL3Z2GKBvq83QnjQtzqaOliTYstIiQ7gvD0
         YCoo+yAZJy27GSK1R4rffxVwbikdXAhj9kIAepsWov9VwzIBsllah0dwiDEP1ZPStVaU
         83Ww==
X-Forwarded-Encrypted: i=1; AHgh+Rrc2k1EsmkAiHrbHEggCibmlmwLzi5opI2ZuZ/pdRtiUPOZdDMDl7cyySzkS8aGqmDWtXHHDAjjuXkFkDPPPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKpCvHjrFXXmXlUNhsX90kaWaweEgZVy7cIO/O83ReuA5R2fHb
	15QvAHCmTktWuDt4SR5RqUNaghYMUpPup7pS9xIPqazUSsZQ388Ilx9N
X-Gm-Gg: AfdE7cn744fmTZR0qkdxP548ZxBH5d8WIvD/GulW/UAwQQdaAIfo0NgrbL2E9jNXNHc
	5lgbiHGuuFHE1+q7e0G3CYH/nMQRyf1M9CEq3Gh6MBWOHBgIy1c5QKAZY+xVM4yzbYXz7NOK931
	wiiDleAnU7ZEDxGes6wJNBhBC1L2qbjR74+0wCuilOX7aUBnpUgcuvYZhR6zhCyX59gnVHI4A7T
	0d1H0tblR4rebpZWExPgZoH0Hzdid8OoIo7fVPtQbdc14LIozqDnWedUozhfzaz/Yjxb4GT76bb
	++UcizjF4eblcArQeLa7IjvKZlf05BecvKjWWouczihfCFkvsIsHqWnyuQo1VxIcwjTvIzd6Cx3
	/qv6Q1sNmdM2jNoLI1EoqRGcUgCFFWxoF1q7WNAbGena+fnNgY4J/rUbrWAHUT15jRq5JJo0cjI
	zN+qmnlGU7nGCUsZX1WHko9Vp8AZjs3do=
X-Received: by 2002:a17:907:7211:b0:c12:4597:601f with SMTP id a640c23a62f3a-c15ce131902mr350361066b.53.1783607139638;
        Thu, 09 Jul 2026 07:25:39 -0700 (PDT)
Received: from [192.168.1.50] ([79.118.68.203])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d026a479sm280465466b.18.2026.07.09.07.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 07:25:39 -0700 (PDT)
Message-ID: <c2c05574-2179-4b9e-b681-90387bea3561@gmail.com>
Date: Thu, 9 Jul 2026 17:25:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 08/16] wifi: rtw89: add IO offload support via
 firmware
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: leo.li@realtek.com, gary.chang@realtek.com, echuang@realtek.com,
 wenjie.tsai@realtek.com, phhuang@realtek.com, isaiah@realtek.com,
 kevin_yang@realtek.com, mh_chen@realtek.com
References: <20260420034051.17666-1-pkshih@realtek.com>
 <20260420034051.17666-9-pkshih@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260420034051.17666-9-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38827-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:leo.li@realtek.com,m:gary.chang@realtek.com,m:echuang@realtek.com,m:wenjie.tsai@realtek.com,m:phhuang@realtek.com,m:isaiah@realtek.com,m:kevin_yang@realtek.com,m:mh_chen@realtek.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 305EE732477

On 20/04/2026 06:40, Ping-Ke Shih wrote:
> +static void rtw89_fw_cmd_ofld_udelay(struct rtw89_dev *rtwdev, u32 us)
> +{
> +	struct rtw89_fw_cmd_ofld_arg cmd = {
> +		.src = RTW89_FW_CMD_OFLD_SRC_OTHER,
> +		.type = RTW89_FW_CMD_OFLD_DELAY,
> +		.value = us,
> +	};
> +	int ret;
> +
> +	ret = rtw89_fw_cmd_ofld_enqueue(rtwdev, &cmd);
> +	if (ret)
> +		udelay(us);
> +}
> +
> +static void rtw89_fw_cmd_ofld_mdelay(struct rtw89_dev *rtwdev, u32 ms)
> +{
> +	struct rtw89_fw_cmd_ofld_arg cmd = {
> +		.src = RTW89_FW_CMD_OFLD_SRC_OTHER,
> +		.type = RTW89_FW_CMD_OFLD_DELAY,
> +		.value = ms * 1000,
> +	};
> +	int ret;
> +
> +	ret = rtw89_fw_cmd_ofld_enqueue(rtwdev, &cmd);
> +	if (ret)
> +		mdelay(ms);
> +}
This can fail to compile with some kernel configurations because
RTW89_FW_CMD_OFLD_SRC_OTHER (4) doesn't fit in the mask
RTW89_H2C_CMD_OFLD_W0_SRC (GENMASK(0, 1)):

In file included from core.h:10,
                 from cam.h:8,
                 from fw.c:6:
In function ‘le32_encode_bits’,
    inlined from ‘rtw89_fw_cmd_ofld_enqueue’ at fw.c:11655:12,
    inlined from ‘rtw89_fw_cmd_ofld_udelay’ at fw.c:11858:8:
/usr/lib/modules/7.1.3-zen1-1-zen/build/include/linux/bitfield.h:217:17: error: call to ‘__field_overflow’ declared with attribute error: value doesn't fit into mask
  217 |                 __field_overflow();                                     \
      |                 ^~~~~~~~~~~~~~~~~~
/usr/lib/modules/7.1.3-zen1-1-zen/build/include/linux/bitfield.h:235:9: note: in expansion of macro ‘____MAKE_OP’
  235 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
      |         ^~~~~~~~~~~
/usr/lib/modules/7.1.3-zen1-1-zen/build/include/linux/bitfield.h:240:1: note: in expansion of macro ‘__MAKE_OP’
  240 | __MAKE_OP(32)
      | ^~~~~~~~~
In function ‘le32_encode_bits’,
    inlined from ‘rtw89_fw_cmd_ofld_enqueue’ at fw.c:11655:12,
    inlined from ‘rtw89_fw_cmd_ofld_mdelay’ at fw.c:11872:8:
/usr/lib/modules/7.1.3-zen1-1-zen/build/include/linux/bitfield.h:217:17: error: call to ‘__field_overflow’ declared with attribute error: value doesn't fit into mask
  217 |                 __field_overflow();                                     \
      |                 ^~~~~~~~~~~~~~~~~~
/usr/lib/modules/7.1.3-zen1-1-zen/build/include/linux/bitfield.h:235:9: note: in expansion of macro ‘____MAKE_OP’
  235 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
      |         ^~~~~~~~~~~
/usr/lib/modules/7.1.3-zen1-1-zen/build/include/linux/bitfield.h:240:1: note: in expansion of macro ‘__MAKE_OP’
  240 | __MAKE_OP(32)
      | ^~~~~~~~~

https://github.com/morrownr/rtw89/issues/111
https://github.com/morrownr/rtw89/issues/106

The reports are about the code from that repository, not the kernel,
but I assume the same thing will happen when someone tries to build
kernel 7.2 with the Zen config.

Using the same GCC 16.1.1, this fails on 7.1.3-zen1 but compiles on
7.1.3-arch1 (the standard Arch Linux kernel). This is the difference
between their /proc/config.gz:

3c3
< # Linux/x86 7.1.3-arch1 Kernel Configuration
---
> # Linux/x86 7.1.3-zen1 Kernel Configuration
40a41
> CONFIG_ZEN_INTERACTIVE=y
148a150
> # CONFIG_PREEMPT_RT is not set
218a221
> # CONFIG_SCHED_ALT is not set
270a274
> CONFIG_USER_NS_UNPRIVILEGED=y
290c294,295
< CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
---
> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
1264c1269
< CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
---
> CONFIG_COMPACT_UNEVICTABLE_DEFAULT=0
1477a1483
> CONFIG_TCP_CONG_BBR3=m
3057a3064
> CONFIG_VHBA=m

So I guess the error happens when rtw89 is compiled with -O3.

