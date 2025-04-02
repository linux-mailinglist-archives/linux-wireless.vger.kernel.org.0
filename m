Return-Path: <linux-wireless+bounces-21081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E36A791D7
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614F77A36F0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D996323C393;
	Wed,  2 Apr 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRkK4sQP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F2238D2B
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606487; cv=none; b=X0fOw53xqV5+mnnWXmDjkfDpuAcMou+TA5uUTQqPsWX27T42U2ReIlMz8flWvr7f/ov2PRKvb2kDlIt638PPMhqzi8U13xfJG4jtCsjS63CRacWbdK862vM0QRigHfnBYhTu2SajQIGEuoHLeM37oj35KQCVVevwHiSp+2q2y0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606487; c=relaxed/simple;
	bh=k3E3hHhMb+3Tt8rz9w2IYBzpmpuRowfDvMHRKUijeNo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fynMGqt9OU5RA5wF07TAe455PiJRowJ1QNYH6SnM3yDrOqyt5WT/aUInW6ILP33P3yeS4DftatMJBrOLNDCy9N4xJ/HX4t4ltKOV5+8FkrqCpQtkx543zyxRMiHFbzchygiLRoRHveE80NL+YboUvpGKAh+0qvLQSIil+obCzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YRkK4sQP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532CGRJ8015653
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 15:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tBteceZY1Uo0YtSu4ojswwk/m3kIZQD/mSdFMya/H5g=; b=YRkK4sQPaW1t8Pdp
	F7MTH0HKb0xF5B65X0v+ejXnxlJQCJXd48bVQTW2CjNE2R88XpWMxE5N09Mrs0TE
	iPpz9bVO96G6ezlDTBPlTW9hm1XPKbtPUjYYx2pzeuqRsUi1g8TII5skEv8gdc5x
	zpkE9C3oW5o/CMLPVo6HHlDU2t9MxFCHsABbzePGWSxjiVghwDN0B/NU2rM1978u
	URcsZk7il2aL7akuniBuhz1Jn+3BPoG6JChC0scXFoVoo8/eAtZj9q2+HNibYnyX
	1vRrDHrqkQKMu4fatKcZnwtvJQQ4cxO4dtTeaCSAmd9+D9n1Q4oDou9flbxJsdhN
	dTaqvQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p7tvkuc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 15:08:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-229668c8659so17180805ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 08:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743606484; x=1744211284;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBteceZY1Uo0YtSu4ojswwk/m3kIZQD/mSdFMya/H5g=;
        b=V1wzwbf19EhcoOxqShcBQ+LLWT0uaE7BrlfrUvcIH+ePOyQl4MiiWTVX1Mi36aam/0
         djSpVMoLroVKEFzqIZ8fIhBH2LxLDN5Jq0p9+/jvdHj/tj1xJxWqUvKKFZJoj7flecOn
         bXUi22K7++G0YCLCfobcQxQEuefJ2HNTDQwph9sjXZGbAiQlI/VuD0kC17E/Q04VdFr1
         nWSDTkHG+aq/S3zYScsPjRqH/Ebbwf0ED4CqjDuk2E82agk/avGCHwj/WW51FOIIclcX
         xsIFc6nY5UXhYPVIJlphvVVV0vEdZRsRcbgGOOHOYW4HTZm5zIdbC8DgYKuBEGCvSfMP
         ou5g==
X-Gm-Message-State: AOJu0YzHLwlcqk7mmiB6V1zJ7nUeUqBfZ0gxw5mx/uPqzUtjsM6udkIr
	SWOuWcbqix2M5p2LzSvdlPk/O3yuarh6Eg0lWkV0dEp7nfwjKpa/8VGMFKzng7LV5YKh+6A1P/g
	bZ5luF+cG9f3wV4xgfxM9VycTRT4DzrzrkD4Y1wacHuxqTRt0r8J+xa6U6Qe0NM6GEsbFlSedQw
	==
X-Gm-Gg: ASbGncvPqeyfVSBI2siCnlF7zhA1qxPn+yghXUnw2BL9VjjC12b59tmtPcE0xnwVWjn
	jRuF4Vi4TS5yX5mHh62ybTWnRc4+iWjZ6c/CXhYKhLqZPBBLsuriyW4Fn1FiaFo3QPiq900q3nS
	krEnU06Zi8ZdVMMN+wbNa65l9XEVA8QD0mQlzL/GXptKv7ZiGQLnXFOsc96UbVvzOozGzrelJ+9
	ZHrkSe68g2f4yZiT+22//svoYEjvJG4PVxkNKmyxmMj8wvGBF/mOiqXTJyCBgqMIKLO2CCNFtCd
	klAjO8LKGPAFGK+FLCKRrCMHCFw2BTOnCXE+D+rePp/bZZQlKOxm
X-Received: by 2002:a17:902:e549:b0:223:4bd6:3863 with SMTP id d9443c01a7336-2292f944b79mr284775045ad.10.1743606484148;
        Wed, 02 Apr 2025 08:08:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzN6HUSqwjsovI0Fsv36UQmBNgWvtimWXt/ZpE9qA6Cb4hWs2jNAUSwZbA1otDdmWBCpfUXA==
X-Received: by 2002:a17:902:e549:b0:223:4bd6:3863 with SMTP id d9443c01a7336-2292f944b79mr284774195ad.10.1743606483353;
        Wed, 02 Apr 2025 08:08:03 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eedc988sm110193905ad.59.2025.04.02.08.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 08:08:02 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250401173755.1982382-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250401173755.1982382-1-maharaja.kennadyrajan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix spelling errors in mac.c
 file
Message-Id: <174360648262.2001642.9731556374991458213.b4-ty@oss.qualcomm.com>
Date: Wed, 02 Apr 2025 08:08:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=OIon3TaB c=1 sm=1 tr=0 ts=67ed52d5 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=2oqTpBN_-z7nGWg3eNkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: _v7HoTxpxmkOxIBXS0UK2clWc9OCc0R3
X-Proofpoint-GUID: _v7HoTxpxmkOxIBXS0UK2clWc9OCc0R3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=681 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020095


On Tue, 01 Apr 2025 23:07:55 +0530, Maharaja Kennadyrajan wrote:
> Fix spelling error correpsondig -> corresponding in
> the comments within the file mac.c
> 
> Compile tested only.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: Fix spelling errors in mac.c file
      commit: 15293c1829d897065295750f1c1987f0ac82a890

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


