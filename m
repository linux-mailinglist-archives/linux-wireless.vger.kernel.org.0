Return-Path: <linux-wireless+bounces-22184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB415AA01B7
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 07:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D7318901E4
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 05:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2831BC5C;
	Tue, 29 Apr 2025 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pHErKgJm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFCF53A7
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745904174; cv=none; b=XA3xqxKgs3PdEA6aOZYa9uBRu+zYX5c1biKrSM0kqtsbKAMZZNLYPp7lpuh8eu8BtEDZd5UQuJdLl5EzPzwoRgaDWle1ES6DOT6QIsH4G9Jev5SgGMdtSkvp2KVEHKH0LyOgxPB1bx5S0UWTDbE/8ojGx2uX1JjDoY+cJhYs1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745904174; c=relaxed/simple;
	bh=BL/LC8DpJ+5yqvVW5mURJa8I3KMfoLH8Fv07qSqk9uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e66/K7hg/UvGVN8UTLZvNmSOmNcjqL/eKE/jyCGHL9jK9RK2I56a0olal+x23/dHjdLObbE31rihRu/ef/9d1bcPKetI9C8FxHJTSqlHdTXwnIWBdGWFSlHUZiQj/sYoqs5Q/uO1mc4Gz2B/5KovcVqItZMmJr0tnRK6Rn5O5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pHErKgJm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNqAOe030686
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eHju9dv8AbgTtrh4Rh+8EaZhuXoJuvizsQH/ia8kfRM=; b=pHErKgJmHB21NXPV
	clUfGkZxB1TfUyv2XyImOoorta3DgPmcVWy+HXiiRBAGiiKAhyOcK5BKECjL1a3s
	pCkJrGXOugBITbxM9Xuu3oZpxL/dgZ1WPIar86MIN7i5XnPC4jR5uH64CP62Jmf7
	sEGYqDk4+wGtSBF+ZBu/T6hh34XFMgAmMO6HOTsyYYiiZmkblRohrux9JaB86L4O
	8hB2yNBEdDcXEIrCdu5EHuH6yfMdVnGAq10PLIg602vOBsMqLUk65E2NHUW01muO
	d0p9dD+y2d3lT4LGqiX6I9/BfOQBtxr0PI1KsxFJdopDVbMEGBJtp3eXhxhwEtd9
	1KL/fA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468pevje5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 05:22:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2254e0b4b85so53587695ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 22:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745904171; x=1746508971;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHju9dv8AbgTtrh4Rh+8EaZhuXoJuvizsQH/ia8kfRM=;
        b=XNsygdVynAlQneXCpC3h5NlgZhkUDxYncSqqeVe7mTYk63Gzzj351UVLH5raqofJ0W
         Ue+iBrzfCnLtMG7SZGHLuB2q1vecIJqbEiyUsMtbM0zyyZN5hAFSU6u7g+WqGM298TSo
         YPavOR+tbZ+UwsRJFsbBOIK8B3VbqL765KEHZB7/99cNKmc7K7O/iKtSmKuSAT1GtYu+
         NKdneE4F9UO1Mr5NiNSagh5/EZ4IN7JCR20C/UENu+Ck3w2atw9/0J4YpAMM68husjj5
         Y+9T7yxwchg/t6o2GxSdRWLVhL4+ejXh/iPkOgjAEvxWpGyzUHDq2Yr09dmqcZ1NWRlV
         z22g==
X-Forwarded-Encrypted: i=1; AJvYcCW9oKLyYOds94qA5PSA8oGV36BCcgL1hjciMU9TIbVHrN3JDb9PME5qfuglTbS5bWH/9d/k/fBg4egwF97tBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvIjBXigoy+bK85ltbFekItxK8fQeEu3CZ7IIQc9JFhoM3tsr
	TXtK/FpQ2/smENaOKuXHbXmEKMWmzWd+tqcSdUZIBlqGCiRh0cnmUsDrOJG2JRbhTUe3zrxPWJM
	dhWLLUeilUnJ9DPZkR9NZR8UCvyDSjYPtT/4J5+j74ihfw312giV0+y9+3v0iZqJb0Q==
