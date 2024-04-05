Return-Path: <linux-wireless+bounces-5914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D338A89A153
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 17:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7233D1F21C68
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8569616F8F7;
	Fri,  5 Apr 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oz/D2npm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E416F912
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331381; cv=none; b=u8Xd07oQ1lL3al+mF+wVjBmPR7OElFL6IC0856aymQ4y+NiuR0IHTKcEzngQJTFcfuxYLyXZoSHfP67qOKq5P3rJv+GIYQI8YlAtwUDL4EFBcJtWvArdFyArmRDh0e4E0ioaPR5sle2GErV3ubTn4Qh8fj3h4Uk6WdzfaOZbaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331381; c=relaxed/simple;
	bh=fKp4kGWmhyXjUHBc89ffu8WE2eggiJqu+ruZMwmdwuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fDnDM7qtrJmRkhfO96J8sLw0rOSeR5tj+kEsHOzM3y6eplQ2zPyFNwzSz3wsZHbvJuF6xbwo2ojajveU23itLr8tTpBPeazj/v+n4TulXrpafcXHDaK6JwFvTrClWblyr6YIiOyi1M6Fh1dcoTX1SzdXytMv5wbKqNZwdENQ804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oz/D2npm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4356PvTc016112;
	Fri, 5 Apr 2024 15:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DyzRcfosSoahMsC0CkfmLAxIcnCYww5lEesThVlWUjU=; b=oz
	/D2npmusnI58wdAGIWIxeLmkksz8VKzCHrtzg+5ztpgNCaEm4tohXdbhJ5YKBums
	RV/WQZBJLjYo8luMdk2GXOwFTRtk2JCYer3048FF1kf26yOM4sJRb7Mk1tv/6vLb
	8fbALlVNhZ8z6+bFrhsiHChbh8xQQMc/ElXLTjBSs0txpcXWW/oZjxu185ABjmom
	utm6PDJ03u7fyAAJYZYOvon/P86qQQtGQ/mQemhhR5OsLZJDgltMhpGUfR1SwBvs
	wE+wdoajtIj9U4TN7iREi3KsllM6JOM2Z68uuDbikZ5usowiB99sDq+x3nXUEVPl
	xhUWno/0eedWS2QBWtPw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa8fc1juw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:36:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435Fa8Pa003036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 15:36:08 GMT
Received: from [10.110.127.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 08:36:08 -0700
Message-ID: <19570dc2-1c39-4407-93b4-87ed2e355f85@quicinc.com>
Date: Fri, 5 Apr 2024 08:36:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] wifi: ath12k: Add single wiphy suppor
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240401190409.2461819-1-quic_ramess@quicinc.com>
 <0d1058eb-aced-4e81-9f61-e4b5a08c04a2@quicinc.com>
 <bdf7abad-3d13-4085-8e75-c0d5ff4b41db@quicinc.com>
 <65e994e1-8da9-470f-9b1e-b2db20974b2d@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <65e994e1-8da9-470f-9b1e-b2db20974b2d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aeBcD5RnnFpoJSdPcJWaPTD3kzPp23U3
X-Proofpoint-ORIG-GUID: aeBcD5RnnFpoJSdPcJWaPTD3kzPp23U3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=677 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050112

On 4/4/2024 7:12 PM, Rameshkumar Sundaram wrote:
> Hi Jeff,
> Planning to re-spin v7 to address comments on PATCH 07/12, do you have 
> anymore comments on the commit text or other patches ?

no, i don't have any additional comments, at least not at this time ;)

