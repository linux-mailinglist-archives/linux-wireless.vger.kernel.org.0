Return-Path: <linux-wireless+bounces-23096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F48ABA43C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 21:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6F7A4060B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402AC27FB08;
	Fri, 16 May 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e/Syyj8o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27727A935
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424432; cv=none; b=PHvFGi0T2NA6CzlOBqNu1FGFr/WIQgCDx7ihgx4orOUeC8oLYSBkNAW2kBzY0O8jUwDPvUzkLf8TaKJ41GLpJt6IHdNKrQ5t7VcqTk9IvC1hMyoqtT+LtGKOyEbAc9Bm4Kq++pfmnsNxcPrp8PvKPSTU/Fwxwg8VLUwgT6Od8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424432; c=relaxed/simple;
	bh=KFzHuwVYK0p8YlGOC0YLQrm+LK0SPlOIEWdpZinf8gI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sKwkpRjSduFZwBtIoITLgO8BLVhINrwjD/IPN8oV9yBMUBlCOifBZelBj220CTsEmY9yC4xp8QVYESWI85QjO/ehmMWEmqby4NU9N4NnaGALZPkG3N8mToHKbkm1X5wZlVd2ItDaSVsH3cBU4pSykARZrRo84NiUj8f40WVt34o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e/Syyj8o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GCH2un014002
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BvoHKEkjzzYcPzo6Da3jASTKrHpVPvX8RiAcr3Pjjtw=; b=e/Syyj8oMw7KPHcv
	5THUBGlvmthJ1Kre/H2hk2LE7QLmuK79U1ovoFJDYBuXFAGwDerrWwc1AJi/5wNf
	yr8H/xFSua7MywaO277xowGkZt8ND2mA0u2jxvScN6lSnB6GWmeFiON08SfnXfey
	kMjuS8jOnO6ZAeJ5zZJfhBt2QL9ar4EwDUiEwhw52sweQWfI5cGp9MxX6so76FDU
	LhpsZF+L9j54sJByLaGxUFCGVzHpJGacTJjVPGJjwvdLlf00j7Hd0pjGjvXsrNe4
	/k7cV8+SIAC9LHi9uagq2TfxHdlVA4+HjcCL47jJkOjJHp4cWGOd+HcEtQSMeknk
	4ny6eg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46nx9jtfq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22e6c82716dso19745585ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 12:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747424429; x=1748029229;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvoHKEkjzzYcPzo6Da3jASTKrHpVPvX8RiAcr3Pjjtw=;
        b=OYlGHV3VA+/2DLu6zstkdiRdEyQdzk6wt0l3KVpYqtTHDn2TLK9Y5oz8WCobpCOLWU
         ommx3gSbcLNLb85NXudjnPoHMwzgatbGd8ktX5asPvPH2oIImSHdsqKACi+m3A5R5lUk
         npfjYMHONUbCvvxQOBLOPbBAGBqIMMGSwitVLQ9WD7RAIJYUbluguYeBwS12rTltB1cD
         otWoVRwWykH6RBKXy3t95Tl3GUq5eg1PKsGj+Lcyjc5y4pQt3JS2RSCCthyhaM4cVe1A
         l4NmYvcgPJ1/qxGMLRD4UUpg/+gXuBNkv7nINAugcDu6CglsI88DWGb3aXomNxkWIE3o
         7bOQ==
X-Gm-Message-State: AOJu0YxkO+vYFM1DxXy5LkdwOIz5MYt9zyaOZiNQUabSPQS42p38/dHF
	YHvi7/B7nwk05nZaYY3TI9mdzRd7PqGYOnb7QpdA3OIXkDPvjqxAt7t/FqwhI/gxXhMEiVbQ1iH
	hrh5lMoSM5yp9KLmL7rq+GBUdZZIecBpc1eAoRepRExh62mhOScyN734fPy4Vv2fymvi/IFvKgs
	9mbQ==
X-Gm-Gg: ASbGncuTUErXEWLkcPPlKtjTopgLWAbWgih1qKopCsM1Hj7ShKQOIwC6pgERDhHli7A
	oy7fAhZDQiO5zBkZhmKgabC0HcFMsro1A2W5t1ICJ4XwknCd9NQWkgg/7r5MzWmMExZfPe7m7DC
	5VE9/cBTPo7uNFq/8JlV9EMUp1L7kCkG5f3ej/jglYABu4pBSgyNq/3DtgZsa6gKz/oi7g5jjcg
	AWSJhFm1bHwpKrKj+9WMJcQukPduxO9BLvmAYonIIGyR8yj9FLYl4m9s8guavJF7CJpdc5QyyHt
	DL71AxoJjzOXPkLThHCm3x0ecI+o5qghostCwsn0O5b/gts1
X-Received: by 2002:a17:903:187:b0:231:9817:6ec1 with SMTP id d9443c01a7336-231d4e55359mr57479035ad.17.1747424428531;
        Fri, 16 May 2025 12:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Fl4Buz7XgPH4csT8qvjpXcGdBTeEEqM64uxIAnQiWW5H0Ey2pjXi1jomB/OZVtroTO8pbQ==
X-Received: by 2002:a17:903:187:b0:231:9817:6ec1 with SMTP id d9443c01a7336-231d4e55359mr57478825ad.17.1747424428180;
        Fri, 16 May 2025 12:40:28 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97798sm17955255ad.147.2025.05.16.12.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:40:27 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
In-Reply-To: <20250417065237.2507613-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250417065237.2507613-1-maharaja.kennadyrajan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Add support to simulate
 firmware crash
Message-Id: <174742442738.3316767.17251889559296921974.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 12:40:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: WoY_dC0P5uaGTStNh7KDICeLD7nbwuz0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE5MyBTYWx0ZWRfX6dProa8On6uK
 IElNKa+oMYvHwir/Xws4ycN2SF+hbJGVBxm7ias3gMed0GgJtv8mc0+R7yM4SdzuBpOm1RS4d+5
 wCL2Rb15pmAs1dB9kdHJ12KisFc56cSev3xUPJpCvSxicXlNsC5DaqkYXavvNr/2+OgyH1g8u/P
 s7DGjbycLX+nfcFJk+QvO/+GOsRmpdGHlka0k0mouJNIQXQ3u8tD6wgbztEk5La0URSbPRHY9zT
 H1Txyk9DX6BUa0EJVWQqNcWyKH6egpEKC33PO0dKUw0PWCoZ8uknRo83hjeAZOkck0DaEY8oNAV
 eeo11jTc5g3jV1qO2XxAOdsns33oGENGrduYS80et6qqYFH71qiQnH1DZOBuQeKJvolxSuAlY+2
 txcCrwXlqF/vMG6G/8kdGZ8aEBJfPInlxgIkuDeq7upXmAyUwR18jzHsHxgVGXTvN01aUU0Q
X-Authority-Analysis: v=2.4 cv=CIIqXQrD c=1 sm=1 tr=0 ts=682794ad cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=hXFIHNaUnWQ0vPDBKDkA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: WoY_dC0P5uaGTStNh7KDICeLD7nbwuz0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160193


On Thu, 17 Apr 2025 12:22:37 +0530, Maharaja Kennadyrajan wrote:
> Add debugfs support to simulate firmware crash to test firmware restart.
> 
> Usage:
> -----
> echo assert > /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/simulate_fw_crash
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add support to simulate firmware crash
      commit: 7971bda2fe57cd86ba8e1588366c1633cbd007c3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


