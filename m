Return-Path: <linux-wireless+bounces-38958-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lbUqMCyVVGplnwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38958-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:35:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924A748347
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:35:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=IE5WFS+B;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VXerbsmy;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38958-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38958-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C34830344D2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3E538F947;
	Mon, 13 Jul 2026 07:33:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB739023F
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928033; cv=none; b=A5rWB3JbsIQcysaVoOi3M9ofeJfn9iWbNaDefGZobk6e4Ov1y/cBL0DNxz9GwXt/lwdsOQArGVqbeCUs6xBle6EQcUuXTp2LTqJIfQ4ZTYp5VDLrZFcKxNoYbhyQaLOTdEfcyH2w14esbPHa/blZH7Qsu3OD76YCiVpwg7KLo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928033; c=relaxed/simple;
	bh=A+/sx+ytQ4G8yq4U68WgobXipHkg5atz+C/gynH1CTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tciFrpoinhBY0V3/h/YC4pr4C5T1DA0ITLAPpaqv1zWagw64wjBXONfYJYVgMrj0M23TLZ+RG37FNq2RWe2H4abaArBQdqJuMxPX1MsFvuLc7sn6nHxlIkOcO1FhI5MPFDOFGQSBQHp2x2+W8xo7GwhMupCQIH0o61fCACdp2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IE5WFS+B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VXerbsmy; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Ne99731611
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cSkM2sZ6NfRboh9TdbBfSTlyiPdbQTQESCI/5cewzIE=; b=IE5WFS+Bwkano6D/
	nLrYC/tA3dUoexvW18WnK6yYkFXe1nj/+xLDBjrTE5/dxFqnPsEF3fXmYEct/lF8
	RMOzEEYmms3ZTwTrIumA6KfMfkc7hxly/Xs/ZHN6oL80xFyzKu2jS6u2kccSrtYQ
	k9UrHqL/+wTL5zT1+eDb1/vzmROtda+up+RXjlb8Ks1bvjqqC+KmYolI9JI8r8Or
	mIs4XxvNrGT2QB48ACm3mnfyFrOWHh8nBvtzG73cKVxJkXltXjpIw8aorhr6E6Ux
	SNsoOMrT23oG+nXV7PkTqjr0Kx1utE9C20Is52sNTHRBXioM9gv7eCnfxTklGluR
	dLZTgA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn39drx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc88e22f92so59778415ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783928031; x=1784532831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cSkM2sZ6NfRboh9TdbBfSTlyiPdbQTQESCI/5cewzIE=;
        b=VXerbsmyfriesgrsOwm4VXX7wJ/gRy6mz1XseftqjlR3o4BecP7/DRMo/GqejI4LKP
         ORgrw+Nc1tdBvDL2qt12464oGR9vYNTzg5RzvJ2xJRolOWuy/763Ic2LrAAJmJnTLlQE
         Ch95Ho6dB4OoaIGRncJC3d5kKUOuQaC/uPgtybwYdOOJqMuSGsEcWhnW2F9hpLjwRv/n
         RulGfw1lMVVaCXTHi0y9LW1jjgzIpQcELlF7FYg+Djcrisuc6ETkIAS4xlFnvrrKZ90i
         HHkTU2qMFjGWpWJKeKWOD0XLHivSVo8o2RNk0rcJhdD1Xdj0zq0gwNVUouCFbnvA/Gb0
         kpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928031; x=1784532831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSkM2sZ6NfRboh9TdbBfSTlyiPdbQTQESCI/5cewzIE=;
        b=V67mnxWu3dN/tiFM02V4kCDGN03AsJc/BNh92ODkXEtSL51UEy9gT0TGNGctA8XGHe
         mW6TYui3QDRLrDSZszhPV0h5TOM/9B9X4o909F356NzPXtzD+s22K934/LY+3y8xeFNr
         xXq3K7pdGiPIYrXxPcYg7QJiAjvs85KCmlyK0f/cKVa5gRc/tUr6ADAgs0aK6T6nfib+
         js6wsvwjsgwYOX1sU/97hMymzZw9UU/u3QbwRUCdFm6BWqhw4NZhW5KRLi+T2Fzj/vfv
         w2chRM9h2KJenL1HukdJBasVIC8OLowit7fmeyHEr+FXi0VXFzOt8PVwcAwHaY83N5mQ
         6cIQ==
