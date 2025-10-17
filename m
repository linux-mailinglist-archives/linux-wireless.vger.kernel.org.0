Return-Path: <linux-wireless+bounces-28012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E50CBBE6642
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 07:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C0FB354A61
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 05:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0B32AD11;
	Fri, 17 Oct 2025 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FRdYFNLS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C228B33F9
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760678148; cv=none; b=qIeuh2BLavJLFrKExmNEZJBNkFzHhMwX+CgwQq+J63afmlpwy2UTNKqqqE6058DJGXZGHN0sXFgBDFN3J9fLWFAudm8IJZYt+hbDmo+be+gAMLV6Qh1UAnOFjfL3X6xMMXOfgWSfzWXhwgAd26tvDcS+CLmKfruP73xrD0s74IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760678148; c=relaxed/simple;
	bh=V+xtcFQjnKPPNLpIf9ZNPZJZPoH04836VPBakdj80UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifTLvpj87fEBe6+TAWMKmYHM6T3J/DlHDFXv8U0UGoyTMNwrwTQa+0leMBhyg7LHAUJeICB3fAL8M2hNgRa7CmOXr30r+dEjfYINm/Zj+u0VNX5zcCFlsf0DWfYqEycRMvdzI+85lhXvXmk89yROSXDym0PxbHTJDfSHX8SbffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FRdYFNLS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLX0o009503
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 05:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QIKO/DPFg0c2wPpUGqI6aEd9ZsFDZggwxQR6K7a+wa8=; b=FRdYFNLSJJAowr+n
	gvssstqhkoQdmm6b+hRKy8OigSnvsu+dureYFV8wANM9n+NZWRp9XInydCSGN00i
	G4Xx9pLa9zP7JhpOxjAEw5CYSKzViyiS5uk/QLt4wdl1A1oC9KXiRGtTBynYnsPS
	Kppa3sPTySlFNLslcPZHKlDvZCmFSq6eY5xccJeVoCox/yQbUZK5h918DZKF9Iv0
	otcNRaQf7nuJ+dW5onFXzJXLrsXKG7J906RdlkeEUGPD5Inw5ViLvqi67b6xsOOs
	3vAk4GKTdYGXUojC1HpKJu6NAEhmL1NFbJIu76ZlsLskqs9YomosQFSkehi1Xd0S
	RlWdFA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0catgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 05:15:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33bb3b235ebso2381540a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 22:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760678145; x=1761282945;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIKO/DPFg0c2wPpUGqI6aEd9ZsFDZggwxQR6K7a+wa8=;
        b=BCsCEBDAKCY5srt+xxbjiGhNo05hYF9wROpSPUKelgPtEvP5SMX/dOeiAxC0F1QxEy
         cf7dZ9epDVMSRJEpWpbW8LNHjTyL4jj3Y1JwqeIi9NDWAkpNv/oUJlk/9PDTDPo3c9RE
         IwTP28uKE9W3+N24dt5kNLV03N1nN2NdxVp8tOCYfZfFbscvfglJqpcF7/IHXYaSJ0gt
         lSW/7ThbcP8T8piEBKnHUAgIZpROXS0n1Edl2qbtR93jhMOpKIwDvqxSd9c1NxCqD9eE
         o+7jcDWJmLDX+4AgF+YcLO+B2lEn5MVdzj+X9hxhoEivvsaxLkv/X5WJEyCndGOQ6RMW
         CSRw==
X-Gm-Message-State: AOJu0Yzx3frbcTMcKXBJgqIgj4pJLM9lCVFX0bremVpaD2DEfKW0fmTC
	QzTRFqKmTg286OFMlZwn4EwUrBaOYmhw2NrSt43fbs2AoN3AK6eME6sMOYLHsVZ9bHJdMlrryd0
	V11j6UthQICZBItIYYwTQv+loq3bZ96nzdNqQM3Yhb98/hk97YYaQq8mYrY/MEVuOEDZCcw==
