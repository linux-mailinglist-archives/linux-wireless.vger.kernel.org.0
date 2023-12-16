Return-Path: <linux-wireless+bounces-865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39508815B3F
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 20:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6E81C20F84
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F362FC24;
	Sat, 16 Dec 2023 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C9USnVR1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F92FE0E
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BGIpJhD012300;
	Sat, 16 Dec 2023 19:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Q9D7SnyIYlGu2ncYy2qku/nv+AUppoYloIuWZx/vYAI=; b=C9
	USnVR1vjZ6Rk7egu9gMLBZflduSppg76LKzQ1LsEvE9tp0q2hso59s/eA6iq3YaB
	8XavYKa2Vz+zIw4MiFOxVxZk6kCuLjOnZsGOho6ISxYQFMR5DYPDhv/gZ+obxsBb
	ld7FzBWkFrp5Z28elegf5PbOd2iefiBbkT76R1i34lpOsv354UDJPQo9jviyM7xa
	MRMFBow8p3u9WDMeDyn2d1CX0fc9vzomBJjRkRtNDz86dulzspoqBANE5u/nX+bK
	bMa/65Cp+nz0txTn0Zl8CXeLXMsvyglAtjVYdS5dlJl17K47sRQ6hkNKdHjGBVZp
	EKLrxUNWIgFhN3pcl4DA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v151fs2nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 19:20:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BGJKL9u021912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 19:20:21 GMT
Received: from [10.110.36.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 16 Dec
 2023 11:20:20 -0800
Message-ID: <8fab1be0-7ac6-4203-9ebd-975feda862b9@quicinc.com>
Date: Sat, 16 Dec 2023 11:20:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] wifi: ath12k: support default regdb while searching
 board-2.bin for WCN7850
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231216060140.30611-1-quic_bqiang@quicinc.com>
 <20231216060140.30611-6-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231216060140.30611-6-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PEkdUL6--pKxjbPK3Fy5kij10d8dCCqS
X-Proofpoint-ORIG-GUID: PEkdUL6--pKxjbPK3Fy5kij10d8dCCqS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=819 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160148

On 12/15/2023 10:01 PM, Baochen Qiang wrote:
> Sometimes board-2.bin does not have the regdb data which matches the
> parameters such as vendor, device, subsystem-vendor, subsystem-device
> etc. Add default regdb data with only 'bus=%s' into board-2.bin for
> WCN7850, then ath12k uses 'bus=pci' to search regdb data in board-2.bin
> for WCN7850.
> 
> [   46.114895] ath12k_pci 0000:03:00.0: boot using board name 'bus=pci,vendor=17cb,device=1107,subsystem-vendor=17cb,subsystem-device=3378,qmi-chip-id=2,qmi-board-id=260'
> [   46.118167] ath12k_pci 0000:03:00.0: boot firmware request ath12k/WCN7850/hw2.0/board-2.bin size 380280
> [   46.118173] ath12k_pci 0000:03:00.0: board name
> [   46.118176] ath12k_pci 0000:03:00.0: 00000000: 62 75 73 3d 70 63 69                             bus=pci
> [   46.118179] ath12k_pci 0000:03:00.0: failed to fetch regdb data for bus=pci,vendor=17cb,device=1107,subsystem-vendor=17cb,subsystem-device=3378,qmi-chip-id=2,qmi-board-id=260 from ath12k/WCN7850/hw2.0/board-2.bin
> [   46.118239] ath12k_pci 0000:03:00.0: boot using board name 'bus=pci'
> [   46.119842] ath12k_pci 0000:03:00.0: boot firmware request ath12k/WCN7850/hw2.0/board-2.bin size 380280
> [   46.119847] ath12k_pci 0000:03:00.0: board name
> [   46.119849] ath12k_pci 0000:03:00.0: 00000000: 62 75 73 3d 70 63 69                             bus=pci
> [   46.119852] ath12k_pci 0000:03:00.0: boot found match regdb data for name 'bus=pci'
> [   46.119855] ath12k_pci 0000:03:00.0: boot found regdb data for 'bus=pci'
> [   46.119857] ath12k_pci 0000:03:00.0: fetched regdb
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


