Return-Path: <linux-wireless+bounces-12569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256E496E667
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 01:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD68B22DD2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 23:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BAB1A727D;
	Thu,  5 Sep 2024 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jxIOBb+X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1372D1B532A
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725579562; cv=none; b=ET6yTF99WweKlyQ4Tvro1ywtRKzpOnhJ0WsHfxnBUJCtAQ3EJABbCvJUidhgLoX6zXkT283vSLseyq74HExlesBJmHkko+Ig8bbFfliXqQHhG9J9ysWT+LGq301gifSVyZnuTDcf1eej2FznT32shEaKDug4eGTpdoKbkb1fgO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725579562; c=relaxed/simple;
	bh=U1ctAjv4/foL5yGt3mnfiWSinzsIfS26dhRXNRGDZiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jr7yHvhgEUHXiWh5U4Mbzm4aWbao8oU/gtW1ccwNq2ZrGtaF5to0wiGA6EM+UJGN/7bOqapUd4i+3lV3qJoXGaLhXyimN7AFRPlDw+8t3VgAVX6apZ0KsxzdkXolJfgyhLmMLz71dfWIsxIAk2CsTO2Fz2Vi5IVTKJblNLQZ+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jxIOBb+X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQORq025486;
	Thu, 5 Sep 2024 23:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JGkirmq6fdULqUsQlJs0l6hHXX5W6RsKQ+g7CB6M+KI=; b=jxIOBb+XkJVSas4w
	82bTamB+w/FCONStXwY+sZF7ZhW9h/z1Yd0aDswsDE+vHcsNXpzWSdtwGFTof+6B
	Tx18Nmq2vtHAlhvJMGe6FDqb6Iv2oknmumO/Vqb23W/qFwwKTywkYF9CjYZhyMnq
	2C+AmFO9/gsD7FhO4gjJiUP6+CGBwkiUwV46GslI8iyR9UPa8MySEs+HP4MPGbGX
	UXNZz9oQE2NG92wUUFmSHhmL7dStRmKMe5qSnTdSOrbvA+PbIa+8EVT6wUkjCG+q
	1BEpEE2dHKxJen0rexAMlo2+TOQv/kg+2wqH40+kq+Hzw2xbFfhHWKZnzMwZmxmQ
	udBKxQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhx08j31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 23:39:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 485NdGJO030539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 23:39:16 GMT
Received: from [10.111.181.108] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 16:39:16 -0700
Message-ID: <40685b52-10fc-428c-bd6c-89a047b7520b@quicinc.com>
Date: Thu, 5 Sep 2024 16:39:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] wifi: ath12k: add 11d scan offload support
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240905023511.362-1-quic_kangyang@quicinc.com>
 <20240905023511.362-3-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240905023511.362-3-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RANY-anpexWcItgv2evechUfZS14D-Q5
X-Proofpoint-GUID: RANY-anpexWcItgv2evechUfZS14D-Q5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 mlxlogscore=782 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409050177

On 9/4/2024 7:35 PM, Kang Yang wrote:
> From: Wen Gong <quic_wgong@quicinc.com>
> 
> Add process of event WMI_11D_NEW_COUNTRY_EVENTID. Add handler for
> WMI_11D_SCAN_START_CMDID, WMI_11D_SCAN_STOP_CMDID.
> Use WMI_11D_SCAN_START_CMDID to trigger 11d scan then firmware will
> report 11d scan result by WMI_11D_NEW_COUNTRY_EVENTID. Host will
> update the new country code back to firmware.
> 
> The priority of 11d scan is WMI_SCAN_PRIORITY_MEDIUM in firmware, the
> priority of hw scan is WMI_SCAN_PRIORITY_LOW. Then hw scan will be
> canceled when 11d scan is running.
> 
> To avoid this, need to change the priority of first hw scan to
> WMI_SCAN_PRIORITY_MEDIUM. Add wait_for_completion_timeout() for
> scan.complete in ath12k_reg_update_chan_list(). Plus another existing
> wait in ath12k_scan_stop(), there are two places to wait the
> scan.complete. They run in different threads so it is possible that both
> of the enter into wait status. Therefore use complete_all() instead of
> complete() for scan.complete. complete_all() can work well when it is
> only one thread wait for scan.complete.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Co-developed-by: Kang Yang <quic_kangyang@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



