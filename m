Return-Path: <linux-wireless+bounces-37494-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6W1dHzaIJmoTYQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37494-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:15:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F266547CB
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:15:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mhkpDovf;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=d+x30k8f;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37494-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37494-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C153305273E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 09:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED63B27E2;
	Mon,  8 Jun 2026 09:07:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B353C22423A
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 09:07:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909677; cv=none; b=WiiTjB0Xkaz8qu6ya03zErSPdZnCWS8RKbovMxHWIMPA9uO3cHDeRhNwMRBDafSEKPWjDAG7PjFiAta3i/0X4VMn/MxmSLvGZf0cuzh1Do7it5izIfxpPwR9cDxOubvxFYFvw6P4fLk5bc4IYgy7JlPZCJetiIFCYZxEAwZOz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909677; c=relaxed/simple;
	bh=xTyy4gSY6e6aHySUCe9bWY0UaJYUeu6ewzygCc9pYMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vFZrJDbyGZaADU/P4d6Jq+fawYetTmXUOjHsWIMjbUWn9EaoAoE+88bSTZnALT18wcFwgDwkCAgejFM2D5MvfsWUI8cK34Lc+DNE0K/+1GtqJRBNP7xw9NKlkf4ccw+rNs07cWMQ+SrTY86f+5TBYkvmJYXeDOjF11LGkMzJDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mhkpDovf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d+x30k8f; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PjIW2733091
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 09:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o/E3vkj4sKo
	mbz3XMhhkSzI/FiNo4lvJUm35/NFL1zY=; b=mhkpDovfs7CC4iR3x7CZr2TLx66
	21MXhYUen2qLOKmNkEpjdp7V5Tyvagjy3ZQFEiqLyhZ8mChhD7pGBGQnyuF4ZRS0
	t+Wd4ENDoWyLedvQor9NohzYIqrCnf5DgzLKWfIuThDWOnmVEwFerZjx6RtQbcPk
	nbnzVeQDmmD6aGCbOs4FWVcrERUD+PSkX4ZI5jsYN5hDUEMkmSCZC8KLeN+VG1/r
	VbujlLGlRp9XAUejDkSwGR6TxyBQ2RbVSZ7iK047UTgzi+0qDz85orygEU+LHZ2b
	QCXdOVqfnreHjEIUJ+WUqxV9WNBKH6MnP+fqhOSJWfCZXnF8eo0eJvt7h1w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf73tt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 09:07:51 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-842692bf60aso6233962b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780909670; x=1781514470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/E3vkj4sKombz3XMhhkSzI/FiNo4lvJUm35/NFL1zY=;
        b=d+x30k8fAvWae8pWrzeYC/P5S+vN0vHcXKYZPEXTm88k31CA00sPOzX/IguBya3Wq8
         BILINwSnOFzBx8tgokphMqzVp2ToTceHEn1mJtnroUiwEahfk02UEoIsGUBsSOxT1Ugn
         Gqh6unLxXAr7bcT/lDao28OV9pwymJ36avr3QaixA6FRw5IdOnaJ9rtJUa1Mj4N8q1XB
         qK8rTrcdCjHkON1aw6GCX28TzwWdVUOKEGI/dVOWnWbt9vWfZUn4+u4lavtSAjOFgFmW
         uiHdfXnAkA8MgNJPaaVZ13e+ScjZyPT6dLUDKAi/gxAZWu+Ts9N4WShzVpozFn2g0rzr
         J7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780909670; x=1781514470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o/E3vkj4sKombz3XMhhkSzI/FiNo4lvJUm35/NFL1zY=;
        b=rkvk8XxHSf/7fTZIv/vyiw9G6zPVGnysDcidhplXo8BgcdSBqZnbLU+e8m9VqkU0qD
         jP+MZhLoHojomCmOxYKBA7I5+wi2si5Yj6LlHfmQtCxcncBPbRrGyyGL4Ce71u44Kabu
         +zyso740jpkZY2aZoB2836dtMCrWofqZrVrf+Ms+aXOVShB2WBIIkABUyEZJf0Xx4d9F
         8/i9yx7seN/BUP10txN5pCJtkQOFZTBRV3euHJdAoDLK+P77clgDNnlk4Lkj2Mo5yhnc
         LZUoql9UXYegGAu3gCwRCbk02/uFpaMt+8c+VquKk/8vspHUsD2zhUHZux3NJBPycKbU
         gu/A==
