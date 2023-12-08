Return-Path: <linux-wireless+bounces-563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB951809716
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 01:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074A91C203AC
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 00:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB7A28;
	Fri,  8 Dec 2023 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aYkEqK9k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3871716
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 16:23:02 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7LtbNE006399;
	Fri, 8 Dec 2023 00:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+8ZzvxzPr/MezNcUbjarSDHvvjVU7bO3w3ZCSVYgJMo=;
 b=aYkEqK9k6E9DUXDEzPnZqbUoP4kJkowefYTUIBKZ4EAo+k8SxCHQ68JylF30QPJeYZfC
 g/vByKUeHD9xsZNWjFT1QVLNxbTqPkMCXuhTVlU2nQtQSR+dSyI24T5juAMsQSVC5THs
 L9PW0lxv2uIrFR+uCCdAFxroK43biF8sC4u0676Q/IbVz6ogvBCC9T5nJVFFV2dBxRB9
 +MD1TgoVfieU+sqMjxfeozIaBKUHy4trun1RIPzHKCuutklYnVIigYLbwcOBnCjdMCHc
 XMQ59wawSKMbrrFGC4Ns51JlwEtSB1S34ThkXCMGlFA8T15/N+23V9y2WbLe3N84yjWW HA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu0w53c5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 00:22:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B80MwRs004653
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Dec 2023 00:22:58 GMT
Received: from [10.110.111.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 16:22:58 -0800
Message-ID: <b629f75d-9726-432f-aefc-053c85809511@quicinc.com>
Date: Thu, 7 Dec 2023 16:22:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] wifi: ath12k: Refactor MAC setup channel helper
 function
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
 <20231206034920.1037449-4-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231206034920.1037449-4-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YkJvC11MOeRij_qcQF2nPoWDhtiqnqfx
X-Proofpoint-ORIG-GUID: YkJvC11MOeRij_qcQF2nPoWDhtiqnqfx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_18,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=427
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080001

On 12/5/2023 7:49 PM, Karthikeyan Periyasamy wrote:
> Currently, the MAC setup helper function is accessing the mac80211 hw
> data. In the future, to support single/multi link operation, need to
> decouple the mac80211 hw data from this helper function so that it can be
> easy to scale these functions to support single/multi link operations. So
> remove the mac80211 hw access from the ath12k_mac_setup_channels_rates()
> helper function.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



