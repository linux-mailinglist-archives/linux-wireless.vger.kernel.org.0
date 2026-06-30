Return-Path: <linux-wireless+bounces-38413-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uX2UIqc0RGocqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38413-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:27:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 390426E8238
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:27:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=D+lMPPWM;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=P08otLjE;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38413-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38413-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86FE7304242B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A442F6918;
	Tue, 30 Jun 2026 21:26:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6300224D6
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854798; cv=none; b=YEhWWRz09THRKTVVIp13Rry7HAhP5FQkTycvYlcw0AkOI85yyBGPiJOZWPotK28bPN/s5Bl/7sOn4B46SToHQQJhAtVkCHdnuUOsNCDFgQ3Zc8Tg9zSbw0EFnagZbWmhPKJqSImZZ7gEzrxCSOLx5Q6NIet5W/7j0dKUstljIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854798; c=relaxed/simple;
	bh=N91PR//69AO6FOOM+dnAyN3X/jtnvZ+HzKBOzH4X1lM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=miX7IQYrwepPDXd4nRwOk2wXfaDV0/WJcHTa9TOspd1pPE4LdQI8DuFvRU8yCPCBb/qpjpLEcekQVYL8b+jwFR0YpFo9Y4jZUlYAck7p2jAWxOnfTPm3U3ILQ4JWBomM/yLuKR47aRUMAXLdDUs+k7qmrJyCC3qWksCEuq1PQcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D+lMPPWM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P08otLjE; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDcp22948554
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hM/2xLiVBIEn097bAk1PtclBiyah9Mcg79Um1wYelx0=; b=D+lMPPWMfUrzeapI
	f13fuvmI26a4UZRHFAE24hPO+4KQCsTfde+LP91POTt0s2Qa+byEA57TS6ICF0GS
	s1zVUndS2hyCH/nTyxEuETuGNBzJMvSB0vTFybcx3nQlTIYVyGnc+gQ3tQpitle2
	deobrpouFOeWEbLNaszeyTtq2u56b1HkbRrOlhk0eTGGHQCD6SOYKeUraafN9ipu
	W68EWIaVPPc424cB0X0lQFyf4a21+knp1lYf4EAKS4y5n2Det6+LOvGC0poHxbhc
	NH3YfTKZ7TYl920ptpHgqHr8szyt1eef5AfuyrVdxmDnznpQQWvm/2IjuDJc+44q
	bOZuyg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw0k15-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30eec544cc2so262273eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854796; x=1783459596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM/2xLiVBIEn097bAk1PtclBiyah9Mcg79Um1wYelx0=;
        b=P08otLjENazOuYnzbQjjSUTogFRezZ1RwcAAN83FF4jSob0zvxaEL5DAIokCIYBrwC
         RKSjZbsCVMuJv8LasvWyE+8SUTh3C712POiAKZNncKhu9vah8E03KGqJOcU2b/IiBm4x
         V12IOuuOPZVk1aTwrCQy6ugDX6h5TvXKeerUctjj3sJ4/9fhod2OMLyh3FA3/Q6K204J
         5obl9VuHKKzwSB1TFWboVAGXp2Wgh1/HApTHGEY8a3U77CFLym620IuDZRv/L95KF/8L
         urWPj+hvttQfUkPAUL6fqZuGK07zDwsS7ROdo/OxUSLijmAJuHhj4/2gJsy3vMMMEQHt
         I+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854796; x=1783459596;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hM/2xLiVBIEn097bAk1PtclBiyah9Mcg79Um1wYelx0=;
        b=KdUxXVQpCLOBGBF5cFJp7tgls7ZOpEygvJ7mEtNXU6WHgpJYW4rJ5s0SZgN9cMYce1
         iWrcvkROTThXieoi93nmv0HuehM+j2RgmQ75n/CBqoNDNvWDJHSWyeQwfG2CfHze2UBc
         lz+ZkIjXbR6lfzdOOk7o2TTd4E+XjGt/1/MohlDP5m+TiP//bNd4NpdX1mYlCcm0zh8M
         sRL9cGspqnyVtxj93e7ORaEMTmXKiLo8669RI3YORyr1uqbivIHWUGBVv2uY0Gd0LOj0
         b9CsenDUQHE18nEubt+8ZC3UMxKu7A67v+9EUpU5w46ZlzJTwqaRFGE0CqDAAnnDxf54
         +baA==
X-Gm-Message-State: AOJu0Yx+a5iZMhju5lm/ZMfxqslYh6PlLQ3czXdZQrSxN2iGnCvejj+C
	45zBndC0VrRyXl7IgJTGIw7IIfgVgkWWZa5R83n0mjz7XjBTV83RBoSGIxg5xJItvUnq0B1ylaJ
	M1eE5RM8bGWTa2Nn6rbqex+y08q28IfT2xzZyQurnE8yuOFkbeve0zglN01wWa01pv2kM80Qj+w
	QC0Q==
