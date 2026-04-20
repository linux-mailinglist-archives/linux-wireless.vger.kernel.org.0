Return-Path: <linux-wireless+bounces-35025-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMZaAInt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35025-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B4A428B00
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90EAB302F434
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405FA382372;
	Mon, 20 Apr 2026 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lzJP1fnO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FbXu0dWN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A13D38A739
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676182; cv=none; b=fYqeTWhRyKW0QmBDpngDy8IAz5QnRNCAze2ygh8oFz0FlGS+RFDnLucb3DmkJgg5B7UCYhMUlJYFl0m1Xauv2PSwtiOpEFHUG2MW/mkTnxwQIVlD8yRC1kcq5jc3ilMpbUWAEwc6PBQbya9IfVVkWDornlOpydyNru4FcHLub4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676182; c=relaxed/simple;
	bh=ojZ4ooJFyRLTNxtjmIo4ctwGoyfRzuFwd82kpLpE8DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0ORhB4Zy6kkL98bje9qVYyGFYgHMk+6DRa8g6rZwJkuUOwIiioN7gVU3dmr2E/obSxnd6HkU3Ztk4HgAmyj5KtTg0rwm/6ElmdbbW1dDS2ZrgM9Tg/OAWKJ5mzR6RqWREclVaU5b8CLo0rxms+gXJXVcVcXSWZ+ufhqGhrKQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lzJP1fnO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FbXu0dWN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K97SF6084514
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PMe+uJ7hQ1a
	sPcTwnjy//ExWvufM9mqoYiz12hYi5ps=; b=lzJP1fnOlJ3eJOpEuxxrVaJr2Wq
	nvo8cjYtUyOmygsjt6LFpbmr2o9sJ/4lDGlIPiZvvbg8veucslvVu748h2iixChr
	TbmuArHC2Bkdjotv+qJMKmiLiZvYLeQgAlcynU8dYvnsUJbKCZI7i7U4lKlgrS+o
	NjjOen44LeUtYaehL5eBqiwXwY27e3jVnAuAu+8EesaX47cJCwRt/nifErHggx3a
	EqQFXyoRgwyyRV5rT6Neqdm0wmrP4tPC//j4eRFOQJ0KUkAY5srir641/gYS7692
	7ujp0J0MLDh5YrIB97q3UBmJ/WDzjG+SFoWMJv27fszKsPfmMQO/j+XVhuw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh81g09u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354490889b6so4303899a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676175; x=1777280975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMe+uJ7hQ1asPcTwnjy//ExWvufM9mqoYiz12hYi5ps=;
        b=FbXu0dWN+MvACCvxqiTosiee01iDqlB5sRfV+gG4mcmdNsGnQApLHSXbcTa5uwzrcs
         Z/tTZwNrnhGho6cN9ZKFovLRZMf3CChYw4ycPS0g9BASFcLdbOBAfbEBES6iJLfWkdMO
         DLjAE1LHx+mwn8HqbpATiM5uP2a3kVnfGJINlJdJGfzahQ7Fcq0iwyNP+/+e056KkCFd
         8wCbwRCUNt/s9wlw5bEPopTK6sUnjEyJa7VKNcg7kHyHooT9V1K1NHS1/XxM6CwHCWf6
         qURZPSqHN6Jd/JVWWwxHTCXRc21SoFwRcJua0l/fLbapJp85kzlmPaCXUu15btPl5Rhx
         +BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676175; x=1777280975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PMe+uJ7hQ1asPcTwnjy//ExWvufM9mqoYiz12hYi5ps=;
        b=Eeja9E3OQjx5mpgMAepLboAIZxOhNDPw05N+O9M/mQbN9jbSTcSg0m13AEgWv0VWyJ
         Ce1ns0ak2y3wFQix4Q6bUZzj8l6hiIjBxpfiQw779mIlmPm51ZWmk6YXHoovbAGrjUJd
         oraBLa/DhQgzvN08652MsZr793r2jIlAaSqJrleKttVf2pvZv8P2PoXI6qW3Swr7lA1K
         qDVEyNdqs7bp2+iZhgoAkGTRUSByEPUOIyyKYWfkeHRo1WqLVgNfNZ47PsgaIrkb6AKM
         JBYRVkBlLibpqbGmgVi6/ZEhbdh8eLGtCg7BRTn7krS6iT1pCjfLgNIYaEAHDE0o4ek8
         Ikfg==
X-Gm-Message-State: AOJu0YzZlRxxkkg6/GqcKrd+HnmbKESW+xBSQxNs/j7E/b3+PPP58xQj
	7ulD2Ob7KUaZq12fZ2dfhyF7RvECysGl28F4kDgpp+NMq0iZ5DcmhqS6eb380SdGAFPKqoN4x8k
	u/ffGihKUs4AgxWZeVQpzd9qs3IwOUo5BsfZRfU39t5q8Wd23wAN+zjYhOf7VonpwnpJ+
