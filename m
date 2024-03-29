Return-Path: <linux-wireless+bounces-5618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2B3892334
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 19:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539181F21A8E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2462E225A8;
	Fri, 29 Mar 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o4SjT6bW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB42566
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736248; cv=none; b=Dx7K2PR7pUHRZizDGfBsQ+uOJrrx4xB8JP1WmbXHvdWCQ8cVihnfQsaJ7shJ4hAxvn2HDn5pW+zWzBFk2JONp8V8DzXAudStio9QQxidkW263wY81A5PV9YPjElhYIxuQ8nmhOAqnQ6fYj2wDZfjsmqkxzR4X2H9N4gCc5JQUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736248; c=relaxed/simple;
	bh=Uckpucptc0pxG6H+7KU/xmV3gDtxmhA7GvL1k6e3Xao=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bkR+WeHsjFyByLPmSVoKmYTqlu1oxtmGV2LVcGpp6SrL5mMkyhok2uuro1kUr+KqscZemBxl22cy0pBl8X2Y0oWyoN6Kd6fdyl2S+TJNLTvHGkvojUUgjGQCYJ6dVYFr/qD6rNHZoevoYftEg4Glcog2fRnJ/uIEdCbKAsn79UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o4SjT6bW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THfJMI028878;
	Fri, 29 Mar 2024 18:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=muMVqwiyAAh7TZzR8UetaWk+MGxnU6dzQ9bp7G8aFB4=; b=o4
	SjT6bWqTiaDd+E/S6qo2W91+hl1lWvcTWAx8yJ1R/VQJFMK3HhwWXuuKUV6lqFQu
	VAFFDkzMK03Fek3mDNihqG2E8L2B+GNMykKlgW6a9Ht2L27NJgBafUhz3UrGcEjZ
	5a8xadjcqmyhkyMnv2CMYLN+xu9kqtbaHEHQFWgyL9hxKac23M0pnoit4z7u4yki
	Y9vVckenW6E3hiWZuFU9/+XLmPFi5JwC8CkuhUXWCXeOTrSYcXyrPP+tiVdiXcl2
	3mVBkKMf8f0RrsY1Lvvnp2G002FhMZwZZK9pEB02jIYASv/fckkEsval4rysbtOs
	lfG+w7Lz6/6jJqrsRmVw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5ybmreuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:17:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TIHLRk030962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:17:21 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 11:17:20 -0700
Message-ID: <913c8bd0-5b46-4b4b-b0e5-723d2ae6d0a8@quicinc.com>
Date: Fri, 29 Mar 2024 11:17:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] wifi: ath12k: fix survey dump collection in 6 GHz
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
 <20240329173926.17741-4-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240329173926.17741-4-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: slj8PFtQO7CvUt1CGeWrCUmaxrdKmNCz
X-Proofpoint-GUID: slj8PFtQO7CvUt1CGeWrCUmaxrdKmNCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=766
 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290162

On 3/29/2024 10:39 AM, Pradeep Kumar Chitrapu wrote:
> When ath12k receives survey request, choose the 6 GHz band
> when enabled. Without this, survey requests do not include
> any 6 GHz band results, leading to failures in auto channel
> selection.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


