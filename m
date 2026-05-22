Return-Path: <linux-wireless+bounces-36795-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IcSI8QpEGpQUQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36795-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 12:02:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 088D95B19DA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 12:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBDA5302F749
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 10:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37AC3C76A0;
	Fri, 22 May 2026 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eHh7X2gG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="csiyx7o0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D943C4B93
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444062; cv=none; b=mht+alkE5+dtAX7EFA5A40BzUWOA5g7/2vW+8iU8SQOXvazVULJ6UtHsqy43xV21x6Ui2ko9UVnWgotzwLCPiR5vTlZqrQa0oxUECXinRrDcLId+N/+hh8Ic+3JvjjkFwApPZiX7brt7EXCHHidDOcXWYuq00TRTWvRTn3y+H1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444062; c=relaxed/simple;
	bh=eEEN3EXZH9+ocSgYvv06EBOEmhgPIImBeQeRcWVT6hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oLuwYg1QYbw/iTXTzy4wkLLrIsBRtlcfGywdUvyOioEyJ5AaCMaEuonT6tLPyVMOE37bOoJ7pZfI2ON+lUmqWUPd0fzakf9KF9KMR9DuhJ45yrFLtds7LVi325JKsmrbRhwDUAAexAeRmYC2mKwUc+5Tvgr0wvh3dtrZKxKLmSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eHh7X2gG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=csiyx7o0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M9p1qS312901
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YR4rbS+4WUMiEynV2sZr8pSzcK/RqiAN6yJ9tTgtN8c=; b=eHh7X2gGrSZekNOb
	xkDmqbEW54k9aNsjuHmVMXxsX8I8pWfkpIefqSA1ncFswM3zO7mNthHR9mPKM43H
	gdAmQwJvnzvcpAHEzUyu5HWmyqySgPIKvuiNNnXArB1Dm6Ws4O1XZvQdrUbrb0rM
	e5nH7dsWC7/h2UU/D6aL/v3gFuGWLccts+1ZPuEuleYzrW0DdofrlBxGwwdzeXO1
	n2Hx1KrVjELW8du55RA5vhG3FBDWrn0xMTbfzGDQr2TFvHW37LDxACLaIp8TgmjJ
	581P1XwAw4f3uPjgmxmq5AAPMezvBPq0QMjka/UXu0OVM2KHvs1t2VIbYinr6PTk
	RKTB0w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea88338q7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 10:00:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso11151953b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444058; x=1780048858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YR4rbS+4WUMiEynV2sZr8pSzcK/RqiAN6yJ9tTgtN8c=;
        b=csiyx7o00JbeY2fYsF0w1GZ0I0hnbeB7NfnOT3YR8yK3Jg4bEA71CV8t5zSQKZ+iuI
         aZmJU0Bkg/ytsgihmwTPzWOBj+3auW+IOfDJeBnGM4/87+FwgIoeUScQyxTW3ZnHP0f7
         42vBfnmfoAifMToB8Crnz0bD4aG6HH4+OBuTNzQRcotKkvT7V5fFd8Lk0/303IH3KMK5
         k3ljlorDh5XJVaIsmAGedspSiWqZwRZhqE28S6PmT0UCwrnmdUr/Kda564l3kGejnIWy
         KEzCUFqadpbMAkzvfIMJ8MzQ87oYC0FNa5bPDlXrs3dKFxQ8fzXpBqnZNVOVW2lzoz3l
         TxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444058; x=1780048858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YR4rbS+4WUMiEynV2sZr8pSzcK/RqiAN6yJ9tTgtN8c=;
        b=Dc8rfNg2IJ0yG0piIiJ+NqqjkfmsD9QKvcDBDbZreLromp50CxLUpDaFdQ85FRCy6T
         JykE3HErIDXX1Dd9IRGa2oVtCH5beSeiNPFh6hyrVYZOBTd+35untCG/o8dzfohMOKuc
         ACpu1WTmplh1/qKGPuJq6SuYhlulYn+QluSy4x8+wXNvqySScxmVVw0xQ6WVjhCoTSSa
         Axr5DOY88vQ+HaF3347+zi9txQkxvZFlFA0FVlGU6Y0FQ7R6MWNOcQq0FDNCmp/+yrCA
         G06BkEzHReOjJlPRRZ72eBZwbSuNyCh4HPubD56s1cZD66c39mOE6VfbvxpN2q+6rGQw
         OT5A==
