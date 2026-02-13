Return-Path: <linux-wireless+bounces-31813-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFXUHrb2jmnbGAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31813-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 11:02:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5D0134D08
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 11:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00D5C3082EDC
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 10:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2DA30CD87;
	Fri, 13 Feb 2026 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A5bEk9QT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dqHv5R2e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE651BC08F
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976932; cv=none; b=uh+op3tzcvqbaJSwLsYZeQcfbutZ2wAWxEX7gorBAYa0USsRY07rJhkhqVQnQswcOtK/+p1fkwJz1eHGpoTBG9i6uj5fzl1aw6P/k87NhR/IuascZo6X47v8qKb4ZpGoN711urmVmioYZ/laCH1tMGm+VrN4M48JiEEhrEYai5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976932; c=relaxed/simple;
	bh=MIQqZ8MhegOP/HKBrETfUk7bA770sZ/7rpdgRxzM6oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gUfgYMmas7FTabLRwAeVB6W14zJQ9AO2MZqoryHD2aXXq5k9ARNHodjn5qqGYSBr3CidIOImyKUOUjvflR1kNPXRSjlzYDgc39doKCoFlNmPcyJSnSnnHXvoT2Hu9G3c3Olikr+D9wHyN+DtPOMc50NdsKspA6ePNBFtbIGqhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A5bEk9QT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dqHv5R2e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D4i0Hw3951637
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 10:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4ktP3GIa0Rd
	ZImS++poI/ijs1AVQuDFaEtdmXySUe14=; b=A5bEk9QTI35Uy06Y/Vu/ligkX+O
	F/eSlqauqpZomsY/KAFBSQWWsb2khbE868N8/THPWvBFXrVHMcibcnh0CcBPq0Po
	zYHmAj1CKRx4Av8Oyu82zj9n5l1IQMgNBTt7+TAD+ZzmKRbZ3qHqBA/nHm3lZs+F
	ZxGIKlDDpGLTzrUjTd5Tk5bR7Q19V458VPFSVR1lCWoLfGungRR5BhcdM8D3s+d+
	BG29iEn/2MEuWEwHrifnNr7K+yRZwx9xMnmKH4mrNCxf0I+1cLvgYU2ItYHHgvWk
	bG0OISevEB93/6/gsKNtiJr5rqdm+6dS3jzJEyMhCdHs4FHjNks9suQP9CQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ps2tcwp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 10:02:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a943e214daso29554165ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770976930; x=1771581730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ktP3GIa0RdZImS++poI/ijs1AVQuDFaEtdmXySUe14=;
        b=dqHv5R2ePkRpr9E2yl6q77j4LAveu3DuOmCaUpSAjAMBarvvVgIrMBOxhQE2OGLVKW
         1TRklvyrFCz5eoYyHTxFpPfXQ89A4BdoyMRP+RlCBt95wU4Ov2zBUlqt163KW7oKgdhV
         WYJaJ5sw0AwmvyBQAfh2CC0iz1zSacEjXcjGwCErWSKiW4TQykHauU20+mv+mdiN5GGE
         CC/UIaEp5dWTQgID7ZPsXb1UDKODy8v/jNlHKA6rdkwEQ/DEGAlKqnBVqLO7a1VOlzhk
         y86FW0aYz0pjI5nMOAx0WiPFqhVKhhneYW5vNBRN3O05Fl2AGd5ThSsElgiSFbCnGd7n
         JfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770976930; x=1771581730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ktP3GIa0RdZImS++poI/ijs1AVQuDFaEtdmXySUe14=;
        b=A0qcjqCxVTELHpDOm7K0uXIXY46tqNbDvWIFlEdSVKTJqLY7SOj/oiVfyhP0wT52Dp
         EmPyH1OhLHVNq6Kls7KAZEfXIAecex0FN5CxBsMeHjmLlJl1Dg/x866iIUK5dmdkwgU5
         ie+hvG7KV32nrdhvyggJIGDx83WSoUzyMqWRDrk3YahTnIt0D8UVVvpa0xN9ZLLGU/nR
         YXrbDWQqmlYqVlwZQp31mfH2kthDkVUACnIwSB8TMPEeq2Jvmfyz0aTDcDENcRhzze8C
         /R7ibI5pK3v8gP6hnu4xxOSbLFwPqsBvpLlBkJytsCFT+fx2IRmGNv9XCdVgqgYIfs7z
         LOJg==
