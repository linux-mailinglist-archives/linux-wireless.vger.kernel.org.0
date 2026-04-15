Return-Path: <linux-wireless+bounces-34760-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBJiOxlg32k0SQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34760-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:53:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6DF402F14
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E8F33068133
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE8033D6FD;
	Wed, 15 Apr 2026 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQ+5+/yz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OksiBrDJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4B33C1B7
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246216; cv=none; b=PUiTTTXKC5vAFrje4lSoyzK+MyvAYBJ/KKakEMrHhb2/aONawTKfCVEshVLAXyo8QpEz0BLNogjk3AoW3i3cQ3V60YAacLCSdk5eYnx3FDyYV8a+F6sL5Hx5sCttR6rNENYURxhE1sfoWnVDDgISVOX9Rmp3M61klMWeLR4nfRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246216; c=relaxed/simple;
	bh=Z8MjBuFSrHwDM8cTVbGacktpyzjVhrbHqBj9rQ2ehT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReASad7Cq935f/h5INB2kghGxLYeyFrJhQcO/KGQrCY8vIbTox5kTuVRNK4RmWatH1enpPju2xylYliyCca6jeYRiSVGrPcQ29Xhk4kRoWQe45ejeuOkus0pkfFTxFdFbPCziBN54lYKFHPK5Yfx0AWC6up+osMKOPed5bAecTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jQ+5+/yz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OksiBrDJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F7tSEu764265
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=37hRxVhXWiD
	mi2CQ1v6YambcwPASbq8QXXmiSg6bWzQ=; b=jQ+5+/yzDbqZJ7KI3RU2x3EOkJr
	2QlYI2DkSRHzglP4Jj45dvcmjBFp56weo3+bi6M5IHPNEuEoo/jd2fLLhhVwIcIM
	2Wjzhmsqlr6pHrH8hINx4UpfReG5hmXKp6vLEN1fG24vsEQ93h4d5NU1jaP20pow
	CRmyNROA2NmC4et5+EVP7d4GMZf3RNHMEsiPUK8jWcm2xbxTuuyT1WfGrol9fe1s
	ZuoK1yNNhzZI310N/1cY516c2TUYLjruZbV0oGm2LSvWeGMtEsWZRmtGbGdzmCXF
	1q1S3XHenPrHx1/GJr7KDvsvvz2tHVjzFUD3vlsn9rNnp6SEilE+T7QRtQw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj6q7req8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fbb57764aso3022211a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 02:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776246213; x=1776851013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37hRxVhXWiDmi2CQ1v6YambcwPASbq8QXXmiSg6bWzQ=;
        b=OksiBrDJsq/9MMLDO0/TIR1JnPD3Wtt1sdfhvYGWbwusMs4+CjG4izyxsxIitvuajh
         Ay7pyyRsZBmxP9KILPsV5Lj4QIR3OqJosbMEWBsGMXOMBdkT+dCcnNG1x61O9Df4PQqv
         Vou9c4VQ5kvCjgoq20XcQ7YmdGCH3gv6F6VADOVezDBbLNexxBm1qNp3yWhFL7bHUHd2
         c0FgIv8UacgWM30hkrkdLiYWohwVQ+/eGD3dhVQE8ujctQ6T3gGit7m4QEoc5pCX4i2x
         JRFkffWP5H3JUsvj+4r7x7m1HiH/xgXnWFsFr/XJa3qU0u8ERfqtzlw3o4wOPpUkQKPv
         oMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246213; x=1776851013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37hRxVhXWiDmi2CQ1v6YambcwPASbq8QXXmiSg6bWzQ=;
        b=ol7448KztgDnboiQBlWcpqahQI4PhEvqsOy8XhY7/NO935l73ZOfpTFo4Qk7AK6Sfs
         TWdEJlQm3BX1gpnIjz3oqe4Uxmt0bKqsEvH5sdJANYm9UPpbB50F8oJhsLvmdv+h5ejq
         hGc0UogvoSgpUQMuZlnZYuQi8N+ZvAoq4xJw3oQM8s8ogSmR+OUKRlymLKZkX6WUJgFt
         5qUvyZXSrGVzENS1eEkcv0WA3fyXsaOJWb8S+Ehf+aoN2CvKX/bHcO4+mafir7fEnQB9
         tYeWgasvu0ehtASnfvZrz6GaNNu5B5VfuHRViiA5IFPkzXtP09fQ1QPvrb/0cy8w7gfg
         lySQ==
