Return-Path: <linux-wireless+bounces-37854-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XW8QMoZfMmq2zAUAu9opvQ
	(envelope-from <linux-wireless+bounces-37854-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 10:49:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6469D697A91
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 10:49:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XodH8UcM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37854-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37854-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 745323053C0E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AA23CFF69;
	Wed, 17 Jun 2026 08:46:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B43C555C
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 08:45:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685964; cv=none; b=VWobA1WI/YdCE7auZUBE5gSaVM3SYtPjcaBsFZBYHSCJlURyHaegZgn0iTYAnlV2OCLzKbKO0YyvezRXRN/rpjQsYzrYujtP/6hddHhOaBER/U/X2gTMveYVgKxs1Z/rTnUEnro7MESel3StTVMZZytvbS2paYXgbo0IlFO8YrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685964; c=relaxed/simple;
	bh=RLGGn8B+kjnGM7xYwjjZFXDkaSeHZsA2fOBfr4l498s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZMLMnBqmOJ6/cDKrXU5cBVLPc04EQjEbHAmTAZqK7o+QqV/EbNSie8smTzdlnQj1jNQN9BziZYZgGKTytDXiVZ47+b51J4rmV8433pbau6biUJCePCSzoPbLWrQ8dCu1v5rFfv8hKKEmvYiiArPHXD8a85w9ybBTfT4YLSdSHIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XodH8UcM; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-462342ac290so793729f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781685952; x=1782290752; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF9kaY0ySVP8TclElgAl4XtwTiGQvc9KgAyLLUGd7Qo=;
        b=XodH8UcMbT1J7zWqKB4UNq/zEtEiHUipzuD9mV/6wHRNnsDEXIcePw3JfNonX7/xWu
         Ke5Wk5EkcPT8mYWK8i0CQ7rUPjGh24mo2AY4XOXWHz8IEdBYLg0KnVJGFhxGe76e0lXX
         aa+cX7UMRlVtqut4TeENL+WSQ3/QD6JXZgazhTHwLjzsh/kGpvKhGsu/xpJW4RG09Gnz
         n5q5YoMMKTsAKaTscuHNgPx1B4qrze+IJdyh0/8w/W21ZJcqo1nl8vDLTdQ4DJQPOlAS
         MoW5sv48m8ncw5cU3Ce+fOmcybc1poLZg8cpzR/siCjyibGoF75YuXNl55a7AEMk0SfL
         vDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781685952; x=1782290752;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YF9kaY0ySVP8TclElgAl4XtwTiGQvc9KgAyLLUGd7Qo=;
        b=M6oNXf0DQ8Rg8b8Rh5uLCvAMmCxsVRAXO2LsQCgnle38hJCxphLGW7hzVbkFvvNMIV
         BLWcO8SpZV7tNsrR6fDj+Alp/DkvnOvVwIyTpJu3udX4h2LTC7LtjpHEx4KYGOnuLfKJ
         DcbT/4NYk7iGBCrSXvhbnfNYvVh8gYqyYzcua+2AJqW8zPs6cdL5M8nuDgOCZlcCbvLY
         4ZChXutd+Ksxrc79JO0japJwlDmqS/jCf62RQo+2u0u8ax1KiSJ4Rd9YlT4zyjnqMXYL
         BG8ctLTnt+c2eM8pXk97Vng7CPZnQVmNuX+K6C10Y6adgx8gFXkg/QdRa5FUsapk3doK
         WC6Q==
X-Gm-Message-State: AOJu0YyxzRAn/X7KChAP8i6g2F8kljsdWUH4svojIB0sXRrC0vsmgcGk
	asUj9sFlqbmUQDD2KzixAFw1PWUwZF9tC3BvlsQpBzxAN4K35r3KgxlotD+Iyg==
X-Gm-Gg: AfdE7cmHr5nRoUohuy/PM/sBCP8e6XVqBbrHN4Oq0PsG2YEXwFJ8Gdd2eLgthJ9xnuX
	ETXBH6i39mHeJJqkG3kmOPi4oshHzdZHQH0o8uL9643Pukyg52cHFMrZLUVY345kd6YSfLyaD0Y
	60PWuF2+knd8qM+3PhgGIu+UbfTMRsxaRayKGKbKBcFrF+K9QKBTjHlIJgc4k+LdwPlzMAADA5r
	UMHdGuggtjcLj1iyQYZt4TsJWDpBEtePuQ1YKXI5m268WBm/FLFGv53bT5v0QCeMWCEGC/xaHi6
	qJnSFmjrZvfAayRkQZq4egPoTJnSikg6YqL54FqJlqeEB/KZnY7U3Jq7w7aOvkxixfkCcOWTzNi
	P2HbfVn76+X6fmUE3ZUhQB3vIJckzkqoHeZ5jdxXlEUnMcOAmkGCwg3ptJKGxVcrnSbtIQNh1I0
	h2ISIxEdN4vl2cFfuUbZYs79gYKf3AwIc=
X-Received: by 2002:a5d:6843:0:b0:462:943:7ad8 with SMTP id ffacd0b85a97d-462412c7546mr3395654f8f.31.1781685951556;
        Wed, 17 Jun 2026 01:45:51 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b3ed0d2sm11458730f8f.22.2026.06.17.01.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 01:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 10:45:50 +0200
Message-Id: <DJB6YIA9WQGU.1Q3ODO8HFN4BF@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: avoid setting 320MHZ support
 on non 6GHz band
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Rameshkumar Sundaram" <rameshkumar.sundaram@oss.qualcomm.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611084422.1511513-1-nico.escande@gmail.com>
 <3fb00a3b-2092-43d2-a8f8-9f934505dcee@oss.qualcomm.com>
In-Reply-To: <3fb00a3b-2092-43d2-a8f8-9f934505dcee@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37854-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:rameshkumar.sundaram@oss.qualcomm.com,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6469D697A91

On Wed Jun 17, 2026 at 7:03 AM CEST, Rameshkumar Sundaram wrote:
> On 6/11/2026 2:14 PM, Nicolas Escande wrote:
>> On a split phy qcn9274 (2.4GHz + 5GHz low), "iw phy" reports 320MHz
>> realated features on the 5GHz band while it should not:
>
>
> s/realated/related

sure

>
>>=20
>>      Wiphy phy1
>>      [...]
>>          Band 2:
>>      [...]
>>              EHT Iftypes: managed
>>      [...]
>>                  EHT PHY Capabilities: (0xe2ffdbe018778000):
>>                      320MHz in 6GHz Supported
>>      [...]
>>                      Beamformee SS (320MHz): 7
>>      [...]
>>                      Number Of Sounding Dimensions (320MHz): 3
>>      [...]
>>                  EHT MCS/NSS: (0x22222222222222222200000000):
>>=20
>> This is also reflected in the beacons sent by a mesh interface started o=
n
>> that band. They erroneously advertise 320MHZ support too.
>
> s/320MHZ/320MHz

sure

>
>>=20
>> This should not happen as the spec at section 9.4.2.323.3 says we should
>
> Reword the spec citation to: IEEE Std 802.11-2024, subclause 9.4.2.323.3 =
...
>
>
>> not set the 320MHz related fields when not operating on a 6GHz band.
>> For example it says about Bit 0 "Support For 320 MHz In 6 GHz"
>>=20
>>    "Reserved if the EHT Capabilities element is indicating capabilities =
for
>>     the 2.4 GHz or 5 GHz bands."
>>=20
>> Fix this by clearing the related bits when converting from WMI eht phy
>> capabilities to mac80211 phy capabilities, for bands other than 6GHz.
>>=20
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
>>=20
>
> The commit log mentions wrong `iw phy` output and wrong mesh beacon
> advertisement, so this appears user visible. If that is the intended bug=
=20
> being fixed, please add a Fixes tag.
>

Well I did not put a fixes tag as this does not create any real problems
per say. It does not impede any sta to connect in any way. Only
people explicitely parsing the beacons IE see an unexpected value.

So unless you guys really insist, I'd just skip it. Otherwise the 2
candidates are are:
  - 1476014fadb6 ("wifi: ath12k: WMI support to process EHT capabilities")
    It added the EHT caps parsing but lacked any logic to handle 6G so
    that means backporting would imply a different patch than this one
  - d4e244c85e45 ("wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band
    in EHT PHY capability for WCN7850"). This one added 6GHz support and
    is the one I'm fixing but for a different chipset in mind than mine.

>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>> ---
>> Changes from v1:
>>    - rebased on ath-next
>>    - clear all 6GHz / 320MHz related phy capabilities fields from the fi=
rmware
>> ---
>>   drivers/net/wireless/ath/ath12k/wmi.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireles=
s/ath/ath12k/wmi.c
>> index 84a31b953db8..a8a4654c4f34 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>> @@ -5154,6 +5154,7 @@ static void ath12k_wmi_eht_caps_parse(struct ath12=
k_pdev *pdev, u32 band,
>>   				       __le32 cap_info_internal)
>>   {
>>   	struct ath12k_band_cap *cap_band =3D &pdev->cap.band[band];
>> +	u8 *phy_cap =3D (u8 *)&cap_band->eht_cap_phy_info[0];
>>   	u32 support_320mhz;
>>   	u8 i;
>>  =20
>> @@ -5167,8 +5168,22 @@ static void ath12k_wmi_eht_caps_parse(struct ath1=
2k_pdev *pdev, u32 band,
>>   	for (i =3D 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
>>   		cap_band->eht_cap_phy_info[i] =3D le32_to_cpu(cap_phy_info[i]);
>>  =20
>> -	if (band =3D=3D NL80211_BAND_6GHZ)
>> +	if (band =3D=3D NL80211_BAND_6GHZ) {=09
>>   		cap_band->eht_cap_phy_info[0] |=3D support_320mhz;
>> +	} else {
>> +		/*
>> +		 * It seems the firmware can report capabilities specific to
>> +		 * 6GHz also for 5GHz, so lets explicitely clear them out.
>
> The code comment should be less tentative, how about:
>
>       /*
>        * Firmware may report 6 GHz/320 MHz specific capabilities for
>        * non-6 GHz bands, so explicitly clear them.
>        */
>

sure

>
>> +		 */
>> +		phy_cap[0] &=3D ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
>> +		phy_cap[1] &=3D ~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK;
>> +		phy_cap[2] &=3D ~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
>> +		phy_cap[3] &=3D ~IEEE80211_EHT_PHY_CAP3_SOUNDING_DIM_320MHZ_MASK;
>> +		phy_cap[6] &=3D ~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
>> +		phy_cap[6] &=3D ~IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP;
>> +		phy_cap[7] &=3D ~IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ;
>> +		phy_cap[7] &=3D ~IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;	;
>> +	}
>>  =20
>>   	cap_band->eht_mcs_20_only =3D le32_to_cpu(supp_mcs[0]);
>>   	cap_band->eht_mcs_80 =3D le32_to_cpu(supp_mcs[1]);
>
>
> checkpatch warnings:
> ERROR: trailing whitespace
> #61: FILE: drivers/net/wireless/ath/ath12k/wmi.c:5171:
> +^Iif (band =3D=3D NL80211_BAND_6GHZ) {^I$
>
> WARNING: 'explicitely' may be misspelled - perhaps 'explicitly'?
> #66: FILE: drivers/net/wireless/ath/ath12k/wmi.c:5176:
> +                * 6GHz also for 5GHz, so lets explicitely clear them out=
.
>                                                 ^^^^^^^^^^^
>
> WARNING: space prohibited before semicolon
> #75: FILE: drivers/net/wireless/ath/ath12k/wmi.c:5185:
> +               phy_cap[7] &=3D=20
> ~IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;     ;
>
> WARNING: Statements terminations use 1 semicolon
> #75: FILE: drivers/net/wireless/ath/ath12k/wmi.c:5185:
> +               phy_cap[7] &=3D=20
> ~IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;     ;

And all that will be fixed obviously

Thanks for the review

