Return-Path: <linux-wireless+bounces-23182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37763ABDF36
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 17:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3E23BCA60
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFBA24C06A;
	Tue, 20 May 2025 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BAuDowdo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FD21ADA9
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755332; cv=none; b=d3o2C11+0HQd5Vc1JqeXcBf3XF2a3wAwode+Zqz4ffjlLPzrlO3+mMxVRGSbqbX7FvC0KBZ7fyajfyFKFu4S79MyysKToiDJp84iwYjtaiYzm++sTr3sDB5Fyq3UNc40VXGJF6zbacgPP2adyB/Xc1p3EnUtKz1q/M/28pW3Ugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755332; c=relaxed/simple;
	bh=UZmPNhCJ3r0UkfGc1kGSTuhlg7JUpXzc1OoBLJ5Iqp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JCd3vI6NC8TX0m1ip+UJ2UxR6WoEJaacrI9fsuLCGsBZ7yBoa6CDBysXKpX2gGrwmuCGOfP+fMxOtP8QsoSpMRtl5P7nF4fUCiyixLPhV3O7K3912hBGtARg7kB4lLNZeLFg/zCFLsLRW2oGhIPAHyMgRKNsjFpIm3SSQt/pg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BAuDowdo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDs9fr012269
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WE8d5vHr1zUw152rm6mfp4GuDiU4NPfd+rj0C9XL2cs=; b=BAuDowdosHJxKkwj
	+hojtY6ozytzQe7cRgTaJmCBUMAfDhnRSAKVZonC9wvWvKahwNsh4nTDTDlBhNAS
	15g+jFm88Z4PaMQi4ptTYlUXb9fxjVpW4k33gqHSet2SK3G6cbxNJjjwh5nviZqU
	rBwtf06/yMlPPNjKP8TedQP8vnsSXUAqT1aY1IycwRgaBqd41aZkEhMOADHtWupm
	NBJhIz7TRg8OJ6lWbGufoy6wbELDtPuHpyo5I+Gy0zxUIishPcpKgLg2llimixth
	bwabZvfENuO6XYuEE8ltxsiQYB6RHSwzYjdjDic7mou3koVdmicSStjcnsq9hrkk
	zEP4fg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r6vyuer8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 15:35:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30e82e16f7fso3836064a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 08:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755328; x=1748360128;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WE8d5vHr1zUw152rm6mfp4GuDiU4NPfd+rj0C9XL2cs=;
        b=UOSrlbqVlXxDwkEJBwkMjjD6WWKT+ZxQ82LOrNK21TBo5chzmrN3iBxTcr0v/W4NvS
         ZqwH3FKbkUK7Ess5qdW/h7joa1DoaFyh6qSabih6SZV4FZ+JI/fDtZWsxR1Mn8QHFjXv
         FyvA2ISur70woDDMJELcxiMXHFMkSr9Hnj47TsbX9lNeXFOQfskhkUVGAsh8FCAnOtLk
         vD+ob8Ov0z5VdA3Z5ql+DzTXdLWGTxyttNE3qBNcSRJf0tkWQNMZnZU796xzjFkzKJjZ
         DjPoH1XH5whzjnmrCfXKw84+0ssq6qfG3270jjYWDtegyvMXUzs7Q7UNotAW2FzStDgk
         DrFQ==
X-Gm-Message-State: AOJu0YyjkG25pBJBisqBqna0WSguf2fitaQDYzFJ4c+c+f68Y3GNQn8q
	JGdV4AdN1Q0YNfqaka7dcEDCxkICKJnpcUvM9dbveLB3IOS8vEnPUqn8M5WOEUFS8uOOh+XIYR0
	jwZms8Qrt19RslL/1qiGcB6vhkpB0Ck5j4WOGSYIg7i0kbLE25mNhfedzaQiT+EJiITGnofeu9A
	Fkcw==
