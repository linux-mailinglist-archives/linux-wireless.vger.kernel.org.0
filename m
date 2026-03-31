Return-Path: <linux-wireless+bounces-34204-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNgADLhVy2moGQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34204-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 07:03:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F7363FB3
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 07:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C4733045003
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 05:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B01363C4E;
	Tue, 31 Mar 2026 05:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SzhXr5qT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mqa4uWxC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099E36C580
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 05:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933428; cv=none; b=B8IBYSgZG4yLRu2k4a77hctTm6Lafcd1h3hT41sMTMgOevFe/izCvYh8eem6+qfKwp2e10HrfMuw8pWgb/Q7kXRBuzsc+raxogW0ZszfiIT2IBMuq+h9WN9V/zLHVBmovghlSVSasrOoQIYz+0VtfAkRyC0YvVvKW+wwdgVdH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933428; c=relaxed/simple;
	bh=diZxQKDC+ZlN06WvAU+8YZQ/yjritTFY75iQgThkJi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzEIXsu1hmZ7CkjxQdCZy+lwdZ6RYBfOS9D3B998AM+Cx7U0MSDt8qjNPUhHVdnPsSk01QakewoAcJaK93fs8zuI9m0N/PFNJoKTBmpfyN9NCBDyXoWb2GHLAI5/yxlPLT1nnIuV1l9dUt2ffFZSsfjSoD+L50dr7REiQZz7smo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SzhXr5qT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mqa4uWxC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V32SCn4013490
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 05:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TV4etoVuPtlENfSDF3QJ/+hh0lBOV/pehR1DxChF+u8=; b=SzhXr5qTskaOKvIy
	l33bvaz8dGh3STN2x/turlbIOS6CcVBS3DMhv37Pq27eWsFm9KAJ0OFko2BCQHX8
	cihT/MoN8C3kR/MaSoc6NJyBYsU3pTyQVyaz5C3FR+XqWKIfJAg55Bi2+zFyZJVQ
	QH1gTcQfyvnczE9SAeKG1g4zrNFghRSMHqwBRMX/svV99iKKRdAh+r89Ztc9daki
	65XNLUPCtGWbuSwYcvGyHK06yPCKXltOZbhE5GCcOMd6vOTfXBfuvbGZYI6Hlri+
	X0Th6j/1fyPr+cGc7/Ybacq905FLbuTT5dfQZCsz2ErvJq0GN1hxqDd3CrkuEowB
	gqM95g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7regug2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 05:03:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24af7ca99so28711605ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 22:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774933425; x=1775538225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TV4etoVuPtlENfSDF3QJ/+hh0lBOV/pehR1DxChF+u8=;
        b=Mqa4uWxCL2NqNhJd/s5ruLTGZnoAr/qRtqSLcQOk6l4u6aerA1nC+MovvZs70+oEIi
         abC69h9Wbu5txG2gcu/omRDdEFDd0ztYGF/+VC5DDO3Vb7UBjAGEKoQEnF6CnKcKNvKA
         PA5iBzX4eLa1RZYSqtBKUjF090Q23NpChgKkiuPt/QVligBxamRHOV+y4EJMOEO2AVNM
         5tndnWWPDKaIlDXGeWPli2S2h1AJkfjjtj2eJxe/lqwA+D/erAntMNLueffBn68upiyZ
         jln7WD2MUbSZtwToCGrRtr1i9aGaISlQDVtBG393gEcW9R2B0VNB5PfwVSmIyhm9MCDE
         2c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774933425; x=1775538225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TV4etoVuPtlENfSDF3QJ/+hh0lBOV/pehR1DxChF+u8=;
        b=lQ+Rd7RkeA+yhAJ/8FMZw7yVugGVw0tDZ1AwIGDfKyC8cBhwStQsE3f72zEmUxrdBZ
         NO8+AlrZwmtLJ4aifNzip1mWUpdRW+l32iF4vqSMLYiqI68mivOSlrucSzYa3t5zuQpf
         RyHsHs4mtuTJWViwmCgtbdhGPD1SUlFhwJy0tzX+bg+E6BSQF3qPxEakJesmZds3r/tE
         6o3iMU0vL+Bfwbw+NqS9U6bYO8zRZK08Svexi1PtkDovp3zK305bEPogL8dGtu3V19F4
         kiVmYDd5ITUM3KlSEATQq0gznxYawXVy1rI1d46kQCGpEFBB0YzVfwBUaU4tZgrqZKVI
         dyPA==
X-Gm-Message-State: AOJu0YxmhDus6uW/RHHM+YjuPH5OoXaDmBYzvZoI+r3YDmPLGrFwyRZG
	b2d+k3PG4stNHZvKghRdFzFV7QmJGa15yrK2cYCbdV3SoG3nXx8ZofswC9rXJdbu70Jrfqpu7df
	MUz4bryOYKODyw+GAfgpIXaowH9FjOhC7FSX8bgV2iKe4Iw+H/xdzpmzIOfV63vvPjm8T6aD+JM
	q3RA==
