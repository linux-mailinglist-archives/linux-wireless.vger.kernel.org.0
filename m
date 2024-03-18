Return-Path: <linux-wireless+bounces-4867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D3687F07F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 20:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6B91C215A2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B75676D;
	Mon, 18 Mar 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pE//NR0J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A595711707
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790870; cv=none; b=TpTaVaBSoLgBFoAx+hcLJXEjWOo8cOdxJEFeWV4tddHVJBbhWWONAL24FEuv4jeVM0iA4QV/GDipu6Vm3N92KAsp2B8it5y0DRNWMtjD/TJEor3w6Q0dteLTO5cg475chyNBZsEDCxzTokRGsvdGjpOl4pRMm4R2BUlQqAWcMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790870; c=relaxed/simple;
	bh=oYCjDy+lb4njrYlK9OBkTYMygVirapBclB5ymfGs3hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VfLDS52k5Zumj271UoytHc6oH6DAqAo7pUdeBibX13UCkHAOGG3TynMBPMGOfHQQFL6ugSuJB8c1M5hw0tHT9qn4Wpc+lcghAce1srTOIuyXslzpUgcTRwGAW1I30z7WMK5FwwpeiWlhr1cIoJm2qEMWVGlPdqh1bvRbjiTgAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pE//NR0J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IDTbm5009153;
	Mon, 18 Mar 2024 19:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wv518dmYEwtTR+TjjPyC6YIb0i+sx73V1gS2n1N7lFE=; b=pE
	//NR0JkPfv5Vm1njMkPfe6C8ItrtGqNiCq/2wSJ+5SOWYQ76UPfUe8/KqmXAD52f
	76WD5QLkWvfz10RuVqemzerPfMuS4/s/Gj0DiWCMPWiIE/yUBF1wXnm42AmxxEX6
	NkVu8umOuhb6427C+gtbGMLWJAM/W5fqzp4y7MYIXXzT1Huf/TawC8gPtQiNLm6D
	PS4m0Cn+sH0+K8zIkuTQlQDxDec+IMcvrdAMwcldgAEizexi6o6oUwf/vMZbkxFI
	EfsaYc+fFR9aCHax/C2MEQlbTiCWoEbTr5L8MHjB1K0ThaQruvWnPz6SSg44NS3D
	aT2x7HMAEDLTSJ96+A3A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wxmnjs4r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 19:41:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42IJf2GQ031024
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 19:41:02 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Mar
 2024 12:41:01 -0700
Message-ID: <2e46eb4e-daa9-46ad-acc5-4a7e1321a5bc@quicinc.com>
Date: Mon, 18 Mar 2024 12:41:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix memory leak in ath11k_xxx_remove()
Content-Language: en-US
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240315014307.3132980-1-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240315014307.3132980-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O5zhKu4OInZ2TzPAHCBbVTzetMYI2cW2
X-Proofpoint-ORIG-GUID: O5zhKu4OInZ2TzPAHCBbVTzetMYI2cW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=471 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403180149

On 3/14/2024 6:43 PM, Miaoqing Pan wrote:
> The firmware memory was allocated in ath11k_pci_probe() or
> ath11k_ahb_probe(), but not freed in ath11k_xxx_remove() in case
> ATH11K_FLAG_QMI_FAIL bit is set. So call ath11k_fw_destroy() to
> free the memory.
> 
> Found while fixing the same problem in ath12k:
> https://lore.kernel.org/linux-wireless/20240314012746.2729101-1-quic_miaoqing@quicinc.com
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 1 +
>  drivers/net/wireless/ath/ath11k/fw.c  | 1 +
>  drivers/net/wireless/ath/ath11k/pci.c | 1 +

My Qualcomm Innovation Center copyright checker reports:
drivers/net/wireless/ath/ath11k/ahb.c copyright missing 2024
drivers/net/wireless/ath/ath11k/fw.c copyright missing 2024

Kalle, do you want a respin or will you handle this?
With copyrights fixed you can add my:
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


