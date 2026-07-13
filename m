Return-Path: <linux-wireless+bounces-38955-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x64HCgGVVGpenwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38955-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:34:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C434748329
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:34:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=cbNVdvkA;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BjoZB0jy;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38955-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38955-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81ADD3028C8B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C63905E3;
	Mon, 13 Jul 2026 07:33:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B738F230
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928027; cv=none; b=ZhBc3PGsJAuH5YzjoIYjoe6DkLa9k6TokzwL/mnZnBKj81G3jKw7wXwBQF96ilK8nIEuW1RGJDQOQ/zC4Ju0vmSdJ+ge9KqUPgZbxBZ+Fbot1zEOhybZMx+dHNO+XSNgYy2i2Yn5TWlPzskc/KdcFYalzd/QnGv8iyblwplccgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928027; c=relaxed/simple;
	bh=TeZaYIoVp+JA3pXQ2eLqBzhtk+TLvNQeHVX627eTnNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZCiFc5oRyV8c9bf26PTxT0E9vtpB93TqZqKKZnI45eIP9u7gXK3wsPJNV5fShl0Amfck6ltOm5nZ8I/VJrDCz7bAOuYQ47qwJS4ICOXRD7AGo3/30FAgmM5Q8XpnbsTS1IvWgEi2IBHkIICh12cwoSmmUN/zEtIa4xZFr3hYWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cbNVdvkA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BjoZB0jy; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NxN5648719
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MHqVBdkvTS9RGcZbYw3ny3/a6eyNFEqIY0DGCMDX0qc=; b=cbNVdvkAUEjBNEwh
	IeuJBP8QuSZaeVi3jKFaYwbpYpNIS4BTns9OKxsMbtvCT6CfMQGRh7+QD8JaIbbX
	7qHcUsM2TUDsE/zaHE2kHGqnDbGp7NwtnEOl6rPgMWbho+jQJFAJZFkNeWhlBV71
	u11PxtSk3FfaQSusnOqrnUobIHVSomxACE3tRh4L8x51N0Kx/VlSvJSUWQOY3/Oh
	1ploYdilKTZk/A8omdrlSapl6dValW9XFwddTYsCcDjxjofI7wc2MUMkiirmqtR/
	bqOPR5ANK5vuavNBnBlLj4IFaR/2+qCJhaWZlYRbU2he3j6kwbqjWbDvfG0i5Vj4
	dXkoag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr4vj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cccfa32670so40435785ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783928024; x=1784532824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MHqVBdkvTS9RGcZbYw3ny3/a6eyNFEqIY0DGCMDX0qc=;
        b=BjoZB0jycdsPfUoc8hW8lpks2BuW2IszR21UZLGZ35lP+Fe8ItcJiagqlPH7Qx2pR7
         JYD5wNVkC3VsRMFCiWNQPiB58w6dXV7/mPgCqBZdKA76dSDWScJ1kcYIYMtdmjbtLA/M
         PElP+6xq5/k59oJZmyw2yGUDZkf3B+KfqgBCbDNXCGGRKT1CXA3ZwBRHbAHxAqufJ1+C
         vACuzGl48eNxhOP5YcqgqT1XVLGrGYJud+KwaoViNl0hkHhsqd9D900stlQvGNUcxC1L
         KkNFBujGxYzKiaFqvWMFC0hgfPI93fe+V7kAUFqJv3YaE6m9KP3fcGu73JnlTAh98sta
         soMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928024; x=1784532824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHqVBdkvTS9RGcZbYw3ny3/a6eyNFEqIY0DGCMDX0qc=;
        b=CUSDmapo/Fq6XngufY12RtOwst4Up5iHsK6JLiCBO1JsOsBfVtrRcNI3PW/cIuIeUW
         yLdfMsZYCNiXhc2KovO4I0ZYJTgx9NgNQmzNCmQj51pVxW8Gg+WpA57ijgUKBYZVnIOY
         dEXhkEAFfrgBfPS4SRQcDLfKollY7ppXBzjFyPaO+hwHmqZvRpLedBh1S9AXeW6f/+pG
         NWh6uoYxw5ElnnrXz3K3BDgNbQMZS8+aIyawhOH/TGNUGU884bMCsiZ/cmdNI0U366zu
         H5Ui66VrnLW/bdMxW45PIViMbh7CzpF40yN0Fu7fKsmINgBpX5ToPs0vm/oZf0zUv2Zq
         tRRA==
