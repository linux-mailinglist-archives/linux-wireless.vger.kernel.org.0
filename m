Return-Path: <linux-wireless+bounces-38945-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vCtYN2uVVGpynwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38945-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:36:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5780F748375
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:36:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LCYlIHNc;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="C/Dwy7FF";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38945-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38945-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5B5E300BDB3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8E638F95E;
	Mon, 13 Jul 2026 07:30:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B022038F925
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927837; cv=none; b=MwuSNDRlvnIMPV9ghgmB9U7chwo7ltLBGlbEJpz/6yY9Hsg2h4GY88Dgf07M/ltIzFWbIwMQxI70kU/b4CroatCR25BQpRzacUhHNn0mY1+RVJzqfK1fVyqLVzfd0OpjBEhXgHVXZRlkQfIGUs4MKUxHLCIPwkT7+gQnsGrUmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927837; c=relaxed/simple;
	bh=TeZaYIoVp+JA3pXQ2eLqBzhtk+TLvNQeHVX627eTnNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PIhYYVRATqO1EXrGlypc4wwh6sXfU1em7CcNpxj1E9ctL6vDWnZsKqZq034sK3A9iTSPt9m/muBzRI42xm4ZSfkPT5IaNZTaMvmw1/v6NFpJGsXGRmPvrn9Dv1RLwshkisrz65FMOZHrsqC0fn6atUEVPY2prSDjzHw6A74E9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LCYlIHNc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C/Dwy7FF; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6O0H7674537
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MHqVBdkvTS9RGcZbYw3ny3/a6eyNFEqIY0DGCMDX0qc=; b=LCYlIHNcyydq3vdI
	MR2zmAEaG0+UrIEfnTvXW/PB3Vy4AcbWEQguNvgp+r0u8YPi7+vTlTNTrdhgNutt
	8bdoMxIaB0MTq5cjc8ulQ+vpk1/pppDmU/GPXO0ZoILA2RIeITCu2iA+wO2j/73p
	T10ERJlBPWjltF35oCWQgHjH1X5tuQeAuoTddvDUQppx2Byc2hBr6KgAurFEQn7r
	K//5WQ/VM4o0bh1c2RTY+OD66xE9gTH+Ym50jz38hRJa7syzpCkR+XSl+x6KB/Ik
	5NF6t2YlrzeX6wSJf7vGlQD7o6mMuiZlf7Lou9vuvJVu0et2JeLhWo6zveLMElb0
	BrsKBA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbecgn0ft-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:34 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8895156101so1589814a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783927834; x=1784532634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MHqVBdkvTS9RGcZbYw3ny3/a6eyNFEqIY0DGCMDX0qc=;
        b=C/Dwy7FFFulwzM2ZjMYofRepXnXdUFtCCsFhUE0Dh4CWGel0jZPQmhe4nYijgL7KxL
         8Qme46mtnqHIz3w3op0gk2RJ3C1o/31PAU0v1FH5uR9KMiLYc6fVTnl7kAspwhpBtmyV
         3YB5+dHbEtPhAHm7f7UCX/JC3nHe/r9ocDZsHCEH9QsSYvM8cqtAPfJewoWgBBKV7Pnh
         vTT8Tmtk1vtUgxl4QG5hjH1YGoyJu7pYYBJEnRvNRtX+3ftz3DjSqCqTbPJJedzJAOQs
         PINBch0iYoQKW9lOgDb9rEAmL3br1TajaJ0CKkshi1P9O3o9yJxl7RAGVSSHVj6Z6PWE
         Lq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927834; x=1784532634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHqVBdkvTS9RGcZbYw3ny3/a6eyNFEqIY0DGCMDX0qc=;
        b=nDR4fRpj1iOUKtEh/+nW2AaJxg3nYmESJQIpOqMyzsHGmXPLnS4Hg4WSudpnFXNX4f
         kPZkYX/FUfFw8pALKAw4tTZWdflGKk3Ju4aiLKNB5Ti5/jonrIbYYmBmnXRinhCpvaFU
         RtAZXN+xYhfr7WWKszJCjvNFn717j5B0q1Q/YtBAmQYCdmEhecUdrSjEQxXiuc8mjaTb
         Wm+ckgoJtF5bHA/vL79mx289XssTlyM7ExnPytAZ7VLN/bgI5+ll1O6Yn9K+uHS2Isd7
         k/k3+wW6HDR1EoKtVH60Y3N+jJtPkCXMfWRxyEGI3FMHIjJkoqcV5XqHgWYv3Vlm1XZK
         mTRQ==
