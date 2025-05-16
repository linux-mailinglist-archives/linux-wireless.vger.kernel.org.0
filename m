Return-Path: <linux-wireless+bounces-23098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073E0ABA43E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 21:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFC9A40733
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519C327FD60;
	Fri, 16 May 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LpsgOArL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16025487E
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424434; cv=none; b=jc5iOwfNfiV9HxXEAObdwmb3grmg5YgaeUhppzZRvCyxUv9Ewl5LcEctpveqKcnsNBBThtW11EkuWdwoLtWWCkWNNqeqis4I+q7HxlM8mKwjeaFibu+8j2ga97UZY/Zc5WZZ3fkDa5kZMCFW7DbVWAyub58I7sQnw70r5HQQuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424434; c=relaxed/simple;
	bh=Dke5viz5DkYp7SAwu8Cf1opH5fNIs66Ce7w7D+pJw0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sbuhdPSWioibPaeNAs3KBuu6uIhBcTjExk3SdBNEZWuZVAcPsC9Q5SBoYggIh8CbM2uuzzRfhIv1hpgqXpo9K0WVzl4gADz+AzEvFvb8BfnCV7kUy7Vi7j/7KvDs5h1NWZTkyKs2cL5gSMd/4u/Ey94Wg7HZzS5Jo5GnnXmnuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LpsgOArL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBYB6Y024398
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5G7ksd0wXjHCiCnsoecac/SagfBtut8BWKbVXx39nk4=; b=LpsgOArL4Lh2Kiok
	Pznd+NmIR5t0OhXFEhtzsRUOFmjpHtiPDE3whGT7OW4CwxUebgIqmnvDnSYtzfMY
	GbB8+jl0Chffpd81txe+KbFv1FG3bg/r1F0sxOgWJlK1ABCZ8fIU/bbtgEVAiGD4
	qh7YCqNJEVsufgpDJKUXzFi40agAo69W6ItEIjt1PYeOzn4o7PlsecHJyeT7I5md
	tWXhSlCLSOPDX+yhC02jZVhIL6BnvEWH7B2Zn0PTEbQayHgWEfX61/VM0dZ/muDe
	NsAfFfeLDAFFFBUQNXXqjXJkS0mB4JgHc8OhYhrpGr+jOEUmzlOG3sWKzdpOecfO
	3ya4dA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcn3751-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22e50a45d73so23503095ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 12:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747424430; x=1748029230;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G7ksd0wXjHCiCnsoecac/SagfBtut8BWKbVXx39nk4=;
        b=vND+lqsL8EMU/tCNyPzCBXOd4sQWEJWBQNyBpiAS/wu9JAxSCAp0QAO7zkxWDMEEjU
         qpE29woHmjcomCWRYdiKND9QYKjprrpbix9kLCZCby8tdsvVDel09xR/pzkQlHDVZ19Z
         1/ZGKcM4CNqTIdMJpmSkwTL6XPyJpQPN4W6A7+NPYieGxlnxIWJbGfEI81hTfi8hlNpk
         ZxEY/ucqlXHKJsQR8msfW98IOBwvZJf/s6iy6HUQpel8d0N3A9BX+1j4axI+b0cSwhWs
         +NQwW0hucznvFjKy3niSVV48Nw/YaFPPB6WO+DQIcK7Y4iL8ItP/dkbZKGbmhNAqSDu+
         CUJg==
X-Gm-Message-State: AOJu0YxFbg+5FQhIWj25TcdFShWvtkTXh35FhXddn0HlrgpwbGV2CZRP
	aSRtNvGUuQ52shUDq1BXm+8xScOCLd7FmZ60hGtUlWS3scIKPZj9qCPmShiAvmS/nqdCLlM9fe6
	hNaSGaO6P3HTssn74eEJCBe5xxBGWkapPjLkZfSuemRy5C3Uu0djtfIsgMJHGskxk3V4Qcw==
X-Gm-Gg: ASbGncvpXAoKwKyFKBtkhBVM/qpNnNRJS0N7DhvQc4sFIq2M8/CeQTff8d5vGLvBx/7
	I0VUmNIp9qW36FEmDappWv3NUoWxNkmorE1OVUlPxjZlb4UwVEmuzuE4vwH3wU9toh7XlQ+iIvM
	pp1AANFiXRSzve5fP8kgT51aRK/1F3PwZfWzBlIetBR9S8/As0ooVXe4BS9vKvHbk5ClgmFS59J
	pKXv0ldBnSGdSSuUqelHJnoB3JubK/1xrXniR259B6tGntGhnXUsLFmg7E3z+zAgTSf2B32EjAj
	3HBpqNi86eQdE9jMFm0l/RsfDHITvyMkdJSo32TgCONMQD/W
X-Received: by 2002:a17:902:f54a:b0:231:b7a6:df1a with SMTP id d9443c01a7336-231de3ba25fmr45392895ad.50.1747424430252;
        Fri, 16 May 2025 12:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqVFV7Kgb6vfQ/FeDrtMUl3/8u4tdcjBCZnmJAEL8s50lZlgCge7RMn6WiFDEbR5w5NzOCcQ==
