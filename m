Return-Path: <linux-wireless+bounces-18545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97968A29A51
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 20:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11006167FE5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178A205AB8;
	Wed,  5 Feb 2025 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gOBngM1U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D61FF1B3
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784559; cv=none; b=mLJWhBVwxIqiOsl7QGBPBW6QGc4T+pV49d0PL9j54C+UPt6wD9/S5CoMI1doJRpOPU6C3EEBIU8tiYSWhpqCbL0bb/OlC8wzGk5xlE6LHw6J1DQ6A3kx7yF0qVz61+FccsD1feiokGskNeanBVaMZSQaTa9JV1HTTdM3FfY44Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784559; c=relaxed/simple;
	bh=PmMfshh5THC8MfMQz67iu7Oa5ccLmDis8+ArJNdIu/s=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=SgvRyE6mp9rGvN5BdElpvob2tr9pTNSX8KyzCi8USOVOkJ2cc2vWNyGCTH7uVb0Z+2I7PLLJQvBG0wDQiZ0edMDOtQa/YxuqJIauMoQKCux6xCqBsMMQbVLgyDsW8wIOklHhO0O2n1t/qVuqUO5rZJonRb+KC0xD7n84CKnp7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gOBngM1U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GNd6W025753
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 19:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U89NaUs2hFzdVum9QFeTZv
	vj2h4vjXk6YXjDwpodyZg=; b=gOBngM1UmtXsNXEgRTgC+F06435D+fmXvuvhZK
	6msXg54TYygMRm75x1lriXI+4G/0VcAgmoDI0BeqoBMBEkAn4j1hpfZkKeDsjyIW
	Ed0ry1jEi3QHzL2Tk0Z4ALS699NpnJD9QyTVx5EtjtAi/7A/Dgs0lVuhULe4ajaB
	k1y45DqI1cgWdfhtcpAs/aohoWnxYRFR5KpnPrZBuaZ1HVvYH1LD+2he+bR5qm5Z
	wWNyQu6mxHI9Z41yGvYeT96wbO+3G1y9bLD+UugXJjdJw14LiBPg8gJ9aRDFesaf
	ULLReFsySSU1iQ9nn1QzRH5dvBIuLfJZ5oKukQKj8glv5x6w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mbfh8ffq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 19:42:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f9f90051a2so125835a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 11:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738784555; x=1739389355;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U89NaUs2hFzdVum9QFeTZvvj2h4vjXk6YXjDwpodyZg=;
        b=BJKDNKjVUF1l7gtuHqcpj3tBBttMUIhSRO0xGngsYSeUD+1kHjHKCf0ypShlJQr5JC
         X4ZaBeFcmU4+0hvlm+t8Jed+1OcgtbNXdtGiSoP6k5ZKFdQhi4b+m7zj2vvSFN4GbVPL
         CS2PcLcZkD+1tjWXQ4uPTUpIu49lUn0UqwMXsCMj+W+pFGiraup9U/F6K5fBaA3qPXse
         iPskDB/R/f4ZNCQoH4s1/r5/10mFrdBbMhPQQ3M48L8qE3cet5XKdqtzbFlTwJIyh4pD
         MADm+jRw+I6/PINPgOgD1nYdqBFRiUtn6tWW8alOxuFv4/c0+c1vtAxNpjXBj2zU+smR
         MPWg==
X-Gm-Message-State: AOJu0Yyp/H+qTqoM+n7XgelhNEHhV6cG2kOqjtVs4fjmsxHa0mEGkWCC
	sMTzezd8lsFeBRc+OvF0oaW8/sqzXNh61RM+yn+ZKwxr5pQ5chqY8ZuUl1W2mtA9Q8LtfNaeYlv
	1acetwbkNUetetARrWeoFZmN1RSuvIMG05JqoP0aLpPztASTeGKp+3x6h1LCsLbrqKQ==
X-Gm-Gg: ASbGncuL+pz0YRb+riq8fThEG5/cZLYln/hHYCa/Joa2r4LISWxdwK4Q2sfW7yyVr74
	LvftB8xCH9IzjhWctr8XA07S51S1nSm+4YD++elg3V3/Ha9p0+4LBPF4ZSK2sy5BPPOANT+4m4c
	QAJXrHUC0g7zj24LrVaow8RuV57wXH9syY0gUJSZQqFdvWZdCHdYai6BPSSqU52WOP18N3m63P4
	4Id/TvhfQqOwRQK9/5/2Qpq7aCKrOI7nVn/wktcjmH4OUzTeIw2IPnXRicqrRUxbnArX0c+03F1
	roaqQGoP36Yzyl6BpQ/RunXzdrK4phnSAE7R0k7CoCrg92SSd7rQrfDdo9lV
X-Received: by 2002:a17:90b:52c7:b0:2f8:4a3f:dd2d with SMTP id 98e67ed59e1d1-2f9e07846b9mr6703874a91.15.1738784555055;
        Wed, 05 Feb 2025 11:42:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF940SS5ltAjpQDKtK9E1zhSwIPpVcHL52+Reu9zJb0T1PN07OyPNgW0Um7KDFL1mJymnS5dQ==
X-Received: by 2002:a17:90b:52c7:b0:2f8:4a3f:dd2d with SMTP id 98e67ed59e1d1-2f9e07846b9mr6703834a91.15.1738784554649;
        Wed, 05 Feb 2025 11:42:34 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1d89b9csm1978812a91.27.2025.02.05.11.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 11:42:34 -0800 (PST)
Message-ID: <9be8cab2-02d0-40d2-b69f-7cb3095249a9@oss.qualcomm.com>
Date: Wed, 5 Feb 2025 11:42:33 -0800
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
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PULL linux-firmware] ath11k and ath12k firmware 20250205
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: khHLqiQwUgvAkZIBT4lXvmWgA8JTESwT
X-Proofpoint-ORIG-GUID: khHLqiQwUgvAkZIBT4lXvmWgA8JTESwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=861 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050150

