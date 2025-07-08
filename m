Return-Path: <linux-wireless+bounces-24958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5394AAFD03A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27123A7A4C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3163F2E62D5;
	Tue,  8 Jul 2025 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZsMvs6gT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D862E62B3
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990947; cv=none; b=FR3HvuniydxmFTa6p6xDxrqEMLH6pW/Nolrx7EV+RKjCbRkrzf25VplqVhdyDZMxje4BjDrFajJJPOjSw712LdBfXOVpixRmWxDMlfiYLh5ibIjTOoziWUikfBpSkQRazKcG0BPNk3uhL6ZSmN6DMVqm/HUc1gm7eOWvgCPKBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990947; c=relaxed/simple;
	bh=BFYaNxWGnZ7nSLWM6Pzc8R67VmvEQmwt+4iXF6D+xFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0ifcqdbLgu6YBKhC/0/vD8WZShfpcos3npB+xoBYVE/bFF27p6uPT0ym3usP5hpWTjNY4SO06euwc97e1IXKHFLV9gx6zoEmlPOic1sD5LaCZcVrgvS3jQvdHMBJWMgbnxgyrvbfBNQlgXRmEJSJwx6gIatIh0TH42iQdvTggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZsMvs6gT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAXwW029138
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 16:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wdPQGpjrY4GgzrnS07a54sSjWQm02bCXVIIpJTlgTgY=; b=ZsMvs6gTaosj4sGO
	IrCNi1e0lbPj4ZVCh+XE42Jg1cNH9vUETcPKRtz1VqNAxRmSFwc6IYEPj2PpfuUX
	oFgnebJ6Q51wJNCjfuEtqlZPH6iAakqKf83Rz39UQUXwRlEnPBl9xz3G0AmFH4jQ
	7OFvvc+BHRNvASno6H6e2Kh7qMqB8ikuYOjt+HiEFCiaFHauxHF8YrlJPCU5wA79
	+Ub7QRIFcc8ioW4s7Qr4WQFwoSbOakg7XOuopHOZXV9ucgif2OrVyERC66jZABb8
	KrHIHMUZ1nTsRXoEwBYqAr8ly03njTf95iwem8hrxkVyhS5migBokYKHHae3rMa0
	1iT3Ew==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2b7rak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 16:09:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b391a561225so1745506a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 09:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990943; x=1752595743;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdPQGpjrY4GgzrnS07a54sSjWQm02bCXVIIpJTlgTgY=;
        b=uqjcb+ay8hfh8ENymGeD7f2hcQn0Tu8PGfoSeWPE6h3HEa66wpN/0rfUNJ+OZybXQ9
         JD6gHP+zCBqmfjafeQ45R1nEqkl78RU6HIZDL7wH/yz/oLdz0GuSMUiaAG1ymYPaI4Sl
         xYeYJ4Z6MABHoK2I5fqbDU8B4zj8H7vJJAcLncrQHrse+PTWq3ZcuWW32cn2YlKacz4i
         lTbMqXbMXqyhMRAl1NEB4h1oNYADi8qiJLLgQjEd3v/7yIg1qUH4ORRnK8A+dTVupixy
         DdtYgZqXIngyWIjjkXvGjf4UcfJO457TOyXqootN+QazK21V7D1hfnVWx9rS8X+1V4CV
         TLog==
X-Gm-Message-State: AOJu0Yzc0dR5PVtU30S2BFBijaMPT0iPcsqcJHbESGUzZxNvzWl2OqrJ
	3mKaAwxLqzFiBkqis2ac0K0pEXR0WaAeYK8dkt2KACw7Yc8rCxsxn9odsGDxLij04XxQDLo9Y4Y
	zwiIO6JqylovJdWE3ysnbCiEvDOQ0r3jZ1kQgeXIo9RFPJGS99lSlHavkujq2lwcNdnfjHA==
X-Gm-Gg: ASbGncvBykdp8HbmeP/tJS0IuCWCPW3Ah1PheXuT6l1OmCcyVVJ80xaHIlrEh67P4V+
	0+pp93rUNXqv0BTyw4Oeu8qvSTuWQPWC5ybvAf81mWklZFFVKZAkL8SLkShDK16f5SgHODk8ziC
	U4jk3hjOmO0ew1APlue3aVHcQsXNECixjlvOBBBIfR2v6mGwhe7UISLci39K/Lc+m30Yw1LgtoP
	/rLAzGn7zqIz/BK3tNpewD7Eh1E6/zT5BH8e9yrxQesGnC2SFa10weT8WQcsaxCktsTIV9ZwMxf
	FoBz4IQKXXvGEQIDUIo3uElPqjSbvGa2fuNhoTvOaroW/1efdxbxbCTzMmBLOBeDnExmwJ0Jh3m
	FvQ==
