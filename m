Return-Path: <linux-wireless+bounces-24475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78B5AE7EDB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 12:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DA416AA8E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8BE29AB0F;
	Wed, 25 Jun 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gcPbRqMe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917E12080C1;
	Wed, 25 Jun 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846551; cv=none; b=ZUBZ+sfcxIFXQa1oGgWN1idbyAw9fKn+qrireKNd+I8VovFnyVzVOqhhNkh8u5eDmG9uKIDuCoKAXOpCk2pvDAU1HICb/Gmsc44X5j3nq6ju4eELWL35zr0M68NhRqwlYVu19P24R9W0kwH8O3Qx7CGObY9A/c4Lz2DEmL1VKlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846551; c=relaxed/simple;
	bh=ejRSnZMZOb8MetpeM54/FhC/hbo4wCQaq/hnZzlt120=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hsc5lPg9xkWyGv0v29773tNbmigz0IdWrdFY4uWCS87e2ZrtMX/L5S7Ud5lUUEyuLaQZN3VmeuRYIrAVOMwrm5+DEhf+xQIVBKRSPKBbBx0g68Hwkz6MDWeJHNoMMqNAhR23s9tUNil1uxphQm51vm3vt4ids3hdmjJReieMe/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gcPbRqMe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P5Uage014612;
	Wed, 25 Jun 2025 10:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	63/bL2IIGIhEgVAkuZEz0w9mUZlosciFa/3XDDkBNPc=; b=gcPbRqMeHb0eFjY9
	dXeTSIscHXthu4m2AZQJ1yPz8rwjjqcAm3eXyYxKCYGrxuiSPnhDA6ieevU2qrnW
	ftclR3te/Ugcuwqn39Ejd6sIz5uVVGIV/3Cg2k/eawJziZAb7TwX301p0evHPS5v
	zNd8V41ey3f9zDSgw1oYrw+oE/ga6NKpTRVVok2VKu1eSlFRjOWW6cMao/roFRxz
	su3cdEXexfugcuvLt9apkXag3NuyfuA0LLiOhrepRIK4yOajUWO82wU5ViL57ygo
	qJUv4/wRUYknfBZtyhoaL8kWJ0NtTPk2FhdeIs6MHY//bbo/WKe/3WANCqLtZYXa
	WzOM5g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rpyqm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 10:15:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55PAFcNw020623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 10:15:38 GMT
Received: from [10.133.33.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Jun
 2025 03:15:36 -0700
Message-ID: <2d688040-e547-4e18-905e-ea31ea9d627b@quicinc.com>
Date: Wed, 25 Jun 2025 18:15:34 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: install pairwise key first
To: Johan Hovold <johan@kernel.org>
CC: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gregoire
	<gregoire.s93@live.fr>, Sebastian Reichel <sre@kernel.org>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
 <aFvGnJwMTqDbYsHF@hovoldconsulting.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <aFvGnJwMTqDbYsHF@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685bcc4b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=UqCG9HQmAAAA:8 a=COk6AnOGAAAA:8 a=DXNEfgFaXloPVKmhlksA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA3NyBTYWx0ZWRfX/S9JpvsSuZkw
 /6lT3pInHPGkUYiPRogRT0qYb5M4y2vtnyGSor3NxU6Eoe3IrM9TdsCFK7aUgqJhwSKOvgFpKNw
 A5YzNSE/tWbHwdYg3RGEG26Gv2QyWae5kaA1fJIjwXvDhq8o2LRmtwlGGFlqUfVzKRtK4bg6NDE
 nMlFXm6R1eZNMCkxVPf9XPHxfL1/vcxekRRhk3k6ycOeVVcpead9f7zOpAl1PQXFHHU+73iU7/E
 A5MCUaLVENKMm4CAQLTCcJxEaV5sFhHipHvavhwfIEVFFioGC0y1at9r0tgANIHm9RWXmmi7h3H
 2i8W0Ns4q9fYS/RJ20XrV9sbBBZQ1ktJB5Ii8lWAm6HOjqh+0Kz1VUjHuznCMy5oGCzVzQHan7E
 Ie338x+ajIyDcGM8e71ciZglhJ2+ftBaQxyZtqFZYUrvgv+REyv5yDV+6ZbQef9MKr6ydPW+
X-Proofpoint-ORIG-GUID: U5h60NmTV_qS2FdWiRKR7rNBv3AlkNaW
X-Proofpoint-GUID: U5h60NmTV_qS2FdWiRKR7rNBv3AlkNaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1011 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250077



On 6/25/2025 5:51 PM, Johan Hovold wrote:
> [ +CC: Gregoire ]
> 
> On Fri, May 23, 2025 at 11:49:00AM +0800, Baochen Qiang wrote:
>> We got report that WCN7850 is not working with IWD [1][2]. Debug
>> shows the reason is that IWD installs group key before pairwise
>> key, which goes against WCN7850's firmware.
>>
>> Reorder key install to workaround this.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218733
>> [2] https://lore.kernel.org/all/AS8P190MB12051DDBD84CD88E71C40AD7873F2@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>> ---
>> Baochen Qiang (2):
>>       wifi: ath12k: avoid bit operation on key flags
>>       wifi: ath12k: install pairwise key first
> 
> Thanks for fixing this, Baochen.
> 
> I noticed the patches weren't clearly marked as fixes. Do you think we
> should ask the stable team to backport these once they are in mainline
> (e.g. after 6.17-rc1 is out)? Or do you think they are too intrusive and
> risky to backport or similar?

Yeah, I think they should be backported.

> 
> [ Also please try to remember to CC any (public) reporters. I only found
>   out today that this had been addressed in linux-next. ]

Thanks, will keep in mind.

> 
> Johan


