Return-Path: <linux-wireless+bounces-1993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBEF82F48D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 19:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DFF284A9D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 18:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A71CF81;
	Tue, 16 Jan 2024 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HR6/bxy5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567991CD33
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430847; cv=none; b=tKJSzwROZSGiydEScYwonv6EdLgWXkQN6iji54IQ6ZQmFpVciWLCpF4K4nMW+I7Uau8pS+HPxgrtlNu0XF6VN6qtj4AvtuV8EMjBHjtOqT7GDukUyozhwHmtBLRkIvKhR/1eolrHkoWIGzrFj5zt4ijpdkbR+J4cWCJfNQdhno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430847; c=relaxed/simple;
	bh=pesjpPjmM6CHAavIaUKv3Ij5x16JsHQo8O6+iB4R3sg=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=I1N7I7JlAl0drjhL3tfAkQgcHI9mjltL3fH7yBp9iR8wX4lUdT/o7Xlbw6KIc6c4RfOH1yI4Fav4Qc80w26fMjU+lLoOHjcIRpXbjI1JqwMChzlohIQ9ndD68fa3ADoPpNbHHwrE3DrXDxF5MB+jDPWdowQsOWaikMklOmfv5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HR6/bxy5; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GHeIhf027111;
	Tue, 16 Jan 2024 18:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vUDCpT90dG8/HzGH6UiXotTVBpfgMjkPr9rKU+bxjKE=; b=HR
	6/bxy5UbAr9DiRdS5vJWM5K/oeywOirJZ5i4CAcZO6SBYlQP6OtPACh4Pu/a141+
	z4gQ47w9vBJIm2y28M8dC9HHc2sA9N/1ubATys9C306fkqceMBkWhPMT573oQFHU
	7YTo1Lj4A52i7Fz9C8L0o4biPBAVHJ9ceCmllPcU4Zq2WryGsLR4jbjSA1oNeZKq
	9H6sHmJq8KWIWtiw3af8KSAetIKZZ3kuV7bfnn4hOW+DSrcdY9Ts9N8rwgjzE8mC
	chtgQzv/1rGS3sxCSo59+PJOR4OoPoOTRb1TkWWuPYMk26T1f6gE4+0L85ljUWGf
	LKx6qdWZLgsDlNEBsUWA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnnvbhhtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:47:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40GIkxHt020105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:46:59 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 10:46:59 -0800
Message-ID: <b5f39cb3-ec5e-40f0-bf29-96175435c0b2@quicinc.com>
Date: Tue, 16 Jan 2024 10:46:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: add support for collecting firmware log
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240115023726.2866-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240115023726.2866-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m_mSQ0W_973iJiR2VWZfRagbIeeFleRy
X-Proofpoint-ORIG-GUID: m_mSQ0W_973iJiR2VWZfRagbIeeFleRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=747 lowpriorityscore=0 mlxscore=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160149

On 1/14/2024 6:37 PM, Baochen Qiang wrote:
> Currently there is no way to collect firmware log because firmware
> does not send it to host. Also host does not handle WMI_DIAG_EVENTID
> which is used by firmware to upload firmware log.
> 
> So add support for it by firstly enabling firmware log upload via a
> QMI message, and secondly processing WMI DIAG event to expose it to
> userspace via trace event.
> 
> This change applies to both WCN7850 and QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



