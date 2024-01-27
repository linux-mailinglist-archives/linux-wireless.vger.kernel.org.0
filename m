Return-Path: <linux-wireless+bounces-2584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F1483E81F
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 01:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100AC1F289F3
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 00:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8804E15AA;
	Sat, 27 Jan 2024 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YtvSIEh9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8DF138A
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314626; cv=none; b=Yy8jpj+c1SiBgmAu6tF/YLRiGRHkkrAnOSDwqGVl3ycQza/oXljqJSmW+tuVwj8OYSbY3Vrg6BRQtn8ZPlKiyf3P5TSM/KLJ0nVt9h3D8Kx+YkoDJTVfL48+PJzMt2Z0AFx00zVSOx0THkjiIW/Frj6zeS+gfUoEze9mGxg6/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314626; c=relaxed/simple;
	bh=z9EKlMrBlYn5DhICFRPKRZKKRdYZkQ+Y1gIup72cw1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n8nang3ZJDfwqzR4fBZtxeH0B6IwFZ+XVfKTwMbu099RcqmNUCxT2aFSbp5/NfnR7PcGkQe83Gte4IG/SJ6KWCakTz+0xVxuDXtkpXmhqwiCMueud0MK03F+hu5qsq8iyE9BUSFsggrhzOwI6jX6aR2z2y1VGrtRjQElAC8QWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YtvSIEh9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QMx7UG020906;
	Sat, 27 Jan 2024 00:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5eBECWCDxYEA54enC1/hrGb/7yL0uYCC1cetVUWAyeo=; b=Yt
	vSIEh9rwTrO+htCSciBbxUq07wnAXOKTLfxDDuJsA1VPZkUUc+xlvUxE4p7VIfpt
	keFbYFJOABabtrNPH/6HNKAwwKNEM9E2VvKFGjl2viIkkRBL+A9OaIgZM0dX217I
	8vKaWHxSIQS31bJAJQ5fSr57JPpw5UpDfIFLJFhWJTPKcpRVzrPkox/XRdMG0gCc
	inlmV5JOSXDHKi1Dy7DlGnSILeyDy+VImNJsPExQ8s7O7Sxmtp+YG1aJCJyzpjeC
	8NrjP3AOB9xNDlJpt9W+5ai0l7xmJ4xyUkf2iRmIVwZvEceTsMvS8rawf365oxks
	RHyQ5YgPCwW2llM22Sew==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvjbg8haj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:17:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R0H2BJ001607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:17:02 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 16:17:02 -0800
Message-ID: <ed00c5b2-1553-4d3b-8a80-07ba82b8f1e7@quicinc.com>
Date: Fri, 26 Jan 2024 16:17:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN
 from 256 to 512
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
 <20240126115231.356658-6-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240126115231.356658-6-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q8XqwxlbO9Vp4Wf3hycqbjzpAPcKKvMA
X-Proofpoint-ORIG-GUID: q8XqwxlbO9Vp4Wf3hycqbjzpAPcKKvMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxlogscore=850 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270000

On 1/26/2024 3:52 AM, Kang Yang wrote:
> Mac80211 needs more space for P2P scan ie in P2P mode, 256 is not
> enough, resize it to 512.
> 
> Also delete the duplicate macro definitions in wmi.h.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


