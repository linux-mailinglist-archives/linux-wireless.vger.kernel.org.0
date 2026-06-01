Return-Path: <linux-wireless+bounces-37280-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELnVEP+8HWo/dQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37280-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:10:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC81623112
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 713DC3064EC5
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F13DCD9A;
	Mon,  1 Jun 2026 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfCPvO2x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690932938D
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333733; cv=none; b=NqpJ2ZJfReRPG8zLU+O4ncfVyax9ommx5YZslneqlmmM/TpH0AwddeVkNFNfQGFFym/v1VryHrYmkU4FYDAxpgcIm+nWQXNU0U5mvI7ukZdW46eZENrh1Vund6XR/qYutl5svyGpvBljXUxkV4JOpvomTHPa2vnknyT1r0+vdr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333733; c=relaxed/simple;
	bh=EzAxtso80P6P2oQKtnOX2YdnPIINUmaMEBKPpSvQnvM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MpfUeE/JvsAg1Gdvnc2vZGphJGrHMGJ+IDAReAdJjepgsaOzm631UEaSMGt10csilY2r50hCQ42YcDN1xWM1ZOHA4OW+t+gR8oLzQnXx+1o0F99pCIH+PgiQNBH0U5UXs4hUuNhR+3Oj2efA74xYfL3paI3EGaTrB8IodOO83KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfCPvO2x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ac357c55so10244255e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780333730; x=1780938530; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bb5+0SQ1WSt0e7KSkXzY2MHcwPs9a1pBUBUqaxnOM8=;
        b=ZfCPvO2xGlyJJnslQdOtZ34tb+P5UPseoRFHdttt9vAdVEUlJQ5SEmd2szM34N4FkB
         mhUIQC0ngXc2ZO8WlZo91EamxnHHRnrQChaYbHKeuXo4P0WA/II6gioLlI1qSkfLATB2
         bL6Ufrqo/QikU647Wjel4fjwB6lKUqreFVWqyXzjigGZOVsB4L5wwY+Melg1jQ7ncp5w
         FZ61NWaf3l8cikke/FSG4AEjfZSNJPJSgWsdKKL6RWgjb2L1YB49NzsEAJ3tw9YKrkse
         XxzB+J95AfmCVSh4306LJZ1Wkd1NwRmUbyBmVCDcvXwAbO5Lmopg4EHq+OR+/HAX4XLb
         lK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333730; x=1780938530;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Bb5+0SQ1WSt0e7KSkXzY2MHcwPs9a1pBUBUqaxnOM8=;
        b=jxsQH0t6PJRdJqloNcZPv7lWhUyngka6vSEnszrVxNwjS8onb1zBCNN3aEHi4jvhJi
         ISHv0acIBwKQQ1DhVZrcLi4E5jAT1EJmsfWK628dQ++2kdHfcK4UBDl1NFUArfM23TSw
         cOmv14NGH1KuP1ZDIgWWNT85HuME09EEXzUAGytsEVpiHFDluxLgxs97R3Bpl1XTlcB4
         bXZMqXrSE3ImEE0F/j0e0HPe98HIm988+sYX/5mP2dCLZ46m0wqq5puBauocS5sVBTM/
         Janb20OpOd+LHOgs6Fh6Wrianq9NNTXHlM+bpNl+vHaUxYLG5KkqGcI54joZ5fZdQt1y
         u6hA==
X-Gm-Message-State: AOJu0YyEZaq4VmmTtTA6CBh3rAODFOoy7Us14ckRPbl3KSUFS907yXDb
	qBnOGDFdlh40kpRABRkpb84rLNyS0ntw/ce3EphJ/B7hzSelKRphpnd4
X-Gm-Gg: Acq92OEjjtv+vvpHV0gRnpCflU73VGw1Mek25volxshyUd8e1O4WN/NYUIh/X9HNGMi
	9DE9b/xZtiuHeKe0Mn0PFpgkXg+WY35XBOv36VGwXKz5rvI7RyAX2ESf9Qdi7Sz8/U3ZhSIw5Pt
	vUejmhHGvXx/WKhiZr9i1sVNrizvMKRIQeIe4+zaA7DqFNUmxvISL5QN8Jy0V9JZYOi/EiJBC8f
	QaaD8W/b6PicuBiknDj3YE0/NMNjjeXQ2L83wndWOjVeBzGUGx0GVsOjN++HKoCWCvR26H39Psm
	a6faNC2Fl13Y9xSj1yYatAE5O2B5FbVIiMobnw9rpmmPH85U9PQfRwW0e7RfAllABgyNnpsez8/
	S4GPtcyx6NjIFhc1LqcqnBdeMkRuOuqqmAwX4LliTJ+wAtkwU8TdKNM5gNfFtse1oLOZTgPMrj5
	wbhE+370v03g03gCTWZG8obKTEeczxIEc++HcDnXTre3BCxcV4ySyH
