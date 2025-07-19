Return-Path: <linux-wireless+bounces-25682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52908B0B0E6
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73F93B19BD
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8683821D59F;
	Sat, 19 Jul 2025 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WB/xOdeH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC36F1482F2
	for <linux-wireless@vger.kernel.org>; Sat, 19 Jul 2025 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752942165; cv=none; b=us/vZDhliCStx9bJ7j70cCxyoHgJlojD1eF1N1u+xZ8xyqsRMdicFWahBdhIpDDjsBD0zWtCu0SGjfcR/b/8A/+I3IhbBzyKpTsQrmXPDfBo/bVHbB+kUtf2RgNuoV301O88veWSvp0CTTVmA0AfIni7TPGr0dhAc45DoaIbhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752942165; c=relaxed/simple;
	bh=cBY/3y4ODvXQXnOydhXDLKPxQVpHT+3G6MuydL6PJBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FkYVEN+LIxqMPqLwIHF0bVaqqUR+XNZq0WdKRP7jEWaQ3eaPdbGsRkUtlY6uJzHdUQmqVZGxD2khumlVL81RsuYkMuRO7W2o9zMg4yXOjWeKxR8u0GMZX0RXW6xOwphETm3uyH76j/lu9pWyrcztYN3xowl522+BICkjcbLbTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WB/xOdeH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56JEpL9Y005989
	for <linux-wireless@vger.kernel.org>; Sat, 19 Jul 2025 16:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZFp+JOKzx7DaEUo/HUAr/pzFRcL8dFxbeIn4tC71Fjk=; b=WB/xOdeHB7O5H9DQ
	C46QbCfi5glmHgY6hysL23xcIey+CVJ6+/bkrWeHVL1QE/PT+GEwaHQh/jYpxrPI
	6VrM7KpuqlfTpw9eYkPLOVKqfs/FtAAKy0oE+MW1iniNqd0MdOjT0NyaJ0+m1SYo
	2TUcQ9+viyESGuNNWhg7WzW8/MvO+rOR92W+Pifnhp4wNfLyJN6vBMZlQxA1ZpxY
	kWcZz0X2CL0W4QGJAeJuzU7HrnYX8mnZa1voA9Mi0Z4vXlYEQz9eY3qO4KzK1k8K
	IBw7wXaXt9Z5cDNVUlPanISBppxXSKrqR4feGUq8fK0oHx792pP5R4jmjookAgkb
	hYPZlA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045h8w9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 19 Jul 2025 16:22:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b321087b1cdso3340197a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 19 Jul 2025 09:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752942160; x=1753546960;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFp+JOKzx7DaEUo/HUAr/pzFRcL8dFxbeIn4tC71Fjk=;
        b=e/oNVue0Euukizb/j1qzJT8mhKBejr9+r7Qy04Xz0NorqB40fbhqj3DsUWABJZ2qby
         U7ClRKLlU3RcPJrIDwKT+v60uSkjR9YeChK0D3wJA84PfpSaOVfiFGa5YB+Td/96eBxA
         HGTdm/kjHlyrWXTa0QJjVbHhkk4gGlro6CmqGMqV1DX5wZfRWH+nu6P+kSKT0FXgY/Uj
         lCbIzT/70uWPC1j4qntKa//h47TSLqugK+o7XOjfSSQutHXfM51NrFFafhDVIc4TOTpi
         YBKSL2PxMgIZpyUS4uEz18GpVLi1xlyUliqEAGHy/tOhd4gb2yWo3nInEk4T1wh1DcZr
         N5Yg==
X-Gm-Message-State: AOJu0Yz84+/RtDyu8sMg/XIw41klqCKryUxArTKP06YoK65XiTqRcpSQ
	OHjt3SoCyGXUgHkVFCIzk3sDLyN1w2ltQhvnffWWlj9r3rXbbA/06sRiVIdw46Ea29dhxplhmKU
	Yc1sljUqeRYgiguyloRgYEdHEXjj4kAnZ0JDPQzPa90pfnnb0kyMJhfaqA6yyAC0t47sPJu8KAQ
	jTyA==
