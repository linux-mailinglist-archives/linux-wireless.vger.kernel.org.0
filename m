Return-Path: <linux-wireless+bounces-35728-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EItJLfK82mL7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35728-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:33:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DE04A83EC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5389A3072120
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D93659FB;
	Thu, 30 Apr 2026 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KpcxtflH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F1x+/Cgv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A993BED37
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584650; cv=none; b=fnFTTkro3BDn2BH7XAckDyl7DnDPkIe3kVowsAdq2olnPlMZ1+a1Eiduj833Y3+sNrbWru1UZDpgV4abhM54WtpkH7l0W6vsHA5McK7+q41yzI/+lVIvDFtXX137/YTbzcG1vY7bHQPYF8H07D+vNiyiJPQQrnKUvMFoFHRPFbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584650; c=relaxed/simple;
	bh=RHeNGzFsaO5OU7c8ibFy6bhq1ZsmwbrnW3uotbi3WGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R0CdXukW4J2559u46o6A1+mMEYnQ7exgXzFCDn4R7JKrOTBrSCaxOf5Mf2jB7v3zmYa9EZ8Rv0iAKOgbYFz9LkU1M/fKW8P7pvSZfN0Jpz0T+B0rCWVceUSQpI4Nnhvb5EhCwZ2rQ9HxwGjp5pkuGPS6qAOxkWcnlPZ/s/CXJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KpcxtflH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F1x+/Cgv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UGImDr2122428
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uqZlRmb6OJxdMV/7RwJxD3OpNFk/6428iJHVPeZXyao=; b=KpcxtflHF1RvLzrm
	x/LpGvQMk5ePecYf541+Lp8GKCTwzWCI3tUaQt31d9/jT861bvBMMi9HGjm5xmoM
	KgIHSG2oqN7Pijvoi2gJCb+peObcavyoRWp2CndyK0uaAYwpNhtOlkjHxFAejEht
	8NK9E/6u2huWO/mo9rv144LFxvyF2M1GpNkhTRvAW1ou6aVLfr2qI5BNc/pdrlFs
	A/TeGctbIaGdNHLBzLb6Fz7sgiQtWqLhS4wsfBB0z7nafe2Iut60Xqaue90XJ7PU
	e2YlB0Y0ESBmg6jXoRvHEfU41E+JJJneP7mdyG2n8GynP9Q1HW05kXmKDl5d6zKI
	0foBKw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvag4sc5a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso2465979eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584647; x=1778189447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqZlRmb6OJxdMV/7RwJxD3OpNFk/6428iJHVPeZXyao=;
        b=F1x+/CgvbuigcRrplRbmbEJIg6c611fq+OseVIgBfKVozMYSmaZhn0hgW/MWIU4feA
         vmuR4GT0uzF9TqI+XnUFCovQPKwzXcI/YIkClRrxQCo/wYhcJzYNLE0QlfiKps84tLED
         z9IibCZEG5wfPXlySB9HWF1u3DMOWptRxNXsW8b8p0Wqs2P1odIMuwcSQblAhtu8KHEO
         TqlQMf8Rxz4H8RvIeLGqkeo39HGlwMJAxRpdzo2Xtl0rbZIZd353FeLaHE/0VcxB3n/B
         uggNaCEg/19/bqo7F9iofpvs7/u7KL4OJGaQcmEFroXFqG6wKM5Pgsj6XtYjbmNHJ3z2
         UL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584647; x=1778189447;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqZlRmb6OJxdMV/7RwJxD3OpNFk/6428iJHVPeZXyao=;
        b=YUltjkDMW2LhMmmnYMbncqRDItB1k3mjStjXRJnOv8jDQ2YaigPp7+/ViBQHVTa19I
         9Pj3Xim44fT4X1TUKQuxUM/74NlqbYaKxvyobVFQFRh53sv+MHkMaeyNAYGp81E3lMDJ
         5r4c/a6iwSQAlwBjz6AcgV2VyVmeVCuUSMTuf+kIRIF5joDXQ3zq5YIc73LPMj6adGFo
         3YFogtsQF9lOGqdZ1JU/od8dWU31P+y6XWVGb0zUDBzDocyTBoSYOLP/YtuCuE4Xuvo3
         wDcPulUbovN6B/s6Bp+AtiIkXDvO4LKtNneabYbGBaGcn/6LiXhLrrH64D9iAQba99tb
         ATRA==
