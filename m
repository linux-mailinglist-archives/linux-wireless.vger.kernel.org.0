Return-Path: <linux-wireless+bounces-28319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A0FC0EDC6
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 16:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B21F501E65
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043522D0611;
	Mon, 27 Oct 2025 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d0o/shcU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640D22C08B2
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577313; cv=none; b=GCV0lV6l5V6/4r22e2NkhtsQCPiY6TfcW2gP8cqLs2gJgjaKTUK40smwpdXQCB7pp5rDmlSz7FQxh9RHYf1JyCraaniGio+PttiKk1ej4QJn2eXF14OPtf5LOb/sxRofroCSICcLZrgWWZch92mX6f3/CpMmNdB5mGD0ryk+K64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577313; c=relaxed/simple;
	bh=QLqVDGKVKT0Vzx9Z1Px+JIv6i17b5HfUWfDL1/spq64=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=DiGZTJHXdynsdJoAO9rPuwnFgbtejywAy2ZJ82oSCjvdvKrTpoFkiK3+/7PFTGcuNszecXT2q5D0gmz1M+AShRQngrWOWfhYgtqbSNwdYObQMGmaoVs+Ak/W8UhrAUbnBB1vOZL7lOADl+09wBkN33A8bp9U7Anu9x1ieM+J5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d0o/shcU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RCLYcb2753176
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 15:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OCOrSgOblqXWig6OfCFVn8
	9kjpCjlnAQHN6FWMG46rg=; b=d0o/shcUHoGwdYkJx/43muxD6H4lTTPZG4Uqtx
	kGG8WOo9rQPg+LVFxMSfGq5H37eg4VDrVLQKqi+rh1yS1lHI7oN+UtwVK/GQMPjc
	mlXickZfXq1bFJoyRtCNo9NBKs0uGRGHmxSL/5IVBTMC7ViA/fw8mL9mLAi+lTWH
	CL+TlRXnssNx3C7bwhhvwyL94Zi4Z1d0/SAjypiNIHto9h3Jq3K2QkFKCXbGvFut
	ESeCDh/qTvsLXUkvQiMGRlG7w+bvfeRrmbAuVckBKv21vmk7uhgpqmeEl08rgcx4
	fYwhGR4oCNJmuPiKo/Xi0zv8laZlQMWfJL8R1K0eKpehbIxg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a28nsrhek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 15:01:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-798920399a6so4960398b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 08:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577310; x=1762182110;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OCOrSgOblqXWig6OfCFVn89kjpCjlnAQHN6FWMG46rg=;
        b=fIHhWKhGpVJ6RseKA5hh6IQcpoOpIcxHc7yeJgh5UMwmChu1UToUf0lN+yLB+5Wb6q
         q9uVsaa/HgxJdOijMZblF5DTIe6XuhTdlOEhbuEvO3hXxjvSEi/FiUX4TA8sCvYhX9rL
         o+cRZ4ulFDhV4VZ2GcbtiTGcab1EyYSCERIffpkS5ALTX8YfIiUqmXEkXB+1bHqwoBk2
         7/Q6P8VPtbxAXGB19f3kOuoy2tlYrYJsHT8ROAq86sJo7+niODXXzPCWg59KP7dfFNNr
         61FgKzPlGLdCu0eg+msm1kHslp+5ub1bBovKiN7BVmj9x+b28YU9cZM4riPlTrHOzvx4
         YJfQ==
X-Gm-Message-State: AOJu0YydfU2eYuO1zRS6sA6JJJTAozpeSlN9Sjrs7P2c9qjdvsPe3VY3
	DSgzkQhlbkuDgBHbJ5iXdBV/VcDyKTvhBHSwh1NgoBFALXoTSSVVVffOkxXRpYRoIxzMViwmlT3
	U2WM9Bsm+G0+gSbo1gYOdd4sd+U9SIthbEcqAVVHh4kHxMH+qy6AMqwyWBfiihUsi7SmST8DPtN
	1rsQ==
