Return-Path: <linux-wireless+bounces-38944-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ouEzIhyUVGoInwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38944-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:30:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B6C748268
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:30:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=CoYD1SzI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DnimqVCZ;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38944-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38944-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 438483004934
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEAC38F926;
	Mon, 13 Jul 2026 07:30:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781D38E8DA
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927834; cv=none; b=dUWvZu6OiK5KTHlllJWH7v2seJdPxB7KScrIJ+90w2/X1vnhbvEXWNMUhR9VR4qjOev52Dpk2w0+2VSUfY+vbYhDflyrv4awT8+lyxKrgjG4HdjDZM1sr8NiFhVpqNebSotfKkVqsrpwIVTi+LifC5KV2s7ohstwQqRfaiyWp9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927834; c=relaxed/simple;
	bh=2o9y9Zi9OmwlQIIlWoLdNRV+GUZXbtrrxZklrrhkszo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaQbghmitr6KHeY7QOcyeJ2vmkm1zEB4CDg3s8XL+ADX1YLOggi/Ic2f0bT7X6rd1s1BmmKWOTGbR0HLOpohFZdwAjIvLutcev5XS3vKdS3zNWtVwhJz/0gn/Txdm4Cj4oFVWe+TQ6C6g0s/sTzh6Gi3lZpEgIoJESslGj9bTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CoYD1SzI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DnimqVCZ; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7KZ4f774574
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qRoN7bGojJCnIgc2vmQfLaoan0NtbsUh2lM4erLlpsk=; b=CoYD1SzI1JUkh9Zd
	65qshYtmOFHNZWFbFjI49bv2qskeMaPvhgma26vC+wPhVcBWGj9ZG4CDtwCpVoA2
	cmaxljfv9RhYsr/a1/aBZS4G1M8rC9oYYtJk3mu0f5HmvmhsOEpHPKFXu5QRUrdn
	xJ/bg3oRltILyi5HSWwC/kWEdd4fmZjQYxNUadCBI+HUZJQQXfyBE+GvFKWVpwyi
	IXoxuRfCNIr/SleN45uf26fjVGyIwNNGKR3j/uiIRnsh+UGniET02/ehvAzukOiY
	nQV7qkQKM8rWE5EXEwiNVl/ulCBijjnypHDI0RN2Uc4udvpKAgZLcQ9uAkQ+tzMB
	2k62Rg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcuj0014c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:31 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84859a64079so5319824b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783927831; x=1784532631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qRoN7bGojJCnIgc2vmQfLaoan0NtbsUh2lM4erLlpsk=;
        b=DnimqVCZyWcz65e5WLI7vcE1JzOeE3aIZgfnBtBWcZPZiay16I+ssCV1qGsnck95g5
         w5TkMOtqPQkVeURzAF8t1jfcgGOg5fD36toRM4qnvumrh9CBNgUIIrRFWKwbdLs9ImUH
         9ysgQcs47yhNkVpdGpIpYSDsWsDaHpOym5O+Noq5iLRdRWhwrqYsJyDjg/rqK+pRdUHI
         pyQmaY/w5PnmdrVcEi7h3DbXlltjQFexmIs1mmJGob8WgfjM6vNuvoJjoKEFC/9Q1sw4
         Yo+BXoIejS6Qqr8fQsiZ+feMNitrXYeoB7ENYRJv+62tpQ0VaYfM/qSC4ym3iUK4qN1+
         f03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927831; x=1784532631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRoN7bGojJCnIgc2vmQfLaoan0NtbsUh2lM4erLlpsk=;
        b=Ylmne/fCeQZTXCMf1o0yNQmu1ni9+twVk9ZdZfLFZpOKtomLPC0/u/mzLQ1yzydyfI
         KcJKRJMPuBebqStzOOHnEcj62zcxWY6DsjMywZi0ewG83Zrv+MDWfLVZK0Dv39sgtvIw
         K+BJvK8ACCzWHkE6uANlVBqd3TUZW+x+5GTiHVCcSEmLkkO3KQ8aVxxS9hAgfCsuI06h
         YZfr3sHtoY5aZ+DsNRix+aAkI1YdIgaeB/JLospjzvwEHKIpG8ENsMMPPP2x7yTi4/af
         4eg9SqD3wTY19qeywvfW7zrAu9yts666LUXLhTHkGwK0TBfdGs7uK75ZRSSYkGVfvE6B
         QVUA==
X-Gm-Message-State: AOJu0YzhIwFNWVOqwdAmaMkVZAJzQmhy7s/v49+3lYWpiFMKEM+/g8YV
	BBlo8Vz4wDsp6KIR55lIRP/YZ8A7O+JSCWy5V9MYtzUtsabmMGpY6ToFdG+IgNc8cPCTEEi9d+i
	DphwKz48m3BxIGBIA1O2RVBklRtmMiNaaJDJuTwlxzNzQQXOcO6Vkw1j1bl3LvQUahkSJFQ==
