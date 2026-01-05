Return-Path: <linux-wireless+bounces-30341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3AACF1A04
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 03:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD7B8300050A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B46D1A9F90;
	Mon,  5 Jan 2026 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="awvbLTze";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pw8k9ONc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFDA2561AE
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767579749; cv=none; b=PWMedleguZqYqdhK6WCFXdNjplNX0vfKjNVen9MENKekcPgro/jw+9BHEJ6coL1b532sQnPYNvuszvQCGlMdqWx5Jyr/LiI3LC5jC6kABkJ3jDIsBS3yA5qJEiQMFtMNfCgxCGWlty48n6IfSoV9KQ7zPfhgbUCDtg5XxXKpbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767579749; c=relaxed/simple;
	bh=Ay2aMGPnmpiaXtixWnu0U4ZoPgRyYzzW5ASNtTM0YW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfmamBdWR9p3TAzcPQ0ZPeTGgBUP78QPsTSl2AG4x3jK4BJtBZC3eTSSb1h8GmtnwC39NuEefeZ8jwoat7v9GufEAMg+Qd51OVkPg5JZW9WiQDVr/YIsOjEU33EuZbHDWW0xDQXaKjiqVh4+gKJgx05uwtEolup2NSiaufmUtVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=awvbLTze; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pw8k9ONc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604NHAV53063541
	for <linux-wireless@vger.kernel.org>; Mon, 5 Jan 2026 02:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4FsRJhkCr/ESd4vAHear1nOT8fKaGVoJnRJCY9ZaTGU=; b=awvbLTzedY1tH9Mt
	f6x6KNBRF2yqQ/lIaJGh+RDJ/SxOo9OBja7FCH1Qlgty2ZDU7my/lvBQOcwafEOC
	/4pTRY0/4fU/EoC8IaHg4rwO0HO33f3lPI0y7ABiXZfGY6nECuK54OOmM/CqrmMV
	sl7g4MMqD9GXxRFsgIe1lkVGx7h4bpcqx8L4NpJJrkxI96NX9nDf9yIS0CFoxga1
	4PYwUlM78/46pZ7YZlLYBseHSdcQWckV2O9xIr4ATB1c/0dwMGES2DRB8InCEneN
	O9e/BxbkTSRRejQzrHII4ThJmG73H85q4+Daf0IZ8OGbkm/mRv6o3AGgHG44S+dU
	gvzxmA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bevd82tgf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 02:22:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f2381ea85so301357965ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 18:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767579746; x=1768184546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FsRJhkCr/ESd4vAHear1nOT8fKaGVoJnRJCY9ZaTGU=;
        b=Pw8k9ONckfTx0F5INI7WVv1aIJxMew2yf0/FCXxi/R6kP3MoYqLjbw98NO/BUdPiC7
         tR6ewFLDDi20Bb1IA7Ez49b5RK80ee6tKzMUQJ5KZRhKq8o8qiV23P6hY5saMSneX4ht
         mKW/S1JgcE8V7rlYWyQuropnT6NBr3G4ZW6ejZUTBGNZlcwuHwFddz4DdrA00UBUNOo2
         YeARqSlHSiqJiXxP8zWNX3XYtBKUYzyY+312OBgwthS36UmkGuawa6RP+c00OFth9f55
         crBop78MwEfpkaScvMiAxaK+2X1WRn7owk9NBdJOTw2+jBOKC4YwXbo4NasPDLAcute5
         jHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767579746; x=1768184546;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FsRJhkCr/ESd4vAHear1nOT8fKaGVoJnRJCY9ZaTGU=;
        b=Lxn8vd3f9VizT4LVZn1OBIB5u0szs3UXCv6YCy8lchAoQHs+FhEZMkfB4VhAnUOMVv
         2FT7tGFQWbRy9a2BW+fp8u+KCRtwHvO5FM6bF6axad0N0lq7i1MOwkphw7An8P199+99
         R3fzMHcagO561UcHEpwVvNWnspNFceqAeU0mk47ukWaeXA3eAEypZTeRYWsmXrXyOic6
         TLgjPHK0pgSpYDWBnwsNBW3aZsfGZAKitTicnNPJAcjLK1F78GuqBcyrjOegz/Yu1HaR
         AoVwBi+QjUapJ5oOYN/Y5LXnQZL6ARmaAGFFpyJ7+zsLatvQCLrL+H79RN4rOXvVrQw4
         HZkw==
