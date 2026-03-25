Return-Path: <linux-wireless+bounces-33824-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJX0AF2hw2lBsQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33824-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:48:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC09832198B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 09:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 855FD30F3231
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD0A39A053;
	Wed, 25 Mar 2026 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="QoTeywTx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from courrier.aliel.fr (pouet.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A543A398903;
	Wed, 25 Mar 2026 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428341; cv=none; b=erxIhpQhw7W9iU6RM5WF9b0IVXZs93QoAIKGq1bRzznqXvgDWM5ypYPnsE+NFU83S4UUKdzDanCernL3PT0iXAB6UBAvgxM/8j+VfddjYxsUJ65W1elGAyo9tCa0DbAhzOzNzgtBiHRVAPbse3u+aQsiUSlw9XRJ7kveUL6iA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428341; c=relaxed/simple;
	bh=EbpGoxqQXt+Kk2/8U5yoMgWyFVaTQNOoOx8b2j6G0us=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jgCq6uIG1+rdeH/K3aY5Tb5FpSOCPKPnP5zJzGZipqkDJwwkwxJFtlA+CZ6Lj39U6cQ4HdCvdoGjE83ZIDn3P1IZHs9lDjivr5zyMHeonO7LEEswsL9B0OzMYl9HM/JZheBT5lXXaQK7TITqyRQohOt5dyrxcoIzGbeb8n7qOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=QoTeywTx; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Message-ID: <2c63a66c-8562-48d5-ac25-50359de3ad8b@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1774428337;
	bh=EbpGoxqQXt+Kk2/8U5yoMgWyFVaTQNOoOx8b2j6G0us=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=QoTeywTx0cyBayxdpZrL++1gsw2TV/mGYRha6OoPqh2MWI4qe86v7yv0IaGWjfsgD
	 vUHRmtZyEyZ+HLcQw8qqsDlx1zxXOXLy8hQWTFHQg6WzvuXNK4giOmZKw/+zavaxT8
	 q9S9AX8y/ZNWIRI0QT0BWC0Pfe1Wn7//P/Qpnh3Y=
Date: Wed, 25 Mar 2026 09:45:36 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v3 2/9] dt-bindings: mmc: amlogic: Add compatible for T7
 mmc
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
References: <20260323-add-emmc-t7-vim4-v3-0-5159d90a984c@aliel.fr>
 <20260323-add-emmc-t7-vim4-v3-2-5159d90a984c@aliel.fr>
 <c01c4e7e-1c0c-4bbf-b126-831160c8e32b@amlogic.com>
Content-Language: en-US
In-Reply-To: <c01c4e7e-1c0c-4bbf-b126-831160c8e32b@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[aliel.fr:s=courrier-s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33824-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[aliel.fr];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,linaro.org,baylibre.com,googlemail.com,kernel.org,sipsolutions.net,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-kernel-dev@aliel.fr,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[aliel.fr:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AC09832198B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 3:38 AM, Xianwei Zhao wrote:
> Hi Ronald,
> 
> On 2026/3/23 17:55, Ronald Claveau wrote:
>> Add amlogic,t7-mmc compatible string, falling back to amlogic,meson-
>> axg-mmc
>> as the T7 MMC controller is compatible with the AXG implementation.
>>
>> Signed-off-by: Ronald Claveau<linux-kernel-dev@aliel.fr>
>> ---
>>   Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 5
>> ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>> b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>> index 57646575a13f8..40dccf9715781 100644
>> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
>> @@ -19,7 +19,10 @@ allOf:
>>   properties:
>>     compatible:
>>       oneOf:
>> -      - const: amlogic,meson-axg-mmc
>> +      - items:
>> +          - enum:
>> +              - amlogic,t7-mmc
>> +          - const: amlogic,meson-axg-mmc
> 
> It seems that break API here.
> One item should be added here instead of being replaced.
> 

Thanks Xianwei, ok I will change that in a new version.

>>         - items:
>>             - const: amlogic,meson-gx-mmc
>>             - const: amlogic,meson-gxbb-mmc
>>
>> -- 
>> 2.49.0


-- 
Best regards,
Ronald

