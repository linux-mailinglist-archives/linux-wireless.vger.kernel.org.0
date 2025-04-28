Return-Path: <linux-wireless+bounces-22147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4000A9F556
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 18:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADB54621E4
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FE027A932;
	Mon, 28 Apr 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l0JsYmGD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE914EC5B
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856860; cv=none; b=Ucd1kUWdyMfxg/FK3jbaAjPr+K34IRWov7G2RbH0Fga6PLyDR1prpb2z6S16eW47MZyDV23YM89MKXkNXqOCXwDiTUAMotTRial4RPRum6ArUMnb67vVzzKONOSLBZutOYe/Z2rx61ZWfcC/iyFqWEN3CgI9uRehOSWVJ+z9NJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856860; c=relaxed/simple;
	bh=jhY+hYNQ2r4ndw5PRb4PGVzEEi2I+rrNHKXGy2747b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p38c9cnI4HzdxR1V3JOD1Gnp0IsjpLZhR9ij+fw4n70OX70rVCovEMfGqoeClZCaQIE1A/6F7zwWn6UKUxrUQFiYsEXRp8bL21vxu2tJ+ZS3/JwtWE3/M58YKljldzAy0GE0Wt/lwIcPn9COQi2OrnCHhj44RHovM563tlJfpjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l0JsYmGD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SACTDL027121
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/V8Sk0jnYoMxTmrMu46NMhWrQw7hVUH5YLpHYQVbNKY=; b=l0JsYmGDncuP3wk9
	1mK1rJ/dDXV2C3LLhPfdUGHRo4Cssmf0vUefYPBQ91iyPcfz9oYa2Dt8i23Owwqp
	qBDKNJaC7GkHQM8aATOHGRO663CeFCv0sE2C4u+ir9Wp4Dppljo5hvNKPBzmMvS6
	HSRXg4rTgWrUfy1WgxMCxp22EXvfIjmQkDFMhuc/B8ZWaTP9jxwFAl0HXhP96/cd
	WMUmm2m/tEpFSQKp8eOD433RKZjafK9zF42eDQf343kRrysE+1whMNgr1dSOk2MY
	fcUJMTrAsmyTJANgWB6h6rUEep04NcHtZHXBXROF68iuCdfRAcTG77zijopmlz0U
	3u+2WQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qjwsphu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:14:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22406ee0243so34508795ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 09:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745856856; x=1746461656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/V8Sk0jnYoMxTmrMu46NMhWrQw7hVUH5YLpHYQVbNKY=;
        b=IP7zPUv/gffWMWqBQ3cnstJPHiX0qBbDRaT0PErQK/6YO24FJ1D43cQ+0QPuSWvsyD
         rdN3/2biXvE5HknGmF+BypCblZG90Pwl2Zxl08VOtPEYoxbCasF/Qe8iGMbKQGji7Gad
         LruYlLquYAZH20DcMitSgRgN5nJ1FoTpn3qKlYu17LKx+lbhrfbdylJNbpMEQ7JIv5T2
         92ilMrSMSG03rBce3Iz+b56niCVfhE3sQWSim0/zvl70HM0kGqPlhDaphLiYv/dSpVAE
         blvi578agD7gmjrC0XQZ9e0JRq29kWyRSuAHGFp4/dLw2B6mkqozcRZSMi290Yre4zGJ
         DZfA==
X-Gm-Message-State: AOJu0YzvtVtrsJ/hVUTKBYocgBESwFm/rfFhP8Kl/cE5bEacs26tWMiR
	CM1lN0cEDiQZzMJXOiii8sIwuV8MB+lqRVDR3baYfiTQSd0FUZbpXZKUmOzzNvSlDIHGVO5rAnp
	GPFilnDjOK2+CcTzDqfgmXRfNLD2qIEabGesu4cCXHoWldIHFYbtCDYKIndA6sKiEWA==
X-Gm-Gg: ASbGncslvAlYo3i9SbfJyeZDNph24wasvoqYqnum8dA+7DcvaKcXrNrclMh8Xn+83F6
	quFmxcO68cJQb8lFRvTD91q75KLawJ7VQb3IhPb8LCm7XedsSSLz7EeF4kXpcaiHKRiuVDbCEjE
	nFEfy9wdoe4INFeOP4R1mMLPBR0ajZv+YSd2YYkyimJbOXolWT0hyqb961mQkPDZhWBaWevjCB+
	trbtVZj96GOkEb1SQkYEvn8zTydTiAoNIW0qqkF0trtrSbmwYWiL/6VCI6UUxol70KGZL1NZZDV
	aPVnPKZc+2HHPF86TF6pbOIbZeiizQVWYaqq4hYVsNLexuNlaRlzSgipwBi0
