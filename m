Return-Path: <linux-wireless+bounces-37654-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ufJmHEJUKmrsnQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37654-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:22:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5A066EFE0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:22:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PwPge9tw;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=H9WXh48Z;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37654-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37654-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6279F301A178
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 06:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9692BD58A;
	Thu, 11 Jun 2026 06:22:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1635E1B6
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158971; cv=none; b=aCrCK7xaaQHlVKSY8NWS2jw7wn5y+oMHY2y28kS+5Nq9HzF++VgSA/okpDl6hLUq6YF7jy8+sMrNHF7sErOPiOz+tbpX/XeotDMC5B5niK5i2B6glLgcVLefTgYkh3Mz6pL+xnncbhHrXqNAzblQalzlBuSpsHKywuyqb7kAMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158971; c=relaxed/simple;
	bh=y+lYDBINEOBJ3sMczPoMzY18eBg3PZaJzXSvcKB2/kU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSuODPnC0tABfCkCRVtP/BeVAsIXeO8Q0h/ZusB5OCow2ORoctdNOWepQQIQVlggl4LttdMh4ZfUfnrOWa0zOb75AI4+HGyZRf4z8GbPsyhU7mhJMK6o+SByYS05WhkUSc44kgFEGYMlIU4qk2FXdHdBcoOqCIFUSFC7HoDhXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PwPge9tw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H9WXh48Z; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GJQJ3761243
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=j22aAdfdP4E
	83OTdVaeCswQWY31M9ox5Imj1jzuV/Hk=; b=PwPge9twtyCUnQGGZkFyZmt305x
	F4IGXf/6V5l5M0GfkKqHx5/J5gK/oWmwimj/eCpapicngCkccRF5fNtCJ9NIcegu
	UUu3BolXqHmjXz1h7KODcFkOlP7O/3WZGfGmXVLO7RZMZQVhutDrqN2iZJzGgEr+
	E6yIPVO3rf7c35yON6jAdZIV+/6LRAMgRbB4E1xznRnWC3oHPC2Re6wXuG3jnYMz
	qz47ls5y+oOyN8mcWxq0gZFYvZIAEB6Okqw2xUnv5tw3XTCkum6FCLehiK2epF42
	YxmU47ANjRyE6PPfU2EETTcineDBdZTmvYZyjq30++5qDJVM9ELycSMO+Hg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sj123-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36b982ec27aso5587626a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 23:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781158967; x=1781763767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j22aAdfdP4E83OTdVaeCswQWY31M9ox5Imj1jzuV/Hk=;
        b=H9WXh48Zum7btZwSWktLPd32YkqJydr6rlXIWcCCaK2F99eRsiO0yUZTqau7vWkzvM
         kWlHAuLira4R8/fv3ymUbeN7SQRk+r0t2gm9V9ekJMx7tdPH1bIjh8Tt8/OfpPAu5ReI
         6q0AJGc6bclJe9J+Of51VX6YkWeS1ns0wU17ScM6SmTTJA1tU5RQ6d8RgFwdhW7YHl1S
         UsmahPBc+F3uXf3jQil3sMsEpoeTSj+4hLJGgF3np+0Kc0rStzV5sLxK86tJxSw/zPIb
         N+8EhWIuszuxDN3KEPEXR1JnS6zQfLGJjgLTbcGoTo018HPGK5v2MNwMS2UFv714qnDH
         Dc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781158967; x=1781763767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j22aAdfdP4E83OTdVaeCswQWY31M9ox5Imj1jzuV/Hk=;
        b=SbKQyOi2ncka4aJofRNbUROqIKIRhei7ujmoEkjbaQ76KLFtUrD88g7JGX7qjv1qkh
         ulB6UhzOwcd3G9HIhIVPX/3ytkex95JGr8j5jsa7nMVr3Bcrikv0Bhm0clqivYYsF5w1
         YXJhxx19rhVx5JXyu0bEZYe18JjTveBgvbLcgGxMXqZVlqcWSq6Z6gafhSVVT5GRYyFz
         FL8blBBJ9Q/bC7KpATBOeRT3UJhEKoxpRErHKMkcb2LZNjU0eIkQxZdOlQaI61sF9VUO
         fO3P9cJhvE/UB5aBwhZq/s9NMsV5UA8tpzn8uF3/AcbS2hqSF96S64popf5G58p2+YKk
         zHsA==
