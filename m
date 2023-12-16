Return-Path: <linux-wireless+bounces-861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6086E815B3B
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 20:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4027DB220BB
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 19:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC48D315A7;
	Sat, 16 Dec 2023 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aNhour+U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1C31741
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BGJJCWl029393;
	Sat, 16 Dec 2023 19:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VpRvUplXXT7dGa34wIr9GbUG2DDEmbPqs7UOjQeCgdU=; b=aN
	hour+U9gu1KL0vMyOAdMPGQXiaUPOSaic8uFZacHgVkjLeEk30I8Gbch9uVaxi0a
	p02V+x5l6zPkkGBe5tr8iemnOiCujFx9I91CHD8IrNfv1K3VKH/MdwXcgQoYQAdF
	oasErM+u9DBvcJLb1O56nyx+QsG1PiK6lDgVdJd+0ynKftzGULQ7xJUg/iauwFV3
	c4r50pxjKdhMxCzJgy+v8bCX2Or6XT9zhIUha0elngcgrDUBMzcDykMtzV+R1Ijs
	pbV6yVu0xdYu23kN8Soh0q9+C4F9b69w85CpqPj/4m3fh8i4ByGRAIEvCXFU6SJY
	WJ/zWu7RZsMeDPLrG7Uw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v1531s1gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 19:19:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BGJJBxr017402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 19:19:11 GMT
Received: from [10.110.36.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 16 Dec
 2023 11:19:11 -0800
Message-ID: <75bf6bf6-6285-4bd0-a925-17bbf6242265@quicinc.com>
Date: Sat, 16 Dec 2023 11:19:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] wifi: ath12k: add string type to search board data in
 board-2.bin for WCN7850
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231216060140.30611-1-quic_bqiang@quicinc.com>
 <20231216060140.30611-2-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231216060140.30611-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qV0dqKwS2wsprpdyL1_X1eOQeEkXOdSk
X-Proofpoint-ORIG-GUID: qV0dqKwS2wsprpdyL1_X1eOQeEkXOdSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=959
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160148

On 12/15/2023 10:01 PM, Baochen Qiang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Currently ath12k only supports string type with bus, chip id and board id
> such as "bus=ahb,qmi-chip-id=1,qmi-board-id=4" for AHB bus chip and
> "bus=pci,qmi-chip-id=0,qmi-board-id=255" for PCI bus chip in board-2.bin.
> For WCN7850, it is not enough to distinguish all different chips.
> 
> Add a new string type which includes bus, chip id, board id, vendor,
> device, subsystem-vendor and subsystem-device for WCN7850.
> 
> ath12k will first load board-2.bin and searches in it for the board data
> with the above parameters. If matched with one board data, ath12k downloads
> it to firmware. And if not, downloads board.bin instead.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



