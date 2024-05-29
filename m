Return-Path: <linux-wireless+bounces-8280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13FA8D3E96
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 20:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5EB28443C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 18:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15311C0DCC;
	Wed, 29 May 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JUMeHRpT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C915B139
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008869; cv=none; b=VDskmax4QbuVKzInO7nzNlaYhYsmrk92KYK6tdogJJmVY0xzm6lUxRoGrj2hcYayuxlhLhuwi+dIqPBDkxcipwqZPIbUz34tqv52jCHNWPa+KDfaO+4RBtrBAaiD2cowRrcBFpPFI6gfvYzIRh2TM2NYibhTyJYp8jd2xZLTTIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008869; c=relaxed/simple;
	bh=jvHGv7yAEPAO6IHge8Ay1jmGYAJ44Y+HGkMqvbgIEz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p141TWJRdxUS6NHH7iBg5nKW84HcnjgOy64WEArsTH6VKRGdzU1W6gs6vPTEvEBhb8lqVO/YBcRzBhIYlm3spj3qPxkaZFIjXuJ8F6BzNAal6FZguoMlOhi9w/H4Esv6EXz4rt7cL4g7QPjcCeTotlrshXsxc3V9rbbe0DTHYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JUMeHRpT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TBPRXr005587;
	Wed, 29 May 2024 18:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kujre1iGGAvnBM/XAmXTj7gERKqKCqvQXUoL/RtiuBI=; b=JUMeHRpTE6bA2HBg
	GRWmDCfZGaF8OTCcd7hsRN+uzz220echYrbRjNkxWqx7hxzJYoaOanV+pKDtn+at
	ny/g8fx6ru9FeFRlsk37lu70vpBwpIC9IsFL5k0fH12rdlLT6Y7rm4ZTVj3ZLwag
	+4ojAUtMxITDhycedVrpCVqGUDtRfgoeuPCY7Vj1VKD7was2QkgWUnaGbXhI5OxJ
	QzrQ8U7ngO6bZlkeCHtLhwSx2GTfEg5CynQZyrMhKrX3HdJSVDRFDe0Kb1KR/+op
	AB8UsWhWcc9LVMoyHq0Nz7U6qWsCTKqZ3OpyjcDSEArlEPV53cZ5gJp2r07+8bvX
	5MbWGg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0xa28a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:54:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TIsMoI019545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 18:54:22 GMT
Received: from [10.110.109.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 11:54:22 -0700
Message-ID: <e78c215f-4d6f-49e9-ae06-97b21ed0c273@quicinc.com>
Date: Wed, 29 May 2024 11:54:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath12k: unregister per pdev debugfs
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240529043043.2488031-1-quic_adisi@quicinc.com>
 <20240529043043.2488031-3-quic_adisi@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240529043043.2488031-3-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cXUFwGkIJHq2NgD_PkngALVzd9PPjrdF
X-Proofpoint-ORIG-GUID: cXUFwGkIJHq2NgD_PkngALVzd9PPjrdF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_15,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=771 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405290130

On 5/28/2024 9:30 PM, Aditya Kumar Singh wrote:
> During normal de-initialization path or if any error happens while
> registering the hardware, there is no support to unregister the per pdev
> debugfs. Add support for the same.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