X-Gm-Message-State: AOJu0YwtAkvnSZHgduYpfjebgUmXM1FimuK8x9abOlAwVa9GMT8vx3zA
	Eb96M5h48d/fanUUHd3653Qnv97+UW6j6fARMozhISoyJCk5aen9lp+GTr0F6jJB/E4Piwf9nLl
	UFOAl+6mFZtMMSJillPQNeGeVc3Z+OlDPsFNfQMQzXOYugCo7AerhVMV29Sf7KDhjXDNbLA==
X-Gm-Gg: AfdE7cmB1S0jaiAUi8bmUqk6pdbmPo5wi/Y26puoFhgl4bI0Vv0mnE1E2Nvbz8nEc7V
	UlcMOLz+rEW7U/Sz1l65AD5XwM7DJT3D6mCzK+dOJPCXZ7Csq+CgiKR5LdEVAfauuORHxL0eJyd
	50rlF0mWCUV36NPd1OxX4MgLA2HZ+Ei6KF5U9xXipfyNZI8F4jcqUONZ2vHicl0jyqGh5kpPBeN
	icwhhGdbbw5KKnCyA5et1Y/tquExVIRwecr+ijAs0FGC3FQbpmSUQEH3Nu80fWsbonkIuJQ7Qnr
	T3J1bqq57Wm0TeahsrXj4CqcI54f3VcKC2J/8bATR6uywnrPxhVJinRh5ZDkPmrd4H7BtlNtmZn
	LcfMEFVyqMOX0nkAvbFQaj6f7QtrznvbueVtPa5hxvC75nboxPlZ/drljq/Il59ri
X-Received: by 2002:a17:903:2f83:b0:2ca:b8d:e65e with SMTP id d9443c01a7336-2ce9f15c5fdmr80618895ad.37.1783928023952;
        Mon, 13 Jul 2026 00:33:43 -0700 (PDT)
X-Received: by 2002:a17:903:2f83:b0:2ca:b8d:e65e with SMTP id d9443c01a7336-2ce9f15c5fdmr80618635ad.37.1783928023341;
        Mon, 13 Jul 2026 00:33:43 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb72fsm95073615ad.6.2026.07.13.00.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:33:42 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:33:17 +0800
Subject: [PATCH ath-current 2/8] wifi: ath12k: factor out peer assoc
 send-and-wait into a helper
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v1-2-d0a2a1a519eb@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfX7n+aL5SrX7j+
 PneYFs3lzD+xms5zl+ADlmvdio38YciGPua6e8sfd4jUAbUCPqwOBmJlHaDxg5kn67ez+GjDApQ
 wpX9avso6ccT3+gY4bBfkBKg8iso4+0=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a5494d8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pIzPn9nKbmV5hhrGKQQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 1wvBp8eTw8FhG-i94znUFTVoaypB3OTn
X-Proofpoint-ORIG-GUID: 1wvBp8eTw8FhG-i94znUFTVoaypB3OTn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfX67e+AB+trdYE
 iEJQahBNM0TlCJYOCXzzJ8lTAgYveUX9IXUsM8mUNIpbs8rYswuoB6IMxySfVCr5z4hiXHMEdq0
 HRzKmM3mv/5L3u0HVJ9Y04Cg5RYxIo2xJE6NUoQ3EoXNqBEoD8x8qBG8kp9GMTe3ulk0rYGjHGO
 hpKl7KQTgW1xX08BlEmwp5qHX8MEPu1G5qjztjzkfWN1q0etSDrHdqckd5RzKNN6x/MT7bQQckm
 OEEg4puSiyC7mlkftaS9KWz+4UoW2qevR7cLT2DrTiYSBQyu2f35+fXy9Bh9PF8DzreWZk6pFAP
 2ITLdX36fZ0YBJ1S2AcgPiYwJwG4nta9Q7VMYKN7OEsjDcFPvUFFyiRwctUiM4zgX0gVKjEovMz
 GpAYkADF5FrWs2FvIjn6DLgnU0HbjRohCp/6qz4xvkLFKh7RlorPD/aLsudbVeisEEnJXW2Mmmt
 o9lcrCW31KLLL3FsITA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38955-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C434748329

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


