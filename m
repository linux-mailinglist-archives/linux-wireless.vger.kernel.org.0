Return-Path: <linux-wireless+bounces-4911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C42C88014D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 16:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0764828688F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DCA81AC6;
	Tue, 19 Mar 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g3lUZq6J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A8823A4
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863940; cv=none; b=sMd4XtIfY+MOQAgiJrMB/rQ2MQHjGoOoW2gqmU6Zu3pYAUZPk4ClBe33Zx4KcJQQJxdeU2dG5YzPbZ5yNaA98uscDwnqUhpQUxG63DZQe1YBrhmyu+pE71Z6bSiZRahkXoGIlnPH/Gaf/O4CFQX1RjwtPlKeyYxu9kWuqhF3xSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863940; c=relaxed/simple;
	bh=BOhpykBMRHtMQOT5EMQioCaAW1AoiNP1e/pKFISfsXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a1/uIsd8XFH0iKX+2o9XlOdXpG+5Bwrvfh35xkUh8wGCWao97b3ueU85bobcicfs9IN5Gqe7Yvwi+Fc3VFkExPbP29UP4WleZ1STa02F+NlAbF9hpF9radXD79eCZrRAOiJ7vtsRKpV0Q3HCO/O76cKAW4BwWnp7GjitxB4BuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g3lUZq6J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JEwdUY009334;
	Tue, 19 Mar 2024 15:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ftcgkdEMHQjZVYLKhURwGfhXn3p1c1g2PGoGrx4YlZw=; b=g3
	lUZq6JA3Ct+EAASep+wYSPjMglx3/v3Cw8/CbvxWVyVx3/Jm9O+Chtc5tI7KPEs3
	dUAf6A1FLJoZ8RH/XJ4n3DCGBCo87FazzkVMWs4UWuwLTyOiNfor6tMsR0l3JWO+
	fR8U0hSvEwS6RjJ49VznVMPqfIkgnU8K+npdSmh6hqjZEGuFhHrIKexKY8IzxUFr
	8IzvQzTBpjFoGugM8t3lwyGC7AqicT1a+BVV76VyFa7Hk5HFZaelHp872V3Vb28Y
	/Txpz05Ci4KZLNGhJY6Ruk9eVA0w1OUKF67hxdlMK+6I68H1nzZgMdrhNo+vil51
	VBh5Q9wGZeXQN9Haaaog==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2e9hnke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 15:58:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JFwqsH002232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 15:58:52 GMT
Received: from [10.50.62.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 08:58:50 -0700
Message-ID: <34a993b5-7772-44d8-8be6-c754f9f05f82@quicinc.com>
Date: Tue, 19 Mar 2024 21:28:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] wifi: ath12k: scan statemachine changes for
 single wiphy
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-6-quic_ramess@quicinc.com>
 <34ffab82-44ec-485d-84a5-d5bd9aec9a85@quicinc.com>
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <34ffab82-44ec-485d-84a5-d5bd9aec9a85@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X4vz4ZZmKcBeEf7ryrwYZl_MpG7XGZ9H
X-Proofpoint-ORIG-GUID: X4vz4ZZmKcBeEf7ryrwYZl_MpG7XGZ9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190122



On 3/13/2024 4:05 AM, Jeff Johnson wrote:
> On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> When multiple radios are advertised as a single wiphy which
>> supports various bands, a default scan request to mac80211
>> from cfg80211 will split the driver request based on band,
>> so each request will have channels belonging to the same band.
>> With this supported by default, the ath12k driver on receiving
>> this request checks for one of the channels in the request and
>> selects the corresponding radio(ar) on which the scan is going
>> to be performed and creates a vdev on that radio.
>>
>> Note that on scan completion this vdev is not deleted. If a new
>> scan request is seen on that same vif for a different band the
>> vdev will be deleted and created on the new radio supporting the
>> request. The vdev delete logic is refactored to have this done
>> dynamically.
>>
>> The reason for not deleting the vdev on scan stop is to avoid
>> repeated delete-create sequence if the scan is on the same band.
>> Also, during channel assign, new vdev creation can be optimized
>> as well.
>>
>> Also if the scan is requested when the vdev is in started state,
>> no switching to new radio is allowed and scan on channels only
>> within same radio is allowed.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> ---
> ...
>> +	/* If the vif is already assigned to a specific vdev of an ar,
>> +	 * check whether its already started, vdev which is started
>> +	 * are not allowed to switch to a new radio.
>> +	 * If the vdev is not started, but was earlier created on a
>> +	 * different ar, delete that vdev and create a new one. We don't
>> +	 * delete at the scan stop as an optimization to avoid reduntant
> 
> s/reduntant/redundant/
Sure will fix it in next version
> 
>> +	 * delete-create vdev's for the same ar, in case the request is
>> +	 * always on the same band for the vif
>> +	 */
> 

