Return-Path: <linux-wireless+bounces-32283-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O3YdC7JyoWkPtQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32283-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:32:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA401B6041
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A89302DA28
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC0F240611;
	Fri, 27 Feb 2026 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ddqeO0Bt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="at1mRDD9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7A2F12AF
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188332; cv=none; b=RNVWCAsqxFvN6friFo7bP70X1tWTVbNu/6HRKd/QsoZbipsIVZLIPSMjJ9lln0z9uSFKYXKBnUif3hboaiMB2rxrWlzSJNwnx0uOoZCBBGBgBWL5UFD05aj0/gjsZDpEwN6I4Foy168SduS6wrQ5PAhuoKpYul8PinMl7Ai2TBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188332; c=relaxed/simple;
	bh=/RPFkhnylfztiuSK+DxJmoaNXR7ofxhw6mybp6NAD2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvUcnx2zIkojY9kJiDp7EIpz2wqLKKl2ctEzn1JtW7U1f4qcqWXTmczwHQ9PJFVa0GyxTY1ok2e0q0JQnq7UUy67JKIJ6fDapwnSTP4f5NHux9dA406MtxzxRD215lt8yqIigM15NrOHx8u9++e625kGSS1F4t2zMie0pXwHns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ddqeO0Bt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=at1mRDD9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9tB3I1874289
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ett7mpf0ScG6POdwVZ0VVIp2V5X3Jkol2pRvXyiOqdU=; b=ddqeO0BtSAW6EC8n
	CqlUBG1WL6bVuEk/zrIPCwNiNWX7JlKshPldYJ8MZUyHQv42TIKENJv1h7/kgV0t
	vrRXX2u17iVW/xLivRdnQzqSgcmHULzlKZRps6wLyHI4ng5c9bBSwTbYhwsfLHah
	JOU2Y2SfsxMbz78HYAKbLbCCU1qJvQPn1gI3zCs02MTd34LZIV4cnS9hhXhmSedA
	hxElM0RFoXBR5LJqfObU51nJvAiFV+pFjWIRnbTVXCuk5DsMmUEDSveEbIgvIsVg
	U3F5bO1m2OeF5pwKQv3xXejqoJRE9A5kRm61iqDG6n5TF41s6YHanu1jtOmL+1Be
	q6qefQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuyttm01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 10:32:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2adef9d486bso19582865ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 02:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772188329; x=1772793129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ett7mpf0ScG6POdwVZ0VVIp2V5X3Jkol2pRvXyiOqdU=;
        b=at1mRDD9oCRjV0G9NCtDcM+/Mo0mdqeBK0ddOI7vRG33rZkP/ZC8OVp0Y/K3X/Wl2+
         MhjIvVIRLq1cu6KuOW4iYDX6l2hp0X1cTc6rpOKGu/YwX4gCqG3XkGmEG3qAGxO02qyq
         VyVC/Pt3LrYWp+CDb9Y50YS5q3GuUCvr1M7IN8/EIEscW1ilYQVpWBx2zGVHVBq9zQTS
         OXByrA5chUehkPkxLLt90XKkgQLEOv1DSj2woE5iOhwTS6O41RQSwoMDwJL3IMSzGIhf
         4BJckFgkE5bZ+/cNjEP4ArSRTQHB7hq4U06rkiyl4F5mNzmiXxUM7g7XovQfnEotRaNx
         udJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772188329; x=1772793129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ett7mpf0ScG6POdwVZ0VVIp2V5X3Jkol2pRvXyiOqdU=;
        b=Eavi3+zhNEliMLZ2O7q+GEyM9T3WVnwDksa+LUDX5u8xdCoQmydJJQG7wfpOA7WGGQ
         oyupvh2CEAXPfHi0eYTBMRH6j4pb1v8Cd2EOqWBhg+4zxWT4GB38O/qHqgZcgt31XTL+
         EBMLQGdU68ksqzp49ixo+yj+hbMAUG6xcvV4qSp9v9R9vKqrpNogKL4dAQwdSA8qbTf6
         2MwnJSO5Xl4lnAlCAWP2ptD43ZZHlyhRi2Pm3T85e5mJtBwpu8bfBmXXQrjoP+aRg32H
         gN8EUWjSuT425Bser4L88vZun8zrtTIBLmjze0/LkCmHolS/NXWMqKxW7X6+2VaK+hIC
         JUIQ==
