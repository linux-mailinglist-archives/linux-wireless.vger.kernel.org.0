Return-Path: <linux-wireless+bounces-37052-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLOOBFr1F2q5WAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37052-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 09:57:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D405EE1D7
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 09:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 981C1306C52D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A54A3546F3;
	Thu, 28 May 2026 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NTpKuC4v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OWMM0Yp3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAD340A46
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955010; cv=none; b=myq4Q7MT3CJTxYEUvgDJTjGuz2SZTuuR9YzCOqKejvq67c64uJX6sOM0hlMgRLpEdjunsNyb/Pzuc5qw4sVD1Mzb8OIskEm58KDFxTPB+KurnECh9Z2B1csBQTbhRF/DGxCWY80jeL6CgLyfmjZpl3T2NZmYWygaW2X5N9IxqYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955010; c=relaxed/simple;
	bh=TpEN5UaRoGOIh6LxvB+UTYXgag1rpRNcJUeA7STd0jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTLzG4QiB2ZzTM1drNRo2OiJv3RRvfwQavNObHbg4Tn2CkQj16WJ5gcEVlYIOU1DhO9oBq6CNRHTa5q2WaYcsc1yinKUyAn9Zhf6Ffa4NOG7ZwTltoAdtQDXAw2YL31LS+kDy+4OyoT1YA0DACS6mIV8PHkAwWoWCgFcsz4/hKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NTpKuC4v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OWMM0Yp3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S7HLBr4188721
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 07:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dTE50W1bsXAlocRr11xq4D566Kq+w3xqvpSkOq4Nftk=; b=NTpKuC4vCUCGx2Od
	hhlz9jf669+7o7EaCobZHcDX/c5FFeAhP3bgqAZI5YyMlgDEZzgxWj1brp9jrYRM
	Bpa1DGYmCUiKQ7K3bBQtUsfRVbYl57keeG7iIWvEUkybgwwY03hsa8QVkeuKDpRA
	jYxP47oS4AA1uAoq0HLYBatfDdf4ed0FHWiKYBHvn6PguYjB2+Be0FLdPO27n3s0
	zetVgoJRWZbOgobP3e9jP3ZyfUSKuiOvJGk0WnNOQJJmDqX7F9mCu0TpB/u8vsua
	GhYxIu3CV6q7kLJMEIZLkr0B7Wh3TEIleyBnL1YVylb/iauVgOclHKhPDl5brYUW
	JObNMA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y2sv1a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 07:56:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba115ab6bbso139226425ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 00:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779955007; x=1780559807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTE50W1bsXAlocRr11xq4D566Kq+w3xqvpSkOq4Nftk=;
        b=OWMM0Yp3p+7ZAs45db4Fs3KCybuSk98FisGULh4bRT4y5F6opr5BpO8fToDbUq+W2r
         WOU3o74GSg2yb31bWwKp6KDxjObRqZkqNBCV8cP4q6hq1Tsv9EV0FUJ1MpAZC9XiGlSr
         C/ovkYMTGbHj1+6OASpTykMsRkkDQLgoXmwtkPLasx8tvIemOniCstgHQnVCbSjKM+m+
         595Qp/Lx0n0kWI8gjSKpKLaEx8aqLZtVS3OvaEA36yA4KqHrlARDvFbOwcugRZW8UcwF
         XosYzgeQeySRuEB9vhSZ3AKwWgQepuWbmilvS38S8x2NB34m0N4RkCgmyq6M/ifTXFCu
         AcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779955007; x=1780559807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTE50W1bsXAlocRr11xq4D566Kq+w3xqvpSkOq4Nftk=;
        b=Wb/bp5RWX1ljorGnNh/uYnwALtUfApJNm3JQIUJIG/dwPbUiUdjDDaerfE7n7p9Zi9
         l+qP7QlfVJxF5ngQb/LKz32rMm2IUZdj/aX2EADS0pRnnpvUmeeRl5OZVVKqCCEG65C7
         1JBD0Q0BgBIJryYocEjpGA6u8M+hFotQ+OxGJI0kfPeEkTk78Boc/t54tFNRPmw5eWzU
         9KLxJnJ3aZwzk+hohf8uPdsGOeqGJbC3vGCOj+jeZnJjT6IZJCtW0nWhWsH2g2hnuNoF
         2z265aEtWrZfjrcQOqxbDfQvDSWwXdUa2e2DUN77TRd/WVP5Wd/n3SfnI5nkQngP1deI
         fSwQ==
