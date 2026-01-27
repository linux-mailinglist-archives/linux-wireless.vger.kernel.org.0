Return-Path: <linux-wireless+bounces-31239-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDzHKdbweGmGuAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31239-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 18:07:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE8982E6
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5E893009E26
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C654E362135;
	Tue, 27 Jan 2026 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="kNbfZXNO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB2230BD5
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533250; cv=none; b=UdDUsfTXgHtZ9t35EP7Far51ljWrCbHMsFcmXxMuJytiYECqb4i71QzmRE5rcqluseIu1KeaoIe7M/3RAIICiu09ce7DLNaevVKv1qu/aksjtEFY73Vle9veflOIzHPQ5JJEQAyP8zxArCTfZEuNXMsRtHk6yPoycgmGx814Bhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533250; c=relaxed/simple;
	bh=5p0vJKbbIOOYnRp/oLeN2PI6Xz4v0WPciD3N581SREc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/sAr1L5fKRPIKJnv7ilnIQq18xKEnFb+QeGLzeq6qcHTuJtVc7M+zgaX9OVo7hasBT4e+25O2Eb6vpJxpHnQ4g51D/i0UTKLvgPlxMQFzqvNXqI+pRMPi9jhWEkH47wEcYCnVgOCwaP79osVqAV2VavlYv3NiXwnivAIF4Iyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=kNbfZXNO; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XILyT17ZMMPYRrz9JqseQKbUaHFCP6aU1jH5zpBbKx0=; b=kNbfZXNORV0X2Dzd9yQVGrNgc6
	+Nu9pdfoCn2Hpp9VewMSXmFOJgt0IbFxrRYU/lKPo3t7P8fnMSpMgdsG8hBsHfLntkd73gf2k0hWS
	bpYsgYCnnIR8Uh9VEzPIEokWMMuK7Q+gCCAfj5SEPhjVDtvJAcXXOJRx3uw4ofmKnqdA=;
Received: from p54a43f8f.dip0.t-ipconnect.de ([84.164.63.143] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vkmQk-00BtUQ-0J;
	Tue, 27 Jan 2026 18:00:42 +0100
Message-ID: <8286aa0e-d8b8-4c32-af5b-6ddf163b6417@nbd.name>
Date: Tue, 27 Jan 2026 18:00:41 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: connac: fix txpower_cur not being updated
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Lucid Duck <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
References: <20260125222235.36565-1-lucid_duck@justthetip.ca>
 <4ddb4417-d623-44ae-878d-5ee5939f2826@nbd.name>
 <f677b9d5-235c-4ff4-be36-c71c43b6988a@gmail.com>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <f677b9d5-235c-4ff4-be36-c71c43b6988a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,justthetip.ca,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31239-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nbd.name:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CECE8982E6
X-Rspamd-Action: no action

On 27.01.26 17:17, Bitterblue Smith wrote:
> On 27/01/2026 14:21, Felix Fietkau wrote:
>> On 25.01.26 23:22, Lucid Duck wrote:
>>> The mt76_connac_mcu_set_rate_txpower() function sends TX power settings
>>> to the firmware but never updates phy->txpower_cur. This causes
>>> mt76_get_txpower() to return stale or incorrect values (typically
>>> showing 3 dBm regardless of actual transmit power) when userspace
>>> queries TX power via nl80211.
>>>
>>> This affects MT7921 and other connac-based devices. Users observe:
>>>    $ iw dev wlan0 info
>>>    ...
>>>    txpower 3.00 dBm
>>>
>>> The firmware receives and applies the correct power level, but the
>>> reported value is wrong because txpower_cur is never set.
>>>
>>> Fix by updating phy->txpower_cur after successfully configuring TX
>>> power, matching the behavior of other mt76 drivers like mt7915.
>>>
>>> Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
>>> ---
>>>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>>> index 045771228..7cd357419 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>>> @@ -2251,7 +2251,7 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
>>>     int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
>>>   {
>>> -    int err;
>>> +    int err, tx_power;
>>>         if (phy->cap.has_2ghz) {
>>>           err = mt76_connac_mcu_rate_txpower_band(phy,
>>> @@ -2272,6 +2272,12 @@ int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy)
>>>               return err;
>>>       }
>>>   +    /* Update txpower_cur for accurate reporting via nl80211 */
>>> +    tx_power = 2 * phy->hw->conf.power_level;
>>> +    if (!tx_power)
>>> +        tx_power = 127;
>>> +    phy->txpower_cur = tx_power;
>> 
>> phy->hw->conf.power_level is the user configured power level, not what the hardware is capable of transmitting.
>> 
>> To fix it properly, I think you should determine the maximum rate power used in the loop within mt76_connac_mcu_rate_txpower_band (updated with each call).
>> 
>> - Felix
>> 
> 
> What about these older patches?
> 
> https://patchwork.kernel.org/project/linux-wireless/list/?series=932665&submitter=&state=*&q=&archive=&delegate=

If I remember correctly, I found some issues in those patches and asked 
the Author about them and he mentioned that he only tested them on some 
old 5.15 vendor tree and didn't actually use anything recent.
So I dropped them from my tree again.

- Felix

