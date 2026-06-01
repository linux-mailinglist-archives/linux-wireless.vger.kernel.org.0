Return-Path: <linux-wireless+bounces-37257-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPozOlKAHWpPbQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37257-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 14:51:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D5B61F92A
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 14:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA83A302A6B9
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3C3655F6;
	Mon,  1 Jun 2026 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mzihi2qd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P6DJ/6In"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9CB35FF5B
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317664; cv=none; b=gFPey58sxJ45SuvK6/YMjr4wXR0u3dQmOJX8YDuYvUGfWkNlWvxelnSRH1rn08igbvfKpufnDj0IrS3Dk+mFI47lFYpxU2E78m6tN6XEUGQQwo85sz19jZw2/2/9mDbn/Zl8ZHyytjo/HQI1HhIELmOycvhWtLdEvK/vMWeuhaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317664; c=relaxed/simple;
	bh=MRL3hOEDDn7YPxnmnUXups8WzPpAStw7Od7aAnYHMKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBRvqsF/q19E1PuJlbO1SZR3ih8XxrRDn4Vg1Dkq/3wdxrdrne5Ua1x3AMB/Q043ex6773TuJbevdLvydNB3TKtM/X1nFK82t7WpbaH+qvRCBFemPYuBQuRZAvt1lQIL0UkgPOZt3fLiWHhui9+319by2FMWqCg3jplZ7kw73uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mzihi2qd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P6DJ/6In; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fTe11258371
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 12:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ywLulI4ZuoOc549odCPLhYxm1aLERQDAha6vmGGnqaQ=; b=Mzihi2qd4CSvy010
	AbEmX4rqRjUy8UHqF3Je889kQhS0e3l8nnp1/ay0JyRdWu0G7x/tiQqPWkp9Y0M9
	CgyUYkhyZzjHAUFSMHxy7tCAHtGKmTIauNkYShYjWGNC5nsfBondvjbGsEkB4mQl
	EDbPpTMP1KwGPzEdx6jL0904NK4WXa4OcNnR4hzm7Sw6p/rNYRwgiqvDro/geWn9
	wxEHKOytppp9sM2amda5vLWD/hPuHeX5KNg4+beGrvfsY6PMSjWEVNnoA9cbeR2u
	i+FuVAKFTFRlI53mJ7SWwC9C+/9woWe+PP8SDu70A3FBb21DOxVxQPdbzSYB/VlM
	5LGKAA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6ssry3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 12:41:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8423770d72dso2132970b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 05:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780317662; x=1780922462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywLulI4ZuoOc549odCPLhYxm1aLERQDAha6vmGGnqaQ=;
        b=P6DJ/6InBb3LxqFa+XPSCJWYo7MfC5zRhjM+Ftu4vwqtlKcGv3xt2x5hcBNSK7YxCp
         YTuZIEC2B+Lh4bES0MhBUcJcjavqc9Vkl7Yj/Xr2NNuXKSsfOKk6ckDNZNiuwsb1oZc7
         E9ooLsEENBGiBRkNvj3fvihXO6l08w06YiDbtGRKVbywznZI56X67Gs3LAaLhmSnGzHH
         qWwfoF4oOAjLkyDSgZcSyvV5V5pmFhKpnyM0zo9Z2nRzg8UpOX/jPoegPQoUO3IepDdv
         Acj4gYM/YN28z1uuuR4J4wg0BvgbsIj+cb+95odSfGUHTxYKFkXYYRbyqsDWpTtpSghV
         nu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780317662; x=1780922462;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywLulI4ZuoOc549odCPLhYxm1aLERQDAha6vmGGnqaQ=;
        b=pIJgCTi5rCaAmO9jPI6Elf25P3xlPoE8mD1bZZxXiEin6hVyx4Y0/8l5tYRVB/G1GZ
         Ul0f5Zo6sCYp17sRwelmZxdeUjjHbMqa6nuX/ysQV22605J/vDivWFR9ucqkyEjJ046x
         aqF3IuXCqgj5dJqiMFMIfXygm79Cmqpk1q3BIg0cxXOPNvM5sSW9nky4LkiqU64AZR5q
         w0nH5cLdwTDaN3YUJPhpK1539xY6XSiLkeAnsoEE4ka0E4Os+pQcutSRse6sQTp0u0Pg
         tPlS4Ri8fAZP0kJPOoTJVZBkQNubjFLxlRgVkPZmqq00UIoBmTOpYFZB8ZNNGvmSHm5A
         09Rg==
X-Gm-Message-State: AOJu0YysuZhOktLzuH5yViIisXq+XFn/5S6Coy3rYLHMqAScPmiE8sH4
	OshjpXbxiNAxIIKcxdPD626cIy7t7t2e8ZdGkV3JISgr1idbMT1ER7gcLry4ZQNennLZ5U6MBHW
	O56HAWibCJ41q+lx/82EXQB5meNDaO2J0YeUF5odyh00udn9CgMGHCGtw8b3tIMjm7Hn2RS74YN
	4Tyw==
