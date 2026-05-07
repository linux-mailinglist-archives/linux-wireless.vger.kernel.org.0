Return-Path: <linux-wireless+bounces-36086-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G3qJwDJ/Gn1TgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36086-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 19:16:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A37134ECC77
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 19:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EE54300FC13
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C9E402B90;
	Thu,  7 May 2026 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nsxSMUpt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jBisSUu5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F51451052
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174193; cv=none; b=nQoUNDgBU8eSB495lSXLG/3qOeheNunci3AIuJGpvZV9+/joFj+w27jtG94J8T5xgccjUJYatVL3E+PFqJ3TV0yLZ1K60IXR5dOgw1JB6dkM2NpkRPYTUOib/7u1TYICFlG962Kt6H0B5vcnUih1a8R4H24L/m5xdCnVXs9Auh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174193; c=relaxed/simple;
	bh=moiR7aKigAP6s17MRwya58GvqPPeYcU17v21rOwq7T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KcFeRmxYXMIgvGGPeWNoLyc6CLXAYHcpT6uZfRuZlRfSGt8nxiXeN3+8Zgx1PjkFioZAek1lY0klxecbuD+agLKXU/kpc3YcaTSR/oTIcvw80OxrJ2t9LBWKcyBYhh+jef3RUKoHhQEy44Yxzh0RpdkYueXXpGA7ulLiFCFkBuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nsxSMUpt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jBisSUu5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647F0c2Y260344
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 17:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ee2i7x37m57
	69einrRLQHrp6zsFBc1qHyScA40hFpw4=; b=nsxSMUptaMJB/175PulK/RNMAe7
	Xi4sCPqWp1pfqTcwd2a6Uz97Pr6YW5VoPLKD0tEFGaaJZ24eYeyKFyjXX8RWm6JS
	Z7Zv/EJm1QIps6R3Rs/0hRYRVGrnIr6cqzf9n9k07GkjuD3LUTakFPj0u8uQQzcm
	ovRJBYKElgS21JfKpbnuHPiqe0m02xauqoStnnQbfhuPVvM8y9DXYEe5rSQpOlXI
	CbpeLQ4F5WfUsqRdiFVyulFMbNwfNkpPaP/9Cw5l0ukFwHkF7t4dTYrxfcxMKx/g
	l4uYjkP+QKwOpWmso3K/mEWdZud5jqtqxKSqov0vmNQ6wHtBzLR5f67Cyrw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hr8ubsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 17:16:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-365ff2ab7beso1301691a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778174190; x=1778778990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee2i7x37m5769einrRLQHrp6zsFBc1qHyScA40hFpw4=;
        b=jBisSUu5WK9jZv8vwr7wjmHIdq2ZfG/o1wDILnaJz0bngJUJnejHjSRWg6jPim0G2X
         k0p3Dhi//6knCJehfz0HG5tl+6wEKrFe9+m+IJAf9gR+nDpK4rIf7Y3rBey93iqy1FDX
         lNRi/sAu1U8VZUeU6kCqGvwrqa2TRV3OPnjLIg2dPF3sPQ1tSGpyQ+mcLsoiaiukXES9
         mV1K0V1d8rDItMiir3FxQrB4B2z9jtKGV7mILTYs3pUUS4O+51VXxoUGwusDsVASh3C8
         5uR+ObbEHnUCWsC/L2tjuzILng0Igv76OWApEj4WbpIzz+fWzP3TMKJDohiLUOew/Pvh
         Q3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778174190; x=1778778990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ee2i7x37m5769einrRLQHrp6zsFBc1qHyScA40hFpw4=;
        b=WD0Ytdu+prYBWfZDXz/EOYk8e29EHjM9+VopE/SWnxqlB7j/MlJo9Th7q8QxENmwgx
         9BIqIC8UKlTxUMtcm/p2ajB+g9F/02d/M8EUJwvk4w+3DGnFcSareRVeGQPtAH1eHnf+
         c710Qka0A+xjKO23Zy2S2vOYXhvG+Yqdrk7rf2aof/NylqO582vwui0NmG9p1Yw3AnEs
         4CqJj6cIGER8x6aiU33/4wBTcrxUeRjA+/Oak1uDmrO+pnaAk9T9m8iRlFdjum8IEMSH
         GcykjSAUMGKF+3wvucw/5SuJoT9+3jcLUPVQXnBT8f/+bjhAqxuCVj5o2LizpuOXfnfC
         W8Ww==
