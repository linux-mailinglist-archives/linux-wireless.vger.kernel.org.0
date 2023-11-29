Return-Path: <linux-wireless+bounces-224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12B27FDB9A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 16:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DDF1C20929
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF00249F4;
	Wed, 29 Nov 2023 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cO5KGnyC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AC9D46
	for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 07:35:49 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATEQWAA031808;
	Wed, 29 Nov 2023 15:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mkhB+oc/0d+2BM5+G27WFV+55X05SJeWrCNbmhBuaMU=;
 b=cO5KGnyCSPatQ5LdVrL0OFAHFO0AFXG5hg19f3v86Z+qGzhe7r9lT401Yr8rHUOnmTPh
 3twPp4lnU98zzsP50iOt2r7252iuNCdUhJnWDDZAjGxBjdd9l9g0DouYc/upiGF72B+z
 8mkrJJXrRBHYkOAjn7WmWWSIoH2QQt3p/fllvGZayP7/Vb9p9ggJOq+KmDPpIs85Rv0P
 e0OUvu4QH79371DfPRGpgwkXHqLuTHrCNYfR8V5TJ9pSkbSPDb0rljOlNAbqIQdB/rSd
 /aVqiSFRdcOqYnxzoBOsJj1rqnE//PQcOCZMdikCoKYzJc+zfB4dS33vENmEkYVm0piY EQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unnpetnc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 15:35:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATFZjPF022136
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 15:35:45 GMT
Received: from [10.110.63.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 07:35:45 -0800
Message-ID: <d012ddc8-3578-43da-9787-e44dcc4e7206@quicinc.com>
Date: Wed, 29 Nov 2023 07:35:44 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] wifi: ath12k: change MAC buffer ring size to 2048
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231129020414.56425-1-quic_bqiang@quicinc.com>
 <20231129020414.56425-4-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231129020414.56425-4-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VhGp4JUl5GtWrK61lx_X2phg_x8y05ER
X-Proofpoint-ORIG-GUID: VhGp4JUl5GtWrK61lx_X2phg_x8y05ER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_13,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=846 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290117

On 11/28/2023 6:04 PM, Baochen Qiang wrote:
> For WCN7850, there is a SRNG named MAC buffer ring, i.e.,
> dp->rx_mac_buf_ring. During initialization, it is setup
> by host and then under control of firmware. During RX
> process, firmware fetches buffers from
> dp->rx_refill_buf_ring to fill that MAC buffer ring,
> and those buffers are taken by RXDMA to carry real WLAN
> frames received from air.
> 
> Currently a low RX throughput is observed. Checking
> firmware log, lots of errors are reported by MAC buffer
> ring, complaining that it is running out of buffers,
> which further indicates that RXDMA is suffering from
> starvation. Currently the size of dp->rx_mac_buf_ring
> is configured as 1024. After changing it to 2048, those
> error messages are reduced, and a 6.4% increase is seen
> in peak throughput. Note that 2048 is an empirical
> value. It is chosen here because the RX throughput
> meets our expectation after the change.
> 
> This change only applies to WCN7850 since other
> chips don't have a MAC buffer ring.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


