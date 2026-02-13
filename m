Return-Path: <linux-wireless+bounces-31812-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P/0CLL2jmnbGAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31812-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 11:02:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDAC134D01
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 11:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E72A3066CEF
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5886F7E0FF;
	Fri, 13 Feb 2026 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cWwClDcx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vk9kEPm8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231351BC08F
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976930; cv=none; b=nJOdK9ayU4a+SyBzQgRGrVaAS/p4L4gKT59uifDSBOSi4yIsE7OFWGmXJsL3HU+ipShZAD/KgLZe8eczZtHmmIIiF9ZrramHuiASjvDQiLAJU+K5WcwtBF+L13dnSt3acJqAi41wenKbHBOfefGKQHliKQ7q0nD58UJlgYZapEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976930; c=relaxed/simple;
	bh=pO//tmvrlH1Yf0iUnWc4kqKSWATer6FCyhx8sojPQco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtnZwZorJTTYjFgq+ygBgQ+bFgf+uW/Q95Kgs3p9zV+igTv2YPn1vLnfndaiuWtInlO+Nf8GfdUyXL/l6Qj2nwBtYbdLqQffQ2yjS/yPQb9hNb/MtvjQuX/aP+NUKki2yE/DKca+d4YY1dMI8TYqisndBCg/IbcUMvYJswne/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cWwClDcx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vk9kEPm8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D7F73U3043297
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 10:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=a+5DLSmrdLU
	gglpw14uVYChSbWu109sqzY8B1R6pIJU=; b=cWwClDcxa+UqhkIatrqRmbXyqQZ
	zlKUXBtsSOW/ZaaRuUJPOL91LfsUcIF5bCdcsMrKovaHozajU/qywyoL+Y8pTgBM
	Yv0fVCm5/6Nsw3dyPs/eLUcLYbz2QHsK9FQot1O1RzJjD3EoxZYlLxJ1c4nNdb7I
	1FEwb72KhZcjKhjUljc3SjAhWYjzXKIeGY9t2qhIqXyytebE67M5gpRXZJa5pmQk
	/QjjYlfTzTELpxWx/TV1ywOFnxOrH82XdmqW32xPFN1zQ1MXGZZUWlPHV/YNSVNy
	dMBSsRCxiW5+DYwxXhJWuASvFYdZzqD5HSmqabtvVHvP0Dbs+KBKLuGSJuQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ps2tcwj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 10:02:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a784b2234dso33885975ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 02:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770976927; x=1771581727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+5DLSmrdLUgglpw14uVYChSbWu109sqzY8B1R6pIJU=;
        b=Vk9kEPm8tckwXONZUjeZPvr1dcWiRmF7G5b0UObFajrVLFAEZ2zCVCFVA61Nt9YCW8
         CAJhc9k3zUSUoxK5EAEDchOJRSN8Wy8eFpkOZzCGG0JHW1nykeherTqBOnf9uUBo1XXY
         2qh4tqhrzVizFvtTbs20R6SXunCggB1W/vn/9xgjhDQaUDY2U1TCIMLJWEAi7mVo+M80
         tMonqKp5ZPEMThmn6RII6fhhZVDqdBoZpUao/il9v4ZwzSPpooDZTJh2YrkaVJgEhe9J
         i/jrfUtobySuU5s9eo+q4gbiOma8cyQDYiot/B7abiLCflpA3WpXBeBTwp8BZ9Ivb8X9
         PJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770976927; x=1771581727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+5DLSmrdLUgglpw14uVYChSbWu109sqzY8B1R6pIJU=;
        b=SY/7mNQUBnbfIe5m7ye9x6WNmyq1Os4ZaIq8W/Iyzc1BDj6a/TpFcSRm2z8u8+dPCJ
         bdPaZrXlO0DMLJy131ENF6Fsf7EszsITooU9B7rYTrV17681tMFtNzBO6UfHnBZUK3wD
         wx4h1/55B0jhuyBZxHct35QELA1b58ETIyrNaXDtz/hscJSqU50+j6deAbRQGo0leJLo
         wZ/G0X2d0BwX9cvSvcumsebJ5xbiGbFKxt5yXc22yi6Dh/cvdkroXrf2Yn7SiYLynbtt
         jSBGalPNnYwqFZPfeErvWCNpHzR+WUP2oSQ6UHcqdTzLsfmEfmaPBfrxILIIffGmV7cP
         cY2A==
X-Gm-Message-State: AOJu0YzoCLBifZXerZ6enPesi0YTg36P7VHvuyR5KWKER4Jz9HQhodDa
	CtHDbVum5CLIguT4TW52FmboFcgxjS+pjdSXend5JWszm9dvUxkIVl4e8pu+wVt//Xub/fx2H8d
	nK/WLEOEemWihcS1WJxc8UFc8rBXPBkE+FqmsGJMY7GIxbLdTU2StIuyeC3yDY76whTNqq/bc4H
	PhJA==
