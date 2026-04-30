Return-Path: <linux-wireless+bounces-35727-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEZUEpzK82mL7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35727-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:33:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2004A83CE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F263012EB2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5713BED0F;
	Thu, 30 Apr 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cuhgi2Hn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fSp9gsXU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02463BE644
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584649; cv=none; b=kDAj70QUCuMR7OCAnkdJDlGa1Pw2s5hIHQ1Hg+w6NFBp1ScwzkPkFZlt9OsbWXutzA36fPlInDHTnSceBEEhxjuIbHuI3F7kvlcTBdTNpMeiYXeCNqd77KB1TZK0EsS86gEHFVjWmCtKKQuj0SkkEKGyiSUATwi01EfRCuH9v+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584649; c=relaxed/simple;
	bh=da8XQzgsLpsI0Qh2lY3tLKy6aMZOPtf+Wx1P9UwEU4Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m8bMTi//Np7ghI/GlXac3xFLBSuJu53vIncGWRKc2VVXuwtU98Ee7XQTZwrQHcfPEiOeBlrgJNWWmuuXToef1FCJNa7hRJ+jm8FHi/k0eFfpZ9HTjjP6pesP8uFLrC4eBgLBpWZy6BGnS84TlJN6XipFbWSb/5O1w5/KtYVcZhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cuhgi2Hn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fSp9gsXU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ULFX9i2943346
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sWDkCoSlbuYaiDR5HNRavFuwUB81+inEL5KQtnFP9Qs=; b=cuhgi2HnP2zzv2vV
	p5aswfTxMaK5Ynd36MzEFW29CmgHTsB4BQuljFv6JdGWDwXrbRtE/hXa4NpwVDW3
	XF/slbG8CWG3oAfBmnizZN6AB0O8QlhhK/2s6CjQ2XZtH2lChhimWEETJKg67pSQ
	Mw4eVmI/THK+WGlm0Zd0Otxq6qa01Q7MmEogOOH0LEY//t5wDSjcW+G2tlJYMc5d
	AhflDk8EzlLBYIAG6M4rhPexXeQ80FaQ/pmnn44irSgBzFtWijqZP+5eYJx9PZfI
	3WcXrZURhDhEA0EGWTYvd16Wp2ZK3ikPXel6dHkhVfFzNYao+PxkrdofYThBJWHb
	L41nXw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr44dsp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2d9da2559aeso4737966eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584646; x=1778189446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWDkCoSlbuYaiDR5HNRavFuwUB81+inEL5KQtnFP9Qs=;
        b=fSp9gsXU2QNofzxCZ5mgH6RzEE2985IhHwyLHyHlG7nSLKfmHnP9jNAU7jQ0cgU4Eq
         mdV07a1+Y7e/luAzJOFVCyDAowfYI6d+gH+C4UCjnRf1QzQ3AGBKzi2A6ioQVlq0B1gk
         SrlehECfIjcVoHqP2QQGhFQmcnt/XDrlV9hx/r70xsPX2AbT4L4Hq5tSyVr3WQODaiHR
         krtprsoBBI/N3dwBx2aNXldPTgv2RucRZKUMd6sN3URJBqX6XHN8CchUmdLNUvuobruj
         UkftzA4/Ktq79uCM+V5x+117mn96MR/ckfiwrz1vvs9hGiT+pYyaV/uf4bzLKvoqorA8
         ow8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584646; x=1778189446;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sWDkCoSlbuYaiDR5HNRavFuwUB81+inEL5KQtnFP9Qs=;
        b=YBIFUnz9yV2WjfV4pYfru2sFeeNo31EjiJDqj69rz7Ude2EMbgspdPd7wjGdUtBcUU
         3Sld9tNEu+UJsIYhphzNWeUBDWu4SPyKeSseJBRBeG3zyleCRwYORWvqlrJT5U4znUKz
         TqfhxQS2gqcjZVDAWrLe+17F6NQUIz4Qg8og8/U1Os3DXrJF8WG+7iQlpimDAwteoi9A
         6fZ1uMD8WlcoSACEB+guAJzY4W+crvmUlnlSy6lr0TofqNFwbyLbnuClxWQ3Z2MA0fka
         IBOgawKhXSwGFqI0zjCbqFZ3B1pQYOLz6eEfXIWBb6ofcEqezuw4xgpc4bJrxr+22Yhs
         8mmw==
