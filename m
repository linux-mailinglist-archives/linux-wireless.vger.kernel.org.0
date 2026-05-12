Return-Path: <linux-wireless+bounces-36289-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOz7F4uxAmonvwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36289-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 06:50:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF37519AAB
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 06:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B255303F04A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3CF2F8E81;
	Tue, 12 May 2026 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgwPL65a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SMNYq1rg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA1328B77
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 04:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561367; cv=none; b=WA6B8vhkJZ/Roe4hgVgsVOGW2cGmm1krd3Wem+EAVzhV4gQYQHBzTi8xiD9ZziFQqAZ7Zwi+xrfEwTrsl8JGk9EHrmK3BmzEwaQt1/RJXtBgZcH+0wWGzSPQH1Xb9OnNB3C7HDD3IW6ttc/P3DT1YKhG+cZMTb9CWW1jJXmZhhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561367; c=relaxed/simple;
	bh=eq70pSBDPpv1qxRtghvsdz+5yk0RTCO1a0feY91VYYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YspYkI5sM6d1hgSO53NG88K8QLp7WGcy7Q6U7PZ6vPjyoKZiiWtdxY82Hc61na2dgeI3UtffNsGtZiw64C4bP2k3Ow6dJB0N0OURPQ+uBoidHUBlgqm5HP07/1g4ToIk5Xp8HeVy+SWR122xs18b1WSw6JKPln1kFBTH13n22LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mgwPL65a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SMNYq1rg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6r0J3385188
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 04:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9iIPH/EreHB
	hCKOQUYLGHDzjj9qbMcXYyayD8tZa/wA=; b=mgwPL65a8kB4GOJeH5s+SOX4kmK
	PkvU6k2APw2WDBC+HnddZvCFYh/k2voALPpQ8oeNauhsT/vvXwNGzNKOJGCCyCAP
	l5l1G9beh4JgldjrqKJoRZF69Lsew4V0h/EEyfL8sZ3Pl4vq+uhjJl2faE3m3IlE
	ui9HfqImWEHp7skxC42fuLssSM7aqiiDVUdSGBnJcG9/SflsU5hxgrIJrD7WEi+j
	gqKrJt58nX41IWBJ37oGWjDjpVRNg+QYuHuOGUkPle2+RRW8YEKboPDwSN76FktQ
	XK4p0k3uMcIBVqlImk5nwxhxcrr9m3okTU7szIC4VQtQ0cMPMqiZJIXWUbA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv4hfmq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 04:49:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso3587379eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 21:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778561363; x=1779166163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iIPH/EreHBhCKOQUYLGHDzjj9qbMcXYyayD8tZa/wA=;
        b=SMNYq1rgZCPNHtuxSp3wKU6RwuJlcP00ptRL6sqEAFGfUO5suh9uUcINUqdr07AbOA
         et04Km0iqDKA6pML3dsjWk+NueSaudiCKaLB3jIPwazqauO108hDVTUQspLC928dNtLu
         89Y8HtMQ9KwcRhDJOnv0ZCnfntBLF6dfIPzV+2mng07OLMKh3AcP2Gx04WU8JwqoEUpg
         RwH+s+a0yrqq+QnZ9mtTvTLjAO1sCejRuw4unLN9vF+agDcRR0g2Z5ZVwkTk/xNBXOjb
         MQ6813vWhnqo59fmw6OT6dBPj+7rlleydsaUqw3j4nSc3eiRpejH/nBeNz4mYonhMrHu
         wVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778561363; x=1779166163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9iIPH/EreHBhCKOQUYLGHDzjj9qbMcXYyayD8tZa/wA=;
        b=FkvK3HWq7ZSKiUAvDlLZbJuEwCmBSSbXBOA9byNGWdx1XUqp0HvqaAJj97M3DJRAEd
         fteS9XW6cy625uW1BETyoFGlYgIIgGEIQ0IZ/AW/B0qAHHHuXkUinfthAnSdxkEkNGQN
         gKAWl4WS7qlCYDA/nWauD/4WR7gR9SALQ84KncvdEErIdjton970R+94SOTJXdOt+uid
         wik8LrV5hQuh46qJNf3/ZN1R2Jq4zf27qhpafUe4YPc5Lb3qQCzgF22mMpOpWwlSabjV
         eTO9Lfm/HnxYgE+u9ox9VVvDVytYU2HaIGqQcDI85Wc/SgYqEIy2SC6h9GkbM8bcDbQU
         zZyw==