X-Gm-Message-State: AOJu0YylcSAIsjHs6KouAThSxM54KRFlDS38HAfVj00Z+bPeJb8dBoo8
	v6JqqSVzkTocAXaOwyJ4WNbPbUeqHLNshm7HVM7RM80zu57xfc3SiwhP20Aa7YP+x+mmE2HFP8g
	FoKiHeBeiZCnn5/WlmWmHfJWT0BCuoBKypH8lDVHeM68hzHA3Lq0Kx9LTqSA2+Vm5hIOzPQ==
X-Gm-Gg: Acq92OHFsMixRiwdsu5hti6d1HTIJ9kVmbOr5fTBKSYCTVGEfhof9oEJDzCPraBpbJb
	Lvebk4y3e3m1e/UoSfXRvZbx290c9k74uGXnTKGX/yMA0E4aCQprwC1/utr5XmNPlaa6UFZEjcY
	z3W7sZUN7nGHveQvufaneRoDGGeLyCo22TO26QVIH/G/fMT1mQD9yCGbKK2BvqRISkDVGVwnZB9
	ZxyjDffWDD1q7SPfp4/X1IhXSfAbZZOP52up5hVxP8+n8vwKDXAtSar3y1+vaatnInWp0ae+fNA
	b4jfGzFXcDqJcLa+I/XY5JWUfb6nKq5HzFoB4H0cO3ZXaFzTq9oJcbrQJOnmI0tHjaHykckecJM
	Da3c4f3ZFkRC6H95+G5BbZ0Tzy0W5SSV4Y9jyZrOrdSG4R7p+emzNHnPhTFaH7nSSPGOCwZHini
	KK
X-Received: by 2002:a17:903:1a84:b0:2be:3850:297e with SMTP id d9443c01a7336-2beb07726a8mr290233075ad.31.1779955006981;
        Thu, 28 May 2026 00:56:46 -0700 (PDT)
X-Received: by 2002:a17:903:1a84:b0:2be:3850:297e with SMTP id d9443c01a7336-2beb07726a8mr290232735ad.31.1779955006410;
        Thu, 28 May 2026 00:56:46 -0700 (PDT)
Received: from [192.168.11.105] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf132aea25sm1996705ad.79.2026.05.28.00.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 00:56:45 -0700 (PDT)
Message-ID: <a4ee39fd-f1d6-4b84-832c-c4eb0166476d@oss.qualcomm.com>
Date: Thu, 28 May 2026 13:26:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid setting 320MHZ support on
 non 6GHz band
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260123144224.2216923-1-nico.escande@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260123144224.2216923-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VeXH+lp9 c=1 sm=1 tr=0 ts=6a17f53f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=QzOFYGnyxmos3_uqdkgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA3OSBTYWx0ZWRfX1ftS9Lx+srFd
 6FSpErBHcvDMZba9nU050mQbZlkH7unvFg7nUfxlUotfink8txHSGMCFzyLou3C+tAVjSpWafkJ
 zYK07r+JLVkQ0WFBa6lP8qugOM2NE2KLVcxo7uWz8ok+Wu2R9Cgb4QS3Ds9cqlmZBCEXTLignkr
 9iTm86BE6d+jsDfeLGVb6mdYsO9Mp9n1BpVG2S16ExuGcVaBgt+do3ZyqKIqWL5NOcMz8N1n+O5
 ChHk8p1l5OCuyj6PnV8P/V0j8Vr8hm76HFAdJpvnRbwsRJ+lilIi2YNFifcXiVvyefTmm8JhHw+
 nISjEXlF81U8khx0qe0PLM4xGciJVJPB5EYPtyUAWn9+mOTTtwbOmrNGVZ98JDkVECyb1Pznt9I
 C8ZXX63Llqx4PrM2UQ4/x3Iv7XgZkMbC1CJX/JsOwo4XqVkh5wqQWipmDM0I6bor2/hecMCMyEh
 jFJHZW8JXRnCGxVcbIg==
