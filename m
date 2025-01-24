Return-Path: <linux-wireless+bounces-17918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27701A1BCE1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 20:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E08516DCF2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967BC188714;
	Fri, 24 Jan 2025 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q9B3c2MH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495435976
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737747288; cv=none; b=LQ9hTo/HNt98JYFkoYoykDLRhxoUbl+GJa6CrzAvMBs/mKo8M5uIP2GaYe+1nSWBTsOe5tOiYBnicTGa7rU2U7rH+5WJoq/ydEy5ovgj63Pdv7pMdx/Zo3BPuG6nmVbUDdLr3TJ1XRqU8V2KnTjItxCe71gJM1hPSBdoawOf1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737747288; c=relaxed/simple;
	bh=NcoeCqgAQ5KBxwfpgxQo7TVcm22gwtBUsgfByNKgp7Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=BoLxfVAUTzgKWwV8D0CvBhoRzvYgfpjow3ImHDYN/LMqaIPGHVUYqgjr3gx55F/9yhfeFYJz8K3EVoaR6cVt3HSBToNyud9n7fs3METRD44/E9r3jha1mEtaDM1rQ3mGukAcuvcQEYSowsQ74hCCKIwUr4pJYuCStcQjOr2PFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q9B3c2MH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OCeTSb004789
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 19:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GBgzsddn1AaQ6ApTxidChv
	IRA2JVHU72+jsfbcvmvuY=; b=Q9B3c2MHUslsCS7b/mUwsXl1s1CZoNMmHtk5CW
	eyfoxW6WbU+8htqeZDJrWsFrtmWX44cdjGrKvFGOK35qjHD30DNmEbUbh20C5ZZn
	yasf/SlG+ctYUqtodF0vQcqtdUX73ZOckul9ZQJyWvjdYqYudzYIYuNKUsa23uue
	Ou3bbxy3jrNpij3A9uTi0g95/R4wp+Ip0P6upFWvdmex+LTxX4/QPwUXKH9yPhwC
	V0JR1RlzKI9HyXTE/dU9HLBIldZ1Jj0JHoVKF69B9pBKCYguNqYI/xq1kuZJHGYN
	XKEvVsLMFoR6SF9udJgYWV/gqEsbdbEeUpjYYolod9O8PFYA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cb2xgwd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 19:34:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2161d185f04so34264555ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 11:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737747284; x=1738352084;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GBgzsddn1AaQ6ApTxidChvIRA2JVHU72+jsfbcvmvuY=;
        b=kL2j9OwVKEOyVfawldYnk3VOHqywrhQ3dlvuWth+UewmuCD/wNS8g9xbVecObK2OtF
         xp8fDtph1XumwNtludSUySwPQFVl4JtuVdVlEy2VsOSF/l1f4hdi+DRBxqDyldz0/6WV
         SDqBJzMwlmKwdls+AubbAlb0gweBzImj3PKk4DfcvEz4oIaGPMRCdvH4uYUBJQxaDzwe
         5XY0gsi7kqoEo5xHrAHEVgIOaD8kzV18jm7GQA+oqIwcYtczRL6cnDeT/4tjB7iBUat1
         ShGel/jbuiPxRh/7EmY+2ZleCPfFSM5CYT7wVo6CESi5mku73/OFOPuN6O7CYl2vcQru
         jCZA==
X-Gm-Message-State: AOJu0YzFOuKxbTQbL5QYCiqeiALgwHgUSFd5X8AFXnAUph6IWK4jjYe5
	C+W8FTWKzPHnRIJeYeFTiCWS0yn5QNsZRHetkVRxVn1tdcqbmRWF13M1Nk/4LJhKmNvTzIofCWd
	4JLyTbY/0BFewU0kkKU/hgEQZDBkMMNg0HWzznrT/vSMX8uoBM0ndvQlZuaAGMqsH0k9iE+WkbA
	==
X-Gm-Gg: ASbGncs2PXS3NuIOZa0IiLZGQAPnGJnd7UQsHFKwMTvcwzXqlyKDBdzRKhdgSyfHiN9
	8uoM+WON7to5RS/m9x7UHeASpK6nrrJwKcgZQ/IRoZ+w22Tw7l1OmCe5BWufXgr8pUCYMeSTi8S
	vZtHr56VzOqwCs6yb+7q8zy4yLrYKU+ybltn2IU2DJNmaocleCBketxu9JlZkPofvrHzZ+voOT8
	8IASxkn50ClV+XEu84JXrjwzj1jM0frQdkV6OyGre8qqGHxGu/ZRAyHayIKy5uNHfwDwpEAHn9+
	RWlsxo5RPQNAWVAduFwXXJyDSXUUe7A=
X-Received: by 2002:a05:6a20:2d2a:b0:1eb:3623:5a13 with SMTP id adf61e73a8af0-1eb36235af0mr42494888637.8.1737747284140;
        Fri, 24 Jan 2025 11:34:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSJA+1ljjIJRHkf0iGymCofgHmiawKyhAgfKNlM81XtiY2GY7mfJyGWC+MmnJGoRYnSLZeyA==
X-Received: by 2002:a05:6a20:2d2a:b0:1eb:3623:5a13 with SMTP id adf61e73a8af0-1eb36235af0mr42494861637.8.1737747283801;
        Fri, 24 Jan 2025 11:34:43 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a78ee97sm2264332b3a.166.2025.01.24.11.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 11:34:43 -0800 (PST)
Message-ID: <3311fea1-c7c0-4929-b92c-16ab933de33c@oss.qualcomm.com>
Date: Fri, 24 Jan 2025 11:34:42 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org, kvalo@kernel.org
Subject: pull-request: ath-current-20250124
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DL-T8Rv6IhoYwezf2d7iSKIYKfVwoe3I
X-Proofpoint-ORIG-GUID: DL-T8Rv6IhoYwezf2d7iSKIYKfVwoe3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxlogscore=920
 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501240134

The following changes since commit 146b6057e1fd28fb1a38d300bf76a38dfba7f9fb:

  wifi: cw1200: Fix potential NULL dereference (2024-12-18 19:58:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20250124

for you to fetch changes up to 64a1ba4072b34af1b76bf15fca5c2075b8cc4d64:

  wifi: ath12k: fix handling of 6 GHz rules (2025-01-24 10:32:44 -0800)

----------------------------------------------------------------
ath.git patch for v6.14-rc

Fix an issue in the ath12k driver where 6 GHz operation no longer
works with new firmware.

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: ath12k: fix handling of 6 GHz rules

 drivers/net/wireless/ath/ath12k/wmi.c | 61 ++++++++++++++++++++++++++---------
 drivers/net/wireless/ath/ath12k/wmi.h |  1 -
 2 files changed, 45 insertions(+), 17 deletions(-)

