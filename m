Return-Path: <linux-wireless+bounces-32915-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ0GFRM8sGmohQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32915-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:43:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AE9253CF4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D911E3218D82
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8932ED40;
	Tue, 10 Mar 2026 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ky4xIO0L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IJqk65aq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAAE31D375
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156714; cv=none; b=E9AY9R3EbA05BUPn+b2/102qDvh7TwQ3NkS6LHOzP5P431YStJN61a7vaqbUWYv12aqdrHGvYAWM+fhybj6LZYUNrlqL/vAhjgr6z6uTbjfuNnUDuhNlzR81ptGubFB4oyLRhKk4tmmXmuqbatOmdisN+VIsGiEAzFY0Ep7nUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156714; c=relaxed/simple;
	bh=W9a8Qd9H3dYWVA0K2oCPSnr+U8qlC1ivbO2y5aVkiBE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YbK+3ScnS2+q9JpnwjIRw5FozIY6hGSqg9iDKUn2KOiNokP7RprUqKdFltne7av8D5AtqKvacKDHD6IOI0hJzgMMx2vOCkJmzfkR+pZgQ5/iGL/UwRJAsBP6pnVMRw67FjZ0NaOilnLeszNHkyrfitMr8x9rRSSA2g81BxgjgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ky4xIO0L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IJqk65aq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaTw41502932
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yAVrSs/RbTskVAhrKyYHE5rdAkjuJ7IjWtFskKC2vBs=; b=ky4xIO0L5EWX5w4x
	5Oaqk/EAJ0Ix0FOUTXmHDGxDJ2d4oHj9mlCWjITuS3Siw3YId845Y1Dej4ljii2I
	omKcpmbERGQcKD+frcnRjqOzHFZ6aaizIBA/A2d/a+ixBziu6zOdd62fXXyYlzUB
	95v0qQ56SWfSCxjIOfVIboOSe4hdhO1HdEAxKtKyxpmAzSjPHu48711exQabQlhl
	0u+qEWyhuPAuIyk1Q3aixwhhUZ4RLYGhQYYr/NGF2Vmatua7aRLoLvskIiti5aUL
	e3Q4QvFX1SbD51eXPr4Bi6Akp2R/377ZVOR8iigSVFGNMM+ZU1FLPPYYDoHbCc+s
	ads6iQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctdf8j5tp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:31:52 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d74dd618b4so20620213a34.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773156712; x=1773761512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAVrSs/RbTskVAhrKyYHE5rdAkjuJ7IjWtFskKC2vBs=;
        b=IJqk65aqasKSFfKC7Qmy3JQ+T8vZ1xWI8Yr7cpsAy51z+KF9Sa/2D7RT69Y2EM4rcO
         5gIaZkmlTW7L3qtUeCHVfYWm5hwjgd0FzEp8ZLKErH+YwoyKPnf49gZ2e7ETNPH88/Se
         tqRl3opAuVyiyjxXX22r41o3nLooYajpqTpJeW/qFKdOXxANSzVfzsfS6KPbp6yjtm2R
         a7luMNQGzZ12ejsgpZXg7fTgtCrF2/sd2CgZfhUoAUSW6OSY383mfqGM09MwNhjJnekZ
         VNlnvjle9XnJcaBj0AxP8Tl983AwdL8UBI2cJ5CuVQZ4qcEwx4Mnv/bopxy9Q5g9dfjs
         Li4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773156712; x=1773761512;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yAVrSs/RbTskVAhrKyYHE5rdAkjuJ7IjWtFskKC2vBs=;
        b=SdgMKaW+FHymoiQxNKG66l1OBL0u/wGceogkkaPWpwSlZ1iLuCyt2z1upqD/cuOUJF
         /SzY294iLEsyW2A4/+S21k6JTmeiwqqgiqjYVf2RJGS27XOxq4LA9slithB6SzpJgYmw
         tIPnkOFxoJLaSTbrW6isVhEqApxEhChS+q4fUc7aEpNmODsrwO4FgbncZHTzIy+I9yZe
         Pp8k9p6IZrZmkB89jftWE34Ze8KL3IXf1MMx/4EF0UTleZGEsv2iWUPNOSv/RE7mUIH/
         9WMVPBgpUL9gUtR/JdTli4wsiDzq2uWLhKnGTvPGQ0C+JCvahcujL+8wx7og5tEE1XR6
         rDzQ==
