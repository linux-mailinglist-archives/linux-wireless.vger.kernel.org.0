Return-Path: <linux-wireless+bounces-16132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CC49EA8EA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 07:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2B1668DD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 06:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E5722759B;
	Tue, 10 Dec 2024 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GRQ6iJSv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF741D7E31;
	Tue, 10 Dec 2024 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733813249; cv=none; b=llVytHNPIHZZsg8r6ye1irPOp5JeGjF2MnRa6WGsH4phCmQYQznvPIA+jXKt9jaGTIFYBQAMJ0citcRmVVZU8CceQpXSzFbcLyIr9z8V4leWmNd9/oxlHmIavBbSpIouBu8h8iMJYl37t2ekeIe0g7nuQZw2gDDa7fYzeQlS/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733813249; c=relaxed/simple;
	bh=zK7WgrLWMLHCbW7NHTd14SzjOtq3ZvDdErahwDZlSxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SwGyh2S/Ubpzv0DA+xhjshCrOnOm0EdHndocSyDrdCFGFbvrLFiuqonqZoLsx26zT/V58pk4BZouCknTza8E9SghW232h7v7xqrAoZCJDK6/IDxrTkkSckf3NvEFpjOEqtW5LzlLybtycJVmus5R0LZXBF0yz9vVatkGR503K2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GRQ6iJSv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA6K8cI028717;
	Tue, 10 Dec 2024 06:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9F3pZqw2ZQnJtyHMhelYfJPEZgidNRK1W5f7+6gzfcQ=; b=GRQ6iJSvafh8Wmj8
	gOJ8lGrftZ18LowL9zpkgr/kFIHzfym7FjOPDBI8AYtDsKVsg5g+g9ZxKzsw+Jqn
	USw5lA/xfwZiLBMfYLW7iOR8dOdLmE8+2RUUfZ7l5MVear28nnNUNEbpcAGCLaZ3
	dn5nT/bdTbU7k7R0PNuJQf37oof6C6XX3TshIhkO6zIZH3yI1Zo4o7HT1uYESw39
	7MnMZ+1vhpjmlJqRyBj/Wp1yGEG+IytUcXWpFbIrKtZKkEzx+YwJ5oMFyqo+yD5i
	lfpkDJU1/zlEKL+yk/bdhnwqdb9m7iz9esHC4XgyrGZRc0XL4ztKQ2CsOmYwNwB8
	dLnemQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eg9eg25g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 06:47:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BA6lJlg032576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 06:47:19 GMT
Received: from [10.216.0.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 22:47:16 -0800
Message-ID: <3ed0ccbf-1ce8-7429-151c-d21eb5311f6a@quicinc.com>
Date: Tue, 10 Dec 2024 12:17:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 wireless-next] wifi: ath12k: Fix out-of-bounds read in
 ath12k_mac_vdev_create
Content-Language: en-US
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
        <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241207071306.325641-1-dheeraj.linuxdev@gmail.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20241207071306.325641-1-dheeraj.linuxdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j9NyINFhCAzci3chAL6vrGITh3fJetCJ
X-Proofpoint-ORIG-GUID: j9NyINFhCAzci3chAL6vrGITh3fJetCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=437 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412100050



On 12/7/2024 12:43 PM, Dheeraj Reddy Jonnalagadda wrote:
> Add a bounds check to ath12k_mac_vdev_create() to prevent an out-of-bounds
> read in the vif->link_conf array. The function uses link_id, derived from
> arvif->link_id, to index the array. When link_id equals 15, the index
> exceeds the bounds of the array, which contains only 15 elements.
> 
> This issue occurs in the following code branch:
> 
>      if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
>          link_id = ffs(vif->valid_links) - 1;
>      else
>          link_id = arvif->link_id;
> 
> When the first condition in the if statement is true and the second
> condition is false, it implies that arvif->link_id equals 15 and
> the else branch is taken, where link_id is set to 15, causing an
> out-of-bounds access when vif->link_conf array is read using link_id
> as index.

Practically this can not happen as ath12k_mac_assign_link_vif() which
retrieves the arvif by link_id before calling ath12k_mac_vdev_create()
sanitizes the link_id when there are no valid_links running for that
vif (!vif->valid_links).

Vasanth

