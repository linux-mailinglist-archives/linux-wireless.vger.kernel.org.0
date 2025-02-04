Return-Path: <linux-wireless+bounces-18333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87719A2693B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 02:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE89164B97
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 01:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1527081A;
	Tue,  4 Feb 2025 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z74ujgkI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06625A629
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631617; cv=none; b=BEQG1ZSTMELnoz8hajehtsUmFlPbNHv6fUpaHN9xg21kG1DFBFA3vD2cejDbSWJhvIvgtq0LOAGPZ9YeJxOr7a7t/E6siPnZFdSHjle+azeXJxr/2L8zQrvkXleHyNF7dxm5BaJyspZsttgWk3YODXKHqimGUkv+PAiuCKjZADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631617; c=relaxed/simple;
	bh=X+f+xBZ5x7qaeHgObjDrFiESlq4mLFR+nbshgLgAE5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KmXd1Fx6v/6bI9+FP+2aOfLja1m5BVxJlNPWHgGvpUuqAG66S5qkZjJWKZT7nlObbBqEuoKtmjWbMHEGQorcB3OXiSm0Yc0Qk3EwqGbSUBn7d6i31UqegIbiv+vKJaJXOXBWXRYiEDNPmP/cTpSzq/RzmoXQPe6C9L86NyCyIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z74ujgkI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513E5YpY002395
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 01:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yT5/fcAE26okMeBX/EB7E9oL6/XaBT9SZ0JtHj1hDks=; b=Z74ujgkIJ1nofgbX
	JdhTBUlkFH8h30LQ7yeyQpeLIoLs9Q3QpxioAlBQkNEH1MvHDiVVU7S3BEjufWfc
	MD8Somtup+h+Y08PfdynIj+CKH7PKy646wMwR/jePf/Q+RoEBPudVLkZi9ZyBT6z
	R5Yoz6LibxK3sUuZ2bzGT5DDNDex62lBm9TV6P6DPjwU5k/ddNnNOTRqC/5KDMKI
	iygzNZsK2Z5m8QIv5+H+huu6vhqn7CvBwYEjbUhFYc3iKrVCAum/yQkP0m3myeJG
	RmRH500aOjZMNZX/BLVpG4wdA07MQtKvhMjtT9RewMG5wcTXysm66FveikHllQKV
	D/aN5w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jy8s9bqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 01:13:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21648ddd461so109230355ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 17:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738631613; x=1739236413;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yT5/fcAE26okMeBX/EB7E9oL6/XaBT9SZ0JtHj1hDks=;
        b=PlHXpmeqG9ttuXdWMKribxMLQ03Qy7kFSynPc+4a+bop9CXPA6zMw0SGNSuWJB75cO
         trKFNslk05CIAuzDHBvNchSMTeOipU+YJpFAsSh+ZJKZ3PmW4RUW5eRDgD+xzy+zukAM
         2ITbLGIP3PVdq6TYS/fJintqWkp+dGq3HplZ7h6A1MAay7YJQ1dQc9r+T7RZU4qH6nc6
         X+68Q+zPh+y9FkoGeyzie2JWxHyVGQweuKTLGYisXIL5fbzP3QoFgzyvsn/6PL8ZVaRB
         rcnpiMwghYEO9oFwbxFl5A79R8r50CpwHMNYdQ7Vvu0xcTikh4AzHlK9MOO/onQHkNp5
         HkTQ==
X-Gm-Message-State: AOJu0YyJm+k7BDbh02fWK7IgAktrKNFR2dBLPtvmdNSPTZikrCIjt4BH
	DNojKuIbICqbow4pswLuRQWnjUh8MtPPqnfY9TDabjAs/fsXsZz2hl7s4AHJhxtBO8uaH7ywQ3j
	aBWoJvt/S/FHW5Zs6i9oedCqvFWXebmSaiv0687YGhtuPB3GaOFajzdXTVjePkMMpLQ==
X-Gm-Gg: ASbGncvD4SVcMd7a6qnKBkRmCAseiH4dm8Z9C6bhA/IImZgFZ1Ayeds90cJPRa77Kp0
	JCsDfd2SCT2S1bxYALAh4eJte0RxDUIXSDTXnqToI9hHLBmnU+TCayIjL+ZxPbbWMEsrvP+UbLi
	OZG8PEyR8oJXZM8vw+gVtr8l04FROBgFsqp2KoUckvq1tqx9B2IQxD1lQuQmiKj1FqaJAgkYfvJ
	oxL9ZRuCskGMJrscN+hPtju/Ze0RRZCt4p3qsQHH+LlHMMpi3SYVv2f/cLMQpULIgGX4gJ8CicW
	AkSbeQj0h1D/NvCO6nRfCEovkB7hgsHXlFPS+VGHWA==
X-Received: by 2002:a17:902:c40f:b0:216:281f:820d with SMTP id d9443c01a7336-21eddbf3371mr261750595ad.11.1738631613341;
        Mon, 03 Feb 2025 17:13:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsmFp4dHUN9/ea/YQYopKp1NpfKyinYyi+gwqb6hy52ez2R0RAtdQ+Fo6xTNuvyemLyBbDzQ==
X-Received: by 2002:a17:902:c40f:b0:216:281f:820d with SMTP id d9443c01a7336-21eddbf3371mr261750225ad.11.1738631612923;
        Mon, 03 Feb 2025 17:13:32 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f8522sm84069685ad.89.2025.02.03.17.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 17:13:32 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Lingbo Kong <quic_lingbok@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250113071758.19589-1-quic_lingbok@quicinc.com>
References: <20250113071758.19589-1-quic_lingbok@quicinc.com>
Subject: Re: [PATCH v4 0/3] wifi: ath12k: Support dump PDEV transmit and
 receive rate HTT stats
Message-Id: <173863161230.4031998.5854006886193521367.b4-ty@oss.qualcomm.com>
Date: Mon, 03 Feb 2025 17:13:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: xtTjfse-TDCdHu3F3LlOQ5mIJWZimdgM
X-Proofpoint-ORIG-GUID: xtTjfse-TDCdHu3F3LlOQ5mIJWZimdgM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_01,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=686 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502040008


On Mon, 13 Jan 2025 15:17:55 +0800, Lingbo Kong wrote:
> Support to dump PDEV transmit rate stats through HTT debugfs stats type 9.
> Support to dump PDEV receive rate stats through HTT debugfs stats type 10.
> Support to dump additional PDEV receive rate stats through HTT debugfs stats type 30.
> 
> v4:
> 1.used tab(s) to align the = to match the existing code
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: Dump PDEV transmit rate HTT stats
      commit: ba42b22aa336c3ea0bd6f9c606f70a35a278bd61
[2/3] wifi: ath12k: Dump PDEV receive rate HTT stats
      commit: a24cd7583003824f8bd0034c02987e5da26088f6
[3/3] wifi: ath12k: Dump additional PDEV receive rate HTT stats
      commit: 7a3e8eec8d183d7b293bfb69caab9f213e0a6bbd

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


