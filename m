Return-Path: <linux-wireless+bounces-4860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4115287EF42
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 18:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CC51C2228E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9278F56454;
	Mon, 18 Mar 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m3gmOZf6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6C56453
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784469; cv=none; b=W8VTiMfdhgl0MQ3rZ8KZtHU99EID8y0+N4p9E5XQIAcxzxmb4maSpS8T1H2lcMChBy8efDNf/Cz9RbiyR3U9kiSo43IBsjUiyrwT+BVW35OjX0q7E+f0+Vg1X5tNyrIEUV7jL6P2WtiEli/PR6GzJHWnKQ79DWaRHuRjsA9gwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784469; c=relaxed/simple;
	bh=S0bzTLqHkDMIXe68HkAwt8hEA8WcKM6wMHhCPCjv3GM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=I/fBiaK+1CiefUVgA8jMdXYtNXqlz536kFH2D/W5EhXL3CEJc527fNxicpnOpAGlSTlb51rvfm2SOKdVvVlvRQ4/1Oo9fqayarBNPR2FX8Njc9ihbyaEodbSUWCRRWlKC1uo32VjGOxDPaTjGpVKlvWfWOJzJyki7SHB3EQGZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m3gmOZf6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IBM6wr006657;
	Mon, 18 Mar 2024 17:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qTYW2FAaJ6uOZrLHIY/TRsouExLdZxPr+fL1UYud3rI=; b=m3
	gmOZf6/5CD9COhLLFbeIJbMT08liz/7zIQR1mxYDOw/SjTN2/ItIXyakwEBJGd5t
	2okYDGdDrsg12oUQocZaOpRvoQEmkbKXe+z8EdfctccBhIZYruks+YR2f5xbxCLV
	REh+olxI1ZgVedDeeoXMOhpu0QItqP05pxXQNdvYZTvqsk36F7U8SkS+92HSecul
	DoNvAr5CRk2ms4d6ZQa7I7K9lFT6pzvmuPQcqiGDHC2s2LGX16q3WATRVQctSroT
	1t3T+kkpKJCpvDjZ+MjBF5CaS1oK2I0htPkrBJbpwPB4SXqj/YbKEioTkFFR1M6l
	Zjx+AWZ4CVG2nMmVvIhg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wxmnjrwtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 17:54:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42IHrq6g002485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 17:53:52 GMT
Received: from [10.110.89.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Mar
 2024 10:53:51 -0700
Message-ID: <b6f6d5a0-17f5-4526-b49f-cdcf2b75dc31@quicinc.com>
Date: Mon, 18 Mar 2024 10:53:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add firmware coredump collection support
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240318060249.1023837-1-quic_ssreeela@quicinc.com>
 <c1b44950-95d2-4185-b906-4296ceec123d@quicinc.com>
In-Reply-To: <c1b44950-95d2-4185-b906-4296ceec123d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hmH1ag9YxPEz_pBw-_BY_SVlOdQSpsFA
X-Proofpoint-ORIG-GUID: hmH1ag9YxPEz_pBw-_BY_SVlOdQSpsFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=787 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403180136

On 3/18/2024 9:02 AM, Jeff Johnson wrote:
> On 3/17/2024 11:02 PM, Sowmiya Sree Elavalagan wrote:
>> In case of firmware assert snapshot of firmware memory is essential for
>> debugging. Add firmware coredump collection support for PCI bus.
>> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
>> format and also pack various memory shared during QMI phase in separate
>> TLVs.  Add necessary header and share the dumps to user space using dev
>> coredump framework. Coredump collection is disabled by default and can
>> be enabled using menuconfig. Dump collected for a radio is 55MB
>> approximately.
>>
>> Tested-on: qcn9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> 
> b4 shazam reports warnings when applying your patch:
> 
> Applying: wifi: ath12k: Add firmware coredump collection support
> /local/mnt/workspace/jjohnson/kernel/ath/.git/rebase-apply/patch:35: new blank line at EOF.
> +
> /local/mnt/workspace/jjohnson/kernel/ath/.git/rebase-apply/patch:230: new blank line at EOF.
> +
> /local/mnt/workspace/jjohnson/kernel/ath/.git/rebase-apply/patch:298: new blank line at EOF.
> +
> warning: 3 lines add whitespace errors.
> 
> 
> 

And ath12k-check reports the following:

drivers/net/wireless/ath/ath12k/coredump.h:1: Improper SPDX comment style for 'drivers/net/wireless/ath/ath12k/coredump.h', please use '/*' instead
drivers/net/wireless/ath/ath12k/coredump.h:1: Missing or malformed SPDX-License-Identifier tag in line 1
drivers/net/wireless/ath/ath12k/coredump.h:59: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath12k/coredump.c:11: line length of 93 exceeds 90 columns
drivers/net/wireless/ath/ath12k/pci.c:1339: Possible unnecessary 'out of memory' message
drivers/net/wireless/ath/ath12k/pci.c:1388: line length of 100 exceeds 90 columns
drivers/net/wireless/ath/ath12k/pci.c:1398: line length of 93 exceeds 90 columns


