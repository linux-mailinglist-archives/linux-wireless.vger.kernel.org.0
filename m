Return-Path: <linux-wireless+bounces-24709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45174AEF1BB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 10:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5503A8103
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CDD22618F;
	Tue,  1 Jul 2025 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YpGP7EZK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F722488B
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359760; cv=none; b=V415+RAaYztKlh6HfRWDc/wm3cJxXdo9fJ+2KghiUgdMb+N1RprJisoq46juYNVYbHIQaKVMe7XpiwTIOl95mKyMvrJdV4x/a86iu2JDPVx50AJzaAvdvQ8O93JNtHW+rnlVEI4r5H7DpSCrUNZLWcszntL5H2i6aAe9OkBZdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359760; c=relaxed/simple;
	bh=iB9wQsnPFnjA+FsBjRsdlB9P/ugucnogCQlOU4I8V7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyJyC6dF6qiR79glvDqIQhXFIpWRxRRlynkv0mdIPhiI6TlMscyEJez0w/0fE0i6zK7UrcaoVNAgk1t5nqflNsO5zLO/arvL6hse9YOAUQtFerndgF2naj4orX1tWDmbLUO648Ic1KR6FGYzVMB07ct+jP6zCAWQbC66V4AOokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YpGP7EZK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5612Ue3V002153
	for <linux-wireless@vger.kernel.org>; Tue, 1 Jul 2025 08:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hn9BEc329/VEkiBC8gFvy+qU/a3O+eBhve9KTPKFkSs=; b=YpGP7EZKiwDmWvwT
	Pe/c7qYs7nKJCrc9EKXHIKEdTOCvKkH2yOfGjPBLjXZq1xW5bVWGJy2UDdULOYZw
	JqoXjkUAdzm7TB6XKkYs2iSQK10NGMFh/TUA1t8quEvvI6QDgSFicFp1SNmWU5Sn
	9s+5aPVFJ6HobKvYVXpoHTbvcVZSnfWx1SYzjdvUZhJs94aVOFFKhdOwoCR5G1r2
	mEOrVrYqjSk3279B8Y8OnQtagO5eGqc4vTDujpMS2pz903rPddmOR0yNAxObYR8T
	iMHKGdXYE3Aj8AqkIhgZJXtYeFnPleKcPkVIUFY7XqkaDRPpWwYB9Oyfuzseg5nc
	uyqeGg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9pcqt67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 08:49:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-312df02acf5so4625061a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 01:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359754; x=1751964554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn9BEc329/VEkiBC8gFvy+qU/a3O+eBhve9KTPKFkSs=;
        b=V4lYWQHEX3n7LHRNwdBK3DcWgn1EswjPzKgTnaJBLm/QYf/xOjp+yfoRvj0i2y/KzM
         5310anLCoDstK1EJ1uyOiZ/rfWvUlTr8n48cE2BXgF7l1TS244lpiGLPhYW/E95NEIJH
         cds9RWZ/ThEJR+SHSMeDT44RrkSF6FqITA/liUMFRpBP9G/OL8YHF74OR4L0XLr+SGoZ
         ejB9h/2FXvghWHR/1or1DAoypkX1tGi9IUKfHh0Oyqz+RodQr/4t46F0ytvV6pHCi5nV
         NwetmM+PhhA657OWM7Uoa7rMwkAqw86nF2tLvPWiQxjt5zYVPgMjPOF9dWOXqZvdWnCz
         2rsw==
X-Gm-Message-State: AOJu0Yxpen9fhVliNkzkRlbf/YtE8WL/jTVrylnTq4Dlv6pxP2uiM8Zy
	e+5dMKO90N+PPmgaCimVhrfJPtfSyV9HflWJbezfst4YqwZZC0vQUp4j8L0ZxfB4oUsVa4BME8Q
	tPnnWdIzsGIfnCaKJZFjQM3GrWhNJWdTATHmr1CWpLs2EUFHtTZp7oDcbJmvsMfaBTNHhtQ==
