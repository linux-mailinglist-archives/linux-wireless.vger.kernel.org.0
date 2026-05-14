Return-Path: <linux-wireless+bounces-36408-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OISK/9ZBWomVQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36408-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 07:13:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9BF53DEDC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 07:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE53430166BC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 05:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA13BED6E;
	Thu, 14 May 2026 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVTUu3HB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bu2Kg7KM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A811C5F39
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735610; cv=none; b=SANaZT5WFyuS2WxqH4TBQAFS/qsZrcuT1sCmb1tEOM2NGPkEP4vpXKzCNvga7hxl5EeBm0bxs1VhchnfWxGEPHaCgRhZpOycjxi47wl0PHJ3SuP4LlwoPeBi7QjB52aqKLyNgAKiqtPOQjleBG9FV7cx4IDnsu+GV8AsS6TmINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735610; c=relaxed/simple;
	bh=VJEi+LQjQvpb2sBPTQT1s79F8yD/a6RpDiryNNJ90X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgsErdDUEMw2+vg5vmctp0xEsjZ0WhGOBw20ujj8SAYWt61VDSkFp5g/VR21Xwen9CikJwcDrkKmjIU6qqB01GsKkptSDWL6Vc6wOvSNZukaECc7gHSH2Cj3/d9mMmfO3zO8+QsWj/opfCVVU9rDTZsVhrMW4oRtlcVMA2JuGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YVTUu3HB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bu2Kg7KM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E0dPLV3474773
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 05:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/5XMCJRSZDY0XJc+QOdRMaoXWGMiebQeGgCNmc9Dhbs=; b=YVTUu3HB0OTW8g6S
	R9JolPsDru3tA2U0h83Ia7AiNOV20/+g7nHPh8dtQ64n/gt9wr44JLeIe+Ttrodx
	1ZMGUHQzywewPAW1GQ1l4bM9ATYLhgiUQ6gpeH/7JXBwLIwQSDpWdbigaZEqhAtR
	PMl8XvAlReEfSe4hgiJ9wwhYSG1WleqysuXTTSAqPpMtP750KWrxGPtbjcq4FUB4
	5a+Wrwk8rLTIEEmuT0b6ibbziYLc6d/DQR3WhcmOOUAbs6bO47rd1TTsnLDFN2LK
	0dK3UDAlDMtgDeFSYLOmrhofF9RP0UdOMOwepIREPFNpfHGszISEUPJNUgOkV4jE
	3STyjw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p41c3xg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 05:13:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-368edd5fec4so2736763a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 22:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778735607; x=1779340407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5XMCJRSZDY0XJc+QOdRMaoXWGMiebQeGgCNmc9Dhbs=;
        b=Bu2Kg7KM0cRiA6S1QedtfjPnqPhg2oEVy7n1zh8hxlyqctNy1CLyLCbceWvmhjV5HM
         Ie4gd/jCngrdQDrjbmzZZCCFx4d6XQVBpiMWgLy/5Uk0HaMbKcrYH/QYzjroE4Q0Mlth
         7xoUzbSjJHbtje/J0sdAKDtaNxPGmoBzmfYrsCkNDLAJ07jISDB3DVJWirRZ+YtAm7Lx
         tRTMNnF1jH3jsH++9GiWQcKnCH/SvsgbCYpAWWqNZ1gKTcWEmfBX0qNup3ZNUV1iVhJc
         H4J3L7t/3XGSF8QOFlWk+Sk+/v6NyCmIF0ecQrkQ5byE+NKveIjB14GpX30leqXTWUEM
         bMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778735607; x=1779340407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5XMCJRSZDY0XJc+QOdRMaoXWGMiebQeGgCNmc9Dhbs=;
        b=hgq6HGgEzO3kNkaSQRnK9u6Fu4prEYGPQ0USECpg4pEyGyXe5Qkvj89AmghsvkgENO
         bmSopQ+L25DgXMQ+sqMtLFoEI5r3qy+bCDzHs8nEcFZ7+Tc4e+DOry/yzuZDXpM7kRU7
         ouF/Cwf4f3i5PTO3ixPvqf5V3d1e9V88r2Vxsyubhgxsl2S0yZ7fZKoKZ60wNk4QYDWc
         7Ye2gfV/+U63hLHgkGqc2nJkVOxoE+A325ZbT7Tynx1NyHFrvbQsOZgfec4CJ1GI+mEY
         RyiesqsLQLzdG8vqkn1tPaafze+k3OsJHl02XbzeeKO3yct1R++0CbyrZ8Lyt1pQMiPS
         d/tQ==
X-Gm-Message-State: AOJu0YzinCaRLvialEqfu/OUobKAFRaCCuJtz646tAqUNqEnUi+MthVB
	y3ZIT332ZZgici5WPbiGlf7PawcuSh5jRNK2ifPwCeBhIEVn9UAYlfW643cHudLuWZ0pcxqHBJ9
	3sa486xXkuz/6UwJKbjL37yv0eXOS0R1aY2+3kXhvnAYBeSQyOIjFZTx4PmgriBX0C2DoFQ==
