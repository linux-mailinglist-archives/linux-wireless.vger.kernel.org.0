Return-Path: <linux-wireless+bounces-27504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8812B876A0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BFF1CC0AEC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94E02F5307;
	Thu, 18 Sep 2025 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pgaQoYQ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF922FFF98
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239254; cv=none; b=iCsqhETVASAqH1z6gLX1Yn4EnG0mWNmSKa0v3rdyl4fE39MpXZQ4V5bO2nuks7p6VDz6/shkaa/Ng5SrKFG08e8lFHjrZ2eJDfgBcY+di9bR+eL8tDn1tHSJRj6nw5MdIOsd/MRSyCa+GLeAxctoi+g24JQWXn00UHcpl0HQ1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239254; c=relaxed/simple;
	bh=cBGZuscuDukNyi0JgRH/8oaP2V79tCI1mvkhNd7G1Wg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mPU0skdqujtXG4FZNCNKphns801PkjTLftkQ/+m3Uuw+D6bOT2IfF7CQoiPHI3VnpKKBcXycEZfDc30uWe3n1CJfC13AAs0ITG0B0sIyB181xPpW5/LZmdhwVQWpNpZQgeA+6wFcOeHOQ6ad10nfY5jx04DDn1Q2kXKHKlKrebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pgaQoYQ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IJCDav029741
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sfBCOxsmUp/2/EBHlsYVe+MbALmMUe6mc4/e76b2WE8=; b=pgaQoYQ3O9pJSf9S
	9BuIB+FCVNZ0u9I/8timtMSJZFLv1QTxkvexG/POe+Yh5tFf74rFkRd6bCxKWhlj
	uo2Vw+kuyjRwtS1eVwOR9/qF7OP+Oq7uvoxigNgxWzk5zeXJkfWVBlHd+KTxwL3D
	bk8oMUnjtcpSRBAwDK6DbQf33tJ+ZoWRkKAPuI/kcVQnnfoQ+IVJHF1SRP+frMrI
	v7ES1u6lRKCtDtpzUCp3Ty4XfGfSaXLcQHCteRem0DriO+i12Xa6jlfhoeI8mgOC
	L6AhNFndlYmC/7AuziEyVpYR5fakPY9z1/UGon9GH8BWTVAEs2iPdCOsX0SxI/Ji
	die1Ow==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy10bh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:32 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54d6a67b5fso1176893a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239252; x=1758844052;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfBCOxsmUp/2/EBHlsYVe+MbALmMUe6mc4/e76b2WE8=;
        b=rvDLt4PePv4GgBmXOS2buFD3qgzoIkqrFOl8ppbdP75cIBrPOPl3D4G3gf+oxC7uV+
         G3fhVVrpdiFsa1WWb+7YL6NXqX2HfLhVxRU4jCLO/UiIHjWVycVDDEIu1jD3txO5dBDT
         VTnS0Osrm9fsODSMRAPOOjA8/iRkLy+A0qixcYAAOEsCX/DoGxEBQqc6Qx8GDtXXmu2J
         bew6MuwPJ9LU2yoM0MNQ8JblSIGgIY9kPs7/VTMAwxjzg6NH0tKXKPexsNCerI6Ib06Q
         dgQzDqcjCKtQEptAmeM3HNkXe2KBWB/kcx/fG1uV0PhHye2Sw3vNwMi7VDiDsY4TtX77
         /yEQ==
X-Gm-Message-State: AOJu0YwL+hd4/aWIDzMuqwCGrpYUxEu0d/BRw6JajhZ9uWLCKz6ITVsJ
	YWwBTs5x1m15xBzpEhxYYsa1me/ZBpuC8Ro6LesEjFIGIR4flsKSkDtb1co4vtNkXp8sV78c6F0
	JDCjQ47UZBrDNxopFLaeyO0pSnT8tT/hX5TKSOUbPaiVIXc7RJoF0xULOWLTDatxiNixLNQ==
