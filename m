Return-Path: <linux-wireless+bounces-23084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66693ABA1F8
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B411896386
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EA02750F1;
	Fri, 16 May 2025 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Og6rGCC5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DA5272E79
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417248; cv=none; b=ov9UGkdDKJe9Y8g+KpzBtAWhtBw13j88SJPnAxAGSVPL9kVC8AiWQxA9fnS1/1Z5rMrsrOU0SZhAwDPdgbpMXaaZR3TdDcdCGMTjfA2lACxpk9MYD70CbvkQKXX+BNd2GVwHs9fc1Go9uhZVkMX5A+oVNkMJi1u9yOBGdMpDKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417248; c=relaxed/simple;
	bh=0c1yrSJrjxCsVlYq4tbr45bgKKiXASQqbAogZUlWQRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pBh11DqB7mzLIzG5fig22fZ+CzA1v0njsyiyce7Jh6Z0yxrIicv3PeUJhSnlCED27qZwTDUB7ZM7T/dFTzI2GVCmhuehsFe1tzj6MwIfoKxdRkDxaMz4ybXM8G7aXMlXZ13XSJqijaZai6mVozh3eZR8crIB5GsrbrPeFll2PEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Og6rGCC5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GCpwFV014150
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z2w10jA8jhawj7mJ7gHQ2d+FYBPDhiimjY7HiQ61Q6c=; b=Og6rGCC5PoNgGNyX
	tWn4KKbvRjmChKrDiHMely+CPmhtNIW0Fr85RQnsZECXVYdlE6JsqzjN3pALKZ5w
	jqObYK4zDatp+vrlzMqB1BZxV570ZRxK/2nAGPBHpJDRSJvejPuulJXTOfG4AgDQ
	Z/hWDERlTEG69jVbZ22epvZV1+/Q/gKGjRexfN9efzSbUcrfpAuDTN3TwICDwogF
	h3xdo38hDAjF9Us3e1TXRIjwH6WoLh320zNWPlueuCnvS2xWi026dzQK+pabMq2W
	KGBVdtbP5szSC2zRvrG6VU/z9Ue5xMKotzc0TlVXpyam/cDkI/JEJEQSLGEwqqhB
	Zi0khw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46nx9jt72x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-231d7f59e03so11941315ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 10:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417245; x=1748022045;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2w10jA8jhawj7mJ7gHQ2d+FYBPDhiimjY7HiQ61Q6c=;
        b=jChLMWff5qE+ajHnwILFcB37uRvC+/JhLGonYClQUKu63k6nHVIN2a/xvsAo8DOJ2I
         3VjfpzFEDv5TNwKvfboy22n1Jkp9PkLFIG+eWJKSIQy15S1yeetpRXkaXCnIJtrPbdwB
         P0tEREpPcrGqBgPioGnHhoXiy2yZlyb73qOtiBPDFS4ckWBnjdU3Ir5s5Rm8kKkoLE2J
         lLsJ1KHfK0G8NTmu85aPSKXwcKihzpsFpZ8kDkjIIMRnhKxJRJNvRWxUBeayfk2N3WAY
         ktGOkBSuVhoOwOyUCLT9hvV0L2m7oSv7l/meM2oNXlazqRvavQ8uZbRoVO7+CFaA2FSl
         LfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpqHNmssRQETx7KAhoRtjrMqfdmHT8cwk3PYhPzXVmMQs4MyEh8er4TKN2zBFS9HNyNLidgMjAcL1heoxLUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7HqaWGazCPr4fVeLIXCRe6tB5TwAaWyWi/2Xk+y0UdfzuK3qa
	jTs+bRs29n798FwyMU7nSgf9h45befq0ca1883O2jr7LROuDoMzlqMP+j61A8kWNLqXiI4TUpl/
	/S7kKWQIG9fOOObIx7p4/l1QpQbLSuLCj3zupPNFoA6mt4dvrP6vjRooVWaQQBFPiLMU7Ayb4/u
	ekWQ==
X-Gm-Gg: ASbGncsThr3CgikNBa3+LHf9hrkiPlP4GSAMsLTzg3t9RPPgnmYcLqv6a8+YPF5l4fb
	Y9VbiV1CLihfLZ0iagWF74He7IziejwBfqQHKHznevdLw+5o9EFReuDbaK/78KqDTLHZNuUgKpq
	MWI7JTFyCYrfDXvQwbeqxSlCQvSR9Is7IHxZ5DY1S2gqQ8N6V31CbNAO8HQR3wjMb370q7mb4r/
	YPU9Y3I++MvM9R4kkh+W2uGG4XAse51k9Ku9MnZ1/KFVJAJo8OeUG74G0xxom8iVUc9fQJbrWTx
	1kJMrxDlFfiVeiW3lifqkVgopThRoxGQPRuOr1YrLJKqqnsS
X-Received: by 2002:a17:903:1983:b0:22e:62c3:6990 with SMTP id d9443c01a7336-231d44e7182mr57457975ad.16.1747417245447;
        Fri, 16 May 2025 10:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExtF4TLFrrPoEt4gmfmLFTd9XEB50AQ+2oIAkdKuvYSP0egvrOWfC3m/7jstWY5dO6hzURnA==
X-Received: by 2002:a17:903:1983:b0:22e:62c3:6990 with SMTP id d9443c01a7336-231d44e7182mr57457635ad.16.1747417245053;
        Fri, 16 May 2025 10:40:45 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ade573sm16994125ad.80.2025.05.16.10.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:40:44 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418115627.534833-1-colin.i.king@gmail.com>
References: <20250418115627.534833-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] wifi: ath10k: Fix spelling mistake "comple" ->
 "complete"
Message-Id: <174741724396.2935573.18125129643312875821.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 10:40:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: l3KGtRNePng96NHaJy_cvU3mXGILCO9-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE3MiBTYWx0ZWRfX3hnXS/sWbuw2
 aa/uiodOMUYAx6DObWTet8wC06/7LZvbsJu+S/2iMQx7gKGpBnXRu/rwbo0wUymmxcIuJjkEaWA
 jEfqwdiBbphVF0whQHT/637UEAc3VmYS/MyTjx3sLCL1md4IjPI8TG5J1C7JiPu37B+2stlsNdN
 gUfEhYcOwb7rXazpqHRgy6LeoJKv141FtQzypmp+r+KZvsZ2nBG75uyY9Nev6jPjJsHmW/OO79s
 tKHXnhuS2whOyDw0KQmSlp7X6IZAgZosqtn/omhI4CrtX4fh0lsIikA2F5arwyvK4toqfaWuLlS
 hVfoXWT9xwQ4HbKPinE2DPn7n/Fygw/EkMpniNk2Hy4vTcnOnloWS3F3sYGhEYQ1HlRJz48n5lU
 poOW+USX5xlrk4CVRrTWZzBwzXFvYyJmFOpTCs9TtTs9uyXv1BYrZjaIu3b6KJm2TGySxUNv
X-Authority-Analysis: v=2.4 cv=CIIqXQrD c=1 sm=1 tr=0 ts=6827789e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=uQsNN5m5feiSJzJ953YA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: l3KGtRNePng96NHaJy_cvU3mXGILCO9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=774 spamscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160172


On Fri, 18 Apr 2025 12:56:27 +0100, Colin Ian King wrote:
> There is a spelling mistake in a ath10k_warn message. Fix it and
> remove space before colon to tidy up message.
> 
> 

Applied, thanks!

[1/1] wifi: ath10k: Fix spelling mistake "comple" -> "complete"
      commit: 2ef2d31925f0414ff0f37862b6c33f62b49089c5

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


