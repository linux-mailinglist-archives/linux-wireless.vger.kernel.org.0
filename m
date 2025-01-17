Return-Path: <linux-wireless+bounces-17668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3E4A15A0E
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 00:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4983A2310
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E51DE4EF;
	Fri, 17 Jan 2025 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YsHhqzi0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD101DE4C4
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737157315; cv=none; b=RnSp9KYJaKyYsDgVzGiqes15EE9r/qevX/JIJYaF4gsNBFx8/EaVgzVw5KFOl9Pq1zW7p9hY7W/KpuBnWD7XDBS0ozBVu//QZb78ZC76KFnPBLultj+X0pQN/S73/sGY3K3cSAY4iJH9nF9Pq/t/j3MEIWrOq5a33QNE7PE6nCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737157315; c=relaxed/simple;
	bh=R3MRgcmVTKVJbAFe5vq8MMrQWHBAgGAXFvh2BXct/GE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G9/Kpq6fogHKjHGIc+VhdIxMCv1i6REPiFpBrWRTYKvm4sN1NSfywNrkycZeSp9EZuoxCYQWPqvGEwqlIJ337O9pQfI0yvex2i/rGG+wHXJGPhKqoU2RmXQpx+EfXarf3ftLXS4aXhg8lDep/HRFObGKcLcnp3KdT+4eNmtQ8Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YsHhqzi0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HG0RuW008840
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 23:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DlE1YBTTne8e1I++1l/sONj2hwpUTlJheHHRR2Yh9Ls=; b=YsHhqzi0vk5nrr3o
	03j+UAhyUiHGhlAWSnI7MTiDMMcUqIUuSuhFgiW0bKwFlXMj4789AJ7sifWeUhWw
	QMvzpJhZt/PvjKcmPKYV+6VljQLx0wNwlNV2Uq/HEy7EKOM6Ri0keaERdwcCAScR
	lt5wS6d2dWRjJrM/yD4V5n6sDH/UnzW429aWdUgcmbhb+i0moo7BkFynm5lKJVOk
	khpUXsdKyx3a+864EvpvSpAHQPxpSxQodkPv3JFvy1tSSgzpXtD5BEtuVz8KX0i8
	bsjuLd2duaVES+z4VePCOJASydL9MbnVuJdgmpVDtTeBxi0INo2uFC12LUkA9J7n
	cgj89g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447tbp8v2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 23:41:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216387ddda8so57388075ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 15:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737157312; x=1737762112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlE1YBTTne8e1I++1l/sONj2hwpUTlJheHHRR2Yh9Ls=;
        b=JmP/k2HHUXSSqmHv/1Hw00bGEYO8DG3ddOpS/l/kj4CmAVSZMhrjyXXJPzEle/ISgB
         aVvHxzfnzVmvP2DHtvy8X7aa3Y2Ob4U2oOwKJG7mVHlHlaKwqzL/ruVIO7LHlAhzqwSL
         qnc6/FuwlJAGMD6A66akUJAINrlaujyGD+q4JqemGQrzXFcBbhPUGglS0A9cv6xEJ1ZZ
         t3P74vb8wjT2ik+IiTioPiqgPDffPwAL4X4bZKfFYuVoBntnRzSOMQmXfjkVt+vSvXuM
         0D0pxLOeU7vmFmnxY5rdcmVIgTFWVvBgoFblj0gaWZKATLdb73eauEw7j+7JuuEWUrpB
         ymiQ==
X-Gm-Message-State: AOJu0YwHjH8mZ8EYbhrLVm5GFoLxp2vaNWmeFCmGHZpGsQcD0xyJxEYm
	NCp95sXP0h8Nlsef4EZOsmcHKJS9GwH2WRdCs6i7MRecE0GQYV5uvawVHdvneJYENdjlYlHWc80
	VvYfb1s/+ZEZCwsSk/pLoHSIoTdkPMUzpvtJXuAERm7xAJf+ZWqCJfTbxC1yKfTucow==
X-Gm-Gg: ASbGnct69xSKgZJFFV3obWA3QQNna50feTJwmRjqwhPNqBTudzmKrgMSuivqCOD1FF6
	9+hvm0bnVpBCfKgXVWhbFKSWXrJcgVu0D8n9PoTx8iFNR2DxKtaSodjTkSl0SdAQpgxt3d9ihBg
	3K/f0/ur7jlIguZgkcz8zrrrycRg5TQezv3KMn0rU/ctHlGcHAY7DpyUIziQVsVTIzsVBl2tm1e
	axNyAVWAoxvIzYf7NMeJgKAfM9EbQTi3rgQvR2lf9kSoOsAOSZeTv5C90o6LCffYHTzTJsTFtnj
	eiBYGqaB3SweeKJ7l4s6g6Lq0BbEvYM=
X-Received: by 2002:a17:902:f54e:b0:216:69ca:7714 with SMTP id d9443c01a7336-21c352c7a86mr73954825ad.11.1737157312054;
        Fri, 17 Jan 2025 15:41:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEknRc1UWjcu8zhTvjm2/SuMayJ+0UjFl+FDIgz/MK4fFIHZRCNwmFGB+iNtO5sqA8CHmjBnA==
X-Received: by 2002:a17:902:f54e:b0:216:69ca:7714 with SMTP id d9443c01a7336-21c352c7a86mr73954595ad.11.1737157311677;
        Fri, 17 Jan 2025 15:41:51 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3d86e1sm21565915ad.172.2025.01.17.15.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 15:41:51 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241224143613.164921-1-quic_periyasa@quicinc.com>
References: <20241224143613.164921-1-quic_periyasa@quicinc.com>
Subject: Re: [PATCH v3 0/3] wifi: ath12k: Refactor monitor Rx handler
Message-Id: <173715731108.3752359.4147559527899683477.b4-ty@oss.qualcomm.com>
Date: Fri, 17 Jan 2025 15:41:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: ZbTnrr82OnDXRWr1lu4_mX9jXqKXOGLx
X-Proofpoint-ORIG-GUID: ZbTnrr82OnDXRWr1lu4_mX9jXqKXOGLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_08,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=712 priorityscore=1501 mlxscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170184


On Tue, 24 Dec 2024 20:06:10 +0530, Karthikeyan Periyasamy wrote:
> Currently, monitor support is not added. However, in the future, the
> monitor will be enabled. Therefore, refactor the monitor handler, which
> help to add monitor support in the future.
> 
> v3:
>  - Remove the Acked-by tag
> v2:
>  wifi: ath12k: Refactor Rx status TLV parsing procedure argument
>   - Updated more details in the commit message
> 
> [...]

Applied, thanks!

[1/3] wifi: ath12k: Refactor the monitor Rx parser handler argument
      commit: b238941e8e97c17380f6a6a2dc51520b1829c167
[2/3] wifi: ath12k: Refactor the monitor Tx/RX handler procedure arguments
      commit: 844c256892e162e85db52ce2e1f3d14053ecd488
[3/3] wifi: ath12k: Refactor Rx status TLV parsing procedure argument
      commit: 1254580d4f831808462e719e00d43a46e4254631

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


