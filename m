Return-Path: <linux-wireless+bounces-37631-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /koXGCp6KWoRXgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37631-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 16:52:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FB566A6B4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 16:52:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eFAkaZAB;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37631-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37631-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C860323CFEE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 14:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8713E4266B9;
	Wed, 10 Jun 2026 14:35:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0141930F
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 14:35:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102122; cv=none; b=g8LIb4zfnHW94QchI0Ihgki1rekKibxq3TgcNwwdwQ8VMyCSiQeHF6E/H4T6JkOGEKOhwI2BTXpzbpL4N/4xyOZzHbknxyaABqX952bl2dhv0olW2VhBSsF1iViqjuwhi2oem9kFJk9r9u9TBvDzlFgmW+8W2tneB2u7ooUSqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102122; c=relaxed/simple;
	bh=HvczFRqGw+IRU1mDcrnLUUgG+MM7iQrUu0vju3oC6GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmDyUJkg4uivL5Q/CrWzJOmDej2c+hdUZzKuiXlAlxy1P7LCBhkOKmn74Lihvmo+EB7/64JG8mgQgmgZGur2qVJvJuG4FvqbtM0neV1knGewLC/+gs3Io1Oh0IY7y9kLot0CC3Un7je0AlYhBKUzDONWQZS/JrgfY3nIpGNf4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFAkaZAB; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef5146b56so5039917f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102118; x=1781706918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e/NimQjbBFn6JbAdVCXHQ0b8RgUcxqZ7nFsxKAMXryc=;
        b=eFAkaZABS9/FunV8wpte9zBDIXM6mHoeqVN3DpDn80uOzw19UICnGtvONk9q0JdAQt
         NYLphHAnyR2N495u5AZ81e6colTjK4b8fN65kp/EpOF11z2lZfaQNmb5MDdNvA+/MK5m
         TMlJYuph1V663+23ODKupIDxHpNM+ArbWo2aaCde83xp2PFE1bedDz6VI7JQibrc7DNv
         0myq9iPKcCfGZs6/JfMmz0UxbjySN61Y4rrvz3aEZKc+7B7wDvxBLraw9hxKEmSzbF2S
         LjS/7qQjvgA8Kbd0CsJm1GOjEcej6FTRFe9Bg4n5V6YxTTO4DnGG9H1RxNWpMZUW5EXq
         D2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102118; x=1781706918;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/NimQjbBFn6JbAdVCXHQ0b8RgUcxqZ7nFsxKAMXryc=;
        b=S3EGt3kmmPBDg44II65XfnmsX6m4vW5pp7r5/kjQSIzz5S5+aPWV5UZ65ThoaAfNss
         j259IQzenqrjHziEF9eyEiMLBWdfq2FUPYTlEINY0EHPUovkqndeZoonFon4lnUFRRtW
         Qun8OJ/4Y9ToEV+PNlwhvC4/PUhW//C3T68ONgVRV3sp/oyGxNWZJchtBHJhog5XSw12
         qA8KRhsNjE11c0EVVD9tRhNpiAd1Ns7sGnbobKrBeaWC68TNT6RQeAVoUyFKSoZIgwns
         ggWHWJTwmZRyRZau5HlIKrFRkC5LLjSMmJZXys+Q2PiUP59OUDLjie+BNy+fF164zslb
         yB8A==
X-Forwarded-Encrypted: i=1; AFNElJ/IXgNV7MaSTL2PPme+E9u0+GMyjd63twG6minSxBGx2pND+83Gxo6FBJeqV1QNw4sy07ZJ9xRQueHiNAAeog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Lb25kt87wBDztUSQJzl8k73kt7kcFxk3P6ZwQQvl3bYGQ8Ir
	Sn3NuFK2tgNbXE8vKptFQ7W2ujgm1EaLESxLtj0RIjElxM2fophhtbzuExQZIZoq
X-Gm-Gg: Acq92OH8Dsg9bfA/cFPEotw7cqdxf8Ssru2co11Y6V+II2SrgS+ZZ8waen+UERc8ky5
	Toj1k3xefOpq2s+VqGuQq9Y0/sqzi0B3tyHpwYzz0/fltUqJ43Wi5FTr9pHsmcfAVN5gFOhEkXn
	LLDJh6NDHKPi/PM+1ZmmHv5X5MD3yVjFPFLKy1zNfYycgWZt+OO/O7pQehXYt3DTQkNkuXlW8ri
	udWiFUEjKIz/AwKRnjr8/trF/yAjIBgKGMkT91xGcBVcm3qHcmzgUEq4yTAAU+Wk4TUma8OCfAQ
	IQUkmdBV0hg1z5ranT4ABmy9PbN1nxAxEVyaYo2uumUOkCnXQ4jLzHKSsJEaBRpsN/E1uNUxwH8
	amVTgGpEkNBRUfg91RP5RtRENenjihHGnf6dzWJdrPRioiNcDyOTtX5ROJJoYjiG5xin7EYqOSm
	Q1iTjp/nvJq1tXjlkYVb+o7KYBm8I+kU2EbaOVAFHdxasymiA17E8I5xC5wpS+qo9F9xMxgFx+i
	7RSpw98kcAjcdbl
X-Received: by 2002:a05:6000:200d:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-46032b6b100mr33159846f8f.5.1781102117975;
        Wed, 10 Jun 2026 07:35:17 -0700 (PDT)
Received: from [192.168.1.131] (59.85-85-174.dynamic.clientes.euskaltel.es. [85.85.174.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3446aesm79481632f8f.24.2026.06.10.07.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 07:35:17 -0700 (PDT)
Message-ID: <0a23b741-0f5e-468d-a32a-0f730cb722de@gmail.com>
Date: Wed, 10 Jun 2026 16:35:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7996: remove code guarded by nonexistent
 config option
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rex Lu <rex.lu@mediatek.com>
References: <20260610041050.206950-1-enelsonmoore@gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20260610041050.206950-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37631-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:angelogioacchino.delregno@collabora.com,m:rex.lu@mediatek.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[matthiasbgg@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthiasbgg@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4FB566A6B4



On 10/06/2026 06:10, Ethan Nelson-Moore wrote:
> A small piece of code in mt7996.h depends on CONFIG_MTK_DEBUG, which
> has never been defined in the kernel. Remove this dead code.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> index bdcf72457954..39c525a40412 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> @@ -921,10 +921,6 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
>   			 bool hif2, int *irq);
>   u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id);
>   
> -#ifdef CONFIG_MTK_DEBUG
> -int mt7996_mtk_init_debugfs(struct mt7996_phy *phy, struct dentry *dir);
> -#endif
> -
>   int mt7996_dma_rro_init(struct mt7996_dev *dev);
>   void mt7996_dma_rro_start(struct mt7996_dev *dev);
>   