X-Gm-Message-State: AOJu0YyE0HePH+LX8LQYLSGPeOT909cfRev1XJXw2rpL9y9soTXbUZSy
	qw65kW7UO+L+SaE1UeCTq2Kgru82WNAo4clrAcANE0qtMg1EpSt7OXgjsduNuPveWSXSk2K3fY0
	UC6d9o/7kFrIzW+0+wGCA9JSKLsPmhWKdl794dzII8pDHwuJ3GiIuLoeJoSrsUsdsioOy2Q==
X-Gm-Gg: AY/fxX6xeIAN9GSG3SMRb1WicxW2MKg+CnMPTVqPEBQwquCxD+8OXijhmQR5ylKQTGn
	IJ6u78vCLtRarJL+424MjZKVVlUDoa2sCW80HN4mVpXtZ08vVzZTLKraEs8n9YgArwx0FiJCcYg
	AbsuBEe8I7ptVA0AjrtIzBy8fqOpTBx1Qwcr9/VKRTigOCbDs58Xc720DifUaYQ1tFgbOJVjow6
	2fmWgqV4GaKjLdS08GYB/DlvBxcOlaOx9yxQYsCTnAxq93hMRHcQEnJ9bWojlg0gLp4RWOy4+MC
	Rvg0hMgUx1gUhLT0kgIhVqR7en9HbGtaH1YVoUhKnbivuwQVBHLNwLHTGi8CODU8g775NbZVzfH
	Xi2E80s7+UufJnyZoXxhXJiH+7AM7fSAgr4sRoJ143loBDIh/qp1qN6ltjO0Zdx4Rrf7gE/vBYD
	SFy7Up1A==
X-Received: by 2002:a17:903:2f8f:b0:2a0:d431:930 with SMTP id d9443c01a7336-2a2f2a494a2mr513096865ad.47.1767579745854;
        Sun, 04 Jan 2026 18:22:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExjJB7nVRkK2WQhSZ+qpovsPM9KrF7bBKN5gmhwMxrVXo9yHwrdF8tG8YH2piAxMFR0j2omw==
X-Received: by 2002:a17:903:2f8f:b0:2a0:d431:930 with SMTP id d9443c01a7336-2a2f2a494a2mr513096675ad.47.1767579745390;
        Sun, 04 Jan 2026 18:22:25 -0800 (PST)
Received: from [10.133.33.54] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cb25sm440862615ad.56.2026.01.04.18.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 18:22:25 -0800 (PST)
Message-ID: <717658b7-91da-4073-a746-a389319aac2d@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 10:22:20 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5 0/6] wifi: ath11k: Add single shot/periodic
 CFR capture support
To: Qian Zhang <qian.zhang@oss.qualcomm.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Yu Zhang <yu.zhang@oss.qualcomm.com>
References: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xF11Cw0VIjJaEYB562msuk7xs7Dn4RNe
X-Proofpoint-ORIG-GUID: xF11Cw0VIjJaEYB562msuk7xs7Dn4RNe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDAyMCBTYWx0ZWRfX25u1isCsdGdY
 WkicHkHika7Xvbj1axNlHn4S27bCQHbFayvjaZSppjeNTCr3D8EK4DmV+GM84VpMT4q4k312CzW
 6aSQTcAwsHI4H5w8M0jAcV0KxlAvgZ85pd44P1vPevih+LrAibA1xrt/PVh5k/Fu/L+Oyi0ayi0
 h66pnYc/zZ4I9SMBdDb4nN9v/eNYrpsZgLXLb7XowqIPwOvApfSvt379ajaT8EKqK9MUUMk6qTX
 4P30a26ymtO+giG6/OdaE+2vG/RyRIo+ZtoqbJPqhOp9iRyB5kByXCSjAF4hZTEFdZU8qaFMS0C
 KyXbiWoBJYKMx0f6EXf6ExaVEMkLnNnhmMegPHJnGti1QN7aLLRdLI+4WVKKDXGvoSbdBDz8igr
 Vn95CQdveWAjdDvvY6qd87Gvdmw+dB0fFRzmNdLph7HflJnBPPYs6UOxQG1HkzCXPLAoYwmbPJo
 OLChj6EyqOpX6XZZwrg==
X-Authority-Analysis: v=2.4 cv=B9G0EetM c=1 sm=1 tr=0 ts=695b2062 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=n3Tg3unRUF8wbe423YUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050020



