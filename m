Return-Path: <linux-wireless+bounces-38876-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9Wt/ChNiUmqNPAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38876-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 17:32:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E35741FF2
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 17:32:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bkIYzITz;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="RYnMHv/Z";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38876-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38876-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5AB53009FA7
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259A3222582;
	Sat, 11 Jul 2026 15:31:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEFE2BE7BA
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 15:31:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783877; cv=none; b=JhfBSCRxXtDtUo8E1tCqNIUif6SsLo3bxOPXI0vF2hsxQhVoX56YvtUFIANkWosV+oIH2MzbRZ/a2IsouQaY8IfyaElY8hGtskC2zCv1i/auuYrDLBdmlq1gjsUHBJrBENroZrsrXMTDuEvhcZghrlxx/em8cAd19ZGs5I8Ni5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783877; c=relaxed/simple;
	bh=hiDsvgvDxZ/XYYBO1PehN4FpXxld0pkUuk/b4fY8VZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uLUGa1iDGPhQ+5pNwJHzKqjXUraMh69dbueFMIq8JBAzDKGBqJioMFmwu9/FeYqCh9c1GRrNOFY4d6dIH8ntB5l+8WnyG3svYF0D5kftnTwhkAZBsO6fcukVLfA8ENUZPnwNzP8KbcdODKFy4PIz6TrZgEGRH2sWz6mDHUTCodg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bkIYzITz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RYnMHv/Z; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BEO31r3947239
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 15:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9VA3RYDnEanCBIXzD9RQ33
	8HU/KiXn5kJsmKUAiyXtg=; b=bkIYzITz/SZk2s23M5FWnbefAFvi1huGYX1OTz
	OMj8YKnSkmkxV0kpuPrIKIHRvjXl79kE03qrKnN3jjIx1wLhRA2+TuROay4fRIt5
	GjsynZgqNrV5Eal4qzFW67sXgcrE5Y/g6Mg27Z9zVvre180/oSUY4GwPl16TCMAw
	J+vBE1oWdf6/q7RtYKIiYHLrerGTD3rjIxp9jcvoL0/S3X+i/dIVUHzl1qx0TpLV
	1Fq/o/lbkGO3cFOuxMQZ8ZqLALsdSzDNMtvNipbarwhlfhieZV3pYFV2IKw4C08Y
	Rz04Cd1FPmyG/BPgLuh81NiRjOLay+gGyg5p6srsFcw1/usQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf480yg7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 15:31:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-381250979d5so2109246a91.0
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783783874; x=1784388674; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9VA3RYDnEanCBIXzD9RQ338HU/KiXn5kJsmKUAiyXtg=;
        b=RYnMHv/ZD4q5ZE+7ooYaVQbO0Cn8xycUgSjVB8C0HAJIFdrusPSzC0DIY2Nvirj3Po
         o9KMUNK/yjjCDiw8yLTMKsby8Qy2rNSEDKYBfw8npN9PqS57K9K/wQuCrUYxYSmvgmAl
         2WOhOKm5xZAwk+GFJwnWppA2XSR5jai/rMF0R1Mu4PKMpVjeVZs5w0sULxjl0NMOO82m
         9jd6Pdx9CdgH4cAoPibdrkIoaAGnKM98zwHQnSIGmOQUXqXshdrVMQ2vBL0PBCZMqyKy
         lvakQPBuYMXp7hIJ5EFcXXF5oUQ4No3S+5IeEGaGuEjDWehALujl1B9jzixGA0i/Hg0R
         ZG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783874; x=1784388674;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9VA3RYDnEanCBIXzD9RQ338HU/KiXn5kJsmKUAiyXtg=;
        b=rLU5lXPp6rAW+LacsuaafRJy2BnwGFuStr/ZZTXTBtvYedyC9D3kP92KAO/HVP7iXL
         cRJohlRnYs+eemQhlwnxXK3j5duPKTVQi0nmzl3RlvxqU188Jae0F4BKTecslaMhXrmc
         X89h1UywN7ObYb+gP0GUIb9ZYtmbnK1/pm4umzx/WXlWHUEL8FE7kdTPSXKA2Zuf2N8/
         08U7GUQFxRO/PHgFyhdio8/0SH58Dv6nb4Djw5mlddm2wm5UCHS9ha8En106ce/4Yg3J
         cTdRDV+GqgxaQSNAsgiuIfavMHhKXaAv0nzTw5fbcu/HXKVdIt+DFn+MI7DYVvFdh+v3
         W08g==
X-Gm-Message-State: AOJu0YytT2u5FpyCiymreE4A/lx6LP8/4SQmXvKZwN2l/RTufUWZiNMh
	09FZ+mpmFX1bDLYaLe0pT5za1p6A98I8jp6nxMHGSUYUKaWPqtINiPxU2gXpmgLUBOwkAiwu6zn
	qnAYJWznt43EhgHZH64SvDYTwJYtaNQ2wZLQF3hjVHg4WUVsNlzbnoazcFOmkqEaWr7UCsA==
X-Gm-Gg: AfdE7clVJcRiKEjM6lrIyuo95f+CVwYl1J6IC2jC+L2oeZUmu9303Bkuda37SkT2LuQ
	mFJzNeTF2005GC1Ags9cyZHwMtFH1vPeSW2qQyvYIu49hyWb+UeMybInEfxFQWZcVpZsdB6jH/P
	zrI1NeB4fcgYKQWzJtNAAKN4TqiLo5kbWttRdP1xThCUYn5QRyyDDZNUEZScjhuHvLVIy2/GUnM
	P0staCkh0+wi8cRLvnJbCtp83+jtj+OuncCQUVA4vlo3001svwYsq6RfIGlXQrrON9IVshy/D+O
	SPBxBZF6QuihR+XrntTZEwgaDfJT1qvcm9N4oKgbaDhiL43cP3O1xLIMNw4GUgV5QRr3rk92Hey
	jMcBDfgZiXuYTAY3+mJxVH2lT82VcY5j0vw3HtXR49Z+K5uG5h7bBgBWgWy08d5mg8Q==
