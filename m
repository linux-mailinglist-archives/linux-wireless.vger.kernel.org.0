Return-Path: <linux-wireless+bounces-32285-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M46LuhyoWkPtQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32285-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:33:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 346DB1B6068
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA6823013733
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A634A366823;
	Fri, 27 Feb 2026 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R4Lsiabp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="clAm6dGt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846D362129
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188388; cv=none; b=Pqx4btBv0Fh6jeyqibnrZJtIi25+FEB4m2h28mES7kHOQMweH1Z7Icqas9DvIGUkgiJhNrDxp2oPyuQhUjokt6nd1YSV7VbqArospqvQJ8OpJHtkMT6ces5FQiFp2yoeFg18Kx93Ne3Cnot2zmPIdzggji4QQOHaFdLQ0CDMNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188388; c=relaxed/simple;
	bh=ufTv6gTgb6i7Ysx3P9lyK6Ba/LD8fn2ADBqpJUsOWRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHty3uFFONTX0s5GrVOHUiFy5JlABUMPL2WSkjbBSrtUtXURdyHW4vuOm4PKgmTq3oxFbfV4uz2/2iN4FvztAmQcioa1/AwflbiFx+ra3CODL+YClO07rS74X19rYhop3MmRtma4b/3DYbV/BISP3IChHJpxRf2p/kSxawHB5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R4Lsiabp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=clAm6dGt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RAAbJ62439977
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AmleyjsdcwmU6RUWm3nT6zae3j05K+pyYsiW/VZse7M=; b=R4LsiabpcdrIDT3m
	MxZ5wYNUUw/zEFXskr9vxQyQsgNcctuQqNarx5hvE26wrDq3OLndstreWrwPAZHO
	rcZsVB5EHEw4nMnXWjd1LPcroyIwkr7kwly1POP4mDSStUwQxM5Vr6EFchLJ3Ch1
	eWpommHzfMFK2ONuPuzvs3yEdJpLTE+YYNd+XhCRLA69q19lZOqTIOueEijlBysv
	VicDKK/hBI7g2GvqdSZX8mV45934l4ZxQ7kTusnterjL6BmYcSas4UVoxWwznvmB
	EMnJd5ouyzBOHtils3p9uwVV5jDGiB2L64OJ6HwGZpEOc1RzJZlP3WJDV2Ic2CCL
	bjnMwg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cju4r2y8q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:33:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aad5fec175so73152015ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 02:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772188386; x=1772793186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmleyjsdcwmU6RUWm3nT6zae3j05K+pyYsiW/VZse7M=;
        b=clAm6dGtBYgo4fjjU5oMYhYQvFSxdCrNuMgKd2QJOVcVeR+3dLNgaM36rp+qURXZZJ
         uIO4pUHg4fGKwleNS5Nxs4BP9IaYT7psQfrLbSV3+ur8Rz04eVv0yKpuWBtRjO098pAZ
         saeh0eqQybaG7Dr+aSCiQ8n13ooqOhR5djnl7ItzZPd2RG5ySRGwpfYINRBu1LOfFAbi
         aRddVJ1GBSOFF5SA54lEJ4g5z2gFQob5r6H4AHdncVLc38+lRoK6ALKb2UERbD50I6p4
         NPuHsa52UQyZrsNgx6x/Lebz43dWrtCHtJqXYs428C2PvC8iky0/+ByfnfA7VUxiOkH0
         MaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772188386; x=1772793186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmleyjsdcwmU6RUWm3nT6zae3j05K+pyYsiW/VZse7M=;
        b=YVA/S9Qms0pJtAHJfqeEHVUoIMp5VR6z5BCkAKqiYFirSafeRxPXIKW84LrAoIB8yj
         O03jmZYwLPq77IDhpT3A6ZP0zHx7BsVAbqc1q9huerLsOKkg16I9PK3hg5o+bUIFqegk
         hU4bKPWcFVPvfsuV4aMCnodQxeC/lDE4lstOqV+IDdEbAuhgBdnjxXC1QfbkmPCE9htf
         Q8//Z9NFCg8WNvdN4POzANiPSTbf3Enu2SC25NzcuAltmL1pVSzsBV3HZM0AUoQCo0AN
         8F1lQ6wKe7VD3c4N3EBIr5+h+3Ls+pTRqaWTMYtUS4s0Bd8ehbpT0pRa+/W2H86BfV9j
         G4ZQ==
X-Gm-Message-State: AOJu0YwhfxprYO4hD1x2DbLnTiop3Lxtxhuqdx+UotH1V2liOdcBVBk9
	yEmiwfx5+elXBCuBXJwhxupQyEp+82o4qEX7+fhzTZGTeLtm+MW65xYySbawPWZfgKngfAqmpUL
	p9Ux3zsjpkckH4MNlgzBYeKat/GhG+xthb6mSCqJfhPUgPY1EReIQVJ2o8optOahPdxB0Yw==
