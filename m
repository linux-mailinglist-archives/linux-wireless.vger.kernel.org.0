Return-Path: <linux-wireless+bounces-26210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A991B1DEF5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 23:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8461AA1949
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 21:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FA421E08B;
	Thu,  7 Aug 2025 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AqxKqiot"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D02512E6
	for <linux-wireless@vger.kernel.org>; Thu,  7 Aug 2025 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754603030; cv=none; b=tQHLvQwAVm2dweXkx/n/T29d1SuKf5+F2EQ5I+XAlfFueXNs3wDzfKakLYZLx9J3As4MFjTS6yGzazIiq0JRZwb8go+McIBCVzmJEbJrsoUZBp/ZK5FPj7HHWq4qqnOmIGsS9XRqXteaa3HTI+1KzR0fmwxc4Ail89pW/8M9JWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754603030; c=relaxed/simple;
	bh=a73m3Ol7GyVat8qyuCqYO4lPUWU67XvDAkT2t25mHFA=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=tIdkBXQyUTYKpoKxX91qtZfWd7IOZJ1B6EKQT9DEakfRBj1S9/SDbZjHbyi4+oKfsbE2bS7ggxscM8QcabkqJ+xnQZDA3naBBCyI6hXqGNrNK9+pI/hY9BDtprYpk21FQh70l94TATueOzXomhLYZPg4b2N8Rt9w6q6kjM3joJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AqxKqiot; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577EDHTu028297
	for <linux-wireless@vger.kernel.org>; Thu, 7 Aug 2025 21:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=c0YZ3YLLvJK2KdMo7JoUSc
	JunUE/MEJzmwquZliu5aQ=; b=AqxKqiotMaKj+4zPmQwOMwJzOt7NovA+3yERsn
	2jguwNczw02rJtEEJde29DyHMD0mAuCqxP+u1ExQzuw5QRHKwAoceNOTKTDIt+UR
	uR3vooaoJwNdCknLTzfdz9xYKvAo5A6Q7i/b0YSldKWxcZy7G90yxCv9AvfXCmaf
	pV5F0gquaG7oBzieAjEVCCx3oVwoHxlTQZEybgegEbnEI5//nwKedhV/HRoSji+2
	qMzei8F3g0VPqkLRNNTlt+nqpQgLPQ/+GZrOgwg/MQo1037oQdyiyodmQhfEtIoM
	ReYSeJyPcaPY7fwFmS1y6ag2RsWqie+3c+E2rBAbd8OQEsuw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw37rgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 21:43:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2403e4c82dbso11324575ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 14:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754603027; x=1755207827;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c0YZ3YLLvJK2KdMo7JoUScJunUE/MEJzmwquZliu5aQ=;
        b=J+jBU3YirvoFbHR8AA9nDxvG2hMpPtkdraVXRZkx019J8mckn9bcNACXUaanuCyPA8
         T1v8OhkHK+Q4EC4Umosq+Z6fue1fIR0KIbo04B1BenIlWtmHZ2B57SbLCT6aNJRFtdC2
         3NxJ8QOoc+MetvqW+LNnHsGcAR44SA+X2LB24OV78w3cB7bchajkN7d7FWVdKGrH9yZz
         6U28l+Y6hzO6Vyq6jv8m6vfHSncA1xli0qODEAMc5LGQ/ZmI1e1WyKwH0UD0CPJ08tfD
         HPx1hYpM1vaW/D3grzCBfzjkx9CwJwJNRi4HVkuNfipYhLlji2IGyvnY4HiVXcupc7SQ
         +atg==
X-Gm-Message-State: AOJu0YzD9aj6CJJpnsV9GKNptzpOrTaFDKMCcnHKngYhni1Wcs8gdgrs
	Xnfze2m+04tyGcWpqokZyDRMA5IwQ8KHR/RvQXTwG7dLlRb4QhMA3oeAwyzZr58IR2BYMr9bDW2
	SvGwzQ5xpvuzngdAhIjKs0eMqqtaLWede6GLCzfYPOYLHhMN0llRWvSXqnPlh3fBLSVTrag==
