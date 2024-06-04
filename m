Return-Path: <linux-wireless+bounces-8484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB888FB658
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287741C20325
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E085113D24F;
	Tue,  4 Jun 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YDr+FSqb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDCA846D
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513054; cv=none; b=QeDZ4UCBq9IKF9p6RpEQZVDxc+us7H3xp1zury7hj4H+t14M1nNX58VylXlqox2p+o0QvbR1F707MEr5Rdzp2VmcpMm35uwkLnF9Bd0pY0tC/rT/zFFDR/j7lVix93ZVBv9A3olFHbfvNhAR/d9sscqVQblhd+2XAKYH8rXbrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513054; c=relaxed/simple;
	bh=qBuwPla7aLBUloRR4GSIdte6CBYJfAQzqv07gNufyyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XAxK8Gf1wr3vLm70d7ypEhHRKlhRrC+Iq4nhdYCrC/56rtzKh/zW/AWxqJh3xA5FN2Ibqfm3VNB/uN3itQp1OmL7PYpyDtYx2JlIAO+nUq2YMMv1pv/kSf5EU5H04zvCWHwk/FLsOammW52cB1kwj9smLmGnHcMbEfrFCPDGIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YDr+FSqb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454A9bSi024997;
	Tue, 4 Jun 2024 14:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B/96BTw+xkS3lQkxH7j6xdN90NrdAqBAODbSG1NhDP8=; b=YDr+FSqbz4+6K6lO
	F4a++Y3TLD5U4fU8oN+p/l1Nh01tpkmAkCV6PCGhKSEbo11/doqw5e6MOqWhYIxy
	mo3qTpeSnswkYbrizgT+QW42nq3KFTHvn4JwVjZ61V0FV7kYpx1GjCuH0jcUTOZI
	95XY+2FoYljm6JYxk1Q/ty3/WrJcyHBVBcagGSbZ2d3EVH9g0rLiiq2gxO3cDxs7
	NrYNWzD66QcsxERIZs+Z8B5lYWco7F0v6y0+Zqx6grt0vpJs+cfKVty7q5vOHHqT
	ir2Lzml2Ztu0cHHbFYAfhlrzeKZrWy2w2PlQlKMyDK/4yLgKWYbI3XjLgjdxlDzV
	lqhSPQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5wq1v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 14:57:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 454EvOe8012295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 14:57:24 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 07:57:23 -0700
Message-ID: <b10a0ba2-6085-4a33-9215-87bdfcc6a895@quicinc.com>
Date: Tue, 4 Jun 2024 07:57:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] wifi: ath12k: support ARP and NS offload
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240604055407.12506-1-quic_bqiang@quicinc.com>
 <20240604055407.12506-7-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240604055407.12506-7-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mNvpcQOoMGoTYqQPsvpmokxrhQa2Stwg
X-Proofpoint-ORIG-GUID: mNvpcQOoMGoTYqQPsvpmokxrhQa2Stwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 mlxlogscore=566 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040119

On 6/3/2024 10:54 PM, Baochen Qiang wrote:
> Support ARP and NS offload in WoW state.
> 
> Tested this way: put machine A with QCA6390 to WoW state,
> ping/ping6 machine A from another machine B, check sniffer to see
> any ARP response and Neighbor Advertisement from machine A.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


