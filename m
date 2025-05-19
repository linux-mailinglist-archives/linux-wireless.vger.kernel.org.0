Return-Path: <linux-wireless+bounces-23159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAABCABC5D2
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 19:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31D27A51F5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8C0288C0A;
	Mon, 19 May 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dOTUzSK1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74D1BD9D3
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676890; cv=none; b=KaVroI6DonoOD33lQeeKr4u30P2g+isTtm3/JtehmeA8eTRV6wi3DLwkAl3z1+z+6eyJZHA3jwsFazPgBqxFZZ9kJMA8gpdmpcl67ZiroB6oRH2iBQLC8XFMHH9uL1hlUloyPII9ZoYRBKdefWGYd0aM5pOvKZMVo1CQCuWZTYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676890; c=relaxed/simple;
	bh=xLTBgXqU955E6iztyvSs9wk89W0yCM2QjAFszJ9Ran0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=etqReHwCsDoNMcSWq9AXiyRoLCl8UQ26v2n02tz2P+7EO+1djOA0TXHtoHhHhntTzz9lQ6cZMapFDeHHvgc4YWsKkXFYhgRkoxZnoJ7kwN4bYAz6hwCUiQbqbNyUq1wuuKUnoxgbubvomV/ZitT4SO7FwK+hvwrnA6i6BKXWf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dOTUzSK1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J92A69025672
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KiNTa3xHUT48vXI9VZ1eFS1ze1mvvhYB3w0j4U0Yoa8=; b=dOTUzSK1npw4cYHI
	QPzsmwpPmOR6/A6wv2+VBPjIg653lf322w7Yf8nnIaVG/CAO1THDXbTdtvzCOcWC
	ozVc5onjQLC40GsdFGNBAHKDpQR1yBLXBTIXW+PfITadUXuY7khwEtpybOkIX3U/
	Q4DBuAHttaYCRRhj2uYT7w+QPhf+LipMyHCIQq0K9xgbvJLMQ/lp5MOiIjiTzG7E
	T5p6DF+iLodyYSy5sGfjR4uXIcWImQuVV5dA4BuJS5EAdv61BUzETEOawl0/pn8K
	cDjmnA9Jg2MlwgLhDUuiEerm9meSAQcj7w6zJ5RWyVn/jUu5rTnW2ZvsV6zphj4E
	WvcOcA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pju7d5u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 17:48:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b270145b864so1078854a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 10:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676886; x=1748281686;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiNTa3xHUT48vXI9VZ1eFS1ze1mvvhYB3w0j4U0Yoa8=;
        b=D+oc5XceBbPgiJq08jUpQgy9ZxYhvZmoQQqsedOHBmhgvyMl0o+2snMe1nvjPsEV/h
         eW/L704i1qPCivma7L/+imIwR/s9mWrHoMR4tlvSyhLszF97CvR0sx9phgEFsarvHDa4
         OEHHFlVn73poTwVqQKFtQbkR2UJfprFHYiKWJUpjfsUVW6btMF+KRu0+nGrPvOxKmDer
         ZmmYHpu1E4m+BbHsr+zoatiT9uUCxs6470Btp5jQGYefE9K2ChpVCBsKaaoldNeYaXlR
         EdgbAMKi43ghaEEGJ6kOqbKN3PlF9g8hcvfJMrGTEWDNwHymgEXr3MEZsu8GcrOLrw0d
         FJVw==
X-Gm-Message-State: AOJu0YyeB75gVvqVCv4v31dSPUdiQ3mczm3meZhccpW4PG1xnSDnqECr
	IGaaiR3OFrqvrgZfGquSObrsz5x+WRmouRoaLP1yQjkmiwNwGrPJYwETqkAJhH36W2Ri/AZIC31
	0iFjoMdp9rqIJrth8UHcn9WV0bpY8YgzOj59whmSJ6bF6ZTrTX4FA4YxRxG6yGWCTKNlsxZlHv/
	Wg4g==
