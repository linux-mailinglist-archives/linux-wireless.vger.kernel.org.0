Return-Path: <linux-wireless+bounces-17978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B77BA1CE2D
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 20:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896911667F9
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 19:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30EF7DA93;
	Sun, 26 Jan 2025 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jgj052mK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6726ADD
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737920658; cv=none; b=Z529Ybw/ckDvqqU+oTin438WNyrZ1ev+MkFYv13j5fzgm1h54kAxwZNxbPCa/I0sxfVrTfTc/6QNUMeaIIo98z1bfJTJbo/Stg3FI0QficPPIHpcfT+iTLKVQEDh1Tf8YEkjpxhayLUZwUGpnlHZbSzMN1wAAEQQC/U0wM5bsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737920658; c=relaxed/simple;
	bh=uUhBHohK0SaiC45DX+Bvb0cTz2qR7g5G0Td9nEgDhr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBiy03q3xSSdo2EHeAPDykUqygXKP0+WdQSfCTHCoXToTUdpTHkyPR2XpOHj0bTmqUMLPANql2edJwBAKCg4W4fEe8wyprmlbgaE47LHIgde19qIMnqCy2+HIsy11AGDS3jtYGBTxRaEb+ycWKdtGYEhgqCLzJAUTuU+EnhdGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jgj052mK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50QJdWTp008735
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 19:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zppcty4/uQ16HqpS+FI7awSafDceY417DKR0YNvbdh0=; b=jgj052mKUkXPEFNL
	bdMCeepNgfrBRZuseLkWbq/EL0pZ8BpY9xhkQCk587nejC8dZhXpl6xzt0YK9cvT
	NcmMUIy/SlRtJfkyLIBX4ibhl+owNsBshkz8Zsasc0G/CAOEEDEyRg8OTMi1FOeb
	hvBV09sgrvw6H+QZTb+O+5k6BerkgQOW6sihp/zradCoer8z6TXGhO1eOCswj6G/
	3vl73ZEJKMJxkzcrzSGUXpeec/8drkiCWV/JNPzZdz624bozVE8wLtU+mRqs2s48
	iNuWDOdH2oWUFDpZA1ZaqrngHfqEBGjORUG/x6kj6Fi9hBt+sla2PFaFK9Y2K5Ng
	6EcQuw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44dsav043f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 19:44:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21655569152so69694485ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 11:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737920654; x=1738525454;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zppcty4/uQ16HqpS+FI7awSafDceY417DKR0YNvbdh0=;
        b=LzIYciI+17vEfbjAibhiDnAqSpBGI+mmwIxgmMQ+2CGOin0mI3HJVuI9AoZTbRIsi/
         W8RQa1Og1/a82+F7DgutRtdi2ysPBA9PT+Zx6kVJcwJf0VN1HCRE1ApN07VnOFv/ngRA
         IsIR8OeiErDKmOB68kFzf8ser2t8WLTe3ncmcXz2dsjlnNmVGhtJUw4BvS4zbPNaVXsN
         DgSt+R0yt9+uQsZItJOSzXlHVNUvVZJ2d5Qty4JR1eF2lFAPelVyBg4/OXUEadRRuFqw
         heAxkcYtnMFjpwsop5pwLYx7xn1RuC6DMhYlopP3JqC4tlSGL54W8te/9fNleOfiyl4n
         FV9Q==
X-Gm-Message-State: AOJu0Yy4OhIXEWgpXYkzMIE5eIGykEFzhjlkT32tmxbCCIlJUcXNFhkP
	w0581hG+/ICDrZjoEE55PNiAJRLyuk941G/2joF9ILrRh4PNx1HYAUnQC9alFFjN5f1/eDyNNUT
	q5OtXNP3IX7yrQEa6Zk8ccTxroj+HWBjZUg4AaAdrLXXid8h81z8HkmpjjLSkgMw3WA==
X-Gm-Gg: ASbGncufx71NOdrb+Rg2TSd3Xd8XLBo9dwyDET8GdoyXrKddj2R76ntrysiAl2Y1/Qx
	oru73DFQpfgUwszUR3176w1sKpWbnDOmvPP0zt3ibky3c6+iYx+5DQ49Edl3A08J9oQ/fA3fldX
	N4AfQN7Rloo5y3PPQWsRm1lXl+fuOxIwtw3qTW3VqjXCdvlaXpcMpt1ILAGLRESsEMQVnl2t6u0
	DYnI/Z6VxHXz55/aK0r577Zc2mqmaVtEsOvotj+izlY68wL48O1Nq5mPQTdpqHav/x2SoRG7R5E
	B3feNkPXE4/i2YZ84l4FHaoE4qBaqb9NEikKYdYfFP4hJtx6sLSSZlUL98Svd9mpBoAdIrhsaw=
	=
X-Received: by 2002:a17:902:da87:b0:216:501e:e314 with SMTP id d9443c01a7336-21c3540d181mr559954665ad.20.1737920654302;
        Sun, 26 Jan 2025 11:44:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwcgvc9tmkTjZVF+OIDMkxCxBDysIhtQ/xvXpuxEuYyELDBP38Vxfm4g8tZfJuRsKlEr7oFg==
X-Received: by 2002:a17:902:da87:b0:216:501e:e314 with SMTP id d9443c01a7336-21c3540d181mr559954435ad.20.1737920653939;
        Sun, 26 Jan 2025 11:44:13 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424eb96sm49386475ad.222.2025.01.26.11.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 11:44:13 -0800 (PST)
Message-ID: <b9a81c89-70f0-453c-9619-5d1142bd91d4@oss.qualcomm.com>
Date: Sun, 26 Jan 2025 11:44:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <quic_msinada@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
 <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LXVp7HnMvGq9n5p96Sqy1gCAshi0l-Rw
X-Proofpoint-ORIG-GUID: LXVp7HnMvGq9n5p96Sqy1gCAshi0l-Rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501260160

On 1/13/2025 4:38 PM, Pradeep Kumar Chitrapu wrote:

...

> +static int
> +ath12k_mac_set_peer_he_fixed_rate(struct ath12k_link_vif *arvif,
> +				  struct ath12k_link_sta *arsta,
> +				  const struct cfg80211_bitrate_mask *mask,
> +				  enum nl80211_band band)
> +{
> +	struct ath12k *ar = arvif->ar;
> +	u8 he_rate, nss;
> +	u32 rate_code;
> +	int ret, i;
> +	struct ath12k_sta *ahsta = arsta->ahsta;
> +	struct ieee80211_sta *sta;
> +
> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> +
> +	sta = container_of((void *)ahsta, struct ieee80211_sta, drv_priv);

we have a helper for this so please use it:

	sta = ath12k_ahsta_to_sta(ahsta);


