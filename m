Return-Path: <linux-wireless+bounces-6862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D22C8B27C6
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 19:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEA91C20D59
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 17:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B568814E2F8;
	Thu, 25 Apr 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YKZDLtAM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54C14E2FA
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714067651; cv=none; b=AKesiaP77j1bHF5xBhw+pU5Nf8yscGybfdbcMp0RL4YYuXe6VJan6CTp7VOvQJ2T1fQdAo9buwifKpHb7PVqo5YwqaEcpmr+40u4YHgcJh7Q8skAotxNWeqO0DdJTAVQT0NW5yWEeBu+AGYH9SGi38Fq4DLJDBymaQqG62D3A/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714067651; c=relaxed/simple;
	bh=zKwzaDfigzutR00bKawWE/7deoYHc+LYoHAlz249euw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sm3CBHPxrLSp5BZqW51yqVJjzGLhPLwMWYWhq6+JrA/QC7sf3aTFiVdGACIlxklW658RAAvGj1YZBmuU9EEX9qfkN2ftO0Dr5T7vUuvrKrXY1qg1usMiVcBbJE40PNeuhMK3cfiqRsWI32s5wZuhWXIGj/WZpd/q/Zc9OJXixUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YKZDLtAM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P5bHg9019195;
	Thu, 25 Apr 2024 17:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2Na6ad40206QPDp5o8TaF7vesMMfV9eHR8tgG5QqC6g=; b=YK
	ZDLtAM2QP1GWYtcRltxJCqFN0jkQGENSGviF0iAsVQ8cZkdBhg1YE+RqcmoBOYDa
	91uex4++JeiCpAspCXJx1L5IjLHDMfSOJ2XSn6dxqtgb1Ek7yHaoau+lgTR1n7pP
	e60ayLeeGAsBSMAAlmmYDpk4ZVh7gIAcejJR9bFlRo3y4KebtT6/1DxqM/Zqn2Mk
	fcg4emILbVwmyF4k55ZZyw5YmZQlcj2xxvQZevcxtoV6tO78WrtVRIoGFm3NctCb
	qURD7IeMWQMXa1fCDtQkM+0L8ASWBKkXNdvbjuIF2jkkQz4r4AqQ2iZZuzRDGhXH
	j9Fvc8TRmUcgE3EnViEg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenkb846-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:54:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PHs4xx022455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:54:04 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 10:54:04 -0700
Message-ID: <c7097676-439f-4dfc-abca-8b7ed8f5fb99@quicinc.com>
Date: Thu, 25 Apr 2024 10:54:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/6] wifi: ath12k: add 6 GHz params in peer assoc
 command
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Avula Sri Charan
	<quic_asrichar@quicinc.com>
References: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
 <20240424191141.32549-5-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240424191141.32549-5-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uBdlG8xjpMIhTyLvh2sCL0JvXMoAK0TT
X-Proofpoint-GUID: uBdlG8xjpMIhTyLvh2sCL0JvXMoAK0TT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250129

On 4/24/2024 12:11 PM, Pradeep Kumar Chitrapu wrote:
> Currently A-MPDU aggregation parameters are not being configured
> during peer association for 6 GHz band. Hence, extract these
> parameters from station's capabilities received in association
> request and send to firmware. Without this, A-MPDU aggregation
> is not happening in 6 GHz band.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 

why was the following dropped that was present in the prior versions?
Co-developed-by: Avula Sri Charan <quic_asrichar@quicinc.com>

> Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

pending fixing that,
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