X-Gm-Gg: ASbGncvk+JQbWDIlnYHYyD3AxgAyZQ1CivGbNXHAdvS9LRf4XJv9UsvrQJ3sttREFXb
	8M1w9Tr61sheGfMyatyoiAe0fLhaA3DDVTHrrGzcr7zKo1nmE341Wn4KFYJDM7sEZmDeEnn6DYw
	wc9EDnxTTUWQfJyjGhuqtwlurwJskzFESZZ4V2HCuSHiKUngWETrRMMUO4NWjLGHHZX8cguvX/j
	3dm0j8lppY7aZAq4hv0XojggDTdkVmMMGXoysAJCFvS2N0Pkd568WUDBDyKSjltwi8RimOkR1G2
	wB2fziwI3L0RD62Ab0n/krFYXS8DPAQPm2PgBoqczgZ12Nu9
X-Received: by 2002:a17:903:faf:b0:224:160d:3f5b with SMTP id d9443c01a7336-231de37ec9bmr167382545ad.49.1747676886210;
        Mon, 19 May 2025 10:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgkMNmycXWGcWfkPtYwBJCSYbSgtSw8y2jykqfsoWFfr3G2XDxdlJGqMqWmrSIqp4YAU9qog==
X-Received: by 2002:a17:903:faf:b0:224:160d:3f5b with SMTP id d9443c01a7336-231de37ec9bmr167382305ad.49.1747676885859;
        Mon, 19 May 2025 10:48:05 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe8b0sm62651425ad.89.2025.05.19.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:48:05 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Sowjanya vardhineni <quic_svardhin@quicinc.com>
Cc: linux-wireless@vger.kernel.org, P Praneesh <praneesh.p@oss.qualcomm.com>
In-Reply-To: <20250424055104.2503723-1-quic_svardhin@quicinc.com>
References: <20250424055104.2503723-1-quic_svardhin@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix invalid RSSI values in
 station dump
Message-Id: <174767688506.2567051.8725585393397940556.b4-ty@oss.qualcomm.com>
Date: Mon, 19 May 2025 10:48:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=XKEwSRhE c=1 sm=1 tr=0 ts=682b6ed7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=pzwftTKYgEZDdG-AG3IA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: yl_8roJSly_hMwLfbgjGBNVCUau4ejNT
X-Proofpoint-GUID: yl_8roJSly_hMwLfbgjGBNVCUau4ejNT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE2NSBTYWx0ZWRfX03i40Za0gcLx
 +yUAvoxjkUZsBSBZ+ubcPPhxvSThH/aiRqNapFW27ddQoLUOHWOuLnVMIqoJ3jYY/+pATkWzkck
 gEq9cbaKJJD4nst0MAT8K5da0y4UAdrt9yxyN2WxG5SyxF4AY3nPiMLbHsxIvl6IzdOoq2j3IlI
 gs5gtk5pG4sMM5SKUoNxceTDTXspYT0xZA0v0+889/rvwG6TXPLg7CkFbCflJqbljKvvhdlKCor
 aMslc1vUuOVUT2iKXiN00Pu0h2GIkb6zLSa2uZ6KGm5aBE8okUBP8K1to2wCrjv/Kf7EAfhIOOM
 u/L1cWdNy42k/Fcqg5F8HClZ3k6gSsbKuMVZe7U0Z8JnzmPuEO84+JyEtlma8McqeaxoUYKokXr
 JBFLuWZhgWP+MXCh/4rJRsOu5QjZRw8wsyCrL3d5arRaLGz/FvRGtyoXZ2rE0byQ47FzrC8O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=759 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190165


On Thu, 24 Apr 2025 11:21:04 +0530, Sowjanya vardhineni wrote:
> When processing a "station dump" command, the driver retrieves RSSI
> values from the HAL_PHYRX_RSSI_LEGACY TLV received from the monitor
> destination ring, and reports them to userspace. Currently, the RSSI
> values reported are improper because the hardware has not been
> configured to update them properly.
> 
> To fix this, enable the HTT_RX_FILTER_TLV_FLAGS_PPDU_START_USER_INFO in
> the filter setup to ensure the correct RSSI values are returned in the
> HAL_PHYRX_RSSI_LEGACY TLV, resulting in correct RSSI values being
> reported to userspace.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix invalid RSSI values in station dump
      commit: 3126f1c52af5bc8d40d2c984907daeb501f6b739

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


