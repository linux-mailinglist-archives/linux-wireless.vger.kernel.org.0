Return-Path: <linux-wireless+bounces-35681-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGLyGPnq8mltvgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35681-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:39:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F314949DA39
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E71963005748
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 05:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841911C28E;
	Thu, 30 Apr 2026 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PyEKx+bV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aDi2aKCb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991A369992
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777527511; cv=none; b=K0g4As+igHS2NIA3QQOUcFfhw3z18ABtDEVxiIWxv8epvkGA5pKh1hz5bFnt5itWaD04TqxxP6TfL0A3p519qCHE/1ufujo9Su/pCN8tsSPb3QbMl4cZbuin2ABh9njje6EULbg0qX1EXzCAAPbVgRRkJGPQYOJOQlSFcxgMVOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777527511; c=relaxed/simple;
	bh=xfn4aKLHn4tvS5pKUO90imHhbFYPzKoUQdKb9Rnkgdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PnOHoTDmPH0/5s5xktQaGeS4fmS/T3NoR8WOvK8kfRdeDVv7862a8c/ZKfutsi8kvNr/jUGHGiNHh/B1DxF/AzBrV7g8FpQpouTx1/XvsqO/i8padlcF4+Jvnp0kp1EDW75Uu1UeSYUVwLItdVmtiF7MzZXolvvdy1QuCLnqtik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PyEKx+bV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aDi2aKCb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNui483732413
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 05:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=w7zNnUezkDI
	6ZzHEX6DPkZmDwt9xVPpml0D+lBJA8Gk=; b=PyEKx+bVO5M0G98zLE9wl+Vc3jk
	IXCKAz7FiPfX5ilDvQvCyGLVQQsjbHjfOBrF68uFVF2/50TeUgpqhoD6XBRe+lGJ
	H1DVJ71fn8RFA5intfgNCQxgPkeXgmSD4wAb8bg1OHE8Yg7oMnUN1laptRCWjAqP
	5kvN+ExW1jvpWJo/EVKnSEaZ78mo4hE8fgqrqEv1BQfngxTues1iETRnSliYrO9w
	0lvKwR11VCRUVs9s9HacfmpFalDyGE8ch9J5GRbSv+Ur9Aqird75WUpcbEQGMBzv
	8B65b1RJFSZpkyD3GsXktHJmAMkDMeFQQe2uvBP7Bs3blWOJMzGUFTAEEeg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3x8ycs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 05:38:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35fbb57764aso1655234a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 22:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777527508; x=1778132308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7zNnUezkDI6ZzHEX6DPkZmDwt9xVPpml0D+lBJA8Gk=;
        b=aDi2aKCbuDakfAkQafMG0YRVf97mA0qWQiIII6BWg5Pctd1yrIeBxNbIlzlwbGHxCH
         fMGNO1qh0GyD6pwDk0DJa+AvPeLMNHQb+qDuI5q6G3EA45q2v/U7Z/8YUcL52e0MFrMY
         8MYbw3SLxWhq74WFy+lfGl+6yf1OEoz2anQAYJOWM/NRL1AZrogLIRxybxuoXtNtdwl/
         TAplv72JIs3yQrPGH8Up02J3Cf3vf5q78AnN3Q/Qjvn5koNcCFBtn19NW+V0Us50Yq9h
         TFmNGPbSoQrhpyzPQkXJeB/QRklwTHhyha4FB8yPt+ogrHhnLPYGSdFW0aX3fj1Zdp9S
         0Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777527508; x=1778132308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w7zNnUezkDI6ZzHEX6DPkZmDwt9xVPpml0D+lBJA8Gk=;
        b=r2WAr4HHgHeWVAH6gFG4h4c0UydvAxCX5Xm0iY0T+U577LS5GRagSzN2gLnnGGtKLd
         3YW8Id7U8qRaeu6mOBo1o5HVjsqTqSBI9OazOZ58vby2aJ1mxgk9AwYOAovNTxeFmLdD
         Cf16ztEUlKIcMYcAKGuBQXg7m6YSYEvD2wgxZzrN4S7wAHVAQSDgw95aifv5XCcAlowk
         AE4k1ja7g9ZYowCJo68NUtjYoHGOCCdq+3E0p5jSlk5kZUDGOeWbFoPepGpij5aavrCR
         zKP0qXVwgrOlLwwC46zLjEpG/CLpznS932t2ucDokf783E4uVMaIsF13GyY1q23/tHIj
         XQTw==
