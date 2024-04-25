Return-Path: <linux-wireless+bounces-6859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA23C8B27A4
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 19:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A857286607
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E6514E2DF;
	Thu, 25 Apr 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hTDj7qzT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596D63BBE6
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714066466; cv=none; b=KF7X9qyn3E+ZxVZeEJA7LZgkvx5SvOBKqSrbUeaUR4Pwx7h6i/9++CVRiNDPOZKvfK1iPFDSo0SJ8hl/gcEO28TXp3hlXn1yFRGD5H+DZ5J1IC6P1OLzIuf8i/cPMGYBi4XuY0PgSfzVbdoPHGTMV836AQxbvUyuFT97bYVmUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714066466; c=relaxed/simple;
	bh=1BE0sx9NUuZjEp1CYKAOkGOhf9nJ8M8Iadt9yZabG6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B4tHajW13lb5x1SH0KZkL1CIh22lgYwtkD8rKFSRXL/Ba4Jio7uP377i/ifuGtBE/cWR26LaJdEQBFs0qOjra8tbPiP6gsggOLLXd9D8RNUrHYVaRsHLvStJyIfjNvI63g29R1X7cr99laxY/KPg/uheQdoBqzisl16FgLgUuHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hTDj7qzT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PC6tSo004646;
	Thu, 25 Apr 2024 17:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WrjJHZQMIBwHrFA/rzrIhqUmfSjUkitaRUQRSkxYy8A=; b=hT
	Dj7qzTsRRRq+329yB6tOg4hH9XDlkJB5mD+zYRv0t1Zaszm7RwED2n7J5rPiSq1Z
	KimpOeI9JosB5Zz7HKd13AuAvMmlME7syk/Ky7jEXyTSFabVXuP6BocmTa3oK9VT
	YtDrk+0BwRl3CHrsfJJE8awBKCPqWY6Rj4wzyc6RNq9ifeQMFTfqAPOUeQ69bBYA
	khgRmNzfsTdFMag/d/cMMTPLizWOMP4jXsOKPmhE0x3JHgaC2SyQg8M0f3hnEtQw
	p94FkRa0MrJuBX046s9758as7orB9X1L7n/uhVJFo7ukKMLkyum6g00WZp+QgU+r
	FCJ2XCNU94BN0tYgiIKA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenkk9ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:34:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PHYDR1025098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:34:13 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 10:34:12 -0700
Message-ID: <08cda85b-e2b2-4c73-a41b-471dec080508@quicinc.com>
Date: Thu, 25 Apr 2024 10:34:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/6] wifi: ath12k: Correct 6 GHz frequency value in rx
 status
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
 <20240424191141.32549-3-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240424191141.32549-3-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wDi2BfAWhzHs6zqkEC2vfD-_g8NZhudz
X-Proofpoint-GUID: wDi2BfAWhzHs6zqkEC2vfD-_g8NZhudz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=742 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250126

On 4/24/2024 12:11 PM, Pradeep Kumar Chitrapu wrote:
> The frequency in the rx status is currently being filled
> incorrectly for the 6 GHz band. The channel number received is
> invalid in this case, resulting in packet drops. Fix this
> issue by correcting the frequency calculation.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

again this should have been propagated from my v2 review
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


