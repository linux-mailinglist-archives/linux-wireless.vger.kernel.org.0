Return-Path: <linux-wireless+bounces-30427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB08CFC99A
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 09:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E78B0301AE2C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E5529B8E5;
	Wed,  7 Jan 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjIzlr1R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hqdFp7ny"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57332286D7E
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774488; cv=none; b=NF6rC5OlV7lhVNtX8ywYn8f4Xz2ulTIYz1wkBxAmQaMkFX2+vyQsihzAqWM2+2Dx+i3eb57ii4G+GdQelMjm3ZmfeHrl5CB2n5IVJD1NypHUbiLP9Q4ly0+WsnGp+fnFVcgML2zlE/jqiYe5NGAq9Z2HDDZQEYctoEpK4eN+4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774488; c=relaxed/simple;
	bh=YuO01J5cCWly3QRXJK2VwnsCcUL+EAOlhGOT+tPLkLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBjFhMCT8raxoeJNtbOlzFmNc2UEj0lgmxageyV2IbJscZiifkCTr9P5aRZxF1Cz6gtub3OILKgUn75ylserldIzDfzbYb2cbRpahpR2GzcAm8x/s1O8Uic+pGM0acHl92816JWpIuU9SrGUkgFLvpCSNGDenRd6Zwkt9PrHSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IjIzlr1R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hqdFp7ny; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6076tM4g2379134
	for <linux-wireless@vger.kernel.org>; Wed, 7 Jan 2026 08:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k43xa4VOrmCN2BiW8MUJUfR8Y0vRZWMZ5hz8NjvOgRc=; b=IjIzlr1R3KKnDL48
	B4snHTjz6SONqjd29mx4uQZ3AvJlUhmn02XRlKxkp+RwDNmsJVBv9/es/IYnZcl0
	B94OoR6+JlMDnB3ABDSZCR4N4Sah3Eb0y5lyz0D04hjVx6VmV/XEubFket4cuE17
	CY46JeOZ1m5HwWTsCfA8dirRd5Xxf7Gq/kNq1YJU+8fVNDW+B4+K4iY/QryDH6/P
	edEe7CYGA4XR0peZ2whHfhBmUklhHzZK21BqVg4DccdxFDHnuMtjTwSbi1Fx2pnw
	hsUUL06lkeVTpphXAMXEio6Mhc54SPQhWZYGUGA17WP+P3TY/lSYNDCgRWQM40Gy
	VNqjKQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhjn4r99h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 08:28:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1d26abbd8so58252381cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 00:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767774484; x=1768379284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k43xa4VOrmCN2BiW8MUJUfR8Y0vRZWMZ5hz8NjvOgRc=;
        b=hqdFp7nyW05SypdofsnhU2PsD7DYelj7kJ96jlfB/Cw8GxNgRi0qtaky+Gfq8/8H6g
         Wk3dp+QuOU3qwbY4WDn8IzAIkUL7ex+vBNd+8dBcUS04hJYH1DaoY2nqx3wIb/XtF4oG
         sns64KwVwwqdlKNOBuP1BNGrKlzvM+cWIwJVabExT4QlpttjXDGcq2EtKRe39iM66awy
         VbCPrdgwuT+2qXulzXRsIJ8hukXnMb3iWEfr3V9q9Kj7gRnDoIStuUT7nOsB9KM9tYOB
         iF9IkmGySxdMeGIhFwA3yK5V4yqNINTP/xyz8O5V+KXydOd7WIdTX50bUXFVlsR3Dacb
         Mrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774484; x=1768379284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k43xa4VOrmCN2BiW8MUJUfR8Y0vRZWMZ5hz8NjvOgRc=;
        b=mtFjsuiv6/Zq9mk+ausO2pPDXO6CHPvAaJsgI9NGWQ5X1WQdYx3rCQ7cizScryEHBf
         oS3d/b+QvG+rXlUBMexcaMg72YyM6jBmLh1ypSyU+0z4+J3HgabsVYDP3iMIRH+ulvjq
         cy6mQECX0fPqb14PMIL/wcwhSgCf1tSz36Bl9RlpSoIHCLVD+4jlQOz8vyojbv/XdS+n
         OLcNVmRS1NlqdGERIPqYZLx4zHRZANPEeyXW+AVBzNZCXSNiF0E357lRrgK59aqtuuu5
         uUNhLolyURAN7/I9MntWHfSUPI6TPOZH/bEEw3TKUsEGZHX4QABIdgO42/SeYWOhSamg
         Tilw==