X-Gm-Gg: ATEYQzxeQm/XbhtzTsg/AyAe/6bsQwVW3Uj+VAC/YsqoGTiLFHyWQRSlDlegW0rPGW7
	4ky7qIjKk4lGK91XE8TA77AIusJMwvRAcIVB+cxalyryEJ2rl1XJrx5akKN+CEWFUr37tQoLvmE
	rSpHkO3LUXC7eac1VHPwml9zsumlVsvZ/y/R65PWDHyNkEQALKVuR8P5IWH0RYou00MK0ZeEaAZ
	JAf0wnojDVHnj0uVKyxu+FaIqld4dizNwNhQw6msWRx2TuK+UcDctHHhQ6Wr+jaG2pMrnLj826t
	EyvFQtlg4RA6PCzN5W29nab0EnL+Ivv37tyQW415ivwnsIKb8bsRmPE20Sl1aiPdrs0vBrRKtgN
	lNRWTFvOHvanl1gEutw53tI6fDkps8R4OLFfLRYJ0Ctbnnsxmj7WLKHSpf7uh8sG8lgk=
X-Received: by 2002:a17:903:2f8c:b0:2aa:d61d:b6b3 with SMTP id d9443c01a7336-2ae2e4bbabcmr25011995ad.41.1772188385970;
        Fri, 27 Feb 2026 02:33:05 -0800 (PST)
X-Received: by 2002:a17:903:2f8c:b0:2aa:d61d:b6b3 with SMTP id d9443c01a7336-2ae2e4bbabcmr25011735ad.41.1772188385477;
        Fri, 27 Feb 2026 02:33:05 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a0409sm80007975ad.44.2026.02.27.02.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 02:33:05 -0800 (PST)
Message-ID: <9a647bdf-640f-4d3c-9fd2-50bd55af1008@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 16:03:02 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Set up MLO after SSR
To: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
References: <20260227041127.3265879-1-roopni.devanathan@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260227041127.3265879-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA5MSBTYWx0ZWRfX32djaaxeKxZl
 +zhPzA972jznqeIhxSCNBKITS3lN7zxFtmNB8y/PdKMzlWnAeOsgMPGLBlw7nawO7gg1npul+2A
 6i0OE4HA/gli6B2SKnjtfV4zMkZ5wCzBRnOyyot/ifopnCkggXi4i+iIiLHOBGeUdDJ52b6fqO3
 dJ/0eTwG68IZE832Revy9JJk0f6guWpjWir6o6uoBzV5PwYWsnn8Qa0TglLJnQI8wSyvsViwk8v
 IzyhiBgFBib+xRhe+lmvWZ/xYRAzjd0vptRZ9Lk1awmbBb+lOrRYBxeGi601OGFWylcIRCd9pLk
 k04LXzDNpU+K2AmzxHArtKzsHASx/6WFZkNqVHSqcl4VS7PPIpLhcbNQUbg72gWiVypOY1Dc4pP
 ruDrAMo7QXmC0S2njWxZ/FiWQyT9271bgBx+/WUwqcRPLY4e0l+EHsn+yCCNVCXxnCrd5cvjN+c
 JcABZ1AF2CjeIvFr+Dw==
X-Proofpoint-GUID: V2vxW5pXTOy18nFG-uzh4YAUhxGuEc6N
X-Authority-Analysis: v=2.4 cv=KZzfcAYD c=1 sm=1 tr=0 ts=69a172e2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_3h4uQTCdB2spDowhVgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: V2vxW5pXTOy18nFG-uzh4YAUhxGuEc6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32285-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 346DB1B6068
X-Rspamd-Action: no action



On 2/27/2026 9:41 AM, Roopni Devanathan wrote:
> From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
> 
> During recovery of an MLO setup from a core reset,
> ATH12K_GROUP_FLAG_REGISTERED is set because ath12k_mac_unregister is not
> called during core reset. So, when an MLO setup is recovering from a core
> reset, ath12k_core_mlo_setup() is skipped. Hence, the firmware will not
> have information about partner links. This makes MLO association fail
> after recovery.
> 
> To resolve this, call ath12k_core_mlo_setup() during recovery, to set up
> MLO. Also, if MLO setup fails during recovery, call
> ath12k_mac_unregister() and ath12k_mac_destroy() to unregister mac and
> then tear down the mac structures.
> 
> Also, initiate MLO teardown in the hardware group stop sequence to align
> with the hardware group start sequence.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
> Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