X-Gm-Message-State: AOJu0YzY14JCYsLXU+ZQdT7L22wpklgMqsSilLTEk4Zh3KBVKd67BAps
	/+RTtr5ems32rXTXoLm6M2627I2z+AvMvO4SMFRI9AxkoGvc9u2qBGXKhNKufnIwbnoNiC5m7ns
	fJLhECTU2nPB2H8RIjVmcwfiAfAZeucL6b4gX1bsxb4fyVZOK97BoDXBjrSMpk+qzeQLMdw==
X-Gm-Gg: Acq92OHyEpT85j00kI2XjiKNEJbVRVI7kHe1lYynO3gChQnn5yhlFiYzOZDPeCprpJJ
	I7tkUZRRa66UYdOrdH5/nFjc3azT+MPrQkkUYOTlQ41ytbEEGO0r+9SC3bPDPL0P7fIwzcTenWu
	fRAVr+rjUIKi+e4TUl3TPMR3tKXmU/buCNdHvzZ0AzhICbWj6sZQL6Pv7/8mLjzASKTqcbDzeKs
	+laSi7gN8nwSzDAIztwIhYRwrbj/E+8z1p+gmK0FpzBsGEsDQ3OLJ45fQkli/8btFFmEwP/HaBF
	PiCxuietWfs36/U8gXRPRd0OLfqBeIU5YRdOqEJ/HzCcfdDMefiyaC3rx5USyiS8FB4lvumuZ2r
	+VYiPF7HUARACdiaEh/liPTfYN7tslISyrUX0LspYXqA7VgNsze//iySC
X-Received: by 2002:a17:90a:db4e:b0:366:421a:2350 with SMTP id 98e67ed59e1d1-366421a24a4mr273781a91.9.1778174190432;
        Thu, 07 May 2026 10:16:30 -0700 (PDT)
X-Received: by 2002:a17:90a:db4e:b0:366:421a:2350 with SMTP id 98e67ed59e1d1-366421a24a4mr273764a91.9.1778174189846;
        Thu, 07 May 2026 10:16:29 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82640f7838sm121457a12.32.2026.05.07.10.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:16:29 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 3/4] wifi: mac80211: implement STA-mode peer probing
Date: Thu,  7 May 2026 22:46:02 +0530
Message-Id: <20260507171603.1007812-4-pritiwa@qti.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: YR4iROzlfdDZ8LC-ktCD46TLCqXQd1p-
X-Authority-Analysis: v=2.4 cv=caHiaHDM c=1 sm=1 tr=0 ts=69fcc8ef cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=1tVaBpimU39H8dQPe8UA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: YR4iROzlfdDZ8LC-ktCD46TLCqXQd1p-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3NCBTYWx0ZWRfX7EIvyGPdFtl3
 DIv0SV5wkMRM7BTK1WV/6IY2B8DrtD9+PIXqd30s7Jhm1mn34yjb3LE9ZLYaayygNSm9VsUviuc
 BbCf04873wFa8rnYBdCpohMakgpgHcBUKyl2OAPkKTBDSZGULcBv+Dtwne1gfsGGlRP+cex+DHO
 KLB/5fIzohM68rM7Y1FY2Pqx63RXBMfXWFvWs6aKaiGYZaoFOMF/4ruDqJhPGqXPyoo2Ke0jQae
 IzVXBp7Hmy4lTX1TbpIIAxuuSjTSazDp8i1hdq2Xe5R5BX9zcK3nup4lmVIIMYf7rKKx0S1zkOn
 wcKUzNIq0D0bM+I0bbHNvGsYscfJ4rdeHGBY7vj2gwLZRKKRyGQusZPrsdMcut3QMc2/ecgRUks
 2hPKeX/ZS1/RbhVlefDI24CQZgPWjiPZuwbLPChhp+1TDyTVvm4Drl4YNrZR+GXIF4S8xj12zut
 kVbonh/cBg1mHJp8cAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070174