X-Forwarded-Encrypted: i=1; AFNElJ+wUqsf2uNO1Bf+ndgqvt2y5KJ5AM3T5v/ucA+KNlGbRqgnXXeJ4agNH21/P+GX4MU7lB5WrsGpkgoXbHjiUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35SL1Ui1PVNMqEldjv0tm8qFwa0v7LCIs1HsJpcFp8JzWiAoS
	PxkXb/NGfL8AMDB80U4NO+zIy22kLY7hNL78dw5Cws3zW21zzyv/i+a2L1l709w9PkXFULqP1xp
	+VBGhVZMY9WGyTK1/OsZo/6Q+Qey8MnuCxFsWOraxKAhjQgIngDPl18kWdUbn2sh1zRiRPGBFmE
	6CGQpG
X-Gm-Gg: Acq92OGfYxbIK3TheQWEyH8fF7eOTHGBwtxIM2/UGGcMhDf2mE9qP6UJ2eINzQnBoig
	YDaqtd48zanyyvcWwfgGwldSUku2QrU8XixaMWgMH7otJi5bVJIs88JmrcoDJhIV7jZAqvpTiGo
	MOtrSsJ5mhqe0YYZqijNpAMO9FRRScpwVL5cHjjdMLboCHh6kW5Bq5XYPY7jbaiJzBaCuMQCYjY
	/VNfq8GuW8yv4GYYkJlMJndAIGAobHG8c5UVs8AeiVaWtuMb83bbdCKkfDYbrlYsiySpgK6xeml
	edM6+6usRDWI0KBIPeYVfaxtGEF/1Uorluxm8MB/i32sK6Ook11eCiM8PAwrNZtoVgQp6DAI+ID
	kBOc4LMpwQBC+XTJ2nfnipVv5jSIoeR1UX/aceEcRkVo5u8mu+Tk126x6mcDVqvuTSUASa5925g
	3OlQ==
X-Received: by 2002:a05:7300:fd0b:b0:2c4:dd55:ffc1 with SMTP id 5a478bee46e88-2fb4b82cd05mr5874961eec.2.1778561363342;
        Mon, 11 May 2026 21:49:23 -0700 (PDT)
X-Received: by 2002:a05:7300:fd0b:b0:2c4:dd55:ffc1 with SMTP id 5a478bee46e88-2fb4b82cd05mr5874946eec.2.1778561362692;
        Mon, 11 May 2026 21:49:22 -0700 (PDT)
Received: from san-w175-na3-01.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d43b4sm16032926eec.11.2026.05.11.21.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 21:49:22 -0700 (PDT)
From: Wei Zhang <wei.zhang@oss.qualcomm.com>
To: jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.zhang@oss.qualcomm.com
Subject: [PATCH ath-next 2/2] wifi: ath12k: fix NULL deref in change_sta_links for unready link
Date: Mon, 11 May 2026 21:49:05 -0700
Message-ID: <20260512044906.1735821-3-wei.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512044906.1735821-1-wei.zhang@oss.qualcomm.com>
References: <20260512044906.1735821-1-wei.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZrTd7d7G c=1 sm=1 tr=0 ts=6a02b154 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=5nEK3cMyjPeeF0Mhq6kA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA0MSBTYWx0ZWRfX8BgTlCkdTShg
 MtdxbNirVxIGn6O46lOUh+cAbCY/9U4Y78p8V21clC+QMsC6FgxdduUhnFREgIaf2LBJ2urq+CE
 AScDDmUhTy9psUGVZGgsZdFpW3Q/+qlsQx0PtxXEX660cHdQHLmFW5crBPHSHDf25MwtxZBNaoB
 O2DESzwREsnNL2Z7b3bQXQopo/ihHV17tVYthCEvNHm8SuqbaeKvfeucudJfFIiLAi6OPJLJWgq
 dMxa4e/tWSZMdQGZf0uGQ+2+ogCKrW1zgcQcwCO/I6stK26WGv9JP/c80MHStD9XFOCOtsFXMqk
 JclN/GWdeBz2xVmmmqdc2nphqAJ153GUtN/fdR2rfiXWzIWFxFqtTfGAPjuyk9g4olJiTGEuNro
 obftJNt8olqcIUkDr/PaN9Gt4VIxkZDXT8XcD/w0eF4q5ujduO7n+77kPYa9V2A39qV1LOnF34G
 eySydLCShfOiweBl7Ew==
