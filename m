Return-Path: <linux-wireless+bounces-20802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E90A70453
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 15:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAC97A223B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5159D25A64C;
	Tue, 25 Mar 2025 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FanOVWdv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F425A33A
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914374; cv=none; b=nKTOjxTdXRlA4LTkCyq6OYvVzADeySTOopJ+wXD0yMzz0ZoirIIaxfnWdS5o6LziX9EhuRgwHNDZnqTHceihauQImdQ6eoLUDmp27cl14It7frSXCvCwZGmFH2C8d+Nx4dPq+WoFO7ehGx3d9A7DW4Ksri9wX0jAJgofQh+Hzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914374; c=relaxed/simple;
	bh=d+kKsfl2TTj9vTCfKwIjZehCx6egu08uzHV5hFpXi0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b8df3uH3CxvOqfP1gAORwt9v7NkhYI84aK8iaYOWiul86rhdzQAcvYgYn4HjNAueFxXyCwEWQgY/haY51ly3MxgQDyE2DkfShuV4/UcEPRmJn3posE6aflueKGPLjxIpV1B63fCasZCAxLJg74VjMjMOGoOJBkIoxJdMjHKz56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FanOVWdv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PCuEhw017070
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 14:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ftcTynJFhZf6Ou+y+dlXrXlxZij+fB0u3WfPkqUsG4U=; b=FanOVWdvToSN62/b
	eW6+fkKgH4vKcZ3veFc7yfEXb+Rr3khkkdMVXH6U1UngLzagHNH6F8cDVe+5QzUK
	GEvsefQhWHyPGgxoycMaKSqp+uUa6FGNvQZ6eSYptJYBVpOi85dAdcMVii6iAUXc
	LoOCgBP8f7ATs6TwAo/cdvn7fRcI6yjQnfoSX9CGGUaMtKcLokmDSv8xqbg9kCdy
	vpbXnUN47r/V4Je8/mPr7Jhi7ZQqrxHnzUzYZ038VEyzPTsGi218JIhRl2LdkxDa
	QAGGMHQt75IEy/E8WGqNpY4yWgv6z1Rzur4ltIHdTVSgOjkLLjQ7TALPvrckcWg/
	6KjDZg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmcy9yct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 14:52:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso15763124a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 07:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914371; x=1743519171;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftcTynJFhZf6Ou+y+dlXrXlxZij+fB0u3WfPkqUsG4U=;
        b=i1AGYqYhCkuBEBdgSbl7DvkZjoJpKUB8wYxfKdFGjL9ajNUNmO8sVWojtHibWGPeaH
         1u9hKumWun5uxqxAYVGTxkPqeMzP8k2AQIYoi17f8/Of0zqhZ0C3W2gaO6Y7xZ4scVeF
         v4HS9uBhrsx+d8deokuYTvICTnYP7OfH5HUf/E2HQV4Ta0Y4Hif9ZpTVxnCXmivB5qhB
         Vb9rbRiakMhbnoGCpUjavlUjABfHsRBLgxku9iuC7j78fmxqJMwBHWtSEK/pSu6HFzTd
         1yM2SMwSIDAtYmpGUwOiBhToPydo+bQ5H/Vgh1YRsdH6WJ8nltuMUJTHsyLDNEyaHmtF
         AVOw==
X-Gm-Message-State: AOJu0Yxp0J0ux+wIC++WMIjfTU8Z6PPFHT6jhrjBQftLLkFpXHs8R/ab
	0Y4dlsc+Pe6J99KcFIhHUM5WjZp0/qwkcA7fWcshJAyVFX+mk3WewSEorfFLtlQKETJm5XpFKAI
	y7yq2IDOsd8qRv38Ur0NsQP/EveCODdBGHMK1B8Iw79ywYHH496Gqqfr9+HeYKWHHsA==
X-Gm-Gg: ASbGncu2WNePklWa3ahDnDrJZSvkXf7lx/OzUwX5dMj8RgPMOQ+tgF7b3+1ETScQp8X
	d04Dhy1ffb8Zu9J+hR6M26kpDLHTh0xHzz1SE+I0AvECRaiYB1w0nU0i1bViFFU0liQ3dub2D90
	tusnLL4CkkDxgnpQL5ja1oRO+QgVMPUFIJPn+PZf3MYSjiJ7R9ddoxyHpuAdLAVl3PWc1rUBRVt
	Jj2pNMbwCP4+Acj4mTFWmLBf3gelpHLk7ddlfUdA790/8da36P+z4CHi0G9gQwT/zeTSuBedVS7
	jgLHaXfFSS3KP/DpaW2SxiJPPlnO4qFkmqhbgpYHOwp+b5S2n0j8
X-Received: by 2002:a17:90b:4a44:b0:2f4:4003:f3d4 with SMTP id 98e67ed59e1d1-3030ff08e4amr25846267a91.30.1742914371010;
        Tue, 25 Mar 2025 07:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGq37xgRTdz1JPqWrLC0RaHjS1VYwIHPt1R/tO8cE0n4o8nk/6ax8nuzgtSl/hVZJ/IF/xkg==
X-Received: by 2002:a17:90b:4a44:b0:2f4:4003:f3d4 with SMTP id 98e67ed59e1d1-3030ff08e4amr25846235a91.30.1742914370543;
        Tue, 25 Mar 2025 07:52:50 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3036c973cf0sm1136656a91.1.2025.03.25.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:52:50 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
In-Reply-To: <20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com>
References: <20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: don't put
 ieee80211_chanctx_conf struct in ath12k_link_vif
Message-Id: <174291436978.1215324.3680053989987464544.b4-ty@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 07:52:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=EZ3IQOmC c=1 sm=1 tr=0 ts=67e2c344 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=2YHuQJzV6Ps-Yg4M2TkA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: kZEtr_labiqXaiaBnY-yDiYPrcKOZZU6
X-Proofpoint-GUID: kZEtr_labiqXaiaBnY-yDiYPrcKOZZU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=745
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250104


On Fri, 21 Mar 2025 09:45:53 +0800, Baochen Qiang wrote:
> ieee80211_chanctx_conf struct is not put at the end of ath12k_link_vif.
> Note ieee80211_chanctx_conf has flexible array member inside it, causing
> below warning with GCC-14:
> 
> drivers/net/wireless/ath/ath12k/core.h:298:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Although there is no issue for now since the array is not getting used,
> this should be fixed to avoid any potential data corruption issue in the
> future.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: don't put ieee80211_chanctx_conf struct in ath12k_link_vif
      commit: ce0779378c62758a0c503bf85e643c6d8f343703

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


