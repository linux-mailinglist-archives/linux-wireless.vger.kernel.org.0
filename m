Return-Path: <linux-wireless+bounces-31237-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFUfNSvleGlvtwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31237-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 17:17:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA3979A3
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 17:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE8173003831
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AFD31328C;
	Tue, 27 Jan 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsUzC4eb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA9315D3B
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530661; cv=none; b=n0ZiElZYcTwP9fzOshXyaiS6sXfUOkJG7PCvCxhYmr9E9HjI68Li5vugLYJaGsadZFuij7H95MFPdEoqFb0U/+pPynILQN3ab+3dzxAl9FcoYMBex1X8Py66wxa//3vxQTxUix3ZhLE1gdUzJ875PTavX8+1CipgKkMIeQ3DUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530661; c=relaxed/simple;
	bh=87PaDhLMvveyDf0BoXT59QnBgLb3gG08rex8jLNCNsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3GTwwl3rdJIC8LsAcjZyQ0+TpA6JqnFbEecFIOefPdHsK1QiLOBbREEdzkg8b1ZhPzk6j1FUtAdTHvLqkg6FU7Q2IjK8M4dOOuYf3i1at0kFGToP96OTUdG3G9R0mzA7hCNGSjcnPxj0AE9t+g82/WUYuTRJpSKDBbvP/LYzE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsUzC4eb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so45938355e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769530659; x=1770135459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwDnk5uOMV/UB49+4e7v5FBtsAbtq5voacJEhYYH4XI=;
        b=PsUzC4ebyJ187cvb7pXDX273tLJq+rpO8CjkkgxGuUzzCESeSWjkcFSqU54FC27KnB
         vJvZDWExqYozuEbKJd5hT0bqx8o//G1yjaQUD66kQfi8y65wcfFxzQrVSHYzCIhXszk/
         OUZCobU5uxeqxcdGg9XWucPGwO6JRoYSySBXBnb1ErOVPQa9LO0yh5T2MH+fBW0oDKuV
         75xQwJk5j1+H8gp1XCqOig6K9TIUZkggELinGz8oxXLCuvoU4d1w0HVCoVv3qIy4KB88
         yCMVMHQATThjRGeKeGBqDXJ6/VyUKRwG6+7i2OpBxR7gslEU2VJTypx38TTtXgzAVyN2
         oUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769530659; x=1770135459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwDnk5uOMV/UB49+4e7v5FBtsAbtq5voacJEhYYH4XI=;
        b=Zh/Wc/oNzT3jFEtNlHLl7y2UvG6BLOp9BG1r5gvaeC/Mshle3Tw60wm1ZZjcm23wgm
         gglIkffUJoPKlqY4Kz0hB0nMA9xZnv+LPGoDT7MlcWJRAxBcKcrirbBmx9zt6AbXdxZm
         dLx6zdabjtTDmKlgxZNnxFmcgiNjEKxzObSLSdv601LBrZcTwdDNpTzmvrNF4BpcBhZr
         DI5UcyyHyivjRGB/psma6eAawxLbLmRP3wdHdAn15GRRTaVDkwx41A3S3hP0LCM6KbEN
         MugMdGOx3Dndnt9+vPFn0NhDCFSjm/lfzAAt9Thb/rYwdlUnRbHVGrbUDNx8TF9is/RK
         PsRg==
X-Forwarded-Encrypted: i=1; AJvYcCWJmb269t1XprkwNdkPlxakMNn2B0j175VBFjMJ0uTwSo4l/0o449TobFfdwmoW46e2H0s9jX5zVf7K5dbWpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYFPYTirv/ehKKw+/SLCafoXsVDNN+igPUS6guDjenTcA1ZBE
	MwVkx2Lb+rLK5r/PteW7t6cYb83A6G4z1tQliduaoF+Ae9Sxbs8KGsNe