X-Gm-Gg: Acq92OGk6iGqXWmFL7vTzuQ+1pUXB65E1CLGlP2Zu2oPWrtVdXUUheVPyvpdc7vxYFg
	KOd2oGzhI0UfB0vUfGFUE21f27B+n5CrRiFAE16mPj6at4vZMFscV4r8+5m2rXSjy/Ju9jtrw6j
	1srjnXiNs0gsM5pUU2gcq+699a4ZMvVm4CkDzaW0sPSGtB9kP5E/78m92CoZ235lyl+N/FmF557
	qKAPItVBqsa0arjhlk4URuhNBfimuX4lEa73EtREQMgo2I2fuHyligx0ZArvuosNnFVCIP6ZGci
	iBAuvEKRZ98YycRXC9L3zyJU5Xgf5jM/p1QYq9vp6Oifa/OcYcS6/U2uxIUh3hVrGwbgRmyJdNN
	CbkZ2CSxZKBZKQ7CO17Cw5uHPE7s9y0cbozwWrwkHhBTu1jMd9BE8jyci2gR2mgJnnx8eCY+GwI
	An
X-Received: by 2002:a05:6a00:3489:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-842251b184cmr10375801b3a.0.1780317662276;
        Mon, 01 Jun 2026 05:41:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:3489:b0:827:3d52:5d1a with SMTP id d2e1a72fcca58-842251b184cmr10375771b3a.0.1780317661774;
        Mon, 01 Jun 2026 05:41:01 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84228bd6fadsm7227730b3a.0.2026.06.01.05.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 05:41:01 -0700 (PDT)
Message-ID: <e1c83c9d-50d3-44f2-b5c4-611eb62ef850@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 18:10:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/6] wifi: ath12k: Add driver support for WDS
 mode
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3d_9q6MgUTfwH6mtYBHwg4-Y899XZ06c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyNiBTYWx0ZWRfX3eVgLimG4b66
 ZnZlkcQ5kub/wi+iJLuEE7A90A2ePAxm8aFvZkJvuVUi/FPeGuiyNP/X9EvFPeOzeSKJNT4omfX
 D2/Sk4srZF2ltc8lRvR/nmcmFEuhypByWz/pyNQ1VQGlELpU5VDqEPVXHIq+lLKfw0HYKKEFmRP
 M8arDNFQSpNe6LjCVRB4NjmFJCqmY9B5l0YZ9RtjKORHAeBIISeF4SYFQx/Nk6G2Mk9c/+0iD+i
 YLa5xzqU54cigAtIBLpz3rPVzPogq0jy6SyAyxpsmQdbvxY4VzgdUvj+OzFWEGYtzXslkYQs5n5
 0XFD9/rWlIeEOKRPCieu8up19ClvkKHJHdyLQpuU7gvgycXbbgMyUqK1atHzZEO0JQ09VD+YTw+
 FldJP2vKuXXRh8VgnVJnKLWJmU4UQBGTpPuCbsK1O6vzs/qLc3y9++LU3EoZgTXL1gDkmFbywBl
 K1vBg1o8AZxJmrWbNqA==
X-Authority-Analysis: v=2.4 cv=O5wJeh9W c=1 sm=1 tr=0 ts=6a1d7dde cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=sAaGq3ReHQV-J7jMsY4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 3d_9q6MgUTfwH6mtYBHwg4-Y899XZ06c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010126
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37257-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 49D5B61F92A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/2026 4:39 PM, Tamizh Chelvam Raja wrote:
> This patch series introduces support for WDS in the driver by adding
> below changes
> 
> Handling of 4-address frame formats required for WDS operation.
> Proper setting of peer 4-address WMI param to ensure correct transmission
> and reception of multicast and unicast frames in WDS mode.
> Conversion of eth offload Rx frame to 802.11 frame for mac80211 to
> detect 4address frame and initiate AP_VLAN creation.
> 
> Tamizh Chelvam Raja (6):
>    wifi: ath12k: Set WDS vdev parameter for 4-address station interface
>    wifi: ath12k: Add support for 4-address mode
>    wifi: ath12k: Add 4-address mode support for eth offload
>    wifi: ath12k: Add support for 4-address NULL frame handling
>    wifi: ath12k: Add support for 4-address frame notification
>    wifi: ath12k: Handle 4-address EAPOL frames from WBM error path
> 
>   drivers/net/wireless/ath/ath12k/core.h        |   9 ++
>   drivers/net/wireless/ath/ath12k/dp_peer.h     |   2 +
>   drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.h       |   3 +-
>   drivers/net/wireless/ath/ath12k/hal.h         |   4 +-
>   drivers/net/wireless/ath/ath12k/mac.c         | 124 +++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/mac.h         |   3 +
>   drivers/net/wireless/ath/ath12k/peer.c        |  11 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  91 +++++++++++--
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  41 +++++-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   4 +-
>   .../wireless/ath/ath12k/wifi7/hal_qcc2072.c   |  16 +++
>   .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  16 +++
>   .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   4 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |   1 +
>   .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  16 +++
>   drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  18 ++-
>   drivers/net/wireless/ath/ath12k/wmi.c         |  47 ++++++-
>   drivers/net/wireless/ath/ath12k/wmi.h         |  17 +++
>   19 files changed, 409 insertions(+), 28 deletions(-)
> 
> 
> base-commit: 30d516006fa1f72f957c18c6171f5680dcdebfb0


Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

