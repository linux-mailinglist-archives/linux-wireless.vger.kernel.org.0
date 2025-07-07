Return-Path: <linux-wireless+bounces-24889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C87AFBE4A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 00:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30424A5219
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B1528A1E3;
	Mon,  7 Jul 2025 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T38S0Dti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B4824467E
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927786; cv=none; b=fX1FvMuU6OQEjfKlhpuL2CYiHtUHkYCHNjktE59G0qw0PMPIYiPMaic54gds4XPLpFfJ7B5nAzfXkGeVsX63Mk8EiS0MfmBZ7xysl4ZFM8k4+dCZsIwygU//oKt7W+GdBLAiUMAckQFqxN55jXcKrTNpRV/6D9yjrHvRDhXx+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927786; c=relaxed/simple;
	bh=g57NDmjdApiYO0i1txr4pJMMyDJSRR/GPoV+Qnb+YQg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AxfFMRgSs+D83IE/I52b6SnNjBtx+g+V5ssDLzrmOro7YJUnb64ASeeBNqbhVZDGrgRBBaI3MlY+MamD4JjWfpUEd7Mwp7vJ5ylcxAQSu6Ws6fdtWI7hK8DADJ8CBGczQIir0hmcq/k49jCdm77mJ7j7RAkEJWXaIZoyRWiF46I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T38S0Dti; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567IaWsm025860
	for <linux-wireless@vger.kernel.org>; Mon, 7 Jul 2025 22:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lc25Qjwnfvt0u2zQ9Wx0LQMuHkbZEWUV53BxT0Htayg=; b=T38S0DtiMHYGXEqa
	0xGgXLSxie9P+i/AWF5gueylp2Ig3fJVfHR648P+inyQoGX+whMPhVa2GKMQWpWI
	GGSN29ZEiytzcUXkbOnt/hVTKU/ENgBZg3J+49uRSdimtKuAwfiauK/BXO4eSn61
	5J8EpY9lMwSvwNxz3gcFE1EQVzNvWi2yDbf8NgcwZzKOhMXsqkVCr6KfZ4weAR+/
	l4H+pd01MOo/75gO2/fV2I4PnyYcoaWv/0VzGe2HKNdJNHrJkD7PCgr16yzYQJjV
	CLYn70pV/Yi1VWqjlEwLSvnaVZ08fW7FZWZCxL+MDHrEfV6Iv51VkjmpbOqbUYPp
	XE1I+g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pv97gpyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 22:36:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74913a4f606so2989386b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 15:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751927784; x=1752532584;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lc25Qjwnfvt0u2zQ9Wx0LQMuHkbZEWUV53BxT0Htayg=;
        b=wbTlSEag3lSiVH6+vV1qRnTra353Juv1rPXqLn1Hm5kD76tb1ct2D8dIddwCS9Ptqa
         2azC6D0FY6rzBRq4CGuM90zICpMWLcJ+sBm7crivePyrf9J3uriuoK6w4kDReN0eVU/V
         asMp1/Ep8Wp1LRR8BrgV8DWRmzuqTbQ4iSbX6FEOA+/0JVDo88FZ1TKwE89FS9UqUEqg
         lc81qmwuHKZ+tnti+NAQ3Il+adisb/f66TB69vpczzSrLCgJ7Bvalo/qV0Xi5KbDxB+G
         eFwHc9oKuxpa/2tvdtA3ZsdmU+Wbjn1k7b/N7HEDIX6DlKz1mJyKN/A0PWb7ZgSw4fgC
         f3ZQ==
X-Gm-Message-State: AOJu0YwJr81qJxOd2Zi3l3MpQ+l53M0oXACXVgLsGLAAWqu2BCNxIceA
	KW80mZQHgVOb+vnUOCbYDve5R+DQ8dHtkuk7d7ylr7sXKbls27x6mYI8Om0u2urPnQhbR19aXbj
	Ja5C0mrHRe7R6b1XNSyyRNqnx15j1A6EyuvSKoam3OFluh4F+dWiO1YadX/OnQCjRbSkkSA==
