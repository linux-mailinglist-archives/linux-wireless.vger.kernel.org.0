Return-Path: <linux-wireless+bounces-33978-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMRAJ1o/xWkU8wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33978-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 15:14:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C7336A5A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 15:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C6DE309E300
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5E53168E1;
	Thu, 26 Mar 2026 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="ZLSd5s8B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4272F12B3;
	Thu, 26 Mar 2026 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533811; cv=none; b=l1ZRTQLhiVlVaz+LoOe43lu3AenZYpC36SqTOdw+pScg6NKzG8nRMACM8/Vp943Vji6pcrHHQeFupYawwaNfd5704rDj420aAZv4+khaM8q9gDOEzg4ZHk7iNM+IdbnHNUfjsetikJnuMNUmdhr8K06d8S93e/aoQhRP0cxBlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533811; c=relaxed/simple;
	bh=dkjZs7WKD/WSTNflqzehy3i+/gd5KrtTWk6FaK4d2QU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tp24f/gkQSuRp1lDcxZatAAkKVBJtPzFUh7v3L5TS5g/BHNCzjWrShahZafcWn0WNmRGoZqWz+8kZHtKuuhD5df8HnHZCasLniXqFa0+Gj2ZutXTZa/6FLvCCY5GvLtVUM2ZsOECS+1b8gQReHU77rMfAwreOcG3d5eNw9y1Hk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=ZLSd5s8B; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Message-ID: <4a04d4bd-969e-4804-b938-cda8c0a626b6@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774533805;
	bh=dkjZs7WKD/WSTNflqzehy3i+/gd5KrtTWk6FaK4d2QU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=ZLSd5s8BdQiW9ocJjlKnLqH32gFxNFAOO5OIbBvOxlv1Zk3WFgq+EpGIoDQ21dKd1
	 sPWfR7l2Eph+/s0n9YTDOJvIxR2QnkybNVD0aRjrD7Jhj+bMXAeg6M8Xb8igIPeq9C
	 lrMZsbUdJOmdU9lpoRZ674Lx9vmrUslRFJ45td1I=
Date: Thu, 26 Mar 2026 15:03:24 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v5 8/9] dt-bindings: net: wireless: brcm: Add compatible
 for bcm43752
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
References: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr>
 <20260326-add-emmc-t7-vim4-v5-8-d3f182b48e9d@aliel.fr>
 <9bc23f1e-1cf3-43d1-935a-c4738d576c29@linaro.org>
Content-Language: en-US
In-Reply-To: <9bc23f1e-1cf3-43d1-935a-c4738d576c29@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[aliel.fr:s=courrier-s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[aliel.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33978-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[aliel.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,microchip.com,baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,aliel.fr:dkim,aliel.fr:email,aliel.fr:mid,microchip.com:email]
X-Rspamd-Queue-Id: 0B2C7336A5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 1:55 PM, Neil Armstrong wrote:
> On 3/26/26 10:59, Ronald Claveau wrote:
>> Add bcm43752 compatible with its bcm4329 compatible fallback.
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
>>   Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-
>> fmac.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/
>> brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/
>> wireless/brcm,bcm4329-fmac.yaml
>> index 3be7576787644..81fd3e37452a6 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-
>> fmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-
>> fmac.yaml
>> @@ -42,6 +42,7 @@ properties:
>>                 - brcm,bcm4356-fmac
>>                 - brcm,bcm4359-fmac
>>                 - brcm,bcm4366-fmac
>> +              - brcm,bcm43752-fmac
>>                 - cypress,cyw4373-fmac
>>                 - cypress,cyw43012-fmac
>>                 - infineon,cyw43439-fmac
>>
> 
> I'll apply all the other DT patches, please send this one alone with the
> [PATCH net-next] prefix so it gets picked by the wireless/net people.
> 
> Thanks,
> Neil

I'm on it, thank you.

-- 
Best regards,
Ronald

