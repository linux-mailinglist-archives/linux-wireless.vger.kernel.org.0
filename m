Return-Path: <linux-wireless+bounces-27989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 10160BE10C1
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 01:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81185354E9C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 23:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC7831987B;
	Wed, 15 Oct 2025 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FUbhen2h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DE3191B0
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571632; cv=none; b=HOm7WxdYctfYYFUJfkFw0YApGqZwA6iaqYOdLZDDoFh+A8w5BzBy7WdI9e5aCfUOTKHnifPUI9FuXbhZphMxEhyBAp9cfZ0ws45xSg07W0Gw4IxxlR3/rMErpQSj+GgreunT6pn/RxCYorWfRORQiRKVFuvfzxrECJktieqR/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571632; c=relaxed/simple;
	bh=22Ld5IsVD8+cz0+aMVpAD9Ikr1B0/fLk7cN2PWoP4Yo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nGWDDyyxfE9PJ6EA2Lr8aReMOERNKEy8j1MFlWTjnJ06ryTZmLNBzPvdwds8LgJvup2WqJb3tB46U6fZJVvfGPaEP0w+WVRK1z7XYypTPPYuYWf55PVR6h398wxZUpXP6nmvBgLudRTyTSqg/ilg2ZSxv6lDVnqv0E9ihgkv/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FUbhen2h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FK70e7005266
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ShtTC1WEMet9WQjtfiAHqjmC5GBi+F6hbueOGEjlF7Q=; b=FUbhen2hqdH0nPM0
	Y3zUk1tlfrnLCXbYo9jlGzMdh8eytpZrO+eS3WnwNHFtg/1rDTnF6r7aKcwFGo7Y
	9hKqnvCIOpy3FaircoE/QMGBHZsnnLICUrbEHt2oxIEuV0OxDQNh2XP4Lu5zJdrb
	W3ZTlMVlv7NYe0adlh/gJHxbB3490xLoAwo9LgUuevleSA2or4BbQj9wJCCml0jx
	toZ4T8V8zeWOldEyDjkLHgOaaUXilShyNsCRAIsb1kQEZ91LTHZEtFSt0/Jfmnft
	t8YXRjPfT9MVStZyiq7Sr8uiuKmvPqfqftmhOod5KLoeCYr0woi+I0ObsmfKmjc6
	vvKmKQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1ajjtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33274f8ff7cso255417a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 16:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571629; x=1761176429;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShtTC1WEMet9WQjtfiAHqjmC5GBi+F6hbueOGEjlF7Q=;
        b=GjgbLH7QfZnTts9J6B7mXTn+6m5a8j96dNq6nRNnXP5WftmCwYFnJet0p1Bh04rp1C
         C9bn0PZ00clcJ+WPcLGkQpvvfTUrmRqOHKcBq4aJ/Fpz5YknycwXayezASYZpYtvNird
         G3Pi11h0tyilXHsaWhthJqylMe4J8hpLejoFTfgTqsmket/gQ6Mg8WJ6RFmFaYPAijIj
         6b5UfRnhLnEYIcyh5gldVCRyWo+emjJNtOtl/eTwALBRq2mqg8PjZpgw46k7781SYKW6
         Kgo9cxXMTNqKqss6VlEh9mDduGxcW4K8mMIMLGt7/UYOe7QA/t46GMA76UyNZ2opRWlN
         U2zA==
X-Gm-Message-State: AOJu0YxCzs8qM3Gf0JCqK4kdixFRgrSgSGrCZ2E4a6Hk1hIwut9sqKuH
	/WpsAQHfNOQJEke/YB2796VPAW4nzr+7Odgngb9HKOQAsouIP1wPD7cdz8Z8P0Ax979L/T4SF/8
	iyWcl7ag+M6MrqJ1+3m1MuoH2oXU1WopMKQHsBZCq1DZUNqHHUKJSZOLlYO4Cvc703olt7AZAgl
	KdUg==