X-Rspamd-Queue-Id: A37134ECC77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36086-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qti.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Add STA/P2P-client support to ieee80211_probe_peer(): when called
for a station interface, send a null-data frame (TODS) to the
associated AP and report the ACK via cfg80211_probe_status().

For MLO connections the driver/firmware selects the link
(IEEE80211_LINK_UNSPECIFIED); for non-MLO the single link is used.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 include/net/mac80211.h |   2 +-
 net/mac80211/cfg.c     | 151 +++++++++++++++++++++++------------------
 net/mac80211/status.c  |   5 +-
 3 files changed, 89 insertions(+), 69 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4fb579805e0f..6df439ef9807 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1396,7 +1396,7 @@ struct ieee80211_tx_info {
 			u8 pad;
 			u16 tx_time;
 			u8 flags;
-			u8 pad2;
+			u8 link_valid:1, link_id:4;
 			void *status_driver_data[16 / sizeof(void *)];
 		} status;
 		struct {
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f948b1331e3e..55fe50629a98 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4922,101 +4922,122 @@ static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_qos_hdr *nullfunc;
 	struct sk_buff *skb;
-	int size = sizeof(*nullfunc);
 	__le16 fc;
-	bool qos;
+	bool qos, fromds;
+	struct ieee80211_bss_conf *conf;
 	struct ieee80211_tx_info *info;
 	struct sta_info *sta;
 	struct ieee80211_chanctx_conf *chanctx_conf;
-	struct ieee80211_bss_conf *conf;
 	enum nl80211_band band;
-	u8 link_id;
+	const u8 *peer_addr;
+	const u8 *src_addr;
+	int link_id;
+	int size;
 	int ret;
 
 	/* the lock is needed to assign the cookie later */
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	rcu_read_lock();
-	sta = sta_info_get_bss(sdata, peer);
-	if (!sta) {
-		ret = -ENOLINK;
-		goto unlock;
-	}
-
-	qos = sta->sta.wme;
+	guard(rcu)();
 
-	if (ieee80211_vif_is_mld(&sdata->vif)) {
-		if (sta->sta.mlo) {
-			link_id = IEEE80211_LINK_UNSPECIFIED;
-		} else {
-			/*
-			 * For non-MLO clients connected to an AP MLD, band
-			 * information is not used; instead, sta->deflink is
-			 * used to send packets.
-			 */
-			link_id = sta->deflink.link_id;
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		sta = sta_info_get_bss(sdata, peer);
+		if (!sta)
+			return -ENOLINK;
 
-			conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+		qos = sta->sta.wme;
+		peer_addr = sta->sta.addr;
 
-			if (unlikely(!conf)) {
-				ret = -ENOLINK;
-				goto unlock;
+		if (ieee80211_vif_is_mld(&sdata->vif)) {
+			if (sta->sta.mlo) {
+				link_id = IEEE80211_LINK_UNSPECIFIED;
+				src_addr = sdata->vif.addr;
+			} else {
+				/*
+				 * For non-MLO clients connected to an AP MLD,
+				 * use the link address for the client's link.
+				 */
+				link_id = sta->deflink.link_id;
+				conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+				if (unlikely(!conf))
+					return -ENOLINK;
+				src_addr = conf->addr;
 			}
+			/* MLD transmissions must not rely on the band */
+			band = 0;
+		} else {
+			chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+			if (WARN_ON(!chanctx_conf))
+				return -EINVAL;
+			band = chanctx_conf->def.chan->band;
+			link_id = 0;
+			src_addr = sdata->vif.addr;
 		}
-		/* MLD transmissions must not rely on the band */
-		band = 0;
-	} else {
-		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
-		if (WARN_ON(!chanctx_conf)) {
-			ret = -EINVAL;
-			goto unlock;
+		fromds = true;
+		break;
+
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		if (ieee80211_vif_is_mld(&sdata->vif)) {
+			link_id = IEEE80211_LINK_UNSPECIFIED;
+			peer_addr = sdata->vif.cfg.ap_addr;
+			src_addr = sdata->vif.addr;
+			band = 0;
+			sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+		} else {
+			link_id = 0;
+			conf = rcu_dereference(sdata->vif.link_conf[0]);
+			if (!conf)
+				return -ENOLINK;
+			band = conf->chanreq.oper.chan->band;
+			peer_addr = conf->bssid;
+			src_addr = conf->addr;
+			sta = sta_info_get_bss(sdata, peer_addr);
 		}
-		band = chanctx_conf->def.chan->band;
-		link_id = 0;
+		qos = sta ? sta->sta.wme : false;
+		fromds = false;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
 	}
 
-	if (qos) {
-		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
-				 IEEE80211_STYPE_QOS_NULLFUNC |
-				 IEEE80211_FCTL_FROMDS);
-	} else {
+	size = sizeof(*nullfunc);
+	fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
+			 (qos ? IEEE80211_STYPE_QOS_NULLFUNC
+			      : IEEE80211_STYPE_NULLFUNC) |
+			 (fromds ? IEEE80211_FCTL_FROMDS : IEEE80211_FCTL_TODS));
+	if (!qos)
 		size -= 2;
-		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
-				 IEEE80211_STYPE_NULLFUNC |
-				 IEEE80211_FCTL_FROMDS);
-	}
 
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom + size);
-	if (!skb) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!skb)
+		return -ENOMEM;
 
 	skb->dev = dev;
