Return-Path: <linux-wireless+bounces-29382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA01C8EB18
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 15:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 988CA4E3614
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A871A9F97;
	Thu, 27 Nov 2025 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IIXpZ0Wu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TEk+WppT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A4F3328E4
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252392; cv=none; b=qCGyYBCfd7ZFNrbDh4WcUs7oW1LUqhXwcvaMucVwDFEC0oefyvUlRnw7O7k31v/GxyFPfTOnTv9kiKgCdixEro8QWa+CQULpZHx+UNObYTkNPbzu1Ep+Yf27DQC5/Hqataa5ZMvFdGHhrWXPp6F25BZFR9Iwwo0WcjCusW+A7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252392; c=relaxed/simple;
	bh=X0k2lJUvVDQZxX7bX+JAIoL7Y9TdybNwhR2TfEQ/ND8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yp/b/xyUefRYKDnFprsd9XUmdsRvGSZR/9RaS0OsAa9fdR/x5Xhcqw9o9Y3vn8wUUlnXh/zZ+ExA7R0TikQrT5RKWAbVadkS9qZxwdMFJIm04pXbgJSpbUBafYicqL803UGJz8Bksm71gML0qqmhjq8loie+CT7GX2gNhcXPSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IIXpZ0Wu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TEk+WppT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR5oBw22855055
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 14:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DcbrOc8qXO3
	zl7DEKnOoP7OPqXGrDwiUiOWDY9SkfXw=; b=IIXpZ0Wue3MJNJf6KwkNNgRua6I
	4cUzJS7H7bNYzdYnsKlKyfGUVDt2auNNztqCycBfRYTHgLsQVTEmZLgL5LDknVuB
	ohy+/zBgXBv5D3s8a0ZQqj305+3Gz3xA07Dk/HliBWOXxB9VA3HVgy2a3PzSlEnO
	y6aqM7XGwukeoi+faWN6/OWK/+FGOZNW4rbZBrX7vxna0Ym+G09e7CR8Z1DidD0+
	NpC+FglBFK2UESAvq+ooYnIZ/GM7EJNyDS8NNiJ1EcKuQA5dF/0Ia2WMaPtnig8X
	sw0ghmtkE6fQkbw/Tq2yQB/GaIoj16mAIrK8nTMDMoBFuRwkI46b8bnc/qg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap4vhb3yc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 14:06:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3438744f12fso2381301a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 06:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764252389; x=1764857189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcbrOc8qXO3zl7DEKnOoP7OPqXGrDwiUiOWDY9SkfXw=;
        b=TEk+WppTjT5fJpAu3N5dTXpFsbEoiE6cNeTWjo5nq87CrjabXmJVI451rnmYcYMU8f
         BbViHbCHWwDiLeusUGk8reBE3Xt8T1R5Jp2iQT1+6FTswxXYxjCzWnlRUJzeqIdZTSSD
         kL9BlwGhMJzvnn3FX6F3Imk4pbpj6maeNkelJweQvRHTFV8mvWYbpSVMxA4dZGoT92wQ
         L74AZbc2YF9lfSQfeZDnLkJiHEzVM+gSGwlmzeLifzvYCylUvefDkgNg6/pjGMvvKc25
         IXXzh6rDbSr0aINfX/vsU1ywgCC1lwmHTwbHgyjhAYqvvtK+LWhBHuvkTGCTOpESEcFE
         4o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764252389; x=1764857189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DcbrOc8qXO3zl7DEKnOoP7OPqXGrDwiUiOWDY9SkfXw=;
        b=OnLYrm3U4Z4hch2H+JqadD+Tc5fiMSaWDA8jgaxHuNQVt18zi4bVOmn3DKZVyuDrs0
         W6J+YyqxZBKiIB3swWVQVqqHUaoYDIk08OODnQvm0WFJKG09J9FX+WDEizIbJxDeHTHz
         D42PnrdleHeAUeTVJhbxdZDxqVaOK+KQxF6YIeEUWzJdTYdc9CmzW69TacXA6FodUDJz
         6R2MReMU3ez6Td9wE49EtYkoTy7rH39cCehQKQjPBRXiTgNIpitp/3g5Y5HGKTMl0gPP
         MIJDsb4DcbPNCWr2R5FFQq4zjxRdIudR6v5xifjZmAHWNMiNhq8WM3sX0zEh75itu9FJ
         GuDA==
X-Gm-Message-State: AOJu0Yy93MmIE9wD/YzoqI/MYbuOsdIqnYXkb7cOMicGWsJNnxdvFrc8
	zB4WGq9LpgUUlFuKQOF0VfTJ4O18SUtUhX4woy1MIeCSd4jtdZu6sNT1+DKoTYnk1EPLCdJUUWe
	Oj4yurRVcD/OC7KQ4qLmHnTwvl3cY/p/ECBfXmweTzDFfIhkAGrnHdV9hEc8ul7za4th2qQ==
X-Gm-Gg: ASbGncsQ+pgbXO1y8IWSIOEWyVn5xQ41gpODr9Au+D4+3FUXC+d9OXBUpBTLJfLnkJR
	edjb75xdH6MOe75bGwZRm3vLsgcRFiJVSvCFtJOLdZj5d5RsRLDHTgv7heO6Ka7aqSrTyi0JdhB
	iZTB+g1qIGW/rdOhJ4N3R2RKcqG6BUP7Y3cAgM4LQi/Qn1BoIHeHr8JkX/qBjDe4dQ8vOt/4JEc
	gGFwGLcxDY0oAABnOC2cNdBl0cgH4ns2+QA3XpncSSvq8QlieaOjKUPdRJjW464nNQ/GnZ3/29s
	oVxiHW2l66D65ukwHgg/UtoJvUe2TYbiCAyt9MjHHLv3OudijAJRKbeI3b5keKkPqDNFERW34IX
	tRSPA3EcOwG5g2DxhOSYFnGeBYaP8cSyBA73x/lugXm0v8qvRPjImicVjTvv2nJzKjRR9XWtDXI
	plFtbflr9KyzmT7W9UI+hx6L5nIsLKjaG65Zw=