X-Gm-Message-State: AOJu0YxgxiX0ss9ArS9wyeROo9B7AIoHqcWAFGP4yBzkP9FSOmmsVXpG
	UygK9XLaYMixAMtkAo7tYiPLqKxPnN7SFFsTLg5O4/HaOLcWN4Rda/1cjWM6w+owbixME84oOSL
	1UYWMOtJ1gsTELqdmZY8m2qABZXnHBf5g2haUYr6GIZJsyaYqXLDa/vD0mCYuRIcbNaqNzg==
X-Gm-Gg: Acq92OFnk8xONGnPhngo84asl7BOFR4EsLf95OLiXkZsOyqTqNMdrTVh8GlAM4zlTPM
	IACkzxPHhegXe4giQl2nDwg4IeXVYqZ4+LNquHm8eKq+DBDt7NzrXcK31WztDLlkmNYYwwql0BJ
	mhPZVOe+zWH4vP3ahfbO+UJcL1BCQ7P7QWUz8bBCo53wB0pqxnSJ/A4nDfVCrcpqA+N3yC/v4aM
	tWOQswSho/MmrGBGuiPRlUWMl8FqlSMK7BFFrbPSXD03yoquvFwNPU9z8Q2+i2HW4VRG6AXnIFv
	mk8XROZWdExR3MbCqTr+OgXXNv4Rdokc+X//KPUNNZ9GjAUXA8wN/o75YKNa2mdZO9jjztrRW3e
	6bYIXBna2mPSQZY43i56M+OJGSQGsi5C3TFxfo/A+spyW7RF/xslVN+XE
X-Received: by 2002:a05:6a00:4288:b0:842:3a3b:d6e7 with SMTP id d2e1a72fcca58-842b0f56e09mr15323615b3a.23.1780909670178;
        Mon, 08 Jun 2026 02:07:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:4288:b0:842:3a3b:d6e7 with SMTP id d2e1a72fcca58-842b0f56e09mr15323594b3a.23.1780909669684;
        Mon, 08 Jun 2026 02:07:49 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282379db0sm16512603b3a.24.2026.06.08.02.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:07:49 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com,
        veerendranath.jakkam@oss.qualcomm.com
Subject: [PATCH wireless-next v4 1/4] wifi: nl80211/cfg80211: rename probe_client to probe_peer
Date: Mon,  8 Jun 2026 14:37:24 +0530
Message-Id: <20260608090727.2389161-2-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608090727.2389161-1-pritiwa@qti.qualcomm.com>
References: <20260608090727.2389161-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a268667 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=-20k2WVAGv-XVeWyH4IA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 8dyBAB0LLi6DJjfAMJHMy2pF0xsxy84k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX5Sc0lvqi4HF6
 CWzL7shKICT8Wl6OxhK6+4i5GWvH4yOY9azB074kM5Y/HFHctV3b1PnV6SYSBw/1RAx/71oVdTL
 6T0X7Ar/2oWPLVHai8uMX+CC2JN+gNK2fhFkpDaOtuUvFpJchBphlVl7XBSMS4hVJjKqbYeCQMQ
 fKHT9OeNs/JFYkHU7lvKyvRtJ35g8vZAowul2ie3zMEsxus8gIBuTnjsv470Ki8zWOCzBCa1LU9
 i2ygpuMx1OggnSGUewTHN4qKLBAc6LcjMhy16vFB51RsXmnVC7yWvCn/WqtlWzdoyKfH3BrULoA
 s1DfrgLq06LcmUvfHZJbkE96sLXjR1thZrQJNZJb09YdoJl95lIstcGHmXfMqy8DSrGS93navUq
 sFILIvBId2YigIGYfNUOYeAwgD8D0DLI8gsgeX8+p3eMXjXPRi1qnUkH91oUOuFRUJKZ1WtiYA0
 2ue92lCvxz6qQq+J6mA==
