Return-Path: <linux-wireless+bounces-23103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A715ABA4C4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 22:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E73B1BA0AFC
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78121C9FF;
	Fri, 16 May 2025 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y/79+x6h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F042AA3
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427966; cv=none; b=sNST60D1jM5hzlW7JqBFwpqIqNmzSa6v1oAzZ7ELqEEGDL02iyFlLvKEpm/w85t8ifPuuHdHWJjmQGgxjf+ts5j9L2/vkOxpPN7uTgGcqnfFSgPOUrv43uTDxiwFPiiQMbBx8NpK7iI1irwRbGWDFoFaToHN5pMXBFfu/wZH8Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427966; c=relaxed/simple;
	bh=+/avaHMy2W421sL0eXuO3suhNcLf3WtCc1srp6pBy0k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cJ/Jz/lPrq1nF9w61jFPUGuxISjtTFgHBom4qpCSLWPfGgEc4qbAQtMuBWN7wCIAk29f/DId91w57zREdsJs1eA99VKixP+J2R5fwJNd6rIqJnXIidWPn6o3uDKvMIAYNLzcLyjJhNKuBgHy5DOY4IPTD57wl3tn4O3TP1/FfH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y/79+x6h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GC5ALG007850
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 20:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dsl1htn5szVmt/DjssSO8gALKifNfg7gundf833ygfU=; b=Y/79+x6hffeZmx1J
	is5kjy3nCCGZ10Di9VsAYgqQWQ64UspceMlvaoIbatzzbT/sYVkjJ1Cjxwl4rWAR
	wwYCa2AqgJI3fWhxZ1pVKnhJYLd0cUCNpW8xA8RT6D/Jf+LZq/92jqSUGuu6gGhJ
	5pz8kvNz3DVSg7XQfW4B+0BNZ2bxoPg0gS9vBarbhUYiRo/ZXTnHgQ2cQ1Cg8GCa
	5NDD26VK5JFZ64TnXbXqEl0KHLP9tWc3runphjIp9Q4SIZhTgzow6maMW9wZC9PT
	RRe+3HW2sEaljdHDbZbroG34EACq2jSYNsvsc9KknzxuCrJ65CM65oYF2Ji9WUun
	h/ljsQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcq32qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 20:39:23 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b0e5f28841dso1674162a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 13:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747427962; x=1748032762;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dsl1htn5szVmt/DjssSO8gALKifNfg7gundf833ygfU=;
        b=UgpN81WRTrDL7VLsro3pZhv369hi0SyMASodtLScSsoWWfKXyVONqqYvGHYISPlkXi
         GFGKYp0lkM9PU38B4KDDpAeZKBo+UhlmiC0L6s6r5JAFLgDYnQaB8tIIzcQ7lCQNwBGW
         6EgX8MUFYLlc2eiQV1riu2BBeIrRDNr/1xN6KBjQv/CIV5zYtmkerBnPF498b/RhdlMi
         IEGVDzh3bCN3ESYYs6vCq4C7fiL6Qatih2kiTb4W8CfKrunDAkKhqyDG+UD+r/rUcktF
         7hZDqQDA7tQeLvVNmYPmbnH+9bh8G1uNryrMDhO+4TFlMTPrJnDhyGR8k8e+LZ7Op+Yu
         KUdQ==
X-Gm-Message-State: AOJu0YzB1vEOKMN5sF5gzjE2/ygfpWz6v+W4MyQiZsGfhdTe/7sQxJM3
	jA3gNBZTJXp3uStuVx6ABbydtF/2DVhHEXhJHf6OKAk5EXCA909vaFE6+quzrNRd3YJukOhP8Jp
	lqOBIf7ou9qwWURbVjDNWRsI2ExS6WxpT4RIvPlZWrBP9900bYbg1su+jeI0E6RJJkzFgKg==
