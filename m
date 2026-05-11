Return-Path: <linux-wireless+bounces-36236-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BsOMNj2AWoFmwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36236-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:33:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A7D5113D2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE5CE304A4EA
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61C29DB86;
	Mon, 11 May 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YApZwCjP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N9y8dSVd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A372BFC60
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511793; cv=none; b=hN/X7bT20h66FlUAGx1lVt3QoMJxWIqPE5pFxoUMqYq+StqnQv5N40IlZ0SI4czEDQDLr6qFEgfbye2LHysVLWoeMp9PzHxmHY56WB/UMZVvJBc5JkK0Q03fjLOfDT/hgeEHNA2CYemdedlwd2H0hlOxN/W9d9VVJXYcTrRPbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511793; c=relaxed/simple;
	bh=Y3EqQFjhg+QPK6ZnLW/fP3HQwZ9T530sZtPSA3Od6+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K1pB/iT71WJnAwepG5+8CSvBqbeX3BC5oEPOvW/3tiglpt81rTWWQIGq1PN65vl3IXwsSDKGcN8wCUN3Nrn5LxbpYor+hMms/wTzCBpP30ojwG0AlolXnp8XoEGMyiBdS16um8Q353wyxHHPh7645cAH6ejDCGcvL0KMzmiAByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YApZwCjP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N9y8dSVd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BDU8623332639
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PfOJpH+Ek347nwgYropma7A+OAstc3H0lM5M2WgtI0o=; b=YApZwCjPaYhXn1mO
	v+0n0Sdpjvehiq1To/+/ivPBwksE1AOgwM+btFf0MYtPHBBgEmDpJ+hWDndZ9ih9
	TX3neOrQWuqPc6Nf5LKed+Io3JgM4FFBQSSoLegjoUGjK4a6x8iu6wLjBOY6l6dv
	GgO8URKPSiviZZnvMvH37/VvnWMJ7TSvjOxx4iQ0+NLm78aCrAr2v+NYWGFCy9IF
	iRMEZM8UBQBtrw4rzK3Hiiup+kxLVJIoheokDrZsRMaEZe7szLfGaXnCDZGTQYtp
	TvPScqPec2l5Pt0Vl2okkqkwmMQ7Z/5F2vZeRPSAdQgD3J05zxqvalIbw6bMThEN
	4QlZ0Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ajgssax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:03:09 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2eebb099efbso2568094eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778511788; x=1779116588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfOJpH+Ek347nwgYropma7A+OAstc3H0lM5M2WgtI0o=;
        b=N9y8dSVdEekf9eTBUZmzLTSE1OYscxDqBtGXi60YJk9oabHgs6OiQMSjJVWrSPzlZ0
         AQumjl+LkW9KGxxEcf92mAoScZkmKo87jEjf9sgzN4PrNIC21IKI9w/UDGqdyf2uT2ih
         kYWrTe+LuI/OHa8LPqaiBPYykjqUlxSon1eGFtQsRF+tXuLv2ksmZZ3Vm4u3QT2U925m
         zlJORG2j2kbH215LXRWOLc6npyqRyL6x21MIUmCMcv/xxGLTW5znwljoqb1M4lG8sySg
         3emYbrMR3dxjWFp01GPekKNQ3chfh2s+2Ww8/XwndtJgiTUOzZOWDHIS39YiL41r5oYk
         76Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511788; x=1779116588;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PfOJpH+Ek347nwgYropma7A+OAstc3H0lM5M2WgtI0o=;
        b=PNF1moCQHSkhJN8+DsPcfSZXvbNjDev02D7DCNu+KGTRIcq9ZW+G4cUq0d5+zddPkz
         8PYj0zHTPkQ3CUgGBnrj0B1Z9oBsv7wiZzdrU3UZbcNnQDwFsKQIjUBzpaYHl8meRKjk
         i3uGELe5oVna7Gl1xcQs3lMKgwmVFjNrrdkORFrC59R7WyApuZOH3zTShpWxhFk9QKOi
         5pmbqSu4zjYHRHLXvcc6sDcbAxOjhbwU2uRaNNnFzBHWKgZVDnHV8MtFLQKGwg/KocKU
         7ThNnz4C7XnuFnB9XXjwIrhtzVJ710VHYJyCBIjEvvcE49pUmDR5ajWWaKCsU5RhB+uj
         fhXA==
