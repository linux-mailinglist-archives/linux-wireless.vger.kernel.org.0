Return-Path: <linux-wireless+bounces-30694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B07D11588
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 09:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E1703021063
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4B5342CB3;
	Mon, 12 Jan 2026 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hwSFANl1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L1K9DRIT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63308310762
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208028; cv=none; b=H2SG6YE0Evg1+63qE6bnHHJlV+HXUeUDzmRGj3h3XywhblKr6am+wXUxn8ru0FRMhKxz9GoKn3SZACKYLbdIwIQNvCA3o3Sr1ARDIwTRQ0rTnKnnhzqLnnLYBBBNPL3P5SxhtHhSGX8XkmidQEPk5Nk2wOluxBvcjRH83Zv2n+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208028; c=relaxed/simple;
	bh=+U1i7eZHkcj82Bcwa4Z/+PLZ5BKAV8Ivm/s2ooMgB/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2F/0u5gl71VDLW5hk60I5OZotCHt+UgSO7pC32rzUijmr47jm1hcqsorUqBUCY30cU8631zeWLc82e5e0cRWEcXCl1prxAnxF2pV/XnhWp6YhR1hdUJGZpX0rc2zejjA8heuuZL272IWLizWmIhWi4CpOTA8KaJXFIfADJ9Xs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hwSFANl1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L1K9DRIT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C85Nvk1235114
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 08:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWkCQrMVdcNN3iDMPf5vzVoyrfbbNe8+1ztYVn/Zmqg=; b=hwSFANl1H5fAwBPG
	TVHt5jto1u9+H/VGFbWAu37FDkvW5uhj12YUA7atyxL3GFuX+c17Aux9Fn+47vw4
	qGcRS8u+UcE5Pp/dFWZ4k6FF9w1dapROQ0xO7k/ciIIooeN1Wdq5gV5T6KlyrTVJ
	6MP4iLTyTobxOqPKh3ZDztmz53UOv8QKIJWANq6xU+IA/hWH/hWa8g1Rt74GqqIW
	a34zmXfDG0ltJWi7PjLYU4Vd+mS853Gh0HPLB1nwupDvmZt9zA2GRbGOybwbQ8if
	j2BSIde+DQhGwEC3ELPft3OZ/Am9foakx2fqdFEZSk9scxTUHKMD7lFF/AP+5qB5
	rQpsxg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfxfv74r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 08:53:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f25e494c2so53491115ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 00:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768208026; x=1768812826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWkCQrMVdcNN3iDMPf5vzVoyrfbbNe8+1ztYVn/Zmqg=;
        b=L1K9DRITB7ZYRCBsgJMi01Vsbq18lcSflE8FYX1oWhHqL9j7JmKs5owZzAgHSeXb9/
         0CNxWcJO6bdl4lDSEXIxDEjFGRZYht/hHMqvd+oSX29W18hLXCjCEC7w0Mt3LPMU3a7M
         Eu08Bv1A5jCNjtfIY4TVCLlR/m2nQ5+uWxGifhUk058gR5tZWhi7Pw6NZAjZJrKWVgDc
         g9tganfKPrcKBz9vhZK2J4VF4Yf/6tDcSPrelslFQsT+eisXyUm7DH+jtdodE1wxQnXA
         KYxAYQlLmfP3VVk8PRlsW/7G1AOG1O4S2ptY7XOK4Rhz9L/LNTfNjT61571KeIbEHXVM
         Q0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768208026; x=1768812826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWkCQrMVdcNN3iDMPf5vzVoyrfbbNe8+1ztYVn/Zmqg=;
        b=xRqfEGixA85Zm1hyQeSW8l1aMK6xSlqPVtO1QW4RItfYJavzzNliEKkhWS44kMfW0A
         YDjGifredXorAsKIO0FM/QuOSnxrg2Bl1/gx31G0OBmkh6HRid9NmfXqv3yV4q0q+WMz
         WL1vtY5eTlpTSFWZyoHGv7Ct2Lcika76Zry3h+9oR7BHbrViSHVS5h8AZ+jYbyElU9rr
         yA2HNilrmDVwhwnJJsGX6UqzUb5qwTec6+8NwIswhMuvnXA+5ojVcLexlPMsBW4zT5Q/
         V8kJpZiR9eagdvBa6+mH3/c1urfw1ssrX3VGhzU/G+XE0iAUCiZFisFU5dC1J+q7jU4r
         Sc6A==
X-Gm-Message-State: AOJu0YwfJMJ6NUq4SYRLg4JA4K+uD8UnF6oFaz1YIDbf9jBbqJo8iQvK
	pxuDuUtB4FRS6nxVugn042AJ1SpUdP+XN7MMGcpiruaxLSnUgDM4T23L1UxW2TyQsDm28SUpSmy
	J3ttaeaimuxP5j1Wgs428wEwQSRLPk3w4TH1DPvM8P/3efj3yko+Uf5dODd9OKMqENztW0Q==
