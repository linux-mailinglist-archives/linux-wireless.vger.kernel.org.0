Return-Path: <linux-wireless+bounces-33605-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP2eEDSMvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33605-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:04:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FAD2DF211
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC189308743F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82C13DEAC2;
	Fri, 20 Mar 2026 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WrqQ+qu4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="knKMVyjy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367B3176E0
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029657; cv=none; b=BNUAc3rkeYvFsb28taVnBNHAU0AewoOiyQGH2o9sXVwiLHEGGezgBmtpUFc6P9qp4nfafo4XS/D0J6ww0vLLMhglGMuikMZrW9zS0CgxivjguOwsaq6E2GNqAKMtjeK73/aMwqiRcTZPzzdrNvjUkRbsrIQx4eyUnH5kZrV/YN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029657; c=relaxed/simple;
	bh=gIgZPO0+UO2yjwwwhpd0tWhUZg9C50wu2NniGKqQO1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9CQzItvZyFkHt3nNE2NeMjB89EbG/21KC4x9EdBoNIGh14xq/XHbdalz9/I+5d7LvxJyI8VzWeI4PKU5ITEr/zkmpb0/BXi8tA3zgtELGdmXQUC9RUz6y//GQLmlNVC9sKHEfA+XJ7OSoOsLh8493BlhBnBq36edrBl/rssV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WrqQ+qu4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=knKMVyjy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KEgw183557797
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+q07IyeUh32
	qgD24zdYiIDHNA20PyKpj/cM/y+e/Y10=; b=WrqQ+qu4JJEx/IN3mOAUDLeHFGt
	LBQ5Qh+6Erw/w1DIdtLPR8HkiwORBfeW+e7gTpKOiOxjLAqbKJpFvfW0Y2HmDeq2
	XiJKVt7QQzUvV4rw5kWxtyqPG8ITNau5wt3zmDtWJm4UHnb8BHJLLtELv4Riwllg
	IgoUkyIyApPBrnWuucceOFVVJwhRssXcpOUJUg9niNPM+T0DfbFT71OIzKYIwI7l
	Xj4ud0cN0mDsu6EH0RrkA0XtJj5NsrYCrlDuOEZ85zV0DHXA/20kbF4AHRlXgJQV
	94CgU4XbNqKix5y82fzudwzWZiPOCqxAtujeZjRl17wyczMw8iy1ptQWvFA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0r1gtytf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b05370ec01so125425355ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029653; x=1774634453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+q07IyeUh32qgD24zdYiIDHNA20PyKpj/cM/y+e/Y10=;
        b=knKMVyjydBYFm+ykOzATBAQAfKoQ7HtCI5UQ3KIh38i9W6HdbPv5SfjADRPQX+Hf2Q
         xMB0gkJxEdazi8eEv4yxCF2mSepCasQQquPccjOVxfoZT/VS+x8J09MDmJb40FS3jjL2
         Atm8DGcjKV6V+16mZI8z0PoewpjWUngSJT+N8q8nq8M/B//XaMFVvhAGRTxAGZt3f6uA
         w67mRZnsNBMCf3uj1CAZMbwWYsjNqim455FDZV3WUhKllx/8PjFFb2ZZWq8yJP/BAOxQ
         SAZGT4ZvEyOdGX/DU5jCbwe/9PS5spPUzIuJlhzmk8nJufuhXP0VjSMo7ry2VCmChCAz
         c5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029653; x=1774634453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+q07IyeUh32qgD24zdYiIDHNA20PyKpj/cM/y+e/Y10=;
        b=oYvhmsdmXyGfPzFh67n7CCoy8ktkCKCHKGn7RG/5FI7PzIX1P91LILIzKaNR+CgoUb
         BbT9PqmvLcYCHTxnfoG5sxgU++gTLQw8wseuvWjf4BljR6UdH+FcOjHht/boNaSPaGLr
         C6BLMqXCdb/l5jM8n/xNzNnJkF2tBuNNGaHM97tP+wZDT3RQD0KtpyTQFWoJfXuXwpTP
         usM/DlvhZZ5ZOtRYTP3QkNfqSrnRHfPL9IaOhJ/9qPN/6FAEyDuJAJXrxvJPSwU4wmww
         dI3TzFwoJU01u6gI8bhoj+kQ/teH6rUq+ZdIjKC+ih1He41Qin71D14Ki0+7IvLAttoS
         L7Gw==
X-Gm-Message-State: AOJu0YwKtgeQSEH98Kziky8U1Rcipd5AqCknTd0G9i4yY2AKB621FVs7
	6MNecXslN31IceVX0eMruItpMGWbNYjd6AM2skw6Vha4R2H7owH8beiZpIm+PYXSoDbszHKT5I9
	/29eA6FtR80tB00NEck07ODr7bjunsFwpoAYXc1O+iq81NGY5HqEJm33vHofAByXCsEBM
