Return-Path: <linux-wireless+bounces-4750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1F487BEF6
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 15:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD27283BA1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10768DDD9;
	Thu, 14 Mar 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hdBsFs93"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAD3D75;
	Thu, 14 Mar 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426812; cv=none; b=VW/SlqcPDBoD+X5VMH6ON/Ix6Q7a+ziOSK/gP2GLaYRRAb/AjoP6qQFqsCkd+SUTcJ8XUUvjBVXeREiTEm3SzWvIeutA7g4l2AHaXaAr7achUfvDid9sgkkVEShBAKV3/QJr1zNrFbWFtOu+VSC+UgcjqOPngOHB3n8u76ZpgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426812; c=relaxed/simple;
	bh=RQEhJycmnD+GTu7ulwMsJeopCZWGUlE1GdYGqUm/zAs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=l7mUWAt0f726ObWN5iyrx4KnwHKafALUPDcYVRrp1TVmV0AbF5zcx855/oP/0vyRm1ULDy5yyYRy/rw+KuUIQ9brAVRC6PvNVl1hl7IGE5klOyQskWgQVQ59n85TymXBh7Ngtw3ydFf4V9KXixz1GFN8cUFMkZKs0Qd9vFHl9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hdBsFs93; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EDPMYT031420;
	Thu, 14 Mar 2024 14:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EDdOuP0IcKfvZiH2PHtMx6DgD1mTQ7rYx6J0o7ctw4Q=; b=hd
	BsFs93sGYoVWM3tWiRLXXcd5cyk0S2Y77YwfJfEaQaAwWwniNSogoE6A7i0RzLmu
	TSggzjZt8kYBLU8FJZu7LShlO7mmFVgi/IZEy75tZZD+kztemyuoKQDv0BiBKRfz
	YgEIcv8vT1rAhY70jYyKP7aWmJfEqhd0wbrHtytMR35+bVwFRpJRcIguuA0ehTFy
	dcfbcZDcl5Hy1YsOZrNSrP92dufsfW+hyQMtrAlXtoRv+p2wTZOnJezXtEx9nj56
	HCX4Rv9tmfe3NSx23WLz8O0smYoXfrGJ0GijwLMwZ55Tx1oTbpNyIR5O1Zs4qgI5
	kgJME1Z+K6gUpLiehmeQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv1njr7ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 14:33:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EEXKoc005899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 14:33:20 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 07:33:19 -0700
Message-ID: <cbedb60c-c849-4b7e-a00e-c75ec8429adb@quicinc.com>
Date: Thu, 14 Mar 2024 07:33:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Marc Gonzalez <mgonzalez@freebox.fr>, Conor Dooley <conor@kernel.org>,
        Kalle Valo <kvalo@kernel.org>
CC: ath10k <ath10k@lists.infradead.org>,
        wireless
	<linux-wireless@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Jami Kettunen
	<jamipkettunen@gmail.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <20240229-ageless-primal-7a0544420949@spud>
 <c48ead11-0e2a-4066-b324-84f802215c9a@quicinc.com>
 <2f588948-0261-4985-91e8-d5060e673cd9@freebox.fr>
 <15db6593-c474-43a5-ad20-b0e108137713@quicinc.com>
In-Reply-To: <15db6593-c474-43a5-ad20-b0e108137713@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lKXh_mzFN_bymXp-uCFqzuTQ-gzjevr4
X-Proofpoint-GUID: lKXh_mzFN_bymXp-uCFqzuTQ-gzjevr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_12,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403140107

On 3/7/2024 8:46 AM, Jeff Johnson wrote:
> On 3/7/2024 7:29 AM, Marc Gonzalez wrote:
>> Have you heard back from the dev team?
>>
>> Do they confirm that an issue involving missing MSA_READY notifications
>> was ever noticed?
>>
>> What devices were affected? (All msm8998? A subset of msm8998?)
>>
>> Was the issue eventually fixed?
>> (Probably fixed, otherwise newer devices would be affected)
> 
> The feedback I received was "it might be ok to change all ath10k qmi to
> skip waiting for msa_ready", and it was pointed out that ath11k (and
> ath12k) do not wait for it.
> 
> However with so many deployed devices, "might be ok" isn't a strong
> argument for changing the default behavior.
> 
> So my preference would be to use the firmware capability in the board
> file that Kalle has recommended.

Marc,
I finally have an engineer who wants to research this further.
Can you provide the kernel log that shows the firmware version being used?

/jeff