X-Forwarded-Encrypted: i=1; AFNElJ/DPUS1YPxmQZfPYlWnH63IRPk7QmDXfFLva/z/G0kzk1iFU1rB0kC8IutU/yYfL6j8esjVjpazTU+FFpXodw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKecUNgs9XRpV7Gas0V2yzZeN5FoI1ko6RQsFL8t54XAxCnwat
	3sjzuZmywSGKgx8Lf/nCDaiiLHhUS5WEZClfgaaEvNRMFzsFe6I8UloJHimmPdTKP2RX/CvxEON
	bhBpkAd41X/eylKtFrtGGIHDuUeAeqdYEOEvqRng33F68lJPmN5tLerhAahXb6tzT+Zf8McAoH8
	wTKg==
X-Gm-Gg: Acq92OHvIzP/7jFTYAz/9x4ZwRLvhWTXUjsAoadG1rhyC12wYJUp+n61r+/mfb0UaVh
	DXSv6ym0952TZqJoI3ouKiUFoVQtoiUFkDxsiz+cqTbWArpcRxmvP0HVSmjffOa1sKLDTjjmPDH
	1I1JqoWGo8DO04tL8nleqF5rDKCPd2ncbgRK78A94rz0IXAriPlK4B8M59x+lWS2F1wdpAq6rSZ
	itWcj8x2M+5BTsXQ6ooL1WjEFqis3Bn5NmFOXnfzQ2PdNYUGUp0uKsIm5ZnAdfiTuJnRKAPuYwP
	Yqx55Ut0aFzLGD8QF+cexLdxYXabH1l4iA2wT+yCMVe5CG9GqJz0yzjTgSFnVLIxM2o43ze7RoQ
	hE/Hbfjb8OI4X1urGX/UsL44tMbPXP3p7Qj2D1hM/sqXtMmpJcQ1HgBzV
X-Received: by 2002:a17:90b:5282:b0:36a:7c8f:1423 with SMTP id 98e67ed59e1d1-3779de5d80bmr1785708a91.9.1781158966968;
        Wed, 10 Jun 2026 23:22:46 -0700 (PDT)
X-Received: by 2002:a17:90b:5282:b0:36a:7c8f:1423 with SMTP id 98e67ed59e1d1-3779de5d80bmr1785688a91.9.1781158966473;
        Wed, 10 Jun 2026 23:22:46 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37752874fc3sm1247507a91.5.2026.06.10.23.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:22:45 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: veerendranath.jakkam@oss.qualcomm.com, linux-wireless@vger.kernel.org,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v5 1/4] wifi: nl80211/cfg80211: rename probe_client to probe_peer