X-Gm-Message-State: AOJu0YzSDRhiEA+ZRfb8CpXu/6ny5oxoGwE7xU9knvlEO+mezh+e30Nf
	CTmpWPBwI27+YqSVbt0FcNJT8dUxl1jiyLan/0jiWCWo6J9DNOgJVjUaVJ2oCKK52FnqdEAnFrI
	oZEXCt41nL90/OwWdcPhpwcZj+iEkPOVSY2xigCsw/63/QaO0eOO/jWOQfDDPWFOial20aw==
X-Gm-Gg: AZuq6aKIPeXAlY2btkxZD9wutxIdS2fEbpITndW7U46Kfz42sg70w+G551G8W/oNsB1
	ziuenyTUDRJefB71nojAVDWMmyOz9ocPcP3MRe9pJEXAKvNZMQ7DMfexVRuH1i06/IQP8FgP0sM
	BTCp1AbXM4XGeboLM0BqW2B3inwQmoi72op57hbicPn0feIxOPok8IAI/zl//N+0Nk+ZGAQN7Th
	beO/IHfX81rslPGLTzz65AglURAmi3gI6VJBoHbAuY+d1nVXVghbffkUsyw6RyBHQ7+z7NxqgOB
	2Amo6pRnxKOx0i+n0rTYhTuriCaD/asTCL9GlQHyEwca92qsMTOfMOMUExpki8DAoEpPTO9FgRE
	LmaNayc4UTH9C8WVvrCReG6yWpFcEXpwLl7+pkjWo+GWIgkplGo8l+Ef7wOPySSNRHNrLxSwXtN
	oFx6O+DTCpd7MbiP55z9HNbS7ipVgUJWjvshIjW50Dei5cAv0=
X-Received: by 2002:a17:902:d4d0:b0:2aa:d61d:79bf with SMTP id d9443c01a7336-2ab4d04e925mr22310385ad.42.1770976929937;
        Fri, 13 Feb 2026 02:02:09 -0800 (PST)
X-Received: by 2002:a17:902:d4d0:b0:2aa:d61d:79bf with SMTP id d9443c01a7336-2ab4d04e925mr22310025ad.42.1770976929478;
        Fri, 13 Feb 2026 02:02:09 -0800 (PST)
Received: from hu-surapk-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad4asm79314755ad.6.2026.02.13.02.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:02:09 -0800 (PST)
From: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>,
        Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 2/2] wifi: mac80211: Set link ID for NULL packets sent to probe stations
Date: Fri, 13 Feb 2026 15:31:26 +0530
Message-Id: <20260213100126.1414398-3-suraj.kizhakkethil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213100126.1414398-1-suraj.kizhakkethil@oss.qualcomm.com>
References: <20260213100126.1414398-1-suraj.kizhakkethil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4MgCXyEbx2en-1xDt7fXurovGcv2OkWo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NiBTYWx0ZWRfX06L9QoaPCv6y
 /oV0erDZhyBACKFZZ0Of17bhzsEQzNJaGJZhj9CM2HBhAGyiwH/JvVVOus4jmET5VYpQdsgW9Yw
 3ZSBZgZlQI31DJ8k7vWeycXqm3QzeEHG706Sv0HlrENEn388wpfXziBA620cMQVbXaDoc5GcxJ8
 qpinMeg+0oaTY29oLEZCx+J9zEFaDQi6WY9R9guFEhxkmJ+6GMC0vquyhIXe7+Bd+5TIZOq4COC
 X0gqFG3QcGzaUA1SPtSYpL1PI+pjtOeSS1fuzTkNIPSUd3DjriCmpuAhUe3u8vVTwTRxFFy7wBh
 XHOxD00ytf6tCD6rvibBxYUlRvj2N6hOoS18gYqB2Wa6B3P0IrKogTcXGJRk/plc0l6T+xz2ipP
 K+tQV2XYTlzBAldnEAZqb8DibGK/+e64lAXjDxx2KA4rKwpY9bTpAXtt2ZKX2ao1YZZ8douAegd
 qjw1w/IPzxuABKZGyyA==
