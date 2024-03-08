Return-Path: <linux-wireless+bounces-4479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12965875D39
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 05:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE7FB218AF
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 04:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92E12C1BF;
	Fri,  8 Mar 2024 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hKwjVuoA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA318E01
	for <linux-wireless@vger.kernel.org>; Fri,  8 Mar 2024 04:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709872850; cv=none; b=Lzt0EBB+Tr4M8zTdMuf15nyOoPklUQoj1IXb9ooe8pXTMoYNWIEkpnlrjy3+jJvLctC1mYOz5xyCcYhPuZB2omOh+xtlcNB25vnC0KQuohhN+5fpVXFa+/+I3aMQn+4hlljX5oS+nlAj9rueNhCR2JuhCZ+tfkHKlKOY8cqWfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709872850; c=relaxed/simple;
	bh=XqT4/gRCmAETkS96ccpdlt8Xk8fEoaWZ0q/ouj8+lVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JJp802w62KWAmC2ojzG7zNlaFOci3erzn+qrEFJdUuZZ4zrO6kMbOqB7N65DKayYNzIj1Vr742DEMzBYWsNpK2uPzRn5ZMiCY/lumPlsf7EZgDfK7yEi4BK3fcVt45fPTika93V4c94WDN2wJlylclbNWJChemK68nG5If7N6Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hKwjVuoA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4281QHl5030119;
	Fri, 8 Mar 2024 04:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XqT4/gRCmAETkS96ccpdlt8Xk8fEoaWZ0q/ouj8+lVY=; b=hK
	wjVuoAYZbP6es5S0ctj3lB7BV+OdVmcpkWUvz9FLL5W1SXNIRXoTKCMBNl6z2u9v
	cQA2jGBmP6hw6WiPIhShajyIkTrfww5uWQueOa4i1s8DHAj9lCUUHyp01HVKHYrF
	3HEL9Spdusex7PTBAvcEY0POxnDEMt0JvvL+c4MoFeQZPvcw0Md3VX5FMPePk0Ib
	Ur+NtAQoV0DklWW2D2xT+QxU5io62cq8iGh/KX2PgDPpD198K9T7cmAf6k64JQGH
	RRAYqg6PBx+SlBEuwg/ODOc6LOs/Y85quJULf/1VVX3AkB/fkwGb+hIcg3IYl/Sx
	YF5b+R/q3OYq5reCjDVw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8m0reu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 04:40:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4284eY7A016290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 04:40:35 GMT
Received: from [10.216.30.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Mar
 2024 20:40:33 -0800
Message-ID: <9856e0e9-2ddc-48fe-86f1-b6b32fa09ceb@quicinc.com>
Date: Fri, 8 Mar 2024 10:10:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] wifi: mac80211/mac80211_hwsim: support MLO CSA
 test case
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240216144621.514385-1-quic_adisi@quicinc.com>
 <83af2d42df024032d1bd1c200c774b7ef10f1705.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <83af2d42df024032d1bd1c200c774b7ef10f1705.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y4bcMPcXdivtCVOvZq2aWqqVvH5RzL4x
X-Proofpoint-ORIG-GUID: Y4bcMPcXdivtCVOvZq2aWqqVvH5RzL4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_03,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=606 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080034

On 2/21/24 15:38, Johannes Berg wrote:
> I also wanted to ask though if this needed any hostapd changes?

Here you go - "tests: Add basic MLO CSA test case"
(https://patchwork.ozlabs.org/project/hostap/patch/20240308043508.14853-1-quic_adisi@quicinc.com/)

Sorry, got little bit delayed :)

