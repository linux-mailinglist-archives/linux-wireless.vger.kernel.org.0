Return-Path: <linux-wireless+bounces-8761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F11EC9025B1
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42151F279C0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E720A953;
	Mon, 10 Jun 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NVObN8tZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6312FB34
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033481; cv=none; b=CRlMlNdSd33RDao9vedt11It85Jfyb8quv5zQh+PjAehlUPgZ0DTdPh3LVSHCsTzqdPt1wHVXJUB0o1Taj5UnQ2dmzha22kcvNqWoXZSPZRSmKgexb0Ox/mp9CgBTCuc0fhX+09C7XxYUBitk+41G2tnWyQHkjsSKyFKPo4Gi+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033481; c=relaxed/simple;
	bh=ECkkJGqfVo9EhKLUbJnZO/RwKpfaGNO2WDORpb3WdpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AMgoMBHkVkoIYDg+4U8Xh3AaELJjH5NuSOtDNuh3fvyyHNLIgg8P0dm3eNnFBnWN2/Cx9khkZUIeK5qqFrw8j90PuSzMVMQvjCw1EIKzlzrKAmwYhQDRPguPx8+dqGnqRkJtVB2Qrd7B1+CgAnCS0WLAnL5dExHOk8W52ZoN8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NVObN8tZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AD5cjO027696;
	Mon, 10 Jun 2024 15:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zqNSpOGPtweJMOZM82XmSdeqHOnuvDexS4PJsuoyWVA=; b=NVObN8tZpU8m9mAk
	ghGolyKa2zvDlMBBrhwgBAFezJ0XbeemiZWnFo3GQkLamiH/iuxnvrmCsRrVy0Vq
	i17oxtUlOU3/vLoV+cr9nO/QwqIEtVuY1D3KfeDfUg8pHv7lGcgTumg7AQ22PRtb
	KaY1BXIHPCxfcjLB8YTdn+YJUUOE65z/8XAJizV3+OrxuLqyGU9tuVkQaGttvHut
	k9LHW24ji59S/KeNE30+/1nDG3x6jc0XYPoDAn5WH9FIcdOPpfWUVXYrouEYK1tE
	+2wfByJFuG7loTqyDoegWAuac9+TF5Jc1+ToWjcgX+NW0DdRYPLrXx/3S+QASCn2
	+fcbDQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfh34gub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 15:31:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45AFVDV4032086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 15:31:13 GMT
Received: from [10.48.242.196] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 08:31:12 -0700
Message-ID: <30d1fa5a-2cc4-4ecd-880e-b7177a8eed1b@quicinc.com>
Date: Mon, 10 Jun 2024 08:31:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: modify remain on channel for single wiphy
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240528082739.1226758-1-quic_ramess@quicinc.com>
 <878qzcq4uc.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <878qzcq4uc.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Sdht1dIbYyOe5nIKzP8u35SmpOYSL3av
X-Proofpoint-GUID: Sdht1dIbYyOe5nIKzP8u35SmpOYSL3av
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=524 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100118

On 6/10/2024 6:56 AM, Kalle Valo wrote:
> The pending commit here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=9b4ec32e921b34bd7a03d39cc0a75cba7e85dc02
> 

LGTM

