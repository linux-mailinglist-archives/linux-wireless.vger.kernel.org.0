Return-Path: <linux-wireless+bounces-25752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C104B0C5D6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 16:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA4A188E026
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFF32D8DAE;
	Mon, 21 Jul 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPkeFIcJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797CF288506
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106960; cv=none; b=u18kKlX9pu8mSdvYl1KBGxYPpzsbl2KMHe85mOPq/roiWFfuwPYRWnINXSM4iKJPf/hmTRO0IZcbjgEOhHut49aYvGu4CvObhI83t8/QMq4MvXG7Pt1VykUB4CaCid08SJKBh7mzU2eUmq3lhOynkE5JkJdC6+bUJIM/4a3Jh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106960; c=relaxed/simple;
	bh=IcDmBcS7TB+M7WX8XvdBo5w/WLfgKmPpkwJCFg4YHLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBeyOOewMCIVGQihWC8QWjeaK/OQCO/aGHOIgGEGzQMkK0hbkCoSHJtqGw22chAj8QVZsLLyEMB2/sFuqjYSmhzEjR0MG54OfQiy4Hx32a7+VSstlDzRRSBvuU2hENKyPYkPSqSQjFyw1c8ICiSiI0WSYeKumqTvcBeJi3CQh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPkeFIcJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L9x99K000919
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 14:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nUUJkTS2dNGZNjwVuHCijvlfJkFa1kJrAWi3EgXXWeY=; b=iPkeFIcJRZqUTBja
	wGSVKVyz0BBadlhrqw573sthq5YjZEGlRs2WI4WL7KDvZ+GkPV8SVAnjuo2H2Mad
	eSUD0PxpFcrlj1VCjs9Wef7dIq22q6ndQm4kNta+qsQ8QBZncehGJLSqUIxemLvW
	OH3oE6G0/fiy0xX7ZAoC6SCaxW8quOF1LW82pqUBD00YwJbh5qHIWYjdEWDQapg8
	V5dOq7UAGgK6vFM4HP3yCLMdlZIN6hSqIl0ML2nRNF4XWzzKtQzMBnYgCv/RGuTU
	sLMlUdEZIf6DNf7ijEVQzyB8gw0g0gKHFCTOZyX9X6zLcN28kmvVkq0ZosH3ciRb
	jfzrQA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044ddepu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 14:09:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23824a9bc29so68789765ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 07:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106956; x=1753711756;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUUJkTS2dNGZNjwVuHCijvlfJkFa1kJrAWi3EgXXWeY=;
        b=JVqVVYWnc6gCyMHbPvt2p+QYH/Hv2rfc8cdzFdWvM3JvpkUmYUBhUylZccsiwz2z61
         RmQvMiLWrca2fgKojC4z7JUrSlrGMY/GjTHDe9Kdbbc5fJrkzx0O2vtd2NPURNTE7sBO
         SYVM/xq7VZI4LkYLIPysFktRClx7vkqwjoLdum9xWr4MRRHpAWou8ep5V5RDqMFaHQ8j
         athyDlN5VGR5oVerc1u3KOeL7vZRzSdym+PYyouAOng+DQkiZIotD+J4roLuo+e08+Ss
         xEgw6s+IUwj7Wj05jeO7Najx67vMJVZOsAkCfVt7zDyAA2qKY1G7J3g8DOSY8+c38Imw
         Y9Jw==
X-Gm-Message-State: AOJu0Yy9L00TnNwHdKBJaEWTtU9pAYvqBbqKzzut70XOLV/DMy2+cHIa
	sF8Al1wfAzc+FsJE5qOi8yugjUWIBb0PAlCmvNC31NSrQpqg2SF8TG4tdYyFmAVOPrON7Atl0HX
	QFm4p3Kd+qpyLC87w0ZYBV8JIvx769wkIMm1Z6dO/rasYmb0yZcn4b6zuehR2a9tZ3FF44MBu0Q
	5nOA==
