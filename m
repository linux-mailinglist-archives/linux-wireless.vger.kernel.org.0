Return-Path: <linux-wireless+bounces-35381-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFb6F2F972lKBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35381-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 17:14:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C065F474FB3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 17:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2712B30B59CF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE24326D45;
	Mon, 27 Apr 2026 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkDGBubw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zdfezzcw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1D3290C2
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302569; cv=none; b=SjUCG/fOOq1BYprTmJ9CgmOl0TzOtqBntk93ff2K0ghdHnWCo28b4bd97YehULwMqjKm+FWTdbWCAyV53YgzYwwEOSS0B3XtyS4SFCM0mbarpKUzmXhdVwItbRWgV1febsiGNh0KY7TRio2ImofGtd8a5XBR2PFNTBqAWcbHgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302569; c=relaxed/simple;
	bh=r6ldPMAbTatfCUG77LsccqfFr72bqJwEcbUZDgDiotk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c7VNA3ms6IrXzrcxOENOvUuT4DZ08QphtAqBBNGl7GO0AmKSZQWxkCN4R7D1sjvCOD0AFKrpNwHDzLBM6XJIZbODpDouLZ1eMch07NgGiaV66CDY00IBG7OANTW3vZ1A/ayGX9qC49bQWRmb8gco7HUaHseNdkkbE2BQt0Zjgy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CkDGBubw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zdfezzcw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RDxnsJ2913820
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 15:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ALUhCxJlMXv
	RO90UyYhoA35VkQzLf265Gc1x8MnaLyc=; b=CkDGBubwyYzVm5oaM4o5gu0Cpag
	LKO5ftMrDyU74brl2eziJcV6PnJnchKCZ3cVHbI0LMzAjv1B3bRouHjJxgamf+gK
	26w4RLXuJ9OxcpyEdNVHDBJb1EYWep6g8VPETam0+VTA5iqYUxwJSHdNCQfYm46H
	wdBYRygpxxNwvLGg1MZQ0ciAY9BdG0F38ShWEGvPh0VyCZa/Ul8Gi/11x6M1VkZ7
	0I+J3xD5aLGmepoT8db0g/YGojfq4dLcrVrXTybFD3u5XrCWNho7YzZWwIz72c1U
	p1vFbOSQxBCIBBG8D57Sd0CuNzvYDWtRI/XKXac2W7uD2As0iLXkVqc5nNQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xj1wm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 15:09:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fbaada0caso9450297a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 08:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777302563; x=1777907363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALUhCxJlMXvRO90UyYhoA35VkQzLf265Gc1x8MnaLyc=;
        b=Zdfezzcw8KfzVcjpe36wouanRnuGvnxN2FkwNHzOV28lHsHhzyp5Rn308ceJSdwFD8
         NVASuZdtd2SgjQPD5IXZZ/tkM2HQLmUbBR4U6pqqWVW9eXgwZeubBA7MSBPgDsMaJgP0
         Aj5vHaLfQauek6ctuzW5ZVpx5MTJfM/wcZN7eOMM4Pz/eFzAbLaqXCp8211dBg/B0uAJ
         LJIptsBf5gZXBj9iGfoHG0EGqkDGw2TILxmQz1Yk0AjKsKT6zSNMnR7kh7aVqgE091L9
         s10RqAtdAZ0c2wIRbO943bUCIcxC8WTQPevfQE4198kgvMVnLs5P/QBAVOQNlJ2HY6Iy
         pnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302563; x=1777907363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALUhCxJlMXvRO90UyYhoA35VkQzLf265Gc1x8MnaLyc=;
        b=snpjtE/4QJaxWo/FW49xbqTNBfmzCrBS2zyiidzd0QlNAFdIf5Ufo+gZB45UiMFVmt
         Zg3E/iy63p0LJnooAsv00322QeHixZY4WDdVSkxC17SptCDoj8+BwsnPa+6iMrjTwu1q
         1Q22Sinu63jMf+mRBqAvwB/uC19sB+LPwh1dRFWNIaVT4Jag/me8N0A8Tb2hmYzJWsKy
         4DkyPoTEIaTxpN4n1WFzb+ZFMghJhlOvEMg2KZIDvRBAo4k3nQZ6d95TJJI+zruNRXut
         jgLx5t427fm6OCie9aWMbdQoyFIlJfu6UxeuTpREMcZdEH4SHaTZdZdnyE3QufsrTmlk
         TDKQ==
X-Gm-Message-State: AOJu0YyfcUZmKUvgVJmFA90QntowRH4aF3ZFpaWPv6SA9YdH3UflL5qD
	npPuapaD7Igh10dQXsc8s/rh6nk2eEps6WRr43LSUYBtJa5A93zlt08q1L0Jpxl22xMPJpwL0cV
	ITo1rhMVk5QS70gG1oNkTzWWX+t8uc9hbU1w7cqYKUMU0KLDg6+2Os2b2dLsjIwwjzivptmIoAe
	ZyIw==
X-Gm-Gg: AeBDietjhOBQZ4OGpeEcnbri1cxoM85ymiTp9OAIkaLkhmTHbMZDka78IIIfsJojKkV
	ONHLJKNaxcVVzlYp9lUOFQN9CdFSn8IQ6SnPXW0AaUroHh3TmZTNmxSXbj50aLRNUvo4RP6Flpa
	r6BUT4dbFt0r4leYijJLtHTx9Gj0T6GiKSWZ9dQGco0Pfg0dX6jSNc6HlEzEAScVq71jCEwMBeh
	IxPopYr2DGW71NDrqT1C0sN0RvLaZwG0Gr2xNoT77xpu1W61hK6vmeXWCYLpnshzZ47XX7rYl6x
	psZ8Ljj7XkeGQnSIEUbmPGBhTM8TOHEWYf8sXvt270hdHtcx+mgV3X8X8f6W+zFY4D/VYrP8IXw
	3aodxWJOMFferGKAQEo1m99+XFX/uJ5sWFrW5i3ppfevwc7cag1uUah8sy55EQ6Fm