X-Gm-Gg: ASbGncuuITaP8gkRJ8PMa+QZjCnIvMBtkEmVTjsd4C36+tTkdzoglU7G8o1qNN3hU86
	yMiJcJQLHX4sE1xHBe+idY7Dej+NhyOSc02Sz+cr/w0lsh6ZHNcYL02p4cFJ4NyeXCO2SaB4rbF
	Eoj2y/HL7lI8gZUe9AKu2qoMdZW3WaFDHbu1Ib8HKmzVNZR83MpnEh5U+vAoPNwWNMgvq8teUgr
	fjVJ8aeHRA9X02EkQvXE4y/vySuC6Xs952LA49YnAupc3AW0xkoaOzG8BZIlhkjk8oX0x4za8Qn
	qLxc+j1xv5YhQOQDrpPfBGQmeF/TWMC0NuViQ2visIAEYFy+17cXotANEuckULjgzdqd5Y9S4Sd
	K
X-Received: by 2002:a17:902:e852:b0:25e:5d83:2ddd with SMTP id d9443c01a7336-269ba53b173mr18945135ad.45.1758239251609;
        Thu, 18 Sep 2025 16:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA3WQUIIMtpkiOihE1sln157kiET5utTKQK9PpBx3bINnG9HfeC03z+T6rglBJpRSFoZSttA==
X-Received: by 2002:a17:902:e852:b0:25e:5d83:2ddd with SMTP id d9443c01a7336-269ba53b173mr18944755ad.45.1758239250989;
        Thu, 18 Sep 2025 16:47:30 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:30 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Lingbo Kong <lingbo.kong@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250812030044.688-1-quic_lingbok@quicinc.com>
References: <20250812030044.688-1-quic_lingbok@quicinc.com>
Subject: Re: [PATCH ath-next V4] wifi: ath12k: report station mode
 per-chain signal strength
Message-Id: <175823925027.3217488.12177583793625956584.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 17jnXmLu1ieXVVFu8k2iBqNQO9iHqvMZ
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cc9a14 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=D-nDFYWG9Ph8EzAAE28A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 17jnXmLu1ieXVVFu8k2iBqNQO9iHqvMZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyJoushbkUdQI
 VkFhIx74dqsFXy3eADUS24zAplGGiRYBDd9oYMXWaW+XgBsifyI8h5dv5yG8ShmngidEwzfHZ4L
 kSrJD/vwD1hYunUVFXP4ybBmmFaQ5V2wr/r2DG0lQPZmJYkOyZCVgnfbHxYb3ZpU1+O/9pcWuyV
 eG1it5bxRXJsixXnL95i/bGGzUjvauvC/34iQOeDLPc8WPnF/VnxZnaI3SVw6ZntgH7SaMVRTkM
 UYXpLPi96fqbH07WN3J5Eh1bmVyELSegqg/ZHRizhsCuOJRwnCxjSKpEf5J1NRfY0VvZIMOC3Yc
 FdmrDgjQYc+1unscinmJY9QDIneBYkTQ87bP0Y995hRkat+mX8glVszQ/VkItofdigjKQ8YnGRd
 qTVu0ex2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202


On Tue, 12 Aug 2025 11:00:36 +0800, Lingbo Kong wrote:
> Currently, command “iw wlan0 station dump” does not show per-chain signal
> strength.
> 
> This is because ath12k does not handle the num_per_chain_rssi and
> rssi_avg_beacon reported by firmware to ath12k.
> 
> To address this, update ath12k to send WMI_REQUEST_STATS_CMDID with the
> flag WMI_REQUEST_RSSI_PER_CHAIN_STAT to the firmware. Then, add logic to
> handle num_per_chain_rssi and rssi_avg_beacon in the
> ath12k_wmi_tlv_fw_stats_parse(), and assign the resulting per-chain signal
> strength to the chain_signal of struct station_info.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: report station mode per-chain signal strength
      commit: 6af5bc381b36282bb90c649c1edcc3396a6cba99

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