X-Received: by 2002:a17:902:f54a:b0:231:b7a6:df1a with SMTP id d9443c01a7336-231de3ba25fmr45392675ad.50.1747424429850;
        Fri, 16 May 2025 12:40:29 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97798sm17955255ad.147.2025.05.16.12.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:40:29 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
References: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
Subject: Re: [PATCH ath-next 00/15] wifi: ath12k: add support for 6 GHz
 station for various modes : LPI, SP and VLP
Message-Id: <174742442913.3316767.4054734425093603053.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 12:40:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: gf4LItzgi1_dC5gJM8tZp41bs4bJO76T
X-Authority-Analysis: v=2.4 cv=HZ4UTjE8 c=1 sm=1 tr=0 ts=682794af cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=kn8lAQMWUTpYvoNR6e0A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: gf4LItzgi1_dC5gJM8tZp41bs4bJO76T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE5MyBTYWx0ZWRfX4l25aoVnSzZq
 DnerGsvXMlr2O0p0bewUEv4JKoVIGX7H8GbTVoMY/hOuroDuVUk6+LOk+gvZZk2zU5ZBOW1qSxr
 A21aOaANrdx0/SQ/X3j0fZoqPSum1XBe/FmM6VU7ZONi8Oi38INYoaVR5q1cIMfQ3fOFWo/gL99
 uPVAfzwfF84b8w3cA+e+DGwgk8uOPh0LIMb/qV0m5EbOOAuDlGa5WbAH4NKavUFwV1G11yEMGPb
 ybAuf1Fi2907b84Ew4zcnOPVhUYj0QctS/oP9owqgzseCpa5swK34dCyW8tj16m5RFF2N4AqbsA
 DaQeXSLO1ZsMe+B+LpKBwzFGqyqNKW6le+SlMaRaFx0FYTgVa6eFNEJuZ+0kcQgwI6HjLFR9V14
 XbH6rpxLyG3gzZ/bvD3DP537TtkTigEiJjBMb8lmnvWZPfiglAZMCbFQIMdC4XaDmAqIvsBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160193


On Fri, 18 Apr 2025 10:55:33 +0800, Baochen Qiang wrote:
> Currently for 6 GHz reg rules from WMI_REG_CHAN_LIST_CC_EXT_EVENTID event,
> host chooses low power indoor type rule regardless of interface type or AP's
> power type, which is not correct. This series change to choose proper rule
> based on interface type and AP's power type.
> 
> When connecting to a 6 GHz AP, currently host sends power settings to firmware
> over WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G commands.
> Actually there is a new command WMI_VDEV_SET_TPC_POWER_CMDID with which host
> can send more detailed parameter than with those two. So add support for this
> interface.
> 
> [...]

Applied, thanks!

[01/15] wifi: ath12k: fix a possible dead lock caused by ab->base_lock
        commit: ef115c265a21e3c11deee7f73bd1061775a7bf20
[02/15] wifi: ath12k: refactor ath12k_reg_chan_list_event()
        commit: 9e8e55c5832d4f905d7ca306f976669d523e9ff2
[03/15] wifi: ath12k: refactor ath12k_reg_build_regd()
        commit: c96bce15c568fdb8edd29b35aeb0f20c2524108c
[04/15] wifi: ath12k: add support to select 6 GHz regulatory type
        commit: fafa6ff0823b79bfe4d1950e7bd51bb1c6dd49cf
[05/15] wifi: ath12k: move reg info handling outside
        commit: 75639b743515537b6ee56bb89c857aaf8726713a
[06/15] wifi: ath12k: store reg info for later use
        commit: eaa027a1d83f87c83f0b4138ca2427875a21b446
[07/15] wifi: ath12k: determine interface mode in _op_add_interface()
        commit: ee2fc1f7347e8393b94d35a0d2b9d24920c9b24f
[08/15] wifi: ath12k: update regulatory rules when interface added
        commit: 4c546023d71a2b175ae7dd17b42efcd5a832a1ca
[09/15] wifi: ath12k: update regulatory rules when connection established
        commit: 7ed3e88664e328bb7cda5e71568b83426b3f3289
[10/15] wifi: ath12k: save power spectral density(PSD) of regulatory rule
        commit: d6b11d0ddadb9e7addd0f582f31ae8e6c256ba9d
[11/15] wifi: ath12k: add parse of transmit power envelope element
        commit: cccbb9d0dd6ab9e3353066217e9ab5b44bd761d3
[12/15] wifi: ath12k: save max transmit power in vdev start response event from firmware
        commit: b0501a0ee772222e3a7fa5c94eb7c6b16fe20610
[13/15] wifi: ath12k: fill parameters for vdev set TPC power WMI command
        commit: aeda163bb0c7b9fc58bdd6ae90c0eef4f4050b7b
[14/15] wifi: ath12k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
        commit: 9a9e8ea7f6d31351039343e9e3b1927c61a2ccc3
[15/15] wifi: ath12k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz
        commit: 29cb3d26d01c275ea652010cc62f324793e34a31

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


