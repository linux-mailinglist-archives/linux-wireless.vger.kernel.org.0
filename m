Return-Path: <linux-wireless+bounces-801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCE081348D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269F0281FC5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998585C909;
	Thu, 14 Dec 2023 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gChCwOIS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08815126
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 07:21:24 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BEC9hYR018841;
	Thu, 14 Dec 2023 15:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jo3YGN2wzRBUBERtmt498R+zQNaBT81vstNT133eb04=; b=gC
	hCwOIS7wuVdOIh0zlEWEPSczD6jR8vd2cBBFOeCk7dclZKmEFaA7ipLovjUZsS21
	ehUwM0V4Rc2fmumdWf9TgHf+YIXILhh5NsKkWooYkuYwF9A3GhfEat3eunGq7PVh
	uuNfpZdis340JvbZoeBM1fsXpfr7z6eQWQjSTpcq4ybT0kGmd9O4JnFVDXUaRpO2
	eVjZJ1sWYA54kIoTfFwDJMaPQdEyFUhh8DSnsRSFV4HSmh10/m0NJAntorcbBKvS
	T5mPn8fNOuXctt90m/iZwPX4McqHSqPcxWBH/h2WniErgonxkLJdN0u8/Rfn+8qv
	1RQZLobSya+WMdpuyDiw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uysrpsctu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 15:21:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BEFLIha030564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 15:21:18 GMT
Received: from [10.110.36.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 07:21:18 -0800
Message-ID: <a68d7271-1681-4df4-bc5a-c1e941f38af0@quicinc.com>
Date: Thu, 14 Dec 2023 07:21:17 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "wifi: ath12k: use ATH12K_PCI_IRQ_DP_OFFSET for DP
 IRQ"
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
References: <20231214053215.2087308-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231214053215.2087308-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y69y6GJpB0Z93GqwrkAbMJ1hg1YsoNMo
X-Proofpoint-GUID: Y69y6GJpB0Z93GqwrkAbMJ1hg1YsoNMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140107

On 12/13/2023 9:32 PM, Karthikeyan Periyasamy wrote:
> This reverts commit 1f1f7d548a00ebe50808cb1f580df9693e194a7c. The commit
> caused bootup failure on QCN9274 hw2.0 platform. Incorrect hardcode DP
> irq offset overwrite the CE irq, which caused the driver to miss the
> mandatory bootup message from the firmware through the CE interrupt. This
> occurs because the CE count differs between platforms. The revert has no
> impact since the original change was based on an incorrect assumption.
> 
> Log:
> 
> ath12k_pci 0000:06:00.0: fw_version 0x1011001d fw_build_timestamp 2022-12-02 01:16 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> ath12k_pci 0000:06:00.0: failed to receive control response completion, polling..
> ath12k_pci 0000:06:00.0: Service connect timeout
> ath12k_pci 0000:06:00.0: failed to connect to HTT: -110
> ath12k_pci 0000:06:00.0: failed to start core: -110
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


