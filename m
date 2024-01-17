Return-Path: <linux-wireless+bounces-2103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEC88309D0
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 16:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE4FFB22B69
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E521A02;
	Wed, 17 Jan 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XxsH4bvH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025221A01
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505569; cv=none; b=JL3jH4osx2pDjA2AO+MMIkiWq60CE/HeyriZYaML3oQvFl5zaJVG2F1DJRTlxeIUir/YhI54SrMj9nfwoFbf9dYQbGgdbxQgPMokN6upX/GzUl7RBWqJtYrOYK7HtsxZOQ8RsXg5QiUzmOLYlAc54PSDptnXd/i+BeYtIRe/75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505569; c=relaxed/simple;
	bh=jYzp7UqBnPIk/D9cIuc/1IvI05iDqvSOZn9wAIVPvFE=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=ZvakuSBxymDPyOwZIi5xm7XJju7KKvoC7Nb9BpMD8iYPLWlaXddOtUsec8U36sQL9TWChjP/nd/FzIul+bXjYZC7Aeghzd61wOH8GPznLnTp1fB8ac5s5nnqPExlOrBdG+J8T9LQZu3yDNTT6r478CEAC3GVwaKzMDB3xKAQiw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XxsH4bvH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HBfhnJ011467;
	Wed, 17 Jan 2024 15:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/GkypJyukRzA6icnybOrYMCIcnlz4PwAEUfXFW5oykc=; b=Xx
	sH4bvHrwWiM1YG8q3DwFIWip+HDNqhov8p8eqyTjj5NP4CpEHzCevUaJLYkaJLR6
	zcXICt+KSpU2uVBcIRwHi33kd/O+ph54D9F+cwgrMM/0NzKbIcrFE4ijmPsTFA0x
	dAcIugFuo8xtVxTLwHcHGE04jDpQG7zh4pR0YLswP8kYowrt7u6YPV1bB1e6T3mD
	yjYqQUcvDxvy52bpqTnS7gkXk7NMvZzkkeSY5h3GOzJUxuqW/XXTl2oJcekivSRZ
	JH7P6GnKkXk/PdF5lhubzCBcao+oHE3PE2yv0t9+XOoQ6fJjYQRhJrLsmk0B5SsH
	5LiAd8TqudmIM9w0mrwg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp8pc973n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:32:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HFWbgf023428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:32:37 GMT
Received: from [10.110.99.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 07:32:36 -0800
Message-ID: <6da888c4-be62-4373-8527-996dddb436f3@quicinc.com>
Date: Wed, 17 Jan 2024 07:32:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] wifi: ath12k: some improvement to RX throughput
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231129020414.56425-1-quic_bqiang@quicinc.com>
 <874jfc5ayb.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <874jfc5ayb.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JwKpV7vsPETcYsP_r0P3qdv8bB0_c5i4
X-Proofpoint-GUID: JwKpV7vsPETcYsP_r0P3qdv8bB0_c5i4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_09,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=758
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401170111

On 1/17/2024 5:46 AM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> Some fields of hal_reo_update_rx_queue are wrongly
>> defined, fix it in the first patch.
>>
>> Currently the maximum block ACK window size is 256,
>> with the second patch, it is extended to BA1024.
>>
>> The small MAC buffer ring becomes the bottle neck
>> in RX throughput test, so enlarge its size to get
>> a better peak result. This is done is the third patch.
>>
>> With above three changes, more than 6% increase is
>> seen in RX throughput test.
>>
>> v2:
>>  1. wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
>> 	no change.
>>  2. wifi: ath12k: add support for BA1024
>> 	a) s/doen/done
>> 	b) update struct hal_rx_reo_queue_1k
>>  3. wifi: ath12k: change MAC buffer ring size to 2048
>> 	no change.
>>
>> Baochen Qiang (3):
>>   wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
>>   wifi: ath12k: add support for BA1024
>>   wifi: ath12k: change MAC buffer ring size to 2048
> 
> I had conflicts, please double check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=1ee7c1872873d82a71e05a4e17cbf9a569bc8ec9
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=4d75db679457b5b7e04271f5174d9128d7d73ecf
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=db549be42740d286ee6ec8b2860b4e4789be2167

These look good to me, but Baochen should also confirm


