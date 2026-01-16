Return-Path: <linux-wireless+bounces-30881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AB4D2998A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F8DD306A0C5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200B0330640;
	Fri, 16 Jan 2026 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GEOKre9d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dhdhb1QS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82103321DE
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526819; cv=none; b=JQUoDbe2IVcvfLSRoc7m7pGa4RIoDDUZ00ZXjDyVmRei3ld4yDBs/gaFH9BnSss96/zgioy5xWwLIAqBX0wq6KaZ41r40ph0EaRWIK7LQZ6YdXPIerQtzLz5/iMeWGtwb3h1zqLTn63CCUaJKdvJKK9qeHTFIFuNF4vkDrPsUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526819; c=relaxed/simple;
	bh=jFEv4r2MshB6wePmIpYJFsvQK8DMRqAxq3m5JyCqHXI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N1cAbypLuDlGbUg/305s6IDA8e42FZbdO/Ya5iM1Hxy94YvjOuMkvM061rHgba0OsMVBym6d/C59AXyKVCtJcZztgNepHWrNlGfGD7ATVvbVadX4L6ofGItC4rPb//ddhO0iktUdJW4FeG/93jd3acO6HGsKSKW5cNlBgJOk+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GEOKre9d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dhdhb1QS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMbdkk3596641
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PBgxiuAXPzWcnKnXjmT6ZLSdskE4wPWQ3nQiKjVtdEA=; b=GEOKre9dEnjiBaCS
	0orl3WNYbm98jeOUDJR0D0F35xPk+Gz+tAFHWqPkRess5eL0PSZOk5n3OaxHclO5
	FxWKZ8oDE0bvt6SG61nCjtAZCUIoxKIcbWiM2ZmoZt6dCGyfXB4OBzSSIzKp7oH2
	/7bM4l2i5YKVT5222vH71UZ9ALuG744+XddTKAiBjE3T8KiDlDVUfoutmzn0LhCd
	/Rm8mv8TBYONtALZwv36/5zUwS8gQA1Gw+XYZMGg4tVmXDQUSbJxvTy3eJh0Zqra
	oh9jtTwCOZ3rlwF80kST5JOUVSBUnR6EIcqrJlxOhLumjh5gDATL8uhaV9v3j7sh
	tLkZug==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96rrb6g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:49 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1233893db9fso5558889c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526809; x=1769131609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBgxiuAXPzWcnKnXjmT6ZLSdskE4wPWQ3nQiKjVtdEA=;
        b=Dhdhb1QSpWAeH4VORuKR8cfMsQO0JNOctyLRmDZBfcOzbPZIinG3jE1H7Aqvp/3rnc
         +Qk/Vb2v4fjYeq0ArYKyrMrhhoV7y+q6+RCoY5U+dGI/lfaedcC6sz0ZCtzp2Ptsio6i
         XArNI5Bu45EJsr4sbUUyiKgar4+oK1PBeYx2k94bJVkkBXzZdQ+iim8cpSbwXOXkP/M4
         E0bWz2Q3tMyIdeu/JMvkXF1pNIEP3OoHTuDwx/B9oLt2xryAdV9JVc73cjK0JE3leVE+
         ij60XrNDThAHmFEcuXZeQF2/dDo9LVqO8O+hCvtSVboqIKXp6ltXqe/pumPZiYgrOxRr
         2fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526809; x=1769131609;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PBgxiuAXPzWcnKnXjmT6ZLSdskE4wPWQ3nQiKjVtdEA=;
        b=Wn0W2eYWqOcTkOiLknjQcCgUIvErU1miVLI/xEugYUSMKz7vDhknth157Qa0SbAJc0
         1ug6HXHflD1tyBvrGGz9zRhgpW3FGrN7xRurOzU4XpLlfyWZs8Sy1BVj7tkuDZAbeoqd
         LuWGwJWaAbuujW8NgM2Ukab9tnsvWm9cTTzorzePaxqjPyq3vSS7U12yBHOFu1D7whAu
         DLOEL1BZXg4CLUjkLu+mnWj0PhgXYn9kKGWOIbVrfXdiyaC8sthBwJrL+uLEYIwQoI+m
         MwmaX0EnjQeKOJejSeB+OCIR6RaWorWb51TQyQJa/a2xmm1kCM2nRofxzRItMV/K9b/k
         y0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW20YefyC2RLOpT3Ot4LEhRoZnVmTfJ5WTeT0IXqaNHLmtCyP+9FB0C93sQhiXvEo1LZn5159USXVg7979/VA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDcDYQVdPsbi96+gWUEiPQ1UDm9aVKDLCZV2NntmfndafrHSk
	kPEO+WPTtUQbl8L2qZgY6u0MFj3rj/bqKYSxUTqxgbXRNgr96khp7HFyTawvufyu1WjHFrfMmA4
	Rxpxo8CxiIKZuN/VKxk5q+3CQdUrpxpWCEDpxBdxnvM8QF7pPvtgwvGlTbzQnt/oYh0mkeBuMUW
	OcYQ==