X-Gm-Message-State: AOJu0YzpYu6lBw44PL8Ee1lvppvhMfOCpqT6h73tQypcsFKKTYtf/DJ5
	xw8X26KBxE0OP183RgTeTdVGdG93uUzoTHvck/dlK4zSSQAW6cPVvPFrnjDykIPkYBcDi0GN0F9
	fP9REqntm6doRee0F3fWCOSJUahNlbbx/0wt7EjYuTbgkGyZ++l98mCasUXIUBVfNJLrs2w==
X-Gm-Gg: AeBDievP+uP7Y9szBjO508iuGaTfvpnsoSYrhl+0upLDEcZ7bKhfLdMBnzVpdbyQ5x1
	/ZL3nRV+EwiKKScx4rcWyfQissu29gDDfFvC6ttrGfYK2n8zHybUwd4acot2sGQkYqOC9yYDMQ3
	ZKxK/aPX9X7Z6H16ZJQDjG1s/sqQGK4DzmtYtjN54XgmfAte2jkCHSaHXNpVpbZSizSXMHsVLqq
	w09iV3+ky+6evv4V3/XEUtNAOIptS9mOmKeZed8nix0E7+/ZTCLWcJ7nuZZPyHvNwaUaeRKUi6c
	ZKJK+2kKoclSySByJ5M9oEcPv0LdAKgR7Q+FuWubPrS/Y9MaqaojYBvzpgeJzFRJX7HgWECdLB0
	BOQQucz6m96ma3tyZHSr3uFYVL+wNLyQ6vKlvcUWXY9Mm5X5K9uEgyEw3/mxGoP2mO0Fb6f3XKp
	I1vA82ZxH0su51hF/8x0oyVDrjv7hOB70mJGaBhUESB1G7z3OZg6a/Vg==
X-Received: by 2002:a17:902:c406:b0:2b4:5e85:efc with SMTP id d9443c01a7336-2b9a4489f27mr11268385ad.18.1777527507737;
        Wed, 29 Apr 2026 22:38:27 -0700 (PDT)
X-Received: by 2002:a17:902:c406:b0:2b4:5e85:efc with SMTP id d9443c01a7336-2b9a4489f27mr11268165ad.18.1777527507264;
        Wed, 29 Apr 2026 22:38:27 -0700 (PDT)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm39561425ad.25.2026.04.29.22.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 22:38:26 -0700 (PDT)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 2/2] wifi: cfg80211/mac80211: set only non-MLO-applicable fields for non-MLO stations
Date: Thu, 30 Apr 2026 11:08:10 +0530
Message-Id: <20260430053810.2088793-3-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430053810.2088793-1-sarika.sharma@oss.qualcomm.com>
References: <20260430053810.2088793-1-sarika.sharma@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1MyBTYWx0ZWRfX3jyGBk26p4Du
 brNuXIepVpFkOkmt055nvP9Q8yGwD8xZQoBshoNXz4YiZx2cyEOeS/mXWu1p40VmG07sIM1PRmr
 YFThvB7UJIrfOqLBpXz4IsYwDUGkuonmKQeME7HGF/tgigL2A9MPyvDPrUZwcqqHSgwjJ0VZkC+
 R5dIRghYgiWQM+EfACYoQDN+4jlARjGwIXzDlKC4Vkj0aPMgbMJTx0PtIb0+sn1Bv0afdbK2ZQN
 7cSJGg3MIABEgNqoQQRj6CScMHzmuXdk5eeJs/3HZR800CwOkczgelggi1bB1iDM/6E5OHmhd2E
 JhwCHezaG9typOAUxI16jN9rsaS1NrsDGnz7rYNdk0KvivfPigLxr8FhykLDx01sOFI0jjgk5Ba
 +7lYhck9EbE8WBw9x+lpC1GuHA10eION17S7tSIHYyie8tIwSwI3ai0L5LBJJ7j2A44SkAhZI4W
 g5oD3InnDaIkAUf51uQ==
