Return-Path: <linux-wireless+bounces-35869-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPPACKWu+Gn2xgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35869-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 16:35:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C44BFBA6
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 16:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0C1F30877DB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA423DEAED;
	Mon,  4 May 2026 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IKlznEZq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hi08jJzc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8CE3DEAD5
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904481; cv=none; b=Ys2DXA+qgNB6iBNKRN5Fbi3PFeFjOR5cgwKvdi5GmorxApKRK+KZbuYHrna75GM+lSviOZGizal/HbM46BxEpJk1tGhALWcR7iV4gqbAHcstWa9iy/6YUKIPPHcHaztBzKa473BG3uQX1GCIZQGsQgQjUbX0EegHBCcc5GgLlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904481; c=relaxed/simple;
	bh=hUL7aV/KdUBYVZfRe9POGjFdp7GN/kNA8KmbHAI76sk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ti619Oe9DiKelxtAtDmG19g5NdHd0IoRFEBveh0Hf1gWkExb5U8r6j7ixdpurRCII5hZZEPzdZ3HTtU9i1IWbq+ZwGfecTi/N1cf9zGPxktKwALej9yrVFSSL9OjJsZwYyT9ZoRhQN5C0O9iCqKZJ53dshb4yehQdbeNs2st+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IKlznEZq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hi08jJzc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644B410D2850040
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 14:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/39q4TNNIKfQVBrP8ix3Gr+iP8j1jkn+DJigD+OlIXg=; b=IKlznEZqk7GAkt3R
	4IBBRWGVy+sTCQ3BL/CWbhHxj1EjNukvEnnkQ7Hj1eZcoESmo6XUY8VTfaLElgej
	rNY0IlJ14BAwUV4k5ncIEUnAdkSWD7qQ6bI787Q33KdZNO4l9Ln54iz1eUoPh44o
	jSso2e4rVqnsvidTVQCAsOYXqjivh5LzlwbZJCX33/U5rNtfWXwCDxei67zgsIPT
	RPFl660mj4LFGr/moVsRU5HnDaStVqdNsx28gYrYwpXSRaEiJBVqTo4YDKfYjWdf
	1Ga+joPqG9qOKGSFkO6DxugySc0XccBQNzz1gEvTHkqX4h7kX5NbdxNwerFgYZNy
	cVePAw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwxk1bumf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 14:21:19 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1270dcd11c1so7827579c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777904478; x=1778509278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/39q4TNNIKfQVBrP8ix3Gr+iP8j1jkn+DJigD+OlIXg=;
        b=hi08jJzcOkYcb8EOPQypfAORL7IhiAIEwn3Fhs8Cpnu/wxdJ8M3u29vd8FMPOt30yX
         STuGXkMBuxaY58DHrUuoc/lbL7LvO/1AZgsK38rdipEzcOSSKHon30P9jder00vnPPE2
         I5nG8s4pSxvp7Q9RHLVrLcGDlh8hZK0rEr8awA4wH/NF+A+scx4olLAg0UchiBFpLin5
         ZrXeZHeuddU0CrvD1DQOYfMreaMv7bHriULgLNAJU5SHYuzkborrUYyDUJ1T6lYUCKM0
         tVIbEMWlmw7WtCAOzX4np0MkNJJk7Mdbytl4MTvwHlKARZGH9BT7VBF2z9rDiwl1OyQW
         r/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904478; x=1778509278;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/39q4TNNIKfQVBrP8ix3Gr+iP8j1jkn+DJigD+OlIXg=;
        b=YNyxm6jY/BCM1cT1GPDamyFQ6gkdFhNyKn4pCuVgPQDJzQho5zvUQua8PZ/2mnjAqz
         8x6+3ulmkaAzCHhuwHHtM5bN5/W+0H9cuCtNouwY29xHiRcKaVKNXGOUodq/qfI756pC
         mVo0EFMYs7gMYFZFcGwhgsfjcUtw+LKBL+i0DR/S7+esEA2LYAArasl1AZYiTj36pJWq
         7KddW9pf3zELeMJskvCkEke4DkvnafYiu/Drqe6lPxF0vRuOwOheKJ5eHsa23ykcS/WB
         FlNwV6ofYpPsATeh4zdfPb/bUBjOQak8h2e2WXfX9jKivpLSSpvDLNsq5IIqEjMPQ/sy
         GFIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QNEP4RIABI1ZCHemt1JLqYn3Z4OyZZA9nuaxq+koSbIBijdO/RDIsRbyF29q0DYUDK9NFHsNfIjfALLGVdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtjOpIIikdlq/WgshEuloyELeaP22hDYH1DyA63oc8NsKZwtK9
	4s72y+yHYPh62uOgseOtVZe4lnpUSOCETbxysmT+YEhG+1Wp9DHs/zIJk6gS1XI41BjKvvyMQps
	rXhzQMqguGAZqFVJYDmh6R42uqbFJaMHmSU8j/o9wyZdyl86evo7I0GB8T5jCclqJrWyZMQ==
