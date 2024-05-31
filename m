Return-Path: <linux-wireless+bounces-8363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725D8D6957
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 21:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A9F1C20DCD
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5411E498;
	Fri, 31 May 2024 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BzMdB6+y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD407C6C9
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182084; cv=none; b=QRzA6+ksUmX0A7XM8kv5dmQv0tPA0z7LwsdL1EecyzDLcuw/X/3fZuFQnF5+VO271IltYeoIlORHPMJk4HNE9HTRO9eORf/IpO+Wd+lEaELI9OQ6ZseVlTbfh93oJqC9/l+uWE5ZEUt/NZEntf2ZRkPuM3+XRtDOpgeta/QR49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182084; c=relaxed/simple;
	bh=U1dab+hCsP3bufffoShLJmCvtN4+7+2AbRJqnygEBlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FuUAP3cu0Mil5i8bZqmdIWmFpEOJr/K31rADZQ2+s5njXupElbEd//XkgpxqhlgF3btkMjPtbU+KOz1W3aPdDVRnwP8vyNp6avBkCEQBa+XwL/W7waWBOmwzJSHRI9B/TAWugYze9h6hDkBxl7eNBwhU9IIlgUfPlM3q0cKWOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BzMdB6+y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V9pKDJ002210;
	Fri, 31 May 2024 19:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CJp1vyOYt4eO/kBpSnlZuec6ZaNAolkogRbKhRnSxcA=; b=BzMdB6+y1zzVGvgz
	yNMZ3kv97znmNHW9txvy2K3y9V2LDTq+LSC+vct/axIzvI3NLq3gM8lzyr5/LWxD
	UIxYFTgdmAmbR8M1BNVTz09YDy4Vn2KKqIs+iB6g/xcZz+XgyV+p1XXlQwpzv85n
	+v4V9j7EXwPZNJfxrYTWYtDYICTIiG0SoteX9nEk3lFUZlhh7paH8PN18tN/Uk5P
	EjZ2dXflMRigtBht4t2EgMkZkbdCpr/xaN6IZeycSJicf/9S2IItbGM0kBM1beMo
	rYs70ozLNiDN6Q8LrpmyMNoTsrMR1QIsdt4zmA0Z/JgDM8oKcK5eC5j+sCnajIV5
	sUbVzQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfc9nhgrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 19:01:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VJ1D0g004364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 19:01:13 GMT
Received: from [10.110.11.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 12:01:13 -0700
Message-ID: <ef9bf058-7821-4709-9c38-84f2b8b693a6@quicinc.com>
Date: Fri, 31 May 2024 12:01:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix ACPI warning when resume
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240531024000.9291-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240531024000.9291-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nqjGzR-JXXm3pZ0zAZ7n4akGP24XOqz4
X-Proofpoint-GUID: nqjGzR-JXXm3pZ0zAZ7n4akGP24XOqz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310145

On 5/30/2024 7:40 PM, Baochen Qiang wrote:
> Currently ACPI notification handler is installed when driver loads and only
> gets removed when driver unloads. During resume after firmware is reloaded,
> ath12k tries to install it by default. Since it is installed already, ACPI
> subsystem rejects it and returns an error:
> 
> [   83.094206] ath12k_pci 0000:03:00.0: failed to install DSM notify callback: 7
> 
> Fix it by removing that handler when going to suspend. This also avoid any
> possible ACPI call to firmware before firmware is reloaded/reinitialized.
> 
> Note ab->acpi also needs to be cleared in ath12k_acpi_stop() such that we
> are in a clean state when ACPI structures are reinitialized in
> ath12k_acpi_start().
> 
> Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 576771c9fa21 ("wifi: ath12k: ACPI TAS support")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


