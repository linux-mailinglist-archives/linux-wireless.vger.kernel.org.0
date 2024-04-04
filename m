Return-Path: <linux-wireless+bounces-5877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D063898B5B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0933D28E5D4
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2B41292F3;
	Thu,  4 Apr 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pzki+MiM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9E763F4
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245414; cv=none; b=GzowfBpzLSX0Rf8101CQ8i0a4fq4SLY6/prxZKuI6eF8P6amyPTkSIqeLrZNtsMQA6FhqRWHqNy3rTNB9OBChzJsSD0eWpnWu9fnC/v/M1Lavwn3xozvtOs1cg+zvJjDpcfFkkYMZ51bX0RSVehl9H70IYwPC6oQ20+PoN5uhgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245414; c=relaxed/simple;
	bh=1yRLdSXrY/apn4lPkqBVP87GJ+x0r1mkv5ul2MSjU70=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mrpgtdskv8Y1c1UXRR8dvq+KMchkcfYCO/y8pCFexkspOcxqMpIJNkGD3uQiIZyy8AVz7LbQeCh2QWgkhyKilkZ7ieNIytegEjDMnNjEgT0lWoYbaDT4QSd1tTEXhzv8V8Y0HprvYRinli1dOC4oBlJjPHiDryJWXaU/HlHWzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pzki+MiM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434BUPHI017241;
	Thu, 4 Apr 2024 15:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XzUKJ+Hn8Ux1niJRQ/AsBQ4v3JQrU2RMU9q9X+xWbQk=; b=Pz
	ki+MiMNcfE1SXh5HUYp9uX3+F2K05bjMhXdD+WQRIk9g3AR10A+SFu8BCS4BBrIW
	kUZL4MWhBEMQ5CvJqKcsGmQzocuh6Pcn0tg3weOoXp3U0CkJ3ChKq+EYEK5oL12l
	8K4T58g6nH11GxGQu6qPPONfEdy2PSA/nJO0o2Cad77BfmyQPv6zOoLr94tMIcOU
	Ed9R6VoHJz6ojZpnm6wyzU7Tsqf7pthx0wYRmUXsOzCwHHaTrmgAHclu4XDegvZA
	DiksDbeX1XLj4MRc4TZ5D1Krv30wL/TSt/bhDywH1N+04E+8LJSHNiRHOYPL68JY
	4xQ/EPYY6+2xBGokzePQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9ep4svjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 15:43:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 434FhLWw032731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 15:43:21 GMT
Received: from [10.110.127.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Apr 2024
 08:43:20 -0700
Message-ID: <8ebbfc59-720f-4137-8aff-2014c33e7ffd@quicinc.com>
Date: Thu, 4 Apr 2024 08:43:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: fix mac id extraction when MSDU
 spillover in rx error path
Content-Language: en-US
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240404141538.1277258-1-quic_nithp@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240404141538.1277258-1-quic_nithp@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: w_KQNaRISUiS8RmYEBe_37IDe96AYAxp
X-Proofpoint-GUID: w_KQNaRISUiS8RmYEBe_37IDe96AYAxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_11,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxlogscore=272 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040109

On 4/4/2024 7:15 AM, Nithyanantham Paramasivam wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, in the rx error data path, mac id is extracted from the
> last 64bits of MSDU end description tag for each entry received in
> the WBM error ring. Then, each entry will be updated into the MSDU
> list for further processing. The extracted mac id is valid when a
> single MSDU is not fragmented and received in the WBM error ring.
> 
> In scenarios where the size of a single MSDU received exceeds the
> descriptor buffer size, resulting in fragmented or spillover MSDU
> entries into the WBM error ring. In this case, the extracted mac id
> from each spillover entry is invalid except the last spillover entry
> of the MSDU. This invalid mac id leads to packet rejection.
> 
> To address this issue, check if the MSDU continuation flag is set,
> then extract the valid mac id from the last spillover entry.
> Propagate the valid mac id to all the spillover entries of the single
> MSDU in the temporary MSDU list(scatter_msdu_list). Then, update this
> into the MSDU list (msdu_list) for further processing.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