X-Gm-Gg: AZuq6aLRHkTwG7YvOOV4n5HKnfSF6CCb+ygtK4mUAPt+1pwvFLnxxsdB+enpJi+MmZJ
	2GLLab8EruF1s2w76smLhDDip6LGjt6jTCiGqBL9Pm9I00VeChZq5/BMQGb39FnlWf+kheHJWob
	luzVA9wA6kOiCBTXBeGpbyXICzzKtX2T1cqNwUW/feMacp5IwpeE6oVdiB74jZdLbod6s+g+mam
	li3uesUL4Eb6rQINzhIzFQEJ9n94JcLQhjcsoRfe0NLoWh7fAB1z8vDOQDEhcUkbbDfBjkJivWV
	AcUTUDRxS2AvRE42pOdx38r3BjJgI9moXEtrdRJ6jNv0F2ruo7yQpHdTSmeHzeJMhVrWUkDB5e5
	BUbsyqxkiOLDaFnmh7GsUjCK5aSmMojB6yV0gEk15pRi8WaHKFeGhEQxNzOVtC825Cojoemj46H
	iq8RgW5v7QnU5JfnkIZA==
X-Received: by 2002:a05:600c:3e16:b0:47e:e20e:bba3 with SMTP id 5b1f17b1804b1-48069c40595mr29890365e9.7.1769530658292;
        Tue, 27 Jan 2026 08:17:38 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd79c7sm2511665e9.2.2026.01.27.08.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 08:17:37 -0800 (PST)
Message-ID: <f677b9d5-235c-4ff4-be36-c71c43b6988a@gmail.com>
Date: Tue, 27 Jan 2026 18:17:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: connac: fix txpower_cur not being updated
To: Felix Fietkau <nbd@nbd.name>, Lucid Duck <lucid_duck@justthetip.ca>,
 linux-wireless@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
References: <20260125222235.36565-1-lucid_duck@justthetip.ca>
 <4ddb4417-d623-44ae-878d-5ee5939f2826@nbd.name>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <4ddb4417-d623-44ae-878d-5ee5939f2826@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31237-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,justthetip.ca:email]
X-Rspamd-Queue-Id: 7AAA3979A3
X-Rspamd-Action: no action

On 27/01/2026 14:21, Felix Fietkau wrote:
> On 25.01.26 23:22, Lucid Duck wrote:
>> The mt76_connac_mcu_set_rate_txpower() function sends TX power settings
>> to the firmware but never updates phy->txpower_cur. This causes
>> mt76_get_txpower() to return stale or incorrect values (typically
>> showing 3 dBm regardless of actual transmit power) when userspace
>> queries TX power via nl80211.
>>
>> This affects MT7921 and other connac-based devices. Users observe:
>>    $ iw dev wlan0 info
>>    ...
>>    txpower 3.00 dBm
>>
>> The firmware receives and applies the correct power level, but the
>> reported value is wrong because txpower_cur is never set.
>>
>> Fix by updating phy->txpower_cur after successfully configuring TX
>> power, matching the behavior of other mt76 drivers like mt7915.
>>
>> Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> index 045771228..7cd357419 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> @@ -2251,7 +2251,7 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
>>     int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
>>   {
>> -    int err;
>> +    int err, tx_power;
>>         if (phy->cap.has_2ghz) {
>>           err = mt76_connac_mcu_rate_txpower_band(phy,
>> @@ -2272,6 +2272,12 @@ int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
>>               return err;
>>       }
>>   +    /* Update txpower_cur for accurate reporting via nl80211 */
>> +    tx_power = 2 * phy->hw->conf.power_level;
>> +    if (!tx_power)
>> +        tx_power = 127;
>> +    phy->txpower_cur = tx_power;
> 
> phy->hw->conf.power_level is the user configured power level, not what the hardware is capable of transmitting.
> 
> To fix it properly, I think you should determine the maximum rate power used in the loop within mt76_connac_mcu_rate_txpower_band (updated with each call).
> 
> - Felix
> 

What about these older patches?

https://patchwork.kernel.org/project/linux-wireless/list/?series=932665&submitter=&state=*&q=&archive=&delegate=

