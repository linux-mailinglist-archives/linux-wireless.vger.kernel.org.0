Return-Path: <linux-wireless+bounces-30752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EBCD19F27
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 16:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33E843002D19
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C7392B85;
	Tue, 13 Jan 2026 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LZ7uPLtY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KxfXeNkI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B4392C36
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318172; cv=none; b=Eeh8TpvmI2vKLRXBk8f9D1PZUnQSMF5EvCMGP8wCNDVKjlSCjaUXt9++JX48WPsStGKTf1e2tGe6McQlY5vdDUKn9vUzZrQS3I6OYsIaoxUOQ9MrSYq0x30470BGMry73d0TlkHajVN6DjGS0P1BjGwDXwSwvdHLRA38EdAbUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318172; c=relaxed/simple;
	bh=EzHd0t4TX1lAvjJGZnFFy7X19PNbFzrdehxRCFDNG14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QmBc0sMALlirFY0qwEvF0qF8PLw28ZDHS362TmsGSfPvCueq0FQjJaMDEm6nUhBFlS/jnzD4miv6YMFeNGKqzzYz2CML45BzmPZFSBauc36QQvn7nKfft10cf7qXqNysG39y2eZ/rWzII2Fq904MGChdEvYO7uTFylN5uoNuepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LZ7uPLtY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KxfXeNkI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DEpuBh3301643
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tUL0yqDwzJToWehueELfVYVdUh4bbVBhzmAExFw29FM=; b=LZ7uPLtYuzW36/mJ
	ARITQAuNilfAPg5qx3z3Jl7yGcrT7G1pl+ZC7pGGbs+TE4dVpXss99hfUw8g2p5W
	vVywFcRpzhKrXVamtdIimiVHEawNFWhsXTutDwmRhgfblHLVTnfzGhDlGdHsplFl
	JtKSydaw/2irTEens+ozNvewqw0/PL3WpvSVGtUbVBZErjZSeP2z1xb+FP2YwMDW
	fnFpSyWjLuFGTKeGp3CbIiUMgWk4uvGv8pMQLbI1iAx8syv+FMcJ/3LQFM30iH8w
	t84FJdFDC7RpD86Zbyvvv+xJ+RBd6UlarlB6IUEVOW+Fw5bBClJxjw9rlgAgczLM
	eTy59A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6jmba6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:30 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1219f27037fso36779202c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768318169; x=1768922969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUL0yqDwzJToWehueELfVYVdUh4bbVBhzmAExFw29FM=;
        b=KxfXeNkIRGo8qEmRwm4QLY4BeXlRemCgqCdq+p4xt67vrc1vIko2/iJdFbQQ5pA0Wt
         dNJF8pX/DaN196yFqSwrkZaGwcE+rp6sq8tdgN42UYVvUai7fmsm3KJZpuLmGWK4rAaC
         y2U4zOalZpSWA44Ekutt03SsiQwR7um92xhZf5Dfw2KkRxdenuDn5ROoVzsJTs9tEhoA
         hX8xqOhiK7Xcfe3h5IbMJPdtAYL1N+dCb0mKzrX3G0rYgFMwcpLvA9vpLehhxuUT83ER
         UlxCj+N9DIaw69DOQj9q4lOy+7bOKj247XXgmu8gipvbIMyuhGzdZUwkpQ29QmjutyNm
         idbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318169; x=1768922969;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tUL0yqDwzJToWehueELfVYVdUh4bbVBhzmAExFw29FM=;
        b=YPZmh5wxxHxZjdN7Uk3SD+Phgj040tollEZiQNpwSNLt4t4IXSZhufJb33W1gVJyUU
         sOly60cNR6yNUds5RpUtuPgTmxvkiuy1cUA8aB+t01NJe13q3cuNK67V9PDLzzQpm0HY
         46H4/vqyLZQ24qCUCPY/78tYMhxyBbxeqWtgu7sINRzyvWed9WhkINJhSr9fIFxvePdK
         8jpbzASk7g2CuYc9kZAOUU2Z3M74lSs+a1j91gOTMCjZBvsbL88YH/CDNIzFYvwN7miT
         MXcK/ODO2fRUnJlG6vSm4TObtWzqGVLeUYL8p45+qNo7JNQhXOind15eqvSuzt/Yxfps
         2TyQ==
X-Gm-Message-State: AOJu0Yw4O75TxSl9iGj2frdH0hPwOsBmmrbjB7ZdDthc+KvjDra4bC7w
	UeZ0LHRyXRPwb3TXLGaZoKwzziWQ1lWfbnjcVk2BfmrLHJbTqDV1v58AsOi5Q4lV5Oonva4RFdR
	KmvMonFsiG2mi/zHef2TJdak+bpMVCnKbzY6sgkQps/Ie/EypnZmIAbRWKu7GLp5G51Ec2NTOlb
	BA4Q==
