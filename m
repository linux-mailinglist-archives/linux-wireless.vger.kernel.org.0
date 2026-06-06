Return-Path: <linux-wireless+bounces-37454-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d+IHJ99CJGpd4gEAu9opvQ
	(envelope-from <linux-wireless+bounces-37454-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:55:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1338D64DDEA
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:55:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="HeX/Wxee";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BiqLg36d;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37454-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37454-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5693A3038976
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92583B6C08;
	Sat,  6 Jun 2026 15:54:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3F3B635F
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 15:54:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761248; cv=none; b=RpsBtcY//eoQaR4ZVo2AzlRyP+PE6eeEn5f7EqzkxW9AfS09Ll6eJWfPVoHb/RQ/sSmO7rjUgx4qmNHPATqif9YcENgyc3W7HmGap+RgORagGf8TDtmc7qEnY+gAcuBNe9u+/wb3dTcKUCzLDdYuNqkVXLc3PMRmIAnUk6ygnUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761248; c=relaxed/simple;
	bh=mIDJ/zWS2BRvF25HD3t1xz263H2SM/Zkt5Sf31wsJOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=arlzdPc0TQhREW5ixcI1/jq5AF82Q/1TEoEAc+fKLkToYUZDi2D/EGHZymehy8oZTPkYiSae4H2dDMwU2QX2B/eeJr/hB6KE+Lm78tTThwoEXjBVCi9D4iIzulm+bpL1yjo6gOsqMsmFeP9kuPKFF7w3BS+rew2T2Cn4vnAVn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HeX/Wxee; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BiqLg36d; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656EuM882178646
	for <linux-wireless@vger.kernel.org>; Sat, 6 Jun 2026 15:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BCRpkNNfJ8YKyuOgeKdTqqw9/0ZmJTadsnbIZo5HI8k=; b=HeX/Wxeelinbmsyj
	Xs0PBWMU+8Txckp3780ESI1DoFXaiTgI1jHHxtKheFgJZN5RO3P6gGHc8wF1kKSU
	3R33gNtcygNoIpszQoZo02y+8PMEwvzy0ZQ3Ns9XtYuz7P0yHhKxlHi9b64g4UUK
	PayOobb+wJ2h2RL29X+EiYtszaAZydZlSbtMhVAtDWZZHlFuZAq7mx2xW4o6JoDd
	UwS9XBujOg/me+SudIAWyoq0giRIXRNEcWMbww96oDDY0kb7hX7EXo4dyFdI1FSz
	55UE9iM2edKe0pK58otBGWosPSBH+J76Uc7cFeNVLYz3gAVH0ScMUIatEd4PQOWA
	nVm2lQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w1q5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 15:54:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304c652be4eso2374969eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780761245; x=1781366045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCRpkNNfJ8YKyuOgeKdTqqw9/0ZmJTadsnbIZo5HI8k=;
        b=BiqLg36dyRxJAtf9RCRxry6KRkx2PnlTkecmI/O4KKOOq3mxcQ/N7iCBvvD5SfUXxu
         LEzyj5NkRT0RD70TbwBKyLCRTaXEjbO/beh3/E97SAe/Ks7jYd7C4sTxQRaaiOgKgMC3
         up5q1ceW34z91e+DgmuyQBGkjpK+u0XyTr06KzvSN799Y9cGU0aTwZ32zaFigcYp6Spe
         8gynaP/Y5B5PWeJa7ls2KcYxCFKfjshcVn2U1BqljwBNw89VjiCPuwfLqIqEy1f4PSrs
         cYPGyDmUB064opuku0vDB1xE9OCwM8nA0AaifabeYBcV9Nwat/rc4jzpQEmVxIbLO4HL
         peyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761245; x=1781366045;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BCRpkNNfJ8YKyuOgeKdTqqw9/0ZmJTadsnbIZo5HI8k=;
        b=TrAu7k8D7ft+wXvOZvgqG81rqta2FjQoBfkfdUVTIBOkWQ2egu6aX/rCh2ikbntLlR
         a581KWo1HnewTuZbiE//IpNcLfn36RQUIHlorxsy7+UO+igLJmT9G0LqbT6sQX+87rNS
         Qtz1GxJ/tI40W0sxZ74el2Y+ZGU4Iw/nLJsu6ziUNjxcWdMi4CE1bPgXmbMt0WW+AOB0
         YY2SpppvRHTFey9s2Ddje1VtLgrw3H/o/Mt/oyI0VrSzlswGNVbkIl6BPlq/Ljo3MOnz
         f4CwX2p7dfQ5YVmuFVk0zmQFpkbAqwMJucgiX6Qhuf4pIVAjmREZshrPD2+AF+qcAMyB
         UpLQ==
X-Gm-Message-State: AOJu0YxIVAKDx9P/nuJnoQkAa4bAXgIbpga/+oCJm4mf3xkd2QbigZOB
	ILeHoUoK0qc+wtsyTYYkJi4w4CwSOluNDpdWmrbz15+zrbM7kXXQhWnUTLC6LNzPsSRWNqKfLHD
	GaO0gszM8sJ27lbPtPDInUw0AMCPgSznODcS5RCQyMAS1JGtcLNZmQD72f4hMOTtAhTgssw==
X-Gm-Gg: Acq92OECNwhErzk/dMH396Q08Wlab5QY9ctoIR5PBMe1j5dTlKBT427gTOCqCQcy7xi
	MX0AP/C1ij1tY6uqTu67dp3BHue7SzLig/XbBxhqj06D1PF93/l6h+MrmQ1coT+2o2EIc3jnMBH
	9ZYO9mMYephbkaLm1FCA41nefsN8AufD5VvU5NQe+31jfWRSvHPPGKA1HAcY5uTdeFtyIX/39lH
	otHqJsvc5vCIikhCyDUyIL/cTw1CNMCCuUV9oGiKyfRqsfYfyOfz0IqmnIWVi2qnfGPv5nxASrR
	rl1XwzILa5AifbnoWHeXedxFKzXQTynN8cEm4b1YMU85m+wVrtLTiSF3t/AWXUnudfyY/PiwPoB
	IVLIHuNXPHZl2uofYdwtyU7Vcaqq/A4A4u3RAHvjp7DtsRzDpseV0Ntaa8foPw59Xwg3CXDL1hI
	M6O4DYaMB/iA4=
X-Received: by 2002:a05:7300:b296:b0:2ef:1d11:18b0 with SMTP id 5a478bee46e88-3078001f4eemr2420789eec.17.1780761245375;
        Sat, 06 Jun 2026 08:54:05 -0700 (PDT)
X-Received: by 2002:a05:7300:b296:b0:2ef:1d11:18b0 with SMTP id 5a478bee46e88-3078001f4eemr2420782eec.17.1780761244803;
        Sat, 06 Jun 2026 08:54:04 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm11240392eec.24.2026.06.06.08.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:54:04 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260517042716.2218386-1-rosenp@gmail.com>
References: <20260517042716.2218386-1-rosenp@gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath9k: Clear DMA descriptors without
 memset
Message-Id: <178076124412.768205.15749977487691781187.b4-ty@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 08:54:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: Ik3g4hdLYNbO2WfOGSXL3z-vNjo1Zn0S
X-Proofpoint-GUID: Ik3g4hdLYNbO2WfOGSXL3z-vNjo1Zn0S
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a24429e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Z4TRpoxFFOJA4x6Y2OYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE2MyBTYWx0ZWRfX3J9ZNu6xwPwt
 8OH+Oc9Nh6Gbd7DTMGcotHQLzsIL4GADzSNNyIxwZmyP7lXHiOrH2flaUYqSFMZX0+OiexwOMg/
 ahf5RBoSZU9dmXQ+eQgRTYbjwA1ciQXgkhZ8Msn5NyRThGrGIiggqRvx3M3XjUbk0wDJ8Cb4Wms
 P1p2id4/q22HiHeziQm5Mp59+s6Yzrp27JZRRaCaFMjmc1DjZstHRd0C97gkPohtnpLGqUfXEtb
 JzprSX7zBGt9QMRuA27eynsH+10olOiyQIaYdwDC/ezvsGKL3B3ZmDoq33Vo2gLuR7aYNKvfVwD
 HbwFcTVv8GPeTp37vGG0poRQuxtbhgaJw5ngZHc/ntFnjGNGOOeHu8W5ShhKsQWZ9VSDQu8OO9J
 FEqPIp+CLjnWHZVpwlJB5nM7U0V15B/OzaH8LbOT0Ytr/kXWKcaTSFEto9dBXClJql758xiHV7A
 XeWfWi8r16As0GitqQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37454-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:rosenp@gmail.com,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1338D64DDEA


On Sat, 16 May 2026 21:27:16 -0700, Rosen Penev wrote:
> Clear ath9k DMA descriptors with explicit status word stores instead of
> memset(). The descriptor rings are coherent DMA memory, which may be
> mapped uncached on 32-bit powerpc. The optimized memset() path can use
> dcbz there and trigger an alignment warning.
> 
> Use WRITE_ONCE() for the descriptor status words so the compiler keeps
> the clears as ordinary stores instead of folding them back into bulk
> memset(). This covers AR9003 TX status descriptors as well as the RX
> status area cleared when setting up RX descriptors.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath9k: Clear DMA descriptors without memset
      commit: 44589c155e6f4531100ddd3b6478190edd075035

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