X-Gm-Message-State: AOJu0YyYLyBr+Q5ZNWn6JagX0iwcQlaGaX6KXpUuJhOdT37UKm093s9h
	Dh497pkJROuy4k+GjNKnXBtB/xtxCox5iMSFS10GqBsW9W6QOViHUCFuZY7YnkJ9vImcSiVdOMr
	vmUGoBV64/9ZPhamMYLlFhFvc6Sj1fOhsDiKDWgfzhsO5MMpNlASV+MXOYskgGz21kF8TcyfPA0
	zNww==
X-Gm-Gg: ATEYQzyk4tHYb0eRkYx74zTS0kx4JW2uuxLzucknZzV/xtCI0xQzJxR8FmNClGnZLd6
	7rabUQe9ZQk6zblFfSu+BdhIY26Cui6CcS1eM9L+iho+p4OIz4UOPdJpnFVPf3TBRQlC9FiHB3U
	UVm6bIrUSvSAULbbg0wdS6/Mt0YB2VvaYyp7jHE14NxhyAUVT/DR/TRGkHxWgENpegxm+6wU5D/
	WVfwoQdgKfFZv6Yw15oOISlaDe1UedJsD4sbPcg0AeN0qE6llNjSPFNkghU9h/bHtq/FTnwHmx+
	/EttVzr6J+ux+cKD/8HJ4fduRb0UId6GXF2WfVi3ipJOOrpDSsHU//I5VeGtqRphZAhbvhpSX5j
	WQR9sN5UIxgmClmQxVXcAGhZd2I7DLwDFXfZ7v5c/KxtCM6O9Kq7BGZTE52lIXxvfc25zYr0pRF
	p0
X-Received: by 2002:a05:6808:3025:b0:45f:cf6:d09f with SMTP id 5614622812f47-466dca3781amr8509053b6e.16.1773156711621;
        Tue, 10 Mar 2026 08:31:51 -0700 (PDT)
X-Received: by 2002:a05:6808:3025:b0:45f:cf6:d09f with SMTP id 5614622812f47-466dca3781amr8509034b6e.16.1773156711147;
        Tue, 10 Mar 2026 08:31:51 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4671e48c8bdsm1924672b6e.4.2026.03.10.08.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:31:50 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260306032252.2237722-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260306032252.2237722-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Use .mbn firmware for AHB
 devices
Message-Id: <177315671028.4092534.3433473847177396584.b4-ty@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 08:31:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzNCBTYWx0ZWRfX0zlqqiOuPXw8
 ryAfOoCNYz5oQkx3vzGe/82SWvLEVPxosN0Bt0yBhXC3M2HwJ07/RL1ci1PoymBTIW2ONxqgDn2
 RCnBiqEYgMRtOZ4hz41/j/kjffaERwL0h4CQzv/i/67RqoXtfZjrQC77rlDGKAScLs3yset9QrN
 ew0j+tCqC7XpTSPVfIejcn4289Vpi44Gk7ixUcMyX+Y6ySKL6Q1lY5/9b40JwCTvi4cM1T4CZgz
 WW6fYZ/D8q6mQUkOgW952+0IXeGMfoV41+vxYxeWJpbCgvwA9i2FJo+Fo+bMB1MM0n+qDRJuNGE
 WzfRJrT2lwwPWZ4yVgDmb9/mood/R1dwUcWrGOE+UThI1GnL+gZLD2xXq7ZFScjFCQ+Hn9FQjLC
 7CLtzgTM1lKm0v9wgaV1piewfuN+Llkuk/DXRuWDhh8sL3MYSNx2LVNyxbpUTlcJGjzmymZQsCJ
 Mn4bBBFcDGjEkzjHXow==
X-Proofpoint-ORIG-GUID: wm0mR5kRAIyRh2iaQctI-KpEXdJeD6gT
X-Proofpoint-GUID: wm0mR5kRAIyRh2iaQctI-KpEXdJeD6gT
X-Authority-Analysis: v=2.4 cv=b+W/I9Gx c=1 sm=1 tr=0 ts=69b03968 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=G5qMDu7UX_ImuAN12AcA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100134
X-Rspamd-Queue-Id: 00AE9253CF4
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
	TAGGED_FROM(0.00)[bounces-32915-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Fri, 06 Mar 2026 08:52:52 +0530, Aaradhana Sahu wrote:
> Currently ath12k AHB devices request firmware in .mdt/.bxx split
> format. AHB firmware is transitioning from the split format to a
> single .mbn file.
> 
> Update ath12k to request q6_fw.mbn and iu_fw.mbn instead of q6_fw.mdt
> iu_fw.mdt respectively.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Use .mbn firmware for AHB devices
      commit: 27401c9b143278eb9fa7d46f97ab063d65e5afd5

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


