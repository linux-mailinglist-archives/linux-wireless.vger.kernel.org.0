Return-Path: <linux-wireless+bounces-14094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2979A0CE9
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B862E1F231D8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1970B20B1ED;
	Wed, 16 Oct 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a5s93WzS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD2156225;
	Wed, 16 Oct 2024 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089572; cv=none; b=rcJAVLcClbqo1ytdN4mSZ6VbuLmmBoYRIbkkGYVl08pFZbg1psWH8eC731gfV4mtUfNVq9qqeWndb69IvAjV72ywjfc1i5xqDkdLLO9b4B9kB/wOqDPrGH4x4R7w6ZSRLFuySEZlf0wRQOR4QlsnaQpeKX/t8rZ7+gLUs0gj2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089572; c=relaxed/simple;
	bh=tJcKe4pt4i7PXkeNUKTeFAuwW6t/YaN5OfSErmlTUGo=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=dI3dAoj1T2sYtI3PHhTPn8mDsOsn+4teysbZeqyr7QKM4hSfDJnTwgmbI8W9lMbaU4QlOnS9Xd/hx5eQiHHXxFe7hHKkE694of8u8gDgslynRRNYdpHAlcKXKx4q9DUcNNuVWxeohorWiN3BCvVVFIl7XoAmTsgvSlvyrbv4yoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a5s93WzS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAIGvf011615;
	Wed, 16 Oct 2024 14:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rXy+c8dpwUyS28XWOvCP+X2h7aTUXs46tAhrIHKAdMA=; b=a5s93WzSKubHayJp
	/wPlB+VYr+ExlmTBql35B3ZI2DcpQab7CjIGvBldDPej9M2IaT1VBZ72g32+xOEA
	zk3iaaGDaEi/d3uV7vZXd20pf8539fEKyolWJfLzkOOKboSyK1GMSKfwKKLDh8Gt
	7p7FQtSl+4XL5VB9Sza3AdYQp26/XY3bQpbraBs5nJoJkxVU4vbpoUhblQOW/g0v
	fY+utrm4KHyzRo4eK1ixVLfdoqLZHn8GrwvSf3TKxn7eynOrPIvlRYmHivkmOzpM
	4SDw9Yq7LpEPdC+ZKO4YgyfZiyO0tJBouqtYs1qboUU3/Ndk7WEuJIaC77COq3+r
	EfyNtw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abm5gv1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:39:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GEdKJq031392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 14:39:20 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 07:39:19 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Remi Pommarel <repk@triplefau.lt>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Praneesh P <quic_ppranees@quicinc.com>
In-Reply-To: <20240924194119.15942-1-repk@triplefau.lt>
References: <20240924194119.15942-1-repk@triplefau.lt>
Subject: Re: [PATCH v2] wifi: ath11k: Fix invalid ring usage in full
 monitor mode
Message-ID: <172908955984.387396.4029422650033805718.b4-ty@quicinc.com>
Date: Wed, 16 Oct 2024 07:39:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7wQfFCMJEt2iNgledcscv-bDehVMXvKN
X-Proofpoint-GUID: 7wQfFCMJEt2iNgledcscv-bDehVMXvKN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=949 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160091


On Tue, 24 Sep 2024 21:41:19 +0200, Remi Pommarel wrote:
> On full monitor HW the monitor destination rxdma ring does not have the
> same descriptor format as in the "classical" mode. The full monitor
> destination entries are of hal_sw_monitor_ring type and fetched using
> ath11k_dp_full_mon_process_rx while the classical ones are of type
> hal_reo_entrance_ring and fetched with ath11k_dp_rx_mon_dest_process.
> 
> Although both hal_sw_monitor_ring and hal_reo_entrance_ring are of same
> size, the offset to useful info (such as sw_cookie, paddr, etc) are
> different. Thus if ath11k_dp_rx_mon_dest_process gets called on full
> monitor destination ring, invalid skb buffer id will be fetched from DMA
> ring causing issues such as the following rcu_sched stall:
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Fix invalid ring usage in full monitor mode
      commit: befd716ed429b26eca7abde95da6195c548470de

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