X-Proofpoint-GUID: OGhH4-v7OOx2R57PVxvyNcjvmRaSWgDj
X-Proofpoint-ORIG-GUID: OGhH4-v7OOx2R57PVxvyNcjvmRaSWgDj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280079
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37052-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A2D405EE1D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/23/2026 8:12 PM, Nicolas Escande wrote:
> On a split phy qcn9274 (2.4GHz + 5GHz low), "iw phy" reports 320MHz
> realated features on the 5GHz band while it should not:
> 
>      Wiphy phy1
>      [...]
>          Band 2:
>      [...]
>              EHT Iftypes: managed
>      [...]
>                  EHT PHY Capabilities: (0xe2ffdbe018778000):
>                      320MHz in 6GHz Supported
>      [...]
>                      Beamformee SS (320MHz): 7
>      [...]
>                      Number Of Sounding Dimensions (320MHz): 3
>      [...]
>                  EHT MCS/NSS: (0x22222222222222222200000000):
> 
> This is also reflected in the beacons sent by a mesh interface started on
> that band. They erroneously advertise 320MHZ support too.
> 
> This should not happen as the spec at section 9.4.2.323.3 says we should
> not set the 320MHz related fields when not operating on a 6GHz band.
> For example it says about Bit 0 "Support For 320 MHz In 6 GHz"
> 
>    "Reserved if the EHT Capabilities element is indicating capabilities for
>     the 2.4 GHz or 5 GHz bands."
> 
> Fix this by clearing the related bits when converting from WMI eht phy
> capabilities to mac80211 phy capabilities, for bands other than 6GHz.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>   drivers/net/wireless/ath/ath12k/wmi.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 84c29e4896a4..14947fdb9813 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -4888,6 +4888,7 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
>   				       __le32 cap_info_internal)
>   {
>   	struct ath12k_band_cap *cap_band = &pdev->cap.band[band];
> +	u8 *phy_cap = (u8 *)&cap_band->eht_cap_phy_info[0];
>   	u32 support_320mhz;
>   	u8 i;
>   
> @@ -4901,8 +4902,14 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
>   	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
>   		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
>   
> -	if (band == NL80211_BAND_6GHZ)
> +	if (band == NL80211_BAND_6GHZ) {
>   		cap_band->eht_cap_phy_info[0] |= support_320mhz;
> +	} else {
> +		phy_cap[0] &= ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
> +		phy_cap[1] &= ~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK;
> +		phy_cap[2] &= ~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;

This field is split across PHY capability byte 2 and byte 3, so should
IEEE80211_EHT_PHY_CAP3_SOUNDING_DIM_320MHZ_MASK be cleared as well ?


> +		phy_cap[6] &= ~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
> +	}
>   
>   	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
>   	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);


Since you said "On a split phy qcn9274 (2.4GHz + 5GHz low)" i wonder how 
firmware set 6GHz capability bits in this case. That said, the approach 
looks fine to me, although I would prefer to clear the remaining related 
bits as well:

   IEEE80211_EHT_PHY_CAP3_SOUNDING_DIM_320MHZ_MASK
   IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ
   IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP
   IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ
   IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ


-- 
--
Ramesh