X-Gm-Gg: AY/fxX7CUq/dZPogsF1s2A2ylc40CmfoaUvZZczOKGtvVqZjYndevRMkDvO4W4uoFyD
	u4JUTRLAbA2oPJNdT1w742QaPNmtTR9ZwynNmbf/tkre7YAvRoKaua1MeIFH2HG4GyCHkeK4cjM
	LIsEZ79d6dRCC2GIhrYbejbln/oOLEzS81FOt2GjOQ6dqkxbB+uLTKjTnr3yeqPiZucwacgBq2a
	Hr9JErzvchzwUQM0FnbwbSZHoKwvSRPDpdrVfRIQ/PqH+P0gR0CjiPcONzv1SUlKwYUlCDu6I4b
	z+lAItdKP5KbF+lLRw2E+r/czbZGDeBwkw7bEi60jhbCctO5VaZVdrDpaZb1MYrE/fOTjUmEZmo
	dZvUeuqOHinsHcE/G3bjJdt4JFApwPFsMfl9w7FsHCXYmjZRyJWFIAR5Dlsof8JMQ
X-Received: by 2002:a05:7022:a82:b0:11e:f6ef:4988 with SMTP id a92af1059eb24-1244a768b4fmr1849082c88.36.1768526808738;
        Thu, 15 Jan 2026 17:26:48 -0800 (PST)
X-Received: by 2002:a05:7022:a82:b0:11e:f6ef:4988 with SMTP id a92af1059eb24-1244a768b4fmr1849068c88.36.1768526808276;
        Thu, 15 Jan 2026 17:26:48 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:47 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
In-Reply-To: <20251117020251.447692-1-rdunlap@infradead.org>
References: <20251117020251.447692-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ath9k-common: fix kernel-doc warnings in
 common-debug.h
Message-Id: <176852680775.1143034.16687864717347544330.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX/O9fsyiyqoYS
 sxyrJE43g0bpAVKy/+6EV0sVhvNJE4U7Sqj5FpuxLvfqwWvuoixpY2VlDuYVI8VIXZcLx5q1vul
 Aff2C3QgcMp9/5HXdJEaRFWxki3JpwS2rMiqBbQtH8sVh/9kqEAP+yUpy7MTR291JkarPA5WQvE
 uxVbyl3BDcJvfzi0xk9wQvXfpcGzkc/ys9b1HTs6TwvqQbLVuV2Vi6muzDZ2iueedwyUQiPnkqU
 X/rklAT94srOewV1UI9OljlCSC/qyRiPPWkqhOeeL9bb/ylPt4W9VOkGjoFWGtqAcxoBdBGMbK2
 5aPJ1aEww72O9JOr/sMw9BTaFruXBALz9ilXdQ+HOZD2QVPzmLHX8b3x3IpiJ3O9SDeeJzNHWfx
 YR6Yqw2TmZPMHGAx3moFSVccSwpvSqo1rQu5CIUEtqkJFuaHeQ93S7wKDppf0euiCeKjvzVQSl/
 5L/titVLcv3OqUXfwrA==
X-Proofpoint-ORIG-GUID: D_CATSdsPqoGlFFA71mTD569XgVj2mYx
X-Proofpoint-GUID: D_CATSdsPqoGlFFA71mTD569XgVj2mYx
X-Authority-Analysis: v=2.4 cv=TsTrRTXh c=1 sm=1 tr=0 ts=696993d9 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=S9M0uSDcFDzX38LZ9aUA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601160010


On Sun, 16 Nov 2025 18:02:50 -0800, Randy Dunlap wrote:
> Modify kernel-doc comments in common-debug.h to avoid warnings:
> 
> Warning: drivers/net/wireless/ath/ath9k/common-debug.h:21 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:23 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:26 bad line:
>   decryption process completed
> Warning: ../drivers/net/wireless/ath/ath9k/common-debug.h:28 bad line:
>   encountered an error
> 
> [...]

Applied, thanks!

[1/1] ath9k-common: fix kernel-doc warnings in common-debug.h
      commit: b9909c19965dc9e5a3a898fef09b437fcc3a9494

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