X-Received: by 2002:a05:6a21:e098:b0:35d:1bcd:6874 with SMTP id adf61e73a8af0-3637db85c1emr12443757637.25.1764252389018;
        Thu, 27 Nov 2025 06:06:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9uy6mhadpUXKpzGCoJgqtxfU6R6AHeFChoFqzR4TMjz3/7QKlyTjdao1M0uVfNA/m0OwP9g==
X-Received: by 2002:a05:6a21:e098:b0:35d:1bcd:6874 with SMTP id adf61e73a8af0-3637db85c1emr12443699637.25.1764252388417;
        Thu, 27 Nov 2025 06:06:28 -0800 (PST)
Received: from hu-surapk-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fb24942dsm2125631a12.6.2025.11.27.06.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 06:06:28 -0800 (PST)
From: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
Subject: [PATCH wireless-next 1/2] wifi: mac80211: set band information for NULL packets only for non-MLO stations
Date: Thu, 27 Nov 2025 19:35:54 +0530
Message-Id: <20251127140555.472327-2-suraj.kizhakkethil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251127140555.472327-1-suraj.kizhakkethil@oss.qualcomm.com>
References: <20251127140555.472327-1-suraj.kizhakkethil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEwNSBTYWx0ZWRfX1vDEEga6yzrM
 DPzDV4zFKri+GdYTYSpHjzR20qcaVxO+W+gmE+by95pDEhpBAqCVd9vHT0VOKS2+MpWkSGs38Ec
 q8a0+tofDArnbOtKeZwDObdCgcvUaL5ogsR0zy0xDU6vZFSwWF5GDhl9cy0jiUZnQeSAB3tEeXi
 fBgnDGdT5t8i8eqsUNzQI80jMtxi4cy0GKE6Wtd9bs0HXHXOU4mAVl6LTDA3Ns2qdd38CNijhYH
 EsAb0TmMwz3Wh2BMliCkrWWeOoJLWUnk4KhcwCEDAvgV/K2HUHJXJhmdEfJ2vVhS2l+NKeTG0vl
 lybm63ZKd1+UKvF8liHiAt7HLDoWsJtLXnv/9B2Wfy/U9Wvpu80GG2En/4CdgEU26/EYFE5a4kY
 tNgTZpWRLGx/3vc67V/Amek2SsBv9A==
X-Proofpoint-ORIG-GUID: S-KixwvBA93isPEZHEuARG3fUfUQfZ1B
X-Proofpoint-GUID: S-KixwvBA93isPEZHEuARG3fUfUQfZ1B
X-Authority-Analysis: v=2.4 cv=Lt6fC3dc c=1 sm=1 tr=0 ts=69285ae6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=vE-tIMW3D2e8mXuJwIQA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270105

Currently, when sending a NULL packet to probe a station, the band
information is derived from the chanctx_conf in the mac80211 vif's
bss_conf. However, for MLO, chanctx_conf is not assigned to the vif's
bss_conf; instead it is assigned on a per-link basis. As a result,
for MLO, sending a NULL packet to probe will trigger a warning.

WARNING: net/mac80211/cfg.c:4593 at ieee80211_probe_client+0x1a8/0x1e0 [mac80211], CPU#2: hostapd/241
Call trace:
 ieee80211_probe_client+0x1a8/0x1e0 [mac80211] (P)
 nl80211_probe_client+0xac/0x170 [cfg80211]
 genl_family_rcv_msg_doit+0xc8/0x134
 genl_rcv_msg+0x200/0x280
 netlink_rcv_skb+0x38/0xfc
 genl_rcv+0x34/0x48
 netlink_unicast+0x228/0x334
 netlink_sendmsg+0x158/0x364
 ____sys_sendmsg+0x1f4/0x21c
 ___sys_sendmsg+0x98/0xc0
 __sys_sendmsg+0x74/0xd0
 __arm64_sys_sendmsg+0x20/0x28
 invoke_syscall.constprop.0+0x4c/0xd0
 do_el0_svc+0x3c/0xd0
 el0_svc+0x28/0xb8
 el0t_64_sync_handler+0x98/0xdc
 el0t_64_sync+0x154/0x158
---[ end trace 0000000000000000 ]---

For NULL packets sent to probe stations, set the band information only
for non-MLD case, since MLD transmissions does not rely on band. For
MLD connections, set the link ID as unspecified to allow the driver
to select the appropriate link. The case specific to non-MLO stations
connected to an MLD AP will be addressed in a follow up patch.

Signed-off-by: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b51c2c8584ae..9554b25b8fc6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4609,12 +4609,17 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 
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
@@ -4651,6 +4656,9 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 		       IEEE80211_TX_INTFL_NL80211_FRAME_TX;
 	info->band = band;
 
+	if (ieee80211_vif_is_mld(&sdata->vif))
+		info->control.flags |= IEEE80211_TX_CTRL_MLO_LINK_UNSPEC;
+
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 	skb->priority = 7;
 	if (qos)
-- 
2.34.1


