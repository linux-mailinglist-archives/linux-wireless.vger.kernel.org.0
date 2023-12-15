Return-Path: <linux-wireless+bounces-819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC4813E85
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 01:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E1EB21BEE
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 00:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446B0624;
	Fri, 15 Dec 2023 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="STN7tYdg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC43651
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BEMbKd3018845;
	Fri, 15 Dec 2023 00:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bCfpqLijhcVpngrnOkXrgFBObRdDHBJqb0489W6qtPk=; b=ST
	N7tYdgoWy5lYMSNskq9EBe9NbqDZT07t4zED2DtKCAMpvpx9BIfVIwlZD3zxkEY3
	sPVOVWMfodtpjF8ETKC+x69TwT/BJRm8EVUpLVLRa34Oxp83l6JLdKkylp20idsq
	7WrhJOGl3nCqZ76AXJZ/bzZzIs84ohTZJXlbXWIBQd3uRPlu6fir5sJeQW+hqDu4
	9npsA+dAzXnBOCQ0u+ywYABaQaZWbxm35wkbd3l+8kFURtPvsqW5M02P9lVL8pYM
	5cClbEhFjtDDjoe+lD6rQXvhvogy5Vz/f4zVtqG1mrQ4N7WpRJeyPEx6MvzoRApL
	zvkQuVjkTt/vN7qwj33w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynre2gt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 00:05:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF05cus013440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 00:05:38 GMT
Received: from [10.110.36.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 16:05:37 -0800
Message-ID: <f605a94d-64ec-4c94-a33b-b6f417a5f5ba@quicinc.com>
Date: Thu, 14 Dec 2023 16:05:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: refactor ath11k_wmi_tlv_parse_alloc()
Content-Language: en-US
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
References: <20231214161117.75145-1-dmantipov@yandex.ru>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231214161117.75145-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gy_bUnH5kUSfJG65K_Gw8ajnbc9VoMpI
X-Proofpoint-GUID: gy_bUnH5kUSfJG65K_Gw8ajnbc9VoMpI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=279
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140169

On 12/14/2023 8:11 AM, Dmitry Antipov wrote:
> Since 'ath11k_wmi_tlv_parse_alloc()' always operates on
> 'skb->data, skb->len' tuple, it may be simplified to pass
> the only 'skb' argument instead (which also implies
> refactoring of 'ath11k_pull_bcn_tx_status_ev()' and
> 'ath11k_pull_chan_info_ev()' in the same way). Compile
> tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Please use scripts/get_maintainer.pl to get a complete list of
recipients for your patches. You have omitted the ath11k mailing list,
so folks who may be interested may not see your patch.

%  scripts/get_maintainer.pl drivers/net/wireless/ath/ath11k/wmi.h
Kalle Valo <kvalo@kernel.org> (supporter:QUALCOMM ATHEROS ATH11K
WIRELESS DRIVER)
Jeff Johnson <quic_jjohnson@quicinc.com> (supporter:QUALCOMM ATHEROS
ATH11K WIRELESS DRIVER)
ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS
DRIVER)
linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS))
linux-kernel@vger.kernel.org (open list)




