Return-Path: <linux-wireless+bounces-37466-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 52jmGbmxJWpaKgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37466-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 20:00:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F098165127D
	for <lists+linux-wireless@lfdr.de>; Sun, 07 Jun 2026 20:00:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NcbTQ+Sa;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Mf4KVNqn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37466-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37466-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87DF03006515
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jun 2026 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E43931F99D;
	Sun,  7 Jun 2026 17:59:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6831E850
	for <linux-wireless@vger.kernel.org>; Sun,  7 Jun 2026 17:59:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855194; cv=none; b=PQprcxTSGr9y9ScvL7BARRxzo75oi/axNlLD3t2zI5l+5VYjPqFMd1seABvSu8NuXuJXOw3pyYZQC0XULJTdhn58XH+XzFv5wenmI174iimpGxFdNOvXxyQ0DLAB0qGbAcxNZyin6OtPaxBDxsKWGetPmnP1LMAre32o2NO4O3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855194; c=relaxed/simple;
	bh=clxk/i+eCBrEkCFgCtUM7YmnY9STxcR/Pjt0/fiTSyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDAtwGac3McdZ6dmgp+krg1Mb+LrLi2aCmtizIzBBVdmq7FzL8GYoM8cmNojPLzcoOOKk8P/5R3nFcTlJO361cfdqHDO2ZSI42MfLiOVc76RtSDm4bhHJ5h9MXPpIy+u16tTNp+vwCoEoTWZM6v92fjrm0YsItmYxMYH7NCHucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NcbTQ+Sa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mf4KVNqn; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657El1lp827191
	for <linux-wireless@vger.kernel.org>; Sun, 7 Jun 2026 17:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ct1CqZkFlo4
	ls/P1k+jnl+NTfOBY2WJSj3L4dNVFpAk=; b=NcbTQ+SaOyihZ7EPEkYbUZfcAvN
	zCIYzyECqPQLREGBjhJNHdYHNg975fFIy5RInCNVq5Zv0wi2kLM8/fsNspUQmLkQ
	o+QHij+t2LJgCa1hTTvERyMrOjtzhuyk+KSbNBp95BWSXmMKdVA+6W3H5Ohq7TH0
	CSNh7IRFVfgiROCQO4xp2eJndXGF06nKpmLPwk5e+B5EvBiG4r1W/ECjZkJ4fo7Y
	TvL2+6qM/8Nh5pwna3tM2zNJRaUk+P+JZfIo5v8x2EB8mVgGPdTCuuT7/G9L/UIB
	+3vn+vk4/TPx8GdJPYnXMFUI5qOucPLgPMgNucfyQ22bJk/UJLu9r1Xf6QQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embx6cbvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 17:59:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36b982ec338so4238202a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780855187; x=1781459987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct1CqZkFlo4ls/P1k+jnl+NTfOBY2WJSj3L4dNVFpAk=;
        b=Mf4KVNqnzxagxQZ1n8pqAxt9HUw00skqZtPzdj5GiboiC/LC05mbVSvFPaBhK3O11Z
         IheZDtYqK57CGHXQwX7bYGnHY/kzsHK8VmtnCacK6N2iLgfhH5i6rLRAEVdB0cX59g78
         m0WR4LepnTtbMtLqv0dW0VfCh6WkpldAadqb3EUWwCWZuIadxF+VjjDTvlij7YoAivsQ
         ibL5hFUa1Dg7iSt76JOzlnPJ2FmZHZ5jmkcDjPolbhJEA3ssPHvaa6VTDMYxDui0GlHV
         Uch6lqanO9hS5ECq7myH6kGoIjTbwh+TFtCbZ0DVvg9cHqJFZwww3NBbRdW2izHp9ahz
         m9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780855187; x=1781459987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ct1CqZkFlo4ls/P1k+jnl+NTfOBY2WJSj3L4dNVFpAk=;
        b=YAP4Wt1Kr62nxq5t+DU8+2AuWWFcVAz9r3QJHiAhUTOA7IoQ65VlS+j6Y9FWxmd8Za
         RArQePCYheotfUfr5mofkuEdB/mt6uxNh/87UgZF/+BkyvoEJd7HLhlYOraGwLleKAYf
         CkGcgUbEOjnY7kquFCQBHiY4ikkUIryxMczTBhNgW4vqwkFwmfgZIJdFDtUh91pzyfUy
         o8vFz7O1zTrlTDRSP837bX5UlGj1i7iuAa3mRchsq8PS2IjYblgffCltrPbolQlnxycW
         eVQd2rLOaeOc80hUZ5MA8NXpzyfBVcByBuSPCeNJd6IQFbLghW1QxMhCic98aupV8/Rr
         pGUA==
