Return-Path: <linux-wireless+bounces-22025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A74A9B950
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 22:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670839A02B6
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39C421D58E;
	Thu, 24 Apr 2025 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P3g5oAkB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59021858E
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527117; cv=none; b=oMARabZmiVGTZygw0DNTz9FIGf/CPjKJe/huSCEXmiNM/K3Hm7RpYdj0e+32HL7oj/gdDSpdBAyPWzNlmQz32ywpP3Ywv0jYH6hPaFDVw0a5a4rpz98clPIVuCbTS2yNUnTnxCW+ZP0ktSBqH5Cbrf3IHYxJMNGngPQrO9WD3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527117; c=relaxed/simple;
	bh=mLuk/U28rf32SqPThUPmlcRROpbyMDSlWH8J5N1Rg8U=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=YA8F3FP6Hz8rSYOeqNNN0GHO4QpuQVGCSiGD2dR+Ibe74Vp7Ki4+8HDbKctVRYl2gS+Lhk5cB03GmaSISrPVqWic8dGgsVXrMRYsotMm9b861Xt02q3pkcJM+RwULGi2OYlXQAhKmF2XyFdSwuPO8UQvG7MAssGScuFIjUJfK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P3g5oAkB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OJnAow026483
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 20:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3SyUdMW04qFzJTxNWJA3RW
	A/E6h9+fNCuPWqTh3yVPA=; b=P3g5oAkBsV1IAXrv8HnNnqAx+ErFnKAahxINog
	tGIaFdmAdSuSDV3FZ5quSVhVN2OX383ZTCVUlw507TfRBtah0KLnR+AyMnWop3Dh
	eFA92Ue/LFV/qfwyR1TUxsMG4vp8aopV8fBkLyRkyY8kNytNyRSv1fLOSeroDHFm
	yyXrahfbO9OScZDyndn5g6sVN4v5Dz+fpe2CkNlBC1nDZnTx83n9BtBi17S3D/TZ
	I4sHxi9D/7IoRLgoNAOKlkIh4I90olsIClgSkodnBoxXDqltbrvV8KVX3PZVIv0A
	AF6GAIVgA11PNLZiqSlyX2QEqBQh2vHK5H0+HdN69BU8XLsA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh16sb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 20:38:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224191d9228so16853495ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 13:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745527113; x=1746131913;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3SyUdMW04qFzJTxNWJA3RWA/E6h9+fNCuPWqTh3yVPA=;
        b=MJTMXtU1BzV1q6MC7JgiidMssVbOPNs1jfGAl1erCGh+/e9RtyZNBBaAX51X/gvvNC
         sDw8KXr8FcliwRhKCHWQtqE7pYXR5e6Oz6DgeLSQmCpC4AyvmwYk4so4TC2734MRJH1F
         b4uu12jN5lcVr3gGdCkQjRKcogb6gSdhDsbMed8jKwd3+BqhoTfatsIhmPsjmWncYBGG
         wQKJm5/Ls9iE0hh7J5Dub3yKBX9fZgHiqa8gQc8hj96O902/5MyDEo4ELLNC11dIjOB0
         QIqiZMJ5TQ2Af/CHKC1uHLMj2rxui0CWk7naRawAT0S3z1vEW+4CvjkAc6fcEO9A00Ol
         7pbQ==
X-Gm-Message-State: AOJu0YxcSifi9HZKG5uPgMDqN3WEmISMQBOPL00VrBAWjtmMtLFq2tLB
	ZFZwoy8OcPjNin+/qCAMwq+DTIrpRLpUitSlHVdr0ID/wdVlqrRRHm73gET+tdAunHNRduaXU4M
	nx3Yziutr+5Y+eH+C9A11oIFZCPtSVTqcnqZT/02azKwQKqILQkN5o9qtA2gGnQMOeTgI8S6jBw
	==
X-Gm-Gg: ASbGnctkYTDADI67UntRYeEO4FWAsxN3DEResAymjFdpxDUFy7tFVKiC5OeFXuiS1CG
	8rMEUCKhI2PYujedamdbfEqwGG4hwBlZWVqoyM/dUKf6Bg8g/lo8zFXWIxU+s/IrkpQCnZsrKR5
	Hqqn7L8iy9YteWXbnOhYeXai5SSudESJMhyZ6BGo6ZYHiArECdoWGdDTg/35/WeTe2YZsIgSeeV
	3o39Ip7HkkpZBXcN8nnbywtc139jUJqbgAxFdz+vr/TnG3WbLs94YoojpVVQk48xnJKwtEOvI7t
	57ZDmzEUauOCUoySP0zp23P4wMRtPMN/SwrM/U6Q+0e7yEFxLSBM0aqgW/vPJaOwQA3sRlnMF25
	U1Vvs
