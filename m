Return-Path: <linux-wireless+bounces-24353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F91AE476A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A534402FF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E3526D4C6;
	Mon, 23 Jun 2025 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FPQiobkr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514B26773C
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690125; cv=none; b=bL2BU9HyXtn+tTBMB5sNBTttHF7yQbHuEPls8CTmvl7lkrPlWr+SYC+IYxdh8+EH1GtvGsFOA7bDW6gg/R6GAXzSS75oC2/oW/CGFF/lo8T41R5tHeWiM175R1+NyDjXPFlBVw01ul5evXgYHNpfxw/yANLJIrUKwI5yXVvcN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690125; c=relaxed/simple;
	bh=GYZi7Fktio8LhvqtzF6n0fxITCW+8BTsmORDJXtqx2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nEfP93kpt6qImtZLVLK1bXOPFIVRBzvaG2NLusSs+81INWsCAz6Xg8Vs2oT0zTMHdTes9sgxYEiiDTnCSzoW5QaBy72ACbQO2sRE9neOmzBgkpKlKV87IcXdbSSPBRPNqge8qQ62e9UlS0fjmpwgAColkQoqsz37Rb4Df6OnwF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FPQiobkr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8uck6008761
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eeN6dbR7WLq/Y8XjMlHe0lEdqr+IJWA4DpQ54P3BxqQ=; b=FPQiobkrfKDumZJA
	WOp2SOVlkCa1Cxy4Ex+qJdTveNvL6XqDQ0jPRfDeeM6zIEzVCafFvdug03CsRh0g
	LO87lm6xjWrQVBOnRlwhJWtnzjOX9Pcq6QHCFxNPdecHr5ipPpRFBPiLBdmxy5vL
	OJt05Vc8XJStkMGcaTkfvSzSI8IzJew9+MWbnQwSpKTJBLIneDYzxZCvnmP3yjTj
	YvIhAyRoPEMrZo1pvnnc9lU3m0keFPumloIKCW//N3MBl/XmZvDxlAGhRVaSzcAn
	NzTcDT/MmG0Z39KipEu6rAQ11g1lqwxjku2zhbbzwP5NhUM3IiicVgm0sOcxIZ2O
	/XOmZw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcmjn14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748f13ef248so3457364b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690122; x=1751294922;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeN6dbR7WLq/Y8XjMlHe0lEdqr+IJWA4DpQ54P3BxqQ=;
        b=VX0vT1m9jiiyphKHDjxA0XPrqKcmKueCee8MH4b9Zh25PxhFXA2Qyavy8fhEJWJMJg
         9XVRjLEWJ+iV65KVtFJ9oWr/HJezckEFy24cnajSKVPImAVTMCaiayH/eQFFyHJPCPbK
         AOSKMma+8yb6xRpy1GQ2LvhCPRdt1AjwwYNkMPTTmqxOSxXZRkD/hVt0RC7tvzoi5Ig5
         wTLjM5bcsAi2Qf3PIMq2kiigd0nHsE0v6ggPTn4fq0Amphi92wQHUmHOz3TWW0SHfGzL
         r9mR5OhHPIuYBUfKDOrFI1GRNeQHglG/5t6/c/UTBheJV8zurbCl8IOFvPGUmjCvrC/y
         JAlw==
X-Gm-Message-State: AOJu0Ywhbr1aiktgwCxGIVOrzALsfFfWvSqIGecm31drvlpHC+fOx08K
	bG5svdg6BU+Lq8/8+rStuQL8mRdQPSdycHZA3GwL2mEcBOgRGseuCI7lzuEwNCK5EGEE/Z76AGL
	nIEjD6OxtRbV5Gj0dgNhtHdOlDfr5kMGWVOpQ24Dyl+MgjvloFjTpzN043TFsEZ5nL6HY5ivlZt
	crlw==
X-Gm-Gg: ASbGnctWAzUtiLtG49uVWgp27xOgp+V/e9fzjWnACF2qP8/EjhStk3cSull+ULUnJvJ
	8YJBPfmYFZO6XWy0G7eu4awzf/9b4ApGZN91X439NU9rNfYpj+pDkm4Ro63j49eHt4hpQ5QrUmE
	hDL7dEfxQ6I5eOj5LsKF5SVIiKLQEKYvURTyX2sL+IqtEYhUmcdbIMFJsuLcIhNZxGcPnleztbS
	z7be5WtBSjxaVAWPAkpOTa4iUfqrtCGysAb+lpvvo+I2khXv8SSu1/XvkAzgSjMTUUXlzM1PK31
	Ri5HfXUx6npc529LFdp6FB9HrkQoc+AdJapuGSoFISdgPmjQ2Vcc4aCzM3E=
X-Received: by 2002:a05:6a00:b45:b0:749:8c3:873e with SMTP id d2e1a72fcca58-7490d7b04camr21575014b3a.24.1750690122099;
        Mon, 23 Jun 2025 07:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfnVhqUnLt4byb8wRkprQr5LEHe+XwRtowo9JdW3xu0OCncYW4Es9uCwFTZgxmEkzD69xseg==
X-Received: by 2002:a05:6a00:b45:b0:749:8c3:873e with SMTP id d2e1a72fcca58-7490d7b04camr21574988b3a.24.1750690121656;
        Mon, 23 Jun 2025 07:48:41 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:41 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250507194832.2501668-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250507194832.2501668-1-rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-pending v2 0/2] Add split-phy scan support in
 single wiphy
Message-Id: <175069012091.3758471.9334138851766473915.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: dJ6pKOSQxaboqnf5nys_36F3PP23Fab8
X-Proofpoint-ORIG-GUID: dJ6pKOSQxaboqnf5nys_36F3PP23Fab8
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=6859694b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=FXeA3Vo7u9djW6XytVAA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfX6VQbIjzNyY6S
 x7b6QJ8UpjbuL77G4DFitA7J6irOf8b21knbDddp2b2VM2UY5wJdfAg8eKd8uzdqKL+p3fGB8Rf
 GMfgVAjbwKhPIm5pzGF40EKTuwpV1RJyyg3xv6f+6fncisNkrnUEVbFPpC91LtL8xyofRbQdMA6
 3bCw8jMsImCXtNm/FzaB6a6bmLib9OZNPmkqnuteRwKaAdzRxY2x9ztqRVxR6rSbGQS89eqiKDB
 74IC9YUXR1DEy/oXDf3NDH4WJa/qZ5sqTok4eTZkslW1PqpKtYeIbPF+qoJAHD4kAfIdZt5rfwK
 gfshXFV4nX7LwxqMIxP4zpkyrz+me1pjIiptoTn2eCvKRJ3p6HeG+dF3aSvGFJiBNGoWyba6hPS
 /OOnZJBvIBf/PS2SIh07sQhs8uSseKzL0NcL7znW+JJHiq9jbbxaNz8VUQe+S3l6e/yXUeez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230088


On Thu, 08 May 2025 01:18:30 +0530, Rameshkumar Sundaram wrote:
> When two split-phy devices having supported frequency range in same band
> (as mentioned below) are combined into an ath12k HW group, they will be
> part of same wiphy and hence the channel list (wiphy->bands[]) will be
> common for all of the radios (ar).
> 
> 1 - 2.4 GHz + 5 GHz Low band
> 2 - 5 GHz High band + 6 GHz
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Prepare ahvif scan link for parallel scan
      commit: 14c7d7eac1bfc29917acedb894e09dae6c00a014
[2/2] wifi: ath12k: Split scan request for split band device
      commit: feed05f1526e81677f508b026fd2d66d178f65f8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