X-Authority-Analysis: v=2.4 cv=LoOfC3dc c=1 sm=1 tr=0 ts=698ef6a2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=-DszaT_1jmKF5TVRXSIA:9 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4MgCXyEbx2en-1xDt7fXurovGcv2OkWo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130076
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31813-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.kizhakkethil@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EB5D0134D08
X-Rspamd-Action: no action

Currently, for AP MLD, the link ID is not provided when a NULL
packet is triggered to probe a station. For non-MLO stations connected
to an AP MLD, use the station's default link to send the NULL packets
and set addr2 and addr3 to the link address. For MLO stations, set the
link ID to unspecified to let the driver select the appropriate link.

Co-developed-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Signed-off-by: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 70a210db16cd..36f921fd2176 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4616,7 +4616,9 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_tx_info *info;
 	struct sta_info *sta;
 	struct ieee80211_chanctx_conf *chanctx_conf;
+	struct ieee80211_bss_conf *conf;
 	enum nl80211_band band;
+	u8 link_id = 0;
 	int ret;
 
 	/* the lock is needed to assign the cookie later */
@@ -4632,6 +4634,23 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	qos = sta->sta.wme;
 
 	if (ieee80211_vif_is_mld(&sdata->vif)) {
+		if (sta->sta.mlo) {
+			link_id = IEEE80211_LINK_UNSPECIFIED;
+		} else {
+			/*
+			 * For non-MLO clients connected to an AP MLD, band
+			 * information is not used; instead, sta->deflink is
+			 * used to send packets.
+			 */
+			link_id = sta->deflink.link_id;
+
+			conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+
+			if (unlikely(!conf)) {
+				ret = -ENOLINK;
+				goto unlock;
+			}
+		}
 		/* MLD transmissions must not rely on the band */
 		band = 0;
 	} else {
@@ -4668,8 +4687,13 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	nullfunc->frame_control = fc;
 	nullfunc->duration_id = 0;
 	memcpy(nullfunc->addr1, sta->sta.addr, ETH_ALEN);
-	memcpy(nullfunc->addr2, sdata->vif.addr, ETH_ALEN);
-	memcpy(nullfunc->addr3, sdata->vif.addr, ETH_ALEN);
+	if (ieee80211_vif_is_mld(&sdata->vif) && !sta->sta.mlo) {
+		memcpy(nullfunc->addr2, conf->addr, ETH_ALEN);
+		memcpy(nullfunc->addr3, conf->addr, ETH_ALEN);
+	} else {
+		memcpy(nullfunc->addr2, sdata->vif.addr, ETH_ALEN);
+		memcpy(nullfunc->addr3, sdata->vif.addr, ETH_ALEN);
+	}
 	nullfunc->seq_ctrl = 0;
 
 	info = IEEE80211_SKB_CB(skb);
@@ -4678,6 +4702,8 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 		       IEEE80211_TX_INTFL_NL80211_FRAME_TX;
 	info->band = band;
 
+	info->control.flags |= u32_encode_bits(link_id,
+					       IEEE80211_TX_CTRL_MLO_LINK);
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 	skb->priority = 7;
 	if (qos)
-- 
2.34.1