X-Forwarded-Encrypted: i=1; AFNElJ+0o07B3VKVgsR7QMbwL8KSaLXkyDSaJ5tALaEU5FTRCnTqu/nta+oNxgWTPxycAiCaKYKXCgU2nSAgtoTGyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+WbpxTXi2ycyt5VARIeBsRNY5sACA+y16GiYciqkeYjsQMJZ
	kqAy3LNcu6wNwD+N/gGMmIyq9jKwU3/yWkBl94ImaS1PERYJG2d7jO3txOie/OYyqE65H1PiVLj
	G+1Fzg0O+/ezxtNXEOV48yau8os04Tp/wxILHX11sKwsNlEZWTmbXu0k4XHQsLLWGwCRZDYZ0z7
	6cjw==
X-Gm-Gg: Acq92OE33S4ujCe8S0R+LeA6WKm8nelw2TGHb0VTSjufnS4jvkiR7bS68y4MfgdbVkU
	J3o1tubA+G6YSJfLLgtyU+gBSQx7T2PaEPtQCfJPt+7ppV8a4zXLL949760vYA7ad9+9NHPiVMT
	Ob/icwxrLe/Mmc8NzmrqB55kEc5jebjDVbWkZPpfmCKLDp+q5wATqtBfhxnnrTE7J2qEgcUoQqf
	prA1jXqzmsqzuH7BFRZoFsB0xpUeNp/75RdrI/lIKcSktvX8KXz6Zogft7hrAn62CO9nfi6DlqQ
	KY/ifwpANHE70UQjhskaDczGZoM/rOo6J87hjtzvAT6aUUxyN7ilLQ+wAGVbtMhgpY2YV4NQC0u
	yY+ZTc9A4pEy8oVF7EZdvNywaInsGsAXXeAMIMzU8yQT7h3Ws5asm2NBb
X-Received: by 2002:a05:6a00:2daa:b0:82f:42bc:3386 with SMTP id d2e1a72fcca58-8415f1a5318mr3309556b3a.21.1779444057451;
        Fri, 22 May 2026 03:00:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:2daa:b0:82f:42bc:3386 with SMTP id d2e1a72fcca58-8415f1a5318mr3309509b3a.21.1779444056898;
        Fri, 22 May 2026 03:00:56 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:00:56 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:30:32 +0530
Subject: [PATCH v2 1/6] bus: mhi: Replace controller runtime_get/put
 callbacks with direct PM runtime APIs
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mhi_runtimepm-v2-1-fbebf41a82bb@oss.qualcomm.com>
References: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
In-Reply-To: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        vivek.pernamitta@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=4878;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=eEEN3EXZH9+ocSgYvv06EBOEmhgPIImBeQeRcWVT6hU=;
 b=yYhT3RpS8Nz/uaR392bqwxteKBb/FYzWe1XQYz9VQyNj0buTC58NW65aH4cKIQFB4iRyHRzbO
 TWR0AthcqCIB6R0xOUx+HaDt8erCDViPTRy7/AJD6uO/Nw6HrkjyI/U
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfX11aboZMD5pTq
 lLD/k9inh1Rrwuh4s0AXaEY4EaqeS49mpBEoLufSjMvmEgs31SsEkebA/W99fYPwqUbFmEqCTAy
 MBuc79d3XWpbG15iMY9i7Ko8N6WC79BJ1EVm9L6tfimIMUrSIx+l1nno+ZVgT1lLraF8IrG0eaj
 2fQ4+QNMWN3wQ7CQs/Z+1WwGHm8169E8fwerUASFwySpKqvLpiptHmuCLBTNEcLu8fPwdkDncF2
 TbZmf0LvAX5hQBcgVlOE9HZQCNtMMaDP8WtHVgR7/W/p/b84qCVIpfjd6Q8i2XY5SCBOB43Cxab
 ezp414VLaMgAijZIob78jMm4QZWr3jcQuvwzl4XIhrpkCUpMG6FoC8+h38XxXQNMfDfsxFl4okB
 VEnC4sScVvFqJ2O6SgqPbGNbv5gy1ZQyl55Wg+bFXVjd2TDATICoyTlxLXeX9zNpXrLpayUvqtO
 wQCdxUQ0YY8DJhpoHZQ==
