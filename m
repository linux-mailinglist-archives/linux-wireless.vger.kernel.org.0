Return-Path: <linux-wireless+bounces-24630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39553AEBED3
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 20:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D5456380C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 18:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F316B2EBB95;
	Fri, 27 Jun 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g3NEW2b0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CE2EB5D8
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751047364; cv=none; b=VTUW3r7kY6APmVr3rHfccG0TItu3Nh7eAnc/VhhniMwYpEfG2krNxsqItwzWnmHPmhT7oa3OqCQoizjLHo7rPWEDv1kmfAUYS4FI/0vNvedT6kxn1ufgYsgnlHmD6QOLwFF8Gwk0ecbT7qWfMqc+IRJBRthwtoLoyyEFI7PBUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751047364; c=relaxed/simple;
	bh=7K3dz0RHRwog01/5OhJi5jfcUQuZLwHGDzYJ92Dzlow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SC+FHqkSwQeysUPzDBMOKzS2zr4EhD9EVKcGUK1Kjd/B3QWLMDSn5JdcFE6sbPO9f2JCgQ0Mahxt1cY6JGIDNzwJYKqV76BQ0XQdoI08WXWiffCr9MBzsf6cRJRV9akYszzsMsmeOkuMvV/zzvwBOBmhgOAuFr6Ft9YmHO3uKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g3NEW2b0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBRrNF009570
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 18:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7K3dz0RHRwog01/5OhJi5jfcUQuZLwHGDzYJ92Dzlow=; b=g3NEW2b0bFIfBcyC
	mGcLZ0xUBLf4+Da1X7MTnb1+BsglquiOBXcG48LA4YA6Ba24qIhbGyencYdunnOi
	K7U5QQgmxAdoHBIiUgLulYL9llvhfB+bvh3OMSBcbCwIKFKXaZ32FU6TUGk1YBKk
	3+PH0VpOlw+gnBDBI3GhFnHZ5yOmkwY+3CXgcrrXoFUu1eimTaw2yorYCU3XJIqb
	mfDax1Giklbr/xjd2VWGYp5M0S/RExWybMKoAJPfYCVmVb4nmx2j7fksY5NU7JRg
	d/DT4r28f4D7wXCVcVgTbffWMuy9pKpJWUWD+S5Qb0DcK504eOoUmqqKBceONBKT
	tP+isA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b47jyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 18:02:42 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b26e33ae9d5so208818a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 11:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751047362; x=1751652162;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7K3dz0RHRwog01/5OhJi5jfcUQuZLwHGDzYJ92Dzlow=;
        b=poO16psVhpQCVeHZJvUs4MRzJO1AuXN5rhh+ntjh1FmW1wVb4BaDtAniSNNECa3jBc
         Rj93EIXWTKdok+od2wMDBMhpY0hB13JY6C5wByjpO7fdZjQYcoHbATi5/s6lhs0KuwqQ
         ycf1vPtNquUZxtEa6Tv6JtLAKFMYkKoWwyW2S2jsVOtPU3bSEx0euYIdTxuR1xaDLAmX
         W7/3YE4ab9CJvrEe7ZSjMQX/4FgyfaGQsokMvm5zu0HCktTgCfv7o+TJzXEoqVxpCxcD
         zR4+BtfuH/MVU9UBQQeWhLXukF4CssoSBj6QxvPXgRG8s6UIEzxEWry7rBWgzr+/wtCR
         vj3g==
X-Gm-Message-State: AOJu0YyhUBoRw28sWYcGR9yOSX4izcMCvGj/7yH0wHtjvn4bnE908lLY
	fLNex2IY4oyrBuRzU26c2zQ78xioeW93Ce8AwNaGQ609yoEznh7zfitSDHiBaVDeuWVMB8qaTgF
	bbY8gXj3NU4VmdnuoLjwTvsa22ZFTWcaFzZie16mMQS5bmQwdo6RwN1y3ssKVDJcPHjGEhQ==
X-Gm-Gg: ASbGncuSLv8UltTVvNVr1YOQWaPVDSTudlWFaHxJ1ICiHlq2K7ifRoqvJhtPaXrPpAN
	Cw0S9h50cdngTE0Z3UYLL+ElEOyVUNfvQ9E/+bFxD5U/qHcnY7zYYrEkwHYbSjriNUkNi+oaOgs
	YdNr2bYOF57Fu4u2749lqsmX553RysZO9BftnyemvAWl2Qa+1Ikm60nFkvdKdYWlyU+G0WgmM8h
	7XL0c/ev8D9rZ91/MJvxmXZJ13+1sBeYLP4CxzTYF5ee8eUHdF2u5JqIUEiWLh+k0v0wwFLHMLd
	OWD1HeRThWZ/tE0Kgl71/GCaf84HMZOID+RMlD8c1ysjBriI5iQDTsaEyxGkrZtOaqaMVRJZlp0
	nYXL/0Cs0eZ0oB4w=
X-Received: by 2002:a17:90b:3d87:b0:311:9e59:7aba with SMTP id 98e67ed59e1d1-318c8ecd027mr6489710a91.2.1751047361901;
        Fri, 27 Jun 2025 11:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4o+Zl6QsXsdfBN7hrGiRGlLA6WRZLfmh7CC7eb/MtvMgcOsqRL+ouKIiVZVN9U4e8XHCtuQ==
X-Received: by 2002:a17:90b:3d87:b0:311:9e59:7aba with SMTP id 98e67ed59e1d1-318c8ecd027mr6489669a91.2.1751047361456;
        Fri, 27 Jun 2025 11:02:41 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5427099sm7491870a91.29.2025.06.27.11.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 11:02:41 -0700 (PDT)
Message-ID: <9c4be921-930d-4be3-b231-f7a45908b774@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 11:02:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: fix timeout while waiting for
 regulatory update during interface creation
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kang Yang <kang.yang@oss.qualcomm.com>
References: <20250626-fix_timeout_during_interface_creation-v1-1-90a7fdc222d4@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250626-fix_timeout_during_interface_creation-v1-1-90a7fdc222d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE0NSBTYWx0ZWRfXx9r+6MlZRcoS
 kirvbxJzHqMaCOptbxnM961A/RWyRULZ1rnDwpxH+76McwmKahulv+SWUXa49RzsPccVdAKv8HF
 FYYEUTSkFKSwabxQjZwt8E/hY0pzNibYjEl0IBpaLFHGCUqxcrsYAVRMetwjTJr7QLt4bMzBkp7
 rqPYNJaIRjUjKW/8vyv/3F+h+L16ScMA6wOCmAaT6r99fQmTbymnGw4zGnRlPmEbOK6VE7bRyoW
 pO6Ag7tg/80x02cCbGXGx/kDDJrVDB6CfGJtmZ+Hw69PkeZOGga5x4SlD38LT2YuWQjLo/ETLjV
 HOrHwgJLRY19cH6RJaAoivEPvIaZxLHV1V8+FafyKWn1MZrHfpmTxYtdDCp2mS3sQkrrb9z9FWt
 McuKG48ynLnk7T+iS5OqZBOAA6S4SpAHZqUSfIAuDm0N5ai9dk4p9qxTIY933Awtr5OnFnJz
X-Proofpoint-ORIG-GUID: BSIaFTgA8QMXPktUC1fAFmh5SUEC9V1v
X-Proofpoint-GUID: BSIaFTgA8QMXPktUC1fAFmh5SUEC9V1v
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685edcc2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Cu1Hzb5Yk4M5GyBUqqUA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=702 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270145

FYI this should have been tagged for -next instead of -current since the patch
being fixed is only in -next

I'm in the process of picking this up now

/jeff

