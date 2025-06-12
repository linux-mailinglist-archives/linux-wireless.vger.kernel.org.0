Return-Path: <linux-wireless+bounces-24050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E3AD6E38
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 12:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2563165912
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E66F233D9E;
	Thu, 12 Jun 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UiCPzLXp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307E223339;
	Thu, 12 Jun 2025 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725356; cv=none; b=Qyd1GRCBUgSW/CKO3/2DxjyoGXcLMXBDgWSpusN3xu8V+yP+Z9qlV6tpv4qqjIM2o5YN2lCXexfGNZEAgKB3PXSD0BZPNCm+b6lZ3uRhCVYXehZ5snSvZkgitraU/rOiIQd5oLUmS+ytKaSNt5C0GpXVUEohD3M3t6NsPwU5zZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725356; c=relaxed/simple;
	bh=/p2+oAN4N9RGll1iL8VgjWS6CIl6MG8l1wXxzcHOKdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R9shbjv/mOGg0rmSSIqtCuIqQflEIF5v0QJPeZNY+xHtOVJw/wbFGZ8tUZT5jYU5iWB8xnNK0mAb0xbjaRvB+OWb8v6xttD+Xbj+Iq3luPcTAgtfQ5g1kKcZuPSjLMJcwXgxjIa95uw0TrjOUkAthuL69TunW3EDpKh9NdGd4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UiCPzLXp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C9IMav002515;
	Thu, 12 Jun 2025 10:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xAru5tL6A9/kwMmGSI/WjuX5wDfBZY9BmkF91WMW9as=; b=UiCPzLXpMWtN2Ugk
	DqKrYrijt5dQFy7Ygvj22hHCzfHRMPNK2bCMpXV/cpzRIAlXh8jyak3zyhfCGbJh
	NoCPK4WQuR7W5fnCuO683hXjCKaGsWRcKppLNNIM03c8zf0+aw6GrF2z262R5xN7
	YuhFbmZZLHlbh6ZrF0ysWtexueuGzbW1e0MoEdhkD/Bedgw1OeFuUhJdiVIaNhIQ
	3NO9CCCEnYlD0G23bu2wqSSDSSy+scYSrmw3db605l44on9EpSqNtSkb2pnP5jd8
	GXJ4WDVnbBf606MqCFS2q4JlXhX/T4qGPIhfrsGLa+0j1MDATueSb0U1aFqvKS49
	CJdcrA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 477jbphqav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 10:49:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55CAn83P014123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 10:49:08 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Jun
 2025 03:49:06 -0700
Message-ID: <73c6cd0a-9c15-421e-afa4-27fe173bb428@quicinc.com>
Date: Thu, 12 Jun 2025 18:49:03 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] wifi: ath11k: clear initialized flag for deinit-ed srng
 lists
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20250612084551.702803-1-senozhatsky@chromium.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250612084551.702803-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6qqAZqvnHHzwNlWHZf_PLk18dmzfKXJ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4MiBTYWx0ZWRfX8kM+9n60IL4u
 OE6AH0e9Q1JP9zlu2pjJKMN8I/hf0ZoR//ultXwmcjuD0jpjifZA63IsPL7S/sYVcURj5hoRcvI
 26L9zO4Q/kbpGbYq4CEWtZ5JWjPfuidrgbpKBkaWapYDoFaYCTyGd96IJCD9M7lhQ0AHtIjWmlS
 TnNhsx0ITTRkHNIRJQ56KJr1I4wrx3VxVww80X2mLYjyKYVSgzkcubGVsTTNcSOCYGKXCfKGaNq
 VdqGQxany70ywfd9o8AbmQWT8O+nUPtuFMfJBXaZzOdQhtpFrr+IvcnO9XOsUebA7vXiGEoTYzn
 jxW0C6hpwZBTRTl8IwOWR+5D4t7ZYNSE82w4l+Bwlsw9NreXv5L1AU5x8Mji7s11Zb8FQxWcGpx
 iM/zJTQoL/uRFRQs+4liN1I2PDJ/hvLnBY9g5w0LV9CFw6eMyG2K0PDugbqgGfodufklenmJ