X-Received: by 2002:a17:903:3c48:b0:223:53fb:e1dd with SMTP id d9443c01a7336-22dc69f3b04mr143095895ad.9.1745856855845;
        Mon, 28 Apr 2025 09:14:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHppuR8dvYljPTYcRZKu4BHzVYSZldfYQM9vAmQpN3t2WmX+8VasqrxjptsnxhSm3w0u+/LRw==
X-Received: by 2002:a17:903:3c48:b0:223:53fb:e1dd with SMTP id d9443c01a7336-22dc69f3b04mr143095445ad.9.1745856855396;
        Mon, 28 Apr 2025 09:14:15 -0700 (PDT)
Received: from [192.168.225.142] ([157.51.192.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50ea421sm84982105ad.109.2025.04.28.09.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 09:14:15 -0700 (PDT)
Message-ID: <1692f2f8-c77e-87ce-db70-00b4d9fc7c95@oss.qualcomm.com>
Date: Mon, 28 Apr 2025 21:44:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 00/15] wifi: ath12k: add support for 6 GHz
 station for various modes : LPI, SP and VLP
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: f7DlTzdAJ-qEqJ25L9BxvuXpKLTXAxC8
X-Proofpoint-GUID: f7DlTzdAJ-qEqJ25L9BxvuXpKLTXAxC8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzMiBTYWx0ZWRfXwbeAir4fUaPH ElygSRgcCdXw0p1Soo3SFUBY1M4SLBDowNVaT+Jh9zK5Lc+uVGpOQmqboMU7bqpSNTLJ3zDQT9+ V7Vuh8i5WqE4k0FiO5LbiSPEirT1OwHfg1jRuy7opywBQTwrRPojAwlOGyGmDUStOw3JvfaSnvU
 7lrHMSWDHXsSXivjGa1O8CTtvQBorcRodJ7Sy9yEsQJcyG6ZvDkE/kcQbLgmmPPH52pEGhHa684 7BM8RVe8Qy4i/nQCQOnJjkhixllk9PSPzPFo0KBP3VPklxrykw5lhrs/sNS3g6RblvLdWJB2fM8 nfHRMvSE9dVIezKHXygbnvunrf8+HfxKOfP82DWGcrMsnQrDglRCvCo7eS5sypoJLBQP3JnRd20
 AOGsHgxqb8cGaJn5TqSE8BJMdjVmNnRzP598vWsUTvsONJTk9yTnCzI+dT8nUE04HueMITGu
X-Authority-Analysis: v=2.4 cv=c/urQQ9l c=1 sm=1 tr=0 ts=680fa959 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=XJI/iaC0GbrNbCf3OOiYRw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=rSFznLUdu7_CRTz4a9oA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280132



On 4/18/2025 8:25 AM, Baochen Qiang wrote:
> Currently for 6 GHz reg rules from WMI_REG_CHAN_LIST_CC_EXT_EVENTID event,
> host chooses low power indoor type rule regardless of interface type or AP's
> power type, which is not correct. This series change to choose proper rule
> based on interface type and AP's power type.
> 
> When connecting to a 6 GHz AP, currently host sends power settings to firmware
> over WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G commands.
> Actually there is a new command WMI_VDEV_SET_TPC_POWER_CMDID with which host
> can send more detailed parameter than with those two. So add support for this
> interface.
> 
> Before above changes, some fix and refactor are done to do some preparation
> for following patches.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
> ---
> Baochen Qiang (15):
>        wifi: ath12k: fix a possible dead lock caused by ab->base_lock
>        wifi: ath12k: refactor ath12k_reg_chan_list_event()
>        wifi: ath12k: refactor ath12k_reg_build_regd()
>        wifi: ath12k: add support to select 6 GHz regulatory type
>        wifi: ath12k: move reg info handling outside
>        wifi: ath12k: store reg info for later use
>        wifi: ath12k: determine interface mode in _op_add_interface()
>        wifi: ath12k: update regulatory rules when interface added
>        wifi: ath12k: update regulatory rules when connection established
>        wifi: ath12k: save power spectral density(PSD) of regulatory rule
>        wifi: ath12k: add parse of transmit power envelope element
>        wifi: ath12k: save max transmit power in vdev start response event from firmware
>        wifi: ath12k: fill parameters for vdev set TPC power WMI command
>        wifi: ath12k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
>        wifi: ath12k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz
> 
>   drivers/net/wireless/ath/ath12k/core.h |   6 +
>   drivers/net/wireless/ath/ath12k/mac.c  | 527 ++++++++++++++++++++++++++++++---
>   drivers/net/wireless/ath/ath12k/mac.h  |  43 +++
>   drivers/net/wireless/ath/ath12k/reg.c  | 209 +++++++++++--
>   drivers/net/wireless/ath/ath12k/reg.h  |  18 +-
>   drivers/net/wireless/ath/ath12k/wmi.c  | 198 +++++++------
>   drivers/net/wireless/ath/ath12k/wmi.h  |  62 ++++
>   7 files changed, 905 insertions(+), 158 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