X-Gm-Message-State: AOJu0Yy2CdspHrCM681SFvqM2Ke2C/fXbL7IqRV4unLHWc9lH7xz4Z7Z
	+Z/e/kM9IeBS/jtF8BBhN99cb5XQR6LqIJhPOWad5zgPKUGyP7kZJuKAbIGKHh0AU2Tz4Eha1/M
	i7HGUGMrGktpX9McAIQoWAqd5SF3vDOEaZvUJmSbZ121JSFBEjs/RzrXmvQBR2Wxdpo+RWg==
X-Gm-Gg: Acq92OFz20y8OidLBri+cCEH2/zTOea3GZxTMQk7zT0bH10qN5PMeR3FIMzZeaxTRKu
	VLaW0zBJCf23AS9SrSa5z3mnQknKLpR3mZUslLFZaF4MLN3itPnbBGKxq8Ho/c5Vf5cnv4FJQjE
	5vocm0fCEJ3ub/1kc5LVSh5WJ+mAXty4I25L526tvniN9VwiuAXC/Si9MkecdTfBDuvX2bpI0gT
	JmngT0mNqgfqYpTF17YypO1Fvq9Yd+VlFRFan4t/nZOkY4bR1A0U1NprbaZSgIoiNFfY6fcWYyE
	/fEV073TeMUwObQxZXJqOr49gneSXVDcrPQ2zWHMszBlcS831j1PpLqjxE37FLgsp9x3lveTv83
	/cbfxR8eYVRRAr7d5soggyZxDWVe7NryVM+QqKExWf4wJL81WmCpyqCwVBXJ9sLaZZMcZ/ikuUQ
	dutVU3XxjWoWq+hfruz3cfcGPgmNfuMleSwFBWFLNeKrp/AxX0zA==
X-Received: by 2002:a05:6300:67c7:b0:3a2:7ef4:81d9 with SMTP id adf61e73a8af0-3b4cd0a4451mr16314594637.44.1780855187294;
        Sun, 07 Jun 2026 10:59:47 -0700 (PDT)
X-Received: by 2002:a05:6300:67c7:b0:3a2:7ef4:81d9 with SMTP id adf61e73a8af0-3b4cd0a4451mr16314570637.44.1780855186780;
        Sun, 07 Jun 2026 10:59:46 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a624fsm13078522a12.18.2026.06.07.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:59:46 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        praneesh.p@oss.qualcomm.com
Subject: [PATCH wireless-next 1/5] wifi: cfg80211: Drop unused link stats handling in nl80211_send_station()
Date: Sun,  7 Jun 2026 23:29:08 +0530
Message-ID: <20260607175912.2266215-2-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a25b194 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=WxumSkjBCS4GX7jbcoYA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE4MCBTYWx0ZWRfX1AVW2j06QiWR
 nXg6I7ClxsH4HVW2PBFoHdpna+TrVQLkDkeW6aUG28qyzvSFUwnidN8L8jssKtOlbxv0WUJZ1JY
 x2LtCUPxhzrqxRV0b51Hr1mazwq5KdvD18ZCBxNWj1TzE5JP9iIaHdzuSjsq+3u/jv+rzaBij6F
 mJEQskhscJtRjqnQMmW3Dw6+xyQQdu2G5/cnKZYrVQpK4ab8JfU2RXkFMfaBuNAxmx0b0ETzqjL
 VpoUEDEd47HAv/hNHrOfW6i+rlRCw14Vxf7WCcEI3GDtQ66XYnWsHLaDSicc+MbSVOHM63eakjh
 X/VEEtAEAK5DpP6rhCfs3qjOCCVnanDDFi/ZsyEqXit2JEq8Oof1AIxN3geyRCOCQwXys6V05ap
 +zn4n7sH69FdzLJsybc7DPygzmMaMM+idIKha99sJS8rLy0+ODaWE3jMKLzjXLBM2LzOAAf/Ye2
 9TKi/02+MxVfoAD5Haw==