X-Gm-Gg: ASbGncuBmIyme+W41NxCzEpc7zAc6jTg070if5I61jbUHQ/gYWWLX1cGmGdp8u9BYcb
	K9bXTJj+Pd8RoqNI9NfqtHMxSIa5gjlZBZBinIiVY0TJqc3D+H7jkf7t26RyKSGJkYjhtlzWkRF
	9wMBjWU20z12erbA5B4SuuOd6khzGZFLFobcPyg8A0w1exeKeJKmIIYsQcJzqYbOh7nS4w5wJaF
	YMF6It1cqw/RNA3/GTiEU+Z9qZwbVNM//XA4KVtXXc7d4U+ik+I6yA1144vSiVVOBTFp1xxjDZ2
	3BsUrIg9oEFCs6CZpr/IoNQSdu44uKeGcCNF/8MTknvXRUAcdyPMinYQgnxSo23opnOj77eVBrs
	n
X-Received: by 2002:a05:6300:6b08:b0:238:3f64:41a4 with SMTP id adf61e73a8af0-2383f644810mr13205367637.44.1752942159690;
        Sat, 19 Jul 2025 09:22:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESNU7pu4aS0A61SLhunt6HW7PpyuYRHK3fH/Khb9c0IvkeDmiSLwCn9Shnkv9AN9sWgFQwsg==
X-Received: by 2002:a05:6300:6b08:b0:238:3f64:41a4 with SMTP id adf61e73a8af0-2383f644810mr13205350637.44.1752942159235;
        Sat, 19 Jul 2025 09:22:39 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc0bd12b5sm3488765a91.12.2025.07.19.09.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 09:22:38 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2 0/3] wifi: ath12k: Add 802.11 encap/decap
 offload support
Message-Id: <175294215850.1412292.8023789417274825666.b4-ty@oss.qualcomm.com>
Date: Sat, 19 Jul 2025 09:22:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=ZtDtK87G c=1 sm=1 tr=0 ts=687bc651 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=4XmXn8M6qWpED5Dd-1EA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDE2MyBTYWx0ZWRfXxRt/9Jz2stUG
 m7bHEPtllssTaZG8CV7zss2mG/0XE1TgpgLEnE6qB+i018N6D3hllIEbVax4no3DUSeG5mY2ViS
 PhdPIehCxdXLwm6OhWoe5nb5twpbYGQSyOYN1V0pCHmSQOaF1voJQujFmZ6v2+nXLaPdMf9O0dF
 UviUy5L62o65vjAou8iytGcbaJJWR0rG4cdWs9CFptWCF4+CLiCncWh219cJ7zHOXGLr2EsCwqG
 QSfFrJfFaV0IQrewTvhPxYo4JZ4/ioJ0lJzZCH2OOfYQsAB+eVg/WoWnHlcD1oNCDDXSiQECKRy
 tjcMzFhCOM2T0OLmS4YBkM1uqcSuw/tjA/aUhmIhFvaPJP94nQ5j8ez03dg7LZGhb9vTh9BoaNh
 UIkXra3WEEEGMpM0ms4JxnG4s6IoOvNaXJB4XuM4M8uOEoOYr08iR2omiO018qhBHBKWWKv0
X-Proofpoint-GUID: ZOoeUG-Xt4UvowYyQ26G2-cCVD9U5-Nm
X-Proofpoint-ORIG-GUID: ZOoeUG-Xt4UvowYyQ26G2-cCVD9U5-Nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190163


On Fri, 18 Jul 2025 08:25:10 +0530, Nithyanantham Paramasivam wrote:
> Currently, the mac80211 layer handles construction and parsing
> of 802.11 headers during packet transmission and reception.
> Offloading encapsulation and decapsulation to hardware can
> significantly enhance performance. This can be achieved by
> having the driver advertise hardware support to mac80211 to
> bypass 802.11 header processing
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: Fix the handling of TX packets in Ethernet mode
      commit: 192c8e9a131f1772a635c3c5df4cb592bd7b3e8b
[2/3] wifi: ath12k: Fix TX status reporting to mac80211 when offload is enabled
      commit: 981050b918fc4c36e0ef3bd7392b39d7304ef09b
[3/3] wifi: ath12k: Advertise encapsulation/decapsulation offload support to mac80211
      commit: d29591d5b52eaa62bc8c07ec83fe63018b5546ea

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


