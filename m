Return-Path: <linux-wireless+bounces-11374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD43950CE0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 21:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C3C1F2446B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 19:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB6743AB0;
	Tue, 13 Aug 2024 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d3qwccqa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A11A4F17
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576135; cv=none; b=gQfzhUjms+7yN5kblZ42BWNnLcVqsIlEP5m4jWqjFb8EyvNWWSqt/zW8g1q8xvSvt7LZgvqff41Y6OXXDaxex82LHETyCn1Ddg8+WwvxIWlNqTpYdxpaZnbSroau7K30slIpUePDI5rwHYEKJD9dQRhThfQHg9+Yl2y/KzDqW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576135; c=relaxed/simple;
	bh=IwUaUPnTjrjqJdkYVuB8yKcauHs2emaI6rCrW/0aD+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ES+L6/USLmPycb25Yy/Kvaleoj9Mt3Cj1x6uoRK0RAydIUYmOEPZp00DlVbBCJpUhDZfTNVnl60Ym2qASkFNPTiUGl24GxfzFVaTCv9L7qmeHT4ETlpW0hO+Y6SQOLaNK0K+nlhelSh2zu/AxoRd8H09Kq1y9sCeTSvPaGdExnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d3qwccqa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DD6FMU031392;
	Tue, 13 Aug 2024 19:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0xlYExBQNqeO5jOeV1R+EJgCWyPDMyof71a0kXqDUFg=; b=d3qwccqa6G5H/Wn1
	x6dE+HfEbB6sphdW27Lf9ZPuVu6j1irOg/omZRc/UHHsTkIOxIJSxmgHTAS0ZgmY
	65DPVZ/BRQavHUF26XxWtB8enRBOlI7LTAW8rRmc+pK+yhpDrBGHMclPj8/ofJ7H
	4OxXLqbGqGq/SiGAZB68GnsT2RElFKJW4Qy0d8KQvmzBPI+DcV4blJzHKZKeO4Fn
	SWGAP0lAdA8bBIXjejKD41Yp1hvYAYYKINle5z8MirdGziO8SdXsmOGJxxCpJ4sD
	awVCs5YAlkcdlvBtgPqFAmg8I+Jlfmw5mPnh205W4tqtIATE5+bx//1vBE2asl/c
	+IZPYw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41082wh07j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 19:08:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DJ8pWk026369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 19:08:51 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 12:08:50 -0700
Message-ID: <79eb8270-4109-4bb8-9890-e5c59765f848@quicinc.com>
Date: Tue, 13 Aug 2024 12:08:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] wifi: ath11k: use union for vaddr and iaddr in
 target_mem_chunk
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240813013028.2708111-1-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240813013028.2708111-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MckKw8YHozQ_xg9awsV2amtYBCIm2_go
X-Proofpoint-GUID: MckKw8YHozQ_xg9awsV2amtYBCIm2_go
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=668 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130138

On 8/12/2024 6:30 PM, Miaoqing Pan wrote:
> The value of 'ab->hw_params.fixed_mem_region' determines that
> only one variable 'vaddr' or 'iaddr' is used in target_mem_chunk.
> So use an anonymous union instead, easy to check whether the
> memory is set or not.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


