Return-Path: <linux-wireless+bounces-36084-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A7JAvPI/Gn1TgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36084-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 19:16:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF34ECC5C
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 19:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6944E30173B1
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3960044E045;
	Thu,  7 May 2026 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VsUJF8He";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZy5lKev"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C352E1F02
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174189; cv=none; b=cF96zuXRJP+pZhK+13uUPKKYTpkh5I/EYmKpSf+MWBJkDvdWAaOpd8ucUW94RO5pENXRfG+uWo2hpI7oAwQ8Souu3dsXig/ylUdbk5zOid+2oXNBnUd3Y9M1+pqNFX/rH7zrciejuWtAeuYODxLFT5IweGsGl36p/1t/xVUnv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174189; c=relaxed/simple;
	bh=xTyy4gSY6e6aHySUCe9bWY0UaJYUeu6ewzygCc9pYMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=If3+xx8l4RdE7HwF7BQ2+eDt+8YherOn0uNhpvcrpLCXLxL4eyJvk6vx+5WBPLjmzpCXzTIln8yJYCfV8Rb6MzJJAXjTvjFDUCG1DKOVWkAdaXGLzq0ir518CYHQ9ko4WvcW0t+vm56tY1WgEkGhHL/aX+y78pkkCwyxt1Fk8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VsUJF8He; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZy5lKev; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647G05Zk1669796
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 17:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o/E3vkj4sKo
	mbz3XMhhkSzI/FiNo4lvJUm35/NFL1zY=; b=VsUJF8HejAoGMjniz6jg/oJBmPC
	qlYKiJ/TabpsEV0fdw4FMX5xSLV+ACj9287LemaZnRiTMVpqDruMJw4N/CWW8Rac
	vPIFqBYlbf7EJslEa2IM9vk7R/V+VnSWTq/EAvxY/NevirK3COPmtkkhTHwAposn
	bJ93GER2Kwtja0bhFZlymd1L9/74QM7ucBZ8dLK5MhjfsuldSuryWsdqwr19yLgE
	0lx1v/2LWxuRcSw1HhrXxGNee+iz0LipiWmq5rc2ucM/Atx/9D5qX+k5qBz/z4lh
	FNGBK3yROQZqVDzEilTfn9OT6tMftlMJU/VdiAZrMJLa1GHBtso38z6gVSA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1p357b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 17:16:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3651991d0bcso2237350a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778174186; x=1778778986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/E3vkj4sKombz3XMhhkSzI/FiNo4lvJUm35/NFL1zY=;
        b=aZy5lKev1n/MnVLtsI3kD/JgpOms3BvjY3EsOTYZpy9w0NLce/dWMiFoCVGdxq8Adu
         ZM3GOSToAuvuK022Z+5Ek4bXJca7szJYVkqb4b8BnDGo6I2GVb24+sXBP63tOMhOyfn7
         JlUwwEMfUvLsf4d59BSks3rHJnTImBmUdWJAHA2xnucVwK8s1OojXeyHnvfVv1DR1PGy
         3w52uPwpuUahdyPiVjkcQy5MEzmgO4vPSbnxmMT1DlpFJBhCFliFhq0jpIzsCk3A5q+1
         prhaVRM0miEI9Z24JFKLEgIDM3j111q2E4COZb04B20D01PZweotVok/FYzAJWr3F948
         46Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778174186; x=1778778986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o/E3vkj4sKombz3XMhhkSzI/FiNo4lvJUm35/NFL1zY=;
        b=U2C2O14cH7WxuQB/jRrDhGBfBIT7z4U3FZc2uuO1+JQ3v0n+SK9s+ibX5yQenPPVuG
         rCItby8kTvEivfPCbFZ7uvXtfiGG5gLTtJISZHLSFJ3VN+6vR39ba9qjsETwTgHuDmvK
         ZO5i32jJRDhPnUoRPPXsstQqBBmEKDRAaeOKmhPzpCmNOncKdm9IrUmmoylCeuMyrVIF
         zSlaPX+G8hPxrrNRzYdqCYdtMkylmdz0YPggV9jxWqBLcxQifRac1E1Mb7szv1AK/WG0
         ftBbPx13YxIojjFUrd0n2kQU3ztMs3u6lTExLFhh3FWsy/H88vSkrUfyCfdciI9/hujI
         nZdw==
