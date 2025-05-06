Return-Path: <linux-wireless+bounces-22655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C19AABB32
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 09:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FB74E4128
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A3E2AE89;
	Tue,  6 May 2025 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LeT1eqGX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10D2777E4;
	Tue,  6 May 2025 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746513689; cv=none; b=fj2/ASfHO8TWNhhmaOViwUUHoqGqf4ybQJ1diAnK7q7moTiwDPY3BigQxnVJ62UhnYHGkcVW/rTGf4DXNQ6tYrKCKacNYHXpQ6J0pwZtrf83bkePdM1MZYUxWtausfZkSXF/eRJdJBT0KyhZ5LvXW2hWnxfS9wDA8ZLPzlqwddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746513689; c=relaxed/simple;
	bh=rv+hoGYq0ZDlQtmYKzw5bu7F4GLiPZUbc5AeOgeSKRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gUIpn53vXiGnuKWrcFnlvVLASG2DLtIrXvyksseXp4lajnc6nU3iT2axDtVgQYSonhVDord/+0BQQu1GyFSY4Rh7JevJWlVRhm0DEL17gH0qKj7BubUcb49KFMyjVzptYdjG+tvtc4goFa677Pd+A+R0Wu/A0uJxKAQDthleSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LeT1eqGX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545KTcN1029768;
	Tue, 6 May 2025 06:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5WpQyy7+lz6gLjHF7QNiOJiMauMlo70+d6o9Egjud/w=; b=LeT1eqGXIuBZa/Ns
	w4nSyWytVs+TdahVbb8h1Kc/hmsZN8V3YvNvGNcu38xyxUos4GNdbfFCuVG3K61n
	qwb7KD0qvciLQ0xDtM4AmKKA3cnu0ZcmgV5EKIVw6h4NE7tDjtowkGxf+FM6CNJE
	r8xzZb6uiOf2GD2LqJ9OkNL6YhDOl8EQj5Zt4zRnb62hgVOvK6M/JUdlOMV2wBnW
	+YLv3u2NOMmbcj9ICox6pgMrEqf/HnhHg4R3X/ZH0RoJ3n8C6lre93k7DTn/DSIB
	xNFJVPhpRn5YdOoho8t+xg5QBI4jzUMyS53/GZhBoE1vJwRYvI+6XaGBYN42k6lW
	nPDKSw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46da3rxk4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 06:41:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5466fHRf019310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 May 2025 06:41:17 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 May 2025
 23:41:15 -0700
Message-ID: <b7d0e180-c638-41fc-83c8-b21f623f8db9@quicinc.com>
Date: Tue, 6 May 2025 14:41:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] wifi: ath11k: Fix memory reuse logic
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Muhammad Usama Anjum
	<usama.anjum@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
CC: <kernel@collabora.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250428080242.466901-1-usama.anjum@collabora.com>
 <f58075f7-f643-4e47-b774-dc529aaa01e5@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <f58075f7-f643-4e47-b774-dc529aaa01e5@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bp2Htcc_BeoaGBKLKsgmCbpfz7uPwgJz
X-Authority-Analysis: v=2.4 cv=cpWbk04i c=1 sm=1 tr=0 ts=6819af0d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=fQUuUtAQQ1lD57sUCcMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bp2Htcc_BeoaGBKLKsgmCbpfz7uPwgJz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2MiBTYWx0ZWRfXwQF2tI8iss77
 gHmcI4SSm4zo/vdROYDV0+/ZKBrP74GuMouiFeRG5S4BeKsNAV4Nb7S67AoaPO6UJalMON2PxCC
 ppsS5EY5AiPxIz1ml/JeQL8IMynRQwY6k1SJzO3kcVG4EMRWoEp1k3nZIkuLD2p/kG6AfouB9xp
 4XVH6DmDyeflBLDCkIztvpFpiflPAUkfkfJ9R7bJjJ8oBuEqXpEGU62aJJZQxxhltWJjIF7KfNt
 T8JnF0Wy2lmD812+wbybGkC7Oxkxp5JLjZzXNPV/VkwKd4/AD2jAvxN6+zDe2W/FlQDxEz0VLrI
 RjMKDNt0i+dlhilOqoaoiiWopb5b2+O/3UWEBdjsZn48iPAp8C5W5iyhbW5lfx+3wDK65ZmOrGT
 bqW9lp9BatcRu/xJC/0l6Q9c5yKZHNKr2OQImNxu7KzLMuzVcHRowQY7ioUnjaYp5CI/SAjK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=803
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060062



On 5/6/2025 3:17 AM, Jeff Johnson wrote:
> v2 feedback was not incorporated:
> For starters, can we make the subject a bit more specific, i.e.
> Fix MHI target memory reuse logic

Regarding this specific comment:

This change it to refine the QMI memory reuse logic, it is not related to any MHI target
memory.

Actually Muhammad changed the subject according to your comment in v3, but changed it back
based on my above comment in v5.

> 
> But don't repost for this -- I'll make that change in ath/pending
> 
> However, does ath12k need the same fix?
> If so, can you post a separate patch for that?
> 
> /jeff


