Return-Path: <linux-wireless+bounces-20518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C646A67E80
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 22:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03AAB7A3031
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE671D9A49;
	Tue, 18 Mar 2025 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iQaRTLZO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432A7E1
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332370; cv=none; b=cVET7Np5unR617ECofy07AyAzliHEsgGAWsqwgTibECCsPmtmkmNz7f3f4B0kUSdyEaERuxfoEcwkTKiKEcLimctUrI1VM7f81rQ/MRXWxrOClB5dyDNVR0RiOlGwPiVMQpkfM30d47fsIJ76IL/6p4d9U/yDU5MGs4pbQNnHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332370; c=relaxed/simple;
	bh=/XV50mWTUaoFoy2fnRlIySdWetK3FZWF9D2TmLm0b8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSaXV+p1gQDkKJsusxKSuUWLTmnj9W6HuHpM8T3JbRXeruFtWd2HgdWs6F7NTbTTelWPYf13HV2k2AabRoDdnubUz85HiDoP4oiiaV+e6P7mxtEEFJgK6EoMfFlLvrS0Wh9NNepCbYm9lDFeVrSa4pAtf700ik3tLqgeGA7K2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iQaRTLZO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52II2KBh017976
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 21:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=k+yq6v8v3HHnAum7+7jnCtPk
	0HsxZODrvCK8fT5xb+E=; b=iQaRTLZOclPewR9kCIWtctFH912QbaM4wa3W22Qd
	ZR9caZsW4SqVx/pe+JyY3VYV4a2tgn46KBV68rFXLZxfp4Fh3SfP4JRyPcNjZYQn
	6YDD6j40GN+Y2jNjy5iN6fKUYTKt6kZJCFmWM/1udW+T1ZO4YBCd1eSOHl+KvxAg
	NytjF2agXlspJ0Iq4aiAIuxXJJjnPDQw0rTcMBl4DWOw44W3W6KJvIBonpFfoKT1
	VeIyv8LmT9EiiF9jA7RPz+DTaTexBJ07oZ7SWigt7rkN75c3tPkjTZsmsHtveB5V
	YgkXIvT9uWk1RPe97XFqTapWopLXVhNDeyFFeVMmWU6r9g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sy1j7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 21:12:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b9242877so1444483185a.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 14:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742332367; x=1742937167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+yq6v8v3HHnAum7+7jnCtPk0HsxZODrvCK8fT5xb+E=;
        b=rDMGKvNWBL0v7p8Z1yWqssWSEQwNyeSef7twXhcWB0cQhtb2ZEhH8ZRflR2MLL4RIi
         VtBhTccEW40GTWrXeO/qTnHLGq0uFWIxh1ep7w37m8E73G11wT1JSazVKwnzBb9/OPFe
         IFXBjEQKitEd0ODnCC9rDWOb6nfnnEYYwy+Dog6FQ29HC4jB5iA2O4ab/vlIuRtZb0Cc
         WVE24BaCc/izw8QHdjlNNNufwpM5bODZ0gk2NYHtkIRClhV8HjzbHZVNNBuUKmVW4VsV
         kt/BdD6bEWJkI9fkzAi7qum1mtuizbQeepUyHK3fxJbW61uvCvEcnza2uUhaic62yuI0
         jl2w==
X-Forwarded-Encrypted: i=1; AJvYcCXm53pScUnlIXnynBA3CSAS1erdXxu7rXo+0jq5BkqemN+pFiW759a5TEAgvKHQuWmfn5CfAErCItS32kwPzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIPtEerZQa+UZMBntwANTMrCu3yZRAGcf7NBuC7E49khc8skn
	TWXwyxfAbUnzUVwdptwh9hTRf2yfeQYrc/x1Cbfo9Y4iIWaVdL3gWiMY7NKGuRNhcb1Ho8e5U7A
	Hn63jhgMNp47u/35iakZdRCXU1+Vus9Ggfz0nZAY82vDQg+wX8RKeb327nEb/emjtKQ==