X-Gm-Message-State: AOJu0YzKj0ZfoaNJgjZCC2QuYL9p9+lQh9lFb3w3M6dk82HQ6gFAH7dB
	qcOXSCwnNnH3RvoX46THyPJaVepgl2KbUclmWR9ArD5DPMUSb2z/02Raj/ERzejx0Ruyop+Ctj7
	QGqqVr88N3K6/Ef4gqjx8amfmugOcUYZofsFXOnoUtWXOg1c9Kllu7ouWUlaAsidR8SUzjejaRQ
	rDlg==
X-Gm-Gg: AeBDievzoKdzqBBxoGg2O5wwmvcxquGW9m5XKyk5RoTRmdKwaV2unIaLWtGWWhKwxJQ
	ffjkpLVBNjo754zXojQOFhVZXeSLb4otSRNiqoOcMMHzZiqDSQ3ndHGgc+7JimGHSELcy8J/6ls
	eQHzZqNP/1yYsauzJJsrYhJrhBIaSrP/FdqQaYdp3xIoVeCEyOvj1skmoZHGHdY9i7IxpqqAsNo
	ksMND7xnVdDP8LLvW2XmDqHE3/V1SwLp4ewZHnZ1lZFHtiPCSdlfuU7WktNHtgvLztFPegWOTx4
	qedS0PtBh7aAy+ADBuzVDb5nxGNLDVOtTM3XAwdrerYDJRFKEGSwcAlkoJkDphE3x0VmbjZrLOI
	laff8NxAVAcCHe6n4puIADA5YxdADQOFnHItIPe7dkFHZkCtoggaVKTNB
X-Received: by 2002:a17:90b:4c0e:b0:35f:b931:d1c0 with SMTP id 98e67ed59e1d1-35fb931d34emr8876701a91.6.1776246212892;
        Wed, 15 Apr 2026 02:43:32 -0700 (PDT)
X-Received: by 2002:a17:90b:4c0e:b0:35f:b931:d1c0 with SMTP id 98e67ed59e1d1-35fb931d34emr8876675a91.6.1776246212281;
        Wed, 15 Apr 2026 02:43:32 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd2101cf1sm2391200a91.15.2026.04.15.02.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:43:31 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v1 3/4] wifi: mac80211: add per-link PROBE_PEER support
Date: Wed, 15 Apr 2026 15:13:03 +0530
Message-Id: <20260415094304.1731390-4-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
References: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AvHeGu9P c=1 sm=1 tr=0 ts=69df5dc5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=hqI_VVWH-qVT6OI3f-kA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: TKUxMoSXYAd-phmBNg1BEuuD8Sx8-wo7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4OCBTYWx0ZWRfX0m3agsQjwr1E
 MNps6og+H1JV/8Lq+P7zlaUnhmkNkI2y3Dp+wyhW9rdPkPe74bnPDP7U/5iObcsqVLCvjHOtgtM
 iFTm1dY79lLaAauUzW6KhjnRevZqxKzPjaKTtUEub+mJ+ErB0b9Li5piBp4XUdPxlyigmU+HlF6
 qLH1EvahvwP0bMvmLyOGCm7A7VhvwzbLWQyDIt2FGAtG7uj41dl2sFJCbWqryxywP9mz5wLSmGk
 hW6dmn4U2LBmjVPPrgAYDg/mGNZ0F0yPDjFaNON2IfJGYtNJWewJh+E4xp0ETI4lJ+lWKqg3OxZ
 KzLFSl3CcBARkozcfe3MWrsOcNcjHGShYYXaV454GvBO9iaysc7Vp6p/6eoVPeWBdJ97XxhrDla
 rM2IZQf3Pqfl2CyTp2B2Jm8jYEsOCRn1aXBXLUpXa0TeiNM1YFg8fnfkSCYk4pa4vwxvBpcHKzq
 spoYd+HY97vOQ/hzDUg==
X-Proofpoint-ORIG-GUID: TKUxMoSXYAd-phmBNg1BEuuD8Sx8-wo7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150088
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34760-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qti.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC6DF402F14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Extend ieee80211_probe_peer() to support STA/P2P-client mode. Reject the
request if a peer MAC address is provided or if the interface is not
associated.

For MLO STA/P2P-client, construct the nullfunc using MLD addresses and
set IEEE80211_LINK_UNSPECIFIED in the TX control flags so the driver can
choose the link. For non-MLO STA/P2P-client, use link 0 together with
the corresponding per-link BSSID and link address.