X-Received: by 2002:a17:90b:38c9:b0:35b:97ba:acee with SMTP id 98e67ed59e1d1-36140465451mr43422195a91.17.1777302562483;
        Mon, 27 Apr 2026 08:09:22 -0700 (PDT)
X-Received: by 2002:a17:90b:38c9:b0:35b:97ba:acee with SMTP id 98e67ed59e1d1-36140465451mr43422154a91.17.1777302561785;
        Mon, 27 Apr 2026 08:09:21 -0700 (PDT)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm31471363a91.3.2026.04.27.08.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:09:21 -0700 (PDT)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next 2/2] wifi: cfg80211/mac80211: extend cfg80211_rx_assoc_resp_data() for assoc encryption
Date: Mon, 27 Apr 2026 20:37:35 +0530
Message-Id: <20260427150735.2391680-3-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427150735.2391680-1-kavita.kavita@oss.qualcomm.com>
References: <20260427150735.2391680-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1D-eyLuql_spzYdw17GEMQYXy158RZe0
X-Proofpoint-ORIG-GUID: 1D-eyLuql_spzYdw17GEMQYXy158RZe0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE2MSBTYWx0ZWRfX5xGIvICgVJpz
 2kTE24AYY2V122iMAncvuQNyeI1CZ4ugXh4X1HtGCeh3ypsNtoN9KPLM3eDDNL2HMzWv+WLoYym
 tG4NTwHnzBIthYTNPme1XnTvUfY4f1sWn2qm2XcO/smINQ1TNYQ55fJh9RZpxlgKvYEjjXRI8Mj
 9M2MLLP4tppsl7n0I/4qQsPYQoEfFqVoRFkncy3LA5kqIgxkblMbvTRLW2v+/bdnsfoOJLB7nqh
 dt45IG4AelKBQ+4I653QMEcixeIhzlZIzsg+7A5o77S0AhaH7fo1eRn0UokgbILDbBi7BwocfzQ
 /psrYTvLiUwQihVcsqHiyjlpvCt6GMT5YLXmOtDLwLQHz0RmZUzTNHKCm4lSF9PY8mS7cgsHO6F
 abl7WJJvOe36Rki0q/b3zKsKvDy6H4ay/yULeBXJD4VN8PMEOw7O/xRLxtcHOvs/+bbWtnLe5jq
 L0nUWOay/Nb9Q0c3nlQ==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69ef7c24 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=pzXnb4g1INWh3phNis4A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270161
X-Rspamd-Queue-Id: C065F474FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35381-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

Extend cfg80211_rx_assoc_resp_data with a new assoc_encrypted field to
indicate if the (re)association exchange is encrypted.

Currently, when epp_peer flag is set, unprotected (Re)Association
Request/Response frames are dropped. This ensures that by the time
the (Re)Association Response is processed, the entire association
exchange is encrypted over the air.

Set assoc_encrypted in cfg80211_rx_assoc_resp_data based on epp_peer
flag when processing the (Re)Association Response.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/net/cfg80211.h | 2 ++
 net/mac80211/mlme.c    | 9 +++++++++
 net/wireless/mlme.c    | 1 +
 3 files changed, 12 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b29fcb4e1a4b..f728f565f7e4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8302,6 +8302,7 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
  *	as the AC bitmap in the QoS info field
  * @req_ies: information elements from the (Re)Association Request frame
  * @req_ies_len: length of req_ies data
+ * @assoc_encrypted: indicate if the (re)association exchange is encrypted.
  * @ap_mld_addr: AP MLD address (in case of MLO)
  * @links: per-link information indexed by link ID, use links[0] for
  *	non-MLO connections
@@ -8316,6 +8317,7 @@ struct cfg80211_rx_assoc_resp_data {
 	const u8 *req_ies;
 	size_t req_ies_len;
 	int uapsd_queues;
+	bool assoc_encrypted;
 	const u8 *ap_mld_addr;
 	struct {
 		u8 addr[ETH_ALEN] __aligned(2);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 160ae65a5c64..3fd98e55d337 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6658,6 +6658,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		.type = le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_TYPE,
 	};
 	struct ieee802_11_elems *elems;
+	struct sta_info *sta;
 	int ac;
 	const u8 *elem_start;
 	unsigned int elem_len;
@@ -6853,6 +6854,14 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		resp.ap_mld_addr = ap_mld_addr;
 	}
 
+	/*
+	 * If epp_peer set, unprotected (Re)Association Request/Response frames
+	 * are dropped, which ensures that the (re)association exchange is
+	 * encrypted over the air.
+	 */
+	sta = sta_info_get_bss(sdata, sdata->vif.cfg.ap_addr);
+	resp.assoc_encrypted = sta && sta->sta.epp_peer;
+
 	ieee80211_destroy_assoc_data(sdata,
 				     status_code == WLAN_STATUS_SUCCESS ?
 					ASSOC_SUCCESS :
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index bd72317c4964..d196b5c086cc 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -38,6 +38,7 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 					u.assoc_resp.variable),
 		.status = le16_to_cpu(mgmt->u.assoc_resp.status_code),
 		.ap_mld_addr = data->ap_mld_addr,
+		.assoc_encrypted = data->assoc_encrypted,
 	};
 	unsigned int link_id;
 
-- 
2.34.1


