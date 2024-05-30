Return-Path: <linux-wireless+bounces-8324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E38D5188
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9072F1F22CE3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB147A40;
	Thu, 30 May 2024 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Db5xdLsJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E794779E
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091747; cv=none; b=tU7Ne1dAD2bMXI1zlvLg7muenRM8Ws02ZJakpgLcYQYCjN6X+TxRzAQRRE7T+qzE7PiAdC2lFzR0p8DZ1ihHOX+yb7VSna1q86F2XUOqcr61vWLlrkYjhLx6s9w4G0Fu54e/WuKpLvOiqpcdblL1Zeu53PIvxkXluz0im6Xuet8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091747; c=relaxed/simple;
	bh=h+zcFC0IWIawb8T3LU2IfhBwO8hUC+yOBY55GNGHgQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mrKXZQn2xpA8jEn2rF4/1NDeA4wUsIW/fZFvSjjF1dUevlkehlu4osUPW5wGgrKRnIlOyWrhccmRA82abhYYqzgpgife2idkcdFFL1IsQJPJ5IG+z8tSnBqSqNCW+jsCytNcWA/rGOoOaAkjvfwsvLffthxcLt7cWXtFRmbNZOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Db5xdLsJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UERiOQ015783;
	Thu, 30 May 2024 17:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b4PntusyRgZjr5WLFu1PEzVzFqheiERopRQLznTyWYY=; b=Db5xdLsJixrQhgNO
	9DJ0Joo0ZhcxL/TbsPFyt4iEO0HH3bBrNvLJIwZBJsyk/S+f//qqMnn9IQnoCTIP
	X6iaqslgPULuhA1JFHJQx7L7RMS+Or1VzANGim1wHFRfTjM0JWb0oIM8SZpyTgl3
	aVxZnmla1KRDcGrwhJGEDYRYd/KJj9jW+kJ0S5M9FN6yOGsmt7xl2Nnt9zW/Fydl
	NgWPaY/VGcBZQFnOm9g26pS6Sb0OJO8TRbMKShlG7k28UuvLxqlsyJxsIvIkyd+w
	rfVSv6MKzPP+rWTq8/jo+4YmINF23iE90DslAump9FsxGMFC1DBibPeW4wVy9fA8
	aneMJA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ydyws4ej7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 17:55:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44UHteSP019203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 17:55:40 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 10:55:39 -0700
Message-ID: <b3ff72fc-c4bd-4cb5-a6d6-ad6772657d6a@quicinc.com>
Date: Thu, 30 May 2024 10:55:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] wifi: ath12k: add ATH12K_DBG_WOW log level
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240530072714.25671-1-quic_bqiang@quicinc.com>
 <20240530072714.25671-2-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240530072714.25671-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lZvV4HbVNn8hY1doq0hUALP59I_42VMi
X-Proofpoint-GUID: lZvV4HbVNn8hY1doq0hUALP59I_42VMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=731
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300133

On 5/30/2024 12:27 AM, Baochen Qiang wrote:
> Currently there is no dedicated log level for WoW, so create it for future use.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

As noted in cover letter reply this needs 2024 copyright. With that added,
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