X-Gm-Gg: Acq92OE5apo368OH+njptEpAcyVU8q/mUWVDxwIT4+g/x8jdpY2gSpclC4R40DvjmBf
	Hl7GTl7mmtT98xxOsRVmoPZtKFcl9QtOj6K6ADZwwA7NSoDhzHjaqWhAtyYXrPCK799wco+l8sE
	jWwoEzAyNYtsfxTuI+hcrTKizEJyz34pYhcF77hTegWYWS1fzzSpJgGI9aWVMLGpZ0CFD5gHc8M
	nyTUF8H/zA+q6h34tFifC/G2SHr485WED8mkHwoWrrB4ydi+DwtPwanzF6ew/NeKgNpEeDsUVmJ
	Nc+4jdTlY6Y5Cl3/rstxYOR4MYXnvb7rT7xw/diZ4Mtri8m+12sjD6dnL5YFW6Au+76x+AcS3HN
	ScPq/7xWTKA3sNFl31RRCVvJgYap6Oojh9lQXmVqk2a5cvZoAUb8l183W09zZTA==
X-Received: by 2002:a17:90b:3c8e:b0:367:e244:4c40 with SMTP id 98e67ed59e1d1-368f7a19606mr6334599a91.26.1778735607037;
        Wed, 13 May 2026 22:13:27 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8e:b0:367:e244:4c40 with SMTP id 98e67ed59e1d1-368f7a19606mr6334573a91.26.1778735606406;
        Wed, 13 May 2026 22:13:26 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368eea199fbsm5025698a91.17.2026.05.13.22.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 22:13:26 -0700 (PDT)
Message-ID: <781c9c44-bd2e-4d12-b29b-daff0f86aea0@oss.qualcomm.com>
Date: Thu, 14 May 2026 10:43:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: fix EHT TX MCS limitation due
 to wrong 20 MHz-only parsing
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260514-ath12k-fix-20mhz-only-mcs-map-v1-1-a38d4a9b21a2@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260514-ath12k-fix-20mhz-only-mcs-map-v1-1-a38d4a9b21a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a0559f8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Iu_Yf0RYHa-hsXmiW2AA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA0OSBTYWx0ZWRfX5wdVaBvPNXK1
 TGC+vYCfccuaWRbNS+fORRQ6o4yOfv205XEZDPjddDlEkk26fuYYwAzuSaMIw7m5z93F0y/GDKm
 qVG9G9OcTJJDmghVAJxzvQ5pPEypvvjzitDhJ3AYXLVVZ/dpUdsjeTezEU7gB4nlFtNUcpe8ZYx
 lVnr4Mldx1alxeahffPkF6xMGGbJPinyz9uJjp0Hk540rekSQ9gwHR7SmKkbK9H6ehG76Gl6VKI
 vqqgtlmHlGSGTdSXaucFmQjEwPbopKLAb+aigh3mdiNVH1VfAWLpOpzyKmj92jKYBN3Ri/Y/deu
 WhtaqMp3NDBc4UHsmNIhNh2h947a96xzQ6CpDIA/S6hd2xVdjL809gSm6k+oP2Z6SZ7zDjBsn9q
 abMzz9VdAno8KBKBJ5ZNwI4vvUQT+hSkEOObjJo9mQblcr9j5POr3uUf3QvCYJS7mTupVOAdZIN
 4OSHPEaagu+a2w5RcnQ==
X-Proofpoint-GUID: DZPChpkGEjCykqpiLZ5x_Cv0k0v4vUck
X-Proofpoint-ORIG-GUID: DZPChpkGEjCykqpiLZ5x_Cv0k0v4vUck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140049
X-Rspamd-Queue-Id: AF9BF53DEDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36408-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/14/2026 9:02 AM, Baochen Qiang wrote:
> When connecting to an AP configured for EHT 20 MHz with a full EHT
> MCS/NSS map (supporting MCS 0-13)
> 
> Supported EHT-MCS and NSS Set
>      EHT-MCS Map (BW <= 80MHz): 0x444444
>          .... .... .... .... .... 0100 = Rx Max Nss That Supports EHT-MCS 0-9: 4
>          .... .... .... .... 0100 .... = Tx Max Nss That Supports EHT-MCS 0-9: 4
>          .... .... .... 0100 .... .... = Rx Max Nss That Supports EHT-MCS 10-11: 4
>          .... .... 0100 .... .... .... = Tx Max Nss That Supports EHT-MCS 10-11: 4
>          .... 0100 .... .... .... .... = Rx Max Nss That Supports EHT-MCS 12-13: 4
>          0100 .... .... .... .... .... = Tx Max Nss That Supports EHT-MCS 12-13: 4
> 
> TX throughput is observed to be significantly lower than expected.
> Investigation shows that TX rates are limited to EHT MCS 11, even though
> the AP advertises support for EHT MCS 12/13.
> 
> The root cause is an incorrect parsing of the Supported EHT-MCS and NSS
> Set element in ath12k_peer_assoc_h_eht().
> 
> IEEE Std 802.11be-2024 Figure 9-1074as describes the format for 20
> MHz-Only Non-AP STAs.
> 
> IEEE Std 802.11be-2024 Figure 9-1074at describes the format for all
> other AP and non-AP STAs.
> 
> Currently the first format is parsed when the peer advertises no wider
> HE channel width support, without considering whether it is an AP or a
> non-AP STA. This is incorrect: the peer AP's capabilities must be parsed
> using Figure 9-1074at even when it operates on 20 MHz only. Parsing it
> as Figure 9-1074as causes rx_tx_mcs13_max_nss to be interpreted as zero,
> which is then passed to firmware, leading firmware to assume the peer
> does not support MCS 13 and to limit TX rates at MCS 11.
> 
> Fix this by parsing the Figure 9-1074as format only when the peer is a
> 20 MHz-Only non-AP STA, i.e. when the local interface operates as AP or
> mesh point.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 6c95151e2e77 ("wifi: ath12k: Add EHT MCS/NSS rates to Peer Assoc")
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

