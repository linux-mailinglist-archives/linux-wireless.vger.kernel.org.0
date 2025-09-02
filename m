Return-Path: <linux-wireless+bounces-26956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72D4B41047
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 00:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDBC3A2493
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 22:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F66263C7F;
	Tue,  2 Sep 2025 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mlf/Ws90"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D81EE02F
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853217; cv=none; b=YFHFkPNqOQQSATtMB6RatYKCK3dJoQ8amdo2z0K1po6ovcPXaz2XsttF7Hwop6szBe83Q+hLi1KfNIxaXyzC14vhh3vgF9JgeBWKMAWTP4cEm8XiYyiVSOwOBYbi9mLOXsfeDIg6nKj0DSOfdA709oGeN3s+awv2VMafwlZ2ctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853217; c=relaxed/simple;
	bh=RfK9TpGo1l+qY2IbxeI/rjdNTtq3tgpsUNfPqqsu8B8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GOPxV1u9y9I+i3SL9tmYZgi4lwPL7sAy9VRk2NLWw6rNjkQY6mY+lllmbRg0aUH576hi6Wx9EkjCf+PeXmH3DJfPNZtLkT3Bntova3iICty/I6xRaaQSJZzGUfDsiQ1seRoRjs/07b1PfezBbhsiqiu41VSqQAhRMtH+7ZWwdMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mlf/Ws90; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqLZE010204
	for <linux-wireless@vger.kernel.org>; Tue, 2 Sep 2025 22:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xys+TN3UvtXkU8j0YAUEEAdyFeTetjbhha1tMZwRS4c=; b=mlf/Ws90qxSd+3Oo
	lIYJhk4+Z99sfe1ZmBJ/tTEvBkBeEX5Rsn+KkyiU+YI2wewZNbyU6eFEfnrpaPFU
	lTzUJ10FtG1PR8eRSdfNcONsm0O8mykHhAERcc9WQq374DUoeyv/5Ptt8J67A7Ch
	mQDarlCNRcOrZ7FXubzdg8l3Jb8KCt5vDUIsdAQU3o7sqVUc79vcJni5SO2IwFFj
	4SQXszIg5zDdl2gb0s30A6gDf/R95sHo8kepEeiek1DJcP+qyp/VEXtK2vBu3r/n
	o+yeKsFib3nEebr4YQ6RsxvyUNyHlQ44VfuzED3fzX5CnRSqjcqJ5WjYxBQ7uj5L
	BSt9uQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0ehkey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 22:46:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7724487d2a8so5095676b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 15:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853214; x=1757458014;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xys+TN3UvtXkU8j0YAUEEAdyFeTetjbhha1tMZwRS4c=;
        b=iipy87Cg1So81UmY0UyKOoE9O6Q1Sh/BY/IEweEhk/L5PNal3PH9JuXOgfXAvAzAYV
         /w5uyNpT9O521yKjdQpoXEcAJKgsn6WEBewdQHAe4rR4Js9xFx7aSCe/H1eR4ANABu1s
         nsbxWenCmhbIqmBQP35cu8yg6sGRi+23L2YliRpaaLcbCvupkxEj5G0EJnYiuOpdclSo
         7loCENzDui/GtoQWMmlD+IR5OGyPrbYCp0uYBQTeRLQSJak/Qwr7SJZfLVid51V9o09l
         V0EyojTW8tw/A0KrbB9RlBIUNSpW8qa+QcmOiM0zvQSD5/IPeqy9rA3Y8EpqJB3T4uyH
         WzDw==
X-Gm-Message-State: AOJu0YzszUxhj/FtlqdAhwlAyN4x27tvFm9Uhxy53zVQMHaIlrggSaZm
	TI2gtHgCbViJt2weNw7TTJ6yup210LjCEQMmxNsKwh/LKxlUoLp21eFbPgpgrHfWMBI6lqhX7cR
	w1GSpFX+I/ARXtTV0UeBJRL2amEjqX9tYOxbxHwhO/xA6DJcDgWvQbinLrfgHQh1OEl6Yiw==