X-Proofpoint-GUID: NZ5cehYFmxuPCiybxZ2BAmUc6aM0WB_t
X-Proofpoint-ORIG-GUID: NZ5cehYFmxuPCiybxZ2BAmUc6aM0WB_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070180
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37466-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:praneesh.p@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F098165127D

Remove the link level statistics handling from
nl80211_send_station() and drop the unused link_stats parameter
from its signature and callers. The removed code iterated over
each MLO link and attempted to send link specific station data
through NL80211_ATTR_MLO_LINKS, but this logic was never used
because link_stats was always false.

This logic was introduced during early work on link level station
statistics with the intention of reporting information for each
link. Due to message size concerns when a station has multiple
links, the feature was disabled behind the link_stats flag and
remained unused.

The link level reporting block in nl80211_send_station() is dead
code and cannot support larger messages, so remove it. This
cleanup also prepares for proper link level statistics reporting
in nl80211_dump_station() in a later patch, where fragmentation
allows safe transmission of multi link data.

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 net/wireless/nl80211.c | 227 +----------------------------------------
 1 file changed, 5 insertions(+), 222 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 85057bd4d565..33609a065423 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7841,197 +7841,14 @@ static bool nl80211_put_signal(struct sk_buff *msg, u8 mask, s8 *signal,
 	return true;
 }
 
