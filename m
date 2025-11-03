Return-Path: <linux-wireless+bounces-28507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84459C2C8E6
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 16:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492DB1890F89
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 15:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9803328E3;
	Mon,  3 Nov 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="olbfNGzA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LLDyWdAw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5833291A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181505; cv=none; b=NA4Br11O/WBlL+/9LSsxO9nuKx1T4ztyGwZRutng00rueedWXzTec3ZsgT5h0BGRCRvdCVexG6ZsAqOl72CJ0STo8Z7jmOdr+DbYtDLT35hbd3Afy9Fs/UaALaU13uWnYqymgR9kS5R1dJvN8GmfJibXwLHArndhvsLtYz6ytMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181505; c=relaxed/simple;
	bh=8gVo9oXnogwsMmqSKsSqmRvCLDt0rUBSHaeh0mJ3SmI=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=CI+PF7VYA/MlJVayUJHiC2D+rLerzulsMLmobHEkD896dMQ6VcxfdqJFwZ8NrEDYkyGDizQC1T14tWIR93DRj3ad3lbq6Nf5L+9bInhjQUtvmQNlfy9e/TzYqtjEaFpG9tIzwZq6eExAVozmSHhQOvwI6FtsQM9riwxjr7Ndkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=olbfNGzA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LLDyWdAw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A38afVM1167347
	for <linux-wireless@vger.kernel.org>; Mon, 3 Nov 2025 14:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wasjlQZYxVXaUb6xZ8ZqkI
	pFidqoYAqCMrL/L/nKkxo=; b=olbfNGzA6nOCNokeIvWwlLzH9IbLmY23HwbShy
	PtMZnR8Gja5xMORsECg3NdEOQY7ruFXA7KGADGB0GE4mnbBuBbFxHm+DrrQlxAZT
	vUW+84CzU6AD3AZuuTHZm8NxKc5+fOZqRqKqYEkFpKUGo90V1ZQj7RJZFrAbttr4
	uSo/5Vz+Y0+oUv58vrdB5c5ZmVKFkSxWiJCcmQ375UrAxe2jtlTPp5ZJpfoJy7OV
	8kuAHIYAJLQviLd/IiICcc7R+5OxTNt3+hylrN6884NZt3ijK8IRQtanM3f2hDRN
	tqGe21w+xOX+rIoeGJPgjgdSSMjrRMVNq61PgLlK7pez6ePA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5977d15t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 14:51:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-294fb13f80cso33661145ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 06:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762181502; x=1762786302; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wasjlQZYxVXaUb6xZ8ZqkIpFidqoYAqCMrL/L/nKkxo=;
        b=LLDyWdAwYYBZTG1WIF0N6zcvlBsIbLv6e2tBO1yYx21eqic69AaJg8FpoO4dugUfcO
         LrA6U4YSCTBS7v5oVHodBUSJwhCsOt1uyE+lm1rooVna/z7wZGMoBwtBZiHvmcxw2N0b
         RCWtmKmX7Q8bgAdteeEaKp5WPZlg3+oo3Jfki4PEM36xPoNBKEHXSYT/HwshcdfwV/US
         wwzTmoM0bISafr1ZJ4KY3fZRppQGTGEfC6I1fBnYZ1RFNWcoOzX0KwYx8uycvxGNxbRy
         f5QzzvPiSwWAszZJclWNdBjBukI4gdhFK4fi+SNWfjaQ0LPQJ3kS3GytTofYl4ILP+S+
         5H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181502; x=1762786302;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wasjlQZYxVXaUb6xZ8ZqkIpFidqoYAqCMrL/L/nKkxo=;
        b=tx0XWLFcxfMfP+Ci8CwXpV+sShgQCT4+ifSfhU7DYWDACvjGFgxAv2r9emEitLgvCK
         I/vKVTXyqz8QtooxAJgj2rsiNjAGuolvN9BXaggSE6ER0GlbgInXJpnetifKrBAmYhFN
         S9deHBl7ALDWavxKMqxA2bTLdddcy+8vxXXKKnmuqJpb0wnub6uDKBnYUYYZ6tFehDD/
         l01poIWFYnTBNUjHnN3aMBrcT2NAXfamecYzpeC3u3owcuQn2DL8pUtSJhHOZLVS6yWA
         IjR5PApHUKWEaQcHFVXMewQQ47dFHypzWPSemnjB5qwPxoz2kMXzPw6oMIt1ZYNlgCSg
         iK7g==
