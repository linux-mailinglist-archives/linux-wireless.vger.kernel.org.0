Return-Path: <linux-wireless+bounces-22149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 396EEA9F5AF
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 18:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A19E3B515A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809FE27A912;
	Mon, 28 Apr 2025 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RSoXAM06"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7725F97D
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857354; cv=none; b=AO3tYU95eEkp7fGsfLi+Rgu+FGTbei5mAw1Wh0ptVQHEQT2p8TZDzqAmGfgWS/PB8M/flMLNidBbKni6XlnGB7poixVepsTZAD7OSoTer8t5EirXR9YsWSZdYYeYKfv6exwbyz2Q4hSzM+IqflKyWuXf98hW329TB6d/1recswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857354; c=relaxed/simple;
	bh=WzfOIRqiueBlf+BEz4QRkFiXBrf1Bz6n/t1n70gYBFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R8F/OfW96/nAbz1CIactZCBsW1hl6WaiWk5fqRt8QCqX5pYwfpxGMSBtpNuXJAdz6ELwgYvOZO0CY0+LqSKfD+uHiE1ZQ2I/wOppyZnFOhdoJOPqQijZcX8lrC4cPxLq6i3MLR4p9BN9UxhuG0FC1kCiCkevaE1e2SgUMZKXQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RSoXAM06; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SFRUet012420;
	Mon, 28 Apr 2025 16:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UQX8Km6BdISNVtiSF1719b1ABZb9Sbm5kArtary2bvE=; b=RSoXAM06Sfie94FE
	O1mW4tyITfDSQHsbzZ4j49Dc35MIAakevOTh0WUSmS6jT1TPwfuLYfgosBIiIqBB
	MdNg6PsBSEXiZKklE8vCX3jD2EnByfVLJSL6oYez6W/FYFQajEL9LT55fHkOy7FR
	r/pQJrWcAY7HRe9tGgqzm/9unhzFrJmDHuXetrApUn3/cAknb9g4Hu3jtn6lkaE9
	lG/yUSrNuwHDSBarpAJy+vQWVpU6+LQLPyDxosr0yi1Soxe4HKJBGbVAWm2Il2mU
	g8xZFCrwvxmyUcJoE4nonfg1vOm8ZGkhPdk3fXS5wpMOPWhGAsV1GNhcVm/oPRm+
	su/s9w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468n6jh0p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 16:22:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53SGMS1d012107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 16:22:28 GMT
Received: from [10.216.5.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 09:22:26 -0700
Message-ID: <4bc1535a-8b1c-44e3-95f1-971fb3904c12@quicinc.com>
Date: Mon, 28 Apr 2025 21:52:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v3] wifi: ath12k: Abort scan before removing link
 interface to prevent duplicate deletion
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250418064008.7172-1-quic_lingbok@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250418064008.7172-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzNCBTYWx0ZWRfX7Dhw0HoddoCd 7xAZW6ZtKscjNtOsDpBX/Kq+BBxiVqe0Xf1VueL7zArLy1Nukn9nj6yKKp7sxfyhzVuzlAbHTnF 52anQFhB7bVw13lyksNJBdMwCqvj7duPi437YTifhO0qjZtt0yIBK3buxmF47tePHgmXs+ZJsBA
 XO5a5LBsWNa4nkNCuj06sxZ4XrB/brV4dBsVh/l0hW2KyTaI4+kYrI3NrfWtwcp0pt/hN/ehx6h ElOtK9XQUBUbwnvRscxSnjarnStjxBDjti9rWY6VHZ6POdJIE2Ydc2YIgab4UKcZUki2SeLgDg/ QmnSSc788CDCUZo+wUUui1lkCmrwmXiO+Ol1LpuYnBTe/u8I8LZEDJEXRRruxizJpF4sAyfDV5G
 aAkswT9E1Tsa8cIk3Jy9m8pWgKrwVxmnJGC2D1omgHGjIUlb+QhJ+EeCziK2J3lqowgnTwNJ
X-Proofpoint-GUID: TKbFS-zbiH4Ftk4ghuW3QKD5TwTreotc
X-Proofpoint-ORIG-GUID: TKbFS-zbiH4Ftk4ghuW3QKD5TwTreotc
X-Authority-Analysis: v=2.4 cv=C8fpyRP+ c=1 sm=1 tr=0 ts=680fab44 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8
 a=DIK6_-D7ZKVO2JlVqWsA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280134



On 4/18/2025 12:10 PM, Lingbo Kong wrote:
> Currently, when ath12k performs the remove link interface operation, if
> there is an ongoing scan operation on the arvif, ath12k may execute the
> remove link interface operation multiple times on the same arvif. This
> occurs because, during the remove link operation, if a scan operation is
> present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED event
> from the firmware. Upon receiving this event, ath12k will continue to
> execute the ath12k_scan_vdev_clean_work() function, performing the remove
> link interface operation on the same arvif again.
> 
> To address this issue, before executing the remove link interface
> operation, ath12k needs to check if there is an ongoing scan operation on
> the current arvif. If such an operation exists, it should be aborted.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