Date: Thu, 11 Jun 2026 11:52:22 +0530
Message-Id: <20260611062225.2144241-2-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611062225.2144241-1-pritiwa@qti.qualcomm.com>
References: <20260611062225.2144241-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a2a5438 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=3AKIg_h3-sDWLFTCN7gA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: xr5hzQK-wtqxiKw2TyiyZt5aiXsfvw1u
X-Proofpoint-GUID: xr5hzQK-wtqxiKw2TyiyZt5aiXsfvw1u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MCBTYWx0ZWRfXyzO95kqIS8te
 kcOAktFmbnMBDIumDgG1EYGYF8y/f2WO6QNeHwQUCJ5dDN7pjx2WLJ6V4cvoatBd5YlZ9Hc7wYi
 8q+xucZrhCNpaQNGxNiC2rK63BFvM/n5uV8xMSKARmBHeoTeWmzETjxq3/r0fkgdylgcoUUjTS9
 JPAXRhFwst9uUhRiL52sMzO6lSixewvOIics+UwO2b/LnLgjVGtm2obVRgVMp7jHBwI8t7rp3IE
 4WSNHR17u0AyP81KtzqRSB5r53IoyoLsCq4Hk6yg4DlBgpRJduIP4xPKtEbQJkEyWXqmFK3lhbM
 9GCAES/zUok11mMHWc/b2I7phPN9QvMHsAVES8MTuiPJkDvcWToPmkd5Q9PpOezrPhqKcMreF8U
 wtGJi6YyKhXLJplJu+QfMlkzLDPeFjcZdRywyT8h1hOzL7LoAnopL5cqX43Z4IzrBcJ0H2EO3VP
 LxBkn3Pah/FPFAcXY4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MCBTYWx0ZWRfX2seo1uAlQU0J
 JVFdnjQsHnGzUYw8um9mMWQf1vJK9jLacXZGR6UDWrIOsKP4deV3Xh0IvLso+4oRiE1zy2S0Izl
 MmVtpPt8AJCv6dz17f9iaVVP00R8pws=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37654-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:veerendranath.jakkam@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E5A066EFE0

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Rename NL80211_CMD_PROBE_CLIENT to NL80211_CMD_PROBE_PEER in the UAPI
enum and retain NL80211_CMD_PROBE_CLIENT as a compatibility alias.

Rename the .probe_client cfg80211_ops callback to .probe_peer and
update all in-tree users (wil6210, mwifiex) and mac80211 so the
tree continues to build after this change.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c     |  8 ++++----
 drivers/net/wireless/marvell/mwifiex/cfg80211.c |  8 ++++----
 include/net/cfg80211.h                          |  6 +++---
 include/uapi/linux/nl80211.h                    |  5 +++--
 net/mac80211/cfg.c                              |  6 +++---
 net/wireless/nl80211.c                          | 17 ++++++++---------
 net/wireless/rdev-ops.h                         | 10 +++++-----
 net/wireless/trace.h                            |  2 +-
 8 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index d6ef92cfcbaf..a85ff2a4316b 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2379,9 +2379,9 @@ void wil_probe_client_flush(struct wil6210_vif *vif)
 	mutex_unlock(&vif->probe_client_mutex);
 }
 
