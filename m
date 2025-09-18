Return-Path: <linux-wireless+bounces-27498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C9B8767C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB4C1CC097A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3965E2F617A;
	Thu, 18 Sep 2025 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EhKrss1x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E772F261F
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239249; cv=none; b=DfDLvUqCDMMZR01Z0kaY+YDRClF+/yuHMRL3bxtDccMUKEVcpYTmvsHWnLb0ocSse3wSO7D3NA70WtvKYhYHC2UclqZyGsWVPToPaVH4IYJX3ebhDvJrvhNfiWO9RwGNy62W2lwQVIOfONjKKmSj8dUrxlg0NwppHbtzN4uMu4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239249; c=relaxed/simple;
	bh=TM9J39bFEDuqKfTlYGgszOCl0RXFTEsif0geRbdYu/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NXBY3DTWoGOLN0BAYDW7A9CFCRdN3i13lXl5+5Wkau+XjKH+Od6+DtJPcpinftbANJWA/oZvwN8uN872fa3KkNT+1DWwkPR34lnhI2VLzO7EjeAX6eby/eDzTKYCwc0x30cJ6KHGLHDsoH97SdLzyx3OLWrQjI2pt4xuXTihs/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EhKrss1x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IJHWZt010741
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1geEf+HG/yfdNqdk1eHzom6MIUc3YrSEMLqGnNrlFVU=; b=EhKrss1xmzBZjkpi
	SHjR6PEmG8R3d0YHMOXwERkYZ8n+EB7HVkvb13EPOESdw8f3jp6h2ljIuYolrjyQ
	H1SGGNvHGVb+KjIhnd7c8B9QQpVkYUFMlQSkpv6YrcON9qj7Z/yVYoShEwm0l5g5
	5Ol2FPhAGrzP1kP/1BjrpNnJE37joRRmPosjI81sToqkdjchLGLds1p+wW0bqMVk
	8MbZGkXCr6N1Ooe5g0Yt3YdlVos5eE/CDhd7ZoOojnZlC0CArdbxrJ6oFpnLNDGU
	0SVco75iA347EE0uDa1W3vw8jyNH6+qVxrmOKylb3+afT4V+mP2adR/S/XQJNtf9
	CZLeyA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxy0c7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54df707c1cso1025146a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239246; x=1758844046;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1geEf+HG/yfdNqdk1eHzom6MIUc3YrSEMLqGnNrlFVU=;
        b=h74NeGTuiLadLamHrjSjYA530GogPmjbELEckRma6bBftBFcCsoC61aNTxnVlmBjsl
         +tIEjkiwv6cbsYyUxxu1NFMg+2gDIlOvImlODtd2dlJfvGcjt18ypxjFnkCOPZkM47HV
         YnR6pOYF03joeqLmLGtdPTM8UeVm80bUtIffgHQUMd1qgTtutotFAbv5AXkZ+Vh71QTd
         +3wwWrpW+Sb75EubwdiGddFj5lppO5yo/Ows8cIQIYdFH4OoUeBmmEjkW4Xe4JZe0jkb
         HN0oNC5B0ya1Xf7/5U28oXHt8hIPzdCogbiq+L4kjhz3kzpVCYGmBK6TaqXCCdq8Nltu
         AmYg==
X-Gm-Message-State: AOJu0YySlku8orD2Pccl/tBE8/gFH/mL14OLQ58U5b8Fg4bmBKYObHxu
	GLfARQ2kU0pX6XTEJnUKC3oTgTLOmxouls+ZKXmK02oOq4MvinpkhzYwG6v0kE3/L4WozvrCn6Y
	skz7u2EkaRbyEPxm54mnb9GLJyE9/yjZxANidlrV9ONpdmXrqi9lytBtwoFf0qH1LCXx8AeXv+p
	GLzQ==
