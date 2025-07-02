Return-Path: <linux-wireless+bounces-24766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8365AF5A79
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 16:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CAA3ADE45
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F39275AE8;
	Wed,  2 Jul 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UZiyR4Iw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CED15747D
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465161; cv=none; b=m9rQSeQ1N/5otFh7u0rnY/Pz0xSodY5cWF0kQs35D2TIiKXgsyFrxgbZ885IfFOJifSha4dyyq7lYDv8EZ1poS7A82Z70tYSJXywy1mTyGMIyq0QO2Qf040QWDOjMdx2Ey9A5uXRdq/AL5KpXTWQWVKb32xOewBz6IX9fgfEEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465161; c=relaxed/simple;
	bh=NJ53W4Zh1uRpgmoLeUki2MzRhCYo/NWbTTG3S+foTJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iKeQybnvowi2n5Osevrih5yFAdD5rCs2cPqSPmutj12Y0DYYq2K7OSVl6VFSpjivwPxZa7lLAK/d7J+mkiDGWQrR74t8N7tiA7X9TdQuVZlRtpP5JWWJ9RQHDaVjmr4g1syUzC2LgRvgnltRFllhs16LdEnrgEmHL6zSSxo9mhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UZiyR4Iw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562A9NL0013520
	for <linux-wireless@vger.kernel.org>; Wed, 2 Jul 2025 14:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IQvBW8J+BIV30oXgy9cxL4PRkz2BKisbdhQbgoH5944=; b=UZiyR4IwMgWge2S3
	QlGiOr3bgTinZWirs1ATmCfFDrcLLXv/L0a0orLcDBO3mUvkoYn1oEgLVfDix84d
	cCqGI8te/i3pKFolagvlGyAVGtUROWVItw/xeFw2oAOxUOhN5csRoF3lUaqp+Ygn
	RyVXUWam/IYtQwzp6ZrHJRrPhlPY8rTCZvlmW0+nib65rM9jBbVtdvPquFhIQE/D
	8FYq/UmTExBeUruspyt5Jx8vk1NTZKjLoK+WVwKqnlJtF6Z0laFFuVa8XVroVbM1
	KkRHbZw6b0h3FJVjqIuZUXx3Q0VqyVnrB0aDdbQ/gbnze501EfsQqgkThadNv3CH
	0fgCQQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8024q3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 14:05:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235e7550f7bso62898175ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 07:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465157; x=1752069957;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQvBW8J+BIV30oXgy9cxL4PRkz2BKisbdhQbgoH5944=;
        b=gKij1zrGR7VnNbVhVsoeooRd53y1KdaulFbb6PLIwnVaJtmFKttsRZKInNbD5WQ8To
         XDwQnvWHQ+L+h7AfKja8JGZoYfB+SxdCRT5UdSbYTUfRm++8P9zbG7p3jwwCarFQGWIf
         lOdaL1NWat3KRgNQrxHf+vjiCeVPpQdX+q64AiWNSzqZe4MIiPRUee420s1ls39JjVGh
         gYa3W6oAAxFpp7b0hTNLmrh79EEOk8M2pivjcnI+lWbawanXaa8sgEQpO5xLTZqzlXVz
         GEtXr3vS1naI4IiCP1VbNP1emVESRGAraXzILidWp1KZaYmc9oR0BbWxKsRfDDqvQgQ0
         sIag==
X-Gm-Message-State: AOJu0Yzuw5RJc72dn171wd/nPYs+TaDpVQBf5DxGejPM/Uz4FlTdtToe
	qwma5hamhlJvbCGCqHZsHCattKBlV0PUzcjFBRPMxO+xhCEAUAhu4IY2tQQ7FHOe4xBE6fRes77
	fykzTI2xoEk7KnzuC+8jaDw2VcvUkvutmJ47QpmDToDrIwG1wgkAW8PwQVzeO7G6AvqUgcS32+b
	Zt9w==
X-Gm-Gg: ASbGncv/kOem6K9wBUgBDfWcX1EQlRQvpPNWEhH8RAcbleItQ9oFNfuM7KE4oAdAtG2
	uY6LNBCWhnTZgEtOTQNVHvhOGINeSbKgkA1cVMCHNJOSA/R84cW3+CJA0eSH4C58795J5myTMVi
	ypIu0dc7A8xOPVFt3m2XsYdOQ9iL4J8+12SYUDseZG7KJcf+A3eC6snewbaPM1YHPfHN7nMaUzN
	nI34MmuzggJuDKuln0zAWxqKASDZTQs5ZnbnfllwFN2IT+Wvbb/VIoY/4Lffi5VX7M8oVhF8rAJ
	ueaSEqmrpBhrgwGrj3MxIFjH6Yn+2g/hHWu66FG3O9ZehEW7m1QUzF/xTZE=