Hi,
Here's a new pull request for ath11k and ath12k.
This includes new ath11k support for QCA6698AQ, updated ath11k board support
for the Qualcomm Robotics RB3 gen2 platform [1], and some board and firmware
upgrades for other ath11k and ath12k hardware.

Please let me know if there are any problems.

/jeff

[1] https://msgid.link/CAA8EJpq=QRbWe6KTxcmHkHp20rgEgLZeGYV7+Hy2Qkfo_MyV1g@mail.gmail.com

The following changes since commit 7ac1fc5f254d8d97a1aa96360c23f0659addb047:

  Merge branch 'make-deb-fix-no-such-file-error' into 'main' (2025-02-04 12:31:31 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20250205

for you to fetch changes up to 99720d02248f775f952a97455ea3b3a687196a50:

  ath12k: WCN7850 hw2.0: update board-2.bin (2025-02-05 11:26:43 -0800)

----------------------------------------------------------------
Jeff Johnson (12):
      ath11k: IPQ6018 hw1.0: update to WLAN.HK.2.7.0.1-02409-QCAHKSWPL_SILICONZ-1
      ath11k: IPQ8074 hw2.0: update to WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
      ath11k: QCA2066 hw2.1: update board-2.bin
      ath11k: QCA2066 hw2.1: update to WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
      ath11k: QCA6390 hw2.0: update board-2.bin
      ath11k: QCA6698AQ hw2.1: add board-2.bin
      ath11k: QCA6698AQ hw2.1: add to WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
      ath11k: QCN9074 hw1.0: update to WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
      ath11k: WCN6750 hw1.0: update board-2.bin
      ath12k: QCN9274 hw2.0: update board-2.bin
      ath12k: QCN9274 hw2.0: update to WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
      ath12k: WCN7850 hw2.0: update board-2.bin

 WHENCE                              |   15 +-
 ath11k/IPQ6018/hw1.0/Notice.txt     |  419 ++--
 ath11k/IPQ6018/hw1.0/m3_fw.b01      |  Bin 6712 -> 6712 bytes
 ath11k/IPQ6018/hw1.0/m3_fw.mdt      |  Bin 6860 -> 6860 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b00      |  Bin 340 -> 340 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b01      |  Bin 7000 -> 7000 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b02      |  Bin 4696 -> 4696 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b03      |  Bin 2602320 -> 2606416 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b04      |  Bin 386016 -> 386528 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b05      |  Bin 202532 -> 202532 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b07      |  Bin 9912 -> 9912 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.b08      |  Bin 464564 -> 467388 bytes
 ath11k/IPQ6018/hw1.0/q6_fw.mdt      |  Bin 7340 -> 7340 bytes
 ath11k/IPQ8074/hw2.0/Notice.txt     |  419 ++--
 ath11k/IPQ8074/hw2.0/m3_fw.b01      |  Bin 136 -> 136 bytes
 ath11k/IPQ8074/hw2.0/m3_fw.b02      |  Bin 327680 -> 327680 bytes
 ath11k/IPQ8074/hw2.0/m3_fw.mdt      |  Bin 284 -> 284 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b00      |  Bin 340 -> 340 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b01      |  Bin 328 -> 328 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b02      |  Bin 4696 -> 4696 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b03      |  Bin 2978704 -> 3215248 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b04      |  Bin 982944 -> 1000480 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b05      |  Bin 248260 -> 254596 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b07      |  Bin 10112 -> 9960 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.b08      |  Bin 504104 -> 596768 bytes
 ath11k/IPQ8074/hw2.0/q6_fw.mdt      |  Bin 668 -> 668 bytes
 ath11k/QCA2066/hw2.1/amss.bin       |  Bin 5349376 -> 5349376 bytes
 ath11k/QCA2066/hw2.1/board-2.bin    |  Bin 685144 -> 685144 bytes
 ath11k/QCA6390/hw2.0/board-2.bin    |  Bin 115984 -> 173980 bytes
 ath11k/QCA6698AQ/hw2.1/Notice.txt   | 3658 +++++++++++++++++++++++++++++++++++
 ath11k/QCA6698AQ/hw2.1/amss.bin     |  Bin 0 -> 5132288 bytes
 ath11k/QCA6698AQ/hw2.1/board-2.bin  |  Bin 0 -> 866120 bytes
 ath11k/QCA6698AQ/hw2.1/m3.bin       |  Bin 0 -> 266684 bytes
 ath11k/QCN9074/hw1.0/Notice.txt     |  419 ++--
 ath11k/QCN9074/hw1.0/amss.bin       |  Bin 3963336 -> 4227408 bytes
 ath11k/QCN9074/hw1.0/m3.bin         |  Bin 340108 -> 340108 bytes
 ath11k/WCN6750/hw1.0/board-2.bin    |  Bin 843548 -> 927980 bytes
 ath12k/QCN9274/hw2.0/board-2.bin    |  Bin 292160 -> 1308544 bytes
 ath12k/QCN9274/hw2.0/firmware-2.bin |  Bin 15224888 -> 15392824 bytes
 ath12k/WCN7850/hw2.0/board-2.bin    |  Bin 1897968 -> 1986952 bytes
 40 files changed, 4136 insertions(+), 794 deletions(-)
 create mode 100644 ath11k/QCA6698AQ/hw2.1/Notice.txt
 create mode 100644 ath11k/QCA6698AQ/hw2.1/amss.bin
 create mode 100644 ath11k/QCA6698AQ/hw2.1/board-2.bin
 create mode 100644 ath11k/QCA6698AQ/hw2.1/m3.bin