X-Proofpoint-ORIG-GUID: wU_C0vGVyQnXF0OhZ_TB0RdZ3oaA5rAW
X-Proofpoint-GUID: wU_C0vGVyQnXF0OhZ_TB0RdZ3oaA5rAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120041
X-Rspamd-Queue-Id: BEF37519AAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36289-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.zhang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

_ieee80211_set_active_links() calls _ieee80211_link_use_channel() for
each newly-added link and WARN_ON_ONCE()s if it fails. The call uses
assign_on_failure=true, which allows mac80211 to continue despite
driver failures, but when a mac80211-level channel validation fails
(e.g., combinations check, DFS, or no available radio),
drv_assign_vif_chanctx() is never reached. Since ath12k_mac_vdev_create()
is only called from that path, arvif->is_created remains false and
arvif->ar remains NULL for the failed link.

The subsequent drv_change_sta_links() call reaches
ath12k_mac_op_change_sta_links(), which allocates an arsta and sets
ahsta->links_map |= BIT(link_id) for the broken link before checking
whether the link is ready. When the vdev was never created, only
station_add() is skipped, but the link remains in links_map.

Any subsequent operation iterating links_map and dereferencing arvif->ar
without a NULL check will crash. Two observed examples are NULL deref in
ath12k_mac_ml_station_remove() on disconnect and in ath12k_mac_op_set_key()
when wpa_supplicant installs PTK keys.

  BUG: Unable to handle kernel NULL pointer dereference at 0x00000000
  pc : ath12k_mac_station_post_remove+0x40/0xe8 [ath12k]
  Call trace:
   ath12k_mac_station_post_remove+0x40/0xe8 [ath12k]
   ath12k_mac_op_sta_state+0xb60/0x1720 [ath12k]
   drv_sta_state+0x100/0xbd8 [mac80211]
   __sta_info_destroy_part2+0x148/0x178 [mac80211]
   ieee80211_set_disassoc+0x500/0x678 [mac80211]

  BUG: Unable to handle kernel NULL pointer dereference at 0x00000000
  pc : ath12k_mac_op_set_key+0x1f8/0x2c0 [ath12k]
  Call trace:
   ath12k_mac_op_set_key+0x1f8/0x2c0 [ath12k]
   drv_set_key+0x70/0x100 [mac80211]
   ieee80211_key_enable_hw_accel+0x78/0x260 [mac80211]
   ieee80211_add_key+0x16c/0x2ac [mac80211]
   nl80211_new_key+0x138/0x280 [cfg80211]

Fix this by checking arvif->is_created before calling
ath12k_mac_alloc_assign_link_sta(). This prevents the broken link from
entering links_map, so all subsequent operations iterating the bitmap
are protected. The reliability of arvif->is_created across all error
paths is ensured by the preceding patch.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: a27fa6148dac ("wifi: ath12k: support change_sta_links() mac80211 op")
Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8f8456509468..529a693fdd28 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8045,16 +8045,16 @@ int ath12k_mac_op_change_sta_links(struct ieee80211_hw *hw,
 			continue;
 
 		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
-		arsta = ath12k_mac_alloc_assign_link_sta(ah, ahsta, ahvif, link_id);
+		if (!arvif || !arvif->is_created)
+			continue;
 
-		if (!arvif || !arsta) {
+		arsta = ath12k_mac_alloc_assign_link_sta(ah, ahsta, ahvif, link_id);
+		if (!arsta) {
 			ath12k_hw_warn(ah, "Failed to alloc/assign link sta");
 			continue;
 		}
 
 		ar = arvif->ar;
-		if (!ar)
-			continue;
 
 		ret = ath12k_mac_station_add(ar, arvif, arsta);
 		if (ret) {
-- 
2.34.1