X-Gm-Gg: ASbGncvjBi5d2HCXlQzttas82hN5ltxvVyQwG7riTgTuf1/0L8v1UKQlEOl3s7vgCYA
	V4QYb7TawPJBZ3e672SkqtLEwmWJzArF6VmiNigFu18dvAHmSr80wlD+VM3uUre22atXd7wbBG5
	GjGKEa3RZ2SkFJXtzyEWMPq2cm1eKWTBeu4c7lud2pjzH/9gpo9AIDQ4V8YsL3AgWZeKXV44mGS
	uaKFNipqToT55CtcE+zIpXj4IoEgdpxFlpitbiTglfBAWwBND3lLfpkdusdfa6CcMr7MGexWMJv
	iIkeG4Fs5Cm8rmbAmFs+BPmJPUH3chbrguV7rdOwTFP5idsS
X-Received: by 2002:a05:6a21:3292:b0:1f5:535c:82d6 with SMTP id adf61e73a8af0-21621a23ed5mr6962659637.35.1747427962563;
        Fri, 16 May 2025 13:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdnqDBYsy4Rfl/9bwENaxiqyNWk+xvOv+FgTF257ZoHBlElCFKl3HqX8MypcZD9JkWMDAD5g==
X-Received: by 2002:a05:6a21:3292:b0:1f5:535c:82d6 with SMTP id adf61e73a8af0-21621a23ed5mr6962625637.35.1747427962171;
        Fri, 16 May 2025 13:39:22 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6e6a5sm1976743a12.17.2025.05.16.13.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 13:39:21 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: johannes@sipsolutions.net, ath12k@lists.infradead.org,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250327051320.3253783-1-quic_ramess@quicinc.com>
References: <20250327051320.3253783-1-quic_ramess@quicinc.com>
Subject: Re: (subset) [PATCH wireless-next v5 0/4] wifi: cfg80211: update
 EML capabilities of an ML Station
Message-Id: <174742796155.3569414.8147767849529527005.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 13:39:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: Ms2kl4RL_kWB9BlBfSSRCES_UjSMCnh4
X-Proofpoint-ORIG-GUID: Ms2kl4RL_kWB9BlBfSSRCES_UjSMCnh4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDIwMiBTYWx0ZWRfX22EkNUEapNp0
 MlsuqKNkGydOOZ9mkb+871w/De2t2JKr6VnU5Uc1i8NLNp2i4hf9zsz7c3fTsZpdU+OQ0mO27E8
 Vihs+rKxGEnU9JFDYHFQEUH490Fk4Za4EM0knmtciw+1mdNk7/vN248ZvRWtb33cu6eXNlfVz3e
 2DwnR2LTX211kc1w6VkUa1OeuvTXnVtPAYSYAepH22scn7Dg+QW0TZtq197DSw/XrWU0Z/oEZgv
 PHGTiFGUWnb8IhsTrpGG7Uk51tMptl3/EpJ/Ro7w4aFfki+z+AyefAaBSRjF4KdO/i/4LdbtEcC
 ti5/7a2HbovhtmV2WhgjGtwXhj8Th3laCQRQJca2aYZFOKo0/ifkMT673uHCVAlEBHbxOL1QbSt
 GAVS91PlSsnT49W9ry1+S2F9LVMxnB+XHhnujY4TvMnk+o/0R/StUzIzyGEMveoaMOXrApwi
X-Authority-Analysis: v=2.4 cv=KcvSsRYD c=1 sm=1 tr=0 ts=6827a27b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=m0kTWXEf_8-Jg5hTxMkA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160202


On Thu, 27 Mar 2025 10:43:16 +0530, Rameshkumar Sundaram wrote:
> When EMLSR is enabled for an ML association, the EML capabilities
> advertised by the ML Station needs to be updated to drivers in order to
> trigger EMLSR operation.
> Add support to fetch EML capabilities advertised by ML station and
> cache it in ieee80211_sta data structure so that drivers can use them
> whenever required.
> 
> [...]

Applied, thanks!

[4/4] wifi: ath12k: update EMLSR capabilities of ML Station
      commit: 4bcf9525bc49d2ee2fa17950a26c43a90ca006ba

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


