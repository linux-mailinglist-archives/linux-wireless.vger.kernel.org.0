Return-Path: <linux-wireless+bounces-26470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF5B2D59C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 10:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B9D162ED1
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B370E283FC3;
	Wed, 20 Aug 2025 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BF5Kq+K/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5B24A047
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676990; cv=none; b=sUiEzwMILCbF1pnNETLWijcQIeeUvJ5rCBpMR6Wv87LO21Sji8HJS6YkcOCdb+QJpMceYacH8/iu5tScyYHSz5XqWbTR6r4jnuOz6cY7uwtymukT42b0AD5nUXaWoxZz1g58WdzS5IherItQmtn4nWMu4o+8+YqW4+pNAC7Sf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676990; c=relaxed/simple;
	bh=CggaYe6pO3ch61TJ0T9xRaJDiCd1exJq8Ey1hm2BEBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UIsl55HZn3nI1qFYhWRar0gqM0wF8KhZZ9MKFphtl4bbE2kS/1w1MzUVefU8WVrhaPkcen9dt20K2+klqOT7AtMl5hwz0F1/rmR9SeGOj8vPMs7qVkWspED1BFUsMJl1/+OMydV4c/cz+x/Hc4FRi7PI+/5blTPcj5OGvABQw2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BF5Kq+K/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oexx025306;
	Wed, 20 Aug 2025 08:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xPQ251smWtJsbj5fDFVaalU6xEJ8NszNtoU+cNd16w0=; b=BF5Kq+K/U6Gg9Nk7
	tKeoDg8qSISaOBedwwXerb7n9NCt8EL1QEF1c9AXKEgalQpcsdd1WXViFFkYokaP
	Ddeks8+0Fm2L90r9sLcHoaAtnlxYUpMRFHtX4iJHmSFTg6+1DjV+MQDY1JiV00VP
	XL+5hIJ8G7WVYdn+g+Ol4ha40ylg7CwBjRDnJma95MChis5h7R5rrAEZT3dV8dsl
	IRDI5GXTU/84+2owqNtu/d1NLFGqla5IxZtY04GdKsl6b1BD+icqehzy9U3biXa+
	M1kk1QTi2pH7LP0DsaxBpc6RvXE0DMp53A00EqGQOuC1aYyAH6qmccO8wT3G52Kt
	R5EUFA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a8wrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:03:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57K832fZ031587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:03:02 GMT
Received: from [10.216.47.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 20 Aug
 2025 01:02:59 -0700
Message-ID: <69f3fef9-017d-86fa-8fbb-2ac2a1df8ae4@quicinc.com>
Date: Wed, 20 Aug 2025 13:32:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
Content-Language: en-US
To: Balsam Chihi <balsam.chihi@moment.tech>,
        Baochen Qiang
	<baochen.qiang@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <jjohnson@kernel.org>
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
 <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com>
 <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
 <ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com>
 <CAONkfw4hkDQtJyOj4RVsR3V=FJDJYKnjtmqzD=jBMy1ax=tC_A@mail.gmail.com>
 <0dfe48fc-085f-4dce-933d-e0f132d2ff9c@oss.qualcomm.com>
 <CAONkfw4p1AuE-MhGiZNMmi-PXR+CjoY63K2Yx_dmv2vnjo-Eyg@mail.gmail.com>
 <CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4gAtr6cl3EjhUhTzG5gal5JCiX3pzuTH
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a58137 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=3cWLWNXYlCYREKE2kekA:9 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: 4gAtr6cl3EjhUhTzG5gal5JCiX3pzuTH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+fU6JEEftabF
 sm4QHgXdap2Mo1V5xMXaSN14zGKu3tgK4BoSqCnsWtJEeyAscb34+h2YCAIDJyZkxHKmYaF0VP4
 gYVH2GyGEQjeFjzUr8Nxzu/08KpWdmOQZ7NxmSyX5sURkLw9nJdyQ+jIevIg9pFas0tnzsaWUve
 3Z6pFXqLv/PxOwHSAIIc2tgaxj3qNfW6Uc0UNKDAghrIWl+vZ0cc80SRrDIptcKwYCRSwpT21K4
 pnt9InpCN8sZyJc5UZXyG7eHxSmO2UoNzTf6hI9OJgoGGz4rkxZt2odEz6gpJBY2TwhBHErRK/g
 V5Gqjluhvyxmxq7WCM69p5Bnohy4UHGsKDR/hLWezSOuw8B2bsyR6FjCzoyjSAoAfaBUT0sKOlv
 afZxcYqa8bVXATKJ7Kx+os1ycVJBAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/19/2025 2:20 PM, Balsam Chihi wrote:
> Hello,
> I Have a question on the same subject but not related to the bug.
> I have many identical PCIe WiFi cards on the system and I need to load
> a different board-2.bin on each one (1 adapter per frequency band).

So you are using multiple pcie devices at the same time in a system
with ath11k? Wondering if you are using any private patches to address
QRTR instance id clash issue [1][2].

> Is there any kernel built-in solution for that?
> I could not find any, so I had to create a patch that loads a
> different board-2.bin for each card based on the pci device address.

Current board data selection for QCN from board-2.bin is based on pci+chip-id+board-id
combination, not based on pci device address. You can find the chip-id and board-id in the
debug during QMI boot stage. Then you can use ath11k-bdencoder [3] to encode those
board data binaries into board-2.bin. This way you can package all the needed board
specific binaries for a hardware into a single board-2.bin. Ath11k board data file
load logic uses chip-id and board-id to download the right board data for the given
hardware variant.

Vasanth

[1] https://patchwork.kernel.org/project/linux-wireless/list/?series=692423&state=*&order=date
[2] https://lore.kernel.org/all/20230111170033.32454-1-kvalo@kernel.org/
[3] 
https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath11k/ath11k-bdencoder