X-Authority-Analysis: v=2.4 cv=Oc2oyBTY c=1 sm=1 tr=0 ts=69f2ead4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=J60kWbWlbidPyJ1VTsMA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: n5UtdBxsl2CGBtunjhm8UobCojxLIPzU
X-Proofpoint-ORIG-GUID: n5UtdBxsl2CGBtunjhm8UobCojxLIPzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300053
X-Rspamd-Queue-Id: F314949DA39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35681-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sarika.sharma@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Currently, in sta_set_sinfo() during the NL80211_CMD_GET_STATION call,
mac80211 sets certain non-MLO applicable fields with default values
even for MLO stations. These fields are later cleared in cfg80211
before the data is sent to userspace, resulting in unnecessary operations.

Hence, avoid setting these fields for MLO stations to simplify the
code and eliminate redundant processing.

Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
---
 net/mac80211/sta_info.c | 49 +++++++++++++++++++++++------------------
 net/wireless/nl80211.c  |  6 -----
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index e6ed9375105c..981f3e0ecb17 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3150,27 +3150,6 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		}
 	}
 
-	/* for the average - if pcpu_rx_stats isn't set - rxstats must point to
-	 * the sta->rx_stats struct, so the check here is fine with and without
-	 * pcpu statistics
-	 */
-	if (last_rxstats->chains &&
-	    !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
-			       BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)))) {
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
-		if (!sta->deflink.pcpu_rx_stats)
-			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
-
-		sinfo->chains = last_rxstats->chains;
-
-		for (i = 0; i < ARRAY_SIZE(sinfo->chain_signal); i++) {
-			sinfo->chain_signal[i] =
-				last_rxstats->chain_signal_last[i];
-			sinfo->chain_signal_avg[i] =
-				-ewma_signal_read(&sta->deflink.rx_stats_avg.chain_signal[i]);
-		}
-	}
-
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
 	    !sta->sta.valid_links &&
 	    ieee80211_rate_valid(&sta->deflink.tx_stats.last_rate)) {
@@ -3278,6 +3257,34 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			sta_set_link_sinfo(sta, link_sinfo, link, tidstats);
 			sinfo->links[link_id] = link_sinfo;
 		}
+	} else {
+		/*
+		 * Set non-MLO applicable fields.
+		 * For the average: if pcpu_rx_stats isn't set, rxstats must
+		 * point to the sta->rx_stats struct, so the check here is fine
+		 * with and without per-CPU statistics.
+		 */
+		if (last_rxstats->chains &&
+		    !(sinfo->filled &
+		      (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL) |
+		       BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)))) {
+			sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
+			if (!sta->deflink.pcpu_rx_stats)
+				sinfo->filled |=
+					BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
+
+			sinfo->chains = last_rxstats->chains;
+
+			for (i = 0; i < ARRAY_SIZE(sinfo->chain_signal); i++) {
+				struct ewma_signal chain_signal =
+					sta->deflink.rx_stats_avg.chain_signal[i];
+				sinfo->chain_signal[i] =
+					last_rxstats->chain_signal_last[i];
+				sinfo->chain_signal_avg[i] =
+					-ewma_signal_read(&chain_signal);
+			}
+		}
 	}
 }
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 108583fb2cd2..2a62be4f574a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8182,12 +8182,6 @@ static void cfg80211_sta_set_mld_sinfo(struct station_info *sinfo)
 				BIT(NL80211_TID_STATS_TX_MSDU_FAILED);
 		}
 	}
-
-	/* Reset sinfo->filled bits to exclude fields which don't make
-	 * much sense at the MLO level.
-	 */
-	sinfo->filled &= ~BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
-	sinfo->filled &= ~BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
 }
 
 static int nl80211_dump_station(struct sk_buff *skb,
-- 
2.34.1


