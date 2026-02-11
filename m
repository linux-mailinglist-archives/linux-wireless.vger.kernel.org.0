Return-Path: <linux-wireless+bounces-31720-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPf0Ego7jGlZjgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31720-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:17:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E137B12226A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 09:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61543301DD52
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80C34FF71;
	Wed, 11 Feb 2026 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nild7jHh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487A33161BE;
	Wed, 11 Feb 2026 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797823; cv=none; b=VxQZyTxRQGIyyx63YoKVfjLXxTY3Mc0ZOiemR+egI1+QZZq03j0wB269ng4hT7LV7Q9b+ipXYAx+9xfh1oGgvRVmM5VzS4sKStxGAIvKALhD7II0IvEgtD6rdZLyYeTJMJXbnjuOYhNthLopXZRt7PNkX7TRicgqSlHUGlNHfh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797823; c=relaxed/simple;
	bh=afjftvONY4SHyXp32bFJSBcIQLGPQAANRVNr6hka5tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4dk2os9yqyUeGrhncRSVuUGEB+sjOTIhTLK6FFq5owMuDRghFX83wMtSwDMvwsc7DLFItIUc8wyfN4ik1+Xi4NQR4h9KxRBayIoftA+kRNcrGw5RwjHvWmAYXrDL6o+Fq6xgrQRZvwrj5Y7Nemwlbm+LA5mXUDO2HPyx/INsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nild7jHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2B0C4CEF7;
	Wed, 11 Feb 2026 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770797822;
	bh=afjftvONY4SHyXp32bFJSBcIQLGPQAANRVNr6hka5tQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nild7jHh8fBpqHmnSqjKv56L6q5467XoyM1PcKrp2MhIt+GDx+bnKFmjGKSTdst20
	 UvsXxyjr8rgR1BOp4n/hqv3HxN31U0ox+8ZyCIPSKczzEpYXbtZdlqMSDox17czNTW
	 VzAQQ/QtzF+0RuoGR+zHPcopnrEFR3AB69DQdsT5YDsFf6QoVlt44UBHKYatb3OK7J
	 uyoy4D1VQkTv4RdYLtVRaLBPQ05hBTBv3ngBAVZVGyl8+rKymDYTmPg8A8EU4hyKCG
	 bfa8y/Gi/fkvaGTi4ILH7BDweIk7iVM8StMKwhmvnwNU62o+izycvKeenxI3Fd+e5o
	 EOmhv9BFJ407w==
Message-ID: <b00c8c18-930b-4cb9-975d-b15118bfc854@kernel.org>
Date: Wed, 11 Feb 2026 09:16:59 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
To: Ryder Lee <Ryder.Lee@mediatek.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
 <20260211-miniature-chital-of-plenty-1a71df@quoll>
 <bd4da0a8522db2991ec0844233efe068323c2578.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <bd4da0a8522db2991ec0844233efe068323c2578.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31720-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: E137B12226A
X-Rspamd-Action: no action

On 11/02/2026 09:13, Ryder Lee wrote:
> On Wed, 2026-02-11 at 07:31 +0100, Krzysztof Kozlowski wrote:
>> On Tue, Feb 10, 2026 at 10:08:56AM -0800, Ryder Lee wrote:
>>> Clarify the format of path backoff limit properties in mt76
>>> binding.
>>> Add explicit documentation for connac2 (mt7915, mt7981, mt7986) and
>>> connac3 (mt7990, mt7992, mt7996...) devices, including the
>>> difference
>>> in beamforming and non-beamforming entries.
>>
>> I do not see any reformatting happening.
>>
> Maybe I should use "rephrase" here.
> 
>>>
>>> Also reformat the description to make is more precise.
>>>
>>> Signed-off-by: Allen Ye <allen.ye@mediatek.com>
>>> Co-developed-by: Allen Ye <allen.ye@mediatek.com>
>>
>> Incorrect SoB chain. Read submitting patches.
>>
> 
> Will fix.
> 
>>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>>> ---
>>>  .../bindings/net/wireless/mediatek,mt76.yaml  | 20
>>> +++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
>>> b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
>>> index ae6b97cdc..4156e1c97 100644
>>> ---
>>> a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
>>> +++
>>> b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
>>> @@ -252,6 +252,16 @@ properties:
>>>                        followed by 10 power limit values. The order
>>> of the
>>>                        channel resource unit settings is RU26,
>>> RU52, RU106,
>>>                        RU242/SU20, RU484/SU40, RU996/SU80 and
>>> RU2x996/SU160.
>>> +                      - For connac2
>>
>> There is no such term as connac2 in this binding at all.
>>
>> What is the point of adding new terms?
> 
> I didn’t think it was needed at first, but other reviewers suggested
> adding it.


Adding secret terms in the binding is not helping.

> 
> The commit message talks about mt7915, mt7990, mt7992, and mt7996,
> which are all PCIe WiFi devices, so their names aren’t included in the
> platform binding. Only WiFi integrated SoCs like mt7981 and mt7986 are
> listed.
> 
> These descriptions are meant to explain how a platform configures TX
> power for the connected WiFi devices, whether it’s a PCIe NIC (like
> Connac3 devices I listed) or an integrated SoC itself (like
> mt7981/mt7986).
> 
> What do you suggest? I’m actually okay with keeping everything as is.

I have no clue what you want to achieve.
> 
> You can also look at the v2 discussion.
> [v2] wifi: mt76: fix backoff fields and max_power calculation
> https://patchwork.kernel.org/project/linux-mediatek/patch/54627282cfb8e5a89fe753da66552c0a084f6387.1769557863.git.ryder.lee@mediatek.com/

That's driver code.

> 
>>
>>> +                        - Beamforming entries for BW20~BW160 and
>>> OFDM do not
>>> +                          include 1T1ss.
>>> +                        - When 1T1ss is not used, it should be
>>> filled with 0.
>>> +                      - For connac3
>>> +                        - Beamforming entries for BW20~BW160 and
>>> RU include
>>> +                          1T1ss, but OFDM does not include 1T1ss.
>>> +                        - 1T1ss is taken into account, so no need
>>> to fill with 0.
>>> +                      Non-beamforming and RU entries for both
>>> connac2 and
>>> +                      connac3 include 1T1ss.
>>
>> Why this cannot be a schema?
>>
>>
> Well, actually, it's already a schema. This is just an expanded

Where exactly?

But if it is, then this patch is redundant. Don't repeat constraints in
free form text.


Best regards,
Krzysztof