X-Gm-Gg: AeBDiev315N47Beg1QKwvN6ZI95YMYleSvymijC2GUhPODtkqxfqLFLIZC9i26OGBxl
	njYavZubbKVNQ4mYsI3RUFf7rtyHuaYbAr1kiwdhmI+WyfVZS0Wv/MCCXB7lJtAlvz4OmFRJGQc
	dc/JB+AgZdCcmBixNRJQHYO+52YwrAxtKnTq430jpwa9JcfQcuwDa23NOCi8FNK4FsctLFQUF5z
	x2ho1VPQYBOJTrImAi2lFKCVw2G+Vk6nP0ilcPh/VW7UylAhk+cYZ45qomI72RpC2HHu0AA6mYl
	ZQyYAIVCaE3+Fu36ZyViNYyZG2fhoaukKHpNr5zwbDmOFUeQvhtDj01Ik+wjQYNI6wP3g5FS+up
	ukWP3W7jD0U0cmhHTaN9qzzdzgyh/yep1P1qg6EF/KW3ib4pohAgoS8Z/jn9u2woD9s1IaS4NUp
	ySAr9e8RhVGti0voKV/wHZ4Q==
X-Received: by 2002:a05:7022:f8a:b0:128:d375:f1cc with SMTP id a92af1059eb24-12dfd7bbc77mr4566627c88.12.1777904478409;
        Mon, 04 May 2026 07:21:18 -0700 (PDT)
X-Received: by 2002:a05:7022:f8a:b0:128:d375:f1cc with SMTP id a92af1059eb24-12dfd7bbc77mr4566590c88.12.1777904477585;
        Mon, 04 May 2026 07:21:17 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8452edesm16546186c88.14.2026.05.04.07.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:21:16 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: johannes@sipsolutions.net, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, Vincent Danjean <vdanjean@debian.org>,
        stable@vger.kernel.org, 1119093@bugs.debian.org,
        Salvatore Bonaccorso <carnil@debian.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, linux-wireless@vger.kernel.org
In-Reply-To: <20251209100459.2253198-1-jirislaby@kernel.org>
References: <20251209100459.2253198-1-jirislaby@kernel.org>
Subject: Re: [PATCH v2] wifi: ath5k: do not access array OOB
Message-Id: <177790447622.1253723.16700354690641778270.b4-ty@oss.qualcomm.com>
Date: Mon, 04 May 2026 07:21:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0OSBTYWx0ZWRfX8mpX/Xw65/ky
 MHnkYPrKZoUFaeH0hUV+6AlBBsN5avTQoT6XX1CbWLLUrBWH+t0EV4ETLZfUYtzJ64no5izCURU
 fhVdDGPklCnpL5y/bavLgSr5bJ9cIGrbrkczdv8/kWWG34SbuajG/PC0h2SXCq6BCl46uRdL//4
 gHAmP103iMx1x7D/AyDqhAPO7tV7xVb+6cO5ZGAIJyJHE8zesBmaxTUilTw3ywRYjtfnXdBTqjW
 1A4x/Uy/gLYlIQsMcJWpN60hbdQTZoBWUx8TTWvrf/lB3r9ORd5IaQBftPLn1Vqztrk+GxAM7wR
 kBnl/iRSbZewkFjaXMJPmcwayF52cJBctuyXntJLc0biUgKxhrYMLhEWhfVFKh0EAdyVc/kkSsr
 syvdDX5SYsHovWDKjCyL9yXqrY/9bEKk2sdyq1VvV8j5StI+/6NyS1WpbAhdJxefvHWW5kCNheT
 g497EX5JXwLcfi/kFFw==
X-Proofpoint-GUID: x6Te61fIpQWuvtswYtOVib2KKFJyBhdC
X-Authority-Analysis: v=2.4 cv=bb5bluPB c=1 sm=1 tr=0 ts=69f8ab5f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=D2o0NHJcERTG5uj2nT0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: x6Te61fIpQWuvtswYtOVib2KKFJyBhdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040149
X-Rspamd-Queue-Id: 677C44BFBA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,debian.org,bugs.debian.org,gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35869-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]


On Tue, 09 Dec 2025 11:04:59 +0100, Jiri Slaby (SUSE) wrote:
> Vincent reports:
> > The ath5k driver seems to do an array-index-out-of-bounds access as
> > shown by the UBSAN kernel message:
> > UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath5k/base.c:1741:20
> > index 4 is out of range for type 'ieee80211_tx_rate [4]'
> > ...
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x5d/0x80
> >  ubsan_epilogue+0x5/0x2b
> >  __ubsan_handle_out_of_bounds.cold+0x46/0x4b
> >  ath5k_tasklet_tx+0x4e0/0x560 [ath5k]
> >  tasklet_action_common+0xb5/0x1c0
> 
> [...]

Applied, thanks!

[1/1] wifi: ath5k: do not access array OOB
      commit: d748603f12baff112caa3ab7d39f50100f010dbd

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