X-Gm-Message-State: AOJu0YyxAWKpdfWUSwi+uQkmoYj6wA7JuJJuA9d/8I6L/SZEmJvC8EWQ
	0GDVU29fX12sVH884/WSkb4oJr22+b7rIsdWi5aKUfhVd4sV5auSIWUaEuqK7NEJi2kreM3+kOu
	wvZmuHl4Hp424rA4VIO9LZQiVu2HL46Or4bpHeJrpLUTWPkSfBSpl359jn97I4e4gSV3iCLM/s3
	mEYw==
X-Gm-Gg: ASbGncus4D3ARqQYhgxTb0r2ctwjJvXjczGSsir4fmR8Frdn6NmCX24SYvUUyAvgIWW
	UEWy07vZwVC9jmfxHqONT00To8W4eBbSrZHetZLoqY9eRoYiUPloHgyL67SEe8COf+tZj03ftcw
	itOx2D9PneXLt59on5x0NCYlG1K4HSromV1bU81xeqxR4sX/4/4ld2DSaKopEYS77X59TnPrlk0
	Lte/oeAKf3/dlzPknzpggMCeFZx9IbcZqfcT86uL4M+RCR+Zd3uQsvGx/Slr3CfcAn/7LpfZPiP
	Gst0J2+k6SR+N+JHYCO/E41Fa6I/2/BrGtAdf4ZWfyGpUW3842qC7F+lJifRMQRcibzQ3TLpEvZ
	bm6kCs7f/KIKsZP0S6ynX+d9wAGXh0+Zax5I=
X-Received: by 2002:a17:902:d483:b0:295:8da6:24b6 with SMTP id d9443c01a7336-2958da62993mr75060715ad.40.1762181501708;
        Mon, 03 Nov 2025 06:51:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4TIDTT88GxyP1jcTSD+XGLJa94lUUo0B6pbH151XMWEaRqBc8s+7rKS6QMUAdzrJW+0E41A==
X-Received: by 2002:a17:902:d483:b0:295:8da6:24b6 with SMTP id d9443c01a7336-2958da62993mr75060295ad.40.1762181501209;
        Mon, 03 Nov 2025 06:51:41 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696f277sm122049955ad.55.2025.11.03.06.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 06:51:40 -0800 (PST)
Message-ID: <273cfb51-9057-4b72-aab3-10f088c21f52@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 06:51:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20251103
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: o48z2QPqvEN0sqvF4EWoZVOxUUufRv2m
X-Proofpoint-ORIG-GUID: o48z2QPqvEN0sqvF4EWoZVOxUUufRv2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEzNCBTYWx0ZWRfX5V4YMVB5okTE
 BjLcaCsX+KRbivxex+DQNOcXbXGsR2bFLZzpn85xsoFUGKpkrEUeVB0USsJsdyi5p8AZObBQkH8
 7mNy0H0tya5HOOhZ0phZqmDV9a4nX/pmLE6eAW1iVVa+Oz/8Qu/C/g9RQsg+M29gjsnN0LATupp
 zH0cs6qmR3Y2ryyNUZs5I7O2HUetgCkKXOV5J3cF1qhJIq5+ykxlaCY8GjVO5oknmcwzL2Had//
 ptZW4tCrwq1Hi8xOvftSTKC23zEnqX1oilzOLi/4oRPu15KYQM5xA/ly23xkfOnB2+m8dL+KtHT
 5fOPKn+ZVcGDXkxSeRzWMdFwpNAHWjYaj060U4nxlpkrTHg7ihXmzDXGmdGNZNaONgEqRiY9nn7
 8hOKPN3p1b7XtsUuE+XuGKq61XEsNg==
X-Authority-Analysis: v=2.4 cv=WcABqkhX c=1 sm=1 tr=0 ts=6908c17e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=X6h9MiuBSSvgxfhAhMwA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030134

The following changes since commit fbc1cc6973099f45e4c30b86f12b4435c7cb7d24:

  wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work (2025-10-28 14:56:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20251103

for you to fetch changes up to 9222582ec524707fbb9d076febead5b6a07611ed:

  Revert "wifi: ath12k: Fix missing station power save configuration" (2025-10-29 08:12:14 -0700)

----------------------------------------------------------------
ath.git update for v6.18-rc5

Revert an ath12k change which resulted in a significance performance
impact on WCN7850.

----------------------------------------------------------------
Miaoqing Pan (1):
      Revert "wifi: ath12k: Fix missing station power save configuration"

 drivers/net/wireless/ath/ath12k/mac.c | 122 +++++++++++++++-------------------
 1 file changed, 55 insertions(+), 67 deletions(-)