X-Gm-Gg: AfdE7ck/hLLoUp+1EXYszdRdhnhwpWJJdGpzi1JuVUWTr+EMdehSw2sgk6kNMCyV0wc
	RshV+BxQh12qEqW9lPk0BA30wvGjnlyWhnvm6i9+lwuZJFPUh7sm0qLXw5FE06oO/vYbO+Uagmt
	i23aLTfTTJmCfu6DVGz/IxRS5K4XdNqtMcEO0tpA2wN7dh9xVK0paOBBOTVWGr0LYXTJ8e9+gri
	Sh6agbnZvxAtH82awJB8KlfwNPJIWDUs/cfTGqmNujkpndl/MVbtGUmiyvdLoTTqVZuucTYW0MA
	Gxw4SitTJMgowl2dQQI6YLSDYKDnVUOr13SNXK/ec6xtP9TwFKLOt5DTu88HhLzN739coR89ccZ
	daSQg+JwbmaSLUETCymXNyfg586KlAZpErDQgyO7qZod12h92qg1P2IZ4XFZzmqSfpg==
X-Received: by 2002:a05:7301:3d1a:b0:30c:ab4f:46be with SMTP id 5a478bee46e88-30ef09f0d93mr1671985eec.36.1782854796049;
        Tue, 30 Jun 2026 14:26:36 -0700 (PDT)
X-Received: by 2002:a05:7301:3d1a:b0:30c:ab4f:46be with SMTP id 5a478bee46e88-30ef09f0d93mr1671964eec.36.1782854795524;
        Tue, 30 Jun 2026 14:26:35 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:34 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>,
        Karthik M <karthik.m@oss.qualcomm.com>
In-Reply-To: <20260623-ieee_link_id-v2-1-8a89d71baf58@oss.qualcomm.com>
References: <20260623-ieee_link_id-v2-1-8a89d71baf58@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: advertise ieee_link_id in
 vdev start MLO params
Message-Id: <178285479396.1590147.1856151805627315095.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a44348c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=oIajaL2VPBg-BlUWyywA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 5uz2WxkabpYyoYY_EBel77VHIBJjovjS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfXzP4cUaJKIUCr
 t5T8IBmBiiLRzancfPxuUopvkdlXMvZGy68ahrwPFsqTE/Ud1EXj+s/hiqCccYACAnea6YgmLUk
 mvQqNnohJER/bQDX31QZUO4j/gvilys=
X-Proofpoint-GUID: 5uz2WxkabpYyoYY_EBel77VHIBJjovjS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfXxr/aW0u54xWX
 5cdRU6Q9zSwhqGEZThh1kG4eb88H7EjDBt4NQl9huID5o6S6YEHNLAeT85re2FWaqQZpsrH3IrT
 LGtxB0C4WGjt03hOwshplpQdNnNBK5E6Hvdar5zxukBRRo/4fwkyp7svYAxGbleIF8FyDo1lOYL
 rCGwWpdoEB5y3uHY9HJW6VBDkGwdsCxiLlm7HWyOuKCWuu4009vKOVGHBYe9bMQltGxYtCnuvku
 EYwLTxnr8dwFwriuD/RfULmBi9gFnQSIBWRJLLkGmpNJE7DDoDkz8cV4zpVCmtZhYvCCG9VNZJA
 ls9N8N0ar33/2/aWUy7jFaXZygjI9as+5NSb4O4+PfvamlRUlVhe01Dj8V1ix8aEi8RwUZZD/ED
 zYIMfy/fHzEbJfs1F7ip+1z22IXqmLTdPoqsqQQdkXxKDQf0DSMq9dPjBUhEsn08mTToEOIqWFi
 CFxjloXBj4o3Q4LNreg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38413-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:manish.dharanenthiran@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:hari.kannan@oss.qualcomm.com,m:karthik.m@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 390426E8238


On Tue, 23 Jun 2026 11:16:21 +0530, Manish Dharanenthiran wrote:
> Firmware builds the AP MLD partner profile from the hw_link_id passed in
> the vdev start parameters. However, hw_link_id is not always the same as
> the logical per-MLD ieee_link_id, since ieee_link_id is assigned per MLD
> and not per pdev.
> 
> This matters in mixed MLO and SLO setups. For example:
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: advertise ieee_link_id in vdev start MLO params
      commit: 784f7dabf5d3bce23c69c48a0441ff2b1536f069

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