X-Gm-Gg: ASbGncs4BzGj/qby3ZtxT2UdahctTDO/7Qd3gH8u59dbjVEKqffDwJPLko+jcglJPjI
	JJ9cc8ankP+wzUQYgwqqTxOXM4HuHHIULOKxSAQ3zjIOj3u6MgFVJMSTPuVr+R2fYAJo7/SmEmg
	UBHn3NtTCx5pAhTjHNBkBY53QlCHpFi2IF4l9AVBx2OY7Y3ZVHmqokOPmwCkyfEHaQ0RiNWijD5
	jpWe6G7fPN9wiEvnOd1PFleb/o9PJR/2wV+7dYU2h7IlrCIJCtN1jOKwkyaDUHX0EdICihyMlk9
	Efey8PwzMJVPG9r8mfD8Q82y2xQgUTiE+C/23zrcOyr/f3/ydz9lg3rUeTU5x8S/
X-Received: by 2002:a17:90b:17cb:b0:312:dbcd:b93d with SMTP id 98e67ed59e1d1-31939b7bd6cmr4341835a91.14.1751359754368;
        Tue, 01 Jul 2025 01:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9SVO++pDakVFQGfgX2YbbH28UoOwYoVlF8NEnQMTAWH/CWI6y7jHxZv9hiemwIBciRJOZKg==
X-Received: by 2002:a17:90b:17cb:b0:312:dbcd:b93d with SMTP id 98e67ed59e1d1-31939b7bd6cmr4341792a91.14.1751359753847;
        Tue, 01 Jul 2025 01:49:13 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14fbebdsm11440292a91.33.2025.07.01.01.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 01:49:13 -0700 (PDT)
Message-ID: <58ae0ed9-91fb-2ee0-73fa-321313033a74@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 14:19:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: add support for Tx Power
 insertion
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZrXwFgbw3r1w-7d6aVwxwAnhzYwLmW7K
X-Proofpoint-ORIG-GUID: ZrXwFgbw3r1w-7d6aVwxwAnhzYwLmW7K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA1MSBTYWx0ZWRfXwym/q/Ild39Y
 zDXd5TjzRx5TTNn0u1klERY6xM+PX5FdvCcfwiyDC5M2l5Okm8STuAIgze4JBPbr5eJmtxMxzJw
 XDWqjuEY5Ab0nPGsvbq4CPiLcktgWmn5uM7CbVOH75wucNFQs+jzwUs+CWl/9JsZPuMge8e4QGM
 Gu3sEj7b+EDhVb7EsqNLkDSTjvkOC7R+kz3hNdR9b1Tbw4ubdcJGJKYvd7gCFt7FaodMXyYMXWg
 2Kvgc7WPu79PlnF8l8ukwkA3uYmzvR8337n5a0Pa6KmtVUCDFFYMQtxW5BhfxGokkfxME1QyQD4
 6OCquZPTzF0V/dTOgcv0MSGp5PilSU3Z2RKZYHE07WBoOnbETZabDTJzsRzwGco3nw983pVFFlc
 aMOKHWmmy4VNq0hblrRE+yapL9lAQuG1Nt1wloqc3ZOmaAaAJlbSh1vJzTXVrV9Q3PzolYAA
X-Authority-Analysis: v=2.4 cv=QMFoRhLL c=1 sm=1 tr=0 ts=6863a10b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=9jhMNZ7qWXdoG8tHMgQA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=950 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010051



On 6/30/2025 9:45 AM, Aditya Kumar Singh wrote:
> For certain action frames like the TPC Report IE in the spectrum management
> TPC Report action frame, and in the Radio Measurement Link Measurement
> Report action frame there is a requirement to fill in the current
> and max Tx power of the device in the packet.
> 
> Add support to populate these fields in the relevant packets. Advertise
> this capability from the driver using the feature flag
> NL80211_FEATURE_TX_POWER_INSERTION.
> 
> In software-encrypted cases such as PMF, skip insertion since the packets
> are already encrypted and cannot be modified.
> 
> ---
> Aditya Kumar Singh (2):
>        wifi: ath12k: add support for Tx Power insertion in RRM action frame
>        wifi: ath12k: advertise NL80211_FEATURE_TX_POWER_INSERTION support
> 
>   drivers/net/wireless/ath/ath12k/mac.c | 184 ++++++++++++++++++++++++++++++++++
>   1 file changed, 184 insertions(+)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

