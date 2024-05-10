Return-Path: <linux-wireless+bounces-7408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151318C1C56
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 04:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D639B218F3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 02:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E713C3EF;
	Fri, 10 May 2024 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WuVaE8hZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D4E13AA59
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307444; cv=none; b=HGw4WX2wEBY+X3RW/DvXB2qq/ca7/VYlSiX9X3Qav4vY8eXcoKWT5RHxkQ3Nr9CyrkDGt0KRZhXZIf43EknfVtK7XCg67DBLfAycwAx25tLeiAo+6H0XAhYomXhrAYQGgqu+P33BeFk4mp+taa+2clfSJpWkumFXU5u+oiiIhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307444; c=relaxed/simple;
	bh=IoQgPRLD1s77e8UXsIdJVJEI7HT0+wZ+UcWDGCqP0wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cpV9OmtAXyv5+yJT7wCUwPcaQVqmva9i8mEtBAgiuYdwDBKyFYYIrc0VnneI/WzRhh8Z3M4YlXlFc2rV3VFrVYyJ6AZiagR8jTo3D/yNw6361pqWYcQoiPIOeGSFz3oCpJuiOAREZ8zWOYzHYpsqlaX0/YKgKp1Xire54BJN27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WuVaE8hZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A1B9qN009472;
	Fri, 10 May 2024 02:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gSJYZAo8a2uHwJFAkM3K6IvRn4Xj+ZLTAK+2F3Osuoc=; b=Wu
	VaE8hZIM8PtxVnXvEXUDKjHozb8UVOZ28EQgFTPc+cWHJuHsmXzBJAnYEHDz9pe4
	0sORG/1msczW7JvZ99J4C0Uc/2yOvZdBg2q9ImbuxInZhCSy5O646QXLbxf19eio
	64swzWECpk77oi0aoTO0V0ruf7BqideC4xPfqz7/6TYyE5RWW9fn+bVlUacrCZ8t
	87oVaneD+nrV3YcnnG5T76ZYq+uD4IE2gpvnyhGVeXGbRQZTJZCKl4fjGdtCGrUP
	Q3VPeWAovA6CbWjBIkLCfIm6WaskhTavVQiG0y1IhP24symIpATf+4cVF+oqCMmT
	Sb7GFl0/PfFaWkJcWBbg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w28bs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:17:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A2H76R026232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:17:07 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 19:17:06 -0700
Message-ID: <b929f311-9897-4fe9-b604-99e29ebaf13d@quicinc.com>
Date: Thu, 9 May 2024 19:17:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] wifi: ath12k: Introduce QMI firmware ready flag
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240507045702.2858954-1-quic_hprem@quicinc.com>
 <20240507045702.2858954-5-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240507045702.2858954-5-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DmNg3X-T4nfWzfkuq6IpJDM8GGCIEBg7
X-Proofpoint-ORIG-GUID: DmNg3X-T4nfWzfkuq6IpJDM8GGCIEBg7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_01,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=787
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100015

On 5/6/2024 9:56 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> When hardware device group abstraction is introduced, QMI firmware
> ready event of different devices in a group can be received simultaneously.
> 
> To indicate firmware ready event is completed for a particular device in a
> group set a flag (ATH12K_FLAG_QMI_FW_READY_COMPLETE). This would be
> helpful when hardware recovery is introduced for hardware device group
> abstraction.
> 
> Add changes to set/unset ATH12K_FLAG_QMI_FW_READY_COMPLETE flag for a
> device.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


