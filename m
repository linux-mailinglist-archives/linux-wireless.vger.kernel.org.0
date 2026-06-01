Return-Path: <linux-wireless+bounces-37274-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GWjI2C7HWo/dQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37274-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:03:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D5622FB5
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A27D306FEBA
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 17:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC3C3DC4B8;
	Mon,  1 Jun 2026 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8Z4ilxm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GC+ztiDD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74742882DE
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333240; cv=none; b=u+gCcSHh+MEqaOOoX6OFLfov0pdKnT+SPPWxvvI+ibhKC8g0sTVN0Q1dfZhZhrnAy3NBth9NCIa+NNa7HxqTaeYMX3AaoEdYz6erQk9G1akKgvdfL2RsZ3ser8qf8hCJQBAQEmBBF3tcsU1VU3TJbdmpTDiS4uYuIqk1TYdyfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333240; c=relaxed/simple;
	bh=57ZQiSYyDOh7MEweuN7uO6mPWJb9M8pTmFNFFAS0XPw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XIJW5PfxglYZ7WC7NTiwt0yiLAo9CgFn/6+drHrBIZHCBTaFYPiNh7YK7fbwWODNlZQQKFtZA4a9/vCMHRukQCkpCcOd5Un+eFBd8ceId5kaPFoCQyLWawZRMEql2hw2u1sQ/8Vl9g7Pb5RNt5fFm6/ZLxBLq4HMRY/SNL4C+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8Z4ilxm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GC+ztiDD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651EgZHu3563524
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 17:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QtbUhVE2fF9TX3S4/PmYqoTy7RsjwKNqXyyUYeZKwMs=; b=P8Z4ilxmNg9bZsQW
	1/BFWl+IkOead/nJmEdv1g4cdSEa7zK2/xWK8ka/bCnaf2oyBfyCAgFRPj5XiNwu
	I6tP11mTVMqCtZidZw2QzgGOr8XAEZ/Qmm0M2SN65Adyr41m/9OSB5oANEaN5b1H
	2c+qgLvWa+SKZI+oz0459fNpfTbGVHU7FFQelw01Jy5VSI1WZ7AzpipH+gkFBbuZ
	TEnF4sSqH9aQODDt5y9HGOKbVo1/itg/6jpfJVU2XMNFDb8ykwKzvhZ/vrRQZqON
	ZN21Xb0L9RQlEuJBqlfvvocLc/Mnqsm6tIAhEy5cAZxpYyaYDGYElAIQh74PKArJ
	OyVFZg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6rxt4k8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 17:00:34 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1365eb2a74aso3202505c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780333234; x=1780938034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtbUhVE2fF9TX3S4/PmYqoTy7RsjwKNqXyyUYeZKwMs=;
        b=GC+ztiDDjLUtq0BnCdnN1zu0RgFKoL173D7upAUL2DfI17zsJe8XEPLL99+Z4Zmp6v
         dycnsJ3bnCIaQYGHyOQvrIn8CC2kaHdddf3ljslkFfKk3NfGORwtB9prKJt4vEauvR+q
         Me34WCZgUvx2u1ErPVwcYHceJiWEhRYW1a1ADv4NdeofBZf7XvE+6QtX+jRMIZ1/0MRz
         sZ417ZI5xD66W+8dKyxNPcvr+W9ZSpgnrvAP8pIpX4u81BvBUz3SsqiY4XNvPXCbd/dn
         yHWHR4/JSwrdN8vMsbKatOraO2zCWazOiz8/e3QNpVzY4SPS4HyOYk0NZuBkbgyV3PgF
         VYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333234; x=1780938034;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QtbUhVE2fF9TX3S4/PmYqoTy7RsjwKNqXyyUYeZKwMs=;
        b=fgc2g6dfBfmXVPlXtQal2RKWpquYFECStb6BrDjJdSPLXfJ9JvVvEsQZZRieHCaHTN
         sutE5KqSW0gU05pSRze4lx1bEBdXCj0GMdzFsjgBlQghJlgzFPi1OMe4l4E2BYhKIpR1
         gH1f1dqpMawEC15oUPGln6tODAtHIhdbxJ07cWLxbslKbHhmDfJoQ9vOctBBj0Vj1uf9
         656+O7WEbuDM4N9Jw/12IARX9q+EbQrnaW5hwAOQwtoGijx6x6gzLWkBeU8L5eFuO3oC
         0tjEb2ZFyN/erH/9y31cVKWyUDsmfLnJeeFPI2C97bx5y3TKecuCkLb2n7D/vfktoY/e
         iPvA==
