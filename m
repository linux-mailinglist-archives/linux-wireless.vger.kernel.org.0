Return-Path: <linux-wireless+bounces-29458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E664C9C895
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Dec 2025 19:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD010341900
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Dec 2025 18:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B9929BDBF;
	Tue,  2 Dec 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZ/W2OoG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ORHqxpaJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1A282EB
	for <linux-wireless@vger.kernel.org>; Tue,  2 Dec 2025 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698792; cv=none; b=i3Ehdx2W0ukFSUuQiE2S5yUadJRrU0Dr0T8uQgt6uEG3hhStNcE2N2i6AYmPFcrlOIGtPBtfKLdHx2TLDu3MUBOw0alOZzteXxkUaxKy2bgFyFYlGi81mUq1MZtJl/UpV0guuNYmP2EV3GWuawOtK0xw+S8jlOabOhAZZZ3uJaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698792; c=relaxed/simple;
	bh=k2gtU/OMVkX16sJ6Nsp9n70vhFRXosKaxtNfUCIsahk=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=WGAwAnp8bz3JkwHF4ayJuZI6Fehf+slOmqkAIUcXoEKhsmkrmWVoZbh3W4cgi60WEGRws/2/fvUKWcWw/89BHJc8hpxqfA/nC6sevNDTVsBgyQYWRmBKTQ9e5wp/WaqTNjKX6JZlffQyScEWEXY5XsxZREpbXoI2Yg43HaIfhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DZ/W2OoG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ORHqxpaJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2GIVqx3284557
	for <linux-wireless@vger.kernel.org>; Tue, 2 Dec 2025 18:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sdAs0dnDIogQLGWCHgQe2H
	rkUPtRZeYZMCUBii0siA8=; b=DZ/W2OoGO+EwpgHVbDwKw1ewM8mFMu0Od7VBIg
	h4SVSP56eUYfq3Cm80ql0MZ+wjt7shMnC3aDAVq96OO79jwAID2ZpXPTZkrpF9oC
	gr+6OJvBeRUDYeqSaG27bNbgrZ/xBMgAMQqFTFZMNJDer6KvSZc783+9b63PIpif
	M9nplnu9Gy5YeeuKiVTWx37gemCmQ8XszFwyqip4HjV0GIYSxDtuQpv+d7PQPbDy
	hjjOsRC7gOmklFxwMbYjbysBl2E6a5jUouAT75LUeIFeo/NjH8WGVB78oS22jEl/
	EdEbEveYeoxwmt/4sl6Yk4EeLd18Uw61T0zckMA61KWQRnBQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asvj91vuu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Dec 2025 18:06:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34378c914b4so10850433a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 Dec 2025 10:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764698789; x=1765303589; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdAs0dnDIogQLGWCHgQe2HrkUPtRZeYZMCUBii0siA8=;
        b=ORHqxpaJ2017EOdUsbmtP/ecWuQnhg+Csu/oQ9Ity6LCas2H3mMWIKlocmMuBb2y41
         2hbkCsGJC47EdWJmmjGpqqGAkAQtf+iyzzCxFTP1jO16nLy0wacTP/kpnh/OmwWZDdxC
         UJoyVegPJG8fpnoJIHOTqRM/5AwB+TxiO2E9L+td+eyYAMswFq0REo1ybTyJQxLxpkFP
         kYgaLuVQYbOcvSw11NOIfMUFk4srHdLTJxnnz94y61bhZGRut6juBzmCdkhZvzd7g6MW
         jaJBLecFuZoXygA3Q17ZlWe1M/Qnf1lpib4jpfU5zbZZ/SE6iTJ0eeAjgAbS9JgRcHtE
         NB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698789; x=1765303589;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sdAs0dnDIogQLGWCHgQe2HrkUPtRZeYZMCUBii0siA8=;
        b=XPozpGg/VTmYa2WQvr1Jsu5PoSGkdrHGubKZB6Sc3dOtY00FXpa+FeHO7lBH4obW14
         z7MUmARf+DlQBR/n4CIzzfcmGqHWxj3oNNiCnpOJEEjTlbhcBuzkRXX2YbRcJ/W8yrwG
         351tPUMVb78PNTBv1SzXASjaHzOd+coo6PyshVNeZvrt9VTWFCnqo32ULNzr6l8ih+cY
         mbDhGjQ9jBRiI18B0c0LACcpP4EMDr4cbZOFgJ2Qn4jdq3XVnTNypTnGsJHNlmpUq/Ep
         f42ZH4VHedwRfI4hfdfLeeZp7ewqQhHcZedSfqgO6aLQhCS2NSolmH4VHoxoSnZgLfQ/
         4GvA==
X-Gm-Message-State: AOJu0YyJisIlq71BZ7rD12wSSD/Onxv1t7wORrV0LdXohRnwbzycETAq
	KtkGVGZvrUSRBbxLK6NkCCEjCvmTrejDQ9qbUuls7Njo94m5abd/XREqVsiawFZifAwbqo80sSs
	/mXoOC7uoRUw6i+WHMp/zdsXRwf39R+bOn+E9nFyJvToNrqnamLn/zXO/A7uqJJEZxiEsEg==