X-Gm-Gg: ASbGncsqiSxyZVyeMZCdso18LVjRD7W+S6LnP5UmC9/vyMV1G0cD0C+pFn7DtfnpkVL
	Q3ai7tppYUC2MA9QemJlU6z7uAdY2NPcphh8rFxKCLKtDxPkAcIinpPjIiDzLSp/WJsLVDXBoih
	2paW8LEI/2kXdzWPEVKh6lK72kfv8ugdU93QwQdQY9hPkpoA1dg51Um5nNftgxL1kpz0CfuDOJ3
	PDRCAVrbazvWcJxzN/8e81eOHXDo0pCnEuBR1b+ENeXsRKDvbqTLmbdE0AGWvP7c14LhhLCEQNJ
	VXDtkLZ1pKARVk3G0B8zoxGForWgz4l3feWyYmh3yyRC9kVapsffmnH4kJlmyEtGRApOEBl292o
	o
X-Received: by 2002:a05:6a00:4b56:b0:76b:f7af:c47d with SMTP id d2e1a72fcca58-7723e21f31bmr19473704b3a.4.1756853214251;
        Tue, 02 Sep 2025 15:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkIImkkPU6MxGr4gP6bIaLDKYFv2y3TCkwY7POopojn7hgisj16D0UfF1OYID2SsHnX63+ow==
X-Received: by 2002:a05:6a00:4b56:b0:76b:f7af:c47d with SMTP id d2e1a72fcca58-7723e21f31bmr19473686b3a.4.1756853213830;
        Tue, 02 Sep 2025 15:46:53 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f4858e6sm11129947b3a.4.2025.09.02.15.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:46:53 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
In-Reply-To: <20250801104920.3326352-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250801104920.3326352-1-rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: Set EMLSR support flag in
 MLO flags for EML-capable stations
Message-Id: <175685321312.3902096.17261701476797887312.b4-ty@oss.qualcomm.com>
Date: Tue, 02 Sep 2025 15:46:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 8e4J73p1ZqvCqth7owcDc6nBrQgY2lf_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX5VUhIm0OgXi3
 yrt+CIcV+BMmv3ruX5B0OjFQva3Hcs0WiqNJmAr//cLvabX3tjZBoisKwb5aVKGmObjEw9Ma/60
 JAFAKfh+JDc53TbGQkb6f6nNsUo6y38A3KadzyQTDI8EwMlY+WN+wjYjZdKYdY65HpsG8c42WP6
 1ClfZGpGQHVj925hEceXcts4XphVT7fH7ZY4wxk5NlgrOyqI1m+19bEaOI8hUGCCoCReRm2dWF3
 haiZn4l5EyHvSlUfc0e/dq4VKCWQ00pmEtvSHZDQukBi2QZ3IC+7YR6L8pxqdGLWimzBfDrxBNx
 v8YMbucE4tKcSfCF0jlaoOi3xK0WLy2kPRmYAzK1jA9B+N8cFt4i7I70hpI3kmzTTB/2d6HGy+p
 yaIx33lG
X-Proofpoint-ORIG-GUID: 8e4J73p1ZqvCqth7owcDc6nBrQgY2lf_
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b773df cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ff3wTCdbfDm941fWPPIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004


On Fri, 01 Aug 2025 16:19:20 +0530, Rameshkumar Sundaram wrote:
> Currently, when updating EMLSR capabilities of a multi-link (ML) station,
> only the EMLSR parameters (e.g., padding delay, transition delay, and
> timeout) are sent to firmware. However, firmware also requires the
> EMLSR support flag to be set in the MLO flags of the peer assoc WMI
> command to properly handle EML operating mode notification frames.
> 
> Set the ATH12K_WMI_FLAG_MLO_EMLSR_SUPPORT flag in the peer assoc WMI
> command when the ML station is EMLSR-capable, so that the firmware can
> respond to EHT EML action frames from associated stations.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Set EMLSR support flag in MLO flags for EML-capable stations
      commit: 22c55fb9eb92395d999b8404d73e58540d11bdd8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