X-Forwarded-Encrypted: i=1; AFNElJ8Nn/qm8T33JfvvxTOsm1liWh3ztCP/atG7KTv16YsSEiee0ZmrWCE3ttZp8KNVJ94XacinjBE6r0xQ+lp72w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLLrfwNtxilh6YaT6rDehcVaNfbi90MtfmbWGxGhBp62e5O0U5
	q4r7GW1uCnjjc5ua+pc4iXVuXkAguIFhDhp2kaDJGXyph60ccaFyoPrASu7p1BU0l8CLfh1nqlK
	IYu0+MDEPUEV0vRgz4i5s35WpsEVzHPbFAERhWzZEyYp3f8XAfpmkD+ZETS3Cnb+HQL3sP3frzy
	T0tg==
X-Gm-Gg: Acq92OHyTiBlVVujLGvftqC1tZhRdVpj+YqXrk/qXUnS0NRuptMNqqPlJqmVNbMP0+h
	nbNrc2x2p4s8/8VwGlubAvkd0IYA2aCXPq2ZWI0IaAAruqf+m0wbcHlCi0HYgr2SdIYA4zyb1xk
	kOpoWCeuKPt4CLMa2pLODhnWTp5urQmws9oAAWycHVsmJevrq94IqH4E+F+CiMql0h0Btg1nGhg
	L1zqmez5IaEbMp64d78vYfKzjfO+5T94RAcb+BkJJ28ruXTQpC9fe9r9w9eER9Wvez0lLTCtzQ6
	Yydqp3gIvOpCgOjbpe7g5URBdvkHWrMNljEJgnv1Tic3qwnUyoZA651pM/SuKG7F/dcWrMJFknn
	zF2aAFRschSuTdsIq18M1dEggzgcohcZbhuKqcKWxvpjaHB8RQBooIx5eRAog4qB6fYtYK4qiYf
	iflQSfW/bbCGo=
X-Received: by 2002:a05:7022:f9e:b0:12c:15ce:a71b with SMTP id a92af1059eb24-137ee342a69mr115602c88.25.1780333233550;
        Mon, 01 Jun 2026 10:00:33 -0700 (PDT)
X-Received: by 2002:a05:7022:f9e:b0:12c:15ce:a71b with SMTP id a92af1059eb24-137ee342a69mr115574c88.25.1780333232808;
        Mon, 01 Jun 2026 10:00:32 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm7151625c88.9.2026.06.01.10.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:00:31 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kwan1996 <laicheehou9@gmail.com>
In-Reply-To: <20260507015336.14636-1-laicheehou9@gmail.com>
References: <20260507015336.14636-1-laicheehou9@gmail.com>
Subject: Re: [PATCH v3] wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS
 reporting in monitor mode
Message-Id: <178033323119.2045173.16227438504007191011.b4-ty@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 10:00:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: Iiod2JEug6ZcM0KMEve0P49MYL3BrItm
X-Authority-Analysis: v=2.4 cv=dsfrzVg4 c=1 sm=1 tr=0 ts=6a1dbab2 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=AD-vRsM93oxmN9sNzJUA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2OCBTYWx0ZWRfX6cyIuQM9QMcc
 q7oAHY44tolJi/7tkNGdlXgfcCFVXsltc2BPGl81R/YyWjSlWd2DpedomPSp1/TmkN8lqdBx/SM
 5DlFgj3jQo+82OzXnwI2hqrkJV+UaC7lp6ceUDJuEGlrbhVjsVavNUnuoH5D5EzZjezy72ZsNwq
 YcGwiUPofdp82q5f0xiTrGbq3K2mcgN7scn8wnJtJ3ha4ubckbhdZDu8GnGOkeveBtzNOfD7+0i
 D4ejg/5nMsE+AVs60X4HVx3r12GOXLKFBSq15PsJ0EQ2vsb0JydBJJkplEKP5BYHCpbYU8gxdrG
 ckoFBvzgqmkxbBj9Sh3qVO8KjMy6jsbna5egNMGQdco2gwZKGKFkrwYs2NqDPIEV3wfrAyM23kN
 j/DVCvud9rRgQDL4kerHSbeJ7mKnTqb8MNkMkTomKM4H2ygu88y0fDsxKdmXUihv38O0qWobBPn
 nNvTzjfgTUQkmYTdMKw==
X-Proofpoint-ORIG-GUID: Iiod2JEug6ZcM0KMEve0P49MYL3BrItm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010168
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37274-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 090D5622FB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 07 May 2026 09:53:35 +0800, kwan1996 wrote:
> In monitor mode, the driver incorrectly assigns the legacy rate
> to the rate_idx field of the radiotap header for HT/VHT/HE/EHT
> frames, ignoring the actual MCS value parsed from the hardware.
> 
> This causes packet analyzers (like Wireshark) to display incorrect
> MCS values (e.g., legacy base rates instead of the true MCS).
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS reporting in monitor mode
      commit: 10085a654a4c2331d5f0cdc20bfc839a49fbb886

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


