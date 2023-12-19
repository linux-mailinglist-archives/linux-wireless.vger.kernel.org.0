Return-Path: <linux-wireless+bounces-1050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F42819476
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 00:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475731C23F0A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 23:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5273FB03;
	Tue, 19 Dec 2023 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f68gKlSX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBEA3FB04
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJHPgGl009134;
	Tue, 19 Dec 2023 23:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6o4ccJ5mhJrAusM990h7fWHmh0FFKAPa1Pg6Zr/nIGk=; b=f6
	8gKlSXNKx+1sGmMClqkCVMUMOiOK7Y48wiaUScoPixBRsXqjXAEyuzOr/rozqukB
	ztCgicvXIq/HmYGGQpbPKfBDGyxueGVdDxx0lPZSpUTl39wo16kopvSrLH66vABb
	Khww4JwLkPW4HjoEYKEbyKrJDG4VqjSlWuxNSwZVDiOeeANcCRxVuZeMxA1KKTlY
	bJ4RhQVQD4Z+03K4MkRs7V9FLLu7K58tmylxNT+jL5rnHjK7HoSw0qmvxwj1aWns
	awQQsh89bhFlskIqJM7bBDG4yfFIABBKoxalEExSNiPX7Lsvt2iSiEgZ4xXgQr6t
	BeMvTv5kxUu1OXAzDEqQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v360yjc3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 23:17:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJNGkXY015457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 23:16:46 GMT
Received: from [10.110.4.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 15:16:46 -0800
Message-ID: <05944e81-3c1b-485b-82f8-15b8cb991a4b@quicinc.com>
Date: Tue, 19 Dec 2023 15:16:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] wifi: mac80211: rework RX timestamp flags
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Miri Korenblit
	<miriam.rachel.korenblit@intel.com>
CC: <linux-wireless@vger.kernel.org>,
        Gregory Greenman
	<gregory.greenman@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
 <20231220133549.d0e664832d14.I20c8900106f9bf81316bed778b1e3ce145785274@changeid>
 <69e18f8e-0157-43db-bd11-78ee945d9912@quicinc.com>
 <a817504ee11fd9bca316312b40218f82c56ec7b7.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <a817504ee11fd9bca316312b40218f82c56ec7b7.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AMRbnbb11BCBjMpqrq3Bo3WGEwrE8e3f
X-Proofpoint-ORIG-GUID: AMRbnbb11BCBjMpqrq3Bo3WGEwrE8e3f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=426 adultscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190173

On 12/19/2023 2:43 PM, Johannes Berg wrote:
> On Tue, 2023-12-19 at 14:41 -0800, Jeff Johnson wrote:
>> now the code can return a value that doesn't map to the true/false bool
>> enums
> 
> No, it cannot, at least not if 'bool' is implemented in a C99-compliant
> way :) It's not actually an enum, it will return 0/1 in the machine
> register even with this code.

Today I learned something new. Guess I'm still carrying baggage from
pre-C99.

/jeff


