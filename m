Return-Path: <linux-wireless+bounces-2915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5507844977
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 22:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E2A286E3D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 21:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF13D38DDB;
	Wed, 31 Jan 2024 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XwEMIujR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481538FB5
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735349; cv=none; b=p+Zb/Ggky4u84GHw2+iI4l2IBAFLZWHofFjFYlFbSe5nSpRNkVpRAIqY8ipNXlGKigi7ey7t3/GMEGqKCKoD9+Ugch3965h+FG0ZIboDm51ZhbtDpdvbix0UjyFKSP+cVUdh8BmsZF6FdICBTL3GR+jDKCf5m3Du4hCd/1eMBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735349; c=relaxed/simple;
	bh=kcFeeST+rEOxdmhKnOB2EyyPhh+yrQoCofcI+l/1AqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DiRM3/Vz3JCCPTU+cv8WK29hto+tZ7UuhKxE70o8df85g6dq5X9TsGwDXb1/wIc7whBkhY2ppzGcrbD75D9nvSf5xEQjTR4Pbd86qVq8jJdhZJKOIdn3c6zju7TVg8AH4T+qLauQIVLOuY5xBVYfw93SempQvJP/G0a0gfsA5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XwEMIujR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VG3Qm5001438;
	Wed, 31 Jan 2024 21:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tbAgYYET6iX1BnZJ6R4plh0iH3w4RPEhpQn8GIAW7GM=; b=Xw
	EMIujRrdLPMuy2aEqoZj9OnWcV1ZJV7XpdHzwCdp5RZaEbeGUm5Ly7rG19BzHLa4
	/W5Fa6mZMtan8CwBhZ10xn44znJwMHRBLK1xsEmj/i+FELw0ALoakm5whi1ioPz3
	n6o+jcwU3tk9/EM6EAxTiAbgMNWtkxfelmAoih3/X5lcseuHmLeb354PI7S96aXR
	CblMdh+HM9V8RvGLal7wiphMytJd0B/3ezYjNIU3uAQ/T+Ux+moNdMPK7/PwoKEE
	TCKePKhDUDWFtNh7tLQLQi+/Qrsmpy/6++1HsP7KuNFaUUTCx3bfUvVI3KLf576+
	b7HXE026GAxKf3vlV/8w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vym2m9ju6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:09:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VL95O6025828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:09:05 GMT
Received: from [10.110.47.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 13:09:05 -0800
Message-ID: <f58ba655-66f7-4622-bb79-bddabf76f355@quicinc.com>
Date: Wed, 31 Jan 2024 13:09:05 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] wifi: ath12k: Read board id to support split-PHY
 QCN9274
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Ganesh Babu Jothiram
	<quic_gjothira@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-13-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129065724.2310207-13-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IaTxkdVFHPv2ccJyGorfr25h08qMoHIy
X-Proofpoint-ORIG-GUID: IaTxkdVFHPv2ccJyGorfr25h08qMoHIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=741
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401310164

On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
> From: Ganesh Babu Jothiram <quic_gjothira@quicinc.com>
> 
> QCN9274 can support single-PHY or split-PHY architecture. Currently,
> only the single-PHY architecture is supported in ath12k.
> 
> The split-PHY QCN9274 requires different AMSS firmware binary
> "amss_dualmac.bin".
> 
> Hence, add support to read board id from OTP. Based on board id
> decide whether single-mac / dual-mac firmware needs to be downloaded
> to the target. Also, update HW param max_radios to support split-PHY
> in QCN9274.
> 
> Also, add new Firmware IE for firmware_N.bin
> "ATH11K_FW_IE_AMSS_DUALMAC_IMAGE" to support dualmac QCN9274.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Ganesh Babu Jothiram <quic_gjothira@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