-static int wil_cfg80211_probe_client(struct wiphy *wiphy,
-				     struct net_device *dev,
-				     const u8 *peer, u64 *cookie)
+static int wil_cfg80211_probe_peer(struct wiphy *wiphy,
+				   struct net_device *dev,
+				   const u8 *peer, u64 *cookie)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	struct wil6210_vif *vif = ndev_to_vif(dev);
@@ -2660,7 +2660,7 @@ static const struct cfg80211_ops wil_cfg80211_ops = {
 	.add_station = wil_cfg80211_add_station,
 	.del_station = wil_cfg80211_del_station,
 	.change_station = wil_cfg80211_change_station,
-	.probe_client = wil_cfg80211_probe_client,
+	.probe_peer = wil_cfg80211_probe_peer,
 	.change_bss = wil_cfg80211_change_bss,
 	/* P2P device */
 	.start_p2p_device = wil_cfg80211_start_p2p_device,
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index c9daf893472f..99d96088e364 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4558,9 +4558,9 @@ mwifiex_cfg80211_disassociate(struct wiphy *wiphy,
 }
 
 static int
-mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
-			      struct net_device *dev, const u8 *peer,
-			      u64 *cookie)
+mwifiex_cfg80211_probe_peer(struct wiphy *wiphy,
+			    struct net_device *dev, const u8 *peer,
+			    u64 *cookie)
 {
 	/* hostapd looks for NL80211_CMD_PROBE_CLIENT support; otherwise,
 	 * it requires monitor-mode support (which mwifiex doesn't support).
@@ -4726,7 +4726,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 		ops->disassoc = mwifiex_cfg80211_disassociate;
 		ops->disconnect = NULL;
 		ops->connect = NULL;
-		ops->probe_client = mwifiex_cfg80211_probe_client;
+		ops->probe_peer = mwifiex_cfg80211_probe_peer;
 	}
 	wiphy->max_scan_ssids = MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len = MWIFIEX_MAX_VSIE_LEN;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8188ad200de5..549b2214e833 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5086,7 +5086,7 @@ struct mgmt_frame_regs {
  * @tdls_mgmt: Transmit a TDLS management frame.
  * @tdls_oper: Perform a high-level TDLS operation (e.g. TDLS link setup).
  *
- * @probe_client: probe an associated client, must return a cookie that it
+ * @probe_peer: probe an associated client, must return a cookie that it
  *	later passes to cfg80211_probe_status().
  *
  * @set_noack_map: Set the NoAck Map for the TIDs.
@@ -5488,8 +5488,8 @@ struct cfg80211_ops {
 	int	(*tdls_oper)(struct wiphy *wiphy, struct net_device *dev,
 			     const u8 *peer, enum nl80211_tdls_operation oper);
 
-	int	(*probe_client)(struct wiphy *wiphy, struct net_device *dev,
-				const u8 *peer, u64 *cookie);
+	int	(*probe_peer)(struct wiphy *wiphy, struct net_device *dev,
+			      const u8 *peer, u64 *cookie);
 
 	int	(*set_noack_map)(struct wiphy *wiphy,
 				  struct net_device *dev,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9998f6c0a665..d1907dd12a80 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -922,7 +922,7 @@
  *	and wasn't already in a 4-addr VLAN. The event will be sent similarly
  *	to the %NL80211_CMD_UNEXPECTED_FRAME event, to the same listener.
  *
- * @NL80211_CMD_PROBE_CLIENT: Probe an associated station on an AP interface
+ * @NL80211_CMD_PROBE_PEER: Probe an associated station on an AP interface
  *	by sending a null data frame to it and reporting when the frame is
  *	acknowledged. This is used to allow timing out inactive clients. Uses
  *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_MAC. The command returns a
@@ -1558,7 +1558,7 @@ enum nl80211_commands {
 
 	NL80211_CMD_UNEXPECTED_FRAME,
 
-	NL80211_CMD_PROBE_CLIENT,
+	NL80211_CMD_PROBE_PEER,
 
 	NL80211_CMD_REGISTER_BEACONS,
 
@@ -1729,6 +1729,7 @@ enum nl80211_commands {
 #define NL80211_CMD_GET_MESH_PARAMS NL80211_CMD_GET_MESH_CONFIG
 #define NL80211_CMD_SET_MESH_PARAMS NL80211_CMD_SET_MESH_CONFIG
 #define NL80211_MESH_SETUP_VENDOR_PATH_SEL_IE NL80211_MESH_SETUP_IE
+#define NL80211_CMD_PROBE_CLIENT NL80211_CMD_PROBE_PEER
 
 /**
  * enum nl80211_attrs - nl80211 netlink attributes
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 3b58af59f7e4..9c311c8290f7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4949,8 +4949,8 @@ static int ieee80211_set_rekey_data(struct wiphy *wiphy,
 	return 0;
 }
 
-static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
-				  const u8 *peer, u64 *cookie)
+static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
+				const u8 *peer, u64 *cookie)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
@@ -6060,7 +6060,7 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.tdls_mgmt = ieee80211_tdls_mgmt,
 	.tdls_channel_switch = ieee80211_tdls_channel_switch,
 	.tdls_cancel_channel_switch = ieee80211_tdls_cancel_channel_switch,
-	.probe_client = ieee80211_probe_client,
+	.probe_peer = ieee80211_probe_peer,
 	.set_noack_map = ieee80211_set_noack_map,
 #ifdef CONFIG_PM
 	.set_wakeup = ieee80211_set_wakeup,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 85057bd4d565..29505f64591b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2444,7 +2444,7 @@ static int nl80211_add_commands_unsplit(struct cfg80211_registered_device *rdev,
 	}
 	if (rdev->wiphy.max_sched_scan_reqs)
 		CMD(sched_scan_start, START_SCHED_SCAN);
-	CMD(probe_client, PROBE_CLIENT);
+	CMD(probe_peer, PROBE_PEER);
 	CMD(set_noack_map, SET_NOACK_MAP);
 	if (rdev->wiphy.flags & WIPHY_FLAG_REPORTS_OBSS) {
 		i++;
@@ -16141,8 +16141,7 @@ static int nl80211_register_unexpected_frame(struct sk_buff *skb,
 	return 0;
 }
 
-static int nl80211_probe_client(struct sk_buff *skb,
-				struct genl_info *info)
+static int nl80211_probe_peer(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
@@ -16160,7 +16159,7 @@ static int nl80211_probe_client(struct sk_buff *skb,
 	if (!info->attrs[NL80211_ATTR_MAC])
 		return -EINVAL;
 
-	if (!rdev->ops->probe_client)
+	if (!rdev->ops->probe_peer)
 		return -EOPNOTSUPP;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -16168,7 +16167,7 @@ static int nl80211_probe_client(struct sk_buff *skb,
 		return -ENOMEM;
 
 	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-			     NL80211_CMD_PROBE_CLIENT);
+			     NL80211_CMD_PROBE_PEER);
 	if (!hdr) {
 		err = -ENOBUFS;
 		goto free_msg;
@@ -16176,7 +16175,7 @@ static int nl80211_probe_client(struct sk_buff *skb,
 
 	addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
-	err = rdev_probe_client(rdev, dev, addr, &cookie);
+	err = rdev_probe_peer(rdev, dev, addr, &cookie);
 	if (err)
 		goto free_msg;
 
@@ -20033,9 +20032,9 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
-		.cmd = NL80211_CMD_PROBE_CLIENT,
+		.cmd = NL80211_CMD_PROBE_PEER,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = nl80211_probe_client,
+		.doit = nl80211_probe_peer,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
@@ -22605,7 +22604,7 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
 	if (!msg)
 		return;
 
-	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_PROBE_CLIENT);
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_PROBE_PEER);
 	if (!hdr) {
 		nlmsg_free(msg);
 		return;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 63c26e8b1139..6c3bad8b2d6f 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -948,13 +948,13 @@ static inline int rdev_tdls_oper(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
-static inline int rdev_probe_client(struct cfg80211_registered_device *rdev,
-				    struct net_device *dev, const u8 *peer,
-				    u64 *cookie)
+static inline int rdev_probe_peer(struct cfg80211_registered_device *rdev,
+				  struct net_device *dev, const u8 *peer,
+				  u64 *cookie)
 {
 	int ret;
-	trace_rdev_probe_client(&rdev->wiphy, dev, peer);
-	ret = rdev->ops->probe_client(&rdev->wiphy, dev, peer, cookie);
+	trace_rdev_probe_peer(&rdev->wiphy, dev, peer);
+	ret = rdev->ops->probe_peer(&rdev->wiphy, dev, peer, cookie);
 	trace_rdev_return_int_cookie(&rdev->wiphy, ret, *cookie);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 94944f2a39a4..8c2a91b85c39 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2132,7 +2132,7 @@ DECLARE_EVENT_CLASS(rdev_pmksa,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid)
 );
 
-TRACE_EVENT(rdev_probe_client,
+TRACE_EVENT(rdev_probe_peer,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 const u8 *peer),
 	TP_ARGS(wiphy, netdev, peer),
-- 
2.34.1