X-Proofpoint-GUID: KFdOXJ1GgcvOWfnSzb3-qU4ZgZhCXVh5
X-Proofpoint-ORIG-GUID: KFdOXJ1GgcvOWfnSzb3-qU4ZgZhCXVh5
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=6a10295a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=A_fZCR7qwrwYhkduS1cA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220099
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36795-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 088D95B19DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the runtime_get() and runtime_put() function pointers from the MHI
controller and replace their call sites with direct calls to
pm_runtime_get() and pm_runtime_put(). Also add pm_runtime_mark_last_busy()
before each pm_runtime_put() call to properly update the last busy
timestamp for autosuspend.

The removed callbacks provided no additional logic beyond wrapping the PM
runtime APIs, so eliminate the indirection and the requirement for drivers
to implement these no-op callbacks.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/bus/mhi/host/init.c     |  1 -
 drivers/bus/mhi/host/internal.h |  7 +++++--
 drivers/bus/mhi/host/main.c     | 19 ++++++++++++-------
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 0a728ca2c494..9f3ee4a14418 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -927,7 +927,6 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	int ret, i;
 
 	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
-	    !mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
 	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
 	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs ||
 	    !mhi_cntrl->irq || !mhi_cntrl->reg_len)
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 7b0ee5e3a12d..a7493aabc6fa 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -7,6 +7,8 @@
 #ifndef _MHI_INT_H
 #define _MHI_INT_H
 
+#include <linux/pm_runtime.h>
+
 #include "../common.h"
 
 extern const struct bus_type mhi_bus_type;
@@ -352,8 +354,9 @@ static inline bool mhi_is_active(struct mhi_controller *mhi_cntrl)
 static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
 {
 	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
-	mhi_cntrl->runtime_get(mhi_cntrl);
-	mhi_cntrl->runtime_put(mhi_cntrl);
+	pm_runtime_get(mhi_cntrl->cntrl_dev);
+	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+	pm_runtime_put(mhi_cntrl->cntrl_dev);
 }
 
 /* Register access methods */
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 53c0ffe30070..71919c2e9462 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -661,7 +661,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 			if (mhi_chan->dir == DMA_TO_DEVICE) {
 				atomic_dec(&mhi_cntrl->pending_pkts);
 				/* Release the reference got from mhi_queue() */
-				mhi_cntrl->runtime_put(mhi_cntrl);
+				pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+				pm_runtime_put(mhi_cntrl->cntrl_dev);
 			}
 
 			read_lock_bh(&mhi_chan->lock);
@@ -1138,7 +1139,7 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	 * for host->device buffer, balanced put is done on buffer completion
 	 * for device->host buffer, balanced put is after ringing the DB
 	 */
-	mhi_cntrl->runtime_get(mhi_cntrl);
+	pm_runtime_get(mhi_cntrl->cntrl_dev);
 
 	/* Assert dev_wake (to exit/prevent M1/M2)*/
 	mhi_cntrl->wake_toggle(mhi_cntrl);
@@ -1149,8 +1150,10 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
 		mhi_ring_chan_db(mhi_cntrl, mhi_chan);
 
-	if (dir == DMA_FROM_DEVICE)
-		mhi_cntrl->runtime_put(mhi_cntrl);
+	if (dir == DMA_FROM_DEVICE) {
+		pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+		pm_runtime_put(mhi_cntrl->cntrl_dev);
+	}
 
 	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
 
@@ -1352,7 +1355,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
 	if (ret)
 		return ret;
-	mhi_cntrl->runtime_get(mhi_cntrl);
+	pm_runtime_get(mhi_cntrl->cntrl_dev);
 
 	reinit_completion(&mhi_chan->completion);
 	ret = mhi_send_cmd(mhi_cntrl, mhi_chan, cmd);
@@ -1383,7 +1386,8 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 
 	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, TPS("Updated"));
 exit_channel_update:
-	mhi_cntrl->runtime_put(mhi_cntrl);
+	pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+	pm_runtime_put(mhi_cntrl->cntrl_dev);
 	mhi_device_put(mhi_cntrl->mhi_dev);
 
 	return ret;
@@ -1524,7 +1528,8 @@ static void mhi_reset_data_chan(struct mhi_controller *mhi_cntrl,
 		if (mhi_chan->dir == DMA_TO_DEVICE) {
 			atomic_dec(&mhi_cntrl->pending_pkts);
 			/* Release the reference got from mhi_queue() */
-			mhi_cntrl->runtime_put(mhi_cntrl);
+			pm_runtime_mark_last_busy(mhi_cntrl->cntrl_dev);
+			pm_runtime_put(mhi_cntrl->cntrl_dev);
 		}
 
 		if (!buf_info->pre_mapped)

-- 
2.34.1


