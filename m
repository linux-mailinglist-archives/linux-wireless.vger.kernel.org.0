Return-Path: <linux-wireless+bounces-24225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F9ADDFB5
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 01:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB09317C0DF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 23:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6AE29B8DB;
	Tue, 17 Jun 2025 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OH02isDS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603802264C5
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203143; cv=none; b=hxdEOvXrxFxWYpi2qJlmifqHl5VUDKWsDlhqTbcBHxYMXYRDkTGSSkrKvnd3bbn5+0Rzv1Tlo9naSlPO/Yv80cLMemJagafPSOc3acRImiNlEtZoqiSJE1//1mm472Bv2o4BZMIBaCphsUsd0zkh9n+0YeNLpx+/QqSW6cZUrj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203143; c=relaxed/simple;
	bh=nY6KZtnOAtjOwrx2Ms+V8WEvUEU0OGAYjUMU12JZPfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JesnuCycYTwARQ6Zm56XcrMLszwywl5tUWbQfUGChu+LOEJ6MbI92Rc/3yNE70pfXHQakocyc7dr65j4jFPv9JN11xzDG6HnHQmMhzECLRUea79CvvfGqmcFnjvloabyJISEYB3Vn6Bbb7n8xGxGVNldPha966LZJCESEbvigt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OH02isDS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HFQRj7014469
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 23:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dODIc8OFkSO8WoD+zVzC4mGUSGgBpu7XdBLKDQWE4A8=; b=OH02isDSDD8gvmKN
	GZrwiHPWVfxFJ9KSdroBV6FJwAT21NS9c5E7anB7usEcDX6tpTQWsCeU7QMH4Dwf
	iOw6zjuUz6CggRwKW2e3hYanSR9E78e+1xrcojr+Ki6yu6C2FaR/UQVDHEDxrT+G
	X9+V7y5rf4YFJUp9QVpmVNdUfEQgB/h2b1CR2ceORUsfBNIOmrevw+gnOOCuz2a/
	ARVGSC+YyWJgJNG9UfJ8qtpHr3K4l8eJYC8AssNCawZQcGjxCaS2WsaMgDDJi4+S
	EE6RmSDMkJ6JfgJf4+togpmcrwe4lAW9bQ9RKvGgqb6J2PdPnVzi9RsiJVs38vUc
	iZ6rTA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47akuwdhgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 23:32:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3122368d82bso8803408a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 16:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750203140; x=1750807940;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dODIc8OFkSO8WoD+zVzC4mGUSGgBpu7XdBLKDQWE4A8=;
        b=jZoLtvxILMw64M6pkCHDFY4iu2X+UYMMPQ9A7308/CEXn+reP/TLsHB5sPKa25mzyp
         DPRH7smP6jHzbnXdMZV4SDEzmZoEzJPrU5B9zRFkrmWHV+Gu9DQTm+z/GmBBpeUoY3z2
         Bx04/1AsYm9JxF9N9A2kl8ubYzeL6VLi671Ttl5HDizL6VeZR16VrRPPSoLaDNdok+CQ
         aXzZ8NYAtYDOmw2pYq+9s7jH0I6NycCNRmwWgYnq6zefLDoA7pppcDkXXnLmjE2k2v6J
         w7lVrCSRQfH63zHa0on7y8t4iHTLlafyMa1tMiRDoPLcHCj6lg0cUy1y8wVehMYedz9c
         2CMA==
X-Gm-Message-State: AOJu0Yw4Ad6SmXRtJKerJtOIIKRBPYJ6vNLIyQ35mjaBU/gXzqQ6Dkm/
	b1DZn5uwq9+QxyvfOLZUC5xQiSqV9XI8lP8Mp1+il8gHzoZ4JZ3vrKXXmHl2VXfpOWLrl676cka
	DOPEtiuYWg4GDVKve70vObcOY5ylcxrUbMcJmfyfweDGznHH98U1p+aIElRxP3SggQPdrmgDsmb
	7Hlw==
X-Gm-Gg: ASbGncspoTYQfw6kesUbShn8lmQCxlPKJMg6WfIlfvcDot1Vw1H4G2M2YKMt1FY0/eL
	xQocHtiG8gpXIgazAyGCN3tbnrJbpXofy31xx2dAq31I3QlIJyzOG+u6rrDzaAG6FecUgL0Uj60
	2w4bUa7r3erjpOl4v6+Ou/jimUPw5Ai5KVYZSy0D/5GR//uE8x6ecPXS0cQOfwEFwEe8oXC0LO9
	PZdk9jxwcCiOqeljn9Ttvc+tf7Wlkh6C60mlwq4+G+XfBxjVeZsFoPAyG0lBex96dNkDOijOTYy
	bFSCAz+mA4onZDaOPNbrdvOMKbfBhZloHpMfpFwNMo6TpEN9BPnunq2DABE=
