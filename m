Return-Path: <linux-wireless+bounces-19686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD27A4B9A8
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 09:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439A27A23EE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C094D18FC6B;
	Mon,  3 Mar 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h7U58Z7w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01EB667
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991512; cv=none; b=TooJFDjgAs/ArlwdI2s8xrkADKOb1PAGS0Q0PnycwuWxfh3LENsVzflJaPcUOQdfTJ9ovm6ASW4QmcPcgcMC7g2Wbai00QRI7PZhfklxaMUd666DGFH0QaNiMAiAdvlqv3VGXwknFMVxy2KySVad9fLmxiWQiUam5mLYad74v2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991512; c=relaxed/simple;
	bh=0TRr/E/PYlBDDIGuWNqlDinZPgzUGdo2TJ76I18uxTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HUjG29zzEP/TfG8w2EV2jzrhhV07KRy+iILpNfN+zfhfIfhYv6gxy/R3qQHsSYOj2cz4Z989Rzv3TLVcNqNVfEShYdhqf/LDwcreTN8pBadEOV82uOjI937BdY1+Cz1FA0MrT7C1WC5fO6rb6Mgkk9RkcguiCoq1gXDPdcECARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h7U58Z7w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522Nuow7027446;
	Mon, 3 Mar 2025 08:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uz7tzLUsz5hr3q010Ds58xzy9jg8n/DhPaK5sSAwY6E=; b=h7U58Z7wTOmVo8/D
	RRcP9TgBvPngKy4nEs56DMs0SdJbhp+FUtMXBjY+TCGHygkgAR6dbv5SYufErEE3
	N3fXBgjkXWVbGnNHAanE/02r9pCOy5FLulrRUwzdr4nk9Zm1LLPcY8v8/EVEMnDM
	QTi5ObVTFRSDXihUtHRZy7nVj2VGtbid3+x58BKgvpfwmyvrlxitFnyQKNGz2gxe
	kAECdPdUWkCuaA1riTLs1v/TsBubImPoNFgHLBu0yBnqHVEXXksNkYM6EsHRMslQ
	6cwJVGfQ1rfsXCToET2H1suqZVpZESR9StEvez7pXilRMqnMgqHXM3bkRkfx26sJ
	Gk3WKg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k4497-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 08:45:06 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5238j5Vw016883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 08:45:05 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 00:45:04 -0800
Message-ID: <acce8693-551e-4599-9260-6c4c604c566f@quicinc.com>
Date: Mon, 3 Mar 2025 14:15:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] wifi: mac80211: introduce sta_set_link_sinfo API
 to add support towards MLO statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
 <20250213171632.1646538-5-quic_sarishar@quicinc.com>
 <9514ee27ef444c754bf97e348d6f06399b159f07.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <9514ee27ef444c754bf97e348d6f06399b159f07.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -ktJEzdu4hYS2HKd6lFauiWuj9lQItIV
X-Proofpoint-ORIG-GUID: -ktJEzdu4hYS2HKd6lFauiWuj9lQItIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=694 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030066

On 2/28/2025 6:47 PM, Johannes Berg wrote:
> On Thu, 2025-02-13 at 22:46 +0530, Sarika Sharma wrote:
>> Introduce sta_set_link_sinfo() API to fill fields in sinfo structure
>> for station statistics.
> 
> I don't think you should call this an "API", it's within mac80211 and
> doesn't really constitute an API boundary of any sorts. Call it a
> refactoring?

sure, will use refactoring term.

> 
> johannes
> 

