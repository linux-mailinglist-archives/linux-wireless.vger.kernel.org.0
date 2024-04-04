Return-Path: <linux-wireless+bounces-5882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB0F898F1B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 21:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6106D1C2281B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 19:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37229403;
	Thu,  4 Apr 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cVfDSgp0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84274C14
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259441; cv=none; b=gLMQ2wTRrdJO1pbW/9evgdBgLBJaLvW6YJyenTnrMoHs3O7F7uPePAJL9Z5bebcnClipbq5EdFXv3QYxwBcl4j7Ti9WQM0GFziuMfUmE16HdOEj9M9K9x7gAbmz7laj5C6arICu4J5xeioV5xbNb7UNy3Fn0iR7r8SdnSRjFMJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259441; c=relaxed/simple;
	bh=SKhU7pjb5MIRqGlA+iIVfRLQO+UCoFOvAo6DIruwIBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IHgqlx8hIzaoXfs8Ewxbt7qi7PHL/xzUv/Z1FoOMFh41KwoK0h3vEW/HexmYlIjuA2jWk1fAPhPUdWEO8T3eoAcovg3S+R/jaIleI3ptQBLaKdmmzZqTN8z73B+q9by9Q1EDMz14yO1rWWgFE6Fk+ZPMXQY4sKhp/wxVud2D8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cVfDSgp0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434IlR5w012879;
	Thu, 4 Apr 2024 19:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SKhU7pjb5MIRqGlA+iIVfRLQO+UCoFOvAo6DIruwIBw=; b=cV
	fDSgp08JMBxMVpiZwLhugRJiRojWVEOMwpPbe3X+X2cV+aHxIjVyArpUHCaxwUEZ
	mxXrys6NDIPWqeYfTeFR0c1q/2715/rq+paANGfTvLclwHAA++WPGZKdMGuAZcCV
	od01frgFi6e8CGdGgqOzIIYxzcmQrv4ko4su2MY2S/c8b1JRuH0gxCUw+shPq9qO
	xvB9PBvGxGyabhjWYX+Fz8QhbCjnzrwqaz/eyQkG6H3LhaEkd31yiNCe+F0q9Thn
	FCf5QPJPtEQTY0sNjq/ZygILlyEjjoMGQ68U5w3iEu95ZrYg9oGNoWcgxKFNyOcy
	y0+1OQaPw1TdmmkO4Zxg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa1gx8421-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 19:37:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 434JbEa3023999
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 19:37:14 GMT
Received: from [10.110.127.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Apr 2024
 12:37:14 -0700
Message-ID: <0ec145b0-b10f-4a89-a905-0bc804403f38@quicinc.com>
Date: Thu, 4 Apr 2024 12:37:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] Add Multi-Link Reconfigure link removal support
Content-Language: en-US
To: Manish Dharanenthiran <quic_mdharane@quicinc.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240404185950.776062-1-quic_mdharane@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240404185950.776062-1-quic_mdharane@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: POAtwMBrOKvq8CAqE4JAFa72NI6mJId1
X-Proofpoint-GUID: POAtwMBrOKvq8CAqE4JAFa72NI6mJId1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_16,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=469 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040139

BTW for future reference your subject should contain both PATCH and RFC

https://www.kernel.org/doc/html/latest/process/submitting-patches.html
"The summary phrase may be prefixed by tags enclosed in square brackets:
“Subject: [PATCH <tag>...] <summary phrase>”. The tags are not considered part
of the summary phrase, but describe how the patch should be treated. Common
tags might include a version descriptor if the multiple versions of the patch
have been sent out in response to comments (i.e., “v1, v2, v3”), or “RFC” to
indicate a request for comments."