X-Gm-Gg: AY/fxX6+w4eKlhpG0Wt9XrreVfN2oTExp8DQNX+ceyW52wWaCOg537E2KRiag3ySu9g
	tlVBHcBRpBzfbMZf3fl5zc+hiZWGcy3Zy6nEzjZKNfuxf0wg6NF/sHVhjYrlFEBpeRMKu3u3ylD
	NU0XXTEzDKveUJV3HnvSbhmbWIwesgt/WrDwqOxN/bxevldMZDx+mILK55nBsA9WpTiVxPbVr3R
	Wi/BGKmYOhDn8sMkAD+2giXlqtC/SiodZt6u4XW5jrItnq9sQVA97j6spE0uEMDU1dcpzniOnK2
	z3BsoFKaDJvOfWukpIkqRUJ1C4d09pubA4v/Ga6JS/8FKMqTNTbva0RJtymMzcsBEeNb07RvMHq
	TOfbNrgeRPSI3VwetD/sbWvQ2E+pJbkxe1zXm9PAxSiGB4ZLnx7bXoNJ8QY8LXI0E
X-Received: by 2002:a05:7022:5e05:b0:119:e56b:c73d with SMTP id a92af1059eb24-121f8ab9cb9mr15686821c88.2.1768318169052;
        Tue, 13 Jan 2026 07:29:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGywGTzJ3xRI4VOhiiPcaXXwGSVSM8e4aHZ5XPdS5IBF8/W7pj6krLdbOQoORp/mYe92uphHw==
X-Received: by 2002:a05:7022:5e05:b0:119:e56b:c73d with SMTP id a92af1059eb24-121f8ab9cb9mr15686791c88.2.1768318168467;
        Tue, 13 Jan 2026 07:29:28 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d76aasm16858049eec.33.2026.01.13.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:29:27 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Yingying Tang <yingying.tang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, yintang@qti.qualcomm.com
In-Reply-To: <20260113054636.2620035-1-yingying.tang@oss.qualcomm.com>
References: <20260113054636.2620035-1-yingying.tang@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: Fix wrong P2P device link id
 issue
Message-Id: <176831816777.3453943.3207053910336933657.b4-ty@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 07:29:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: uVRGCjJ_PiyeKX3fkhRlBL-TanGRIIag
X-Authority-Analysis: v=2.4 cv=SK1PlevH c=1 sm=1 tr=0 ts=696664da cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2Mo8NHjUZIvW9bQ8WxoA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: uVRGCjJ_PiyeKX3fkhRlBL-TanGRIIag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyOSBTYWx0ZWRfXyjArHMaFFcc1
 TwD92hqyVaFK3viFfjdcUQPjLart8yFxN9e6CQI5grMe9ob+6wSK/20HOxt2rrKS/3RURvtbO7d
 Ybb5ekaYokuFFw6qs469X561LqO+/v71hdMfNV+obmEjT4tYLTyHDcoTU4PzfMBROM+zstH9vii
 jfSZErtiL40SGz0tdpAMmtnSfLWK62toADpuLi1ptEtHm5AeA404q2eiV9968w+QfeHIISNzpgI
 J33bc0NjOgq+PpVLpnoHcEYaDCHJKqPDFmrMJy3O6tsL2iHRBeNPFNINymGBq0pTamtgpNpdKVE
 fL9OxmNsyuiL8Ong1Jw426mt8okvu4TW3lw2erdslRtDxvKefR+UWVxlAnSCXZoZVhfJjqPWR55
 hoMmzDknkEcqYCNoIszlKr7wOm+Y0CFsdhAGoNQIKOuAtdYTEMEhRrBDfS81u84eu2bbjrHrPc+
 GOHMCAglMB97JB8WtzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130129


On Tue, 13 Jan 2026 13:46:36 +0800, Yingying Tang wrote:
> Wrong P2P device link id value of 0 was introduced in ath12k_mac_op_tx() by [1].
> 
> During the P2P negotiation process, there is only one scan vdev with link ID 15.
> Currently, the device link ID is incorrectly set to 0 in ath12k_mac_op_tx()
> during the P2P negotiation process, which leads to TX failures.
> 
> Set the correct P2P device link ID to 15 to fix the TX failure issue.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix wrong P2P device link id issue
      commit: 31707572108da55a005e7fed32cc3869c16b7c16

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