In the TX status path, report probe status for STA/P2P-client mode
without a peer address and include the transmitted link in
cfg80211_probe_status(). Add link_valid/link_id bitfields to
struct ieee80211_tx_info.status so drivers can report the link used
for the completed TX.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 include/net/mac80211.h |   2 +-
 net/mac80211/cfg.c     | 193 ++++++++++++++++++++++++++++-------------
 net/mac80211/status.c  |  30 ++++++-
 3 files changed, 158 insertions(+), 67 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 40cb20d9309c..f93d15c61a52 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1364,7 +1364,7 @@ struct ieee80211_tx_info {
 			u8 pad;
 			u16 tx_time;
 			u8 flags;
-			u8 pad2;
+			u8 link_valid:1, link_id:4, pad2:3;
 			void *status_driver_data[16 / sizeof(void *)];
 		} status;
 		struct {
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index abd0ac20f0da..f5b3c9bd67f8 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4753,101 +4753,174 @@ static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_qos_hdr *nullfunc;
 	struct sk_buff *skb;
-	int size = sizeof(*nullfunc);
 	__le16 fc;
 	bool qos;
+	struct ieee80211_bss_conf *conf;
 	struct ieee80211_tx_info *info;
 	struct sta_info *sta;
 	struct ieee80211_chanctx_conf *chanctx_conf;
-	struct ieee80211_bss_conf *conf;
 	enum nl80211_band band;
-	u8 link_id;
+	const u8 *peer_addr = peer;
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
+	/* STA/P2P: userspace must NOT provide peer MAC, AP is implied.	 */
+	if (sdata->vif.type == NL80211_IFTYPE_STATION ||
+	    sdata->vif.type == NL80211_IFTYPE_P2P_CLIENT) {
+		if (peer)
+			return -EINVAL;
+
+		if (!sdata->u.mgd.associated)
+			return -ENOTCONN;
+	} else if (!peer) {
+		/* AP/GO: must have a peer MAC. */
+		return -EINVAL;
 	}
 
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
+	if (sdata->vif.type == NL80211_IFTYPE_AP ||
+	    sdata->vif.type == NL80211_IFTYPE_P2P_GO) {
+		sta = sta_info_get_bss(sdata, peer);
+		if (!sta)
+			return -ENOLINK;
 
-			conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+		qos = sta->sta.wme;
 
-			if (unlikely(!conf)) {
-				ret = -ENOLINK;
-				goto unlock;
+		if (ieee80211_vif_is_mld(&sdata->vif)) {
+			if (sta->sta.mlo) {
+				link_id = IEEE80211_LINK_UNSPECIFIED;
+			} else {
+				/*
+				 * For non-MLO clients connected to an AP MLD,
+				 * use the link address for the client's link.
+				 */
+				link_id = sta->deflink.link_id;
+				conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+				if (unlikely(!conf))
+					return -ENOLINK;
 			}
+			/* MLD transmissions must not rely on the band */
+			band = 0;
+		} else {
+			chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+			if (WARN_ON(!chanctx_conf))
+				return -EINVAL;
+			band = chanctx_conf->def.chan->band;
+			link_id = 0;
+		}
+
+		size = sizeof(*nullfunc);
+		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
+				 (qos ? IEEE80211_STYPE_QOS_NULLFUNC
+				      : IEEE80211_STYPE_NULLFUNC) |
+				 IEEE80211_FCTL_FROMDS);
+		if (!qos)
+			size -= 2;
+
+		skb = dev_alloc_skb(local->hw.extra_tx_headroom + size);
+		if (!skb)
+			return -ENOMEM;
+
+		skb->dev = dev;
+		skb_reserve(skb, local->hw.extra_tx_headroom);
+
+		nullfunc = skb_put(skb, size);
+		memset(nullfunc, 0, size);
+		nullfunc->frame_control = fc;
+
+		memcpy(nullfunc->addr1, sta->sta.addr, ETH_ALEN);
+		if (ieee80211_vif_is_mld(&sdata->vif) && !sta->sta.mlo) {
+			memcpy(nullfunc->addr2, conf->addr, ETH_ALEN);
+			memcpy(nullfunc->addr3, conf->addr, ETH_ALEN);
+		} else {
+			memcpy(nullfunc->addr2, sdata->vif.addr, ETH_ALEN);
+			memcpy(nullfunc->addr3, sdata->vif.addr, ETH_ALEN);
+		}
+
+		info = IEEE80211_SKB_CB(skb);
+		info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS |
+			       IEEE80211_TX_INTFL_NL80211_FRAME_TX;
+		info->band = band;
+		info->control.flags |= u32_encode_bits(link_id,
+						       IEEE80211_TX_CTRL_MLO_LINK);
+
+		skb_set_queue_mapping(skb, IEEE80211_AC_VO);
+		skb->priority = 7;
+		if (qos)
+			nullfunc->qos_ctrl = cpu_to_le16(7);
+
+		ret = ieee80211_attach_ack_skb(local, skb, cookie, GFP_ATOMIC);
+		if (ret) {
+			kfree_skb(skb);
+			return ret;
 		}
-		/* MLD transmissions must not rely on the band */
+
+		local_bh_disable();
+		ieee80211_xmit(sdata, sta, skb);
+		local_bh_enable();
+
+		return 0;
+	}
+
+	/*
+	 * STA/P2P: send a nullfunc to probe the AP/peer.
+	 * For MLO, let the driver/firmware decide which link to use.
+	 */
+	if (ieee80211_vif_is_mld(&sdata->vif)) {
+		link_id = IEEE80211_LINK_UNSPECIFIED;
+		peer_addr = sdata->vif.cfg.ap_addr;
+		src_addr = sdata->vif.addr;
 		band = 0;
+		sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 	} else {
-		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
-		if (WARN_ON(!chanctx_conf)) {
-			ret = -EINVAL;
-			goto unlock;
-		}
-		band = chanctx_conf->def.chan->band;
 		link_id = 0;
+		conf = rcu_dereference(sdata->vif.link_conf[0]);
+		if (!conf)
+			return -ENOLINK;
+		band = conf->chanreq.oper.chan->band;
+		peer_addr = conf->bssid;
+		src_addr = conf->addr;
+		sta = sta_info_get_bss(sdata, peer_addr);
 	}
 
-	if (qos) {
-		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
-				 IEEE80211_STYPE_QOS_NULLFUNC |
-				 IEEE80211_FCTL_FROMDS);
-	} else {
+	qos = sta ? sta->sta.wme : false;
+
+	size = sizeof(*nullfunc);
+	fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
+			 (qos ? IEEE80211_STYPE_QOS_NULLFUNC
+			      : IEEE80211_STYPE_NULLFUNC) |
+			 IEEE80211_FCTL_TODS);
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
+	memcpy(nullfunc->addr3, peer_addr, ETH_ALEN);
 
