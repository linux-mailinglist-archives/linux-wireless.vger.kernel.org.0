Return-Path: <linux-wireless+bounces-23671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD71ACD753
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 06:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B583A6F0B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 04:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1F012D1F1;
	Wed,  4 Jun 2025 04:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OC+RE2vM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD3252F88
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749012956; cv=none; b=qsu0hxSWtLZtK/73zo5oT5SmTdnI2c6IlrhsAIUxcXlFF7El/ECQ8hfGhvm18klfpkhJaB6JptfQyZEAWab+Ot/T1g8JOIcuaQgoxmnRsRtigxh4lz5+UDRGI08fxYpOlEEWrIWr/FQ8esBE9R/Dvajy40gLpWl3OExssQZLkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749012956; c=relaxed/simple;
	bh=c8VB8FWXyyZR5L8tVLU7CDnduTJPAuCYzvJd2K/6iqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVQkXhKpO10GlcxxPddRFOvaVP3/uPknxeUqs1t/6NLpfSm7wI0VgtMarBg7eZG9n1Iid3rf7sJiu6bz1BdVkk7JrD6QAyBDQgDwQg9FtMZuLTdPgzpQJG88Yk463bw0IQVQ0ccuKrLxe8vvScrETg+w4btSW7QiXng69tCYGug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OC+RE2vM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553Leok4010362
	for <linux-wireless@vger.kernel.org>; Wed, 4 Jun 2025 04:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G6xI/j2rt/FbpC5WTd3gyKMGjPoB0WhMh3mpvInl0QU=; b=OC+RE2vMwgO4To2Z
	ZYF5BYwVYCiTYy5WqupvtXrtE2MM7uYd3JhiHABliEUXUpc2NAhN0LkD4RJkr0RZ
	3zvX+KEShGOLYA0SysYVqIomm/tkDo0pKwOtmwpZfWTaRvPo5XiJBVj8dB220Whw
	RPrh/1SATYpJ8+9SVxnPH4fg1MMniaD6b9vtdRZaKX0NQoXLnPOVNOjEeGkSfLgc
	pnXXdbMcyY/Xnooys6d0mM2dRQBgvZ+LNQupTMMca67XmiwfV9EiE1+50C2epiWY
	XESwEhHwkD3JnYXQbChhxXXw5XXGlgiEYrVLB5ZOyUxhuL+WftBpQwm1bo2g1yhh
	Tb2ShQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8ymu7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 04:55:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-747dd44048cso2789297b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jun 2025 21:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749012947; x=1749617747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6xI/j2rt/FbpC5WTd3gyKMGjPoB0WhMh3mpvInl0QU=;
        b=KGUbYoMDLg40V7sHcIex/qgQlqV8Uud4t2MDuc9K0DmrUgzV2dVNq/48hmjRKCy/39
         LummRJd+1RUNIihpgIfOtpTvWsyJJ2RerIittFq9/t6fwQo3DsxBF07N+Ge232xp3HPb
         2p1Ay0JWvycZgZWEZAs86rYR8rbn5zCzS6Ucdcu6nCw+0KeR7iRimrjYPrslHNNE2QbQ
         EVIqzmbmDaXxQSI1HO9L2IQwD73S+ci1/z7biPr1Ult1iZVKYZjMRjXmN4IOxmzz1+F5
         HHqGgUTkEQrk1GL40k9evvMqX09Nmy7W8qsPR2NYp5rHFj68vg5lJOXP6XT2dUN9pkJB
         8ljA==
X-Gm-Message-State: AOJu0YwalfWUL7KtTN3q4JNUTWADaegfMot235nPHCxTjjFRDHmUkvzy
	croWNt8tX1MTBh+Yfi/BjiDekJKB+qUXNsiV4F9zg1uLhgvdC7BPEv+pLGYTenJui1SxzVA+Hbg
	wVbtvHj/vfkYGK+HcfYp3yKx2oAzd1sfdD9/1RlJCYFq4xK75/YvbSiFkTRqiDDJX/ybgxg==
X-Gm-Gg: ASbGncuwefKnOYARUWbqIhMC4c9qsOP4D2E5+Gf0VEJU9XOI4XzQqFIX9cfCPCB4eij
	NNTm8A8Wx/BRW3peEzuAlcoUemR8fEccUUe1Cd3NiLbM+k5/JZ/t1pfY4YLl3cfKt4y961O00Xx
	0cQXP0iu3L1Q6mltH/ofb7WS1XpksfGdtxklRtgP4VSnB+xATp80SliBEo16TcfgBreYcmI72W4
	ckQiNAI+bHx+4xfA37fCf4YVQ/xfAzPd+V/ESBVMYEk6WyU8t+vt39e2GEsDB146wcOORQUPNT9
	2hA1vUPaAZpUQxJZ+p5E+8HOIVle3CF+zqQfupZw5Sr0KHITSNs2zRK1oxq1L2Rz
