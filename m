Return-Path: <linux-wireless+bounces-17547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D90A120C7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 11:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5BC3A196D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648DA248BDC;
	Wed, 15 Jan 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UTrdcqqB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0077248BA6;
	Wed, 15 Jan 2025 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938136; cv=none; b=gd+eKpSVDzfBItSsX1YPkhCalpHvRB11w1VUmwAQAKmCXLYt0avkBWnxNo27ctd39dgGPHjUqyxcTcgRgjm8dlr7kz7e42IVeXouYe+Ao2ib89T1zoGEmLYDN+ICdSxKkzxtjSC6rJ7oMQOMZBUorSnJP23PzY+nQrKrrBtYIL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938136; c=relaxed/simple;
	bh=6mRYWMyB5kJepZ+b6hcLb89aAw7Ids/bM2bi0ZZPiso=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oTSApUpZ0wKsAAfPsyz6o5ciae+PbueZuyI3EP4ifXe8AT2ZU7afbf2tXu8kTEEs0L/NGe3W1+572wnocz95S+4erbveSVALNp0QELdxU8uvIqo9c9yk4wGlC2m4ZJp4ewqOtcVAfhvMcyZ2OXzyR5tUwJWUzoAQnbggm/Osz7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UTrdcqqB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F5maGD018913;
	Wed, 15 Jan 2025 10:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q0j31EVrhvjMIoWK96rn3x0UwXqkBAwe7tNtBo6tiJg=; b=UTrdcqqB7A7VuJzP
	3qZ2Guwd40Piy+8Ycjh8TPxzE+q9hP+TuJnfzEdXxa+rbmQzjXCxEMJ5167s4ac7
	4aF/ha4BEOtIGafyvs6s27p6y7/fdGF5YQQpRj+wEBe1L8QnIoTLISASgJSWgitX
	DW9WQHzlzPA1JuFyAExkes8O+6ltSo9bgZn3pBCGuXyqbte08jp+gt2Aa/hIcNak
	eWlYoyih8zQnEI9sFFgxaJuk+elGJwtq9z5bJ/JHCusZNRKv9lmzZFStOMBp38fl
	QpKKjlVBEaH3z262+VUkVy0H9ewD0QwQOSQP2Enqb80aASJWMKmXYsC6o3lRMu9o
	1NztHA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44676vrrj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:48:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FAmj0X027855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:48:45 GMT
Received: from [10.231.195.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 Jan
 2025 02:48:43 -0800
Message-ID: <1090a0e4-6a19-422f-83ad-4566e5c86015@quicinc.com>
Date: Wed, 15 Jan 2025 18:48:40 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <quic_cjhuang@quicinc.com>, <vbenes@redhat.com>
References: <52a3efe8-c550-4494-af63-6b8c6894e7b5@quicinc.com>
 <20250115094636.132250-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20250115094636.132250-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RM3x8BJx1adyUvfEH6LtMfsTbNTu8lZb
X-Proofpoint-GUID: RM3x8BJx1adyUvfEH6LtMfsTbNTu8lZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=864 mlxscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150081



On 1/15/2025 5:46 PM, Jose Ignacio Tornos Martinez wrote:
> Hello Yuriy,
> 
> We can debug/configure NetworkManager on our own to get what we need.
> Now, I am just trying to get a solution because at this moment 2APs can not
> be configured as before.
> As I commented, if you want to have a common interface combination, please
> go ahead with yours, and then we can see.
> 
> Thanks
> 
> Best regards
> Jose Ignacio
> 
Hi, Jose

When you use 
https://lore.kernel.org/all/20230714023801.2621802-2-quic_cjhuang@quicinc.com/, 
the ap only allow 1, it's expected.

+	if (ab->hw_params.support_dual_stations) {
+		limits[0].max = 2;
+		limits[0].types |= BIT(NL80211_IFTYPE_STATION);
+
+		limits[1].max = 1;
+		limits[1].types |= BIT(NL80211_IFTYPE_AP);


In 
https://lore.kernel.org/all/20241125100508.3458594-1-quic_yuzha@quicinc.com/, 
revert the limits[1].max, it's why can work for my device. When you use 
combinations[0], it's all same as before. So ath11k can support 
STA+SAP+SAP mode(not include DFS).

Now I wonder to know why it doesn't work on your device, which is why I 
asked you to provide the logs.


Thanks,
Yuriy