+	info = IEEE80211_SKB_CB(skb);
 	info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS |
 		       IEEE80211_TX_INTFL_NL80211_FRAME_TX;
 	info->band = band;
-
 	info->control.flags |= u32_encode_bits(link_id,
 					       IEEE80211_TX_CTRL_MLO_LINK);
+
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 	skb->priority = 7;
 	if (qos)
@@ -4856,18 +4929,14 @@ static int ieee80211_probe_peer(struct wiphy *wiphy, struct net_device *dev,
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
index 4a64ac6d1451..e049ab946e7b 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -622,7 +622,8 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 		return;
 
 	if (info->flags & IEEE80211_TX_INTFL_NL80211_FRAME_TX) {
-		u64 cookie = IEEE80211_SKB_CB(skb)->ack.cookie;
+		struct ieee80211_tx_info *skb_info = IEEE80211_SKB_CB(skb);
+		u64 cookie = skb_info->ack.cookie;
 		struct ieee80211_sub_if_data *sdata;
 		struct ieee80211_hdr *hdr = (void *)skb->data;
 		bool is_valid_ack_signal =
@@ -652,12 +653,33 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 								skb->len,
 								acked,
 								GFP_ATOMIC);
-			else if (ieee80211_is_any_nullfunc(hdr->frame_control))
-				cfg80211_probe_status(sdata->dev, hdr->addr1,
-						      cookie, -1, acked,
+			else if (ieee80211_is_any_nullfunc(hdr->frame_control)) {
+				const u8 *peer_addr;
+				int link_id = -1;
+
+				/*
+				 * STA/P2P client: peer_addr omitted;
+				 * AP/GO: report RA
+				 */
+				if (sdata->vif.type ==
+				    NL80211_IFTYPE_STATION ||
+				    sdata->vif.type ==
+				    NL80211_IFTYPE_P2P_CLIENT) {
+					peer_addr = NULL;
+
+					if (ieee80211_vif_is_mld(&sdata->vif) &&
+					    info->status.link_valid)
+						link_id = info->status.link_id;
+				} else {
+					peer_addr = hdr->addr1;
+				}
+
+				cfg80211_probe_status(sdata->dev, peer_addr,
+						      cookie, link_id, acked,
 						      info->status.ack_signal,
 						      is_valid_ack_signal,
 						      GFP_ATOMIC);
+			}
 			else if (ieee80211_is_mgmt(hdr->frame_control))
 				cfg80211_mgmt_tx_status_ext(&sdata->wdev,
 							    &status,
-- 
2.34.1


