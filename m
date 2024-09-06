Return-Path: <linux-wireless+bounces-12611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B9796FB51
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 20:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2A281F14
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA813C3F2;
	Fri,  6 Sep 2024 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nVDCSPOE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F723FB8B;
	Fri,  6 Sep 2024 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647905; cv=none; b=YoLLHdQvATp1rBD4+jZHW+/Ojb2Tx4PIYvFBCrPQ+pu1gh2+86shqKMpo+vN/soCKAHqkUZpZAgyVy/9j+o0nYx5cb7JFOtEJj7F16URX/rQiwgSRd6Dlijq5TScUqyUPuUFT7bc+U/3fdLlQE3fusU829kx68F2gp/YDLIApmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647905; c=relaxed/simple;
	bh=krEvvj6ryDG0HcWRnqPIFYM6AUVHodRtXa8xDOKknTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OenpBVlINDgfJVAKFpIZmOZQ4yltZr/oGfRmYe0SnHliJzVmPtAe38qvWtLhf6f2zR+MO3OTPTx8XJ0CUyGz0ZIHVxH0xCx8tvaNokhZMZdDTvojR2Gu59/kuwocsGLmpD29Qt58i+2G4YHnhh2fST4wBM7D3DZQE+TbiN8ApIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nVDCSPOE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4868YIJM032629;
	Fri, 6 Sep 2024 18:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CIe/mcRmIOgwDEvWBcGTWDvnQ2KluYGPbNhonz0OWpU=; b=nVDCSPOEHs9oAW5u
	URoeclmDMSEFchBuRrvrhePsBPh8IfAHbHsdpWv/8+YeyVDqlt88tdb8UVEEIPer
	FyWeqwhFWSmmjNUDwKho3dbxkxLUTYJ+MAV9ox3Up8EgI3aJnRnow2IqYWr1kI7/
	YGNDs2jIab3rzQU+XYykqzQHSZ+3/P81vnZue55thlFYpb7SdGWcwRW2GgU05mcm
	iKVW1MvD7ytz4Pg6D1xS9ehovbpOHeDVF9/oUGLh+Qory0xF2bb9OA0G3qg4YsSV
	3TfjwJ0TviwIkngqeA4dvnkZX7IZKD6xFWRLnSOiF4NotEtAOgibAXSWQ9qMsl1H
	iknhmA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwtb87r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 18:38:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 486Ic8OP008394
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 18:38:08 GMT
Received: from [10.111.181.108] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Sep 2024
 11:38:07 -0700
Message-ID: <1e77b503-36ff-4a97-993b-f87d658c9970@quicinc.com>
Date: Fri, 6 Sep 2024 11:38:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240814082301.8091-1-brgl@bgdev.pl> <87a5hcyite.fsf@kernel.org>
 <CAMRc=Mcr7E0dxG09_gYPxg57gYAS4j2+-3x9GCS3wOcM46O=NQ@mail.gmail.com>
 <87y146ayrm.fsf@kernel.org>
 <CAMRc=Mfes+=59WP8dcMsiUApqjsFrY9iVFEdKU6FbTKAFP1k_A@mail.gmail.com>
 <878qw6hs4s.fsf@kernel.org>
 <CAMRc=Mc_Qy6-Rgsw_uOweUXtoiZGMR0D22Ou9nXUJDDdPCZqLw@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <CAMRc=Mc_Qy6-Rgsw_uOweUXtoiZGMR0D22Ou9nXUJDDdPCZqLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nxSgVBbnrS-V-S73ijR707OYrT48BYGa
X-Proofpoint-ORIG-GUID: nxSgVBbnrS-V-S73ijR707OYrT48BYGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_04,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409060137

On 9/6/2024 12:44 AM, Bartosz Golaszewski wrote:
> For upstream - if you're using the WCN6855, you must specify the
> inputs for the WLAN module so it's only fair they be described as
> "required". For out-of-tree DTS I couldn't care less.
> 
> You are not correct saying that "M.2 boards don't need these" because
> as a matter of fact: the WLAN module on your M.2 card takes these
> inputs from the PMU inside the WCN6855 package.

Let me start by saying that DT is one area where I'm a newbie, so I hope I can
get some education.

I'd like to start with an observation: I've used both WCN6855 with ath11k and
WCN7850 with ath12k on an x86 laptop without any device tree, so from that
perspective none of the device tree stuff is "required" -- these modules "just
work".

However I also realize that when these are installed on Qualcomm ARM platforms
that there are GPIO pins that control things like XO clock, WLAN enable &
Bluetooth enable, as well as voltage regulators, and the device is
non-functional without those configured, so the device tree items are required
in that environment.

So just from that perspective saying something is "required" is confusing when
there are platforms where it isn't required. And perhaps that is what is
confusing Kalle as well?

/jeff

