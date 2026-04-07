Return-Path: <linux-wireless+bounces-34418-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLc5NZZ/1GlLugcAu9opvQ
	(envelope-from <linux-wireless+bounces-34418-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:52:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BC53A9851
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA3153006469
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 03:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35B7374E6F;
	Tue,  7 Apr 2026 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TRNCmrK7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J8lLtBIS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011F3750A4
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533970; cv=none; b=Rtlg0fO88yJC/f4sMB9oHNtG1B8fhCr0a9KQJ6V6xYq+k5OIKJBGYELrhBohMbqjUwZUnJOCXzI7WUeOdoCculAG//ajIYY+SxPmJU0+1hCzQAU4V3qep3agCrPt6M5xNUgz0LqsfdRcDEb3PTYzixmiGCqUwky2etw6FOvTS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533970; c=relaxed/simple;
	bh=p5W6fl0MYk0hkE35WTbb4JFhMNiQdqaYy+/Ymrv2Qv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/5bp9hMX2rs6Co7bejrIhki3pGYrF4+Wbijditmi4jcoO9PPIv0H2zY/WeHo2R3wz6AYMAMcig5RKN+rwNd+8qh2p2xKNefkFCXfsCOrCb7KxSVdUCC9aEKl5cPo02yq0rGUtY+UYahKYB3cvcELJviGJrCfnRzB4QAe9tBwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TRNCmrK7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J8lLtBIS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQpgd3402629
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 03:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AuAGnnUVWiZRmcQesKYHg8T4vxMspZN6eBQlm36IxqI=; b=TRNCmrK7FSU7YnW1
	4aMcr+R7/74MjoJOSulvRM745KYss3nX8KSv76221sxIE2SNrLjDMDS2idpBQH+/
	ocA7zlcB3lQTfMMp9cmPqBU8xO9eqQIBWu2SINYnorU7TXiSClnkjRnDAjNHfqcQ
	un419Fp81tiQO1EGLAHgEkoaPO+o7+AmjK2IJZUeNsTPCXvEP7U3Bmq1thozwzsn
	j65gJ9fQlUwg7oORHn5SG0WZlAv+iEQ4r0nteHxmzVWMde+QIHeWOrRqS4naxFca
	kZoblcB4SvZBlXD6pTmmZ9j70vM7w5hZUgpLDjr2P6v09PbpHnctxqy8ErYXAoAk
	I/xFAA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhrw74-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 03:52:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6e7f45e2ddso6899580a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 20:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775533967; x=1776138767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuAGnnUVWiZRmcQesKYHg8T4vxMspZN6eBQlm36IxqI=;
        b=J8lLtBISdiY/v6jOcKS3car6G/CijlXZTB+SvHKGKxZ1yR9thLN06PI9Njjs43nJ/5
         vNnl440wHaFAuxV1ASXPcOZW05TgI89rbUgOD/tvjkgLYih6f0jnM0PIN4N9WyN3qaWW
         mFkp32TDZV1MI22zeYUmZEkuLTRcq42ls+HCnM/zeW3fXnDP4IXNgp0Zw+ZYoXAguldv
         nsJOIhBgH+XL8BAQziYSD10ZG/FPGwmFW9hFxm9Rhhmcthn3g7czR7WezoNj9RScT2j/
         j3kXItClH5xM6V7JbVZmToduKY/TxcMctp/kPW6/x2xePYgIuA31NSSHes720G/ejYTl
         RZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775533967; x=1776138767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuAGnnUVWiZRmcQesKYHg8T4vxMspZN6eBQlm36IxqI=;
        b=RV+uR0uBJZ1nlt5fqno9s/YATxXcqksGwqDWGBugLDA4V0Qk03ECJqo+b4e3sCE9eB
         bEWxmaOQTHvA9XkgWlHAcaYJAtGiBz/zmGllrb6I08+0/dUwkc7Relh8P9qoiV3FAwNg
         pdzkdUPM1w1jBM0Kf881Z6LmDlea/IzhEjIX/kz43I6rYP+EFcPDqMrnsi+QphjSTQTx
         8M7rf6+q6ku+WT+vGNoheCd07xm+iQwAw5PUhiDGMmEquq2uLX3g1sfFX92l1t5FimnU
         xpgBTd2huqsMkm4t1g9QzuXnWTPbIsUTNKkjppTLJjrf9+X3ZwGhfKaMuk9e1iYec8Q9
         wEWw==
X-Gm-Message-State: AOJu0YyCyADRhoPGAkXNsELIXEjXW83cYDL1PBUs/9H590uwSDP6Rg29
	JDqN4fjz5+wBUj44Oe3oxxiebMXZkbNSPwQ/NjPhAO0kDfto12dY5wZa7wpCrVR8nh4ydL1i9VC
	zIGsMD76/Ng5SZ1sohfD1Ay/HdMRotctv3Zo0dsOo7C74QBc5ISv8YXFtI4po3DB+fBexlQ==
X-Gm-Gg: AeBDietijCaZNR9iQn+yyBLNJxWniJS1WtC5OGIfNeOnVlCZf9AFUTJgx6N5hRjLz3/
	pGajsZGZ63ngkUDVeDWBwqEMTOMR36zc12HYYeocH1k6UgbHJ6RQ9D5OGI1Xr3ovWR29YFDtfbe
	MPF1v52acz9ZNqrPAnlib6Np1s9bvpQm3vki7I3I8mVaOHTjpKiwWcwe5JQDtzbJUKyzIBy7ul0
	dWxPvigWcalLYrTwaGAyK5NLHXx6nRs7mSWAm4NwATzGgtXk/43w9shmDrcIXdOxvvCDD1SE96j
	hPfK2XMmkjpVDDn4AIf4crRUxfzjd7nqUQ8ulfQ3qSW0scy5n1Q8exnGuCyrtgeMYr3mqQgCgUK
	vbGhdLnwWKIaqaGo22/mPwPqKLwMPso0or1y5B2ESLMMfEyA9/IEZUayIe6iEIQ==
X-Received: by 2002:a05:6a21:6d9f:b0:39c:4af6:4303 with SMTP id adf61e73a8af0-39f2ee459c0mr14891502637.20.1775533966947;
        Mon, 06 Apr 2026 20:52:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d9f:b0:39c:4af6:4303 with SMTP id adf61e73a8af0-39f2ee459c0mr14891483637.20.1775533966475;
        Mon, 06 Apr 2026 20:52:46 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6563597sm16568137a12.16.2026.04.06.20.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 20:52:46 -0700 (PDT)
Message-ID: <0f851509-556d-4021-a08d-937e7bea16ad@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 09:22:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Skip adding inactive partner vdev
 info
To: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Avula Sri Charan <quic_asrichar@quicinc.com>
References: <20260330040732.1847263-1-roopni.devanathan@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260330040732.1847263-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAzMyBTYWx0ZWRfXxly8cdk9s1M1
 d+CgHWwaNSXjEfX+u+epReCZGGElEHX1tqZKA3Cw4kV65qCRdRhSfQLuZUKsnHlE1Klhk9buCc0
 puUkQAI5TyM33dzx64v2zu7aRcA8tD5KpTRap9adI3kp7k7YPYEJUwNsyBWFB6dYRiuwGapy4tB
 2A5c6fKPlEpMSQaZsEFOFU+kY9yu7EmnMjvyKmVJAo6DaaRlecHoZu+An6xlbb+pUyDulwL9SGi
 ihvN+OEGKMowZoDddxUfxBINwPDFDHhSrfvTBL24lPXIHMHRsJR4pOUdxek1/toPpczl96CbTA3
 arJdHIuSg03UAsX71KDN3xaWPmWTe03Z/U7eLJJaCTZJP6bS8JCBf0/3QDlfrcsi/ROr2wN+27w
 Pbf/EsKsGtGunzuOPp2Fp6/ric1GbueJDRww+ja8aaAQf0zqIqw+a1snd3BF+WnOmEg8ab02l0q
 eL9Y4kqlg+vz0mqHF0A==
X-Proofpoint-GUID: KFel_xCcx8R2TbmBRToNpY4wkNcsDrsw
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d47f90 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=RQiAibkc-cMzSS9pYhwA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: KFel_xCcx8R2TbmBRToNpY4wkNcsDrsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070033
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34418-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 77BC53A9851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/30/2026 9:37 AM, Roopni Devanathan wrote:
> From: Avula Sri Charan <quic_asrichar@quicinc.com>
> 
> Currently, a vdev that is created is considered active for partner link
> population. In case of an MLD station, non-associated link vdevs can be
> created but not started. Yet, they are added as partner links. This leads
> to the creation of stale FW partner entries which accumulate and cause
> assertions.
> 
> To resolve this issue, check if the vdev is started and operating on a
> chosen frequency, i.e., arvif->is_started, instead of checking if the vdev
> is created, i.e., arvif->is_created. This determines if the vdev is active
> or not and skips adding it as a partner link if it's inactive.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
> Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 553ec28b6aaa..c1a1b220f4dd 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -11131,7 +11131,7 @@ ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
>   		if (arvif == arvif_p)
>   			continue;
>   
> -		if (!arvif_p->is_created)
> +		if (!arvif_p->is_started)
>   			continue;
>   
>   		link_conf = wiphy_dereference(ahvif->ah->hw->wiphy,
> 
> base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