X-Gm-Message-State: AOJu0YyxRPLsFQxm8ag8bb0XDYPd3y6BTKJ7m8swH0u0MBeyEzCbHLNI
	JxwNUDlT82YAi97Dt/B4AdDrMQiyN3wvVT93F5wHPPDhQNCcNB9QntwV/2NDMl+fjh8lF//mBQ3
	U/NnmJsdZ8tqG4haECHXvFkUKApZQCu/bwqc79SlYoVrP+gkxQShuVpkgj9+mqFwh/e8z4Q==
X-Gm-Gg: AfdE7clYYhx27AQc/Ymqctsi4wuuaJ+VZNyj3zTgHXxgTWr2jmfOXq/FKNECATJ4Si1
	CjqJ+6CwJsVFsHJ1R2pPLHF5dH6tpRNgD6uYYUMoAkgkKUcrNV6Xat0PT+BF0rUM+BLFlD0RkPs
	rLBFSitieGM8MEnXaAKQxnjtvCB5oTaC4kD9qpKxSD1ngoiexQyPM72T11S7Va35nckImLP1KGo
	+ApN3Sl9D3IMtnvSRrXb48hidmmkrjwXPyDaXgsIkdN4Js7rYoZyjAocRFuVRoMQfqRnkNwWjfy
	45BsIKLxXwBLHOXvrKTGMdnn9Zi/89lM18URyS1nWFRHkXSfjlEY9RWebxpBoblaRyYU0pEzqaq
	x8tMh3hVN0PTHF48hCLh6vI4yAwBRUJXrRuLvm2BLtSbCJ3SjeMo4YnTaE1Rd/HK0
X-Received: by 2002:a17:902:ea0e:b0:2c9:d277:2cdd with SMTP id d9443c01a7336-2ce9eac5789mr80918745ad.13.1783928030609;
        Mon, 13 Jul 2026 00:33:50 -0700 (PDT)
X-Received: by 2002:a17:902:ea0e:b0:2c9:d277:2cdd with SMTP id d9443c01a7336-2ce9eac5789mr80918615ad.13.1783928030120;
        Mon, 13 Jul 2026 00:33:50 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb72fsm95073615ad.6.2026.07.13.00.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:33:49 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:33:20 +0800
Subject: [PATCH ath-current 5/8] wifi: ath12k: introduce host_alloc_ml_id
 hardware parameter
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v1-5-d0a2a1a519eb@oss.qualcomm.com>
References: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfX4NLDbDwrB4sg
 fMMXA7tBRafkY1iyBEhKVV3pez9DE0L2UQ4mJFksGvGIh7LSoIuzTdKx2Pq18L9UDZ5GWQjyRcs
 hpYpVlYAN7cd0rwqK6vNMg6auK68TWUlf7Ll3/m8F3GndKJVYvvPfwt2ztR6o+FPr9hfECLDgne
 m+m9JAyECG3UxokoJmwl2rxLQBf+Ry3WI6vnw1mKbxQ8aj1rizfW4cRMAweisVHXKBEH0rooHpE
 tzqH8HwCLrvsqRGd8fHWuMagSoQ62LU+nawGptvM5qP9rP3D9n+1rYBKiaw7o0i/riepaXONSEy
 Xzh5QqYZ+m3ZdaS9YFjbPI3rKVHYjUcA84Y7Ok6uulTOKALl0NMUOStbH5ikzT9FmNI0jsricBP
 E+BBLCg2VG8Q30niD6w0HZ9D2LeYQ2Vxj9UYPucdlUhf0+68gNifdjUxnCE/sQ2CclITdm4zk89
 OX14PYeoIV3neMIsD4w==
X-Proofpoint-ORIG-GUID: vEEhtyTqQqiLpnInU3ZBl6TE6H1VBmuu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfX/xUhoOOCGbKY
 Srp+K5lOyEqZ1GrzwUiMOtZz3axP7C3Uequ0b+OnXaZXi8q04NEFVc/6OYWYCWrDixaa0cKlEyC
 ZslTFK45Mup5rFe7SVOMtnVpsntQfk0=