X-Received: by 2002:a17:90b:3c85:b0:387:e0db:bc2c with SMTP id 98e67ed59e1d1-38dc7ba2ab1mr3720612a91.34.1783783874313;
        Sat, 11 Jul 2026 08:31:14 -0700 (PDT)
X-Received: by 2002:a17:90b:3c85:b0:387:e0db:bc2c with SMTP id 98e67ed59e1d1-38dc7ba2ab1mr3720563a91.34.1783783873804;
        Sat, 11 Jul 2026 08:31:13 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm34111533eec.24.2026.07.11.08.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:31:12 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 08:31:10 -0700
Subject: [PATCH ath-next] wifi: ath12k: Fix ath12k_wifi7_mac_op_tx() style
 issues
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-ath12k_wifi7_mac_op_tx-line-length-v1-1-10e4899b98ef@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAL1hUmoC/5WNQQqDMBREryJ/3UiiqWJXvUeREONXP9XEmtRax
 Ls3eINuBh7DzNvB40Lo4ZbssOBKnpyNIC4JmEHbHhm1kSHjWcFLnjMdBpE91Yc6KtWkjXKzChs
 bySIb0fZhYC1KbKuik2WVQTyaF+xoOyUPiHtmcQtQx2YgH9zyPe2rOPt/RKtggnHZXGVhuGlyf
 Xfep6+3Ho2bpjQG1Mdx/AAf6PuG5QAAAA==
X-Change-ID: 20260703-ath12k_wifi7_mac_op_tx-line-length-de4ed96f4792
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE1NSBTYWx0ZWRfX2own0EJQup5Z
 QixxnkTKN89O4n3ytYjmXP4kfS35GcLqxJlrtwL2R7aQKV4t+kJCy+8khp/oXQYnQCVD/36WMjJ
 d9SyRjY10vIn4fXyAXPCtTLWv4AdYf4=
X-Authority-Analysis: v=2.4 cv=OsJ/DS/t c=1 sm=1 tr=0 ts=6a5261c3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=oPDdWr2l-k5Rtjfzfx4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE1NSBTYWx0ZWRfXwlhN5uI/qhmD
 jncvI5ypYh8YE0SOjJ57nkkO+6EmVivjUgQ9B/eyttL+lV5wY3xkinS/Va4tZXPyYh04d9dCp+e
 pJtU2IIWvuQdEFoFUgA3Ezd/yDBdQvJvWwUB8r0Ks7Hzip9pK4D46uioyqV6XVyWGdtaMsKa2/e
 abzcFYFfx2+eohUf2jyBmD1BDTxreMQhOmht+VEczo+FcUQlz3GrhYKeF+O+wceTD/NdHojbyxQ
 c2E3apGWbxAq7QACkAys3iuwWTgTnnNtt6dlccna0kiDgz+QQJUfstKgPaSH3qVYUfSMwHVjDXz
 vpkhyU6FFQu4JILMA2S+hnltd4RzFnKSXuc7lakv+rUFcgAJX+RJxtbafwe6hCYwX/YkgmO7PxY
 Gzg7mJyMGkIa8ZioybePlM3qNl+1gc1K23e8TzUx8CxnJGDTLOGn5lbmJs5uDKzkUJ/78QG1qb2
 yF5OQYxM15SXlIj7U3g==
X-Proofpoint-GUID: pMFHGFOauIkvaiV18tWfY0gHEgJEwmFb
X-Proofpoint-ORIG-GUID: pMFHGFOauIkvaiV18tWfY0gHEgJEwmFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110155
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38876-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72E35741FF2

Commit e47d6c9bb416 ("wifi: ath12k: Advertise multicast Ethernet
encapsulation offload support") introduced a few style issues.

ath12k-check reports:
drivers/net/wireless/ath/ath12k/wifi7/hw.c:1042: line length of 92 exceeds 90 columns

And automated review did not like one if/else that did not use braces
for a single statement that also included a block comment.

Fix these issues.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index e5bf9d218104..d54c2a6d83b2 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -1031,18 +1031,22 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 
 			if (cb_flags & ATH12K_SKB_HW_80211_ENCAP) {
 				/*
-				 * skb->data may be modified for the iova_mask devices.
-				 * It is better to use skb_copy() for such devices
-				 * to avoid any potential skb corruption related issues.
+				 * skb->data may be modified for the
+				 * iova_mask devices. It is better to
+				 * use skb_copy() for such devices to
+				 * avoid any potential skb corruption
+				 * related issues.
 				 */
-				if (tmp_dp->hw_params->iova_mask)
+				if (tmp_dp->hw_params->iova_mask) {
 					msdu_copied = skb_copy(skb, GFP_ATOMIC);
-				else
+				} else {
 					/*
-					 * ath12k_wifi7_dp_tx() should treat cloned HW-encap
-					 * Ethernet multicast frames as read-only.
+					 * ath12k_wifi7_dp_tx() should
+					 * treat cloned HW-encap Ethernet
+					 * multicast frames as read-only.
 					 */
 					msdu_copied = skb_clone(skb, GFP_ATOMIC);
+				}
 				if (!msdu_copied) {
 					ath12k_err(ar->ab,
 						   "skb copy/clone failure link_id 0x%X vdevid 0x%X\n",

---
base-commit: fa1b1469f1c5f0f54ed9dab80106a117e7736bfd
change-id: 20260703-ath12k_wifi7_mac_op_tx-line-length-de4ed96f4792