X-Gm-Gg: ASbGncuhKB7v9sAIVLKZ+Hoqh6JqaVjMYkRnoldpazsmy94c6In2R6Bn4GXDhiIzltb
	RzMI6DNI7+JlfghqFO9EEVCiaVaN+8aIWSmvzBYpREw+KOHXqbjz1lYjF78nYUq8quJfKY2wR6V
	BwSkv5mB6ejnBhfDGcFjwXaJ+bDK1evAd4B9IX5IR5N5y5Kfo+SHdxzBH0sFD6VntzIxP8NI/Dx
	q1TFccSlXOPRfAcCv2gA+zvIoF/lGKKtF9oFkj6yF66m3YedymVuTZVKY58bIOCsLUym2EtiXK4
	HaRjVhsMNQ6nPlCrUclO+FVbkfhDKsUDBoJKZ6II2BmOLdNvT10L9A46FnBl79aIReOzj2S/600
	r
X-Received: by 2002:a17:903:3583:b0:242:8a45:a95e with SMTP id d9443c01a7336-242c203d43cmr8131715ad.15.1754603026841;
        Thu, 07 Aug 2025 14:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN6v2dbx8Buiz9mLDddezvlVyeMzN2wDlRLGfDM+oXmOvFCIoQRzS8Xs7yecMOzsLJVhDisg==
X-Received: by 2002:a17:903:3583:b0:242:8a45:a95e with SMTP id d9443c01a7336-242c203d43cmr8131495ad.15.1754603026374;
        Thu, 07 Aug 2025 14:43:46 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a917sm195015435ad.116.2025.08.07.14.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 14:43:45 -0700 (PDT)
Message-ID: <6e3e8199-814d-4969-a951-d6b60f60257d@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 14:43:44 -0700
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
Subject: [PULL linux-firmware] ath11k and ath12k firmware ath-20250807
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX82SGvDl19Y6Z
 HDQFQT/cI1E6X4x7T5+ysvfvA0OQE72zd6suoj9S05KjowbrPPfkQcnAVk81spwyabj7WFhm2Xd
 ADoZ1/LISHIoW11XIoIBLcIQ1BvjpBHhnmhD9F+IgbarJPCWM01UNCK3AtDFbMV33xlGiE2ksMQ
 eLzW9uirpRtRivctZNzmB8re67bD7Nqb1F9LsQUZ4M0Zj5fJmYGcKn2D+eEyeVj+e2pnsqkc846
 RemUE/HGEmEq3S/7kxRTwLUw+0In/WbIAb0nAQZaCwwOhqcnooA/vWDfJOaPaBlaiITTrGXO4H6
 4O5ZxFjfpdFrsentM+bADL+YHPTDUX/V6miL5aYmSj4ObY0yTJm/1M4z1qm5db9TKQvrboqKRIP
 zSm/NVGJ
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=68951e14 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=8Juthw4_Jig8fID-B6sA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: gahPgDsMAucPWTg86yJKygms_XUXl9rj
X-Proofpoint-ORIG-GUID: gahPgDsMAucPWTg86yJKygms_XUXl9rj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

The following changes since commit d30c7b425f6d9c9e9f54bcafa99b375342b3a774:

  Merge branch 'robot/pr-22-1754588181' into 'main' (2025-08-07 17:52:32 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20250807

for you to fetch changes up to 35abebaa15c1ff1a141b7c24d79220ef70f48548:

  ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3 (2025-08-07 14:32:02 -0700)

----------------------------------------------------------------
Jeff Johnson (6):
      ath11k: QCA2066 hw2.1: update board-2.bin
      ath11k: QCA2066 hw2.1: update to WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.9
      ath11k: QCA6698AQ hw2.1: update to WLAN.HSP.1.1-04650-QCAHSPSWPL_V1_V2_SILICONZ_IOE-2
      ath11k: WCN6855 hw2.0: update board-2.bin
      ath12k: QCN9274 hw2.0: update to WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
      ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

 WHENCE                              |   8 ++++----
 ath11k/QCA2066/hw2.1/amss.bin       | Bin 5349376 -> 5349376 bytes
 ath11k/QCA2066/hw2.1/board-2.bin    | Bin 685144 -> 745408 bytes
 ath11k/QCA6698AQ/hw2.1/amss.bin     | Bin 5140480 -> 5005312 bytes
 ath11k/WCN6855/hw2.0/board-2.bin    | Bin 6429240 -> 7056532 bytes
 ath12k/QCN9274/hw2.0/firmware-2.bin | Bin 15392824 -> 15183928 bytes
 ath12k/WCN7850/hw2.0/amss.bin       | Bin 6078528 -> 6082624 bytes
 7 files changed, 4 insertions(+), 4 deletions(-)