X-Gm-Gg: ASbGncvGWTlCQ5qTiEB+9hXuTTZV7Fw+WighI9gkjUUE0kqX5Oub0BnARfIsrZx8lAF
	8bwGzSKYOjTTVDt4X5FMrnr/UvKfGWFzq/tuK8XLuvisO/K4IucJxvnL8DVdqD+jFxBTVRq0/7W
	xMdC/HeKmrJnNiAyjrNC4/Gns7XoE1e5g69UGci4pnzK7abc/nfNvjny0RGens2wcAHFNoZaKsG
	IK/LOfeC92hdU7JPQainJFSivNSI2kOb2fLjCr5/JWnDkL5Hifieww61XcVAM2bhfBJ0C7HmPHo
	hIcKK65A0VW5pEQdyBSxbn6TC1lmSLarepG5q3IzIqJhxOI0WqSnOg==
X-Received: by 2002:a17:903:41c4:b0:226:3392:3704 with SMTP id d9443c01a7336-22de6c0b9edmr26765115ad.12.1745904171317;
        Mon, 28 Apr 2025 22:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW6OJEOxRPg1AT+XZjBVv4nDaNye4gjeRQF7wwUXAtlbEMTRNBoGWaUB1qClLHflV5hB5V2Q==
X-Received: by 2002:a17:903:41c4:b0:226:3392:3704 with SMTP id d9443c01a7336-22de6c0b9edmr26764925ad.12.1745904171003;
        Mon, 28 Apr 2025 22:22:51 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a28sm93665405ad.110.2025.04.28.22.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 22:22:50 -0700 (PDT)
Message-ID: <3dc71c4e-1061-da32-9974-b0ec004ab328@oss.qualcomm.com>
Date: Tue, 29 Apr 2025 10:52:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v5 3/3] wifi: ath12k: pass link_conf for tx_arvif
 retrieval
Content-Language: en-US
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org
References: <20250408184501.3715887-1-aloka.dixit@oss.qualcomm.com>
 <20250408184501.3715887-4-aloka.dixit@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250408184501.3715887-4-aloka.dixit@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HjkLiewUnuhHHOvxMTORFYoe1bSLtVyZ
X-Authority-Analysis: v=2.4 cv=aeBhnQot c=1 sm=1 tr=0 ts=6810622c cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=N-p2Yt28-VMXFBeuicUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: HjkLiewUnuhHHOvxMTORFYoe1bSLtVyZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzOSBTYWx0ZWRfX9hujMcTFUOAc TfRgNwx5zbxJGXlXxmk8Xo7VaY9ttoK3Vz0I09tVm8vSeNn4EdH8gJuTweZfAjqTwYgFeQ9rUVx 1O70ZTsVwOkOsHiJyGqLX7t0Onhz9iVtxaqdaubOX8dY9bm6Ue3huGbO1m2AJrrN4+u1gaiULxW
 xKzcmHPSUCztwcJvmPmzkT5wAnWWNT+nCHz2bnWYcHl2l4idfLn+8U66VAHHQ3QUc2YKocI2ry6 pA16Xchfx+nhb8oHINPHCbPjYpm4vBY1vphxaCA6zj/xfnYRMXDPTVi7MtSyafV+sGgzE2Uqvlv DQHdPpu27UofKa1jQEWsQ6svenb1p5y9w5DM1DaTIHp9VKlEVQEFPRwhgemOc0EaepO4HvAllmv
 HvaqKlLeE1HbsC4EknFbCEvIlxkhV+zi2awtsuM7d87/DyWky6RTBH4tpWv1ueZp3ggHQtLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=665 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290039



On 4/9/2025 12:15 AM, Aloka Dixit wrote:
> Three out of four callers to ath12k_mac_get_tx_arvif() have
> link_conf pointer already set for other operations. Pass it
> as a parameter. Modify ath12k_control_beaconing() to set
> link_conf first.
> 
> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

