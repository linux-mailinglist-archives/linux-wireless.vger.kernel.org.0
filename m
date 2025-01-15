Return-Path: <linux-wireless+bounces-17545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA8A11CAD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 10:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C876E188BFB6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2211EEA30;
	Wed, 15 Jan 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="icRelXqN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC566246A3D;
	Wed, 15 Jan 2025 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931602; cv=none; b=Tw8FNFF5iFed2AVkhiiB9si1IS2V296LYxHId9+DXKdxF32/VyDcSuLwGErZug/JQ5o6ZJ4CgdwQih2Muc0S9cNhR0/dJVxq75tm/Vm/ZtBP6xRIeWazoaq3ukS4IEyRR9jZzba0utRY98tMXrgPIskIN28Ci/YuXu3It+qqe7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931602; c=relaxed/simple;
	bh=XSy2+zDyJYWUxm+GTAfKcSO4bZZhLDnLkDkvu5egef4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WxtE+YGxFDELn+EOSKhY+Wmi8QbXbhLmAHVxPCIxuyU4AW5k+wdqNUzn+UHLMWi+lIoRndeQD30VDVGZMwKuVhN5P65WJFZ/A5HHI2C5CyRZLDgKOWlMEknieqSezO343Szev78Mhvh0eapcyrjYqdwPWIk1C3AKrOivUbKxiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=icRelXqN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F0b0B7001652;
	Wed, 15 Jan 2025 08:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uz/6fhele6leCcFPn5Jh5fYePL/JQZ0S+IBb3VNglmw=; b=icRelXqN5gxgvoF0
	r3x2SvURuVYQch4xbvVj4IY/yBHN9wopuPIYI2bUfcDCcmsyz1oCL2d8d7m93QaA
	CghaC64xCfxfeK6/HO0ZDu8yUQmVG/0+DJaf9PeURNmrdznJrJI9wq51ih2vfHQu
	CkeYxqVXnYKCtPPNfttPqBqLqPU8+P9LZRh9+MASMyNyOAeRBJ6Bt6TUsrCo35M4
	sBHjqxjEvu+aXvgtAb7VWwzpmOpep2dRKu9SPuZL1aUSTdmQkklaVGsw2AKmW8gw
	/T8k8YYQvPdqtFYPEl9MOUHyqB5kZ2zx7ry0ugJmHHZWmp2qu+HbwMM2tchj0N5C
	EoKWfQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4462mkh2g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 08:59:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F8xq3o022981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 08:59:52 GMT
Received: from [10.231.195.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 Jan
 2025 00:59:49 -0800
Message-ID: <52a3efe8-c550-4494-af63-6b8c6894e7b5@quicinc.com>
Date: Wed, 15 Jan 2025 16:59:45 +0800
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
References: <20241211174155.30782-1-jtornosm@redhat.com>
 <20250114183405.60530-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20250114183405.60530-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1Nne0vRexswM3qvsjx9R2ha9i_v-MOea
X-Proofpoint-GUID: 1Nne0vRexswM3qvsjx9R2ha9i_v-MOea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_03,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=776 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150066



On 1/15/2025 2:34 AM, Jose Ignacio Tornos Martinez wrote:
> How is this going?
> Could you tell me if your proposed interface combination (or any different
> solution) is going to go ahead?
> 
> Thanks
> 
> Best regards
> Jose Ignacio
> 
Jose, could help to share the complete logs (include NetworkManager 
logs) after you applied 
https://lore.kernel.org/all/20241127022742.4016870-1-quic_yuzha@quicinc.com/.

Now I try enable NetworkManager in my device, find that:
When use "iw dev wlan0 interface add wlanxx type __ap", NM will change 
ap to managed mode.
Use "ifconfig wlanxx up" that can't up wlan2 that same with you, but I 
use hostapd can also up it, due to hostapd will change it to ap.


And I see your previous reply, if your device is sta+p2p+sap+sap?
"So, since the normal sta interface and p2p interface are initialized,
with your proposed interface combination, only one AP interface can be
added for me (vdev limit is 3).
I like your idea to have a common interface combination set for 
everything, but I think it is not possible here.
My patch with the new parameter at least allow to select what to do, 
dual stations support or APs support for all the cases."

Another way, could disable the NetworkManager service than try it? we 
can confirm it firstly.

Thanks,
Yuriy



