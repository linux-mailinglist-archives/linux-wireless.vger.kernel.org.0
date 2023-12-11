Return-Path: <linux-wireless+bounces-672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5354780D416
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 18:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7362820C2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 17:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D8B4E601;
	Mon, 11 Dec 2023 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D6rcwEmh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9AD0
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 09:37:42 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBGxMN0014743;
	Mon, 11 Dec 2023 17:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9P6svbHPe1xhQ2a5tmtFOScoB76jiukn6yl06BmdXNE=; b=D6
	rcwEmhxO1QDJdyXcZIrlbf2qSWpPA5I7V4rpt/w5tN9aIPp/Vpa4bXNtUm4L8Hs1
	ZvxT6ff3pa6/EfSlsp9mdjjYbGN5yeOqktiQaUTb5yviS7Z07H3fuCdr7XI7YkwD
	cgKWsbnlMhUxNpPPh1TME459RR6eJvXi+Vrjpf349FXD8jAodFZbjuW0AQtYTzqI
	4DugnV3Fj97TFr4NpUvxk7WFw3giT/d1+vECXTDeakjaRpxMB2T7GkThmHPyr0C1
	NtGKrFEjBkWGP3i1SvmXl+mtCgtFr1CBt4y9O4QBPXDGDyubpOfQE1OQwbSEHXq4
	usLIKRBfOtVv2FmQMIxA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ux25u0ss0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 17:37:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BBHbZA3015404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 17:37:35 GMT
Received: from [10.110.106.103] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 09:37:34 -0800
Message-ID: <f66bf357-f3bd-47e6-abc8-350332022cb9@quicinc.com>
Date: Mon, 11 Dec 2023 09:37:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: fix NULL pointer dereference in
 ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
Content-Language: en-US
To: Xingyuan Mo <hdthky0@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        "open
 list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>
CC: "open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>
References: <20231208043433.271449-1-hdthky0@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231208043433.271449-1-hdthky0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b2uF9TwZ0pmLlshCjoBg_EmFOyEqGiPh
X-Proofpoint-GUID: b2uF9TwZ0pmLlshCjoBg_EmFOyEqGiPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=749 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110144

On 12/7/2023 8:34 PM, Xingyuan Mo wrote:
> We should check whether the WMI_TLV_TAG_STRUCT_MGMT_TX_COMPL_EVENT tlv is
> present before accessing it, otherwise a null pointer deference error will
> occur.
> 
> Fixes: dc405152bb64 ("ath10k: handle mgmt tx completion event")
> Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


