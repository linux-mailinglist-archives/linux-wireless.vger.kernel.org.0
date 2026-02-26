Return-Path: <linux-wireless+bounces-32230-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBr+BTC7oGnClwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32230-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:29:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A361AFCE5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C1403007AF1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 21:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D582877FC;
	Thu, 26 Feb 2026 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RRGKYzP5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EdiDce72"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E57313DBA0
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141355; cv=none; b=ddK+WFvEBb2qbfl2ZVb7Y2ZNjKQ0EFn+DP1G5dBUmDYX5qqrl65sLLgkLGM5KTJFUc3VnSIQvG2VHDOJ4o4KBJRRcpXxeHGbqgub8I/242zHZy6UQg/Afd+9L3xXWfTZ+OweUsiUjTmSJ5PJmz1auP9SRUEaG0SxkDVqHeXBFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141355; c=relaxed/simple;
	bh=1GSRzavHd+kd4i9na/PTVNgDLzMrnLxkpkqfaY+aG84=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bdlfs1GUgTt8InHqLzl0yQ55KhP5TCbLgHCGHshUreJhuBe73WRJK+1zmBekWAGQo2LNL28a3E1I4hARUNLu2X3dR+GUUJmqmGNAz1Sm5PljAhPiJYtcruk9Y/x4q5BkQWqy07jGJhIVhttP7LL2OuncDeak5pXZs4Z/v5seu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RRGKYzP5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EdiDce72; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QI4Vu41394935
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zBNNAoiali33kDKKph0YyHkrUL8139XPK44OLbCKSRw=; b=RRGKYzP5SgEx4oMJ
	WoE5beAAXfoWSj9YEHjsjWXjZRs3IRqrTeUekYTVCrWk2UqGfJ+vOGDwrDvnjbiB
	aqiP7wmMVjDyuRd73mu32U74MbPznhmoyUsOgJEArqip0C8+rXALNO681SX7lHqx
	oLz73VtDeHZtH/mC+4x9ADXTbSdSueDS0j1PL5zokHQe8vfhZ4t5QzH7jp3NU6va
	mPlg4cObEqgKC1Q9/h/JXelzE3ccR3FClbqSEAJ7GZCCIy8RWf2Irn53AcgzObtf
	emlzlfq8LoPs6bVQl4Y8fiMDWIH2V8/NMdNLSzcmrNa24TLSaUoUQY+ibRTYpXzx
	+3M8sQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cju4r0uek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:13 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d498212845so7333864a34.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 13:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772141352; x=1772746152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBNNAoiali33kDKKph0YyHkrUL8139XPK44OLbCKSRw=;
        b=EdiDce72oEDIBVG/bntw6Xn3hoMZ8cp/1anMdOMtqNzHwTsEcH2daz37l1Q45rBKFz
         ddm/XLbzSbMZNcPJJsl5UPTpKX/PGLpR1ZCavj/CJ8eAVmqLxNbvckaKMIb1FFQiDP9L
         7C9ALUbFrsUJYwendIuvTOEZehpSZhLhe1dRw0OW3KAgtBFLV8OUkIQDoEg9FlPuARus
         pZ7T0Gftzpe7Lk/21oqapuzMGfamlyqBjnj5poPNL1JOkz8yflNQYOw7AkOQCiF4a2Sp
         lBLOTtXB8mPs+FSyqhrIOAkoCxeutMV4/DEquci8OKIlruqA5oKZpODKrQsm+t8bxxHI
         5c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772141352; x=1772746152;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zBNNAoiali33kDKKph0YyHkrUL8139XPK44OLbCKSRw=;
        b=HNTMPstnW1iAlD7MLtrcO4ZJPTedIP9GbuAyE8WzsmW2cBOCl0GDgYdJ2hEa3HaxOe
         B52zn39f9LGSDDB0ocXVYyaRwLD09ps33njK8PpgqYTDCVVbIG5FjBb0ckU8+J7QM9lL
         Ub5QIqWeurgKf7GnnmrshfFCAYz+cYosYsdOmlTtf9Em+uOqv/M1YKSpi83rqyHuj46b
         Kn+28eBA/hJnZjX6FGl5ozLBkx8Fja7sakruB5FmjepGBVHtwFGe4lsZAXi4erXlJXdV
         xaNs5lBx1UZ4kzdPk3M6YkH0f3mZXzymqpVcwlaLMbRIlvM5hyxPKrCfS66jsDsdIX+E
         28aQ==
X-Gm-Message-State: AOJu0YwySxvDgQ2pvcbQ0qFkUzs1Jup3hU7E9zj9Do/TnP5MC11Y6OTC
	7jfBEyDkOzo4nnwPhgxiJdlAYvrT8A6BwkVYV9Cg47LBcWt7QOtBYPjc64UzT2ZE7Kk3eD2KIkT
	xE+uE7I+C5E4Kvc6pKMNXB3Bec2IyY7vNjhzfjdYs0ASfqfK0BTDz3iIzyHKa+pESmnJDCw==