X-Gm-Gg: ASbGncvGeW31wzdvXvZpoTnDoQ2nAYBWDdYRo+5ajvLSDdWwCCCfczuzEvEf28+HXLW
	D7n2iuT5PYIaeZT7cRThJYijJkBAUxcXD8ku4ufcPVcGFJWIAcWkpskTS2k+RdrMu4cpiBjmeZ/
	MZoXEJcKw+6AEuvSqakxggKUX1W2qv/ktlSnnr+w1vYh/O2zRx+mcW/bVcKfS4DdHibYwY++5yE
	MqoQ5LvGGZMGbvIofdGgqTMIAFFIODVhnlZFdCRXCeV7D4v4Tsxi7zYt11KBZa2W7KHyJwcj/JG
	wtYJNw+vxhEm/swZwrdQdBEhsI3f59BjyIkZgGlEfY+Qwi2FVeCcyS9sTRiJeVgGooHeFibf+xh
	xcW2xSvI7b0mtoRXSIIPj5CKZQdoVc4IJf54=
X-Received: by 2002:a17:903:2408:b0:261:cb35:5a08 with SMTP id d9443c01a7336-290273ecaebmr401810585ad.38.1760571629175;
        Wed, 15 Oct 2025 16:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzZxRJ3FcQQbcnBoCwaKMzl+iyWy2m+UrDUEwwXj1RDq/2Nib22rtN2jAco9VOj3HriTFs6Q==
X-Received: by 2002:a17:903:2408:b0:261:cb35:5a08 with SMTP id d9443c01a7336-290273ecaebmr401810425ad.38.1760571628739;
        Wed, 15 Oct 2025 16:40:28 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:28 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250930091551.3305312-1-sarika.sharma@oss.qualcomm.com>
References: <20250930091551.3305312-1-sarika.sharma@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Improve RX Error Handling
 and Debug Visibility
Message-Id: <176057162811.260563.14871578473723294347.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f030ee cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=H-2_zFce71BIRk9qqjMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: CYAd1XxPG0Q2k_MjiHL0RreTXWjvBt4A
X-Proofpoint-ORIG-GUID: CYAd1XxPG0Q2k_MjiHL0RreTXWjvBt4A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX464JmPqiu1nE
 j+oMKBLAM/jWyXih3W48ChPehVuBF/Xx24l6qWGiBNVmbHXprJFTziObL5jXyl/kUazploR7j96
 a4nm+9iGUDFr8i5JyUYhjMEYuAkaatl8zgZnAp1gED+LeM70IHWvugxR+o8AM6cEHZmGPNl/UPs
 ussHlgs0EJF8kwrHlCAzBHfja19+owvgqnyh8pTXEWOn226IJm0CRYkJaI/j5qHR6/Km32ZEM0I
 D4JAILvFaUQqvSpfiGETaaoqIYSwTS4Isf5XkDsHH+VYtpUh0IMFXNGIPJ6h+X5r3256OWQ7WY3
 g48LgeTnPMpjVvCYCapMVynIqVXPWnjlo1bB6kP+jqiQMFIRkfaL4uvXQXp8kR3OsUQ6kedyC/e
 ucavdE6QG+GhGvyPOxnh/o0wBJsnfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035


On Tue, 30 Sep 2025 14:45:49 +0530, Sarika Sharma wrote:
> Fix buffer leak and potential crash in RX error path. Drop MSDU
> buffer-type packets received on the REO exception ring from
> unassociated peers, as they are not parsed but their buffers are not
> freed. Add debug counter reo_excep_msdu_buf_type in
> ath12k_debugfs_dump_device_dp_stats() to track dropped packets
> and aid debugging.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Fix MSDU buffer types handling in RX error path
      commit: 36f9edbb9d0fc36c865c74f3c1ad8e1261ad3981
[2/2] wifi: ath12k: track dropped MSDU buffer type packets in REO exception ring
      commit: 43ba986e7ac7d9420e26e9a9b03c73054bc2149c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