-static int nl80211_fill_link_station(struct sk_buff *msg,
-				     struct cfg80211_registered_device *rdev,
-				     struct link_station_info *link_sinfo)
-{
-	struct nlattr *bss_param, *link_sinfoattr;
-
-#define PUT_LINK_SINFO(attr, memb, type) do {				\
-	BUILD_BUG_ON(sizeof(type) == sizeof(u64));			\
-	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
-	    nla_put_ ## type(msg, NL80211_STA_INFO_ ## attr,		\
-			     link_sinfo->memb))				\
-		goto nla_put_failure;					\
-	} while (0)
-#define PUT_LINK_SINFO_U64(attr, memb) do {				\
-	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
-	    nla_put_u64_64bit(msg, NL80211_STA_INFO_ ## attr,		\
-			      link_sinfo->memb, NL80211_STA_INFO_PAD))	\
-		goto nla_put_failure;					\
-	} while (0)
-
-	link_sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
-	if (!link_sinfoattr)
-		goto nla_put_failure;
-
-	PUT_LINK_SINFO(INACTIVE_TIME, inactive_time, u32);
-
-	if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES) |
-			     BIT_ULL(NL80211_STA_INFO_RX_BYTES64)) &&
-	    nla_put_u32(msg, NL80211_STA_INFO_RX_BYTES,
-			(u32)link_sinfo->rx_bytes))
-		goto nla_put_failure;
-
-	if (link_sinfo->filled & (BIT_ULL(NL80211_STA_INFO_TX_BYTES) |
-			     BIT_ULL(NL80211_STA_INFO_TX_BYTES64)) &&
-	    nla_put_u32(msg, NL80211_STA_INFO_TX_BYTES,
-			(u32)link_sinfo->tx_bytes))
-		goto nla_put_failure;
-
-	PUT_LINK_SINFO_U64(RX_BYTES64, rx_bytes);
-	PUT_LINK_SINFO_U64(TX_BYTES64, tx_bytes);
-	PUT_LINK_SINFO_U64(RX_DURATION, rx_duration);
-	PUT_LINK_SINFO_U64(TX_DURATION, tx_duration);
-
-	if (wiphy_ext_feature_isset(&rdev->wiphy,
-				    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
-		PUT_LINK_SINFO(AIRTIME_WEIGHT, airtime_weight, u16);
-
-	switch (rdev->wiphy.signal_type) {
-	case CFG80211_SIGNAL_TYPE_MBM:
-		PUT_LINK_SINFO(SIGNAL, signal, u8);
-		PUT_LINK_SINFO(SIGNAL_AVG, signal_avg, u8);
-		break;
-	default:
-		break;
-	}
-	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) {
-		if (!nl80211_put_signal(msg, link_sinfo->chains,
-					link_sinfo->chain_signal,
-					NL80211_STA_INFO_CHAIN_SIGNAL))
-			goto nla_put_failure;
-	}
-	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)) {
-		if (!nl80211_put_signal(msg, link_sinfo->chains,
-					link_sinfo->chain_signal_avg,
-					NL80211_STA_INFO_CHAIN_SIGNAL_AVG))
-			goto nla_put_failure;
-	}
-	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) {
-		if (!nl80211_put_sta_rate(msg, &link_sinfo->txrate,
-					  NL80211_STA_INFO_TX_BITRATE))
-			goto nla_put_failure;
-	}
-	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_BITRATE)) {
-		if (!nl80211_put_sta_rate(msg, &link_sinfo->rxrate,
-					  NL80211_STA_INFO_RX_BITRATE))
-			goto nla_put_failure;
-	}
-
-	PUT_LINK_SINFO(RX_PACKETS, rx_packets, u32);
-	PUT_LINK_SINFO(TX_PACKETS, tx_packets, u32);
-	PUT_LINK_SINFO(TX_RETRIES, tx_retries, u32);
-	PUT_LINK_SINFO(TX_FAILED, tx_failed, u32);
-	PUT_LINK_SINFO(EXPECTED_THROUGHPUT, expected_throughput, u32);
-	PUT_LINK_SINFO(BEACON_LOSS, beacon_loss_count, u32);
-
-	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_BSS_PARAM)) {
-		bss_param = nla_nest_start_noflag(msg,
-						  NL80211_STA_INFO_BSS_PARAM);
-		if (!bss_param)
-			goto nla_put_failure;
-
-		if (((link_sinfo->bss_param.flags &
-		      BSS_PARAM_FLAGS_CTS_PROT) &&
-		     nla_put_flag(msg, NL80211_STA_BSS_PARAM_CTS_PROT)) ||
-		    ((link_sinfo->bss_param.flags &
-		      BSS_PARAM_FLAGS_SHORT_PREAMBLE) &&
-		     nla_put_flag(msg,
-				  NL80211_STA_BSS_PARAM_SHORT_PREAMBLE)) ||
-		    ((link_sinfo->bss_param.flags &
-		      BSS_PARAM_FLAGS_SHORT_SLOT_TIME) &&
-		     nla_put_flag(msg,
-				  NL80211_STA_BSS_PARAM_SHORT_SLOT_TIME)) ||
-		    nla_put_u8(msg, NL80211_STA_BSS_PARAM_DTIM_PERIOD,
-			       link_sinfo->bss_param.dtim_period) ||
-		    nla_put_u16(msg, NL80211_STA_BSS_PARAM_BEACON_INTERVAL,
-				link_sinfo->bss_param.beacon_interval))
-			goto nla_put_failure;
-
-		nla_nest_end(msg, bss_param);
-	}
-
-	PUT_LINK_SINFO_U64(RX_DROP_MISC, rx_dropped_misc);
-	PUT_LINK_SINFO_U64(BEACON_RX, rx_beacon);
-	PUT_LINK_SINFO(BEACON_SIGNAL_AVG, rx_beacon_signal_avg, u8);
-	PUT_LINK_SINFO(RX_MPDUS, rx_mpdu_count, u32);
-	PUT_LINK_SINFO(FCS_ERROR_COUNT, fcs_err_count, u32);
-	if (wiphy_ext_feature_isset(&rdev->wiphy,
-				    NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT)) {
-		PUT_LINK_SINFO(ACK_SIGNAL, ack_signal, u8);
-		PUT_LINK_SINFO(ACK_SIGNAL_AVG, avg_ack_signal, s8);
-	}
-
-#undef PUT_LINK_SINFO
-#undef PUT_LINK_SINFO_U64
-
-	if (link_sinfo->pertid) {
-		struct nlattr *tidsattr;
-		int tid;
-
-		tidsattr = nla_nest_start_noflag(msg,
-						 NL80211_STA_INFO_TID_STATS);
-		if (!tidsattr)
-			goto nla_put_failure;
-
-		for (tid = 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
-			struct cfg80211_tid_stats *tidstats;
-			struct nlattr *tidattr;
-
-			tidstats = &link_sinfo->pertid[tid];
-
-			if (!tidstats->filled)
-				continue;
-
-			tidattr = nla_nest_start_noflag(msg, tid + 1);
-			if (!tidattr)
-				goto nla_put_failure;
-
-#define PUT_TIDVAL_U64(attr, memb) do {					\
-	if (tidstats->filled & BIT(NL80211_TID_STATS_ ## attr) &&	\
-	    nla_put_u64_64bit(msg, NL80211_TID_STATS_ ## attr,		\
-			      tidstats->memb, NL80211_TID_STATS_PAD))	\
-		goto nla_put_failure;					\
-	} while (0)
-
-			PUT_TIDVAL_U64(RX_MSDU, rx_msdu);
-			PUT_TIDVAL_U64(TX_MSDU, tx_msdu);
-			PUT_TIDVAL_U64(TX_MSDU_RETRIES, tx_msdu_retries);
-			PUT_TIDVAL_U64(TX_MSDU_FAILED, tx_msdu_failed);
-
-#undef PUT_TIDVAL_U64
-			if ((tidstats->filled &
-			     BIT(NL80211_TID_STATS_TXQ_STATS)) &&
-			    !nl80211_put_txq_stats(msg, &tidstats->txq_stats,
-						   NL80211_TID_STATS_TXQ_STATS))
-				goto nla_put_failure;
-
-			nla_nest_end(msg, tidattr);
-		}
-
-		nla_nest_end(msg, tidsattr);
-	}
-
-	nla_nest_end(msg, link_sinfoattr);
-	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
-}
-
 static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 				u32 seq, int flags,
 				struct cfg80211_registered_device *rdev,
 				struct wireless_dev *wdev,
