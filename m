Return-Path: <linux-wireless+bounces-4299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E586E5AA
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 17:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C82B25675
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3D233C8;
	Fri,  1 Mar 2024 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IyIo9wlQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE64404
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310753; cv=none; b=qXRagsNvNxOD5Dzvixz/EN8JUd1mw3mXOAfEqAVqnkAVay7kpqQrawyi49Zb26LCBPo7dHlslizkE5mta4gNpXQj5Eg+1TAhNy+xMlYYHMff0/mAlWLZ3Ti2JjZrVTnQMiyM4yHirRs+7vHMMN+pMVl02B/xnA+fUf+Ys1dy5nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310753; c=relaxed/simple;
	bh=SmSYteXo/H5Ck0S5dX47YXNrj8CieGxjzMw+cgrA9Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cf08cXQzPi+l5PLB4JqdVsa1LKzFMU4fm4G8R/dzWxhzSuHLrWR0qX6qjWFMV1xVSoneyCxECLAfZwiP8bhcevn5lKtqSmYA3Tu6dXWDS9TaRPr1Jn0yAEOiesHjQqbJUF41NcsvKQp2QKPzoaH8OuK2crjb453HFOVgPHpmVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IyIo9wlQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421F0rMn010205;
	Fri, 1 Mar 2024 16:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CWd8ARhwelmsK+7EeDHRYbx81TZPC8DHiHtlgAkXp5Q=; b=Iy
	Io9wlQlF7+E0JVKVcwWk4Ucozpq7MBHT0bNQ60t49PacHxs53BTEnru9AJ7mD/VA
	nWOSHS9x/ERALHl4srw/ItvCvPSqUXz38yXbaKZctim5Fs+MaR9UdkMOzquCHwxQ
	uy8NDGutQOPV0YzV+AdLnZXz3+aBVEdQ0qbGDIihZAQqWMDlB8dltE1yenAlJkF0
	rroV2ldS6CPl/nEZ6UnUgeKiq+O7nKUNl7gntWw0VH+o66s/3Vd50OLK060fIto1
	NADiAtgzm+t5vKKoBjhUhMw1/lTEIhHYNoyVaS1m8ofBwp+XG18KhR9rnq8nK0zv
	AdagCoP4O/rqOk2WohNA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkh9rg753-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 16:32:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 421GWRBD007716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 16:32:27 GMT
Received: from [10.110.42.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Mar
 2024 08:32:27 -0800
Message-ID: <b71873ac-3ccb-4be4-8155-706ad386e664@quicinc.com>
Date: Fri, 1 Mar 2024 08:32:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] wifi: ath11k: change scan flag
 scan_f_filter_prb_req for QCA6390/WCN6855/QCA2066
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240228093537.25052-1-quic_kangyang@quicinc.com>
 <20240228093537.25052-6-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240228093537.25052-6-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Hb5nFv7QwPoCl7VaPaMQ5Eo7vbgMCnJn
X-Proofpoint-ORIG-GUID: Hb5nFv7QwPoCl7VaPaMQ5Eo7vbgMCnJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_17,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=954 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010137

On 2/28/2024 1:35 AM, Kang Yang wrote:
> Current ROC scan will filter probe request. So P2P device cannot receive
> probe request. But it is necessary for P2P mode. A P2P device cannot be
> discovered if it doesn't respond to others' probe request.
> 
> In addition, station won't filter probe request with common scan. But
> for station, there is no needed to receive probe request.
> 
> Based on the above two points, change scan flag scan_f_filter_prb_req
> for QCA6390/WCN6855/QCA2066.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


