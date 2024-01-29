Return-Path: <linux-wireless+bounces-2649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3DC840283
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624B21C21F1E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B355E51;
	Mon, 29 Jan 2024 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K1jPv0J9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0120555E75;
	Mon, 29 Jan 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523053; cv=none; b=uOFSupUyYff0NJgMvZy8hRDBO3GoiIo4zGdeXQYBq95byoHBBQqwhOZSjNXT6K5REXUEOO0hRZTgHhZGpeN1jXp6Wz39QvgwbvCqxAxQzhjBClJroXBXZoWARkOUWaIcwGP5NwdA3RrL8ywTvxXLVB8Unmtby1B4CdOwbZ6yT/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523053; c=relaxed/simple;
	bh=aUAyeh8hCjKA1LDSrtdl2UuaMoLoprmNE6INQxZReKg=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=Kbc06diacrIhSXkDX9ESXFqjrmzeGZbbPGBVQpwiYwu2DLMHlWFnNPfOmP9n8iTkXanmeGE61kODa2mbWhQEnqLSplAHzRYUDcvuCykLqSsibA4jawZH+B9necMq6lYWLXx5klztkJsDuXGD7tz+0UC7CtEu8+vS2nDTEudJp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K1jPv0J9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T9VFYZ024381;
	Mon, 29 Jan 2024 10:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:to:cc:subject:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=3RJdt4HZT0/lsSk3pmr0
	LA/dVSCwX27tK2gaoXum9Nc=; b=K1jPv0J9ZR60+yCyXGp62pHwB+JrKg+Mzo0w
	kJ2HvKbq/4vbNiJBiC0l7XSZwBoR1r4kk+fStO2Q+7JCTSYHCNeflQMk2u0v32qT
	cu/VQYj3N8GUmDKsXQVJNBuwPawQJiPOUs3LjukD8K3B8sMfzCtzf18IIqHfO/rp
	5VF6GNKJqAXSF7SZJ4mF6AqrcuP++Sn3xN4v3QtVHNQWy3pww3aHoqd69D2paaSn
	y0nn6rZwsEtIwNRS4DVHmkWp258sbahL6BfdkuWNBny7VuWuO5sUyd9w8+6DNlEG
	XiXnFCxriZrvlMMwesXOduC/1fZV7ze0cERoDJduHH4MPQHsuQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx86hr7t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:10:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TAAe9F014561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:10:40 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 02:10:34 -0800
Message-ID: <21cd2098-97e1-4947-a5bb-a97582902ead@quicinc.com>
Date: Mon, 29 Jan 2024 18:10:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <rafael@kernel.org>, <pavel@ucw.cz>
CC: Manivannan Sadhasivam <mani@kernel.org>,
        "Kalle Valo (QUIC)"
	<quic_kvalo@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>, <linux-pm@vger.kernel.org>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
Subject: ath11k resume fails due to kernel blocks probing MHI virtual devices
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: saXM1sRVGRpu7ijQ6uFEfbdSF65S4T9r
X-Proofpoint-GUID: saXM1sRVGRpu7ijQ6uFEfbdSF65S4T9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290073

Hi Rafael and Pavel,

Currently I am facing an ath11k (a kernel WLAN driver) resume issue 
related with kernel PM framework and MHI module.

Before introducing the issue details, I'd like to summarize how ath11k 
interacts with MHI stack to download WLAN firmware to hardware target:
1. when booting/restarting, ath11k powers on MHI module and waits for 
MHI channels to be ready.
2. When power on, MHI stack creates some virtual MHI devices, which 
represents MHI hardware channels, and adds them to MHI bus. This 
triggers MHI client driver, named QRTR, to get matched and probe those 
MHI devices. In probe, QRTR initializes MHI channels and finally move 
them to ready state.
3. Once MHI channels ready, ath11k downloads WLAN firmware to hardware 
target, then WLAN is working.

Such an flow works well in general, but introduces issues in hibernation 
cycle: when preparing for hibernation, ath11k powers down MHI, this 
results in MHI devices being destroyed thus QRTR resets MHI channels. 
When resuming back from hibernation, ath11k powers on MHI and waits for 
MHI channels to be ready in its resume callback. As said above, MHI 
creates and adds MHI devices to MHI bus, but they can't be probed at 
that time because device probe is prohibited in device_block_probing(), 
finally this results in ath11k resume timeout.

Now there is an potential fix to this issue which would needs changes in 
MHI stack, i.e., don't destroy MHI devices while hibernating. And we 
have had a plenty talk with MHI community regarding this change, see [1] 
and [2].

However Mani (the MHI maintainer) doesn't think it's right to fix it in 
MHI stack. Instead, he thought we might need to add a new PM callback 
which will be called after device probe is unblocked. By registering 
such a callback ath11k can wait the dependency driver, i.e., QRTR, to 
probe and initialize those MHI devices.

Your thoughts?


[1] https://lists.infradead.org/pipermail/ath11k/2023-December/005098.html
[2] https://lists.infradead.org/pipermail/ath11k/2024-January/005205.html