X-Received: by 2002:a05:6a21:38c:b0:21c:fa68:c33a with SMTP id adf61e73a8af0-21d22b3e23dmr2148100637.23.1749012946997;
        Tue, 03 Jun 2025 21:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrke0SC+6zC9HUdqtri8k0yK+V0ol5laCcwPMyQaz3cgeCVLCSdAo7CbS/kXjM0m44UN0i4Q==
X-Received: by 2002:a05:6a21:38c:b0:21c:fa68:c33a with SMTP id adf61e73a8af0-21d22b3e23dmr2148075637.23.1749012946608;
        Tue, 03 Jun 2025 21:55:46 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb36aecsm7917620a12.40.2025.06.03.21.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 21:55:46 -0700 (PDT)
Message-ID: <d4e44cf2-4fe1-827f-0255-9b77fc91bd2f@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 10:25:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/7] wifi: ath11k: fixes and refactor to firmware stats
 related functions
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250220082448.31039-1-quic_bqiang@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250220082448.31039-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDAzOSBTYWx0ZWRfXz3O3j9Jmxn8p
 v6nFLD2ldsnBo8wX9bEZabbeOeG7PZMvcG1eECTiZAnQktNxnUjh1ESbQ8B6hLiQ8H2KXfmsYlY
 sQb7CojmpvZAOir7oNZ1YtDHIqKyaa0TjEZ19QEeV3DHME6C5ufjkBmOA0Ew3NY7GOqPwuik6f1
 ptCW12XTZFZ7lUXIWVCI0lQxh4w5BMiLllEVjfpXIjnKmN7boKc1T58oZZilzAaAqcktaBQ69DN
 5h/enB8ZppP/BA4WfWLS0cb4se9X+MOXWC/nGZgtYDAePZpHgHhN/eUOL/3Kiz1lyWgNMNTmgKR
 o3zWwagEQRljfjyF2l5zDOwU7XbR976WOKZ2BUKD5DGXLsA2h6eHuFSVDtnTgoYD1AyPl3zB+eH
 Yr+NlTY7bWQIxrLTdRrt7EJ9lWXf4aUr9qMa4TlnTbvh9sXJtHjxUOOWaPVwausabnwlZNHM
X-Proofpoint-ORIG-GUID: UkOdwwcOrAWXNiRZVGy6UaQFs1eA6mNf
X-Proofpoint-GUID: UkOdwwcOrAWXNiRZVGy6UaQFs1eA6mNf
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=683fd1d4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=ZLGELXoPAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Q7OW8kP0y2Iz0-KcJacA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=CFiPc5v16LZhaT-MVE1c:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040039



On 2/20/2025 1:54 PM, Baochen Qiang wrote:
> We get report [1] that CPU is running in hot loop while requesting firmware stats,
> fix it in patch [1/6]. While at it, fix potential failures due to static variables
> in patch [2/6]. patch [3/6] fix potential issues in cases ath11k debugfs is not
> enabled. patch [4/6] fix lock symmetry issue. and the last two patches refactor
> firmware stats request helpers such that we can remove some redundant code.
> 
> [1] https://lore.kernel.org/all/7324ac7a-8b7a-42a5-aa19-de52138ff638@app.fastmail.com
> 
> v2:
>   - rebased on ToT
>   - use completion mechanism in patch "wifi: ath11k: avoid burning CPU in
>     ath11k_debugfs_fw_stats_request()"
>   - add new patch: "wifi: ath11k: don't wait when there is no vdev started"
>   - update copyright where applicable
> 	
> Link to v1:
> 	https://lore.kernel.org/linux-wireless/20241113015631.3105-1-quic_bqiang@quicinc.com/
> 
> Baochen Qiang (7):
>    wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
>    wifi: ath11k: don't use static variables in
>      ath11k_debugfs_fw_stats_process()
>    wifi: ath11k: don't wait when there is no vdev started
>    wifi: ath11k: move some firmware stats related functions outside of
>      debugfs
>    wifi: ath11k: adjust unlock sequence in ath11k_update_stats_event()
>    wifi: ath11k: move locking outside of ath11k_mac_get_fw_stats()
>    wifi: ath11k: consistently use ath11k_mac_get_fw_stats()
> 
>   drivers/net/wireless/ath/ath11k/core.c    |   1 +
>   drivers/net/wireless/ath/ath11k/core.h    |   4 +-
>   drivers/net/wireless/ath/ath11k/debugfs.c | 148 ++--------------------
>   drivers/net/wireless/ath/ath11k/debugfs.h |  10 +-
>   drivers/net/wireless/ath/ath11k/mac.c     | 127 ++++++++++++-------
>   drivers/net/wireless/ath/ath11k/mac.h     |   4 +-
>   drivers/net/wireless/ath/ath11k/wmi.c     |  49 ++++++-
>   7 files changed, 147 insertions(+), 196 deletions(-)
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

