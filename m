Return-Path: <linux-wireless+bounces-31385-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BhUGsnVfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31385-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF62DBC54C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 031C7301CFF5
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E81732B992;
	Fri, 30 Jan 2026 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G8wUPvZZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lm9LdK5I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9F342C98
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788860; cv=none; b=dTXJhCoISnyHotyoOPuQiVy8CqIMl+eZaP0OJbL4qu+7MQFZCHecYXr5cvfpSxIyZohquxK/t62K3QVnzx59GF+MiqYQqByimdHH1buswZyX8GP9UowXwQlulD/oz/VPcVIVLMDnsVhBG9pQvLstB+6EGHFEuJJIxJnYroPa9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788860; c=relaxed/simple;
	bh=zvY7dVSdhuT4wFIFppLsaAe9OuZ4GxvjKtk4UyW2Hzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBCyvXaz/ccof9xJ2IaDmZbMUlcKmrRKr6h/ST1l/LaR6hEklrctEuuG0tv003o3HnjZMgyoI3jqRTh46xWGGE6OQabjkSffVJzsrGpTWuhkTAayXZMFkeMg7V4aqPIpmasfhtZ9F3bUdHYous/D7KlrUvzngkzg221rXtw+MEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G8wUPvZZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lm9LdK5I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAIPrH485884
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rtQn5QLF/US
	FWvJA+doSTMKQaRWhYW9wXfYu4cXMFyo=; b=G8wUPvZZlHZ2KX9+iL5zb4mY5ah
	Bsb9GG9R9G3glWA/tk2b18LFGGMt9enig95Mqzf83eEmFQRIIKQsdOtGxB3AZgUR
	I7aFvSJan8ryAJpXTxQI6nxDoQ57/khp5Mx+NjBBLJHFv5dwsSBl4x6vsLZZ/nRA
	JLK40u9xCAQCBYhZsSKoNfomOtFQVeOnvMXJQRQ9nzdhPpezCtfm7FVfEZREnpHX
	szKUh5atrFEPJn69hVFK4MJvXORTpsAyeXA69cNdaRlSl/W9CzWoliTd8urDDMDs
	hVn+5jxH/Q8SRMDIGShacZeF4QYKipY7Ou3CuuMHJR+Kvt9sfanBkwzdqAg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0gtnjrg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:00:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-352ec74a925so3949380a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788857; x=1770393657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtQn5QLF/USFWvJA+doSTMKQaRWhYW9wXfYu4cXMFyo=;
        b=Lm9LdK5IAh2okFedapUAe6/+RdLbRKgGHwYufMlo61kd5mrz3bJB+ASRBHeg5AhQXR
         PtaFifXxTWon8fgrO5zvnq6XM30P7fK6THXCuchUc2lWetG+pYej1KrWXO6vdGxGLHfK
         QyMK2J2xPzXc3kualqtozR778sXVot/EnZ+hmXTT4dCgEkkkYkXNMS34W3uZ5mcOSknS
         VCFUa1S1Dke6ShQS7xI06qfqmXJBQZYF9L8Kcl9zS92M2HKHfZyZrGD9aLIPhijUNm6a
         4mKMQbtl9vF755K0Wlu4wcejxA/JTrE1/GN66/1JJaEJK/kMgmXZkNnXm1vi7NQ2l8rH
         a2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788857; x=1770393657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rtQn5QLF/USFWvJA+doSTMKQaRWhYW9wXfYu4cXMFyo=;
        b=h8L/jdXAlpsf+uEeq8ZDv+b61OHcujbRGi5DS/oXx9WC9/Cmgw4JdJwUzKV9eg+a7Y
         PwqfWupS2cuLzMHsF0vVYGINx4/Qaw2Mph8vOCuKpWl/eMvHTMnPP5ms9PboGaJEyWsk
         1RHKusyzDuKo+a0WbeTmCYVivRkJfoG3urUM2MTfQxGlaQMlGXm2yQ3WDWjtuxZ55aiI
         wYXCsfwGCTd2myWBZA34efD2AXd7hNz9A18GUwtqedA+cSJq94ivZEFuKo2dt08g6Pk4
         K0rk4BBNXF+fAt4LvtzBnNLDNL7jWV7aIW85khB9ecRyY1wfklvHz1oSoa4HjdAS1qvz
         +HIA==
X-Gm-Message-State: AOJu0YwcC0ps4bBY2sQBLwHopMYPjOKWAGJfOSk7kG6hF7YjXGnpSRlu
	JqOJqSIBUh2wDUwrlLmN4vrL4GSakuDqTiruyjnsL7+P7z6eL6lI5xG4yLxuMykGIfErH7X2cYv
	jxTrV2zF3X2Fc4IENyNeFjDaaOSQHedoMbZk0VBv9hpAhOvayxeCJlFktYl11dWG+pbmD
