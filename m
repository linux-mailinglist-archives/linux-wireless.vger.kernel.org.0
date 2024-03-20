Return-Path: <linux-wireless+bounces-5038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B508E8818DE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F6FB20E80
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4D285956;
	Wed, 20 Mar 2024 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XCKTgpEX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D2785955
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968261; cv=none; b=U0sLFwS+d78x8fZjkktYr64PoDoM/pPqzOrhE6ndIBOxGsj789Yt5MJiDLQKZ9bzjGcU3uAi/FQZ8JdVg5YdWE+WdN+4/5amY7K66vmuawEvgacuHz9HHcQ7jOQsaWtMLKromtkiADokH+93pSu+xMneQnrRloRIgkACnMDYKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968261; c=relaxed/simple;
	bh=v07Ftv5BlwTg81z0xkpazbVOEum4sRWn+QaW0N9meZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PTHnJVvuk0Nd38L1oLtEpE8a12Wpu6SQKMzpX6gZ/vuEyoRgDwO9eG4tHsZ0orZ76PALCZc+FjHkWn9ZEZTR/s5FZtzoTg5TN0A6qJASI7ieV47HWbDiHdO4SVy/BmKGdhzCmVg2o6c4qgLbLgzSwmhCCAEzb5csZjRtty9i5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XCKTgpEX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KJPuKG015927;
	Wed, 20 Mar 2024 20:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VeHxhxY2CVZBtS6JH63o1WCJdzxR5XMCgwaK76KzxlE=; b=XC
	KTgpEXMNnhEnQPuLksqJmcgMkwyngxrpWvRvkbMW17TggD9SDP+j6cMz0XysF+YV
	LS1D3K24euLWvO7Dj8JfwLn11GQx0p2QPl8Y8wF42nLS0l8xGwUd4NYLNOCljIBZ
	/jdfOE1I3eUU+D+YT6VzcRxFGGnvx6YVuZMPurN6+6N093GgHA0stRMBkqjnV+pq
	PM6NCUY7cEwG0rE9Iv0AauYHGuY4/ynkjCWeaBQN46VVWhRHkM1H9BTll2WEmGsM
	GXTN2XjOxl8DMYcddxRu5HGIMpHjb5ayne2rCC4YQJLU70M4dKh+V2X+1zdgTt+3
	Iuwmoo3TlaOWDFkv4/9Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wypxq2a0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 20:57:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KKvYdO026313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 20:57:34 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 13:57:34 -0700
Message-ID: <6f003deb-33c5-4861-8d9e-69da91d7392d@quicinc.com>
Date: Wed, 20 Mar 2024 13:57:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Add radar simulation debugfs support
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240320171305.655288-1-quic_rgnanase@quicinc.com>
 <20240320171305.655288-3-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240320171305.655288-3-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VrY_H23PtsfuhAGgrTpMuCC1bx6FMdQ9
X-Proofpoint-GUID: VrY_H23PtsfuhAGgrTpMuCC1bx6FMdQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_11,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200167

On 3/20/2024 10:13 AM, Ramya Gnanasekar wrote:
> Create dfs_simulate_radar debugfs in ath12k debugfs directory.
> 
> Usage:
> echo 1 > /sys/kernel/debug/ath12k/pci-0000:06:00.0/mac0/dfs_simulate_radar
> 
> This debugfs helps user to simulate RADAR interference in run time.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