X-Gm-Gg: AZuq6aLmwEB4+oiwEqjLjDWB+KAFvLluO9Enfs9fESQHBr3usztcKqcMLfuTeh8Xmgf
	KOFjvExeaXoTvW2REEVvQ1+VZB1KJKG5D0h0poXicwyFe+m2kLNkRpXleKZn/+/jOFTTv8uCiHF
	1h0Rv1wUma2DJaoMOkPD8xdCsGxRIiMQKIjn15SHZ8pqBhIxVebDjTIojoqSzb5eiDPVmCMTWm3
	gIjeUxJ522Xpr1B6to5w4t3Z35knfoXNL/Ln/+5rRMpJLidQNPFoYzH72uHFQniFiKnBBZuX/Sz
	78b5E8C/oks7MDd7q/wwH1uBGsmlOlIvVrAeJl9W/DNY6a7gL/IqZmifM4IWQUnAoderrHcXZ5K
	ICSaM7y0bhAfjZprEPdum9tvnTBR3xwDunxKi9+nEW0LKso5+Yzao80ZWHOVq457RuBlWN8detB
	UnnC823TfSMcmtvNHHlAK5XhJ/vFkQmY/zKLGLcU/pT4NDj4g=
X-Received: by 2002:a17:903:2452:b0:2aa:daf9:697e with SMTP id d9443c01a7336-2ab505cd904mr13518055ad.48.1770976927479;
        Fri, 13 Feb 2026 02:02:07 -0800 (PST)
X-Received: by 2002:a17:903:2452:b0:2aa:daf9:697e with SMTP id d9443c01a7336-2ab505cd904mr13517625ad.48.1770976927042;
        Fri, 13 Feb 2026 02:02:07 -0800 (PST)
Received: from hu-surapk-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad4asm79314755ad.6.2026.02.13.02.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:02:06 -0800 (PST)
From: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 1/2] wifi: mac80211: set band information only for non-MLD when probing stations using NULL frame
Date: Fri, 13 Feb 2026 15:31:25 +0530
Message-Id: <20260213100126.1414398-2-suraj.kizhakkethil@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: yXlNCxdooFkfVVpRB1LYG1tguM3uN5uN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NiBTYWx0ZWRfX5SeGrFbbhSku
 6PJrsw2SBZh2upArkGaAnncWxA9zFEXbmuANdd+kGNwK7cPRt4Uzh/lcpxTvFC86U4zKbBNeRiD
 55/QbcAWrpK5oUkHRgUhRoKkkP/UwdERzQ0vizLTV470e70MQpvMrnJdoZPCC5anlPgV03pkPcP
 FeNQTLd3RrCl4UD521FqZMk8elGQgpUe6DwrhUyxa9fK4/gxg/h80XooxbLI1EKsFZljFseeSET
 /498Lst2fzcsde4hnto+tzDuT6Mn88tboyQH24Ojyf675JhhkjG+QTLMrxOoYFajt3pWsjRwZGl
 g14pUbBTe+cqB/iPtpDfUkQ9agaEJGz668JBwA0gMdi8ZANywLGQFrIRGHpk5xVvifZ49APkLbA
 yAHS/fKjUgtMqyP3tohdPc4hr1Y22DjYYDRrmCGAlSLgkoVwWcXlz7Xdj8dJnihNkVKkGxNNqZL
 X/KJdr4OKBMyhoC5BVw==
X-Authority-Analysis: v=2.4 cv=LoOfC3dc c=1 sm=1 tr=0 ts=698ef6a0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=vE-tIMW3D2e8mXuJwIQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: yXlNCxdooFkfVVpRB1LYG1tguM3uN5uN
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
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31812-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.kizhakkethil@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7CDAC134D01
X-Rspamd-Action: no action

Currently, when sending a NULL frame to probe a station, the band
information is derived from the chanctx_conf in the mac80211 vif's
bss_conf. However, for AP MLD, chanctx_conf is not assigned to the
vif's bss_conf; instead it is assigned on a per-link basis. As a result,
for AP MLD, sending a NULL packet to probe will trigger a warning.

WARNING: net/mac80211/cfg.c:4635 at ieee80211_probe_client+0x1a8/0x1d8 [mac80211], CPU#2: hostapd/244
Call trace:
 ieee80211_probe_client+0x1a8/0x1d8 [mac80211] (P)
 nl80211_probe_client+0xac/0x170 [cfg80211]
 genl_family_rcv_msg_doit+0xc8/0x134
 genl_rcv_msg+0x200/0x280
 netlink_rcv_skb+0x38/0xf0
 genl_rcv+0x34/0x48
 netlink_unicast+0x314/0x3a0
 netlink_sendmsg+0x150/0x390
 ____sys_sendmsg+0x1f4/0x21c
 ___sys_sendmsg+0x98/0xc0
 __sys_sendmsg+0x74/0xcc
 __arm64_sys_sendmsg+0x20/0x34
 invoke_syscall.constprop.0+0x4c/0xd0
 do_el0_svc+0x3c/0xd0
 el0_svc+0x28/0xc0
 el0t_64_sync_handler+0x98/0xdc
 el0t_64_sync+0x154/0x158
---[ end trace 0000000000000000 ]---

For NULL packets sent to probe stations, set the band information only
for non-MLD, since MLD transmissions does not rely on band.

Signed-off-by: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5d04d7d550b0..70a210db16cd 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4631,12 +4631,17 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 
 	qos = sta->sta.wme;
 
-	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
-	if (WARN_ON(!chanctx_conf)) {
-		ret = -EINVAL;
-		goto unlock;
+	if (ieee80211_vif_is_mld(&sdata->vif)) {
+		/* MLD transmissions must not rely on the band */
+		band = 0;
+	} else {
+		chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
+		if (WARN_ON(!chanctx_conf)) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+		band = chanctx_conf->def.chan->band;
 	}
-	band = chanctx_conf->def.chan->band;
 
 	if (qos) {
 		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
-- 
2.34.1


