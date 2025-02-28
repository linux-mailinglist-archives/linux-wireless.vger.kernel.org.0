Return-Path: <linux-wireless+bounces-19623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F60A4A33F
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 20:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B87189D6C6
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 19:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56005230BE0;
	Fri, 28 Feb 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FvRbA7w7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5226FDB4
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772613; cv=none; b=rsBv32Q+11inDWuvWYgVh7u/k2MKlHnPs1CmGCDRWQOlVSCb/EQ+JXtlaEND6IqFx8Muu0c/SexwTHHSaXv+D/Shx5NJxMdDUOGjtBDumE2TIDFkGU2XejnH5tiOvR+a5H0LaJoUfTSXWF/xVnI4ck7mcYT7keR420OjNyK9C3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772613; c=relaxed/simple;
	bh=bN/2o02x0EaCME+Uhmko1p/92OGOtG/jaYCv6x0kZI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o0NHM6tZMSnxdwhZ5ClT4qaBhe+g+lFlOUs8fGkKLp84if0i9oksOUnQ1WAFvGdODTsSebNVxavrdjknYXcFZ1YL7RkkKoWLccZosAkCj+OUUf69xNpajHbfrHp0NVu4vRfP4iGBC7vQc3EKu+ZoJ2IBBmVbkGVeI5MGEX9keFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FvRbA7w7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXHdo018832
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FLhrDFLiXAfPmYZ+M1E3Tzf5C/xkASQqa32SzWbQuvk=; b=FvRbA7w7sNyDRhO0
	7mUYDTikpS+u+SGRNckdjLEmPGLTxCtQzAlViVCUMrSpU/VgFXyrvD/X29kL4u0I
	RjdXP9cSYsEzyazamLqG9IXfE7oRHn3L9Ejv5HhAE87lEivc5c1I+hRIYrlAxW9J
	Iubu6aEqu1LX7nSecbh/ESzV13lTfjebZEt+W0oF1TRFLGEDf2gTvXqGqVB2rjAc
	/cVIcXnZUU5dPXpkeIOuBr7pxy+VvkfMQtU4wt+P0J3GCvkJ/CbwkYnLdmflQ+Fo
	PXlo87oJ3XMSuz5iUVgMaH/dlnvZ4Zj36XQg4ZnjJqeb2NGXfmokIdXn//x+tQrv
	s/3w4w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnaecg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2237f73c669so4767825ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 11:56:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740772607; x=1741377407;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLhrDFLiXAfPmYZ+M1E3Tzf5C/xkASQqa32SzWbQuvk=;
        b=aBhRpOeRtAU/BxJR1QNkUzuyxXc3aS7kebNsxf2A0G5PopchxKuRXEzqaoPpFcgIyp
         B/3ifh/BJxJHTKQMEWNfkBkFMntnUOyMkBC0JCTSqJoCiHQpPCgTpDyO34wrevSjun46
         mYET4KEquaEs5yq/MaWoa4NvWo9xjkdRBTxKPrOxR2nXa0omJBH3tey2i68W66gBNLQ0
         orTTc8R1+fh85api9HshqTv0O5aCpDKhpoShnwL6ZoZZp4wUpueMl6J/4CnreY4lrySh
         xsG6cvzcro1dQU3nOrqUYidVvwA74NauzgvddfO+wi7N3I0SDrpDzfNy8bIwaJLdNOPx
         wE7Q==
X-Gm-Message-State: AOJu0YzOR9giv7AbdeE+C5/7nck+RyX7bmi/3vGVRmcxjLsxy/CRLSIQ
	P8OPWKHqu3BR7TuBjKnA7hOSl93TsUFGg1os7Cmz6D20dTNLEX4tRT1XZ7zeFIgxQ2Ze/SxzelH
	54mAU4OTqRgJhB/DzrmEgvapmZh7HR+JyHh2sJX+31OHU1XfXODxBXu/rQiVhNHnamQ==
X-Gm-Gg: ASbGncsixmYYgmGbVjfUykWm3dWtQpCQs27RjQ8JQwphDwJedJ8Fh8frogWShcssVjb
	Vkv8zTl1I9/28sYnUyXuhZv4vI3JkMe+GmZ6e8cMQDC4zJZQv/Rf+V8MCq29Ex4lBAm6hCtwt0k
	oUgNNcQ7Dyy4cy/xJ8moN/U+bPs+A7eTqUqrExOOXCy5ghTywrpQOppMSPSyccdX1fiocuNqshU
	+vtBRx8scdm9s8qnTzw7vpK38WfbTPozu/ltuDT12uTM6Yh9+VTBKzn+93oCLJiMS3fky8JvAlX
	f6bOOkfkftV1VhLwxW7maiiCtAG8RrANQ/u5hPiuF39sZ1DcBCuG
X-Received: by 2002:a17:902:ea06:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-223690e1355mr73911195ad.23.1740772607652;
        Fri, 28 Feb 2025 11:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7N0OvSFFa3UWHRhgJnMWCvMyrdXk76Vy99PtpyeYMuduZgzrvVi7czXX9W/MtAa4KhsBhtg==
X-Received: by 2002:a17:902:ea06:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-223690e1355mr73910685ad.23.1740772607194;
        Fri, 28 Feb 2025 11:56:47 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505336ecsm37140165ad.244.2025.02.28.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:56:46 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org
In-Reply-To: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
References: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
Subject: Re: [PATCH 0/5] wifi: ath10k/ath11k/ath12k: Strip device prefix
 from calibration properties
Message-Id: <174077260613.4132177.11023317176929798759.b4-ty@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 11:56:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: SPOt2nwP-QkmMaSZwciu3f9I0mcW8kj1
X-Proofpoint-GUID: SPOt2nwP-QkmMaSZwciu3f9I0mcW8kj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=735
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280144


On Tue, 25 Feb 2025 10:05:31 +0100, Krzysztof Kozlowski wrote:
> Devicetree properties describing exactly the same thing should be
> reusable between device bindings.  All Qualcomm Atheros WiFi chips needs
> certain calibration data, so properties should not be prefixed with
> device family (ath10k).
> 
> Deprecate qcom,ath10k-calibration-variant and alike, so we gradually
> switch to a common property.  This will also allow moving these
> properties to common schema, if desired.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: wireless: ath10k: Strip ath10k prefix from calibration properties
      commit: fcd37e2a33167cf6b507256365e45a43009d74eb
[2/5] dt-bindings: wireless: ath11k: Strip ath11k prefix from calibration property
      commit: 352e8c4379fa540747cbb6c94c4b149c7487feac
[3/5] dt-bindings: wireless: ath12k: Strip ath12k prefix from calibration property
      commit: 64e37c19383f840da534449b88d7adea4c69f52d
[4/5] wifi: ath10k: Deprecate qcom,ath10k-calibration-variant properties
      commit: a97ed4ecb797a69f52f66445ebca538c93462ba4
[5/5] wifi: ath11k: Deprecate qcom,ath11k-calibration-variant properties
      commit: 1bd9ffec4cdb9a1f09bbba16bba538f6c58a397b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


