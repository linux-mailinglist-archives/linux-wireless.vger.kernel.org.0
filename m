Return-Path: <linux-wireless+bounces-3481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766EB851D52
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 19:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A926E1C21854
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 18:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999CD45BF1;
	Mon, 12 Feb 2024 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kNNzN/DN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CADB45BFC
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763868; cv=none; b=FIPTfVnHOnzeKDcw0+7q2DddlKSBLgxQQhYcLmWoNzCToYt3WzVIqgXZxYUeKE+tCUu+VeN87Hl+GICCYVDITnq+ISHNbxKNiWfYR+0XsJNVfN+cyLHUg4d0wqdWyyY/x6lka+OZs8RBH3jfqEHdeyZQLzS4kcMffUh7xqpX5r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763868; c=relaxed/simple;
	bh=P55oF/xL5M8sNQlkW/bWVb5SM7dQZRqHizRqkM9sZNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d5qrbIjhZSr1dmbpz2Q5WIiGleMG23lVK18CbmOusk02aNAR4DNqmQzzRIFrM7p40CYFJCxXc0eI21lSroxQYJOn7XLgKjiCD5NvxwtY7STWA380CoGyNRA097Qjujmq9XbYHxinNo6o6N+UGThygwCKijsVtINCsNWcyZd5ClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kNNzN/DN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CIfFc6022119;
	Mon, 12 Feb 2024 18:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EJ236RSJh2JONZt11QtRVcZlbpwRlVn2jBMn8/Ch+oY=; b=kN
	NzN/DNo72RoNzpOgs33IlvzGm5xwc79HACR4UEp100BVc2qwvW/5a4ux4n1PSzE+
	N+omk4y89ShzDt6vz5wQOVsxkwXJo2qJbTj8S9QZLV7eaVFxiJMn/9q55vIGdAJi
	nsPZMyfPEe6Nn3gdOMFuy+qKCM78XPqg4iyu5bn2MBiJnyDQ20sFAU9P1NXGJfsQ
	D7mi1WFZ8HHvwGnTFWiaUSVU3FDOdzb7JcEQZhMpbyGttlot1OYhu4FWQB1or0O8
	B5mS22pReBxAkHKE/l3DhIew+MLedvgDbz39Q+84ej18EdwKI44craPd1+su7BXe
	rZ4ftp7uWmQHD0I0wJcg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ju78ym3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:50:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CIoswK029775
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:50:54 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 10:50:53 -0800
Message-ID: <11a06acd-1049-476a-92a6-a9fe410aa5b6@quicinc.com>
Date: Mon, 12 Feb 2024 10:50:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Do not use scan_flags from struct
 ath12k_wmi_scan_req_arg
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240211145548.1939610-1-nico.escande@gmail.com>
 <20240211145548.1939610-2-nico.escande@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240211145548.1939610-2-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hrL2Leay_qXiWbtdfEfTHsWlGvf326tI
X-Proofpoint-GUID: hrL2Leay_qXiWbtdfEfTHsWlGvf326tI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=391 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120144

On 2/11/2024 6:55 AM, Nicolas Escande wrote:
> As discussed in [1] to fix the mismatch between the WMI_SCAN_XXX macros &
> their corresponding scan_f_xxx bitfield equivalent, lets stop using the
> scan_flags in the union altogether.
> 
> [1] https://lore.kernel.org/all/4be7d62e-cb59-462d-aac2-94e27efc22ff@quicinc.com/
> 
> Tested-on: QCN9274 hw2.0 PCI CI_WLAN.WBE.1.3-02907.1-QCAHKSWPL_SILICONZ-10
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


