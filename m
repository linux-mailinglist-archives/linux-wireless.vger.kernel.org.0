Return-Path: <linux-wireless+bounces-566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB378809760
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 01:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D231F20F88
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 00:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CD0380;
	Fri,  8 Dec 2023 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pjy1MdLa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E081710
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 16:40:45 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B80YF4w010690;
	Fri, 8 Dec 2023 00:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kNB32l88K4OKdqzfGK3kqapv53u6cdbNAUhSI40TMyc=;
 b=pjy1MdLaWEt1MjBc4P48xiyZrcQxzhsxQOTdCb9xTF0b6AzlO7Hx1VVQj9BdDzDQxPek
 LzP+0GNcITfga4Bt6M7F4IiLI4UTq3MaYlrzjhPvlrLnTzItkL8d1FZCF7EeT0Vnqg6R
 5wQw35ia3XW8nKFpA9hPM1PkTl9q9pGtxA2TFRLzu5CrUsNWGNwmb+iTSdxk39nifmQk
 /HbPUo2zoftGfYllyvUPBqsos7B8n7VFE24Jl6H4RzD9MFli0mHr3LoBWH5lfox79+gw
 AaLoAwNXRqWrFkrB454qC1lD844vLq+yWwFN9nE6ustFM1VR15vQu8b87f+OIi2xBEsY lQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uubdm27bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 00:40:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B80egPN007000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Dec 2023 00:40:42 GMT
Received: from [10.110.111.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 16:40:42 -0800
Message-ID: <da46d1eb-8612-47fa-b092-4020b55b8647@quicinc.com>
Date: Thu, 7 Dec 2023 16:40:41 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: report tx bitrate for iw dev xxx station
 dump
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231207021155.13125-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231207021155.13125-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gx3LSF7kl2GgzIYQpXH-X4sNRgSiYDz0
X-Proofpoint-GUID: gx3LSF7kl2GgzIYQpXH-X4sNRgSiYDz0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_19,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=722
 adultscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080004

On 12/6/2023 6:11 PM, Lingbo Kong wrote:
> The tx bitrate of "iw dev xxx station dump" always show an invalid value
> "tx bitrate: 6.0MBit/s".
> 
> To address this issue, parse the tx complete report from firmware and
> indicate the tx rate to mac80211.
> 
> After that, "iw dev xxx station dump" show the correct tx bitrate such as:
> tx bitrate: 104.0 MBit/s MCS 13
> tx bitrate: 144.4 MBit/s MCS 15 short GI
> tx bitrate: 626.9 MBit/s 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
> tx bitrate: 1921.5 MBit/s 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
> v2:
> 1.modify types
> 
>  drivers/net/wireless/ath/ath12k/core.h   |   1 +
>  drivers/net/wireless/ath/ath12k/dp_mon.c |   2 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c  |   6 +-
>  drivers/net/wireless/ath/ath12k/dp_tx.c  | 128 ++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/hal_tx.h |   7 +-

Please update hal_tx.h copyright to include 2023

>  drivers/net/wireless/ath/ath12k/mac.c    |  92 ++++++++++++++++
>  drivers/net/wireless/ath/ath12k/mac.h    |   3 +
>  7 files changed, 230 insertions(+), 9 deletions(-)


