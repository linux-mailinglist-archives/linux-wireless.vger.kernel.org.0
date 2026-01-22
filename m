Return-Path: <linux-wireless+bounces-31088-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA2eLpJfcmnbjAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31088-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 18:34:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7F26B657
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 18:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 843E93190D08
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DA43D9046;
	Thu, 22 Jan 2026 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9m/y1FD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F40D3D809F
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099890; cv=none; b=KVhPxLzUCK8oOgFAg3UAsonPvhZZnMp/tcJRKQ956ZLtgWAzhMR327O2P+h9DrZFAqhxNgF4P5blgi6A9rtESm6/9i+lbUzrP4fvOyqbphgNcMXvBoaKM3/P9+crH+pWismfQwW1BtkVVMi676ALZMlvfI/REc+9ZUFIfs3FKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099890; c=relaxed/simple;
	bh=pD40w3uXDm31ZrBcaS+MzSP9fBubsBRAx92CjKPqI7s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=dZrmQZ33e698xbuQurNf1wsHCp8gR14PCunw+9Pm3V8+lYuavF0ve9LHEJ1VNbwzzqXIuQDCMsYFiBXEQigmPRwPmv4AuqM9v5O3LajgqpzkSRFZIrg4YoJgeoq5+ypfuzILVHucK8AKn6dfXqgVynhDWY/PqefFBQcvtIXlZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9m/y1FD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so7638915e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769099883; x=1769704683; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiWgGuZbjV+jskMErToMAUvRNtz2q6cfYUKs3Xr6CoQ=;
        b=h9m/y1FDFjcbbqH3sWFqxM02ZXZBIBcu2bfOE2dE4YAryErx97BGML6u02RyvlQ/VP
         1894g/pYfn+iIx5Xzgk1WNTd5PucmmR+Ww9ZBgfRazfrjwKfZ07XcZD8ccIt1iUjTs71
         TubmG7Y6cXjlB/bEjzmXpJmm9p40WXHotaiFsVObXUixqKY8CxjRkuCK0XcRHr+nWpft
         mx5b67LLAFTivzV7LRkCITKy9M1wULW/Y3lN6lr+Hksr4qs8p3JU6smByU2j/Rmy8L/n
         rG8FsunDoRSmIEXinlW02zs/we9BzqNuMpKL8byghluP8IsFksTaNxP4vo6GAoNc7rT2
         dbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099883; x=1769704683;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JiWgGuZbjV+jskMErToMAUvRNtz2q6cfYUKs3Xr6CoQ=;
        b=llqEPdpTwfoOmIlmaqNQa5ejhhL99zJxr4k46zf/JjGBDsTy9lUhdKGy2y1w12BvIA
         MbLL0nPS+0yGhbeXCWGSAAFUkUdCkTNdhm4gDbYFhV5U4PIFKEyf9VQ+3X6k8B48EiLy
         RjwRkuCndrxfPlujE9xlHcn4CxwG93fDYjHwmjN7IbampJIaxb8QYt2AtvlqH7IvP49X
         KzqnzpHnoV0caGWMb0w9xy7pPB0siYrHFInuGrvnhm20+k/SGCdsjIpvwCG7d6Jm3NX3
         AyC2zOsi7CFMbXgj/oEAVqX6e8Zfbo368xTlg5eskC6L5ArcxOrg/Hli9vXxGnqG6NHY
         7FjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8iap36xExXYyP9Yr4eXFBN51Y9A9sxfhKQ4R1YRpO8BWzdjNF66YO0IxYXycGJR2iW3sIN0v83orRipTXHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYhIH9gd1KFUy2AICnz18vRFvkYyrfag9NRtnnw76rebSltD3t
	Nc6OElBbETC5nKZuaml63JbXEgoAcvZ8i8q/TKNFNXZQJqdzTnl8BQYb
X-Gm-Gg: AZuq6aIx8WqyIZ+OCf5zdnjeJBrL9nEnLA7jK7KEf7ovHO1VGFgiObNxGtnlMYEtTLn
	pca96EnQfES0qwknjEUIBR/VOE1BDUJF3qgTovJOJZnaVCCYRNXrEzNPrJCFrXz1F23KWQgXePL
	JYYsAX4ghlZe4kbc8cVHkPFtEe8VeurUeSJTpQiIhGb3uzJJnhb5se4ClV3YOJlB9o1FCFxY3uv
	PVu4Ctqp6Dd9K/8IboldeD+xgc10s88/+PaRdHzCZsNhgNgwELEqq4BCKaKbOOd02EzUFM9IFFa
	fpLNelDNAIxgk/cUOPT410/5ufCcCc028Lm4zjd5GUmjcFKnKdbekeOthmrVvk+Egig+gvRnM62
	qOMsr9KOstsbeP8/BzGpdwH1biniaclpknte9OunHeyHt0MZIdE08eqb3YcMcw/vQpChTaFUDqH
	cvMn/LZbO4aT8DeHZtmoEs2nLW1cvKYA==