X-Proofpoint-GUID: vEEhtyTqQqiLpnInU3ZBl6TE6H1VBmuu
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a5494df cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2Mqij7SlxvU2Fhucnr4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38958-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 3924A748347

Different ath12k devices diverge on who allocates MLD peer id:
WCN7850/QCC2072 have the firmware allocate it and notify the host via
HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP event; While others let the host allocate
it and pass it down through WMI_PEER_ASSOC_CMDID with
ATH12K_WMI_FLAG_MLO_PEER_ID_VALID set.

Currently ath12k host allocates this ID and sends it to firmware by
default for all devices. This breaks WCN7850/QCC2072, because the host
maintained ID may be different from the firmware-allocated one.
Consequently data path may fail to find the dp peer and drop some received
packets. From user point of view, this results in bugs reported in [1] or
the 4-way handshake timeout issue.

Add host_alloc_ml_id flag to struct ath12k_hw_params (and a copy on struct
ath12k_hw for hot-path access) so subsequent patches can branch on it. Set
true for QCN9274/IPQ5332/IPQ5424, false for WCN7850/QCC2072. The flag will
be consumed by subsequent patches.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221039 # 1
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h     |  1 +
 drivers/net/wireless/ath/ath12k/hw.h       |  2 ++
 drivers/net/wireless/ath/ath12k/mac.c      | 17 ++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 12 ++++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index fc5127b5c1a3..1f56474efbea 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -793,6 +793,7 @@ struct ath12k_hw {
 	enum ath12k_hw_state state;
 	bool regd_updated;
 	bool use_6ghz_regd;
+	bool host_alloc_ml_id;
 
 	u8 num_radio;
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index d135b2936378..8091501cf742 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -232,6 +232,8 @@ struct ath12k_hw_params {
 		u32 max_client_dbs;
 		u32 max_client_dbs_sbs;
 	} client;
+
+	bool host_alloc_ml_id;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7d0d7d5fbf53..9e5fcbf8c730 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -15382,8 +15382,9 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 	int mac_id, device_id, total_radio, num_hw;
 	struct ath12k_base *ab;
 	struct ath12k_hw *ah;
-	int ret, i, j;
+	bool conf = false;
 	u8 radio_per_hw;
+	int ret, i, j;
 
 	total_radio = 0;
 	for (i = 0; i < ag->num_devices; i++) {
@@ -15423,6 +15424,19 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 			}
 
 			ab = ag->ab[device_id];
+
+			/*
+			 * the assumption is all devices within an ah
+			 * share the same host_alloc_ml_id configuration
+			 */
+			if (j == 0) {
+				conf = ab->hw_params->host_alloc_ml_id;
+			} else if (conf != ab->hw_params->host_alloc_ml_id) {
+				ath12k_warn(ab, "inconsistent ML ID config within ah, device 0 uses %s allocated ID, while device %u doesn't\n",
+					    conf ? "host" : "firmware", device_id);
+				goto err;
+			}
+
 			pdev_map[j].ab = ab;
 			pdev_map[j].pdev_idx = mac_id;
 			mac_id++;
@@ -15447,6 +15461,7 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 		}
 
 		ah->dev = ab->dev;
+		ah->host_alloc_ml_id = conf;
 
 		ag->ah[i] = ah;
 		ag->num_hw++;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index e5bf9d218104..0c277f51d99c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -439,6 +439,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = true,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -530,6 +532,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = false,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -617,6 +621,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = true,
 	},
 	{
 		.name = "ipq5332 hw1.0",
@@ -697,6 +703,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = true,
 	},
 	{
 		.name = "qcc2072 hw1.0",
@@ -789,6 +797,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = false,
 	},
 	{
 		.name = "ipq5424 hw1.0",
@@ -873,6 +883,8 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 			.max_client_dbs = 128,
 			.max_client_dbs_sbs = 128,
 		},
+
+		.host_alloc_ml_id = true,
 	},
 };
 

-- 
2.25.1