X-Gm-Gg: ATEYQzzQv8np8Q11CNk5qX2LqNlr8WqOJalF0QlYBRBkuq5Eh6bQCP54jG6udFFJbXK
	fdYZfrx5RtoUB/E+klVyjvA+awDeiNaDkOwz62wZaW85wrehDgWTVgdx4eRk00BPW6Yiz/eKvYC
	n/3CJU3kvg3DPGxJdDId5+pMvgVybVmPJUkKKwOv2ZIwhe2MKXCI56oZiZVVJWpaGewS+82RoQr
	PRKl3URhoOyb6QzswR5bUh7m2TYo37Wz/iS0JCzVxITqIaeHNF0s4XXRZtKdZsI2dY7cfnbDHBh
	xPs3II+ZDE9FfdqfQeTIvS6N8rIkP9zDODUeaaOZaXL6JHfE99COyRLocKNRdvtaB4GpNE9utvi
	OgnXr20ELIznzfARETm/xSyPT5/hquVqoM+AwsV+YEwFw0zwjGJ0V53g=
X-Received: by 2002:a17:902:d590:b0:2ae:a928:f540 with SMTP id d9443c01a7336-2b0826d758cmr37912015ad.6.1774029652321;
        Fri, 20 Mar 2026 11:00:52 -0700 (PDT)
X-Received: by 2002:a17:902:d590:b0:2ae:a928:f540 with SMTP id d9443c01a7336-2b0826d758cmr37911665ad.6.1774029651498;
        Fri, 20 Mar 2026 11:00:51 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:48 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 09/14] wifi: cfg80211: add role-based PD peer limits
Date: Fri, 20 Mar 2026 23:29:33 +0530
Message-Id: <20260320175938.2547288-10-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
References: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfX1ISGwLjTkMf6
 Dt0fyq+zEu7ogu0jKkZO0UPDCh7vYWsqhC8Up4AODYfrPkI18EeZ2OOs49pynRRYoXmd6Hl+1qj
 g+xth8evfhNibDvvpoHep2Y/EvjAORLwIVbEgA8JY5oOzoJkMr82HXh/YAhCrY9M8Ggjt8yE1A6
 U7TNcLUmG37T30zQC3ZPpkdo5u02DZVuVYwaC9CPqdqvOBGH+n4mBqR9c525VLePGk8ub4irN/o
 FIFH4C1GS9/3GqIRGmDl3SPSR+UrsBVceV+1bR15lB9oDvSLbcaWzFYeTs/jdbyrc/3DsDFLlMs
 ItZyWZlrdQQCbw6PDqUIZJusyg8gjM5zEFcOxxU0eribGZkVpL+SZc5tBG4G82GlMz3Alx/FQG3
 DsJ1lSVikrlMs74t5eOSISMIFvD5pSfbkWRy5sZcREMoN4Yh/qhgzShxC5zgyT/Ja3rLaePorpI
 8iFzkeqOwa0JrzHOSlw==
X-Proofpoint-GUID: SCifdHWlE4tb1YrOGgLtYd3I8G64GiW6
X-Proofpoint-ORIG-GUID: SCifdHWlE4tb1YrOGgLtYd3I8G64GiW6
X-Authority-Analysis: v=2.4 cv=Y/D1cxeN c=1 sm=1 tr=0 ts=69bd8b55 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=jiiNpTFZAD9lvbD-ipUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200146
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33605-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B6FAD2DF211
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Peer measurement capabilities currently advertise a single maximum
peer count regardless of device role for proximity detection (PD).
Some devices support different peer limits when operating as PD
initiator versus PD responder.

Introduce separate peer limit capabilities for each PD role. When a
device supports concurrent initiator and responder operation,
enforce the sum of both limits to prevent resource oversubscription.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 13 +++++++++++++
 include/uapi/linux/nl80211.h | 16 ++++++++++++++++
 net/wireless/nl80211.c       | 10 ++++++++++
 net/wireless/pmsr.c          | 32 ++++++++++++++++++++++++++++----
 4 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e1593ca8a1f..9437533d0edf 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5780,6 +5780,16 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  * @max_peers: maximum number of peers in a single measurement
  * @report_ap_tsf: can report assoc AP's TSF for radio resource measurement
  * @randomize_mac_addr: can randomize MAC address for measurement
+ * @pd_max_peer_ista_role: Maximum number of peers allowed for a device
+ *	operating in the ISTA role under proximity detection. Only valid if
+ *	@pd_support is set. Sum of both @pd_max_peer_ista_role and
+ *	@pd_max_peer_rsta_role is considered to enforce the max peers supported
+ *	in case the request is of peer-to-peer PD type.
+ * @pd_max_peer_rsta_role: Maximum number of peers allowed for a device
+ *	operating in the RSTA role under proximity detection. Only valid if
+ *	@pd_support is set. Sum of both @pd_max_peer_ista_role and
+ *	@pd_max_peer_rsta_role is considered to enforce the max peers supported
+ *	in case the request is of peer-to-peer PD type.
  * @ftm: FTM measurement data
  * @ftm.supported: FTM measurement is supported
  * @ftm.asap: ASAP-mode is supported