X-Received: by 2002:a17:90b:17c5:b0:310:cea4:e3b9 with SMTP id 98e67ed59e1d1-313f1d2d2efmr19221091a91.34.1750203140295;
        Tue, 17 Jun 2025 16:32:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkZl7s1slbbiEI7nNWQRSVCNx06U+xoTDxO2I1beV25xpGDydiPIMLlLVlSbnf7tvxYkQIbg==
X-Received: by 2002:a17:90b:17c5:b0:310:cea4:e3b9 with SMTP id 98e67ed59e1d1-313f1d2d2efmr19221052a91.34.1750203139809;
        Tue, 17 Jun 2025 16:32:19 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19b84e5sm12731527a91.2.2025.06.17.16.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 16:32:19 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250522-ath12k-sbs-dbs-v1-0-54a29e7a3a88@quicinc.com>
References: <20250522-ath12k-sbs-dbs-v1-0-54a29e7a3a88@quicinc.com>
Subject: Re: [PATCH ath-next 0/6] wifi: ath12k: handle link select and
 inactivate
Message-Id: <175020313899.3793705.13608281635495302018.b4-ty@oss.qualcomm.com>
Date: Tue, 17 Jun 2025 16:32:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: eEt6Ql-DAWZOzuMa67_97xmxcnFrmERb
X-Authority-Analysis: v=2.4 cv=He0UTjE8 c=1 sm=1 tr=0 ts=6851fb05 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=KkTelb30UcioZhBSqh4A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: eEt6Ql-DAWZOzuMa67_97xmxcnFrmERb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE5MiBTYWx0ZWRfXxrKKTrCbbGsL
 VOb6KhdT3u8GKtBQFcBtVmE0tTr3AEa1ttGoJyr6fptmjUoCTgGN49TisFJnXeYCMi9p0B5UN+k
 0tYUkgWXGeeSscHWbSfjR6wd0tokaxcr30HRpazqlvagOoSk4zn7fsBNPStSJF5QpFfVuZpSiDn
 I8Nz8/QYhfIiC2PMl+8tVl1Nkv/dCXWiXZQxwg1NA5rusF37oUTgSLLOQ+lidcWSQgC5eztj2v5
 jE9HFinjfWwxSdzD3TOhKp67gTUU9ZkW881Qz7M9mWZDffrLSGpP/AcTzj/YN1t57xOEZT/u1tb
 rhTpv6lSv9zFC/qrBYfLyhZNn+wTed/G8D0tcen3Z7Hi1mFWEfPoaTDfs8l5c5tpqg/AajlUjMy
 PqhGpVmGUlEWubZgb5zIwR9cltSnoFboZo4hlTZNn0IQgSmBOhIAgRO5R9eNDA12TVag5xr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=852 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170192


On Thu, 22 May 2025 16:54:09 +0800, Baochen Qiang wrote:
> Currently host activate all useful links:
> 
> 	ieee80211_set_active_links(vif, ieee80211_vif_usable_links(vif))
> 
> this leads to 2 issues:
> 
> 1#: If 2 links are created/activated on the same device, and both channels
> used by them fall on the same hardware MAC, throughput would be lower
> compared with even one link due to MAC switching between them.
> 
> [...]

Applied, thanks!

[1/6] wifi: ath12k: parse and save hardware mode info from WMI_SERVICE_READY_EXT_EVENTID event for later use
      commit: 062ade23991e556a14bbb27c1cf873c34dbd9d28
[2/6] wifi: ath12k: parse and save sbs_lower_band_end_freq from WMI_SERVICE_READY_EXT2_EVENTID event
      commit: 241d130f1419fd99923d99aff6e40490a4c34d93
[3/6] wifi: ath12k: update freq range for each hardware mode
      commit: e47b11e3bd34177af6669ef0945eb23dd4da3bcb
[4/6] wifi: ath12k: support WMI_MLO_LINK_SET_ACTIVE_CMDID command
      commit: c36f2cd628f9df6ffb19c23eedaa666440b8f5c5
[5/6] wifi: ath12k: update link active in case two links fall on the same MAC
      commit: 2296038fd35a6e57af77496affe9044293ed2947
[6/6] wifi: ath12k: don't activate more links than firmware supports
      commit: d9dbc6b8b94ab41fb8b9dbb5a7be024029d46309

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


