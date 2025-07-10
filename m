Return-Path: <linux-wireless+bounces-25180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE020B0055F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41B91C45A17
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 14:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B31F273809;
	Thu, 10 Jul 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TYZOghw+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BFD1B78F3
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158177; cv=none; b=bs8hZlZxatQCYpSTVOfSrJYodoWjDDm+fZ2m7CT24awPjFYHtowPhGZSSS6vbfXaEgWyS6QwRuVuYcy/n/jlX5iQhtqysooLM1m+1+P3UhB1XtVnb5jn47EK77uYQSEUTJJrYK0YSnqFoSOOn+JTfEGiP/DhhOG2YbrldCqIkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158177; c=relaxed/simple;
	bh=9rbaXHDUEMbDw+x4grKImYW+4eEXvESHm5RTErB1TiI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QTD+gxZFc1ACVWaCrntP3ydGdDSvzP6Jed0AJgoR+yodcZ3/dVyS3vhFk9+JKTCj1NPkdyQvbLVP1/xM+2PBRUcJj1OcUah3CQ9MHCMphh1HwruhH/QIY/kvGZNH0A4hDoTbAazPJfLkktVOAfAC6WhIvRzNECBEdDplOTCWIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TYZOghw+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8JEax023036
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tQPEiqqj9VNrqfrfVuyEmtc95c2M+h0HYsN2qZTWmag=; b=TYZOghw+bCGWyyPK
	DGYoZ6mTXzgdIPkyiXuvmoTiTGu2r0BiNYVxOJVu1v2ndLjA3bLxqAZgiEygXNd/
	v/SPqcHBgT1gpvaZYEL8cOin70r/A/VwxG/qrVgIr8vtkE1ZHeUYWgn3dLuD2hpv
	p66v5hntCORVXSMkt2EVUBCezcbWmKueCfWjpERQqSyD/SjdjZwmET7c/m84PT5g
	TIXBDv5NTEOGFV8y4pTYaOTTcq5LUk1nPLMmO8cCLzP6ZUqsM2VBXuHzDJixJLUp
	kA7t6Y6TpfrNcX1bvvdhJxiflBpEBCO03EqLOZb+BRVzy+wSJ8lV/D9B4+zYEoN/
	PEBzJg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap59ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b3216490a11so1237181a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 07:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158172; x=1752762972;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQPEiqqj9VNrqfrfVuyEmtc95c2M+h0HYsN2qZTWmag=;
        b=WpfCDaoLMMTM6TC39c7CtVgVEf2bmaRzttil3OUCGJc0brLVRr9dIqCGI7M0h3XipT
         7L5khzr5naGdw/oBY1R6Rmmr2H3W62suP4/4isd9cnFytxP0e3dahvNkK+6rEkFWiIZq
         cNsTDtHfY4Z/WQr93PgQS78GXpsDdGdpOWTckh+7OZYATU7V/a9MeUcv67bvmaeKM3yX
         G1V+35tp64huvnvmmgOrVPsPSAFzFAC2hISrOD1lKbWu5rSvoj/ErVLvN9TnjsN4sIvK
         yGNg01jlMGeIl6z1r/muM6oDTz6PT0OyVAqd2Y24/W3e9Jn+i/3RkOIUUuN154mWfFE1
         eacA==
X-Gm-Message-State: AOJu0YzGdA0M9AINNbfR3opTRT7xTl/5rSL2Sextn76GWzG7ZNn5T0+4
	DHqeYpx7h40rhp6fsk9N+dpq9Lglag7Hly2t7iXl+E/3wRCGv6dgIiaU3+TxxcklzWheZG77olp
	gy2sdTr62JK2N9JRaDq60ELB/dp7O9zTvhaoDtZa5BlJNQUj4Yt2micK7YbgvVHHBLj/zgQ==
