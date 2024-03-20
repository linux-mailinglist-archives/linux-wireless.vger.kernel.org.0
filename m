Return-Path: <linux-wireless+bounces-5065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8997C88194C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C7A1C211C7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291385C43;
	Wed, 20 Mar 2024 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dsexuQDy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529985C42
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710971577; cv=none; b=gBKuizsFKzegzFMZ7CA5qUnAAKGMpmbTDzzv+n4VGr5TKkf+zs7p3ygp0bRRRhEHCdgMYQl6aTWnsu5wfYu7x39uaIuAB1YiVkCh5bXefQj4MN53MfATYLx+acbElWmakoxlxHW5lani1BcoWslVBRKAatU4jF6Fsuijt1BxbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710971577; c=relaxed/simple;
	bh=VR8OR4ORIuJIuZ1XaCN4HmsAt6BjN+jk8pGhIC8ZPT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kolIsPAVAWYVAYI+M+sIIVjip3DMR11h9egCJm6KoxsXxTsuwV9HGUxFSIwp/FAfPXiFpJq7WTxVSRGvzEOkxK3bKiQjwsvfE9QW6t6Hed7w76fw4UcgA9AGpP1R1SELnWl3MJN0j9mKHrRDtw6KVj9R7NXfZNT4fKhCkc0V0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dsexuQDy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KLhtpu021795;
	Wed, 20 Mar 2024 21:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=evfjbZ6Ja7i4Vo2dAlYXxLJliFVUtPE+p2PWhFnKGyA=; b=ds
	exuQDyiYykBY8XcDZQH+Sxzs9mopqtThq7dkI5V9MjzFScYIegZK8SJNa0tTBTnk
	updd1SM7gOiw9aDuqu5tyPQtZHTYHp2VZHCMezipNiiPyAuU33lN7T94xIG+XbPU
	aHMzoUiS8lR1e7qoS+X5BVthKDPpx7mlNIWgWRtFoUxHwRhFIq+PpNZVLA79+Fvn
	RgRYkOjBl2jg9xUScK6mHE7JwvU+cwkGc41wZ1IwruXGOGkmup51xfwHKDuH03BV
	mrYgezehnTNIQ6jt6LXn7KB/rdtJepZV7NkpBlTyVZjIynOZNpNb3sYDos6vvZtX
	Dw8byNppKaH7mmtV9Tng==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyxq91dtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 21:52:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KLqkjp006903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 21:52:46 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 14:52:46 -0700
Message-ID: <71371ddf-aa0d-4343-82d3-c10d560d7526@quicinc.com>
Date: Wed, 20 Mar 2024 14:52:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] wifi: ath12k: vdev statemachine changes for
 single wiphy
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
 <20240320190943.3850106-5-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240320190943.3850106-5-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e6MXyBaJ7EkcTGtreQzolX9nQzUhFOvb
X-Proofpoint-GUID: e6MXyBaJ7EkcTGtreQzolX9nQzUhFOvb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=834
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200174

On 3/20/2024 12:09 PM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> With single wiphy, multiple radios are combined into a single wiphy.
> Since any channel can be assigned to a vif being brought up,
> the vdev cannot be created during add_interface(). Hence defer the
> vdev creation till channel assignment.
> 
> If only one radio is part of the wiphy, then the existing logic
> is maintained, i.e vdevs are created during add interface and
> started during channel assignment. This ensures no functional changes
> to single pdev devices which has only one radio in the SoC.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


