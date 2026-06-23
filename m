Return-Path: <linux-wireless+bounces-37993-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VnTaG8IdOmrZ1gcAu9opvQ
	(envelope-from <linux-wireless+bounces-37993-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 07:46:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 613166B43D2
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 07:46:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Dv0YSHMK;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=S+io04SS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37993-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37993-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 798E0300BD6D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 05:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68127322A;
	Tue, 23 Jun 2026 05:46:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0050345CA3
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 05:46:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782193596; cv=none; b=PfHr/d3g8JnZmyEuvy1p++5uzzq6ARewcivaxwMjQvKYRueP+EqxqcBA+7mHiBcSrLpMeCrb85rRgmYMadSzgKaVFB9nF4XepyIkxo7kBXtYl49NWNqgLN8ea9YJ/bdxqq0GdznYPX4cbkZ6vVOetu6JohDw8bwvBAES+fFgOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782193596; c=relaxed/simple;
	bh=8y65tWhhrgD4cjqiCRpuQtG8Sx3IppBldw+6bCpIJ/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kquui6pvRQtH631F3RBLW1Z0R2SuKK0UtoADl356JSAxCpn3IbSb1IXJoG8BrsmBsOSTJCob9ZOTbwQ62BZG/GsnbhwpnAieRV4BclALNKhnBEcw5cn14NQPcUBMABTzq2LoVs1P41pzg2LRUVp9YFrvEojxmuNtHGjtZPPNfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dv0YSHMK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S+io04SS; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0l7JJ2869493
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 05:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=F1nzYl6QagXdDViuD3bSxU
	u5deBQ8u2MUiQv690fH98=; b=Dv0YSHMKYzqDsDXV3N+YeQ1dqtiHOUIpRnbDvJ
	XHjOOYnarTgwcSEikcmZqIqIqfvQKkQZyNZNMxzh3FoRED9Y9KmwNWwIEgW1cAlD
	kQyefhiPJOAsOpAgOEHOTMW0XxZB1vn8yoU56/sZ8YCqLfceharPhULkQxJATFNI
	yMxFKxpe6LaJGKXktTs2h71bvRyPPvtRGHXtYUGQcGESQ+dKfKv/qp9NczSj6kre
	Kokkw9LizXTSDxk2dD1h9V8ofJgTMJOABVwpdFczPousMo5V61hB33P8JnI4T0vw
	nW+AjHlqVhyOmMB3Hk25dKZB9Q69xG4SAM1GERugMwcQGXIg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmtvcu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 05:46:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8423efbfb61so3821262b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782193593; x=1782798393; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1nzYl6QagXdDViuD3bSxUu5deBQ8u2MUiQv690fH98=;
        b=S+io04SSmDQ6RfhtZlKUGJGUaWaElevPlowoDDd68nyk5LROSMCYaXtMlITR+DLR/d
         ErOc0jB395aIYoTxFx1c8Ki6GMnXoYXvXLZ8OnEj3CJAHouvI+bs+iWMjFUa+ra9q+xe
         SkUSKUwpRP6VfI5CfEP4UwoHc0KQ3REVUVKFztirkRddVY80DeXllKELZxN24fDHgWWg
         TwO87c0V8yhUJNF1jI41X+pf5pmhhN265QrflLgyJPch+YKUOstNicdpOwDAQMgFlo3F
         HSLxiRQCbRUV8MpyTliKCqpHIUCBqhgrtyXaoLfviq/0wyidWQpRnoL2eliekRaLh7o5
         f/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782193593; x=1782798393;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1nzYl6QagXdDViuD3bSxUu5deBQ8u2MUiQv690fH98=;
        b=Nuno3mVE81FIFs1iEH5Ugwp8TTwy3aLmpKgoFEeblsfvM8ryUy8+kMt/CGJdo+wKe0
         l4VttTdKLg20jkfyKtI0o7cOsW0uBwsF6s1P0lPspNhoYuVl1t7Aqs6gh/KdN+kjC7ff
         Spsr3Pr9OpBFMWDOSVF/qO076vGsOCTO39loxTSJLbphsB8SnulzgzU6DkZ3rNy9Dt3B
         VJHyxSnwmdXoYH6P5OoaAboIldDeB6wSpWdyAQQpOahh/3c9LIjWpaHkLeNGdw5m0FIa
         fCxFG9Zdcydwc97zUxKange7QDRf1ZyjORlZOBVIbPWff6wCHBSRYwaF5U7On4IEIevj
         /jfw==
X-Gm-Message-State: AOJu0YwHZw2yw01Xty79bS81eVU/8UuWeDO7h0otzE8pjjP4l/k3tJ8A
	Meu9q7DFh+S8FreqglHg+mzNQS+yRtlGb/A6g1mvGqMHKStIXzteMzX8zdj5E2a/8y5ErQhOBsB
	Sh9itg0iouflUT8DJGxZJf0Qj8QNJUri4dp7mChmp4lp7QMDPURH1+MrVZbswZsMskR37dJYUCY
	68pQ==
X-Gm-Gg: AfdE7ckMomZnfhe3ELpmgFRwclQBOs6DaLtgAZwj7N+KKFgnG22fJdzs109ZT03NR93
	XLgKWrVXFz7MUqoYIW6QLLaJ8xhRiwRMkoS4qPGzlgu35ateZnIopI3JEyrfz58THmenJ0yDHZL
	YS75qB7nggIjpXIOscN4yr2MDrGaJtvDY/vBpsnqo8FjVg9rMV2Yq80+2wTkDwwC651wsFLCZS4
	DyDfz2+6PbHeYN1CVvbVtbUGfoUrM2LAnVvd8eC6Yz2C7IBoMQJRk8LYKnCVtW0AvTx2Ij6dK8/
	7GqLLaW8L9hMtupfzepCidTu85XhaK+Eat4+nGBB3Nsyv/esGAYZOaAbMAwkKkjmCPr127+/mPT
	3uYCaXgRakr/3CexHhaRpT7gVnRDi6thcmobpZaWz2Q9n41h2QlbHnjskav+AMNMtbzmwmPRl0Y
	COEqMT4GPLtGFwoXrVvmTtFPSerRtG4ochbRlqUehpnfQ=
X-Received: by 2002:a05:6a00:298b:b0:845:18b6:1154 with SMTP id d2e1a72fcca58-8459707b307mr1348966b3a.8.1782193592476;
        Mon, 22 Jun 2026 22:46:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:298b:b0:845:18b6:1154 with SMTP id d2e1a72fcca58-8459707b307mr1348928b3a.8.1782193591966;
        Mon, 22 Jun 2026 22:46:31 -0700 (PDT)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed3bd8sm8989152b3a.56.2026.06.22.22.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:46:31 -0700 (PDT)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 11:16:21 +0530
Subject: [PATCH ath-next v2] wifi: ath12k: advertise ieee_link_id in vdev
 start MLO params
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-ieee_link_id-v2-1-8a89d71baf58@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK0dOmoC/3XO3W7CMAwF4FdBuV5Q7TQh5Yr3QBPKj0utQQtNV
 zGhvvtCxQVjcGPJss53fBWJeqYk1our6GnkxF2bF/xYiNC4dk+SY94FFmgKA4VkItoduP3acZS
 qxDIohR7BiBw59VTzZea2wg2NbOkyiM98aTgNXf8z94ww3+8k/CVHkCAtGu2Cx+Arv+lSWp6/3
 SF0x+Myj1vRPVu9yCoTar1SwVuI/7O3X0Z87NdPBmaDlF1VLmpTOvvGUI+GeTJUNqKDoGuyVQH
 mhTFN0y9PhqwufQEAAA==
X-Change-ID: 20260610-ieee_link_id-3424c332b216
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>,
        Karthik M <karthik.m@oss.qualcomm.com>,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0MyBTYWx0ZWRfX+hMTWuMnoXUG
 Q0QWJbJceJ9tZYFlZelyJt+6sI4v2nNi6GDarMkms6Aybmnt79ILxQAKsxum3yfOWS0T7MVUe7u
 5j8Dw7KW1LiAp3PWH1bNE5N9CDHhGqQ=
X-Proofpoint-GUID: 0Qiu9rc5N4VHJ4aBzE-mWRtwZgf5InKL
X-Proofpoint-ORIG-GUID: 0Qiu9rc5N4VHJ4aBzE-mWRtwZgf5InKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0MyBTYWx0ZWRfX38cfQt9/VCga
 MMhs4oNAFSoI/eJPBZ4S4ONRx0eSB1XPvW91JhjINGAxTVCeNq7DoXJU2ePfB7lDMb7PGl3nQ+Y
 5pCiERrcAnkE4y/BDy46Qd92dYg2gRIAK6lko+ULndvOJeVUEj4SGfxtwbHLYSqwWS5LloUDtpk
 fIH4122KRyUDWhnY6aAg+dqnwPEt6wwU2cpjHzwcdP9uamm0JrsPs4uqe353bYBPuRA9KK524nr
 ZfzPEIJQxPMrDMn15Dqh1in8RNJmPMJa/NdGk1YzHSPWY21QYNiLWoWARmXUg9C5BiG1qX9bHb2
 ibLnGHAMOZD2YQ8n7OctXh822999tQrWLF6Oxaa4icdrywmA6RUUkhamJNA8En7MaHZ5/nbJDSL
 gBx3+gS2GnondAUbB63UMBGI0h0KpuFAVbmmNwdkLa3U1Jti8KEL/3Y6+MkdIP96B+WsF1Z+v/w
 TtK064YvrvyixQFhrLw==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a3a1db9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=r-ZuXGAqLrq8oxxbCEkA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37993-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:hari.kannan@oss.qualcomm.com,m:karthik.m@oss.qualcomm.com,m:manish.dharanenthiran@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 613166B43D2

Firmware builds the AP MLD partner profile from the hw_link_id passed in
the vdev start parameters. However, hw_link_id is not always the same as
the logical per-MLD ieee_link_id, since ieee_link_id is assigned per MLD
and not per pdev.

This matters in mixed MLO and SLO setups. For example:

  MLD 1 - 5 GHz + 6 GHz (2-link MLO): ieee_link_id 0 and 1
  MLD 2 - 6 GHz only    (1-link SLO): ieee_link_id 0
  MLD 3 - 5 GHz only    (1-link SLO): ieee_link_id 0

The same physical 6 GHz radio can use ieee_link_id 1 for one
MLD and ieee_link_id 0 for another. Pass the correct ieee_link_id to
firmware so it can build accurate per-STA profile elements.

Add ieee_link_id to wmi_vdev_start_mlo_params for the self link and to
wmi_partner_link_info for each partner link. Populate these fields in
ath12k_mac_mlo_get_vdev_args() from the corresponding vdev link_id
before encoding the WMI command.

Introduce two new flags in ML params to indicate to firmware when
the new fields are valid:

  ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID         BIT(18) for the self link
  ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID_PARTNER BIT(19) for partner links

Firmware parses ieee_link_id only when the matching flag is set.

Also fix the debug message by using correct format specifiers and host-endian
values instead of __le32 values.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Co-developed-by: Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>
Signed-off-by: Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>
Co-developed-by: Karthik M <karthik.m@oss.qualcomm.com>
Signed-off-by: Karthik M <karthik.m@oss.qualcomm.com>
Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
---
Changes in v2:
- Addressed comments on debug message.
- Modified commit message to include the details of debug message
  modification.
- Link to v1: https://lore.kernel.org/r/20260619-ieee_link_id-v1-1-36cf573cb81d@oss.qualcomm.com
---
 drivers/net/wireless/ath/ath12k/mac.c |  3 +++
 drivers/net/wireless/ath/ath12k/wmi.c | 32 ++++++++++++++++++++------------
 drivers/net/wireless/ath/ath12k/wmi.h |  7 +++++++
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index af354bef5c0d..773ecd6da8e5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11253,6 +11253,8 @@ ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
 
 	ml_arg->assoc_link = arvif->is_sta_assoc_link;
 
+	ml_arg->ieee_link_id = arvif->link_id;
+
 	partner_info = ml_arg->partner_info;
 
 	links = ahvif->links_map;
@@ -11276,6 +11278,7 @@ ath12k_mac_mlo_get_vdev_args(struct ath12k_link_vif *arvif,
 
 		partner_info->vdev_id = arvif_p->vdev_id;
 		partner_info->hw_link_id = arvif_p->ar->pdev->hw_link_id;
+		partner_info->ieee_link_id = arvif_p->link_id;
 		ether_addr_copy(partner_info->addr, link_conf->addr);
 		ml_arg->num_partner_links++;
 		partner_info++;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 84a31b953db8..22ff17708722 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1228,10 +1228,14 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 				   le32_encode_bits(arg->ml.mcast_link,
 						    ATH12K_WMI_FLAG_MLO_MCAST_VDEV) |
 				   le32_encode_bits(arg->ml.link_add,
-						    ATH12K_WMI_FLAG_MLO_LINK_ADD);
+						    ATH12K_WMI_FLAG_MLO_LINK_ADD) |
+				   cpu_to_le32(ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID);
 
-		ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "vdev %d start ml flags 0x%x\n",
-			   arg->vdev_id, ml_params->flags);
+		ml_params->ieee_link_id = cpu_to_le32(arg->ml.ieee_link_id);
+
+		ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "vdev %u start link_id %u ml flags 0x%x\n",
+			   arg->vdev_id, arg->ml.ieee_link_id,
+			   le32_to_cpu(ml_params->flags));
 
 		ptr += sizeof(*ml_params);
 