X-Gm-Message-State: AOJu0Yw19kTu1+k9WuSHoA5Nh9V9yp3lbbbWx0hUXBDe4YQ5r01Gyrpr
	J5lB5HeUNS0WojCB6C5jJjf3kMNjpofG0bUczqpN9yeuNCBpBugknY6ZahjwL421ndMOzrfoeSc
	a9ovQmKAsG2GrnZz6FOgnMK0zp7p1+06p9wof4uiEeH2QL5n0B8m2vBkFre35Aba/SSQX3g==
X-Gm-Gg: AfdE7cmZ6SIOaxVmuY0dxjrSaQ4R7AcacWL7JJ17Mogy89ZyAVhnETm/CjE9+DqxO35
	LXhe2xyPY71uab/lI8e4YlA4bs/n9/fAQgrA+5NuV8xmXGlbXOxWGTgfhS2dpbulNZzVc9jYEDo
	mScoq0kQYmwPMmgFG4dA83x4Nx4ZJiumgiU0xl8TRLShH6XdYFzVaLNUyfEDMnDM5ZbwOb4H4hV
	nVo91uNVZhJck7hzhlOUESacMLTnYU4+/eLUyw0ehqmIEJEdJEIUKlKo/9Bvl666FkwfIQSakH/
	EaFxtvr2BJQ+qE582jc4asCduvVh8gRhqkftKOnx2Ktb9S0rBSK9CKv2/P26jIEA0YH+rEbuFP/
	UYgSQXHI00M4chGuvYkvyBAiFK+kPmH+43UGI5rrHs7+xU+8NJiQe8VH4l3DvZKcB
X-Received: by 2002:a05:6a21:7a43:b0:3c0:9c19:65b4 with SMTP id adf61e73a8af0-3c110a7b347mr8961895637.76.1783927833673;
        Mon, 13 Jul 2026 00:30:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a43:b0:3c0:9c19:65b4 with SMTP id adf61e73a8af0-3c110a7b347mr8961872637.76.1783927833257;
        Mon, 13 Jul 2026 00:30:33 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm7947252a12.19.2026.07.13.00.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:30:31 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:29:54 +0800
Subject: [PATCH ath-current v6 2/8] wifi: ath12k: factor out peer assoc
 send-and-wait into a helper
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v6-2-20f6f212e413@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX3D8P6pPttoxr
 TOim+84VtopV5bdSj3Xeigr51LejRnz/mQws/xCmVrmERxcg5JRNNBtSiF5XZax20aG851Yvkpt
 uN0/wUqBM7LynYc1OVCTjc+6u/gHrRc=
X-Proofpoint-ORIG-GUID: PkU9FxPyrvz3nazcO27_2Id8G-Ox0yZ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfXyYw07gCmeT61
 zTOezvePlBQVMRKFKMb6zHrYwY+XLcxuwToXS9NPni9PjEQO12KymrVeDYA0zOgx+nFA0ehJomc
 5MfYuoCf5K5O4SqWLGTg6sx/bt85Y1MccYav7HkLBsPufBRNaISq9syGhITUIZ3S6GQEGYDKkl8
 lS/MzD6D97ll8I1gMrmLFLqcrDjPXmN/ZMD997zBJ1sgxvqkeapagrX4izzG1DJGcyE28KK5osM
 ANdQruIqRCT6TiwO0kgae6VtX8p2/tPrmyznZMUPlsQvjWWINwJiMkYZ7lasYVHj3/wxR8GvucF
 CfvDF7IwlRl6Oyo3v1UuXGTpCPLgMZhbWIG4bXIRlQiDXeiT61XlVRSM67epktj5hy54GlyF0fV
 PSIOqPX81tcGkn4Yb13de0thTzyg5JrcE5gCKcd0fNYFnRwSmKG28G6LLxBalIHUSTAglEWwlQK
 2GagPdx1YLrrcuVmMSw==
X-Proofpoint-GUID: PkU9FxPyrvz3nazcO27_2Id8G-Ox0yZ6
X-Authority-Analysis: v=2.4 cv=KM9qylFo c=1 sm=1 tr=0 ts=6a54941a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pIzPn9nKbmV5hhrGKQQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38945-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5780F748375

ath12k_bss_assoc(), ath12k_mac_station_assoc() and
ath12k_sta_rc_update_wk() all open-code the same sequence: reinit the
peer_assoc_done completion, send the peer assoc WMI command, then wait
for the firmware confirmation event. The reinit_completion() was buried
in ath12k_peer_assoc_prepare(), far from the wait_for_completion_timeout()
that consumes it, making the reinit/send/wait sequence hard to follow,
and the three open-coded copies are easy to get out of sync.

