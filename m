Return-Path: <linux-wireless+bounces-37857-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c2hoNsVpMmp5zgUAu9opvQ
	(envelope-from <linux-wireless+bounces-37857-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 11:32:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CC3697F00
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 11:32:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="H7h/OGGI";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Rwgt1T5P;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37857-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37857-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E7A3037448
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8467239732C;
	Wed, 17 Jun 2026 09:28:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3737439EB47
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 09:28:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688523; cv=none; b=IQorG7uGQK74dLqSamamyyQVrAl1ZzuUcoZ7S4fqfdOBg99dN/ZEAjPlNVg1+yrUmBlfw6eUWwqL18L0uSGzk0RgblRPnBVNrns3G4k0U4FYDuoLgoLGUz70+DTF5FZTs2/cSnkOGfNVhBr7gIKOC9UpYyV0PfrbkPJW/qcBYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688523; c=relaxed/simple;
	bh=QcjwyJXBs/VAbxImM1l3nNyOmkVcE14khwUNQ0//UAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q2Y7GLc/juVefQaqg+RgbDFHs+SDhbt0iWNnBnB0LqrvHD1MVrEwF0W4mEKTdJVjq1Lb6vRG3kXnGMbfkwexxQMo+HeaA7e8bW5N9Wk+2aQnB/0PWME3Hyaoij9iXHmWKXtoaL/L5acWMfiKL92en8zlTO6+VeXzGdo3XRH8uz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H7h/OGGI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rwgt1T5P; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H9IjfI2382396
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 09:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+zF4/NfEfqrlA2i8gwwLi1
	o1EMWt6+iNEVuGEzNSdBw=; b=H7h/OGGIaTrNSZM4RFqaQdHj/HTijrlYJnOKwH
	ISXwsjjwLQgmr8jffk2y7+Be4qbazngFD6onZSZgHhLvek/V2DO1xyDVdeyS15tT
	nUJ2EFKJHlk8SFLl3FvsSTzWIgEukTGlNtqhuv8fh8yam7GZJSTdBQrAjPxuLHS7
	gvm0fL7JCjIhKuiTJmrccWYPVcLhKH/zb0SaXjns6iD2PUKzetHF2apjF3WFbb+O
	kI1fbPTnqnzAAID3ydgRBsmurr6S2tEcW2eNkUVjCWg622oeOOo0Gt2YhFawsulH
	Zf6TpnM3lHlYjWSJZNGCB6Bm7KrQsEpTxJ2FBNgVkKXfFF3Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef2ag7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 09:28:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c6af282daaso18786695ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781688520; x=1782293320; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zF4/NfEfqrlA2i8gwwLi1o1EMWt6+iNEVuGEzNSdBw=;
        b=Rwgt1T5PoyNxWDkLSnk4MIbt5zFYt8AiRMZ0z1do/kM8lMJGoxaSuvQ9Yicpj0PT5F
         9WoL3SErSkJ2CUcdL4cjJi4gIotRlixs3v2lN0ioEy2GeDL6N3w2z1w3PRCwT3Vfqb0r
         hujzrg3+gTiMmhTj27WyL6VvsglvLeQiQl6PVdqVKTbiQf/8eglZ1tBus5s11cs3pCB2
         6md+uTubwvbN5HgV0olb9cglYeC6O1vpttj/FYZj8G+CLah8+DvIlHo4eSXSidqseAf8
         uOSttmq2B0o5P1RVpjk+1LHJ8uzrsIwikG3kYpckPq999FBVBwHmK3CAa1taAlnBnU3G
         kodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688520; x=1782293320;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zF4/NfEfqrlA2i8gwwLi1o1EMWt6+iNEVuGEzNSdBw=;
        b=d8OOmbl+bPjnGS/WkRKBFPqYTmGgOYgOv0DXlWSeYY9/asuEoCS4w3aekvMdYzah64
         naF/OmupYZC7GNHlHPnPP4eWBpgw8O0kyt4/UijYmDYGvXri75/cneqH8E932yH/P7/H
         qQg4Dhaas9MfKnTTaoMf9me8pmZMAFR1C+g5MSLY/peLm3jtHHjKCZxk0UAAptgmgRh+
         s31MdswbjuEM5I0+ERRmkDJdYMiVabzWzavEBHmfsqUJG9tzFYKUlSKM1ccVPzfLy0d9
         tFMB6Ol5h525NGvutO2u9P1jEyur7SL2iCXO1hDkh4PR7CDmqgX51myU/QzLixZummj5
         Qurg==
X-Gm-Message-State: AOJu0YwfVmKC/vnk3srFInKDRORFVvdO6muTYK489K8wEo7VkDlzuleA
	Xih44dh87I2K6s7mlUlPNhlHHWXCY/20TD/N6R/p1LJ2kX8fANxcbvsK1ZhBf1rCHjW0sovZXl0
	1P7JwfRMTcGip2zi6cA51Clgo+r8ulSaX1P6QcxM6cV7SFT49d2YRZRAn5S5GVOqjUKj+Cg==
X-Gm-Gg: AfdE7cl5If3dEqTEj0j4iGH6URwVnSsERFexBqq5R8DjcFlZPo+s99KiOPfNGwJdXtD
	LUCr36byFOuGWpzqeqlCWiXKJ3cZ5BnS651RXDbxR40X9MfA64Owq4ffxjDfirYEdTtjmJVNdwA
	tXHq1luZiswzV3pxGW93KdoaHRmTEcn5EpC3ha7mH+NKRGz2dwdRfv5yBIcXov7fUG82aeLFY2T
	kTtBudEF1YbuPT5eFnk3/oJfQIcTDRsU9QaCfJpA17okzRqvvKPPw/yUOdJ8+jPJVp3Qsd+nVbG
	7LqMFhOw1p8b0TJ0n9iIusynIk2vHCxjpUjI8dEPfp19qfGTR+U0jwXogkW2o7J8TeW/kegWsdF
	cVpFQ4RnUNWyu6OQ5+2MSe1RADyrmIKAR5W6Q0edTThon8RRLmb/dmV7/l6bCzAhj
X-Received: by 2002:a17:903:1448:b0:2c2:5446:30e1 with SMTP id d9443c01a7336-2c6bc0c1033mr29709765ad.11.1781688519954;
        Wed, 17 Jun 2026 02:28:39 -0700 (PDT)
X-Received: by 2002:a17:903:1448:b0:2c2:5446:30e1 with SMTP id d9443c01a7336-2c6bc0c1033mr29709555ad.11.1781688519501;
        Wed, 17 Jun 2026 02:28:39 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8ca31sm157080445ad.55.2026.06.17.02.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:28:38 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: fix peer delete race in MLO
 scenario
Date: Wed, 17 Jun 2026 17:28:18 +0800
Message-Id: <20260617-ath12k-mlo-peer-delete-race-v1-0-ab3c4f455dfb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJoMmoC/43RwW7DIAwG4FepOI8KOwRIT3uPaQcCZkFLkw6yq
 FOVdx/NKYcl2sWS9cufJfvBMqVImV1OD5ZojjmOQ2ng5cRcZ4cP4tGXnqFAJZRAbqcO8JNf+5H
 fiBL31NNEPFlHXMvgbTBGCNCsCLdEId5X/Y2VQT7QfWLvJelinsb0s66dYc3/tWEGLrgENJ4ab
 I3B1zHn89e37d14vZ5LWfkZt6Q8JrGQgVTl2so0DvbIakOCOCarQhptQbTey4b8Dim3JByT8kn
 WknyDtXWodsh6S9bHZP28pS/fqgK5xoUdUm1JdUyqQmphhAMTtLbtH+SyLL9aeqsOdgIAAA==
X-Change-ID: 20260602-ath12k-mlo-peer-delete-race-74fdaf880017
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a3268c8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=jNANfB1xzCx-3b90aEEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA4OSBTYWx0ZWRfX7vjSM1Q/F6Sz
 ke1VJsGEG1V1RrbJ3sbrDvrEra5K4oc10UZPbi+CN7bw1h5xT1PdSB05Qi1OPa7kX8ebixG2/mw
 phzB3ORvzs4C7Wqqu4sRIJ2BFeU8uC8=
X-Proofpoint-GUID: 6A99WIOLdI1UdnL-Mj5E1MHmUu4ca8An
X-Proofpoint-ORIG-GUID: 6A99WIOLdI1UdnL-Mj5E1MHmUu4ca8An
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA4OSBTYWx0ZWRfX4NJvsC2zRGMf
 iCuaXkMul9/WRZ9t2BwBauWe+VcD1W5gJkvxIfe+CKvn6j0qDbwq78gBcyxIT48GHcpbio9OVLO
 n/Elbf8gSAOK4SRNJlK+CneMIHCsUFblyPDU1eUvrT8xT5me6N4MNp6Wnd6+rSUXpo46HKfpVVv
 YlrPuYAC3AuOYjYBo1e3xtkdd0dQebMCVuxYDmH9cMKLiN06IC25MHQaPkpNK4HgL5mr/AGs/MC
 x6xDDErPk+2cI4Q0TgTU8hZby6d/qD3q97LyhYbHaYr1H3yZxoPtZ7wozoPydxGiU81Dgtm+012
 /1FaHORhUHRFnCpNlfs7lTJWIns5YJVQhXT79twaZMJbhwFqArmirs0GK6rHEvlmU7KVAkz1wYT
 LXABR9h8vhlzc+KDv3jAtCSl9d8Mwb4S76ztLWuOYBnf9NdGAGZ2lf2ACMDFdN9E0uFWRQjko+6
 68dKcspHnvYxsDE/PUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170089
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
	TAGGED_FROM(0.00)[bounces-37857-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: 46CC3697F00

Patch 1 fixes a pre-existing UAF in ath12k_mac_vdev_create()'s
err_peer_del rollback path.

Patch 2 fixes "Timeout in receiving peer delete response" on MLO
disconnect, caused by a per-radio shared completion that gets
clobbered between back-to-back WMI peer_delete sends.

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Baochen Qiang (2):
      wifi: ath12k: fix dp_link_peer dangling references on AP vdev rollback
      wifi: ath12k: fix MLO peer delete race

 drivers/net/wireless/ath/ath12k/core.c |   2 +-
 drivers/net/wireless/ath/ath12k/core.h |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c  |  20 +----
 drivers/net/wireless/ath/ath12k/peer.c | 130 ++++++++++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/peer.h |  19 ++++-
 drivers/net/wireless/ath/ath12k/wmi.c  |  16 ++--
 6 files changed, 138 insertions(+), 54 deletions(-)
---
base-commit: 4987a85fb0475defee458fa11af877c8e02f764a
change-id: 20260602-ath12k-mlo-peer-delete-race-74fdaf880017

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