-				const u8 *mac_addr, struct station_info *sinfo,
-				bool link_stats)
+				const u8 *mac_addr, struct station_info *sinfo)
 {
 	void *hdr;
 	struct nlattr *sinfoattr, *bss_param;
-	struct link_station_info *link_sinfo;
-	struct nlattr *links, *link;
-	int link_id;
 
 	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr) {
@@ -8249,40 +8066,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 			goto nla_put_failure;
 	}
 
-	if (link_stats && sinfo->valid_links) {
-		links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
-		if (!links)
-			goto nla_put_failure;
-
-		for_each_valid_link(sinfo, link_id) {
-			link_sinfo = sinfo->links[link_id];
-
-			if (WARN_ON_ONCE(!link_sinfo))
-				continue;
-
-			if (!is_valid_ether_addr(link_sinfo->addr))
-				continue;
-
-			link = nla_nest_start(msg, link_id + 1);
-			if (!link)
-				goto nla_put_failure;
-
-			if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID,
-				       link_id))
-				goto nla_put_failure;
-
-			if (nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN,
-				    link_sinfo->addr))
-				goto nla_put_failure;
-
-			if (nl80211_fill_link_station(msg, rdev, link_sinfo))
-				goto nla_put_failure;
-
-			nla_nest_end(msg, link);
-		}
-		nla_nest_end(msg, links);
-	}
-
 	cfg80211_sinfo_release_content(sinfo);
 	genlmsg_end(msg, hdr);
 	return 0;
@@ -8540,7 +8323,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 				NETLINK_CB(cb->skb).portid,
 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
 				rdev, wdev, mac_addr,
-				&sinfo, false) < 0)
+				&sinfo) < 0)
 			goto out;
 
 		sta_idx++;
@@ -8604,7 +8387,7 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 
 	if (nl80211_send_station(msg, NL80211_CMD_NEW_STATION,
 				 info->snd_portid, info->snd_seq, 0,
-				 rdev, wdev, mac_addr, &sinfo, false) < 0) {
+				 rdev, wdev, mac_addr, &sinfo) < 0) {
 		nlmsg_free(msg);
 		return -ENOBUFS;
 	}
@@ -21626,7 +21409,7 @@ void cfg80211_new_sta(struct wireless_dev *wdev, const u8 *mac_addr,
 		return;
 
 	if (nl80211_send_station(msg, NL80211_CMD_NEW_STATION, 0, 0, 0,
-				 rdev, wdev, mac_addr, sinfo, false) < 0) {
+				 rdev, wdev, mac_addr, sinfo) < 0) {
 		nlmsg_free(msg);
 		return;
 	}
@@ -21656,7 +21439,7 @@ void cfg80211_del_sta_sinfo(struct wireless_dev *wdev, const u8 *mac_addr,
 	}
 
 	if (nl80211_send_station(msg, NL80211_CMD_DEL_STATION, 0, 0, 0,
-				 rdev, wdev, mac_addr, sinfo, false) < 0) {
+				 rdev, wdev, mac_addr, sinfo) < 0) {
 		nlmsg_free(msg);
 		return;
 	}
-- 
2.43.0


