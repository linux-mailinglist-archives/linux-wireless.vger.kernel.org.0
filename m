Return-Path: <linux-wireless+bounces-20303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87308A5EFD5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 10:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD063AF33D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 09:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035C31F03CD;
	Thu, 13 Mar 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bbZLkgWp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA721EF37D;
	Thu, 13 Mar 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859121; cv=none; b=bcc5E+YckDYVikwK6VQRubcYuy3aGaF4LtrQvSwt68ThtQpBNeKMzVCvKqYAoyg8sI+Wwx4bxcWwVvqgWa7IfEwXyaAxEzfFoPgekxE2x3EUBaF8zdWY+8cYbjtBDJO1oFkJ+CJOryyzDKmq18uYmds0Og8qHl1Kb6jKIlN8GOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859121; c=relaxed/simple;
	bh=cmvhZ61KuCH6EtGoYseDt8GjbPbuKre81gGxvuEtC3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NYJDDuJAKeLO73P8uUsIZAUbLPS9stAeuA9xeUiU9KFHEcR/PV3AgY3dlgtLReVBpZTxevq6oxDCdv59RjLjgLNHs96jTJfkwtMQ3wjZu+rfTK9ASmsjFs79E+AehP/UD5J15obXawibReB1mOX/XQ7j/yULVi30VbNdyQL2AjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bbZLkgWp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D9A5DI018566;
	Thu, 13 Mar 2025 09:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cmvhZ61KuCH6EtGoYseDt8GjbPbuKre81gGxvuEtC3w=; b=bbZLkgWp0RM2P9bz
	wbHiVUO7Z8sHTU5gLF9H27Ixd5zDKFg5/0lyWQkFp8kzTzWd+aJ/7FCvY6eyCsWf
	UfljoXThpTVFkR2BCiEvDxQIBy1Iwp2lbKWx8//nLOejAr/Wa5AnLY/vWDskIXB/
	KfQmXJrbEs4xjk8c3SssoLnYEkUDHaYK48pbSHiKWFpZ1XN2JmH6iCSEJF3GUVkq
	dxSww+BPwj8d7r0+zRzH5qbMXfWnuEAI3SVsSUz5fkNU/OaqZN4XGS+2dhI+hINR
	45zW8zqlmkYpWfBxIPOrVa7b0c20PUZD+QUaMTWx6GrhHsTZYjB6rjO1IvsprFO1
	U6JhhQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nwdhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 09:45:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52D9jBpr002714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 09:45:11 GMT
Received: from [10.152.204.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Mar
 2025 02:45:08 -0700
Message-ID: <a44f064f-19fd-16ea-222f-058486698951@quicinc.com>
Date: Thu, 13 Mar 2025 15:15:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: limit WMI_SCAN_CHAN_LIST_CMDID
 argument size
Content-Language: en-US
To: Mantas Pucka <mantas@8devices.com>, <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250310-limit-wmi-chanlist-v1-1-8f0fb45459a7@8devices.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250310-limit-wmi-chanlist-v1-1-8f0fb45459a7@8devices.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KnHX6KE_wvA54Rygmqn7yKA4oBbVvE17
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d2a928 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=HwlXlOyzY4lq39rnBK0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KnHX6KE_wvA54Rygmqn7yKA4oBbVvE17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130076



On 3/10/2025 6:58 PM, Mantas Pucka wrote:
> When using BDF with both 5GHz and 6GHz bands enabled on QCN9274, interface
> fails to start. It happens because FW fails to process
> WMI_SCAN_CHAN_LIST_CMDID with argument size >2048, resulting in a command
> timeout. The current code allows splitting channel list across multiple WMI
> commands but uses WMI max_msg_len (4096) as chunk size, which is still too

Did you have any private changes to increase the message_len from current
2048 ot 4096 bytes? As mentioned in a reply for your other patch, multi-band
in qcn9274 requires additional changes in driver, only scan mode is supported
even with those changes.

Vasanth