-
 	skb_reserve(skb, local->hw.extra_tx_headroom);
 
 	nullfunc = skb_put(skb, size);
+	memset(nullfunc, 0, size);
 	nullfunc->frame_control = fc;
-	nullfunc->duration_id = 0;
-	memcpy(nullfunc->addr1, sta->sta.addr, ETH_ALEN);
-	if (ieee80211_vif_is_mld(&sdata->vif) && !sta->sta.mlo) {
-		memcpy(nullfunc->addr2, conf->addr, ETH_ALEN);
-		memcpy(nullfunc->addr3, conf->addr, ETH_ALEN);
-	} else {
-		memcpy(nullfunc->addr2, sdata->vif.addr, ETH_ALEN);
-		memcpy(nullfunc->addr3, sdata->vif.addr, ETH_ALEN);
-	}
-	nullfunc->seq_ctrl = 0;
 
-	info = IEEE80211_SKB_CB(skb);
+	memcpy(nullfunc->addr1, peer_addr, ETH_ALEN);
+	memcpy(nullfunc->addr2, src_addr, ETH_ALEN);
+	memcpy(nullfunc->addr3, fromds ? src_addr : peer_addr, ETH_ALEN);
 
+	info = IEEE80211_SKB_CB(skb);
 	info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS |
 		       IEEE80211_TX_INTFL_NL80211_FRAME_TX;
 	info->band = band;
-
 	info->control.flags |= u32_encode_bits(link_id,
 					       IEEE80211_TX_CTRL_MLO_LINK);
+	if (link_id != IEEE80211_LINK_UNSPECIFIED) {
+		info->status.link_valid = 1;
+		info->status.link_id = link_id;
+	}
+
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 	skb->priority = 7;
 	if (qos)
@@ -5025,18 +5046,14 @@ static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
 	ret = ieee80211_attach_ack_skb(local, skb, cookie, GFP_ATOMIC);
 	if (ret) {
 		kfree_skb(skb);
-		goto unlock;
+		return ret;
 	}
 
 	local_bh_disable();
 	ieee80211_xmit(sdata, sta, skb);
 	local_bh_enable();
 
-	ret = 0;
-unlock:
-	rcu_read_unlock();
-
-	return ret;
+	return 0;
 }
 
 static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 1bb622d06acf..f80496445f94 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -655,7 +655,10 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 								GFP_ATOMIC);
 			else if (ieee80211_is_any_nullfunc(hdr->frame_control))
 				cfg80211_probe_status(sdata->dev, hdr->addr1,
-						      cookie, -1, acked,
+						      cookie,
+						      info->status.link_valid ?
+							info->status.link_id : -1,
+						      acked,
 						      info->status.ack_signal,
 						      is_valid_ack_signal,
 						      GFP_ATOMIC);
-- 
2.34.1