X-Gm-Gg: ASbGncvpZgwmwH3c8085XkH0/CQy9wSZVSGyZ6Ib/LCeH7qCbuIx5eFO7iEjk4fQTjo
	ujZPhP5PhtDXpIYKUCGU6WaXJcIwHMof6R49MywITsRkpuklowrGZATnl/g/GXIvkHfpCZcIL3/
	/z1Cw4Hl9PGiHiGxr44xs3IPrYyb7PCSzLxF9C2Jj8DKHQb5S4HPtxYaNzRFqBw8Gd3qU4sqDFf
	+nDQTbkAeJicng6W1qRk3IwV8Na3X7As/Lz8AwEIJL5iximf+shE+16fPhgl+bdcLhLqL/f9tQI
	Z3tZJnEpfxbSlM9SMpKSCsPvdrXlrP4R1hDbLsh7iTXb930Rs6e9mkbjqbk=
X-Received: by 2002:a05:6a00:80c:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-74ce6668f9cmr20162812b3a.15.1751927783637;
        Mon, 07 Jul 2025 15:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlQhC/FjcP65Oq+8yL/bUuM4aCJUB8cIi03p6MIQJcq0lGnx4KtSGyvPSbuS9hy/72KTpzPQ==
X-Received: by 2002:a05:6a00:80c:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-74ce6668f9cmr20162788b3a.15.1751927783220;
        Mon, 07 Jul 2025 15:36:23 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee6358edsm9668064a12.58.2025.07.07.15.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 15:36:22 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250630031502.8902-1-aaradhana.sahu@oss.qualcomm.com>
References: <20250630031502.8902-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Block radio bring-up in FTM
 mode
Message-Id: <175192778247.314276.9568519823635230808.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Jul 2025 15:36:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=FrUF/3rq c=1 sm=1 tr=0 ts=686c4be8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=wy0no3_6c23iQZEdgM8A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDE1NSBTYWx0ZWRfX3ZrgVlM4aPbW
 JU6lq5+vxF2Rna3g+yDPZ5Fpcse+hnyIjqInworFnNXTRZQOwuosqMHdbgVrIYW+iR2OQSp6uMQ
 CiYeum4tJqAtLGuSO7gLVsIKWNOun/JNrT5woM2ipdQF1gyJY036vMu7ytkfSxw987EqiBSgyHO
 FnBY0Z7iY2k8AZdjkwpKh1ZaDqzK9u3hHOqGlwqMVNlv2xQaUbVCa7JyTrFzWF+FBfROkncGiM3
 PkSm3J1UCMxYwWCml6ttBH9PJc/dINBD0bPGF3lP3pnt/0H0X/m8VDYVYGPV1+U88VxXv0LFpp3
 eBwlE12WwvVc/ZRxeTYupC3pUCyoYJUCsTeopKy/HmhvmwCguFMHOv9LZsqZJnJ7Vgxp4NRmGUd
 20Yd0gBZ31QEcRbFkx94CSG9RRM7p+cCTw8RhkJUTFu1xv6f6ENnHialHlHxVuOmzA2EJ9LU
X-Proofpoint-GUID: LW7e-QfaRVMwlM_IJ4ny9WL1pBI0x8h-
X-Proofpoint-ORIG-GUID: LW7e-QfaRVMwlM_IJ4ny9WL1pBI0x8h-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_06,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=748 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070155


On Mon, 30 Jun 2025 08:45:02 +0530, Aaradhana Sahu wrote:
> Ensure that all radios remain down when the driver operates in Factory
> Test Mode (FTM). Reject any userspace attempts to bring up an
> interface in this mode.
> 
> Currently, the driver allows userspace to bring up the interface even
> though it operates in FTM mode, which violates FTM constraints and
> leads to FTM command failures.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Block radio bring-up in FTM mode
      commit: 80570587e418f361e7ce3f9200477f728b38c94b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