X-Gm-Message-State: AOJu0YyV9w4Dw98x6UVeHPo9IRpLOG15rTpkgPjsi37l0Yn6dtP/NYiw
	ObWzf0VhT58THBL+KlR8r+D+glxVDcBO/BFszDGFiNusQyQnIgZVu81DA1dPHEm/GIvTrZiuDFi
	X7jymC/bgm+zrUDIhVhtH9R3Xo/gHUGt+K2WdD/aSCeH6N8SoaC4WRhGCyAtWIPaXP6+SuQ==
X-Gm-Gg: ATEYQzzZpi1ZunOiZ25eJsGmzkfQHlQEpDuOMtcHEdeczvpb+sW+Gv1lG1Hd+H+p+vA
	lz4Qo2vQdRN9tFgRXehFnMnaQBG5e1XpvLJIEm312GPOwk2alPF9Isz+OVuHZ7zGuVovPRH6ZKO
	cII5cQCMCD/JGvk5760adloJck8GS98a+o3fVfoMgI5d11Y2s/1Pakio4lNORRTUJNMkUL3C1Ky
	6d5v4kTkrt5uzTXna4vemGaJzSIjISsnCyPAzlm8JdCmCTQ1k83t+U4d0rZxP3csn4KvODOmtUz
	BUKApCDQ9A7/JP+z2KpXmR+PFeRCfmmNf4zUjt9036I3+Qb1T4eVJsSvKEb4GTmzeGpv1hvR2BP
	QILeU5zkmub0Y7ObP6aVhG6vpgMmbqLz+qGslBcsr86eRKN9U1daYb7aN7Y0hGUGjRoY=
X-Received: by 2002:a17:903:3c6d:b0:2aa:ea8e:f118 with SMTP id d9443c01a7336-2ae2e3e6adamr24501725ad.3.1772188328728;
        Fri, 27 Feb 2026 02:32:08 -0800 (PST)
X-Received: by 2002:a17:903:3c6d:b0:2aa:ea8e:f118 with SMTP id d9443c01a7336-2ae2e3e6adamr24501435ad.3.1772188328227;
        Fri, 27 Feb 2026 02:32:08 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b4177sm53062265ad.62.2026.02.27.02.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 02:32:07 -0800 (PST)
Message-ID: <3721094c-17c9-4eeb-a4c6-bd1cc7c44a75@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 16:02:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Remove the unused argument from
 the Rx data path
To: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260227042128.3494167-1-karthikeyan.periyasamy@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260227042128.3494167-1-karthikeyan.periyasamy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bJIb4f+Z c=1 sm=1 tr=0 ts=69a172a9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=LVef6NQiuxLdmPMVh7EA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: U7Eueff6xaMwPeVknB4s_pGhKwiUOx-p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA5MSBTYWx0ZWRfX8A8dRBvMQ4Km
 cszs/LoYyEYY7Tp8AD71T5rhYqrLYm1M8p6p52TOuVYlelgAW2rk/QGFQvfbByZtzCbyY82QTeM
 6XZGU9+el+kDTSVHTXUsfiR24+jva8bGh2UAjduLxS8SKfSeMN/bsX3wvYh3KpI+TsGBIE0F9dd
 dvtTd+9AsQuSvY2g5RnvtIAxL+VLweSRV5AfttjHoBdvhEaxZ7br/0e9cBA8VyceAST2nVrr3wB
 lLvaMTpS1K7ETLHEszjknGpAQutXakBqNOW26Vt3JTOYvNsClZZ69GnuFajfUMgo9+jkCHHXZdD
 1OITwYzfE23DVd3CA/kIYrkB+c0O5WGzmi0ZZl6vny85gZ+xLF04MfpVWi5o+V5VJFoD6Kn1fdE
 lGl71LI3DdOcQIVnbfnzf75ge2XE15zUvEkuwCmIix9gXmoRzJsXyV7wuW4df5HP6GL3R49pb4F
 iSmEXIbCwjebly3uWJg==
X-Proofpoint-GUID: U7Eueff6xaMwPeVknB4s_pGhKwiUOx-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32283-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6DA401B6041
X-Rspamd-Action: no action



On 2/27/2026 9:51 AM, Karthikeyan Periyasamy wrote:
> Currently, the Rx path uses new infrastructure to extract the required HAL
> parameters. Consequently, the HAL Rx descriptor argument is no longer
> needed in the following helper functions. Remove the unused argument from
> the following helper functions.
> 
> ath12k_dp_rx_h_undecap()
> ath12k_dp_rx_check_nwifi_hdr_len_valid()
> ath12k_wifi7_dp_rx_h_mpdu()
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

