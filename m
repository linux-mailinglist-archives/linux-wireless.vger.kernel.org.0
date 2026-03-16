Return-Path: <linux-wireless+bounces-33296-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGdGKlnjt2mzWwEAu9opvQ
	(envelope-from <linux-wireless+bounces-33296-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 12:02:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5321D2986E0
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 12:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E69BE304BCFE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8578390C93;
	Mon, 16 Mar 2026 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxysC7u1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F096390229
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658624; cv=none; b=HXBWurLjCbc2UpU3hmWzVEfINaedxcOuaKdHFk8kDT/lgmoFFMvsArD4DrkpFmAyGclyGg4YTxI3H84zTByCpCHMUocZXxE2i7JiSlu7JiXpFFWxJRDXvn/JMlWNmeyBOcVwLyUBeXTVOUD8BWy8kRf+5QCpE67ndFliG7KGdDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658624; c=relaxed/simple;
	bh=VzxGWTBeSLk5UNJkp0VwYX8eFWPdbdJVWUyczZh3PQU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lZs0HSRdgJ0j0I+jFy7+X+Oi3/UB7zjCBySlGU7IZlnr+ZyYqUlAcanxabILF0xZV4vIGeEzdA8ysqweYIgqa0PdWx7GrJzUEIM1oCtg4gZ2qxgvujD3nsqQDEt1x5boFmtwKMbxINJG0VlQ3SFLQ804ZEJhHmOnCcPZ7PnkZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxysC7u1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48538c5956bso41770295e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773658622; x=1774263422; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmBiFHGEKg6lWFa683rASkkA4loORSF+TCINv8eIzlI=;
        b=mxysC7u1nICYh+ozNd0uclmti4//6BzhC/71LB4oZ4nxs6yQGlVeDxAg/KCgARL9DK
         AHEbKiFmUV2OOzhvlsTCiQ8o+XXbh7c555gAf0hjiL/zDNjZ/VcSbYe6vWuq1Xr8CLoc
         S1GSt8T+NZR2P6c13V5Oo/7KVFVByWb+3tXWRLtkU0HGXhwAvAyR4zFtMcUj/Xw7h36Q
         k8vqw+aK6KxNBEvWb3A7KXZHf9BwFeuOBCUETqDPvpdJmem9db4ebyq6bjxEtkCabHzC
         ycW38FGLHPn+EaU74YCb9XTKHRM0fWFwmzqLrPUt63VnR1RyyEgxueyZg60U0H2V5P0r
         c3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658622; x=1774263422;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VmBiFHGEKg6lWFa683rASkkA4loORSF+TCINv8eIzlI=;
        b=A9MhXBARRCEqAocKgzJOp+LONuA8xIbqe1VRK6MoFdPM/wOG8ITs0Lz+kn4CbjhyFq
         50NdNuzVlZcsHxMiZiyXvghhYFBDzI7Llt9VSCOGUZTsX/eraruksJkodpnWzcp6E4nY
         LwHDAmFMeVgCCEcOE7Ch5h7mICUHyPrhOjKem2isGJQWDkx6VFESfIl5yjM/JIsTKL3r
         itkvw/U06lVpWsuAYOdNP2Ushm9GRECjdtp495ObV9ZaGapdNdCGDywnI5vbm4GfHm28
         7kaVjf3a8X+//0xy+G7F+LtLi0IHim455ZzenZgqc+auT58NvJknmGycCn2l5+X1U1A/
         svQQ==
X-Gm-Message-State: AOJu0YwF8hxXjC5ZZ9pqW5uHjPM5oxvs25J9OxA6OhHB0L3gyuOIocHr
	Rx4Ueg6wWl6AxfenNu0JB1D9m99IxxmwH4wd/QC7Ei1g45/zfgWHUtlJ0kyLog==
X-Gm-Gg: ATEYQzwgS+GG7bx9BIDVTiegHAghIx2H6thW9vNpUUJKZSUgfSTyZqwvynZMVuJZx6N
	jJ/89FhI6FcQTrxu+wxCA/4i133IzYOZ0sAo4uLNIHwLYPgkXNs2/Wu53tKN6cmrfgbyg7tTR7o
	026Qt2oWhMea5xDjZWvr4svLxoHe8nLOuFbeuMAmMKRk3WkGKZucfW6frSJ3qm4ixM3hAIVbs/g
	v0I0IFgWJy9xiYtPjy8dx9lLbVnaPgocLt1/Dpx2LRWAFD4yQVi3JpJnacIUtlkfXJ6lQVAJldz
	oxNR+pKvf/Y5LjqULOAQOVFa0mEk2Lcb9P4bzm/gwnAU3hiIv7kzbafbzxwZyJ25OoZXpKEfXSO
	Z0/qhZ7itbNywtNSBpbziTHNWTq809lrS9vLc9ghrT9j8IbfT8Chxs0RL/6WPjefoQOwYnWrDHy
	run7B0CePuG+gxx0zeP/w92+yu3PTz1R8RNZYaE1Z1iUiLjM8CjD7e
X-Received: by 2002:a05:600c:1395:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-48555b2c86bmr201827335e9.9.1773658621460;
        Mon, 16 Mar 2026 03:57:01 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f255sm522370455e9.12.2026.03.16.03.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 11:57:00 +0100
Message-Id: <DH45I9X47H77.74AIOL6V8R49@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next v3] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Baochen Qiang" <baochen.qiang@oss.qualcomm.com>, "Nicolas Escande"
 <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260316103248.3042158-1-nico.escande@gmail.com>
 <d38acb9f-60dc-4d37-a3b5-8cd09f76939e@oss.qualcomm.com>
In-Reply-To: <d38acb9f-60dc-4d37-a3b5-8cd09f76939e@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33296-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5321D2986E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Mar 16, 2026 at 11:42 AM CET, Baochen Qiang wrote:
[...]
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -2321,5 +2321,24 @@ struct ath12k_base *ath12k_core_alloc(struct devi=
ce *dev, size_t priv_size,
>>  	return NULL;
>>  }
>> =20
>> +static int ath12k_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret =3D ath12k_wmi_alloc();
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>
> nit: you can simply
>
> 	return ath12k_wmi_alloc();

Yes we can, but I did this in case we need to add more stuff in that functi=
on at
some later point. It would generate less code chrun. But I'm ok with a dire=
ct
return statement if you think that's better. Just tell me and I'll send the=
 v4.

>
>> +}
>> +
>> +static void ath12k_exit(void)
>> +{
>> +	ath12k_wmi_free();
>> +}
>> +
>> +module_init(ath12k_init);
>> +module_exit(ath12k_exit);
>> +
>>  MODULE_DESCRIPTION("Driver support for Qualcomm Technologies WLAN devic=
es");
>>  MODULE_LICENSE("Dual BSD/GPL");
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wirele=
ss/ath/ath12k/core.h
>> index 59c193b24764..02ee6c718621 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -19,6 +19,7 @@
>>  #include <linux/average.h>
>>  #include <linux/of.h>
>>  #include <linux/rhashtable.h>
>> +#include <linux/percpu.h>
>
> does it make more sense to add this to wmi.c instead?

Indeed it does. I'll fix it.

