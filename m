Return-Path: <linux-wireless+bounces-19230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A0DA3E6C7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 22:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132CF3BA2CD
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 21:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC91D2641C2;
	Thu, 20 Feb 2025 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ixcsmn9t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F820CCCA
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087663; cv=none; b=JA0wN3V+qjt+OJb2WO2yL/jtmZYWlCpjoEW+gi8oGc5tGunlLsuitE5KGXynt5qlZcHPM5o7FTGqJvlIVyTKXcj/+lhN+ZVg/u5jgovi8GEca6h5C+ta/jCtwH3y0ihzS69vDkn+2ZARYHinwANInn/MoIFM6oDzuSqDPTIYqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087663; c=relaxed/simple;
	bh=qlPKGTRLbcEupI3qxYmLW0lxbRCSwL2+qubKggmS32g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gz9E34E91cV05H4uAo6UFq34dyUm8ysx+qh0mYI0BXTEVQlvTaQ093g946lKxhMcq/KgCSVwH4eOFPzr3k+OWahKVMoodHyv4vCFuBqVCE5UVeJ3crN6XH0qt24z/EA0/HXDEjzweTxm2g/6rADFGgNyS5NwsMPMnHnKMkSZYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ixcsmn9t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KAkFP5011936
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 21:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sXm8CbCeOCA2MHGIdHbWnAtzNNGJ+p2GLkT+nZHKxRY=; b=Ixcsmn9tcJp2Dhim
	nFanieDkrWfO+w9H4Z2GHGhf5PHydblsU17TaCOpuUd+7CjY8v5fvZvlHVPnKDTs
	UCaaOWnFnBVroRJrlDBBQNulAG66rgsXIlJUQJrXJYi+rnS9YhLiwHqgsU6FNMfS
	ybcRlodg/LeTH5vERUSLp9wn53he8uxTnqlQYOAKsWNQS/d6zOI2qAFHh/vHQPSk
	Nphvie/FmvcUjXYJDGe+TIi/4YNUizto+S3YsARoEVyjD0EW+mGhgNBvsg64lsHv
	RDj/zjdTPQ6d7XijfwV/TsKb8US0uXXeuUqDypBfIK0J3g7FgbJdP4NFWgKVhSdY
	dNDrnw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44x2xb9pct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 21:41:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220c86e46ebso25271695ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087660; x=1740692460;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXm8CbCeOCA2MHGIdHbWnAtzNNGJ+p2GLkT+nZHKxRY=;
        b=l9X1sIZEt5d7hN82ZxCvVTb9z83IdO/p4X0jZRv4I5j1HxWyHeCC1p1AR6x4SdKMWf
         7qFOWkHz68lW1kS6TYzGE2xCcP/2db3E5UkKI7qoO5RplQ3FIPtAriDxd8lPCw+g0AGo
         D/ZXKdOWnqyBj46zm+Jz3KxF07x4J36rWLyreKnXTnP4R6TrhMJbHX/ql3PDrk7QUxkK
         LqnrnJTg4A1XlRm5+n8ek+2K1sOBj4NsBsd7C8Qq2PkuE81mB8KU5blRmMjz3xDNSTZ1
         VZCy2Nu0HPlgWeCVvoce0LUvMVBQ4901c8t6rtJXsjn1ZeqMbXllzxCjzd5IZVpNPJv1
         uVNA==
X-Gm-Message-State: AOJu0Ywk055hG0xHEXBZXBB3+pvq0C0uLTUtHrHnJJN6KidYNAEIVShF
	2TXkLfoagwYFMADZYCwo2Z8Ry6izYx1rXbt/fXr9FmWYvrHIO9duAQ65H9fD59PBmqJUOoc8WRX
	Uin3rYuuSxDpr6W04Ojos3oQLPlX4nO4YLnutq33maeDd0ne3MeUNDdEiHr7gPBpMEwIwrElQaQ
	==
X-Gm-Gg: ASbGnctrPUksoVO69zcsFBO9b4trhh7ZL/7QSYhmlNGr8gNBd+D3LV70pISyB0sHCZS
	e3SE4+VLcobPz0SsZ32h3/dsBEaPF5wE4/O/iendYu40QNe4gbMsF09wVQPwfF4UrpdAtVh8yL1
	ZFdZ7kndvY70+KzrrWFRGLuw0llvAP9pdb/MuYLzrBi1OTrr2g4CozGjuuR4+B+kdq9BgaMfrzp
	7QaYLq4ycckBo59CcUNdmovOE7KVME+D7gQmKJ9kUJIE242TkgMqvZML9Ia5e31JD2L+4VG7JBm
	PgVwrX7IPJe20tiODoh4WyJM2ZW93lLYG5Wxjtgorw==
X-Received: by 2002:a17:902:f60a:b0:21f:752f:f2b1 with SMTP id d9443c01a7336-221a1102975mr4455315ad.30.1740087660134;
        Thu, 20 Feb 2025 13:41:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6nbFDufrU5Thv1T/a7ckrxD6ab/wasTHLWyWamR+AS/BVxp/tYhweWgIUOY3IIHFAixrEtw==
X-Received: by 2002:a17:902:f60a:b0:21f:752f:f2b1 with SMTP id d9443c01a7336-221a1102975mr4455045ad.30.1740087659685;
        Thu, 20 Feb 2025 13:40:59 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545cf8fsm125252215ad.152.2025.02.20.13.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:40:59 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250219053640.223734-1-praneesh.p@oss.qualcomm.com>
References: <20250219053640.223734-1-praneesh.p@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: ath12k: remove redundant declaration of
 ath12k_dp_rx_h_find_peer()
Message-Id: <174008765913.757811.10414072274409589241.b4-ty@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 13:40:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: ow90GH_ThbJLNjp2dSzzBS822RqMKs9R
X-Proofpoint-ORIG-GUID: ow90GH_ThbJLNjp2dSzzBS822RqMKs9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=796 clxscore=1015 priorityscore=1501 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200144


On Wed, 19 Feb 2025 11:06:40 +0530, P Praneesh wrote:
> The current code in dp_rx.h declares the ath12k_dp_rx_h_find_peer() twice.
> Fix this by removing one of the redundant declarations of
> ath12k_dp_rx_h_find_peer() to ensure that the function is declared only
> once.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: remove redundant declaration of ath12k_dp_rx_h_find_peer()
      commit: cb9a978a20a4481dd59c3ea8c6fee36b3dac2b47

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