X-Gm-Gg: ASbGnctrKwJ9PMZAlARTT9AtyNPI3XITpbgOOculbSZ+KQ8vYeHJciWCF2SsN9nBaSK
	XW0/t218QwFre2eg/A1FuwuhbV9QGyjdRbxY0odpKR78XZPchpfwaWZUKpXVMLiLvAfOEyp1GOO
	AmvohNoXMeXuKNxyaiISYhw4pUo6SuhV6yZ35iifNwc0uHHW9A/YygEOlE5AJbLgNKfBADSBllK
	t6roXoAT2wVNYR1ijimfHxT6D7jY7ThT9dME3yctE82/3cLVL4OZmLr0PqY9Tl0Xq4734WR5Iu+
	iPorRaiPPIaRD0vGnAT0Kp6tjaM4dTVvgWrVkMukiaGlGdfHw/TPkzVPmp91nEYQvrom9hFmGdi
	v1tu+R/bxZwfg1lXPlEpkQRPx/boWqR15MDnTUcUVtb7/mw==
X-Received: by 2002:a17:90b:4b45:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-34910775f8fmr259207a91.3.1764698788541;
        Tue, 02 Dec 2025 10:06:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHd6+xbf2z4wsfu3GDzVS/La6L3U61jv3f7dxujiiHLeJ95eqqcLPHTONyg4VyfeA2+arbvgg==
X-Received: by 2002:a17:90b:4b45:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-34910775f8fmr259180a91.3.1764698788018;
        Tue, 02 Dec 2025 10:06:28 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34910e9dadesm41153a91.13.2025.12.02.10.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 10:06:27 -0800 (PST)
Message-ID: <5d522aab-9ea7-46fc-8d46-00bd60bda496@oss.qualcomm.com>
Date: Tue, 2 Dec 2025 10:05:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware ath-20251202
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: F4Vh3T98wn8bejbc_Wdi61IhMy2Em9H-
X-Authority-Analysis: v=2.4 cv=Hq572kTS c=1 sm=1 tr=0 ts=692f2aa5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=rMWBp-HL3mJ3BiuJKzMA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: F4Vh3T98wn8bejbc_Wdi61IhMy2Em9H-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE0NCBTYWx0ZWRfX6EFK8dFz1EGq
 g/fYJ2cvRuRPaPMoWU/0OLYjFBbyxG4H6Lt9aK3CohCQmMjaJYXRCkcnReGLhnKXbz7GyleMtX6
 h9DMjISKA5uHHXzxHl2gFIpAgEHkyfLjkBLBi0UBlFDzkzEOoog/1CDJ1A7lc9Vqtoqg9aqm4Ht
 ojJ4UlNW8shzm8yKPPiN3A592ZJUWbldlbc8jQpssKVxsNXN/4rlKl4ZQibOgG5OT/HzQ+HhwBq
 DXbg6u6/xtvWimjEHww/3BGVVDmhWOlOqzfwm45ChIonjlvAc5PahlkzeJpxyodSAD8yRoQtHMk
 T4Wxorb8tLsDtvyRM7UDlyj/iLZOYwbMZlGNoQJuy1+k8AvFM6lOdfip9xHlkM9Dbn6sOictzRT
 m1b+pgplJEu7pNXuxz3BFQb9ON1GBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020144

Hi,
Here's a new pull request for ath10k, ath11k and ath12k.

Only ath11k is included this cycle.

Update the board file for two QCA2066 platforms, and update the firmware for
QCA6698AQ to enable CSI/CFR reporting functionality for IOT products.

Please let me know if there are any problems.

Thanks,
/jeff


The following changes since commit 38c82f07a964e27c3e71224c1f038a4083ff58b0:

  Merge branch 'robot/pr-0-1764573234' into 'main' (2025-12-02 00:54:05 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20251202

for you to fetch changes up to 15f8543684412387ebfc97a4b99ecd18afdc5e0c:

  ath11k: QCA6698AQ hw2.1: update to WLAN.HSP.1.1-04866-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1 (2025-12-02 09:53:54 -0800)

----------------------------------------------------------------
Jeff Johnson (2):
      ath11k: QCA2066 hw2.1: update board-2.bin
      ath11k: QCA6698AQ hw2.1: update to WLAN.HSP.1.1-04866-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

 WHENCE                           |   2 +-
 ath11k/QCA2066/hw2.1/board-2.bin | Bin 745408 -> 745440 bytes
 ath11k/QCA6698AQ/hw2.1/amss.bin  | Bin 5005312 -> 5083136 bytes
 ath11k/QCA6698AQ/hw2.1/m3.bin    | Bin 266684 -> 266684 bytes
 4 files changed, 1 insertion(+), 1 deletion(-)