X-Gm-Gg: AY/fxX5bUjA0Oj2m/RAB2YTdVlLBp0qbQ2EYQJlCgQ4nhVDHKZsLvM6wP9tqV6CetmC
	o3FB3fyQlTss4Lz9x79ftZc+O11aNOXFuIp0KfI+KJEy1BtUbei+eDiQ+UX3zmRhTI107hGa+wV
	Ad32fvlXw1ZFGF+wGJ70ZjNYT+h54Vn4jgbWoUMn4pNlBkd3HtJJJqQDUtQA334CltOchx+g2Ay
	gUrK5gcnVs5RTJ1N1TS8SYuYB/jezPVWywB17ELt5wIyEi7gSxEfsqctrMH/q3YapfVQy2qmL2q
	kDG2KC16QK74DRcWSx67tGQ4griEt8EgP78vb9/+s3Gm7NZxaxiHLN22F5dCLmwNZau6hjX7KaJ
	MbLhXlu3O3vHc7qliA4JBRcp91EB1VSUJrtOJeL92Ms4UGz6a0zLLCOn5l4/Vqk5Fn71D2VsNRX
	9H1QLQP8s=
X-Received: by 2002:a17:903:3d0b:b0:2a1:3ad6:fab3 with SMTP id d9443c01a7336-2a3e398244bmr192928385ad.1.1768208025761;
        Mon, 12 Jan 2026 00:53:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKlV+4r56idUQPnjdvCP2LdvJBCgqv0nR7FqSVZHFjbjhnrVVHBD1fhu/ZRznMJ6bG9A0f2A==
X-Received: by 2002:a17:903:3d0b:b0:2a1:3ad6:fab3 with SMTP id d9443c01a7336-2a3e398244bmr192928235ad.1.1768208025290;
        Mon, 12 Jan 2026 00:53:45 -0800 (PST)
Received: from [10.133.33.243] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2df6sm170159115ad.61.2026.01.12.00.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 00:53:45 -0800 (PST)
Message-ID: <f6c5c5cc-8dad-494f-91ef-632b5316a9a9@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 16:53:42 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: cancel scan only on active scan
 vdev
To: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260107-scan_vdev-v1-1-b600aedc645a@qti.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260107-scan_vdev-v1-1-b600aedc645a@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kQSKvqHi-x9Qo3_QLVW0k1P3ikiR4852
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA2OSBTYWx0ZWRfXyKRdVNf9Pava
 dzQujN8WYoj93WxNmRyWBLZPTtW3RyQQMh/byWTR4dBrgmYtiGQrCbayjnlG3Y3vHoPlzxFAzss
 hSayPK/XPRLukleYgt254YmuarSX5dCJ2VgBMBHUqZ6aUR3lnhy/KVitLOvpqdU3nlgk5qBaN7v
 ZWEjzXnqtMKacwNx1RQIUi4HQpFPyS8OJQm9zlnX40V9VwimAXkj0T4ZnTwMiTWC5EsHF4ZTG35
 pW0q43pdpf6bJolZCE0izaM58roerf7H8uEjzUz0oDcvJRpRU0C3gl3hmU8Zd8sIGoxHbzPz3YY
 UpRn1VhPZHFAj+AZphgXQsg0zdyPrWMOXmp1aBfHjlWk9dyTwS2MId9Ro6ebRWdz43nADt7DA5e
 8kc7L85emBPMRyIWpzBn+N7BCK/PmnfpcUquNcAhGnnBS80ckPhdIzq4OM1jRVBWxAy6n+4cLGU
 fG4leSyJ/9BEPQwFQvg==
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=6964b69a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pvcN0sP83juaDmYZ9xwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: kQSKvqHi-x9Qo3_QLVW0k1P3ikiR4852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120069



On 1/7/2026 2:02 PM, Manish Dharanenthiran wrote:
> Cancel the scheduled scan request only on the vdev that has an active
> scan running. Currently, ahvif->links_map is used to obtain the links,
> but this includes links for which no scan is scheduled. In failure cases
> where the scan fails due to an invalid channel definition, other links
> which are not yet brought up (vdev not created) may also be accessed,
> leading to the following trace:
> 
> Unable to handle kernel paging request at virtual address 0000000000004c8c
> pc : _raw_spin_lock_bh+0x1c/0x54
> lr : ath12k_scan_abort+0x20/0xc8 [ath12k]
> 
> Call trace:
>  _raw_spin_lock_bh+0x1c/0x54 (P)
>  ath12k_mac_op_cancel_hw_scan+0xac/0xc4 [ath12k]
>  ieee80211_scan_cancel+0xcc/0x12c [mac80211]
>  ieee80211_do_stop+0x6c4/0x7a8 [mac80211]
>  ieee80211_stop+0x60/0xd8 [mac80211]
> 
> Skip links that are not created or are not the current scan vdev. This
> ensures only the scan for the matching links is aborted and avoids
> aborting unrelated links during cancellation, thus aligning with how
> start/cleanup manage ar->scan.arvif.
> 
> Also, remove the redundant arvif->is_started check from
> ath12k_mac_op_cancel_hw_scan() that was introduced in commit 3863f014ad23
> ("wifi: ath12k: symmetrize scan vdev creation and deletion during HW
> scan") to avoid deleting the scan interface if the scan is triggered on
> the existing AP vdev as this use case is already handled in
> ath12k_scan_vdev_clean_work().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Fixes: feed05f1526e ("wifi: ath12k: Split scan request for split band device")
> Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 2f4daee9e2f0..950ca7536612 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5606,7 +5606,8 @@ void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
>  
>  	for_each_set_bit(link_id, &links_map, ATH12K_NUM_MAX_LINKS) {
>  		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
> -		if (!arvif || arvif->is_started)
> +		if (!arvif || !arvif->is_created ||
> +		    arvif->ar->scan.arvif != arvif)
>  			continue;
>  
>  		ar = arvif->ar;
> 
> ---
> base-commit: 631ee338f04db713ba611883f28e94157ebb68e5
> change-id: 20260106-scan_vdev-94d8cf5a667e
> 
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


