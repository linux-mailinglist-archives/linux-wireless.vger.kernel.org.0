Return-Path: <linux-wireless+bounces-7483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B38C2967
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 19:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9761F2244E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09D618637;
	Fri, 10 May 2024 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mxiUFG5W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C618E25
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362778; cv=none; b=cV9e7kEz0mgSZ8sUFnsi2MswIFb7R5aVsqn5G6MuZzK8joAsapP1TlgyOZ4Y7eXh4tbPCUH9SdzwToEyuIJN2rJKQCaOc1mUQMPwIW1mrJN3zqI0ACuz/PWzfpC+vIW7nxwXjlZEdJ20zMtYHhQCYKI2pWBWP14TL9U6f4eAImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362778; c=relaxed/simple;
	bh=7ho96LHt5WCEol5+08wCjhMLBRWv/03T/PIYQezWR6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B3XhGq838Utb3dmlunLyBGHv6DZicWDA4sial1ym5080vtfCPJamz+lFCPabOZ32u0KoCIu4mnJA9oCfbbxtuYW/ou9eA7V97LfiFaDyWW1J/iQ76moGQVyuSSPtwZ3pEWX5WIA8mt/8ciK1CS9Bn6ilFOd0SFMMPJGfP+jorYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mxiUFG5W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AE4ngt014161;
	Fri, 10 May 2024 17:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=p+Jbz2wIHBI3u1yvRXxSS7d8VkUotTr7CQxhlfREK/A=; b=mx
	iUFG5WD5mZh6qmZnn08fXUV3V3gTfOwQVY8oa4LB+FLSzD4PpK3ZoSsnPfjohuGr
	wG4ij3xeKsowb8UrhNdMB+yzYlvZ31LLqjt2d6WJh26d7ljT2vXOetCCugqAzGUD
	Ik503WhPPwy7PqxpTjMcY3Uyxst63S9UpYSC9zVjULTam3CQpWchXl2mgZSeRbIn
	JShb+9YlCHiHTci4Svgr+Ps7XbiZxV1II2Lr+noWkIQAgL48JIZ12CmSSqCADDwF
	k0SZN5P+CWUqgXRIVzM6Yyzb48NUYTNO8/h5nQx3vYLcsX2jkQMJIjnDrxo7okhw
	FC/QggTkiWoeOApPaK3g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w2a4j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:39:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AHdQSQ015193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:39:26 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 10:39:25 -0700
Message-ID: <ac5226bd-4094-420b-9d22-f3570105ddce@quicinc.com>
Date: Fri, 10 May 2024 10:39:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] wifi: ath12k: implement WoW enable and wakeup
 commands
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240510064748.369452-1-quic_bqiang@quicinc.com>
 <20240510064748.369452-2-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240510064748.369452-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jgM_yxHBhORcqHNEKd7arkRatIu4rf_F
X-Proofpoint-ORIG-GUID: jgM_yxHBhORcqHNEKd7arkRatIu4rf_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=543
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100127

On 5/9/2024 11:47 PM, Baochen Qiang wrote:
> Implement WoW enable and WoW wakeup commands which are needed
> for suspend/resume.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


