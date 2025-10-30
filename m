Return-Path: <linux-wireless+bounces-28418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA423C227B7
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 22:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552C73A3437
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 21:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2230833556F;
	Thu, 30 Oct 2025 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZx8gCpE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ex9++8ty"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8F329E6F
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861464; cv=none; b=kSdqL19PjRIvOE4sEKBJyedXvr7OPRXbtVwrp2x30WwFg2gKTO8PeUCkM9WT8DJGmXd0EYxwychnx7hYN7cOpr1sv2shu3BA6St3aPEDp/XPDQObqjqhu6WJiXOYHSb4I+W2jCUz4EtD2t7IO9apo/Mjwyc2vojJBU4Soeeri6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861464; c=relaxed/simple;
	bh=Y/hd0P2KoVYcvE6ltfm/r0as00bOVGanViz8BtQE18k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WcrXJyxZOh+sJ5gdaoPs/OxFx86OSfzmTTR6or5pui2mW0geG6Ia6gDX9HpL3fgh9+vaMJeKVgX2HEevZZUTFF5yS8+JAh4ExY359S+kAcfa/1Ij+11x3Il4O6aWpskvRwT3B3I2R+sGH7z5RC7F9/vn3btC5BXSqUCCJ2H5ilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZx8gCpE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ex9++8ty; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UFHOE7102861
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4zVQx5WyeH2UAU5jT2Q0oIBeHwoSDCmZiyBcYaM+hFo=; b=AZx8gCpEbfkbjHtW
	31L37iGfRjbPiS1WnlvgqFB4J5+dKSnFprThKREFjtuHk0sSrYQ7c7AEF3Q3H6oJ
	5RDuWhDhMoJJSKXlIWvfkO3IF7vvxn+4NnyteevFNt8aPlU+tIWQzdYP+NPrl4Hp
	vUZrJoIUpe0c3xrkQnPr9sWH0+1mJ/M2fMRTd1oV02g/CRIOIHICrqQTXqBh6A9v
	0gFu8qzNTT5gw3x/jLJ73+WKPnsBxFOmEpdfqJVMMXh8NcAgELi2uj7gc0aNMI8u
	dJKOpAF7CoAs968EAyo0vtTo+1m/vP/rrqDK9ZBBHoxEdsj7H+pKfAlRbF/CDDAE
	Y1+WeQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdh3n8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2697410e7f9so36671735ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761861461; x=1762466261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zVQx5WyeH2UAU5jT2Q0oIBeHwoSDCmZiyBcYaM+hFo=;
        b=ex9++8tyQI5mvKzaZ42NpX00JivdKCSzYLrJeXfIJaUzn3HDo4EpKqG+QIGmAJtLQv
         4s18e2b3BXr8AX63aBBycqG9k6TbLkwBxK5/X1m3rLVsZWGjJ8W8z0GwLmhRIpUdzxhH
         hDveHI0AvOIYgt2Z8ExUw9K7yLQaQH6PGYKIRkrZ2PLFUB/SiOdVlEeLHELWM5su1P73
         ZUJsc7BjLCwIlQ9TceYWzokumgSip1lV4tMd2ZknuWyK8hUywF1jBnia6Q9lvs/8vTyJ
         sam4Zra7Td7E5/6neopeog2Pw9KLdggLpLArdLDsAGlC+BOd5bcxyEPOtCySmjaxGr+P
         Smow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861461; x=1762466261;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zVQx5WyeH2UAU5jT2Q0oIBeHwoSDCmZiyBcYaM+hFo=;
        b=vmEO4xZvmlwTQfSYviQP3iBefjiIjd73iDmnt+lhrPjF7EIW3wWfSLsnHJDsj5m95n
         wKs3dHOLqADX3bvEAU2o6ge8WYiIKIzkI80YVPG3ex2m8kfPB/+vL5YNtKnSlTZkWJHc
         v2fbPbpkwYvYY9x5cTuC7OjiNuKyaZlbn5h0Lrb5Ia4TdVcLk0nm0jI/HUzQDU1+1P1P
         e1AC1febqBV1N9ESy3c1R5G3wsDpW4YIVulKQSCsZcXe+oh71Tfn8F2SMXI2Kd8w+595
         tYOqUh2RncBsPsqgM5qNu2J4ucTLzPM7pN16DAK+lUMonYmS8bs1/L4/fJZZZQMHojk7
         v7pA==