Move the sequence into a new helper ath12k_mac_peer_assoc() and call it
from all three sites. The reinit, send and wait now live together so the
completion's lifecycle is easy to read.

While at it, ath12k_sta_rc_update_wk() previously warned but still
waited the full timeout when the peer assoc command failed to send. Now
a send failure returns immediately and skips the pointless 1 second
wait, matching the other two callers.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 59 +++++++++++++++++------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b7eba8ea981b..3e3b06e15f80 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3594,8 +3594,6 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 
 	memset(arg, 0, sizeof(*arg));
 
-	reinit_completion(&ar->peer_assoc_done);
-
 	arg->peer_new_assoc = !reassoc;
 	ath12k_peer_assoc_h_basic(ar, arvif, arsta, arg);
 	ath12k_peer_assoc_h_crypto(ar, arvif, arsta, arg);
@@ -3835,6 +3833,29 @@ static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
 	return bw;
 }
 
+static int ath12k_mac_peer_assoc(struct ath12k *ar,
+				 struct ath12k_wmi_peer_assoc_arg *peer_arg)
+{
+	int ret;
+
+	reinit_completion(&ar->peer_assoc_done);
+
+	ret = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to run peer assoc for %pM vdev %i: %d\n",
+			    peer_arg->peer_mac, peer_arg->vdev_id, ret);
+		return ret;
+	}
+
+	if (!wait_for_completion_timeout(&ar->peer_assoc_done, 1 * HZ)) {
+		ath12k_warn(ar->ab, "failed to get peer assoc conf event for %pM vdev %i\n",
+			    peer_arg->peer_mac, peer_arg->vdev_id);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static void ath12k_bss_assoc(struct ath12k *ar,
 			     struct ath12k_link_vif *arvif,
 			     struct ieee80211_bss_conf *bss_conf)
@@ -3915,18 +3936,10 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	}
 
 	peer_arg->is_assoc = true;
-	ret = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
-	if (ret) {
-		ath12k_warn(ar->ab, "failed to run peer assoc for %pM vdev %i: %d\n",
-			    bss_conf->bssid, arvif->vdev_id, ret);
-		return;
-	}
 
-	if (!wait_for_completion_timeout(&ar->peer_assoc_done, 1 * HZ)) {
-		ath12k_warn(ar->ab, "failed to get peer assoc conf event for %pM vdev %i\n",
-			    bss_conf->bssid, arvif->vdev_id);
+	ret = ath12k_mac_peer_assoc(ar, peer_arg);
+	if (ret)
 		return;
-	}
 
 	ret = ath12k_setup_peer_smps(ar, arvif, bss_conf->bssid,
 				     &link_sta->ht_cap, &link_sta->he_6ghz_capa);
@@ -6480,18 +6493,10 @@ static int ath12k_mac_station_assoc(struct ath12k *ar,
 	}
 
 	peer_arg->is_assoc = true;
-	ret = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
-	if (ret) {
-		ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
-			    arsta->addr, arvif->vdev_id, ret);
-		return ret;
-	}
 
-	if (!wait_for_completion_timeout(&ar->peer_assoc_done, 1 * HZ)) {
-		ath12k_warn(ar->ab, "failed to get peer assoc conf event for %pM vdev %i\n",
-			    arsta->addr, arvif->vdev_id);
-		return -ETIMEDOUT;
-	}
+	ret = ath12k_mac_peer_assoc(ar, peer_arg);
+	if (ret)
+		return ret;
 
 	num_vht_rates = ath12k_mac_bitrate_mask_num_vht_rates(ar, band, mask);
 	num_he_rates = ath12k_mac_bitrate_mask_num_he_rates(ar, band, mask);
@@ -6840,14 +6845,8 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 						  peer_arg, true);
 
 			peer_arg->is_assoc = false;
-			err = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
-			if (err)
-				ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
-					    arsta->addr, arvif->vdev_id, err);
 
-			if (!wait_for_completion_timeout(&ar->peer_assoc_done, 1 * HZ))
-				ath12k_warn(ar->ab, "failed to get peer assoc conf event for %pM vdev %i\n",
-					    arsta->addr, arvif->vdev_id);
+			ath12k_mac_peer_assoc(ar, peer_arg);
 		}
 	}
 }

-- 
2.25.1