X-Gm-Gg: AfdE7ckWVluXJBOKnxAkwIUQYOkhu3DYPLoXyRoYRi2zW5rJVmNR+00mMLgL1aqrInW
	lKryHd6tYfu3ScBj4Rr++TN90LCvLJaJvxOJl2ZyUZZvAL2/G0N/QD34P03NNEIwg3YIfqG7Zl1
	XUmfPXEhMdztkVhz8eZwCl20WgoOSJ4Vt7/wpEIhq4mjDGyPCHHDkDssWnFblUWqdnVw3HQA4a1
	VzuCosq9ExVRq1wnPYXKJnuwrxjkyCeOR/lc0/YdS8LUNC7qlPwOJljTCyqGwmt/g15WEmSkeOM
	TVqg/1ii2P7XagvoLkIzrRa2vnc0hR41hDXqEmq/lyGO/p1h5CUgAvGf1P3sJDvZMN39nuZkBAk
	TqyEJ0lNr95vJGeLrXjSSizPgqEcYvOZnNzzKIXiALKVikerO3ol737HtxIbPjRu2
X-Received: by 2002:a05:6a00:2da5:b0:848:2f84:730 with SMTP id d2e1a72fcca58-848898e1844mr6789371b3a.67.1783927830695;
        Mon, 13 Jul 2026 00:30:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:2da5:b0:848:2f84:730 with SMTP id d2e1a72fcca58-848898e1844mr6789337b3a.67.1783927830213;
        Mon, 13 Jul 2026 00:30:30 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm7947252a12.19.2026.07.13.00.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:30:29 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:29:53 +0800
Subject: [PATCH ath-current v6 1/8] wifi: ath12k: fix out-of-bounds
 clear_bit in ath12k_mac_dp_peer_cleanup()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v6-1-20f6f212e413@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfXyaHnm+LeRA2n
 k18WfNaFl1tOnzzL2CdOtD1t/xxwnuJnaa07eulzm/mOufN3YsGz6F1U1I83aySSOoyozTN3b4n
 VaVLBZJeD4VtxCgvIKm+M+DO11YthX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX/9wLn5cBhaHB
 VROdcgbGHsH66PS6nTcsOy3Gp01r5eM2kXjBNMRAF928SEwrCEO3Uh/5gZO1pMahcALJ+MIxUpo
 7Uq1zr1BTPe5WXAqwHbbPi3bHh5EBFK8oHwbfe/Ds4uz1guEcVBSBoQ3UTVwxgrdp11RRUcEmH8
 Jxy/PxslqliJnbH7LZXZ3RLT+ESQLfmLis0tiXNtl7hjbHhCWWR67mizToe0PV3XFqanJq8dOaX
 8rgchsVvLzFIU2OBBct4HXNSdPua71ALC+4aUe0dvZlEaWMkqyBY2/yPwZWXto1p0cFNAIIT17U
 Z6we4i6uPy9W9OvcgMie+T2e/2KU2rU5dzqmLMIMyN0MeV8v36j7PhZVEp/266qvXO8/RNguDWV
 8E3oeJ1J8c7wSTaiHiqYutlwCIryVvzZsimleZI6UeGUfW1y5vakj+a1B4krk/ER/m8JtPSSiAP
 o+/2IfpOGPV0oJ3HMbQ==
X-Proofpoint-ORIG-GUID: 7CsN-Zalz7JHcAXnCBH7UxmAwo032yPU
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a549417 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=IU88uQVEuTzBCV0X16QA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 7CsN-Zalz7JHcAXnCBH7UxmAwo032yPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38944-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3B6C748268

ath12k_mac_dp_peer_cleanup() clears the ML peer ID slot on the
free_ml_peer_id_map bitmap by indexing it with dp_peer->peer_id. That is
wrong: dp_peer->peer_id for an MLO peer always carries the
ATH12K_PEER_ML_ID_VALID bit (BIT(13)), so clear_bit() is invoked with
index >= 0x2000, which is far outside the bitmap of ATH12K_MAX_MLO_PEERS
(256) bits and corrupts memory adjacent to ah->free_ml_peer_id_map. The
intended bitmap entry also never gets cleared, so subsequent
ath12k_peer_ml_alloc() calls eventually run out of IDs.

The ID without the VALID bit is what ath12k_peer_ml_alloc() returned and
is stored in ahsta->ml_peer_id. Use that instead.

While there, also reset ahsta->ml_peer_id to ATH12K_MLO_PEER_ID_INVALID so
the bitmap and ahsta->ml_peer_id stay in sync;

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: ee16dcf573d5 ("wifi: ath12k: Define ath12k_dp_peer structure & APIs for create & delete")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 490c134c1f29..b7eba8ea981b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1283,8 +1283,11 @@ void ath12k_mac_dp_peer_cleanup(struct ath12k_hw *ah)
 	spin_lock_bh(&dp_hw->peer_lock);
 	list_for_each_entry_safe(dp_peer, tmp, &dp_hw->dp_peers_list, list) {
 		if (dp_peer->is_mlo) {
+			struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(dp_peer->sta);
+
 			rcu_assign_pointer(dp_hw->dp_peers[dp_peer->peer_id], NULL);
-			clear_bit(dp_peer->peer_id, ah->free_ml_peer_id_map);
+			clear_bit(ahsta->ml_peer_id, ah->free_ml_peer_id_map);
+			ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
 		}
 
 		list_move(&dp_peer->list, &peers);

-- 
2.25.1