X-Proofpoint-GUID: 8dyBAB0LLi6DJjfAMJHMy2pF0xsxy84k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37494-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,m:veerendranath.jakkam@oss.qualcomm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: E7F266547CB

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
index ddcf559430dd..7f30588ff52a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5076,7 +5076,7 @@ struct mgmt_frame_regs {
  * @tdls_mgmt: Transmit a TDLS management frame.
  * @tdls_oper: Perform a high-level TDLS operation (e.g. TDLS link setup).
  *
- * @probe_client: probe an associated client, must return a cookie that it
+ * @probe_peer: probe an associated client, must return a cookie that it
  *	later passes to cfg80211_probe_status().
  *
  * @set_noack_map: Set the NoAck Map for the TIDs.
@@ -5478,8 +5478,8 @@ struct cfg80211_ops {
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
index 0b1291ff7a2c..f948b1331e3e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4915,8 +4915,8 @@ static int ieee80211_set_rekey_data(struct wiphy *wiphy,
 	return 0;
 }
 
-static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
-				  const u8 *peer, u64 *cookie)
+static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
+				const u8 *peer, u64 *cookie)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
@@ -6026,7 +6026,7 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.tdls_mgmt = ieee80211_tdls_mgmt,
 	.tdls_channel_switch = ieee80211_tdls_channel_switch,
 	.tdls_cancel_channel_switch = ieee80211_tdls_cancel_channel_switch,
-	.probe_client = ieee80211_probe_client,
+	.probe_peer = ieee80211_probe_peer,
 	.set_noack_map = ieee80211_set_noack_map,
 #ifdef CONFIG_PM
 	.set_wakeup = ieee80211_set_wakeup,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index cd72f187a606..5d51dc8c09a2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2432,7 +2432,7 @@ static int nl80211_add_commands_unsplit(struct cfg80211_registered_device *rdev,
 	}
 	if (rdev->wiphy.max_sched_scan_reqs)
 		CMD(sched_scan_start, START_SCHED_SCAN);
-	CMD(probe_client, PROBE_CLIENT);
+	CMD(probe_peer, PROBE_PEER);
 	CMD(set_noack_map, SET_NOACK_MAP);
 	if (rdev->wiphy.flags & WIPHY_FLAG_REPORTS_OBSS) {
 		i++;
@@ -16114,8 +16114,7 @@ static int nl80211_register_unexpected_frame(struct sk_buff *skb,
 	return 0;
 }
 
-static int nl80211_probe_client(struct sk_buff *skb,
-				struct genl_info *info)
+static int nl80211_probe_peer(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
@@ -16133,7 +16132,7 @@ static int nl80211_probe_client(struct sk_buff *skb,
 	if (!info->attrs[NL80211_ATTR_MAC])
 		return -EINVAL;
 
-	if (!rdev->ops->probe_client)
+	if (!rdev->ops->probe_peer)
 		return -EOPNOTSUPP;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -16141,7 +16140,7 @@ static int nl80211_probe_client(struct sk_buff *skb,
 		return -ENOMEM;
 
 	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-			     NL80211_CMD_PROBE_CLIENT);
+			     NL80211_CMD_PROBE_PEER);
 	if (!hdr) {
 		err = -ENOBUFS;
 		goto free_msg;
@@ -16149,7 +16148,7 @@ static int nl80211_probe_client(struct sk_buff *skb,
 
 	addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
-	err = rdev_probe_client(rdev, dev, addr, &cookie);
+	err = rdev_probe_peer(rdev, dev, addr, &cookie);
 	if (err)
 		goto free_msg;
 
@@ -19997,9 +19996,9 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -22567,7 +22566,7 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
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