X-Forwarded-Encrypted: i=1; AJvYcCV6cZairuK9jomZU+3y0zb3XnGTVSQ9oXAjtGOOmKeKjs9j7Wqkks+STvE18QPlnep7Ymjx1fhCo/hFCn2nOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSLQ2C9Q6GhHyBr/B8KDepCnkUUhy9+CzeD0KeWz7Ws5K+OA+S
	E0MiRk57Mcj+A6NMV+5WwHqQrFNMW2lDiiEAJYjP/8zgiNmFzPdLoFqIHrXf6uX5Kxo4mXZ2p9q
	fPJ8ORAtqaaqii+NiTHf0QbyHjCBQl9UzaWFCAlNUSbGQPNntwPMVsY+VArNqowix6m9vfw==
X-Gm-Gg: AY/fxX7C5xX93ldZ8pFCq1aXrYTeszM7foOrUnMTY8U5iD3YmFgqgNoConGza60HBON
	9ybQ/VZ41nK1LM8/KSkRz7NJ/i3EgS+CR77NT0eqwXaIm+SNp6nBCGVsjzI5YUvird7QwHpGDiZ
	C11iGZPbMpsO6kub6DLRzYmXeyI21xOii42+N3H3dwt6uJrrjRKHXMCy4mZqOQBdH2klRf0qxUW
	NRcifpns9+mWDwOnD3+Tki+VHqshBRk6/l6Qn95wSJxlPI+9jZHUWlYwzIJOQ/16n1/ShOC6G41
	0oSqGdQNC30+3rn5IQVlrD1B+OzmA1bDihgNLoLNNUTNPN0CEfTvfICG93QfoIomrR9a8uXrt3D
	9q85PzKe9seII/Niy3LbcBadoRyXgjUG3oTEs
X-Received: by 2002:a05:622a:1b9f:b0:4ff:a40d:d2b2 with SMTP id d75a77b69052e-4ffb48636f5mr24099431cf.16.1767774484655;
        Wed, 07 Jan 2026 00:28:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1MiIvYcTnGKSlwitEUnDPbVgoa6OjhOX+6gyCQTwvT+xhiYWDPGcJ1+Nnrt4tdoBe4eljtA==
X-Received: by 2002:a05:622a:1b9f:b0:4ff:a40d:d2b2 with SMTP id d75a77b69052e-4ffb48636f5mr24099151cf.16.1767774484256;
        Wed, 07 Jan 2026 00:28:04 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:b90b:ec1:e402:4249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865f84besm8276575e9.1.2026.01.07.00.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:28:03 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 00/14] power: sequencing: extend WCN driver to support WCN399x device
Date: Wed,  7 Jan 2026 09:28:00 +0100
Message-ID: <176777447710.14370.7888531422852179019.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LJhrgZW9 c=1 sm=1 tr=0 ts=695e1915 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=f4exIScRoNMJIANslhQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA2NyBTYWx0ZWRfXwAUptwzR1EvV
 TAyOUam959yq6FcavyRhThqIetPMelBc4N1EuDJZp3wG1iMoNcvfVZ5xtGLbllcelgYP1dJ7OGn
 BWAdkbzECMK6fRGsjOtGhIA5TNPQEei/K2UXYSKP6U9VK2oNVdGlGMlr5efthlE6+l+TKYAxRl9
 FtCP5EG3c9sLYZV7b26vJsey/Y05N22hqGKGXavMBdHNS/CWzBGSehKXDWZukkE9EZ0CQ1P/iCJ
 ls6+VX+ot6oaYP/RlHXeXmdwo2WOmBqrqvuItBogfJU5s7/wr47wFc6MoXbNzgIEV2ynYC1PR4o
 Lzqfz16XnINhhlLfaYeaoP75kisz7vltiV8hH4bv5iwdsJPzweJLbB9iOG/16QhP2ob6D0u3+QM
 lm78ChusZr3GJpng3WPJ9BX9Kyanu4oZnUd4hK2ZdSUOA7fFeuMQvFIGMJZfvSp/IB5td1qdF41
 7kHvAkccnDbXcreDcLQ==
X-Proofpoint-GUID: DCk_PksXCGRs954CCp4wTJZUTwoZGjfK
X-Proofpoint-ORIG-GUID: DCk_PksXCGRs954CCp4wTJZUTwoZGjfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1011 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070067


On Tue, 06 Jan 2026 03:01:10 +0200, Dmitry Baryshkov wrote:
> Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
> the later WCN / QCA devices, but they still incorporate a very simple
> PMU on die. It controls internal on-chip power networks, but, most
> importantly, it also requires a certain start-up procedure (first bring
> up VDD_IO, then bring up other voltages). In order to further unify code
> supporting different families of QCA / WCN chips and in order to
> maintain the required power up sequence, properly represent these chips
> in DTs and modify drivers to use power sequencing for these chips.
> 
> [...]

Applied, thanks!

[01/14] regulator: dt-bindings: qcom,wcn3990-pmu: describe PMUs on WCN39xx
        commit: a5fae429ec2ac72372bc874a0334a7fb9eadee83
[05/14] power: sequencing: qcom-wcn: add support for WCN39xx
        commit: 0eb85f468ef515fbd2538375ef3884f6dd376382

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