X-Received: by 2002:a05:600c:a11:b0:490:b0f1:c27e with SMTP id 5b1f17b1804b1-490b0f1ce6dmr5127165e9.24.1780333729641;
        Mon, 01 Jun 2026 10:08:49 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e13eefsm5056975e9.2.2026.06.01.10.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 10:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 19:08:48 +0200
Message-Id: <DIXVMW7QYLL5.M5EQ7YQQ0DTM@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid setting 320MHZ support on
 non 6GHz band
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Rameshkumar Sundaram" <rameshkumar.sundaram@oss.qualcomm.com>, "Nicolas
 Escande" <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260123144224.2216923-1-nico.escande@gmail.com>
 <a4ee39fd-f1d6-4b84-832c-c4eb0166476d@oss.qualcomm.com>
In-Reply-To: <a4ee39fd-f1d6-4b84-832c-c4eb0166476d@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37280-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: ECC81623112
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu May 28, 2026 at 9:56 AM CEST, Rameshkumar Sundaram wrote:
> On 1/23/2026 8:12 PM, Nicolas Escande wrote:
>> On a split phy qcn9274 (2.4GHz + 5GHz low), "iw phy" reports 320MHz
>> realated features on the 5GHz band while it should not:
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
>>=20
>> This should not happen as the spec at section 9.4.2.323.3 says we should
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
>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/wmi.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireles=
s/ath/ath12k/wmi.c
>> index 84c29e4896a4..14947fdb9813 100644
>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>> @@ -4888,6 +4888,7 @@ static void ath12k_wmi_eht_caps_parse(struct ath12=
k_pdev *pdev, u32 band,
>>   				       __le32 cap_info_internal)
>>   {
>>   	struct ath12k_band_cap *cap_band =3D &pdev->cap.band[band];
>> +	u8 *phy_cap =3D (u8 *)&cap_band->eht_cap_phy_info[0];
>>   	u32 support_320mhz;
>>   	u8 i;
>>  =20
>> @@ -4901,8 +4902,14 @@ static void ath12k_wmi_eht_caps_parse(struct ath1=
2k_pdev *pdev, u32 band,
>>   	for (i =3D 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
>>   		cap_band->eht_cap_phy_info[i] =3D le32_to_cpu(cap_phy_info[i]);
>>  =20
>> -	if (band =3D=3D NL80211_BAND_6GHZ)
>> +	if (band =3D=3D NL80211_BAND_6GHZ) {
>>   		cap_band->eht_cap_phy_info[0] |=3D support_320mhz;
>> +	} else {
>> +		phy_cap[0] &=3D ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
>> +		phy_cap[1] &=3D ~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK;
>> +		phy_cap[2] &=3D ~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
>
> This field is split across PHY capability byte 2 and byte 3, so should
> IEEE80211_EHT_PHY_CAP3_SOUNDING_DIM_320MHZ_MASK be cleared as well ?

Indeed

>
>
>> +		phy_cap[6] &=3D ~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
>> +	}
>>  =20
>>   	cap_band->eht_mcs_20_only =3D le32_to_cpu(supp_mcs[0]);
>>   	cap_band->eht_mcs_80 =3D le32_to_cpu(supp_mcs[1]);
>
>
> Since you said "On a split phy qcn9274 (2.4GHz + 5GHz low)" i wonder how=
=20
> firmware set 6GHz capability bits in this case. That said, the approach=
=20

I suspect that the firmware sets the same features for mode 'a', regardless=
 of
the actual frequency range supported by the device. I've also seen this on =
a
5G + 6G split device too.

> looks fine to me, although I would prefer to clear the remaining related=
=20
> bits as well:
>
>    IEEE80211_EHT_PHY_CAP3_SOUNDING_DIM_320MHZ_MASK
>    IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ
>    IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP
>    IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ
>    IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ

Yes, I cleared the ones I used in my middleware but I really don't mind
clearing all the 6GHz/320MHz related bits I can find.

Thanks for the review, I'll spin a v2