X-Gm-Gg: ASbGnctR0BX11lLo3nbVt7dXGKvUwCRfn9KaBU0TlABMCP8COGGEbc2qBjOsNriBVHN
	cPz8LvYl3CVf1TNwvXcxN2cDfOPOgYenT+MS3n4LKMD9rbGhzNcHZok+CkbVPMy+BA94rp56kxf
	AqDZliA/gmlmrdErEghK81w2YqWkfIb7akepMQExHB3bbhASZ7PvECyj+8+J4soX0qLiTpE0EOf
	6aRpZNCesGtw5fA8gbPPkBgZBiPfxyw6WB2I+SxxqKtKleU0yXSTBdEZ6PKGGVhZmKeXhLfy8QR
	Z8rRLPX5vu9xbTDfoPGldMxVhUJxhqA8Xn7u5eUECPDS3IDADzgEAROFzbq1G/4MYFuFzx9YZl0
	EJ80=
X-Received: by 2002:a05:620a:2483:b0:7c5:5768:40b3 with SMTP id af79cd13be357-7c5a8469b3fmr21663685a.45.1742332366633;
        Tue, 18 Mar 2025 14:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnufZVz5gRlnk7AOYnKewS8LotM/XOXWouX0li3fq1egAx+1r9AfmpEv7nD0vj12zeT2h33w==
X-Received: by 2002:a05:620a:2483:b0:7c5:5768:40b3 with SMTP id af79cd13be357-7c5a8469b3fmr21661785a.45.1742332366307;
        Tue, 18 Mar 2025 14:12:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba882806sm1761383e87.191.2025.03.18.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:12:45 -0700 (PDT)
Date: Tue, 18 Mar 2025 23:12:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: linux-firmware@kernel.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Christoffer Sandberg <cs@tuxedocomputers.com>,
        Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH] ath12k: WCN7850 hw2.0: update board-2.bin
Message-ID: <iffofcri7ah2pwu3b77z5zfsa2wkzl5mcoarm2any4fdcjvsys@o35roczyxb6q>
References: <398de7cb-e455-4cb4-98e8-31471bb740a6@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398de7cb-e455-4cb4-98e8-31471bb740a6@tuxedocomputers.com>
X-Proofpoint-GUID: JcpqNQGATbnF_7khgNLo57S4U3lH5pYR
X-Proofpoint-ORIG-GUID: JcpqNQGATbnF_7khgNLo57S4U3lH5pYR
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67d9e1cf cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=yDUiu3_GAAAA:8 a=vfnCp4mGswuaxUiX0_UA:9 a=CjuIK1q_8ugA:10 a=dK5gKXOJidcA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=gafEeHOdjwYkg5oUpzAY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=694 priorityscore=1501 clxscore=1011 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180153

On Tue, Mar 18, 2025 at 02:40:18PM +0100, Georg Gottleuber wrote:
> Added an additional board string with qca-swiss-army-knife:
> bus=pci,vendor=17cb,device=1107,subsystem-vendor=1eac,subsystem-device=8001,
> qmi-chip-id=2,qmi-board-id=255
> 
> Tested with 2.4GHz, 5GHz and 6GHz (iperf3 -t30 --bidir)


Please follow the process specified at the kernel wiki [1]. Otherwise
the next update by Jeff will revert your changes.

[1] https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/boardfiles.html

> 
> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> ---
>  ath12k/WCN7850/hw2.0/board-2.bin | Bin 1986952 -> 1987068 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/ath12k/WCN7850/hw2.0/board-2.bin
> b/ath12k/WCN7850/hw2.0/board-2.bin
> index
> 48f18e23014c4a8d1d771c4bd1ed1ceda00a33ef..659acff5411e6f10accbf227b46088fa83ec0291
> 100644
> GIT binary patch
> delta 89
> zcmV-f0H*(lqj~(Jd4PlggaU*Egam{Iga(8Mgb0KQgbIWUgbaiYgbsucgb;)ggc5`k
> vgcO7ogcgJsgcyVwgc^h!v>f=90qB>ptr1g~OqCpV0WpV9l^nNEl^r>}c)}mC
> 
> delta 87
> zcmV-d0I2``qj`v<d4PlggaU*Egam{Iga(8Mgb0KQgbIWUgbaiYgbsucgb;)ggc5`k
> tgcO7ogcgJsgcyVwgc^h!v>f=90d$wKtr1g~OqCpVhc=cRw>Fj?#=AG9A7=mn
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