X-Gm-Gg: AeBDieu6NFwnROUH8IQfW9NyEbLDTvN3l0PZKN48CzhmAAwHDpmdxi4JpP3OxlMxmwV
	1odNUhaY/kyNiZ6LVkPQ4qa9AhjAB+JX7JLpzYhdlYzYerZWMeNDeZBBuzQjL5Is8wGLeU8ngaY
	Gu0oYuYfSxAe9m8Ap7ohnUqUFaM4ZgtRZdsGKb89DWBJqcKKklCGMCl2FbSZuAVYLrfLeTnZV1w
	yIbxKqp9cJ5drBpcrdPIQSvwJ62vpmYDp0ewOrh/vnEQiK6tfeT9Gelo1kqe76Uek5IEOnqkOT1
	2bxr9bzq0xQxw/p1W4LcosmiXGCB+VsKSOblz/d2AHov8VWtO+uOw0HdNzIwIpGN7BWZJcKM36F
	1ItbXgt4LCNY0ZugyYfPPyK2IGZFRNfawXmI/9SugPEa0QVD33ZflymlHNZ0+443Txw==
X-Received: by 2002:a17:90b:35c6:b0:35e:5aa5:ae38 with SMTP id 98e67ed59e1d1-361403ebe7cmr11946086a91.9.1776676175165;
        Mon, 20 Apr 2026 02:09:35 -0700 (PDT)
X-Received: by 2002:a17:90b:35c6:b0:35e:5aa5:ae38 with SMTP id 98e67ed59e1d1-361403ebe7cmr11946046a91.9.1776676174656;
        Mon, 20 Apr 2026 02:09:34 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:34 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 01/13] wifi: cfg80211: restrict LMR feedback check to TB and non-TB ranging
Date: Mon, 20 Apr 2026 14:38:44 +0530
Message-Id: <20260420090856.2152905-2-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
References: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfX5GWDTKx39jml
 JWP9pHlcsWTFehAqjjzUHWO9S6BlzSx5jzlsNfthqSbiQMgkJ1ZNxf6s+YBP8QhMkZ4HcAIZVBR
 dvgaMYkDnU23jy8f7FJr3FzMyeA+2DNmajDjuDge6KElcqO+WpJ85Gb5AGan1nGJ3jU+natB+jW
 JR9hGNj4b0MPDHtuiNAW+fdjp9i6SpJl3szSXDqrzVjYOHOJeURr7jc5REz6jIJaPeM0ONdu4jF
 pr5+0YU7gvw2p8DifVaNfmTeu8+3p0scOemDxUFA9tUUPDabt4sbdbni+j/pQy//sm0R74pTNop
 X5xYZ67tLmnUMsgNHOLYiySBtaibGGNGrC1VHb+27lGmjTQQ2aXgxp52ogRW8Z2FLMQj34QBgvH
 GNEUkkly0+LWm3yEANoZosSGUlUQjrYDGfq5oNaaY9njdqT3Up6+xft1pkXWk41Vi6TLyiUAjW7
 XJ7dDRweAIzd4QxE3tA==
X-Proofpoint-GUID: NL8bbduK68aCUeembOUyHRVzs0PFmuNQ
X-Proofpoint-ORIG-GUID: NL8bbduK68aCUeembOUyHRVzs0PFmuNQ
X-Authority-Analysis: v=2.4 cv=PsKjqQM3 c=1 sm=1 tr=0 ts=69e5ed50 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=8X9NZW4galhvjpjBZbgA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200087
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35025-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 63B4A428B00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The lmr_feedback field is only applicable to TB and non-TB ranging.
Currently, pmsr_parse_ftm() enforces lmr_feedback for all RSTA
requests, incorrectly rejecting valid EDCA-based RSTA requests.

Fix this by limiting the lmr_feedback requirement to TB and non-TB
ranging only.

Fixes: 853800c746d3 ("wifi: nl80211/cfg80211: support operating as RSTA in PMSR FTM request")
Co-developed-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 net/wireless/pmsr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 4c8ea0583f94..afc0e3f931ec 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -195,7 +195,9 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EOPNOTSUPP;
 	}
 
-	if (out->ftm.rsta && !out->ftm.lmr_feedback) {
+	if (out->ftm.rsta &&
+	    (out->ftm.non_trigger_based || out->ftm.trigger_based) &&
+	    !out->ftm.lmr_feedback) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
 				    "FTM: RSTA set without LMR feedback");
-- 
2.34.1