X-Gm-Message-State: AOJu0YxE0RfDVV7kK0LEyvvgS4MO0gaE/H8pi9imU+2YtAQrJiCpUd/p
	cGqvsCZ8IXm03iMBK5MFJCf0tXzTK+1AwTQqpZcF2w2CCyfgd86udXsdO0oVl+NdEiBkhoCPD1P
	KnvbATW6FGz+0BaZ11GNK4c/a+zduDvx1BP7JV8nqx3w+zx9ywKgCGOyEhVoP5815adAoa2KvYR
	6kZg==
X-Gm-Gg: Acq92OHhAk4AH1f+IVDATibXGgU9ZD3iRqlF9hfu+Wi9q3riuvY0QSDuu+9PyA0sElc
	GD5mbw0s62ZEPlw9nP84IKt1YHlIztB3Ov7yLQbD7ehlLmgMvKOS8MeHy29OCtVgEDVCSyzwQSP
	3gf/L4EwHPY3tAH2Vgyx49KStM/UJpPdGrLVLtDgloQ0l0QqkFOrdAWbjjlY/h/v+9hGezAz7sd
	YukDKpf7/iukXAsfcd8Ia1YSgeDiauXhum465ltlmv/1iRlBeOWw5OTVbcDbLq7e2A4JIpLUQ2J
	Z7iuBCIiWDW3XqREYXf2qLavCkOLTBhYQ1zABo7vFYI+GXwHI2wq5eIsDOzSgU3gH/97BNn1xb6
	/P9e4mbFHDG4M3ooP52rr6ZcsuY8U7++2MK6RtqhehNem4F4PyP11aEMfI8qdO0lydr9X4hbeoh
	K5
X-Received: by 2002:a05:7300:8623:b0:2ed:e12:3771 with SMTP id 5a478bee46e88-2f54da9251emr11486705eec.33.1778511788100;
        Mon, 11 May 2026 08:03:08 -0700 (PDT)
X-Received: by 2002:a05:7300:8623:b0:2ed:e12:3771 with SMTP id 5a478bee46e88-2f54da9251emr11486624eec.33.1778511787411;
        Mon, 11 May 2026 08:03:07 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm17330453eec.6.2026.05.11.08.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:03:06 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
In-Reply-To: <20260317180833.3061582-1-daniel.lezcano@oss.qualcomm.com>
References: <20260317180833.3061582-1-daniel.lezcano@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: ath: Fix the license marking
Message-Id: <177851178607.1372190.16665093744685318001.b4-ty@oss.qualcomm.com>
Date: Mon, 11 May 2026 08:03:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=GfgnWwXL c=1 sm=1 tr=0 ts=6a01efad cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: xg_GTMySGkBUykFAQMlUxk8Bdg2PkO05
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2NSBTYWx0ZWRfX6fv5ED0ooGdt
 /RA9S4Z2hNFk/7chsKPaP/gaV1QJy0tBZ5Ef6lnjU++OE4/txXm4lj3zvWULGEzXlygkDLQxvcp
 g2FT9NK67F+YHOFS9NJKIL1N/30Bcd6T72zRusv7ov8MIcXaapCmCuka+JizoCLsPoPMhbGezwN
 iCkMzyoGb4wsNRKGtoJkD3Wz15JG7duy+M3q6QwyEsy10qQcYHZZJ8k9PmyS7jesdTSZawKijZ6
 Oq8CdAyGghjfPwgmk92Ao1gtozC4hpveDE2e+bw6SATaN+nrMOz2T11t8dYRizjZkvSYACmmoO+
 dqyLeUA1KCeg+//iHDbG9YTfjjBsphxZcpYG+CXunl67OgMf2DPItsEU7b+fS7JxwZgjj5RLkI+
 RrDQ44LGrjFXFXZgY1pjTs5wAT+/ag==
X-Proofpoint-ORIG-GUID: xg_GTMySGkBUykFAQMlUxk8Bdg2PkO05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110165
X-Rspamd-Queue-Id: C8A7D5113D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36236-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Tue, 17 Mar 2026 19:08:32 +0100, Daniel Lezcano wrote:
> The Copyright for Qualcomm changed its format and replaces the old
> Qualcomm Innovative Center by Qualcomm Technology Inc.
> 
> 

Applied, thanks!

[1/1] wifi: ath: Fix the license marking
      commit: db17e958184be9fe2b6242b7c5b7b261c0ce7110

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