X-Proofpoint-ORIG-GUID: 6qqAZqvnHHzwNlWHZf_PLk18dmzfKXJ5
X-Authority-Analysis: v=2.4 cv=OLgn3TaB c=1 sm=1 tr=0 ts=684ab0a5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=cm27Pg_UAAAA:8
 a=COk6AnOGAAAA:8 a=B3OtxjWztyHNNZvo7z4A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120082



On 6/12/2025 4:45 PM, Sergey Senozhatsky wrote:
> In a number of cases we see kernel panics on resume due
> to ath11k kernel page fault, which happens under the
> following circumstances:
> 
> 1) First ath11k_hal_dump_srng_stats() call
> 
>  Last interrupt received for each group:
>  ath11k_pci 0000:01:00.0: group_id 0 22511ms before
>  ath11k_pci 0000:01:00.0: group_id 1 14440788ms before
>  [..]
>  ath11k_pci 0000:01:00.0: failed to receive control response completion, polling..
>  ath11k_pci 0000:01:00.0: Service connect timeout
>  ath11k_pci 0000:01:00.0: failed to connect to HTT: -110
>  ath11k_pci 0000:01:00.0: failed to start core: -110
>  ath11k_pci 0000:01:00.0: firmware crashed: MHI_CB_EE_RDDM
>  ath11k_pci 0000:01:00.0: already resetting count 2
>  ath11k_pci 0000:01:00.0: failed to wait wlan mode request (mode 4): -110
>  ath11k_pci 0000:01:00.0: qmi failed to send wlan mode off: -110
>  ath11k_pci 0000:01:00.0: failed to reconfigure driver on crash recovery
>  [..]
> 
> 2) At this point reconfiguration fails (we have 2 resets) and
>   ath11k_core_reconfigure_on_crash() calls ath11k_hal_srng_deinit()
>   which destroys srng lists.  However, it does not reset per-list
>   ->initialized flag.
> 
> 3) Second ath11k_hal_dump_srng_stats() call sees stale ->initialized
>   flag and attempts to dump srng stats:
> 
>  Last interrupt received for each group:
>  ath11k_pci 0000:01:00.0: group_id 0 66785ms before
>  ath11k_pci 0000:01:00.0: group_id 1 14485062ms before
>  ath11k_pci 0000:01:00.0: group_id 2 14485062ms before
>  ath11k_pci 0000:01:00.0: group_id 3 14485062ms before
>  ath11k_pci 0000:01:00.0: group_id 4 14780845ms before
>  ath11k_pci 0000:01:00.0: group_id 5 14780845ms before
>  ath11k_pci 0000:01:00.0: group_id 6 14485062ms before
>  ath11k_pci 0000:01:00.0: group_id 7 66814ms before
>  ath11k_pci 0000:01:00.0: group_id 8 68997ms before
>  ath11k_pci 0000:01:00.0: group_id 9 67588ms before
>  ath11k_pci 0000:01:00.0: group_id 10 69511ms before
>  BUG: unable to handle page fault for address: ffffa007404eb010
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 100000067 P4D 100000067 PUD 10022d067 PMD 100b01067 PTE 0
>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>  RIP: 0010:ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k]
>  Call Trace:
>  <TASK>
>  ? __die_body+0xae/0xb0
>  ? page_fault_oops+0x381/0x3e0
>  ? exc_page_fault+0x69/0xa0
>  ? asm_exc_page_fault+0x22/0x30
>  ? ath11k_hal_dump_srng_stats+0x2b4/0x3b0 [ath11k (HASH:6cea 4)]
>  ath11k_qmi_driver_event_work+0xbd/0x1050 [ath11k (HASH:6cea 4)]
>  worker_thread+0x389/0x930
>  kthread+0x149/0x170
> 
> Clear per-list ->initialized flag in ath11k_hal_srng_deinit().
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
> 
> v3:
> - updated commit message and subject line (Baochen Qiang)
> 
>  drivers/net/wireless/ath/ath11k/hal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index 8cb1505a5a0c..cab11a35f911 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1346,6 +1346,10 @@ EXPORT_SYMBOL(ath11k_hal_srng_init);
>  void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>  {
>  	struct ath11k_hal *hal = &ab->hal;
> +	int i;
> +
> +	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++)
> +		ab->hal.srng_list[i].initialized = 0;
>  
>  	ath11k_hal_unregister_srng_key(ab);
>  	ath11k_hal_free_cont_rdp(ab);

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>



