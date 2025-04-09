Return-Path: <linux-wireless+bounces-21327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38946A82864
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 16:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A4E4A1CD2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B50E266590;
	Wed,  9 Apr 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kY6A0Gw5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5817C224
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209715; cv=none; b=gm5fk2XDn6iu4fZ2epeTBHmLnWsO3S+zZH0yT1TyydFHY6W76885/U0O6QTd7CNmAwh+GVGTWBsL0OfFBEzthLqTOgBWq4hmO920FO0/mpxD0VE8y986tSJrwwJp5DGUw/o1QjNmLcQ9hb02+hbdR0b4wqQCuHa2iPJZHV6/VTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209715; c=relaxed/simple;
	bh=fjVxoqBq0tG50me8xFQJx38ltEGKbUD6GPm55N0kspY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GCwNX8to4QaNP7z6Wr3QVKKKfoK51GJfUH1fE8YPniBX156fZeQMZX6uKdJ1cYYUnemxVpq8Z6w+I5ZozqM43xThMHP+9fXyJTnJj5X2qoA27wVxAVq4XfWEYsign9sLBQrmw/yYbcKWqCrMmB/E5YrIu4j7BV9kXm8Q3W4X1fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kY6A0Gw5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398kPNu023847
	for <linux-wireless@vger.kernel.org>; Wed, 9 Apr 2025 14:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UAlXsfsrquK1S93niFLe52PvZv7ysy5cm+5sewzm3OE=; b=kY6A0Gw5RjTgDUQx
	0WNBUEzbuAGu7lG9fqa2sqxAxn+bToNflyVS5aEOy/ivCfDwzlVJmJJnVe43s7Z8
	1czlzyx3yRNh6sQDmx4cG64N+Dy18wvA1w7spXfUVSWQORgC8ecvdDFXPbAqT6Iv
	meT/FmzBe2130OXePMoT7qmD2e2IJ7OmPHILtfB24TCLMBPwycMAVKVf3Pun4UCH
	IxttwLkg+dzlPz+w3brPv45JfeWFGnG9ecdbqHU6ZAPaG1iZZDtDUPdXkS/7izwx
	pRUhMj+WqwWu6KW+G84xYRO5IZJv+HWPxsF20qMVBx1ThLvTAMt+NuWoRbieb3dx
	tR6hSw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd03spk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 14:41:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-af51d92201fso7530771a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 07:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744209710; x=1744814510;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAlXsfsrquK1S93niFLe52PvZv7ysy5cm+5sewzm3OE=;
        b=tltkJRXONtC12Iq4p8YROoIsTCjnxLeTvxYzPlhaNSNtTDUvycCRuWzYVOQepFytgu
         Evs/lEwMHjV24b2dCLeieLHhkvOhZpFzDPj1bKJt+3qTClsnHFwntzccdxoa/y/yy/Do
         F7HrOnkCwo/K6Tq8lXNptZBdMIe+YYW0a7865pDkpvDnascZz9uhhi5ukaJOPlePPHwi
         geveM77dWF5VsKaB9k4ojd7gZJIHTLg9seqPP4DXMZ/8I0GKflGYG5tjqum/GQVLzSja
         Cb3qG7mHbHIMW3JeqsETEm9UWF7awHbf+PSUlOW1SwJ15cnfTr627GJmjA/yjCIQ3l7c
         RT2g==
X-Gm-Message-State: AOJu0Yxd5I0Xo6zmQVfpZpr+1k2bL7kpsstd7LVyABWfZn8v4V8/KuAw
	8CpxzByLvNODZK4pYwGsccb/W7zYsUJgAt5dUskQiG/JavFxjqx+rEocQuClMZ1CwtA8A/DVjMT
	86hvDR7pCt5COGpzk95lxlPaXa4Pv+UQVUf/WlFfy/CjN990vKE+i1gtW2JOB2BlOwg==
X-Gm-Gg: ASbGncu+ZVB3YCo0eaX1aniztoP4jMVFvXFO0J/pGdceOWaemigXu49ZjN8p79iFBo+
	hUiXpq+u3Mzj7/HPRSqtZtTaBYmTH5R/hvdtBC21yVBbTHP3nB52ucpWBVWOmgyc7NE+J3RaXZ8
	51urdqjeizG5IoDOsFWPnny+Ydp42uxYXRRcOJWiJ2FkfH9y7m1zU9gPgbxBZLPnEsd6VhcOTn8
	FMFv/X73wRCdlOVSLTQhCfSwotOCwR+343vxeSeYgd2sE6XQtHDslb64ghUMIY0qsOw62gGiSHn
	mdqdE2XaRLmcIOcMVUxqDZbbGQwbK8D4XZroc/Ud8mpmnSc7
X-Received: by 2002:a05:6a20:2d29:b0:1ee:d687:c39b with SMTP id adf61e73a8af0-20159158073mr5477100637.7.1744209710192;
        Wed, 09 Apr 2025 07:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd0U8em6xrEZ2t7SnXCW3CgYP38EE8cCvSPcV7P2UyDUSrlOWDuG74IpGN+9Z1b3imdkiXgA==
X-Received: by 2002:a05:6a20:2d29:b0:1ee:d687:c39b with SMTP id adf61e73a8af0-20159158073mr5477058637.7.1744209709823;
        Wed, 09 Apr 2025 07:41:49 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf2571sm1307153a12.19.2025.04.09.07.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:41:49 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250408-timer_delete_sync-v1-1-4dcb22f71083@oss.qualcomm.com>
References: <20250408-timer_delete_sync-v1-1-4dcb22f71083@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: ahb: Replace del_timer_sync()
 with timer_delete_sync()
Message-Id: <174420970903.585328.11717154866782453003.b4-ty@oss.qualcomm.com>
Date: Wed, 09 Apr 2025 07:41:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: Jmi-Id9yoY1Qr0b83pi8oblJFf3ycHAl
X-Authority-Analysis: v=2.4 cv=Q4vS452a c=1 sm=1 tr=0 ts=67f6872f cx=c_pps a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=xVpgQal_Ih3nwBzge5IA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: Jmi-Id9yoY1Qr0b83pi8oblJFf3ycHAl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=810 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090092


On Tue, 08 Apr 2025 09:14:12 -0700, Jeff Johnson wrote:
> A linux-next build error was reported in [1].
> 
> This is the result of a treewide timer cleanup [2].
> 
> The ath12k AHB support has not yet landed in the tree where the
> cleanup occurred, and hence a new call to del_timer_sync() was not
> addressed by the treewide cleanup.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: ahb: Replace del_timer_sync() with timer_delete_sync()
      commit: 25b2f46bd7de2f0007d742de9d2e72e65db0edf3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