@@ -5841,6 +5851,9 @@ struct cfg80211_pmsr_capabilities {
 	u8 report_ap_tsf:1,
 	   randomize_mac_addr:1;
 
+	u32 pd_max_peer_ista_role;
+	u32 pd_max_peer_rsta_role;
+
 	struct {
 		u32 preambles;
 		u32 bandwidths;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4b6f555ca850..1217fe492af7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7838,6 +7838,20 @@ enum nl80211_peer_measurement_peer_attrs {
  *	meaningless, just a list of peers to measure with, with the
  *	sub-attributes taken from
  *	&enum nl80211_peer_measurement_peer_attrs.
+ * @NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE: u32 attribute indicating the
+ *	maximum number of peers allowed for a device operating in the ISTA
+ *	(Initiator STA) role under proximity detection. Only valid if
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_PD_SUPPORT is set. Sum of both
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
+ *	max peers supported in case the request is of peer-to-peer PD type.
+ * @NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE: u32 attribute indicating the
+ *	maximum number of peers allowed for a device operating in the RSTA
+ *	(Responder STA) role under proximity detection. Only valid if
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_PD_SUPPORT is set. Sum of both
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
+ *	max peers supported in case the request is of peer-to-peer PD type.
  *
  * @NUM_NL80211_PMSR_ATTR: internal
  * @NL80211_PMSR_ATTR_MAX: highest attribute number
@@ -7850,6 +7864,8 @@ enum nl80211_peer_measurement_attrs {
 	NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR,
 	NL80211_PMSR_ATTR_TYPE_CAPA,
 	NL80211_PMSR_ATTR_PEERS,
+	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE,
+	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
 
 	/* keep last */
 	NUM_NL80211_PMSR_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8bcc4aa6514e..98eef98939c1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2469,6 +2469,16 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 		if (cap->ftm.pd_concurrent_ista_rsta_support &&
 		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT))
 			return -ENOBUFS;
+
+		if (cap->pd_max_peer_ista_role &&
+		    nla_put_u32(msg, NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE,
+				cap->pd_max_peer_ista_role))
+			return -ENOBUFS;
+
+		if (cap->pd_max_peer_rsta_role &&
+		    nla_put_u32(msg, NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
+				cap->pd_max_peer_rsta_role))
+			return -ENOBUFS;
 	}
 	nla_nest_end(msg, ftm);
 	return 0;
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index a4348535d2ed..d2b43bf584a9 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -355,12 +355,15 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *reqattr = info->attrs[NL80211_ATTR_PEER_MEASUREMENTS];
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	int count, rem, err, idx, pd_count, max_pd_peers;
 	struct wireless_dev *wdev = info->user_ptr[1];
+	const struct cfg80211_pmsr_capabilities *capa;
 	struct cfg80211_pmsr_request *req;
 	struct nlattr *peers, *peer;
-	int count, rem, err, idx;
 
-	if (!rdev->wiphy.pmsr_capa)
+	capa = rdev->wiphy.pmsr_capa;
+
+	if (!capa)
 		return -EOPNOTSUPP;
 
 	if (!reqattr)
@@ -375,7 +378,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 	nla_for_each_nested(peer, peers, rem) {
 		count++;
 
-		if (count > rdev->wiphy.pmsr_capa->max_peers) {
+		if (count > capa->max_peers) {
 			NL_SET_ERR_MSG_ATTR(info->extack, peer,
 					    "Too many peers used");
 			return -EINVAL;
@@ -391,7 +394,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 		req->timeout = nla_get_u32(info->attrs[NL80211_ATTR_TIMEOUT]);
 
 	if (info->attrs[NL80211_ATTR_MAC]) {
-		if (!rdev->wiphy.pmsr_capa->randomize_mac_addr) {
+		if (!capa->randomize_mac_addr) {
 			NL_SET_ERR_MSG_ATTR(info->extack,
 					    info->attrs[NL80211_ATTR_MAC],
 					    "device cannot randomize MAC address");
@@ -416,6 +419,27 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 			goto out_err;
 		idx++;
 	}
+
+	/* Count PD requests and validate against PD peer limits */
+	if (capa->ftm.pd_support) {
+		pd_count = 0;
+
+		max_pd_peers = capa->pd_max_peer_ista_role +
+			       capa->pd_max_peer_rsta_role;
+
+		for (idx = 0; idx < req->n_peers; idx++) {
+			if (req->peers[idx].ftm.pd_request) {
+				pd_count++;
+
+				if (pd_count > max_pd_peers) {
+					NL_SET_ERR_MSG(info->extack,
+						       "Too many PD peers used");
+					err = -EINVAL;
+					goto out_err;
+				}
+			}
+		}
+	}
 	req->cookie = cfg80211_assign_cookie(rdev);
 	req->nl_portid = info->snd_portid;
 
-- 
2.34.1