X-Gm-Gg: AZuq6aIfWAsJJ9VGfEKHGrjsHPynJJsOd7j4wF9AvpgmSkOCsiXnv1F82OT1Z8qoO+d
	nFNUVwxlB2ZuFi49/QvUXsVlI9vNHNtlriOyTYfHPxptroAoYSH/nK7XcrsZEC2aRey0Ox5WTpe
	V7rlcj5lMeT6B8rno2p370vW6S4Vo4lzVwEpV2suHwUGhQAuZjTVNLZUAluUt5Db2N1JPLxci1o
	dcUYN+hvbdagFHOKOQKVZPtnq9mUQA4H/OahYSmNeWEtxZlKCg6yOz6yEtsG3d/zp4ciXpYoahC
	m4pEoI691PKCxi7+yLeVoN3fXAe7rANvj6hfVysSygT1yBH7ga7Eah+OxV90cqDypf6EePDjtIz
	Nnl8xQeHxfc1i6efjuRHyj+D+2o3vFzumCw1Br5Db+HI=
X-Received: by 2002:a17:90b:3bc6:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-3543b2e0022mr3353085a91.2.1769788856711;
        Fri, 30 Jan 2026 08:00:56 -0800 (PST)
X-Received: by 2002:a17:90b:3bc6:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-3543b2e0022mr3353043a91.2.1769788855948;
        Fri, 30 Jan 2026 08:00:55 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:00:55 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 01/13] wifi: nl80211/cfg80211: Allow RSTA role to be enabled without LMR request
Date: Fri, 30 Jan 2026 21:30:27 +0530
Message-Id: <20260130160039.2823409-2-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yrCQ90nS8mVJHwK1VFyCTye3KBGjB80X
X-Authority-Analysis: v=2.4 cv=FPcWBuos c=1 sm=1 tr=0 ts=697cd5ba cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=iAWCBet2lP_shaMVnh8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: yrCQ90nS8mVJHwK1VFyCTye3KBGjB80X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfX9x6IslpVIAsl
 5x40TSc84oKcU43pXMQQa09vpTMyvLDdRVOFvfrmRWgBSGXf3XCp0Lsg+0vjbGeVp4SLvO1R+y7
 fwXNpl9IcQLxssUDhcdz/a/7dPkGvZsMwV72KQ99RdKOfq2wmpi3Uh01TzgTgUrXjqsxHvgx/t7
 TPNixuSogoNbC04y14qPDNmF60d46pSaNkhojqJJXe7DAZUnEXIAy57TkIheg7udCnevC0t/s1A
 UanWfeLL16s1w8QbrXt2qtuO/LIRiJEV5TVRfXXDWsuoy70mFy7/RenmcglE1pG0CiWTiPcWRTs
 wiqh46l4OoO5SzQDn5VFQBRko8dxSFH85tuVVDj8IFYPVpW8Z427WkI3DpadiFLveIrbE7FTPor
 mWAzi9C/arO8ZYF5CelHQN5WpYEFRk5og3osHID219aWiw8JmZvZef2LZET7AdZ5aqMLjUkoTnT
 C2P/Jnju4S/p6K4Q8PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31385-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[peddolla.reddy.oss.qualcomm.com:query timed out];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BF62DBC54C
X-Rspamd-Action: no action

The commit 853800c746d3 ("wifi: nl80211/cfg80211: support operating as
RSTA in PMSR FTM request") adds a check which mandates LMR to be requested
when the request is to enable RSTA, such check is incorrect in cases
where we want the device to just to act as RSTA and not wakeup the
host with measurement reports. This commit fixes this issue by removing
the mentioned check and also updating the corresponding documentation.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 5 +++--
 include/uapi/linux/nl80211.h | 4 ++--
 net/wireless/pmsr.c          | 7 -------
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7911ed58abbb..83dbe9aeab4d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4309,8 +4309,9 @@ struct cfg80211_pmsr_result {
  *		 EDCA based ranging will be used.
  * @lmr_feedback: negotiate for I2R LMR feedback. Only valid if either
  *		 @trigger_based or @non_trigger_based is set.
- * @rsta: Operate as the RSTA in the measurement. Only valid if @lmr_feedback
- *	and either @trigger_based or @non_trigger_based is set.
+ * @rsta: Operate as the RSTA in the measurement. Only valid if either
+ *	@trigger_based or @non_trigger_based is set. set @lmr_feedback
+ *	to receive measurement results in response.
  * @bss_color: the bss color of the responder. Optional. Set to zero to
  *	indicate the driver should set the BSS color. Only valid if
  *	@non_trigger_based or @trigger_based is set.
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 706a98686068..d4738bcc9914 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7897,9 +7897,9 @@ enum nl80211_peer_measurement_ftm_capa {
  *	channel specified in %NL80211_PMSR_PEER_ATTR_CHAN until it receives the
  *	FTM request from the peer or the timeout specified by
  *	%NL80211_ATTR_TIMEOUT has expired.
- *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK is set (so the
+ *	set %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK so the
  *	RSTA will have the measurement results to report back in the FTM
- *	response).
+ *	response.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 60e1e31c2185..4db6c40dd782 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -195,13 +195,6 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EOPNOTSUPP;
 	}
 
-	if (out->ftm.rsta && !out->ftm.lmr_feedback) {
-		NL_SET_ERR_MSG_ATTR(info->extack,
-				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
-				    "FTM: RSTA set without LMR feedback");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.34.1