X-Gm-Gg: ATEYQzznKq7tRGSzBvyeenJnch+ZXSVB6yjbwSF92ax/rbG4DeKDOWCEnwbtmGd1lNu
	VD9wKB+UFpYlGolRkLRdlCSC/c3wI7+lqqBEF6D6pcZKijiTYzSHI0zqdkza/zJn/qPzdplEc33
	NnhU2phisW+EOoJECfYuPXHipXVtU2o7tK+9T5mPhhTQm+yN5MEm+buwdIucPWpjApzkP09PUKZ
	GiLt9t7P0Z3FwB96yq7nlsONsx9fmJUSq+zi+Dc+/EKLenSSocxk8MPbY8H4cs7xWN3+qWr+53p
	VZtPyvWMXgINcDtNSq276ZXwKqPmgHhbTYzJE4v24jSglyYSL0wTKn6sifO1WRi07HBTcONKx4K
	cLq9nxDpzi/LJMPXDrtRTlWKfrzlZCBy8w1kF9fpZaprHoVF3f0qdB2tdJKjE/Q==
X-Received: by 2002:a17:903:1a07:b0:2ae:aa16:acf7 with SMTP id d9443c01a7336-2b0cdcfb995mr155306885ad.40.1774933425253;
        Mon, 30 Mar 2026 22:03:45 -0700 (PDT)
X-Received: by 2002:a17:903:1a07:b0:2ae:aa16:acf7 with SMTP id d9443c01a7336-2b0cdcfb995mr155306615ad.40.1774933424749;
        Mon, 30 Mar 2026 22:03:44 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24277fb3asm104745115ad.57.2026.03.30.22.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 22:03:44 -0700 (PDT)
Message-ID: <14df48d4-61d6-454c-b946-dbf5f5679eb7@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 10:33:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Rename hw_link_id to radio_idx in
 ath12k_ah_to_ar()
To: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260331045834.1181924-1-roopni.devanathan@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260331045834.1181924-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G6wR0tk5 c=1 sm=1 tr=0 ts=69cb55b2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=qJTBxiSCcKiInWsf5WMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA0NSBTYWx0ZWRfX0ancFD76NDis
 GacnXrmp5qXxcV/43LU325qb4RE9wxgBjOeoQolLyVoMZAIlYHd0rk309AhHb/KjlxRFUMiC2nX
 0RxXsY9RFLPs24WNNcpLitRCnDH7KULXo/cYfxr5nK4Yt3bn8iGkTNTZvVuBc948C/G4Ju908db
 0TPhGJknJ4juFURnWXOVNcPlRso/mlbrtZtZcF8jhXDafW51R7EGn+/FiAOEFJRA5XOapLGWPqo
 PKuvHKInLaNJa5BZ8+2WBNoMiaOwVzN2tkmHrdRV7TKVTVJDzc9KzqFKAtMqO5x9B6rPjhJjogc
 QsdgOAW1QzMpmcc5nRz0yemP8c7aNYbSonzowJbJ9SwTIRikbQiTn7OgIagsypN6gCAqlchfItA
 eGL3EFAgjhHkWdAAo6pmnbgnhTl9IwB6VHrehO3NGt+jmvx2fw+PxhNOLBLkh3XUaJ2qD7syctq
 AVQNhW0lA20ZAKrfpNw==
X-Proofpoint-ORIG-GUID: QqvFJl1Qic_rKBmXLH2QKqCu6wXNluu5
X-Proofpoint-GUID: QqvFJl1Qic_rKBmXLH2QKqCu6wXNluu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310045
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34204-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8C8F7363FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/2026 10:28 AM, Roopni Devanathan wrote:
> ath12k_ah_to_ar() is returning radio from the given hardware based on the
> radio index passed. But, the variable that radio index is received at is
> wrongly named 'hw_link_id', which points to the hardware link index that
> comes from the firmware. This affects readability.
> 
> Resolve this by renaming 'hw_link_id' to 'radio_idx'.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.h | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 59c193b24764..5eff86827e9c 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -1366,13 +1366,13 @@ static inline struct ath12k_hw *ath12k_hw_to_ah(struct ieee80211_hw  *hw)
>   	return hw->priv;
>   }
>   
> -static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah, u8 hw_link_id)
> +static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah, u8 radio_idx)
>   {
> -	if (WARN(hw_link_id >= ah->num_radio,
> -		 "bad hw link id %d, so switch to default link\n", hw_link_id))
> -		hw_link_id = 0;
> +	if (WARN(radio_idx >= ah->num_radio,
> +		 "bad radio index %d, use default radio\n", radio_idx))
> +		radio_idx = 0;
>   
> -	return &ah->radio[hw_link_id];
> +	return &ah->radio[radio_idx];
>   }
>   
>   static inline struct ath12k_hw *ath12k_ar_to_ah(struct ath12k *ar)
> 
> base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>


