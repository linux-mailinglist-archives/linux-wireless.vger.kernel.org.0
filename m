Return-Path: <linux-wireless+bounces-35461-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFHaBs558GnMTwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35461-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:11:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF447481008
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B34F30193B1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2D33E2757;
	Tue, 28 Apr 2026 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lLKiZQaR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OfDbxXM8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C33DA5C1
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367387; cv=none; b=pH8hhTr5llj614fMoV87ILv9ITpdvjD8pnxdj2DuhtdSTbI9QWV6jFp80Of679qIhWw8DEuZdSPN6JH2puowmvMu1BgA7yNDGSj12k4hYCvxj8mvMVo6yewcpkEfnhMuJpqWkX2fAZcN8XDxYBg+CwV/Gg44A54wjCgvsrKes7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367387; c=relaxed/simple;
	bh=IVcQveFo/+C7+9PXf1f7giV28/65EdkwTMjykEvG2Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIi5wruGOFww6KcDV8GUm5M/fqcXj9mRATwNV65xJObR4IP5N+Jxi6ZkUY2mODgt8/uy2+MnwVpn16965BQvrCHIc5YLqu5ZD97i5ovSCHU4t9Z1sckC4E6SJPurzvioCUlz8uwmRJKKfvzuekDOllMNB0XB3HXyekQrf0U678I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lLKiZQaR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OfDbxXM8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6H5BJ241590
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zxEQ/EO7rlT
	Pxo1i+SbmJxdLwycebixcJwdXcuBHwmg=; b=lLKiZQaRVBuRy4mrPtOqYuJ2tCM
	4kCundDhGC7sFnWhExdMOtkmj3Cjgu+NQu0OFVRJUOTCs8BFINf/mfQ0WTeFw7Br
	C7VlrAuvUhHykGPzcETmDBJjbjNQwviJu+2qqzK/hHia4oqRBqudEvpHMQtnICBY
	9+Tdz59gJlgYaYuurT6v68lgtXdUDpAtPrR5tdOmZZiOjTQcuWqZOnwMcQ3Cki3b
	qk+7fxTB9X9f+H/uRYdvIBf8A4sJ4AhXHrHq8nEzVKuaidOcqdIqOX2g4nYlwMKx
	h42CETr07z5U3/aWBzKzQIEp2xywEeqKdeFgcPrUX8WInfUdg1PXGve+vqA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt946uy07-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35d9278587bso13415182a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777367384; x=1777972184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxEQ/EO7rlTPxo1i+SbmJxdLwycebixcJwdXcuBHwmg=;
        b=OfDbxXM8o8p+F7sUDcEtAPAY45tS3QI0TqZsaqmTRY7MBLpB3PCUaIC1WLnDKPAlGl
         4VHYafH3Mj+6Zh0O8jy6GaeAg+dzB9Bc74HCBy9zMIixlrgqWhIL5lopShXNORacTbZR
         uXUD4ymVxeUW9KsaRkYp0pgkZqitnJcwvfroyaHEEhj8TbaoyxpF4JYPrM6pGOTlLiZk
         sg9xrqmhvFJYxMtIQPdpGEfR6WARJDXFdh11Aci+WSmmdaMhXO+izbvp+nFtZcr7bTZZ
         s1P8ZBptMtsANZXpJID2e/sLXZ3IwvJ3ScNtWe11TyexNTwkuCF2mK7Mtc9mUPG1ajeD
         bi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367384; x=1777972184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zxEQ/EO7rlTPxo1i+SbmJxdLwycebixcJwdXcuBHwmg=;
        b=UdKV5RqFppxVzN+gM1UG3bRhKsVYELoVkRyxUbXEgli11zduemP+DBU8wzrDNZAoNs
         fJiUYQE9GsZFnz2t1Oe0QbBC9IKSdfGLYwI5WOqdiHrOlsSM/4j67dtU7Nrx9qC7L9ZA
         5o8m1ikNBAyb8qLSIGAQjJ1ANdqry7/kUDIHANKCvEp40CC3JHgCphl8NiavHFM+PjkY
         LCOIC2rKCbDJx9onLtxi5ZqsVjkcusS8qjDxnzXTHEUEMDqCl5UPL4kxWCxj8FJEMvpa
         gbGTevzp8S+YxrDfEqPvfcdjlQ7bMB6jXh3SN0EwYDbNKVZ0mh7IQ34IWND8ThJm1aMj
         Lqpw==