@@ -1244,19 +1248,23 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 		partner_info = ptr;
 
 		for (i = 0; i < arg->ml.num_partner_links; i++) {
+			struct wmi_ml_partner_info *pinfo = &arg->ml.partner_info[i];
+
 			partner_info->tlv_header =
 				ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_PARTNER_LINK_PARAMS,
 						       sizeof(*partner_info));
-			partner_info->vdev_id =
-				cpu_to_le32(arg->ml.partner_info[i].vdev_id);
-			partner_info->hw_link_id =
-				cpu_to_le32(arg->ml.partner_info[i].hw_link_id);
+			partner_info->vdev_id = cpu_to_le32(pinfo->vdev_id);
+			partner_info->hw_link_id = cpu_to_le32(pinfo->hw_link_id);
 			ether_addr_copy(partner_info->vdev_addr.addr,
-					arg->ml.partner_info[i].addr);
-
-			ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "partner vdev %d hw_link_id %d macaddr%pM\n",
-				   partner_info->vdev_id, partner_info->hw_link_id,
-				   partner_info->vdev_addr.addr);
+					pinfo->addr);
+			partner_info->flags =
+				cpu_to_le32(ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID_PARTNER);
+			partner_info->ieee_link_id = cpu_to_le32(pinfo->ieee_link_id);
+
+			ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "partner vdev %u hw_link_id %u macaddr %pM link_id %u ml flags 0x%x\n",
+				   pinfo->vdev_id, pinfo->hw_link_id,
+				   pinfo->addr, pinfo->ieee_link_id,
+				   le32_to_cpu(partner_info->flags));
 
 			partner_info++;
 		}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index c452e3d57a29..51f3426e1fcd 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2954,10 +2954,13 @@ struct wmi_vdev_create_mlo_params {
 #define ATH12K_WMI_FLAG_MLO_EMLSR_SUPPORT		BIT(6)
 #define ATH12K_WMI_FLAG_MLO_FORCED_INACTIVE		BIT(7)
 #define ATH12K_WMI_FLAG_MLO_LINK_ADD			BIT(8)
+#define ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID		BIT(18)
+#define ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID_PARTNER	BIT(19)
 
 struct wmi_vdev_start_mlo_params {
 	__le32 tlv_header;
 	__le32 flags;
+	__le32 ieee_link_id;
 } __packed;
 
 struct wmi_partner_link_info {
@@ -2965,6 +2968,8 @@ struct wmi_partner_link_info {
 	__le32 vdev_id;
 	__le32 hw_link_id;
 	struct ath12k_wmi_mac_addr_params vdev_addr;
+	__le32 flags;
+	__le32 ieee_link_id;
 } __packed;
 
 struct wmi_vdev_delete_cmd {
@@ -3120,6 +3125,7 @@ struct wmi_ml_partner_info {
 	bool primary_umac;
 	bool logical_link_idx_valid;
 	u32 logical_link_idx;
+	u32 ieee_link_id;
 };
 
 struct wmi_ml_arg {
@@ -3127,6 +3133,7 @@ struct wmi_ml_arg {
 	bool assoc_link;
 	bool mcast_link;
 	bool link_add;
+	u32 ieee_link_id;
 	u8 num_partner_links;
 	struct wmi_ml_partner_info partner_info[ATH12K_WMI_MLO_MAX_LINKS];
 };

---
base-commit: 63abe299b12b317dfee5bcd09037da4668a4431a
change-id: 20260610-ieee_link_id-3424c332b216


