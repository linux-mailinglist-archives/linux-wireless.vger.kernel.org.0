Return-Path: <linux-wireless+bounces-5981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A8F89CE61
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 00:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B5F1C22C79
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 22:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A31148FE3;
	Mon,  8 Apr 2024 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XL0k2R9q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569F149C62
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614649; cv=none; b=E9/lvww7eT2hUW9XyGKDtaJh0mmDzVsBmA62zk6QDfsybbeNxU27GQss/J0yXHAtumaiRH8YtIzQKxnIruBn926fJjATxKCLwMNM6BmRSOwdXmCUWME3RrdJZlZV/DpM1oYyaIQoLpT/6jCIcT47oiCnD88Z6nbAcgbSv7BbAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614649; c=relaxed/simple;
	bh=+6cXoo4wM7x8bYsoKK5icwNX+vrnwnf0rsZcvVWB4a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FbWKmE7/YeXInPdG8MGrwr1muvR5mhxKEb2AntqQ4F1/qGAWf/gzw41Esy+4E4oLuyWwSbGUfZ43i0uni7giI1k8uhiwiN9TzdSq2cbhZ3Efic3BgAUSwi8VQHGDa8IwwZsszlfKQ0enUUZtgzhsQ/wUKqfIKhR3+KIQajxmF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XL0k2R9q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438M9xhS003684;
	Mon, 8 Apr 2024 22:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Q1xjPnwoxxLm+hY+vcfsQYj8ICVNKy3zUEywdLZT8K8=; b=XL
	0k2R9q86uTeZ5IYy5ZpI5++iKnKTlrm61DVXho5fQwQFlpf+RuXFASsz93/OIbCa
	9kvsSJBIwY13BRBqh2XuuZ2U8Fp24gLXviAwELxXGiYSstzcxELxenLMHmy27Soj
	QdyHq00xe5CKM31PlFjK3eA3ARnXENuEU/eMZfEfisN8drVKbY1rzDzkxjnPU8jX
	uM9Qok0k68Pq4XMyQ4JW+WedIiJuE93cPxUIwzQ2WF/Wy3HHjToxgBB9MdPzf29r
	83rpnWKznyXXw0NTV6B3UVtgOjBNYKaEL430PCgFIP0BFeUUVpuZHkQeQ1/+I725
	MKD6VIRIeHTL2YUj34IA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbfyhymw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 22:17:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438MHNcC008813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 22:17:23 GMT
Received: from [10.110.80.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 15:17:23 -0700
Message-ID: <571f5a84-f7ae-449c-9670-8574da28da79@quicinc.com>
Date: Mon, 8 Apr 2024 15:17:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: ath12k: avoid redundant code in Rx cookie
 conversion init
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240408040547.837639-1-quic_periyasa@quicinc.com>
 <20240408040547.837639-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240408040547.837639-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hg2PeXEHahy2D8-Z6KY1CoNwG0pM7x6j
X-Proofpoint-GUID: hg2PeXEHahy2D8-Z6KY1CoNwG0pM7x6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=699
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080170

On 4/7/2024 9:05 PM, Karthikeyan Periyasamy wrote:
> Currently, in the Rx data path cookie conversion initialization procedure,
> the primary page table index (ppt_idx) is computed within the secondary
> page table iteration. However this is invariant, and hence the ppt_idx
> should be calculated outside of the iteration to avoid repeated execution
> of the statement.
> 
> Found in code review.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


