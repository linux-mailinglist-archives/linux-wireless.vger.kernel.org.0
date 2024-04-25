Return-Path: <linux-wireless+bounces-6861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047A8B27B6
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 19:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2056F1F24732
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B470F14EC49;
	Thu, 25 Apr 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eGsfaDCk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F14D14EC4A
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714067196; cv=none; b=e1s0WkYyPEP7RAy9y3MHvGEQBOkgCfH2WL/9Q1lkhGQopAMg2r7xJn8NKIaDF7dKnAfiACpt7bUPQJbNe6iSz9E8W1a0Y1T/W93p2wT8AT0cX+tsFZ8LXrYwgi+uI6lZd3Jul73M0j9gmjBABJ+CbbC1YgsWqM7Opx7Djai/1wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714067196; c=relaxed/simple;
	bh=jgOCn2oCavRMwDGxyW2qQ+dYmDLR5YDu4osbkHryxsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CtlBLl4EpeC/6cXPyTRm7CuoLOvJBRBA+QzbdaNu6F/XFCabsKGsTWRMsZvMDLzLf36poz8TIjvcdtKP/TRJkBTGohE2O0HwSwenSY7Ie0eIHmTbUoEIWVwrmjmpInDM+RfsLU/raDHNjCIFIcWeKHgYhUqsl2WfiXXHGxByLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eGsfaDCk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P5fQC1017549;
	Thu, 25 Apr 2024 17:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=glA5mBnxDW3mPsmPjRsO5HXkPcBbEBpIEBumchDdjJU=; b=eG
	sfaDCki10LsLbcHA3kYrUecIBm8eS2adBDWd1TffwCI427Ecg0PGD4fMUBW6vCdj
	5kUJe21efs3QWoY8O1lgdgg7LiFU8aJhcY0SIo4Va1c2MHDra0jtoEdsHxhi5Wb9
	6TwuUjC6ZHUtUYcM1W9Pg//mN5cX50ZuHpTsYgDVHZoL2+PxzjC88X122X0JSrp6
	4NldxagUIydzi69I9mdJ80GEAmCSfVcTB4dU2PvV+TrkiHGSFvXZwv2sdmflBvLJ
	uZi2fn8IAmsP6HNs8oZpa0u1C6kpBTEdtgRhWfKHKhRacyo2gG+cX+FcDG298bRm
	3ZdS29Km9m1HSCV25GQg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenhuby8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:46:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PHkVWZ027585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:46:31 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 10:46:31 -0700
Message-ID: <b1a18103-5663-4ff0-9a3a-498a2220e2c5@quicinc.com>
Date: Thu, 25 Apr 2024 10:46:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/6] wifi: ath12k: fix survey dump collection in 6 GHz
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
 <20240424191141.32549-4-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240424191141.32549-4-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4hWd1J3aj1hkJX_s3H1q2EmI19r0sIEM
X-Proofpoint-GUID: 4hWd1J3aj1hkJX_s3H1q2EmI19r0sIEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxlogscore=811 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250128

On 4/24/2024 12:11 PM, Pradeep Kumar Chitrapu wrote:
> When ath12k receives survey request, choose the 6 GHz band
> when enabled. Without this, survey requests do not include
> any 6 GHz band results, leading to failures in auto channel
> selection.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

again not propagated from v2
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