X-Gm-Gg: ASbGnctdnU9CcEFBm5DcE84R18oIgvSLVkZ5XHbIbm+Nll9/MgNupsQDAJxB0dIcVTk
	iSSEF395osYZYSIAxeCRLkeAVrrcfGtINExv1hXtfr5XOzgnazU9pKEC1KArZbg+8+hy0tBEg/W
	6E3QuaTUREjukLmx73seq0zEpjRCjIwG97yRR2h3frjYjMdsiQTvpgI5qYczmK+kLslIY4VVTMp
	7mAHmv3Y3vZcsYhOWEP7m9PBTuUm8xojwtEYtW+uLr3Lp5tlr4OFtupzHdX21HByaV2sXi2Ohez
	N6k8jcgeZ4bQbnNwbBbnLyYmMWAS8yvmogtoYlZ/j1EfdL/4QJ4MlD7fA7AW1nldfIhh+KBQzJQ
	s30Pfx24y00N6qDgtYjZEvsoi+oOqAMvPEGQ=
X-Received: by 2002:a05:6a21:6d94:b0:343:6c90:77aa with SMTP id adf61e73a8af0-344b5167005mr468356637.29.1761577308082;
        Mon, 27 Oct 2025 08:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrvvBRv7oKTSELHMmBANH7x5KQyEPgrSTWh4Tjr+xrvgbNF7sSM/4PBKdW1pG8CYbqDyIRmA==
X-Received: by 2002:a05:6a21:6d94:b0:343:6c90:77aa with SMTP id adf61e73a8af0-344b5167005mr468285637.29.1761577307219;
        Mon, 27 Oct 2025 08:01:47 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140530d3sm8590390b3a.40.2025.10.27.08.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:01:46 -0700 (PDT)
Message-ID: <e7e3ab9f-f477-4e84-8a5c-609fa1834624@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 08:01:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20251027
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE0MCBTYWx0ZWRfX1RSicK9JtyJ6
 Y7iHYjyxd6SKwHYMumKj9bVWsswKZQc2DMrGI1Pcm78SH4pLlaPUE2xceRK+wxK+b3CNDrQQhst
 X1ZvXu4/V5MF2uwt9U/Y/4tjtzZXiq1nIlkwVdR4N+9CgtwT0fuJN1w/CEbhNZQ6GmP/0d7/vza
 1F1gD7qp0knCVxdkrcMBgVD8H16liWgu1uPS1V0bJDmGjTH7WkWcD2qwvP7975nVHrZnMwfGKIj
 6OVIjrl7Jl/c5EOumm2WS0vbY2q6asLduv/9j69voOzb4kLLidOTt7Yh9djXzCPrEwMBGRyrTKt
 llTwnD+SXkmnmokDR5JLnQDJChr2sRZCOnE5dzqYUNqNBkOR/ResFqpe/jkrYISQLUiehfk9hoh
 B2MFjX6bA4IL9NJwo00Ut85tCaNCIw==
X-Authority-Analysis: v=2.4 cv=RIW+3oi+ c=1 sm=1 tr=0 ts=68ff895f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=-r_gnQ9DsvtphcIF9MQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: gScEZ3ZFnWi-syRDJrQBdqzqHYIHfF8N
X-Proofpoint-GUID: gScEZ3ZFnWi-syRDJrQBdqzqHYIHfF8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270140

The following changes since commit a83155cc4ec5dd8c99edb541dc12d3bd8e97eae9:

  Merge tag 'wireless-2025-10-23' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-10-23 17:15:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20251027

for you to fetch changes up to 2469bb6a6af944755a7d7daf66be90f3b8decbf9:

  Revert "wifi: ath10k: avoid unnecessary wait for service ready message" (2025-10-27 07:35:24 -0700)

----------------------------------------------------------------
ath.git update for v6.18-rc4

Revert an ath10k change which improved QCA6174 but completely broke
QCA988x and QCA9984.

----------------------------------------------------------------
Baochen Qiang (1):
      Revert "wifi: ath10k: avoid unnecessary wait for service ready message"

 drivers/net/wireless/ath/ath10k/wmi.c | 39 ++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