X-Forwarded-Encrypted: i=1; AFNElJ9ft/HFundsbR84TOT4t6flfASM3e0/mktvj1OiPYFlBYF9YgdI0IREgMJH8sjaWsSd3l2Y7XnA2mjXeCQKlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRs4KLJitD/BUc0JslihxZIpKcbthMQITG9kzNkE9r4ifytb/s
	9UBJEkJ7W7Gtxy2YI7L2IjDI42EFVcOG2K7R/f6HOMPhkPOsY+UYbtnLE5YUkuw6Rw7xp1nvW4t
	CT/IYUv3RfbG+rzuck/2PD7PIjtFAGBvBgOlOUr35VXex52MkKQj+V6gEjJwL16ckH80irQ==
X-Gm-Gg: AeBDieuszxiw0mO5coVf/NA5Hh3SmOqd8Q4CEDgmUFvpiZUQweltM9VPyHZzZyLjFLX
	gqaIO47W7Qj62+tPi1CaGDffKDvVBWS/kVfvmRd+jJIeXfnKlk43PEzdMASzyPb35NyTwjDFeVR
	GuwtC5V9Vc5ESFPXTysQtevqAPsRBXHu5SeIgdYPm4JfjDn63X1kq+LzoXKF3SoBMlUiaFT4bD8
	VDXSPS8zZJQvvxCiZdNdd0hO9SDz7smLrOcyI//Wtd+9J53sDwCr91jASmTE8YqX+1+YDgHCcCE
	+bTOrqKZb7C180bPx5VTDJ2JrmsCimhnoFhfDXY5EK1xBvPQUV2B+KkeSgTM4XVd2TS2N/LX5wp
	JXsC3vy3TLN8J0z1e3+112KSP074Sy9J0fmk+52Z+2kWrijJedXhK39vHABpahYC6q2V0Xncu+9
	F8N5M8iD7xfLM=
X-Received: by 2002:a05:7301:d19:b0:2dd:649d:751d with SMTP id 5a478bee46e88-2ee87680653mr181035eec.8.1777584647390;
        Thu, 30 Apr 2026 14:30:47 -0700 (PDT)
X-Received: by 2002:a05:7301:d19:b0:2dd:649d:751d with SMTP id 5a478bee46e88-2ee87680653mr181009eec.8.1777584646856;
        Thu, 30 Apr 2026 14:30:46 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:45 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: konradybcio@kernel.org, andersson@kernel.org,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org
In-Reply-To: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
References: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/4] Use the QMI service IDs from the QMI
 header
Message-Id: <177758464538.1848985.4937106435944960092.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: OP2ZJUpMemNgarEPgTTj3BoHK3mAtV5Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfX0AK+GOApUnsn
 mc4PBUhe3QpxhSQs5GubIYHGtWZRIzg3wDwap5Oe4wSEW7LQUFgYh4Zw3wlOzx+a6BxxNKPbcGT
 3rno6WgGtf76arGX4cT4RQQxM9BQ1p1SYus/9oxrAkuwKH0yrQapbFX7EvZqTK1pymFljktuvtw
 Apl3rxGF+3w3fBxk1O+2eSRq9f36Sc43XKWLolefc+igpMOuTmBWebuWS4UNkMmBqLd72abpV0k
 FgIz3OWBTgunZIVzkuFnCQXFuDRWJ+I5vYXGAvrEFCn2CdH2enp4iGbEr+SPTyYldJVZkNePOhN
 xnp8jFUEQw+XKk5T0X+Y/dDp0ZdhfoSc7e55i6OV9huMec5zsjZJMcKnfvSS29b3lqDSuIxsfT0
 xMSl5s9hC840FSHbxPdkh7C+rZOZ3BLIcKWmXK20g7Rkkn5whIlmhSarPljYvK95PosuiDALMIb
 I0GV/lMod+zJZgFtenQ==
X-Authority-Analysis: v=2.4 cv=UcxhjqSN c=1 sm=1 tr=0 ts=69f3ca08 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pNJNIoqo8oUBudG6fy8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: OP2ZJUpMemNgarEPgTTj3BoHK3mAtV5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222
X-Rspamd-Queue-Id: 36DE04A83EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35728-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Mon, 16 Mar 2026 18:14:10 +0100, Daniel Lezcano wrote:
> The different subsystems implementing the QMI service protocol are
> using their own definition of the service id. It is not a problem but
> it results on having those duplicated with different names but the
> same value and without consistency in their name.
> 
> The QMI service IDs are defined in the qmi.h header file. Use those
> instead of defining the IDs in the protocol implementation file. It
> will result in unifying and providing a consistent way to represent
> the supported protocols.
> 
> [...]

Applied, thanks!

[2/4] wifi: ath: Use the unified QMI service ID instead of defining it locally
      commit: 0e39eea57626e545c596734c0d250c1735f1a7e5

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