X-Received: by 2002:a05:6a20:7f9e:b0:1ee:8435:6b69 with SMTP id adf61e73a8af0-22608fb2fe0mr26434381637.1.1751990942974;
        Tue, 08 Jul 2025 09:09:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDdSqZgaeBfrj9PY42wr9+md6gJ/VxFPLSf4fEepx827EldJHgP20CH/ixffq8pRXe/85sAA==
X-Received: by 2002:a05:6a20:7f9e:b0:1ee:8435:6b69 with SMTP id adf61e73a8af0-22608fb2fe0mr26434315637.1.1751990942354;
        Tue, 08 Jul 2025 09:09:02 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee63003bsm10688855a12.62.2025.07.08.09.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:09:02 -0700 (PDT)
Message-ID: <ab185830-3627-4af2-bcd9-de3a4791b8e9@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 09:09:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: support average ack rssi in
 station dump
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sivashankari Madhavan <quic_sivamadh@quicinc.com>
References: <20250612114620.1055840-1-quic_ssreeela@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250612114620.1055840-1-quic_ssreeela@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEzNiBTYWx0ZWRfX/fvbcE6UwTtc
 Cv12oZHkhu3fCWf9i7HRtd0oncz4acVcSpUcNskjKQSQZgxq2gjlFoCHi5L/9xLT8iklGMX1C1P
 +SmvTWu104ag2X7qNo+0higGBalEnyZ/efydQGHB3H/PrfONd99j5fwFc/BF+Q5HWAWzx8Wj/y6
 ocKgl7cFK5wnap1HkSXi2Ihcmzh5bQUIzZCy5wkyNQrdO/dIlPV50y8byf0Cjjx2Up3dN3uaykY
 Zq/c+nBLE/B82BoRzf2q+XVlQjGe2ASIH2Y+lz5YD5tkfc8tzKFCv9rkETLSxFaUPpCjqI9itJg
 LRKEwKYlQNKaEnHzpm1nb7jBE1O8or+6ZjvTYJLcN5aDf085tWDbfYi8lfly3Cr/0n/hKURFqMJ
 QUclFXj0KhI+bLMzVHfSJNH4jqLVzcvuRomL8QZuQ/0+LPgQc9G1lZmvN8XYdlP8QjPxw3Uf
X-Proofpoint-ORIG-GUID: 2zljPV6l6DYE1j03h1pP9YihUx5-qzfT
X-Proofpoint-GUID: 2zljPV6l6DYE1j03h1pP9YihUx5-qzfT
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686d42a0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=we9uffyMNb9VkVnrAU4A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=936 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080136

On 6/12/2025 4:46 AM, Sowmiya Sree Elavalagan wrote:
> From: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
> 
> Currently, the ACK RSSI value is not shown in station dump. Enable WMI
> resource flag for ACK RSSI in WMI INIT command to add ACK RSSI value in
> management TX completion event from WMI. Update ACK RSSI value obtained
> in management and data frame completion path to ieee80211_tx_info. Also
> advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag during hardware
> register to mac80211 layer so that ACK RSSI is added to station dump
> message.
> 
> Example output :
> Station 00:03:7f:01:5c:4b (on wlp88s0)
>         inactive time:  46584 ms
>         rx bytes:       955
>         rx packets:     10
>         tx bytes:       769
>         tx packets:     6
>         tx retries:     81
>         tx failed:      0
>         rx drop misc:   0
>         signal:         -39 dBm
>         signal avg:     -40 dBm
>         tx bitrate:     6.0 MBit/s
>         tx duration:    1185 us
>         rx bitrate:     309.7 MBit/s 40MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
>         rx duration:    0 us
>         last ack signal:-41 dBm
>         avg ack signal: -40 dBm
>         authorized:     yes
>         authenticated:  yes
> 	.......
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> ---
> v2:- Rebased
> 
> ---
>  drivers/net/wireless/ath/ath12k/dp_tx.c |  3 +++
>  drivers/net/wireless/ath/ath12k/mac.c   |  1 +
>  drivers/net/wireless/ath/ath12k/wmi.c   | 15 +++++++++++----
>  drivers/net/wireless/ath/ath12k/wmi.h   |  3 +++
>  4 files changed, 18 insertions(+), 4 deletions(-)

This no longer applies to ath/main, please rebase

Applying: wifi: ath12k: support average ack rssi in station dump
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/dp_tx.c
M       drivers/net/wireless/ath/ath12k/mac.c
M       drivers/net/wireless/ath/ath12k/wmi.c
M       drivers/net/wireless/ath/ath12k/wmi.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
Auto-merging drivers/net/wireless/ath/ath12k/wmi.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/wmi.c
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
Auto-merging drivers/net/wireless/ath/ath12k/dp_tx.c
Recorded preimage for 'drivers/net/wireless/ath/ath12k/wmi.c'
error: Failed to merge in the changes.
Patch failed at 0001 wifi: ath12k: support average ack rssi in station dump