X-Gm-Gg: ASbGnctyBnbIvMaqSqDOdNnr25e5m4D4YscKnPJgbQcrX81+x6/0qJCHaI1mtWfG5FM
	qV+/hnyrHtSU2ypVHyOpDs41jnCldcwTkuRf/OGYCz9jnABlcPl7K/PHKX+MG3+akRjV5BYMRDs
	rWaZAyh+kfMgjDDB+hx7hc+syTxRFuJqVKrDFaeZXvT98YaktOquHla2h7xfKJuvj1nubES7ADt
	IlBLWcOU6rTJBFDZrQmRa8UA74fK8E1iVXbTFXb8akG6O/XnBBpFePpR1L51XuuePxt8xkNrvF/
	vfL6yMdNexWzRSQt3yq+MXK9nzgKVdAvKKTeEgTw67BHU7CkC3A34st3ajpK6WbLRMbp4eAjkll
	VxKTD3Hm2rYLP3eH+ydc=
X-Received: by 2002:a17:902:dacb:b0:235:1b91:9079 with SMTP id d9443c01a7336-23e2573640cmr293096725ad.32.1753106955955;
        Mon, 21 Jul 2025 07:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXoJfjcOR+b9DjNkXyq7GaF/ukea4c637suUWWiYFvb766O7yt7nD4LCF1PM+DX339rv3TIg==
X-Received: by 2002:a17:902:dacb:b0:235:1b91:9079 with SMTP id d9443c01a7336-23e2573640cmr293096235ad.32.1753106955580;
        Mon, 21 Jul 2025 07:09:15 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e9efbsm59096375ad.5.2025.07.21.07.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:09:15 -0700 (PDT)
Message-ID: <da13cb46-8680-46ac-8bc2-3513be43a492@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 07:09:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: bring DFS support back for WCN7850
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mihai Moldovan <ionic@ionic.de>
References: <20250721-ath12k-dfs-v1-1-065c31454f91@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250721-ath12k-dfs-v1-1-065c31454f91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687e4a0d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Mae7F14F_SpBrmaiimsA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: g8k4awMAGsfAJQVHVjBPKp5dkqFMmAYm
X-Proofpoint-ORIG-GUID: g8k4awMAGsfAJQVHVjBPKp5dkqFMmAYm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEyNiBTYWx0ZWRfXwuFD09KYKoRs
 FlBwJqHi3Zych7c21Fc4QiAO1s+K4Y3d9sEj8ao3VLHFx4uVZtUhnqRTe4G9FjzKNQbs0CufnkQ
 icdwP5Sp90Mvvdq2ZwfcpTkiLd5DvBFJHASxF9kgZ2RmDnp6lbCwPbJJ+4MdMa61SsvoWzqDaF/
 D6gfe0OUNmsMicTpaxHw1SATXBHecQRzRcUR55nFrw/0GFaV7DBTDU0cRl1CoViTye/mCVFlmrk
 2uiaS8Ph4QBTgEMDSr2V9IF7yvhUBnK732ihv0sdNgCq5y3pE1Hl6mO8bDpneM/LLBcBYC33BRR
 XiDWK7S799Sks2GihXKlYS4qg1q7U0zbP6d4ok7j8NIUW1aCl3gT0UZ24ipvKtQlIgyrMbMSYWd
 aw3YAn6B9dW4r6E58Ri6TosnnisxdiK0jtHy/Mm3gyT3s+DC6+5riY+Kb2nNz6cS3/IR1w9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210126

On 7/20/2025 7:27 PM, Baochen Qiang wrote:
> Due to the restrict in MAC80211 that DFS (Dynamic Frequency Selection)
> can't be enabled on multiple channels, commit 176f3009ae59 ("wifi: ath12k:
> support 2 channels for single pdev device") removes DFS support in order
> to support 2 channels concurrently, making AP mode not working on DFS
> channels [1].
> 
> Revert portions of that commit to bring DFS back, and add a new
> combination to support 2-channels concurrency. This is valid because the
> MAC80211 restrict works on each individual combination, but does not care
> about them as a whole, as far as DFS is concerned.
> 
> This change applies to WCN7850 only, other chips are not affected.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 176f3009ae59 ("wifi: ath12k: support 2 channels for single pdev device")
> Reported-by: Mihai Moldovan <ionic@ionic.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220346 # 1
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---

I'll update this to capture the following from Bugzilla:

--- Comment #3 from Mihai Moldovan (ionic@ionic.de) ---
Yeah, adding a second combination with DFS support seems to work fine.


Tested-by: Mihai Moldovan <ionic@ionic.de>

(WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3)