X-Gm-Message-State: AOJu0Yw9JlN32B9BvqHQwCrmaOYG51mxXJ8iK87ccPBLhleDakWO7Zx6
	W7SLtjRjx49MoLiDDefDa3VbHGZvQHP4u54W36sAiTkPCtfxAtmbz6kI/5JSbqd2fJGY+fj8M89
	GTm0pu38V1Bjxlv1jP2Thi7ggz23mVferecW4/388+cwAzk2MZ556HkOgeVydXXAa5w9SOg==
X-Gm-Gg: AeBDievbpY9HJXzL6FZ3ebdXbepJXU+Xq5DjflL65XJvbuZLuhBwQo1IoemRxXMrzN/
	e0SYH5fFp+n4ZiNBpkF/JLBnBFgKnvjMoL2MzYS7iJaUYfMGa25JN16IXmPQ0fe5o+1d4mO7bNA
	C6i7lg/Fl8xJmRjlZTQZ/wHsZ5hNqhNLxPU+xV9bsOjP/hdZaXU3Mpilxd3g9bxqthTdrxcj0KM
	gDAPpQg+wK5y/7MMcLSOk2Fbsh/wy7gDNV+2Bo9gnoTW1an+xNt2WZ7ZWZ+SxfJzVVfwKVSFGDk
	2K4FGGZ5VNru8wY0vtcEDz7vKqkBd7aBlyM2Hrf5yUXafDwkYo98kiXLZNZzgTZgCNcVEH+Oa5e
	+ZlgahEpOrwriB0v5qOAVhWv1a5Vf9r+lB36DS6FxkO1yBA==
X-Received: by 2002:a05:6a20:7292:b0:3a3:2329:201e with SMTP id adf61e73a8af0-3aa5abc82bcmr10292955637.47.1778174186233;
        Thu, 07 May 2026 10:16:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:7292:b0:3a3:2329:201e with SMTP id adf61e73a8af0-3aa5abc82bcmr10292919637.47.1778174185685;
        Thu, 07 May 2026 10:16:25 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82640f7838sm121457a12.32.2026.05.07.10.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:16:25 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 1/4] wifi: nl80211/cfg80211: rename probe_client to probe_peer
Date: Thu,  7 May 2026 22:46:00 +0530
Message-Id: <20260507171603.1007812-2-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507171603.1007812-1-pritiwa@qti.qualcomm.com>
References: <20260507171603.1007812-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3NCBTYWx0ZWRfX70Ew5J6oJlRO
 UreKoqbbIsrqfgeeBK6fGXXyvx+fF7LsSlGxvCD04Z8NZS8ToIaWCamGhlmboHN2CFnx+4vNreA
 lseJv6SYi/F3t1UIQT3unpidiQkTiPgSqkm2yw/1Pkes71srumKYXwBSjIvKLVh6okL/Dg2SWbO
 9nAqK4wwQQPtz3Dw/1YNJOYCgaG4vYSzdzMnLbx1S+ww8rnQMalzKz9J9sbCovudiOxT3QjLEwb
 CPzmUkaUBFG2Xuons3Ew/FM51xc4wgTwyUCvKV8RCxDb0RkHTSZxoRoq68McoJvJ1NQmtefSsD7
 wUG3EZz7YslLZIZ/F/WZj9I6yL+9w4MdCYA04NTrBfncP3kUx2Y+9kF17lOtRNdJp0iByjcGPEf
 McEX5MZMob3VriPWoVUbgmJbxBhDCsB1WILLCcfQfI7Q9knklL5RPNvhoL6M7x5Pqwl6n+0G50T
 MZlOd0bwngN6ercTCWA==
X-Proofpoint-GUID: -gPSrf6vFJ8tbXIRPFXTR9teTPNk05WS
X-Proofpoint-ORIG-GUID: -gPSrf6vFJ8tbXIRPFXTR9teTPNk05WS
X-Authority-Analysis: v=2.4 cv=K4IS2SWI c=1 sm=1 tr=0 ts=69fcc8eb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=-20k2WVAGv-XVeWyH4IA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070174
X-Rspamd-Queue-Id: 72AF34ECC5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36084-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qti.qualcomm.com:mid];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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


