Return-Path: <linux-wireless+bounces-20475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2374EA662DB
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 00:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5334B1899A56
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 23:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565BA42AA1;
	Mon, 17 Mar 2025 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMoS2PiT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B44D79D2
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255207; cv=none; b=ZUExjn0qTCgLtPawsBDJUWX0htLtPH3l6uAIKSRGB+cLGHSQcJePJD8qfYL/6eeAbSu0vRdcHcpKPzXJjv2Tsn6/+YX4pUpkHyHA6aQOHEZeznbht0xMYKe4J+unx0GxZjhV1k9P5sf9YFeORDLxuJbjvJMg0rKcKhJbNVmgvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255207; c=relaxed/simple;
	bh=00Tq1Sn6pYuWR5ApxJNn0rpU11AvZCnSZwrD7KNGjmA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jmYvZsgpIXgt3sLMcsBEJckZnRD9PMDOJrex6AXYd0c2gq3+R18y/aqXSBtttue8Zc6S1hhXoGYGwDHR1mnyBmKJYMZrxl4srdRMxnsJCcjThkJWOTFcplDJMbB0dPrkw4SH4Zn0irWVh3L2xHWhYmDt+fjmDBjlR3xA05oCpfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMoS2PiT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HM3ITn007724
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 23:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8/sfkIrXSkNuWt4PPb8dMXmpEaWbqBqVV115tehWPoU=; b=CMoS2PiTJpapGJv8
	5oD0Y3Pqx4ee4ArBsmhk+hlPvVQUZPz4HgQq6SG26LY22Ci6rt5Xy3lYzThTRy24
	B+D7w3IW4fZ6RqwiCfiMvzXYccpi2TlEuLcgAiTui+Stltk38ovtuuglnBSqdkFz
	GXVWQJxga5DYPHMbsjsziN/7zLK6O+F7XYE+yKAzHxDzrC0nnGZn/qktHVAy785u
	5MLHJ3kbEWLDxYDq9MiV+2DGk8GBoLzt/6lh9hvYLQkf++sLMqbQtd4+M2nfSL3R
	1GZ2SqFwlucsmzFV1XSjmD9JR8iKOQnMDpgxVsuMSoOjkMJ2O0jX1yZlcnkT0hj2
	nQq2FQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1u8ea0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 23:46:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225974c6272so73635335ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 16:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742255202; x=1742860002;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/sfkIrXSkNuWt4PPb8dMXmpEaWbqBqVV115tehWPoU=;
        b=bUBLdPvmnXfbGjQG15aBoUQQXGH1bn8gD802fAY1sUzN8HHh0QOhSu3lMaF17YXIZ8
         gz0rYortPr7HLjo8QMNAfZygmXXF+ERH6o27N9StxJ1lLKQ0niX4PiBG1SNYTO2wPl92
         PqVzKwJxKe9XahQlzSIANn6C8daisoHon9I/aUkD9Jnx9M1sEOQToPcFP8nvGZTBxpKt
         gRYJHof9FL5aQEKNQo02zy7zH81KOuw40hdEOv27lETkJb/9Nq+tP2ylU4heDI7PVPhs
         R8SMYJuK4Xcfp1Zv4lO6hTa67SStQiQdqYRdJfoQdWwoh4t05ePw6TtOoLwWDleHJUkP
         WEAA==
X-Gm-Message-State: AOJu0YwVblKHMxkZRK7u6SCJp2kO1NQuixyp/B92lM0VhKd5G6/Wh9yN
	Pzl00eO3ML2hxPouAG4QQGB1yYYcvpqkQBAynT8lQcgRGIwiwzbeV3wi92yFhG6HZUcWXMdjSDG
	8Fggt1eOVGTdCXnfrqBfOsnUkveh/LVzDYC9QOh44f3Oq3MAw1PGKicvx5F/al+7IcQ==
X-Gm-Gg: ASbGncuOCksPXQmjsjpSkPEckYURAY89zFTIk7OYhQllLvvCAKVUrT0SvsaJjiYJkF/
	JFEqp+x99rHoaziwfba5aXItKLOwBcyk4JPs+ESI2dGFPDUuXYM/HuGts2K0QFuSR27zHAKi6hf
	CJ1sU4FRBnn9nAUf3896FMWq6OPRbg4UEVGIxiB38uxaw/t4hwmfoVh/kPRt6ETCJdUgy2eUAAE
	zTRLUVNGkklnqk8RptIb5bqG8pa6IC0/S9QauQi4NKz8HNXB5X06p3MasK2bIlHFukzLmgBDprx
	R3A0UIdrBfRYU6YYSJcrjbkMiWIM2dT47YS3zQ41utEk5B5jnHcc
X-Received: by 2002:a17:903:2ac6:b0:223:3eed:f680 with SMTP id d9443c01a7336-2262cc2da6bmr16839425ad.18.1742255202414;
        Mon, 17 Mar 2025 16:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6Aer9oh/tCgmZvJLZGc6i6PHPS5PssF48VkhJJDsuvir/xyz8UgsTQbzuy40q5rRL6kzIgA==
X-Received: by 2002:a17:903:2ac6:b0:223:3eed:f680 with SMTP id d9443c01a7336-2262cc2da6bmr16839195ad.18.1742255201988;
        Mon, 17 Mar 2025 16:46:41 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b1103sm8228773b3a.167.2025.03.17.16.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 16:46:41 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250314185605.68454-1-muna.sinada@oss.qualcomm.com>
References: <20250314185605.68454-1-muna.sinada@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: remove open parenthesis
Message-Id: <174225520132.3294327.1520236017702995285.b4-ty@oss.qualcomm.com>
Date: Mon, 17 Mar 2025 16:46:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: kKoGUFizws9WryCYaTWfSVwIezQrUyT2
X-Authority-Analysis: v=2.4 cv=c42rQQ9l c=1 sm=1 tr=0 ts=67d8b463 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: kKoGUFizws9WryCYaTWfSVwIezQrUyT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=729 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170173


On Fri, 14 Mar 2025 11:56:05 -0700, Muna Sinada wrote:
> PMF debug log has an open parenthesis that is not needed.
> 
> Remove open parenthesis.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: remove open parenthesis
      commit: 47c91531edd2a552a8131414e4bdb0654277ad6a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