X-Forwarded-Encrypted: i=1; AFNElJ9/Z6U/ZJgEsk5DEQEPYNcy7r2NSR6wemm40pM5bwreZRDnctylZpReAzn0QtBpj1Km/Uf4LUfKKrZDPqI4EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtW+JYThVDzKM3WS2fBVEK+418LS77p9+F1QluiZKQUZt5PsHp
	sMx1z7xOxS9wgDg6FYssJ84bMD5KVjzCViw7nNDiaCsXZNoISQAZwuSMUnf9Ukv3taK63Aewj3B
	ZiWxQeiSKC8f1fXLSI83ZnF1CE/41KPDZznq6fGZzMKWSYKtW2PgZfjti5GYfQcADX6apcQ==
X-Gm-Gg: AeBDiet4mZHAnUG7o5WbywKLlVwShQ2gnphRO3No45b7157HCx8WmtkNFWFD7N/lawv
	btUZMZFNdKxslYhHMy2nyTULwqKRUpYHR5JGo0jaSX72RcsC0hxIN4u8eRPCuW99KTqPOiC1Hpw
	6XUXwiv16ygL1bKQwEFml+/wcqH2gIdV9R6tN7PVmCzCrRte+3EqDOEh+UAmfZVB/s8tV/Y2KR0
	4hD7DoKTivm2fk+KjpeV+whpj279wk5bZew2Z2Q/YaC++AYBIw2u2xoumxMeZdPlrV2NuaOcCX2
	AuJxfSYolKsEeP3cO7Vhl72Lj5FaF8Hof06Xf7MrZ+noTOE0tQ7F/21LkA3tjnQHKVdq9YeMZcH
	L6it+lFHjB57giMFcYm37Y4ijzX6hZ8vs/0eUjF9k8PPJQ4xAi22s/QXr2dJEDhMIwJd92QoJ6c
	bIMpuoA+9cjjU=
X-Received: by 2002:a05:7301:5808:b0:2e1:e3e6:2910 with SMTP id 5a478bee46e88-2ed3c0e4516mr2211223eec.9.1777584645695;
        Thu, 30 Apr 2026 14:30:45 -0700 (PDT)
X-Received: by 2002:a05:7301:5808:b0:2e1:e3e6:2910 with SMTP id 5a478bee46e88-2ed3c0e4516mr2211207eec.9.1777584645155;
        Thu, 30 Apr 2026 14:30:45 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:44 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Toke Hoiland-Jorgensen <toke@toke.dk>, Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260415222343.1540564-1-tristmd@gmail.com>
References: <20260415222343.1540564-1-tristmd@gmail.com>
Subject: Re: [PATCH v2] wifi: ath9k: fix OOB access from firmware tx status
 queue ID
Message-Id: <177758464420.1848985.2616333328470266377.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:44 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f3ca06 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=UgKvG9LsBQosp5XyPFkA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfXzQtqpo4X02Ao
 uIkxDhnFKsuZNzjnDX1PMoiMv9bbVijrgBjq46koYMun/hGT+Qandv0pZHpex5cjznEWNcJonEk
 vszbvnn/plhYH/5kQPyv1ybyFJYJIg6Jtc0pCL8h8tdgpFflRfbmiLlPs5My0AhUNiuIQrDwQ3n
 VXpwh47g9AspdE5NF6HwtgrhwgakjJrm5f2ai3uLMmgr91MtDIbcE4huRWHqhAWrIA9BVFrwbm9
 V02F9Dopwe4NH2Y5SRWnMHdyNTlbhtOKS+bdCni+F7wrUx3N4z+7x7GMf8uAjxg9l3GwXgvemYN
 h0P/2xUzTvSlKVsiE5eStWlQYh6COMrx9FVt4AHecqRdYVwlv/gWcTPhDTOWLxfxyb6ThoxGYbd
 xpK3Ls2q0ipDWy8j6Y7/Z0jdsDq/AOySXSj9s5+OdUlE31HQpQxywBIuQ1OHppqiZ0UkR5EOqVO
 e+MXxra60j10eIvVBEQ==
X-Proofpoint-GUID: 3IE2hpTod1CoVeevBC04zhG8eWNhqhUr
X-Proofpoint-ORIG-GUID: 3IE2hpTod1CoVeevBC04zhG8eWNhqhUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300222
X-Rspamd-Queue-Id: 9D2004A83CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35727-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[toke.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Wed, 15 Apr 2026 22:23:43 +0000, Tristan Madani wrote:
> ath_tx_edma_tasklet() accesses sc->tx.txq[ts.qid] where ts.qid is a
> 4-bit hardware field (0-15), but the txq array only has
> ATH9K_NUM_TX_QUEUES (10) entries. A qid >= 10 causes an OOB array
> access.
> 
> Add a bounds check on ts.qid before using it as an array index.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath9k: fix OOB access from firmware tx status queue ID
      commit: 7ce2f118a2389e8f0a64068c6fe7cc7d40639be0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