X-Gm-Message-State: AOJu0YzjoEeg/VIvpX0QRdq6BJZyReHKzlg7VtgXuilLbb7ZTlv1u4sJ
	3XfmFC7K4jnTyyMbvjoRoW71MJuAopaDTyc2z2Kk65kwyfo5cs15NrcV7QPE4NhWnVp3Ca9mr6T
	s5xYtxNju1OH+W5XgSQlzgtjZ7vfYfiko0jZXUWx4MyfFKIEPdqGHXkaNmYm9xObNdVEimw==
X-Gm-Gg: AeBDietPWXtwig4TzKrc9wePOQRcIQ9kcGeHsz6pcJbnNaJyZ6WosvtLWYlve+dLQIG
	bvmsPYi7LzzXzJLBKPxduWdbKz6CVKQ8ecXeP/cZ3L/ki+SZbO+/7O8TkOd7cRaRM1bGBWN5pFv
	drZxk72H8m/F+gDXPuteHluI149y+PaZHo/XPYlpQo7vi+OUPyk6nr8yi6QuuA9BndcDBggq8Gs
	zQl6dMpBIXLLj98fMdwSsR9TpAFxfKLa4rs13Hdt8fhuz2dfLjYhAbGRAzZimr9xb7icG0txdsz
	hoCbaundt326YlrWIf99+YSSN95MvlrYopj1U/ziUfDdh1asIEbDku8nAfxghsVbZd2SgeHHGhL
	lxbo20hiTgP1qdcdmnCDCdSd6dgy2eZ6Lz2KMNxbepBVNB+U33BNBIbKw/OYdK8paRizph1ArAZ
	T6bZQxp9KvQm/+RJk0AYU7p2fnRVDWeeyalFU0lYFUWyvdhGQ2Yokm4Q==
X-Received: by 2002:a17:90b:35cc:b0:35f:be11:b3e0 with SMTP id 98e67ed59e1d1-36491f8a174mr2395821a91.2.1777367383934;
        Tue, 28 Apr 2026 02:09:43 -0700 (PDT)
X-Received: by 2002:a17:90b:35cc:b0:35f:be11:b3e0 with SMTP id 98e67ed59e1d1-36491f8a174mr2395795a91.2.1777367383296;
        Tue, 28 Apr 2026 02:09:43 -0700 (PDT)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc33d5a53sm1898177a12.22.2026.04.28.02.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:09:42 -0700 (PDT)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH wireless-next 2/2] wifi: cfg80211/mac80211: set only non-MLO-applicable fields for non-MLO stations
Date: Tue, 28 Apr 2026 14:39:19 +0530
Message-Id: <20260428090919.1798601-3-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428090919.1798601-1-sarika.sharma@oss.qualcomm.com>
References: <20260428090919.1798601-1-sarika.sharma@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YcWNIQRf c=1 sm=1 tr=0 ts=69f07958 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=J60kWbWlbidPyJ1VTsMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: J1Xwmyf0RS31VjMYvGyo4ijfRZhXgzy5
X-Proofpoint-ORIG-GUID: J1Xwmyf0RS31VjMYvGyo4ijfRZhXgzy5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MSBTYWx0ZWRfX5tV3AsVcAYRI
 CtNtiJjbOZI1ISug65EoyY0J/GvGvC2oazB+QBSWycnWZIP93i+LEckYoesYJgwnpGf8t+SqCDZ
 6zsYypPQBq++wDHD0kAFAD4dTJ7El3uvr74KkuV97edl0SP7mWotc56Lcj6t1iJ9hygJTEkMUvP
 xzphIh44a4w+fGwBCrnEHlBS8WvnhM+7yiSEqtc1iTaPdtE3R8y+7WTCksarxve5xjjE38hekyt
 G301saSRdd2dUh8iSNQMh7KQBvTo86PGjyjgeJHcd2mC4UEf083rA5pQwdg3roquLj3Zk4moHz6
 KoYUEYtFWJOIZD3irc4BDhstb1XfISs14GFD/0q79hyHFpae44QTpGauYZ2kapUFGEGqOFnkmCp
 fLUdxSCFnirRUoBt3xFwC8znBzLwAVoMGEwZEx9HUJK1quJcm06FjYtIdqQ+WfrXmrdQFIuJWsC
 36g6zoYNMs0RKWxtmyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280081
X-Rspamd-Queue-Id: BF447481008
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35461-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sarika.sharma@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
index 6c6fc7641a53..5307dc30595a 100644
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