X-Received: by 2002:a05:600c:c16b:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-4804c9b2113mr4306545e9.22.1769099882892;
        Thu, 22 Jan 2026 08:38:02 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470403d3sm81620715e9.5.2026.01.22.08.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 08:38:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 17:38:01 +0100
Message-Id: <DFV9KI49QEP2.2TMVJXR5EK0B7@gmail.com>
Subject: Re: [PATCH] wifi: mac80211: do not set 320MHz EHT capabilities on
 non 6GHz band
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>, "Nicolas Escande"
 <nico.escande@gmail.com>, <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260122145620.861355-1-nico.escande@gmail.com>
 <829488acfdbf7ecfe6418bfb2c5669dae18392ed.camel@sipsolutions.net>
In-Reply-To: <829488acfdbf7ecfe6418bfb2c5669dae18392ed.camel@sipsolutions.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31088-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[sipsolutions.net,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B7F26B657
X-Rspamd-Action: no action

On Thu Jan 22, 2026 at 5:05 PM CET, Johannes Berg wrote:
> On Thu, 2026-01-22 at 15:56 +0100, Nicolas Escande wrote:
>> The spec (at least 802.11-be draft7) at section 9.4.2.323.3 says we shou=
ld
>> not set the 320MHz related fields when not operating on a 6GHz band. It'=
s
>> quite explicit for most of them. For example:
>>=20
>> Bit 0 "Support For 320 MHz In 6 GHz" says "Reserved if the EHT
>>       Capabilities element is indicating capabilities for the 2.4 GHz or
>>       5 GHz bands."
>>=20
>> Bit 22-24 "Number Of Sounding Dimensions (=3D 320 MHz)" says "Reserved i=
f
>>           the SU Beamformer subfield is 0 or the Support For 320 MHz In
>>           6 GHz subfield in EHT Capabilities Information field does not
>>           indicate support for a bandwidth of 320 MHz."
>>=20
>> Bit 54 "Support Of EHT-MCS 15 In MRU" says about bit 3 "If 320 MHz is no=
t
>>         supported, then B3 is set to 0."
>>=20
>> For bit 13-15 "Beamformee SS (=3D 320 MHz)" it's not explicit, but it ma=
kes
>> little sense to special case the handling of this one.
>
> Sure, but ...
>
>> Fixes: 6239da18d2f9 ("wifi: mac80211: adjust EHT capa when lowering band=
width")
>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>> ---
>>  net/mac80211/util.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
>> index 0c46009a3d63..996983f6815b 100644
>> --- a/net/mac80211/util.c
>> +++ b/net/mac80211/util.c
>> @@ -4426,7 +4426,8 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
>>  			~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_160MHZ;
>>  	}
>> =20
>> -	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_320) {
>> +	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_320 ||
>> +	    sband->band !=3D NL80211_BAND_6GHZ) {
>>  		fixed.phy_cap_info[0] &=3D
>>  			~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
>>  		fixed.phy_cap_info[1] &=3D
>
> How does this make any sense? The driver should just not advertise the
> bit on its 2.4 and 5 GHz sbands?
>
> johannes

Well from a strictly spec point of view yes: "Reserved if the EHT
Capabilities element is indicating capabilities for the 2.4 GHz or 5 GHz ba=
nds."
doesn't leave much room for interpretation.

But it kinda of seems counter productive for this name "Support For 320 MHz=
 In 6
GHz" as it seems to have be explicitely chosen to inform people that a colo=
cated
AP exists on the 6Ghz band.

For context I initially encountered this problem on an ath12k AP which has =
a
single phy with both 5GHz & 6GHz bands available but only had a 5GHz AP sta=
rted.
On such a platform, we set this '320MHz in 6G' operation on the 5GHz no mat=
ter
what beacause of the phy's capabilities.

So not sure how to adress this problem, it seems weird that the driver shou=
ld
alter the EHT elem by himself to be honest.

Nico,