X-Gm-Gg: ASbGnctRPDqxalrF2e+0lN1gq7M1BrQx7JSsX37hoyYknmSC47l0/0qUXvO2X4/95ES
	WRyTCWFy/+R1h4sJyaak5Hyl+NUDKdh5yPrPF50FYFZBTt7eYsjComHvms2o017VhoDFOd7ySXZ
	W7AeKb4nzhpu7m6MHCCD9ikQ+AFUnbeTSF0pyqgN6C4mpq/c+RF8VwHIcbk8jYmShVtwZOFQZHQ
	/bbnjdLIWqT2CtZJ1dFDyONANqm/03uoxolCaY0VSXKMSJEII2hhmIqh6Ldpw5KRRS242riKXY4
	fa/9Ciwk9m2FPcsncASvsDyb0imlUX7Vhr2nedfAlAO0u863
X-Received: by 2002:a17:90b:3f4c:b0:2ff:556f:bf9 with SMTP id 98e67ed59e1d1-30e7dc1e9c0mr26022763a91.4.1747755328134;
        Tue, 20 May 2025 08:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1VIeN7KBIpPTeaUOQJ1jMDsM6F4RmGguFP6KtJVvEHcku2OdcKmhj0z5gjsssmEVg4nTnrA==
X-Received: by 2002:a17:90b:3f4c:b0:2ff:556f:bf9 with SMTP id 98e67ed59e1d1-30e7dc1e9c0mr26022715a91.4.1747755327679;
        Tue, 20 May 2025 08:35:27 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a44e7sm8158197a12.73.2025.05.20.08.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:35:27 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Sujith Manoharan <Sujith.Manoharan@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, Robert Morris <rtm@csail.mit.edu>
In-Reply-To: <20250402112217.58533-1-toke@toke.dk>
References: <20250402112217.58533-1-toke@toke.dk>
Subject: Re: [PATCH wireless-next] wifi: ath9k_htc: Abort software beacon
 handling if disabled
Message-Id: <174775532704.2195760.7904408003181702653.b4-ty@oss.qualcomm.com>
Date: Tue, 20 May 2025 08:35:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=NfHm13D4 c=1 sm=1 tr=0 ts=682ca141 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=OWioW6C7uJ6hkransA4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyNyBTYWx0ZWRfXwdkQQzowRo9P
 EiX4jtO8i2cjsSuXhJ+t8popBbb1/J+obbSuOB9MJP6BuHOokPmaWVh0XKG+GzoM7LtV8qarbFc
 3rGHHLPJibMtEmEQmbg3mms9kUEookvS0FVC+rqlVt4qBL2P+udHYcMps+W9z5ayFHmLVpvVN5Y
 QBBuAU5n1t6PqaU6UZO0+Zd0u23wyKCsxAgsDWgBgB/qovVWarfJ/fx2UaIOrUS9Rc9iM4vc/7j
 ktxqftFvZu/x0mwPCBE6ZxLFd9x4IwrhIcXUQKHWA+IhqIalabmcCFspNSvxi+RpZAPEfEPApMO
 8pme7NBvmHDsFF+obtEltLcs/nadentkVWNmfgFUJ3ZXnRL4J3hu/jcGluwBozuE5jNN6orZxcZ
 Z++kMbQDhoYUiBZ+NixWRMz9wXVdNj3J18j3uhjr51SAX6IOZCSlVT8/Vo/AKH2bpfyfvzrx
X-Proofpoint-ORIG-GUID: jikHxXT49iQonuWxGOAL-b-nemCi6XwR
X-Proofpoint-GUID: jikHxXT49iQonuWxGOAL-b-nemCi6XwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=584 impostorscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200127


On Wed, 02 Apr 2025 13:22:16 +0200, Toke Høiland-Jørgensen wrote:
> A malicious USB device can send a WMI_SWBA_EVENTID event from an
> ath9k_htc-managed device before beaconing has been enabled. This causes
> a device-by-zero error in the driver, leading to either a crash or an
> out of bounds read.
> 
> Prevent this by aborting the handling in ath9k_htc_swba() if beacons are
> not enabled.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath9k_htc: Abort software beacon handling if disabled
      commit: ac4e317a95a1092b5da5b9918b7118759342641c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


