Return-Path: <linux-wireless+bounces-7489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E608C296F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448301C2249B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBB18E25;
	Fri, 10 May 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ThkM0bFz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15330944F
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362831; cv=none; b=WpHRKxATDftYa4QgfagAypoWZ2sLPB4mo/OHvzxMbFh0h1wQcdCFmhjU3FFO34PbUCFObT/cCFBdwoheRSnhBpv9LpghWhArbA/uvuA77IQJ0Lgnl47+QXOnCQVMZzA15fPMgmP2tzMl+TgB2BxF0FqvLLGCBsmNhqltx3AEVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362831; c=relaxed/simple;
	bh=SpwWz0p9vEZVACdGpKkmmC/Nk+x34WCPlt1/z287JoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RKKQZPn7d31Fnr5XSLVKMSG5lB/48cQXKJ83dr1qW1U8+aMiaz7j2RjkmffVEHT1W52YJFhRkWQ6tQjaQ4zFfoc+as48jTIa4mqksDj56MUN4owr72BvN85hk3J6UKXMfWT97/FG6gh9VrOSFcp2XqZZsQSVp2cxd8xRAYmDY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ThkM0bFz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AEKp01025185;
	Fri, 10 May 2024 17:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gvSDn1onXQlUziXwS6j3LBnVthDf9cvu+fLmQqL4rsc=; b=Th
	kM0bFzKJ8ZpbGx8+3eCezv81MH/LNMvYMeVJo10mcPPXGc9w2lsiOs5QDrMwikCR
	pNyimTeqUfByGBMJ8pAL0FIIHpcEtX+kxmuPONZS+fYSCyfW+XaYuVpzXCcE4lJ5
	yO6jA7niDRcOn2OP8gjJ3VcDir7sgImW0Tdp1V3483e1oa+ATlpioPobZqnUceXV
	8PnvWsQCcRkxEYS/UdOScifKYoDR7/r8n6gywDD5oAJIe20qXMo9NEVulSPsVq3T
	3e+5PmEgyWabKfCvdXNzR2RHprQUGyNtg/pipQiwVYR/RrpdqFyrxMU/OXl2oX+u
	inrJ7tbuqvUpUmar8YlA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w2a357-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:40:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AHeElG014992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 17:40:14 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 10:40:13 -0700
Message-ID: <960c4437-927c-4e90-87bc-c550cdcfaec0@quicinc.com>
Date: Fri, 10 May 2024 10:40:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] wifi: ath12k: handle keepalive during WoWLAN suspend
 and resume
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240510064748.369452-1-quic_bqiang@quicinc.com>
 <20240510064748.369452-8-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240510064748.369452-8-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wfuwyqmZFrrayyoThfwF9LGSiEsuz06X
X-Proofpoint-ORIG-GUID: wfuwyqmZFrrayyoThfwF9LGSiEsuz06X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=963
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100127

On 5/9/2024 11:47 PM, Baochen Qiang wrote:
> With WoWLAN enabled and after sleeping for a rather long time,
> we are seeing that with some APs, it is not able to wake up
> the STA though the correct wake up pattern has been configured.
> This is because the host doesn't send keepalive command to
> firmware, thus firmware will not send any packet to the AP and
> after a specific time the AP kicks out the STA.
> 
> So enable keepalive before going to suspend and disable it after
> resume back.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



