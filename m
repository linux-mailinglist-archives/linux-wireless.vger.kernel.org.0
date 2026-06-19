Return-Path: <linux-wireless+bounces-37914-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vjv/AeHZNGofigYAu9opvQ
	(envelope-from <linux-wireless+bounces-37914-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 07:55:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F076A4031
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 07:55:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=P9BpJl2Q;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hAs9Ax1h;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37914-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37914-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E8EA30091C5
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 05:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4E340D57F;
	Fri, 19 Jun 2026 05:55:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF9292B2E
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 05:55:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848538; cv=none; b=dtMoX6X3Ogqv4PTSKsMUXQV7Qw9DiyjXJ4IHECCHi+Yl93xt3aJOXNXUqDFSM9xDlrdW5Q6CXW499/+We3MRnBNiHpEOHIk9nrMnWkr5CuU7sQw4KzbbcVeZfPk6IOYxc6tmgyZjudTzHC97B1Ooj0aAbLsCS8HU9QRdZeIY8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848538; c=relaxed/simple;
	bh=ALZn5mOpkaiaucm30+g8l73xltXOYg2Owtq4qJmojbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X8BJQMarSmRblwlyZiIIUT8ASlh98XqZsF4JnSq6DxVfOz4ApSDuthZ9eLYC6EFi/yMkPCJfr9ZSZqv+bp+PGDsI8ktRtzyXjUreWJ3lQ/Vaaaa/uUz/fdYtE3/fD4Vy327/LdFYBrU3/1lMg+jU+z70CczbD/AQz9pdi0nDCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P9BpJl2Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hAs9Ax1h; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J2smen3039485
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 05:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Bm6aeURL822jXRVJQOEpxa
	AsYvkkIhSdGOk3vQmzGPA=; b=P9BpJl2Qa3oEu1GsGiWmYFXXpbZAtczcniTQPg
	Ppginicr5rBdbF2JqaaVxoSVVN4sgNkQGdcJMvL4QDU/lA6b5j1lv5tuHPL9IxD4
	CgXDD0dKNddjZWcqQz1gGHRAdYGL1e18Yll+A2XZgwwpJQWFIW9GQhvthyst1B09
	wA50R/OYjxDHYT35og/ELxNRdbQfwAfLo7oKtKcCta6iGdtdwBod1koHLcIealoF
	hCecnlauO9Ipfx7eO+IVOtl1yXcjIOM6RA/CSFn/gNPxmSx9oiGY9P4HSPQEptoq
	uRHtyWe2Q2Wz5M+xILDp4uUomlgJOSNi8LyqjYIktJqY30Iw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evkvf2p8w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 05:55:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c2b64850easo36962885ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 22:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781848535; x=1782453335; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bm6aeURL822jXRVJQOEpxaAsYvkkIhSdGOk3vQmzGPA=;
        b=hAs9Ax1hSfnaO2uw88cr+nCQjwEm395yWEA4hBuVtcJHijT9WIn54lx2DyZ1b9zD0Z
         2dxvIf2vprAQ+2t7D7cwXvCqYvJl4AxJwtfs3gbKexbFBcH2I4Y2ne+HHHmVY9aFlifv
         8sooxkl0GJ4Bb8gWxEnyfzgJTT/z3HhY2epd0XOLuD7QXGGFJ4c04nvGVg4oZBdqqi30
         gT9P/mH5EDSzJtCKRZc85HUsX2hzy4DdAAP5NsrFgE5S5XXniCGDCayd+rOYqlM5WFHs
         2ooy8WUEkYaXD0RmuOdhtlduuxMexgMYs0jlV0KcDQL2t8ntzTcKAceNCqoF1g5cyDY1
         wfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781848535; x=1782453335;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bm6aeURL822jXRVJQOEpxaAsYvkkIhSdGOk3vQmzGPA=;
        b=mYKJZhj7R/I5S8/MO0eMNORiBs7v5C5/g0CLza2zPrJyuB9FyYkN1gGUrj2WjNeEA3
         gvxg9tV0CpnJTD0VoLf92a8AgpHT+Jk0zl/cXDxNO61HllhWHmfuErewpTZUKP9LPA+O
         Q+Rz7kGeThWItW9rmLnxbSncIIJ08xerua3GFK+FHscRIe3ziHXaZmX+2ZlddsVsGokA
         5eVCzX0/IGJ7BqZcSMzrLotueCpUhW9i6ON9UIFxnRYgdDWjy5AZ7iPy/SRWpukPuN30
         Dsr6jasujVlDNPryZjX8EcqGl55NKDUvBP+U20O+Pceqh47epmPYehDQ/hLKe61r/ggR
         FTPg==
X-Gm-Message-State: AOJu0Yx12oUG5gFSfpK0q9vok/+heOzwfqsKiUBS1r86XnE5QvRJoGTB
	XpijsG4+Q8vNyynSy6dS6L2QEyGv5hE37B6yjW9a9NoG2c114OHnN+ZYcERHF98PYBtwVKs+7nD
	/hUHRVTRP5BUvkWVfRBkc6aumzrV1KWXsRbsljjjedZugW1r3Xq7AKV2Dd18cyPTrUIeHPw==
X-Gm-Gg: AfdE7cllzOAK4xJrFNyR39et7d/Hv1HdJg7UUExr+4q98zHg2AYNLHSnm6vJZGydujH
	bkkkX75cPqzTauddCs6PmUhG3LL/vceJDblCIIL1U/5br5dK3hCcxRf35GYDRfBmr4oIan/Uces
	ZVCrjPAgzxZBliJbxTWhCL+M1rN11C51ZDicbPBhgVq0oY7OP0rY9gUiFRUVr/Gl/9hokHVux4i
	XQunJICIodnWXIZQo9RQaZ5cgwb67d9vu+blB5Xcker1+M9BxZ7amexhvshnpUVUPNkfcCmi6/s
	TR4nUMEJKQNEt/HAC9VMT2P8WCFU7Eplpdf1QKc00JYy/eFfzQ40YjMqdGmqX2mOdxL5LOEvMxh
	B3/Oxe9zXWiKVKTfSP+aY1F6+bYFCGZswor68e8nG/qLZlzlcTGzH8DYabw//YCbZD0vnPZsOae
	e8Og6AQz0YKOe6Ok9owdlb3aeb/iXcZccWifmt5RYbHqM=
X-Received: by 2002:a17:902:d50f:b0:2c0:bff4:96a7 with SMTP id d9443c01a7336-2c718ca5e42mr24589185ad.12.1781848535348;
        Thu, 18 Jun 2026 22:55:35 -0700 (PDT)
X-Received: by 2002:a17:902:d50f:b0:2c0:bff4:96a7 with SMTP id d9443c01a7336-2c718ca5e42mr24588855ad.12.1781848534919;
        Thu, 18 Jun 2026 22:55:34 -0700 (PDT)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7209bd3ddsm10559785ad.38.2026.06.18.22.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 22:55:34 -0700 (PDT)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 11:25:13 +0530
Subject: [PATCH ath-next] wifi: ath12k: advertise ieee_link_id in vdev
 start MLO params
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-ieee_link_id-v1-1-36cf573cb81d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMDZNGoC/3XNQQ6CMBAF0KuYrq1hplDBlfcwhpQyyEQoSpFgD
 He3IS7U6GaSn5//5iE89Uxe7FYP0dPInjsXAqxXwtbGnUhyGbLACHWkIZJMRHnD7pxzKVWMsVU
 KCwQtwuTSU8XTwh2EGWrpaBrEMTQ1+6Hr78ufEZb+RcInOYIEmaJOjC3QFlmx77zfXG+msV3bb
 sJZvBHfjeTLwGCQSreZKRMdm/SPod4N/WWoYJQGbFJRmkWgfxjzPD8BMBrk60EBAAA=
X-Change-ID: 20260610-ieee_link_id-3424c332b216
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>,
        Karthik M <karthik.m@oss.qualcomm.com>,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA1MiBTYWx0ZWRfX5jClYOqAUuBH
 0AJ+618ofATRvUwL//6TU/XgJR0y4caP2jO/56X10CPpRpuBAec+r+99REdpv0PAlYS/+JTfsvZ
 E3W/j0rVzvX9gLIX1exlgIrA3vuuCP8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA1MiBTYWx0ZWRfX+Wm0zBstnnqF
 7omsMBdlmTmNNXjtVEWYvP2LvoVPRpTKe+ZVLE9pPZOtGDrBd4cInQjXRu84zP3pyTNzTAXw6D4
 izDbrZYud0rkrd8DoA7/qcXFdTIalnY4Tbf4iN1B33gP0WyIM0YVeyzfmDjkLXSqzQdBsXjegU/
 0sPQgDAbfap8gguiox2ounPoYP/17R62LID7k4tc6hDakTNJfaPWsqJEW2Bod4ATGYrbFlimb7o
 cCTfYK+mh+bAwUhGNdA+10m5IQqOLS02qctFscHm2sgJ3bCgj6mSzaprlPrBLgNWTAFuWhH1rkD
 d99WFP4xbVbhJq4hfzXcSe6E3P/hncuYbIV2X1uSut5shc97aP6rK3nbs2rVUwDK9h9etZO+7t/
 6bU/k2XRTaU1YtmXuVGyoZSbQeWpB9sb0+pTPVLemCwi2Ccsu6jh7k+bZqFM+d25xHPrEXv3Ql7
 74DNEm9O+pREpVFJWqg==
X-Authority-Analysis: v=2.4 cv=H/3rBeYi c=1 sm=1 tr=0 ts=6a34d9d8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=r-ZuXGAqLrq8oxxbCEkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: FobTyYYQNHGPiWHF5o8dMeZUsTjpFmce
X-Proofpoint-GUID: FobTyYYQNHGPiWHF5o8dMeZUsTjpFmce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190052
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37914-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:hari.kannan@oss.qualcomm.com,m:karthik.m@oss.qualcomm.com,m:manish.dharanenthiran@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: 00F076A4031

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

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Co-developed-by: Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>
Signed-off-by: Hari Naraayana Desikan Kannan <hari.kannan@oss.qualcomm.com>
Co-developed-by: Karthik M <karthik.m@oss.qualcomm.com>
Signed-off-by: Karthik M <karthik.m@oss.qualcomm.com>
Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
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
index 84a31b953db8..a0e8b5678ae3 100644
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
+		ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "vdev %d start link_id %d ml flags 0x%x\n",
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
+			ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "partner vdev %d hw_link_id %d macaddr %pM link_id %d ml flags 0x%x\n",
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