X-Gm-Gg: ASbGnctWfKLyBoSXOLsC7ni0PfAcdcSDn6XhDSq2WWX63e0/a3164heX9w1bOzriUL0
	8PHslWCiJNSLrJfF1/qhXI5322qf2JlHCyQVSG/IXzPlcI5jCygtUQLw75W0Xj+RJjGIOv+6X40
	RKkJP7c7q60EKyaPixlLQJuHUCqfOa5z16xSnxu7Qb0s8AiYZGdmStXQP0YgjnduC5sl11u16sT
	qVLOJuyEHxgc6drzfr/INgP6nwdH1AGlHbyEq2zw5jU8eVjQ5yMlt/lM0RM8Oh8Y47cLCZnEIS/
	r3yLlDGrmLRmTOF3E+S+3J1nE1vA2metaNJwK8ZsfPdPjQVABRiDneOQ0W8=
X-Received: by 2002:a17:902:d2d0:b0:234:eb6:a35d with SMTP id d9443c01a7336-23de4876bcamr46630145ad.27.1752158172126;
        Thu, 10 Jul 2025 07:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzornK5IlTs3i157JACc4s1JN/H5icJdwIbS8IrVHCGZjtXeYDPQ64UgKRsxdIio8TQM/HhA==
X-Received: by 2002:a17:902:d2d0:b0:234:eb6:a35d with SMTP id d9443c01a7336-23de4876bcamr46629575ad.27.1752158171554;
        Thu, 10 Jul 2025 07:36:11 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359a86sm23758055ad.210.2025.07.10.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:36:11 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <20250701135902.722851-1-quic_amitajit@quicinc.com>
References: <20250701135902.722851-1-quic_amitajit@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: update unsupported bandwidth
 flags in reg rules
Message-Id: <175215817074.507672.3474115457894401966.b4-ty@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 07:36:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=686fcfdd cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=DaUM1vL2nq2eCnbLUcsA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 6-VS1IzOX_YporrGjxJWGGTiYDDykXG0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEyNiBTYWx0ZWRfX0zgmKyJac1Dh
 3FEwMuZArlR3vWzXG2T393yYELk16sY7ptil2/u19aHOSabp7XCn84l1GiCUIzaFYlfjwB0phFQ
 pH6azNfWaWm11Ui+G9kkN0XGa3WI5JSieE09qp2hNf08fNjKwXXOGJjqyzHgaDv+D7EChREbPdH
 WT2hoS9XvBYGs09hAsqrAcv71kdCq6Lxu1I8Ab2uJ+kOxAVB6SZAa5cv2DYbnU587f7ovxliPhO
 UmEalhg1CAngUUr8/qeDym1uHqUOMLeWZaWLKosnsnDZWXhhnAzLBbI+00Im4HXgT+dd/uUwxSc
 4SzjMxImTBFvs9EclyL7bDlKeRrM1wjOF5kitCnWLLskEYIfhg+mwPESrfUlsQF3dhHBGLb7lrs
 FFZtRLue7jPT9UfKb58jh0b4IwF1vCUjqWNNqeUJwg3RNXEpHUnWuoRs8ON1A/GpZIXcyjYN
X-Proofpoint-GUID: 6-VS1IzOX_YporrGjxJWGGTiYDDykXG0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=818 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100126


On Tue, 01 Jul 2025 19:29:02 +0530, Amith A wrote:
> The maximum bandwidth an interface can operate in is defined by the
> configured country. However, currently, it is able to operate in
> bandwidths greater than the allowed bandwidth. For example,
> the Central African Republic (CF) supports a maximum bandwidth of 40 MHz
> in both the 2 GHz and 5 GHz bands, but an interface is still able to
> operate in bandwidths higher than 40 MHz. This issue arises because the
> regulatory rules in the regd are not updated with these restrictions
> received from firmware on the maximum bandwidth.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: update unsupported bandwidth flags in reg rules
      commit: 2109e98503bc1c01c399feac68cc8b7faf6d0a4a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