On 12/30/2025 4:25 PM, Qian Zhang wrote:
> To enable/disable cfr feature use command,
> 
> echo <val> > /sys/kernel/debug/ieee80211/phyX/ath11k/enable_cfr
> 
> where, val: 0 to disable CFR and 1 to enable CFR.
> 
> To enable CFR capture for associated peers,
> 
> echo "<val> <bw> <periodicity> <method>"
>  >
> /sys/kernel/debug/ieee80211/phyX/netdev\:wlanx/stations/<mac>/cfr_capture
> 
> val: 0 - stop CFR capture
>      1 - start CFR capture
> bw: CFR capture bandwidth
>      0 - 20MHZ
>      1 - 40MHZ
>      2 - 80MHZ
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>      0 - single shot capture.
>      non zero - for Periodic captures (value should be multiple of 10
> ms)
> method: Method used by hardware to collect the CFR dump.
>      0 - from the ACKs of QOS NULL packets.
> 
> To enable CFR capture for unassociated clients,
> 
> echo "<mac address> <val> <periodicity>"
>  > /sys/kernel/debug/ieee80211/phyX/ath11k/cfr_unassoc
> 
> Mac address: mac address of the client.
> Val: 0 - start CFR capture
>      1 - stop CFR capture
> Periodicity: Periodicity at which hardware is expceted to collect CFR
> dump.
>      0 - single shot capture.
>      non zero - for Periodic captures (value should be multiple of 10
> ms)
> 
> To collect the cfr dump,
> cat /sys/kernel/debug/ieee80211/phy0/ath11k/cfr_capture0 > /tmp/cfr.bin
> 
> Previous link:
> https://lore.kernel.org/all/1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com/
> 
> Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
> Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
> 
> ---
> Changes in v5:
>  - Restore the author in all patch commit messages.
>  - Update patch 6/6. Cache the phymode during association and
>    use it to replace phymode reported by the firmware.
> Changes in v4:
>  - Update patch 2/6. Remove redundant bw parameter check in
>    ath11k_dbg_sta_write_cfr_capture()
> Changes in v3:
>  - Update related comments.
> Changes in v2:
>  - Update related comments.
> ---
> 
> Venkateswara Naralasetty (6):
>   wifi: ath11k: Add initialization and deinitialization sequence for CFR
>     module
>   wifi: ath11k: Register debugfs for CFR configuration
>   wifi: ath11k: Add support unassociated client CFR
>   wifi: ath11k: Register relayfs entries for CFR dump
>   wifi: ath11k: Register DBR event handler for CFR data
>   wifi: ath11k: Register handler for CFR capture event
> 
>  drivers/net/wireless/ath/ath11k/Kconfig       |   11 +
>  drivers/net/wireless/ath/ath11k/Makefile      |    1 +
>  drivers/net/wireless/ath/ath11k/cfr.c         | 1022 +++++++++++++++++
>  drivers/net/wireless/ath/ath11k/cfr.h         |  308 +++++
>  drivers/net/wireless/ath/ath11k/core.c        |   41 +-
>  drivers/net/wireless/ath/ath11k/core.h        |   19 +-
>  drivers/net/wireless/ath/ath11k/dbring.c      |   50 +-
>  drivers/net/wireless/ath/ath11k/dbring.h      |    8 +-
>  drivers/net/wireless/ath/ath11k/debug.h       |    8 +-
>  drivers/net/wireless/ath/ath11k/debugfs_sta.c |  142 ++-
>  drivers/net/wireless/ath/ath11k/hal.c         |    3 +-
>  drivers/net/wireless/ath/ath11k/hw.h          |    5 +-
>  drivers/net/wireless/ath/ath11k/mac.c         |   19 +-
>  drivers/net/wireless/ath/ath11k/wmi.c         |  147 ++-
>  drivers/net/wireless/ath/ath11k/wmi.h         |   97 +-
>  15 files changed, 1855 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
>  create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
> 
> 
> base-commit: 4465d808fda12fa47f83733a9f7b7dbc29d0ea54
> prerequisite-patch-id: f44bdcbd36af0c3fd57b477848bf4699cade9389
> prerequisite-patch-id: 76c61f8f00aac2a3b9ff31e0166bb12997c2b0cf
> prerequisite-patch-id: 886b24b2496167c304e8ed42b5d879e0ecab111c
> prerequisite-patch-id: 672baf608620c531b3765941c2719ad9d34b99c1
> prerequisite-patch-id: 07c9ff6fcaf4ba464be993caa19eb49113eedbdf

what are these dependencies? They are not present in old revisions.

BTW, if you indeed has dependencies, in addition to these prerequisite-patch-id's, please
also list them explicitly in the cover letter above.