X-Gm-Gg: ASbGnctTh9zZVs/NgMMiQ0LK1JR/JNJQei+OMd0M5xMifYLon84WbVXQb7ojyU2mcYw
	1Y8gkSRwcP9Edj0ECQ3Ln2NXP5E8Bu15GU+EQWJyx24US4ol46SYS9iiXkkuueFAPTwMPTHdoa8
	8+70lhYIlV6ovH6G1G3Qo+E1xls81q0TmmYWJb9GLB74tp2e8iEm0n8PREEO60G2fC7ZPQD3jsA
	oT7TA0GGsIJkShdxil0rCBKJaCUdrGVrTcozgFysbyb41w4/PJYTxXn+9yQyRyVYVGm3Z7dTk0z
	njK8Htg4Jj9zxnW2Z7T3aejnyh4iCPlLUomSUGggaL5uQX0RcH4FO+4bCWEJt8Is+z2qDyNkgV6
	vG/uK12zCOAtHvGw2/YL38Ph+EY5+GP/3mcaDUpM74XM3I0Xhh+c3logGcnEICr7Yq72/fw4=
X-Received: by 2002:a17:90b:2d8f:b0:335:2824:aab4 with SMTP id 98e67ed59e1d1-33bcf8fa14bmr2497110a91.24.1760678144827;
        Thu, 16 Oct 2025 22:15:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp5cDrPQ7jg/bHgX5Tzk4GvQSeanJa1RTvTIKbf6pe1o7S4p+gyeCqev5LNL1xEYrTatcd7g==
X-Received: by 2002:a17:90b:2d8f:b0:335:2824:aab4 with SMTP id 98e67ed59e1d1-33bcf8fa14bmr2497092a91.24.1760678144441;
        Thu, 16 Oct 2025 22:15:44 -0700 (PDT)
Received: from [10.133.33.11] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd79d4927sm1402923a91.9.2025.10.16.22.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 22:15:44 -0700 (PDT)
Message-ID: <537f7a80-2e8c-4887-ac47-2cdf861fb351@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 13:15:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add MODULE_FIRMWARE() entries
To: Takashi Iwai <tiwai@suse.de>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20251003082955.11436-1-tiwai@suse.de>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251003082955.11436-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mdSLRgtCk7Rbg00qX9lk2Cm0lTVRrYnr
X-Proofpoint-ORIG-GUID: mdSLRgtCk7Rbg00qX9lk2Cm0lTVRrYnr
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68f1d101 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2wKZT7uEXQSXzUSAk68A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX1wETuNTw1Jea
 E97IX6f+OOwE1gtnpkwSWFsgHvBvTTD0SZBjbJY+gJqU9YJSHzpFo9xJNYTyyWfo3gR4W5KCYEC
 R7YDQ4ivwNjVttxuyoZJS/ZbetUiXKO4Lwt8auBxVds38wPFtfKAB+E1AM/jRaT0Q92syiPaJcM
 A9ikm+aBBHr5bL2nuJUpzpzV2ME+FaAeOkqKggjo1EiAgVtshCXkOVIOhMgQM58QRWNlVME0cmy
 W6JZFQInXusEn1XSzo38EkG6O+Mtq8aYsMn99/9DpqscIDOZIa5g05Yfq8EGNdz1W33v0aELk4S
 7ntYAwJ1NeCYVL0yqAuaJAnJPpbh6CSZ6UmuRNYoRAlnGDLITzhnuXF0na3UwjSHNr00P3puyO7
 rbedz/yuw/WFigLN4aUR9nZc7+IvaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022



On 10/3/2025 4:29 PM, Takashi Iwai wrote:
> Some systems such as live-image or installer require the firmware
> information for each module declared by MODULE_FIRMWARE(), which is
> currently missing in ath12k driver.
> 
> For addressing it, this patch adds the MODULE_FIRMWARE() entries.
> Like ath11k driver, we can just put the currently used firmware
> entries for QCN9274 and WCN7850 with wildcards.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/net/wireless/ath/ath12k/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index c729d5526c75..48161db6af57 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -1871,3 +1871,7 @@ void ath12k_pci_exit(void)
>  {
>  	pci_unregister_driver(&ath12k_pci_driver);
>  }
> +
> +/* firmware files */
> +MODULE_FIRMWARE(ATH12K_FW_DIR "/QCN9274/hw2.0/*");
> +MODULE_FIRMWARE(ATH12K_FW_DIR "/WCN7850/hw2.0/*");

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