X-Received: by 2002:a17:903:1aab:b0:235:e1e4:ec5e with SMTP id d9443c01a7336-23c6e6335dcmr46361365ad.49.1751465156872;
        Wed, 02 Jul 2025 07:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM5Z2FbVNm9hOftU512BCIRmml+BeK0rWxNg2h9Ius09ND7XeEyO5kjNTIeS1U9Z5gE8s9SQ==
X-Received: by 2002:a17:903:1aab:b0:235:e1e4:ec5e with SMTP id d9443c01a7336-23c6e6335dcmr46360895ad.49.1751465156323;
        Wed, 02 Jul 2025 07:05:56 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b0047sm138501435ad.160.2025.07.02.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:05:55 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
References: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
Subject: Re: (subset) [PATCH ath-next V15 0/9] wifi: ath12k: add MU-MIMO
 and 160 MHz bandwidth support
Message-Id: <175146515503.3638878.3725879720919440372.b4-ty@oss.qualcomm.com>
Date: Wed, 02 Jul 2025 07:05:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: BYHNqOUfnmumF7vjK0L4VyFByKiAFE5-
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=68653cc6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=PScoVZ2_27zJITdMlhkA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: BYHNqOUfnmumF7vjK0L4VyFByKiAFE5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDExNSBTYWx0ZWRfX5X9DYxb+GZsV
 Jt6VseiVl0n/sKpxKWucJiAOgW0abu3WE4N8i6FaoQtbw23op7O69NPUASqct+zP3koZAWnqbE4
 tyaLNPlQ9p63lTco4yJA163xKRGdKcQ1s0oP9KznNWERhVFqrYKoe8sdC38zbGTQ1IM/rc7+Fvh
 RskSZOKOa0RvY/wwrHi9b5ZHRYXckM81jmgQa5E3jtKx9RVqyuBf9JMLCP668pde9tWEZqyihmp
 9p18wLIlKc2H3bA+iK7BDYEdctWpOnqArmeWtDzrw4VHVX0Ts0p5Pa8NIW1SeP3mYf3EK/SVbIj
 UpcZ4YqQnfF762LUMQTmiw0odv9K6JlPWHFD85a9NC57h7HftlAX+7RQvOpbyYyEEskkoqMwLcA
 x8/gRCAe7DiajWyNKRoabiFiNuHW9Jqa3czV7KJDvFz+DaKOyPVrO9aOsHDDC2wa2ysZjWMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020115


On Mon, 30 Jun 2025 18:03:59 -0700, Pradeep Kumar Chitrapu wrote:
>   Add support for
> 1. enabling MU-MIMO in HE and EHT modes from hardware
> 2. setting fixed HE rate/GI/LTF
> 3. 160 MHz bandwidth in HE mode
> 4. extended NSS bandwidth support
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> [...]

Applied, thanks!

[1/9] wifi: ath12k: push HE MU-MIMO params to hardware
      commit: 5d6707e88e7fe2d603ad45c5fe7eba096be9533a
[2/9] wifi: ath12k: push EHT MU-MIMO params to hardware
      commit: df8207bc0b4895c18e98a4b084806222b592d9f1
[3/9] wifi: ath12k: move HE MCS mapper to a separate function
      commit: 1eafb8d15d8af39ac7b4d78d69b17f85aa8e00fa
[4/9] wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
      commit: 5ab7479a063d1b557fa59999de701ad8a4624b84
[6/9] wifi: ath12k: add support for setting fixed HE rate/GI/LTF
      commit: 9ad6b169ddef679a64727e3870a6177c78f24b05
[7/9] wifi: ath12k: clean up 80P80 support
      commit: dd25a004fb66c60934fa9572298671c1eb1c06c2
[8/9] wifi: ath12k: add support for 160 MHz bandwidth
      commit: 18ab9d038fadd35d8a4ac5db87ad16dde78f5fdc
[9/9] wifi: ath12k: add extended NSS bandwidth support for 160 MHz
      commit: a82ce08775bc5b50613d48ab7e41b25fc46825af

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