X-Gm-Message-State: AOJu0YxMwkHonsmrQYffeT94ZrBd7TcpcSZidStqdRRNfNcCt/D+D06g
	Ktj0bJ7Vx9Nko5VjswauFxHs9bV/xXZX9HtPGoSra6lEUrLMbAlksYSYVp4GDGMSATaJGq7RUXr
	PPwDrEJsQCORy7IbxxAJQVGZYybcB0cp6R143QTw42jsCVx2iO66Cni1JkzS3skXCKML5yw==
X-Gm-Gg: ASbGnctByVrGxg1yzNA4e8Vqz7McB4/CAg3eCLPM0aqtUOCpqt1Uksbwv1WxJgey3fF
	8fyKBNqBho/NJX6oyHs7NWG2yIAufpjL1A0qKDe5DJgDt1u+Bceo2yAN48bDfYifrsR1zm5s/3m
	jPu6KYRJLh/NXWLYIqg9BXHdPyHYc61IhEbKyjTcmMzcgLlNyV/spo2wuZhiAlMc+PNoASBU6p8
	ojHvOeTQBftDAmOa7PiCMkEVOhGMKRgjtFJGvsdl6ExxSPqSdj85E1DYYkV8ZX3b/H9vSpC59ne
	UvOo0hDtYZcW1K+nffiQUmLo/UWyWBQboS1ZdZ33c6kHknq5LkchgHZTOl6wQY2P5ut8OuS+k2+
	BehFTIimHCg8ISoBA4hKLD/fbpT/dqDPRhWg=
X-Received: by 2002:a17:902:e84f:b0:27e:e77f:57f3 with SMTP id d9443c01a7336-2951a38ba2fmr15385745ad.14.1761861461358;
        Thu, 30 Oct 2025 14:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD73qzIAWPxOmMRVfoJk08Tp+r4nsv0hmco/JUKkLJEbj2CcT8aUy6zZiTi/ldv2k1xxnFtQ==
X-Received: by 2002:a17:902:e84f:b0:27e:e77f:57f3 with SMTP id d9443c01a7336-2951a38ba2fmr15385515ad.14.1761861460871;
        Thu, 30 Oct 2025 14:57:40 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm201868405ad.6.2025.10.30.14.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:57:40 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
In-Reply-To: <20251029-ath12k-fix-m3-reuse-v1-1-69225bacfc5d@oss.qualcomm.com>
References: <20251029-ath12k-fix-m3-reuse-v1-1-69225bacfc5d@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix reusing m3 memory
Message-Id: <176186146024.3489476.5551285791911221420.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 14:57:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE4NiBTYWx0ZWRfXyL818FIBVkeO
 n+bIjsHORT57rmdqRjBNuIWvGsYKvVcdUec0hAyH1/GP31Z5RiOcS7G1b33LZr7+2S8y0eR8zc+
 ebiSq99cqKRBpxXr+VRkcuovkCBVP3W6ne5VCKl5FElHeW8yewdn4Qj4RkNwOhRTdZbDDV+ggJx
 mDFdm/R+9h/mgQfjskq8e4JKwjbRZdZN0cqftLgP974K4bGHT07i+XcQkKhNGVjkXSbfM7JZWfa
 HaK5GsPKHaugqMxC2E8hj0jeXA0WcE6D57fpbstoUN63z1Ap1vUTY2FhPdqzxWSUOa4V70de5F8
 cApIp5dVH8lkyty+IPZ8GFU6uJuJlNZB96bXW5N5rONapEvUHUv659dSnCyugufkO2M/uIr1q6e
 /p2s5qodhinzeuTbfrYmZLEkKua0aQ==
X-Proofpoint-GUID: 4xLrUtYJBDfygpfnvPsoP9vZEulmharQ
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6903df55 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Y1qFtuX8SmuMirZhVQkA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 4xLrUtYJBDfygpfnvPsoP9vZEulmharQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300186


On Wed, 29 Oct 2025 10:07:14 +0800, Baochen Qiang wrote:
> During firmware recovery or suspend/resume, m3 memory could be reused if
> the size of the new m3 binary is equal to or less than that of the
> existing memory. There will be issues for the latter case, since
> m3_mem->size will be updated with a smaller value and this value is
> eventually used in the free path, where the original total size should be
> used instead.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix reusing m3 memory
      commit: 00575bb44b2c2aa53d0a768de2b80c9c1af0174d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