X-Gm-Gg: ATEYQzxBriK2K8QITKe0vQ3APS1EUS+RtS7baTFJEjq1GKJluYvJ+xcbI286qhpB/b4
	CO+yFH790US04JGizmv/Xh++1SI4kZe+KexDjks3Ie0WGVGMUh58N5XQY6ag3qKvxiThnCVSol2
	YqOJ2AVqDeosnWHfYNBoTCoKH26vz6gaWFCioJFXjKIRG7X6iJzIRSoP+TPXkGZIHoDmUSNyuxZ
	WrFOX2xNhoq8grg34C6sUZNtcYjrPVeOSnCmqmcVJtZ7kgd2y3Cv6gscI3Kzj/Ou3Sxit7u4XF8
	ctR1Ag1tLjR3eCYZdgPNhz4ScJN6aZJ0RgH6MJHQNWP5PE0R/arsleMmC2WESXPtqXuHtnl9rbp
	1IuKSRqUnLTGgB+NmP6AsyLrRzPQ+ncvmNAPTwTzbqW30Yj1TfZdnwOcVEcbkmfZMqholo8ZOJM
	SN
X-Received: by 2002:a05:6830:4423:b0:7cf:ddee:687c with SMTP id 46e09a7af769-7d591af20f4mr594594a34.3.1772141352378;
        Thu, 26 Feb 2026 13:29:12 -0800 (PST)
X-Received: by 2002:a05:6830:4423:b0:7cf:ddee:687c with SMTP id 46e09a7af769-7d591af20f4mr594581a34.3.1772141351984;
        Thu, 26 Feb 2026 13:29:11 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666ed17sm2866703a34.27.2026.02.26.13.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:29:11 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Alejandro Colomar <alx@kernel.org>
Cc: Rajkumar Manoharan <rmanohar@qti.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
In-Reply-To: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-Id: <177214135116.1298720.1546784201463561323.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 13:29:11 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE5NiBTYWx0ZWRfXzbU8pwAtfKKU
 NWYlAf+sLOLw+5utAMmvXj95vH8bkxUYFcUuWphV9yP8g+Kg9A6gz5iVHi1ZU7dk7szKxUha8xY
 dKpMJspP/AJk94xpdun9Onmo9aFwQux0FSOJepxPbKaW5o4FI7L4z7sv95xu06+WOOdaT693jBN
 ZFj+GInWfEvrzqQFdDbYbLKsfDtw9/lLew4TNkp9ZdWN9mwdJp7G2hn/4dg/Ij0ZkljDkQ9hEtG
 GHpB2vxsryouxISzxgjKLUnBYjNBDNnNSePBg7Ax1fUVqauiy5IIkEpS0nYq84zSA657wciSq5g
 ImPkj/rtSCwBcPSkDWqLfEV2TowRj6sfmLY8eWh8/34tM6UymQGKT0zuU4TMq1zRDs/RKmZ3I2e
 jHqYA2g1Mtxsg12DcA2a1qOTYdLMmf/MBD8iBEtzYqwBonbUBVsCz3k83pvjv2d+y0j/TKCfbBb
 0bvtCSxJhUoYvf5llNw==
X-Proofpoint-GUID: pGFuUN_IpbOdXgiwFJOg98Pktr2B5V5-
X-Authority-Analysis: v=2.4 cv=KZzfcAYD c=1 sm=1 tr=0 ts=69a0bb29 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: pGFuUN_IpbOdXgiwFJOg98Pktr2B5V5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_03,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260196
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32230-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 22A361AFCE5
X-Rspamd-Action: no action


On Sun, 21 Dec 2025 23:25:54 +0100, Alejandro Colomar wrote:
> This only worked by chance, because all callers of this macro used the
> same identifiers that were expected by the macro.
> 
> 	$ grep -rn ath_for_each_chanctx
> 	drivers/net/wireless/ath/ath9k/main.c:1576:	ath_for_each_chanctx(sc, ctx)
> 	drivers/net/wireless/ath/ath9k/main.c:2554:	ath_for_each_chanctx(sc, ctx) {
> 	drivers/net/wireless/ath/ath9k/channel.c:165:	ath_for_each_chanctx(sc, ctx) {
> 	drivers/net/wireless/ath/ath9k/channel.c:291:	ath_for_each_chanctx(sc, ctx) {
> 	drivers/net/wireless/ath/ath9k/channel.c:861:	ath_for_each_chanctx(sc, ctx) {
> 	drivers/net/wireless/ath/ath9k/debug.c:717:	ath_for_each_chanctx(sc, ctx) {
> 	drivers/net/wireless/ath/ath9k/ath9k.h:446:#define ath_for_each_chanctx(_sc, _ctx)                               \
> 
> [...]

Applied, thanks!

[1/1] wifi: ath9k: Fix typo
      commit: a8911fbeff8bee4fe3376c5044b64fbf3cceb78e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