X-Gm-Gg: ASbGnctavUBNPkhZVpmEUj3g1+BuTbr1xCux/KFRU8WBjZpXogNXhORPEh9hSenM5TJ
	LMKLcV8oe3zJdEdxdR2djvMTJb8Humz4yM7CsoUDOsaSeUxhqZMzo0wXIGI7/GF5WWCJl+4PxMy
	bAWGGuUmc3nE+MOGUocBEJLVwRGhcaOg0F0tTNOp+hbeledYFhkd4HO8Hn9VLkyYrpaGDlucLb/
	UhWh+N0paooZTF8aMpYnFAMOC+7A/ot2kr7jKHKwujwZq40XrbkrWx0R3idyCoYQ18eI09nO0ei
	cqV5qgWcKBPAA33v/7vCjqYQrZgDvf+OXQmxLKUZKAAesg1K7dFY8bFmzcdy6sJDb7EO3EjAUGg
	E
X-Received: by 2002:a17:902:e94e:b0:268:5892:6a2e with SMTP id d9443c01a7336-269ba59b78emr18223915ad.56.1758239245767;
        Thu, 18 Sep 2025 16:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5vBaKdgG6geuc/SzRujQVu1PvHGzrO57HIIICmV6juDdmP0QWIoR32ANS8/D7O6bdfgxu4g==
X-Received: by 2002:a17:902:e94e:b0:268:5892:6a2e with SMTP id d9443c01a7336-269ba59b78emr18223675ad.56.1758239245279;
        Thu, 18 Sep 2025 16:47:25 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:24 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250826105714.1188131-1-quic_rdevanat@quicinc.com>
References: <20250826105714.1188131-1-quic_rdevanat@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Add support to set per-radio
 RTS threshold
Message-Id: <175823924462.3217488.15602655247503171824.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX53Ca6V2xlZiP
 NVdYwTv9FvfA/HwJJxoGDt43vQwaw2wHuTsIsATaqt78ps8Wy9hT+ZL8Do7e/9Yufv16uforGX5
 LGmed3+tEa5jsSlYos/Ag/HadnZqrwAup3JKdJ2luKKW3cxEmEAeODhKq9UjD5TT3LpP2BGoEH/
 RN+o9onN0s3QWhls821DwolgWVc0W4tQJWQ/6nFHm9BT7jJBz0Fs4saU7KSquJXIGaRN3ADvLxc
 MdULEP84cRGF859kkFxTY3ho0Og+BkMTNbqCtYdPwFiKVyoItzmO9p+IrRMEf7QAMbiZWbzHETN
 TAZK2Fs0xX53WrX/uGn1wi9wgAxgO7vwcKk744ZYzZojC6rxY/Rb3kUn4f1MOLjJSDNOvvxrJkC
 MvzcliZ0
X-Proofpoint-ORIG-GUID: 4W8KhI3YtXbpSXvy4q4PDNdrUjlenChi
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cc9a0f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=TXXe6jiMar1sDwaOI5QA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 4W8KhI3YtXbpSXvy4q4PDNdrUjlenChi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202


On Tue, 26 Aug 2025 16:27:14 +0530, Roopni Devanathan wrote:
> Currently, command to set RTS threshold makes changes to the threshold of
> all radios in the multi-radio wiphy. But each radio in a multi-radio wiphy
> can have different RTS threshold requirements.
> 
> To support this requirement, use the index of radio for which the RTS
> threshold needs to be changed from mac80211 - radio_idx. Based on the value
> passed, set the RTS threshold value for the corresponding radios. Following
> are the possible values of radio_idx and the corresponding behavior in
> multi-radio wiphys:
>  1. radio_idx is -1: consider RTS threshold as a global parameter, i.e.,
>     make changes to all the radios in a wiphy. If setting RTS threshold
>     fails for any radio, then the previous RTS threshold values of
>     respective radios will be restored.
>  2. radio_idx denotes a specific radio: make changes in RTS threshold to
>     that radio alone.
>  3. radio_idx is any other number: report it as an invalid number.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add support to set per-radio RTS threshold
      commit: 87a67cc357a8d01f244ae04284eac4c41c221e34

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


