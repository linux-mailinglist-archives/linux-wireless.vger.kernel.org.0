Return-Path: <linux-wireless+bounces-21201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA6CA7E46B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 17:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8181882343
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577491FBEB3;
	Mon,  7 Apr 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ftj/D3LW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C21FA851
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039440; cv=none; b=MpB7ywcsqFWfrmgq+HHnBb492Wk5JqBMs+AdPTKYsbLFDiTXdZptsn5NPQJgj4tFWTX3nDrmmbT8HmxmAbLPspqffJ1mS1s69/TjJX8j19hIrUd21qk/SsTXyBuUgL4+expiHxPDz57OhsxFuLgux+b+CfIORincDupTZ0OqxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039440; c=relaxed/simple;
	bh=Qvac+df8MB6dEf9Zo9hOADT4JsNl++UpaLObglcII7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mcU7SKWyAMNH+0XEpzzhdYXT+a+Xr6EALOjj1nKX411VlmVA8jBShWp773ATfmD8P3+kp08Far2bb8YejGt7nCjwTZqEVJm5TaDgbrI6hhXsdkpCVHxkN9bo5OKyeGI0L2sB3rE7Eg5aA43b8mKMgljY6AYqc/pptdOypGYkpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ftj/D3LW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dqcI028163
	for <linux-wireless@vger.kernel.org>; Mon, 7 Apr 2025 15:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hHlZ7RCUM4VkVBGSYhmO9h2+v9soumRVmW0WAg8ToSQ=; b=Ftj/D3LWzDftiOwd
	425IWqfggUw7ZRzzmqGgmptuSVG0nraIn/FCZC143DIm11AMU7SS9S6mowO5ZYFR
	stMvQH5f01KrwYvPS89X+M4gLs+xCuH+hiTkRHKWQCgo3z3+cLecxCRZZ9pdl+aN
	uWSbNNUguvLzqdUy5Ipu9lDGXQfXeCdI6h2fwjDGopaJpCLhqkSedT2vU4IWL8XK
	CX+LArjbP3Sge7s1t6AVK842aeCFeraUTrzsgBJWuZAtoAQaj9xN1u2jL9jlamMs
	Sd+U9HHNhpGllTu7tfZcgVykAbFCACLTPma+VEdE+GW0v5QgM+XwMscCJVRjCZAd
	sojGAg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcyvpct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 15:23:57 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7394792f83cso3325795b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 08:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039436; x=1744644236;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHlZ7RCUM4VkVBGSYhmO9h2+v9soumRVmW0WAg8ToSQ=;
        b=VHYVyfAbYrBYy4H0eFuMP5TFWc5NQAXErg1xS8Dqe2eFUh83EDN/dFIpacqxknu2f3
         QahvRVp/DrsCXG9RDV4cUBqabl9JygauRXArO6QdM5pQiomWahRk3CgN8XzEd6f4OOvX
         EwRn2/4LEUFNcwZPWrpzir2GtTnFZ2aQLJhQmV3at+QYxSx6PvpfdjmxDGvS/enX+nu1
         Du2kNb1k8bLV3qCAu495EmZmTTBfcsJu+42Fc6WVHn5w+X6amDS3ZQg6pa3KJt/q+AwG
         LwRkm+VcNDryn1r485MoHbG4cPjKFQzHaIyPy4E5VX1m0dIxlyqPHqrCFiXi7FBfzfPS
         FN/g==
X-Gm-Message-State: AOJu0Yw3bWWy2tT6o5UJ//PV29jmCjy4/RjPAweqnaXnLMVLMkdSEzxz
	eUKWHVQjMAwKYLGesWhNDfoaC58qxZFX/kaQAQqCB7B0XmQtdzps8gie/zkhOuUEe7RKcG6+kpA
	khzK1vjfSrjkJi6WLQOynnMyF4Hyqa94eU80NkA+i+dwoEP6n8xtOgleEcuhcibZQ2D8J6PnL3g
	==
X-Gm-Gg: ASbGncsv1Uw2rcFGVZ9jTJYX6/gzYy/NSyjSEqmVwHIbPh4N+xQoOxDR4iQfwzx0wU3
	XOJxfr76usgDIg8tsye7ajvo10vJOiB5maPhPVojQPHG2Es8V1a5eRz+jNIPItMtr0+gX2S/LYn
	tCGnH/2M0mFQC+1WOzYp55j44L35tLfh5rFSn+5HZCnF47KsB1Ejae7eDo7IHLiUwPZcvRO+GZb
	hZkikwUEufAwVhre/KuMUKKlqDf2qnB7Dh6lXfzkiBuMoS4gHqfsBaSNZGUkXF6ehisD527qe64
	Cjr9AqyOkPIXqB1B63iQdKAnHJHsjAd2HvNnGFxWPiXyUffROoZS
X-Received: by 2002:a05:6300:6681:b0:1ee:d8c8:4b82 with SMTP id adf61e73a8af0-20113d272a5mr15966696637.31.1744039435880;
        Mon, 07 Apr 2025 08:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTgjgqkDOtPTp2H2DjY6r5fOdX69d1zQKiktFj50uXmptg6Tcm1VK/rGYK8NEvTJday9BOOQ==
X-Received: by 2002:a05:6300:6681:b0:1ee:d8c8:4b82 with SMTP id adf61e73a8af0-20113d272a5mr15966637637.31.1744039435222;
        Mon, 07 Apr 2025 08:23:55 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e7d3fsm8691592b3a.180.2025.04.07.08.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:23:54 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250402174032.2651221-1-praneesh.p@oss.qualcomm.com>
References: <20250402174032.2651221-1-praneesh.p@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix memory leak during vdev_id
 mismatch
Message-Id: <174403943464.2068408.1950534582147740299.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Apr 2025 08:23:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: FcQojmiix3PPBIFKNXn0Es_iJOGNWaDl
X-Authority-Analysis: v=2.4 cv=Q4vS452a c=1 sm=1 tr=0 ts=67f3ee0d cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=oQbCsDu0WCP6IoMcAQ4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: FcQojmiix3PPBIFKNXn0Es_iJOGNWaDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070107


On Wed, 02 Apr 2025 23:10:32 +0530, P Praneesh wrote:
> Currently driver enables vdev_id check as part of the bank configuration
> in ath12k_dp_tx_get_vdev_bank_config(). This check ensures that the vdev_id
> configured in the bank register aligns with the vdev_id in the packet's
> address search table within the firmware. If there is a mismatch, the
> firmware forwards the packet with the HTT status
> HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH. Since driver does not
> handle this vdev_id mismatch HTT status, the corresponding buffers are not
> freed properly, causing a memory leak. Fix this issue by adding handling to
> free the buffers when a vdev_id mismatch HTT status is encountered.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix memory leak during vdev_id mismatch
      commit: 75ec94db880b1e4b4f9182885d60db0db6e2ee56

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