X-Received: by 2002:a17:903:1aa8:b0:224:23be:c569 with SMTP id d9443c01a7336-22dbd423f55mr14612065ad.22.1745527113299;
        Thu, 24 Apr 2025 13:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOssOO9EMlEhSWXpnlt0d7EeCfY5WHRuv9lpuIv/YQVdg/51RxVXr3vI3U4gwYL/f1Cu9COw==
X-Received: by 2002:a17:903:1aa8:b0:224:23be:c569 with SMTP id d9443c01a7336-22dbd423f55mr14611775ad.22.1745527112895;
        Thu, 24 Apr 2025 13:38:32 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a8dsm18088275ad.136.2025.04.24.13.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 13:38:32 -0700 (PDT)
Message-ID: <96b43d18-72e1-44a8-bf06-6a22fd012b07@oss.qualcomm.com>
Date: Thu, 24 Apr 2025 13:38:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org
Subject: [PULL linux-firmware] ath11k and ath12k firmware 20250424
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5rqrvDUnjegXulLlRlYLi_1R8OarxLGx
X-Authority-Analysis: v=2.4 cv=OY6YDgTY c=1 sm=1 tr=0 ts=680aa14a cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=c5pCFXJUQfKAI649l18A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 5rqrvDUnjegXulLlRlYLi_1R8OarxLGx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE0NSBTYWx0ZWRfX+UHlEU1WgxEP xZ4lgOl9LtTvHnzDG0V1rBIVTQWyz+f38hTBhKLdrP7GCT+XXA6QBdt7ZGCm02RWNQJ2UwdJuiy SfboZelL1uO36URP1MRY3q+0h8SZn+nGc0aLPh1Hc2mVbDR4O/VBaHA6Oceah38Vdw3qSxVezu9
 tSBAP5gFowTXRdocvwZo/uCTaATCxlU5tL5lch3eOrTSfT6DQfIPZ0Va8scq2ED37HU0eX1Ewqi gOFtUPQ1XTv3vav6O5w0Z6w/c0nSxM99HatyKrspsutSK9MCKfLSGFG9p+xtpvoK5+JeZ0pFWQO MTY0CeJw+jrOOShwgolZPUTxd+HPeZsu489Ps+kqYq7KZrSe/jsEQpFnaTQbj3Hmv4L6LZcpHZd
 xsrImLthDlVwwMSQRbgtTNSnzMuK2arzVai7McFDCfptBjWI+G8cf7EfgAPzKsnNDFVDltEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=783 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240145

Hi,
Here's a new pull request for ath11k and ath12k.

For ath11k, update the firmware for IPQ5018 and update the board file
for WCN6855. For ath12k, update the firmware for WCN7850 and update
the board file for QCN9274.

Please let me know if there are any problems.

/jeff

The following changes since commit 490c0af1d6b9ffca0523edcfad27ba483b9d6da3:

  Merge branch 'robot/pr-0-1745490027' into 'main' (2025-04-24 13:46:05 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20250424

for you to fetch changes up to ce13d29c3933f77674cf45855668485c48d3eba0:

  ath11k: WCN6855 hw2.0: update board-2.bin (2025-04-24 13:04:20 -0700)

----------------------------------------------------------------
Jeff Johnson (4):
      ath12k: QCN9274 hw2.0: update board-2.bin
      ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
      ath11k: IPQ5018 hw1.0: update to WLAN.HK.2.6.0.1-01300-QCAHKSWPL_SILICONZ-1
      ath11k: WCN6855 hw2.0: update board-2.bin

 WHENCE                           |    4 +-
 ath11k/IPQ5018/hw1.0/Notice.txt  | 3918 +++-----------------------------------
 ath11k/IPQ5018/hw1.0/q6_fw.b00   |  Bin 532 -> 532 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b01   |  Bin 520 -> 520 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b04   |  Bin 86788 -> 86788 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b08   |  Bin 4096 -> 4096 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b09   |  Bin 2334720 -> 2334720 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b10   |  Bin 269220 -> 269252 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b11   |  Bin 99456 -> 99456 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b13   |  Bin 7072 -> 7080 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.mdt   |  Bin 1052 -> 1052 bytes
 ath11k/WCN6855/hw2.0/board-2.bin |  Bin 6429240 -> 6429240 bytes
 ath12k/QCN9274/hw2.0/board-2.bin |  Bin 1308544 -> 2626240 bytes
 ath12k/WCN7850/hw2.0/amss.bin    |  Bin 6000704 -> 6082624 bytes
 ath12k/WCN7850/hw2.0/m3.bin      |  Bin 299660 -> 299660 bytes
 15 files changed, 315 insertions(+), 3607 deletions(-)

