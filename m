Return-Path: <linux-wireless+bounces-32445-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EFGDIjcp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32445-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AEF1FB7AD
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAE7A309D08F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D56834D937;
	Wed,  4 Mar 2026 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SFkn2bXD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K2nNx7Qu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4534DCE3
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608593; cv=none; b=Ust7sBbfvQFLCLN+xHKHsGByU+t2wEXIYhH6BoD2wOHuSkHe7Oug0puhWUSQTqc/SpNUVsd8aM4spxxee47ZB1Dq/D/t1v8QK9epUN4Jcj5vuSmObQ6lw40tP2cpseXs7oyxIszuAq3VK0XlX+FKe8WhPjnEHe5NRlVmUi8gJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608593; c=relaxed/simple;
	bh=levkQ023BHd5B045KVOIxs/UAaiwBQthQow3XkK4AK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hirShLEw6Jle6suK1QipR7EMQVVUYuat2PYrcdCTsLNTEQmLGdbW79NwDFbeZB+irUYCnhmDibz0gyTWC3TFi8+AfAxXGxRDjArIXD5tLujl7g8N0HlF81l3Y6NNNmhPC8u3z6RIgtce++UP310S0lhkDLH7H3VryQx0OMGOggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SFkn2bXD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K2nNx7Qu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SeAB3110655
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7sQf5Wi5bR9
	sJquvPdIZYMGDe3S2FXEFCOImEDE6uDU=; b=SFkn2bXDkcAklCBxtfnZnR6dc4t
	u8imu7tcDTGxa8KI3vOcqRUJxQfM/kwMHAthgYMyAdJbLWkhizJ/uv5u2op8dOIv
	cZ2YCzMFwsiRau/RclL/YhwJeWpWrgPND6M/L3gUstP19y7Ky4a7ukeP73MdYaM2
	BJA2fKDFCSGTw41S6OdLXyxDRSO83cK/l7FczPnb0Vx5zmWjivXEsdbnzfRwoaYK
	/3uJsgyDLbYsvEiugL4KKWjze1XURFvmMrzIJui9X0LxtkhiyZpiHZPgEoo2rnj4
	736rarpNoX0oKxLZyjWFQuN8tUJ8YXDd+qz67+JJv3MVeyJRMcI+lMh8qzg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp5h2a443-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35449510446so6226404a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608591; x=1773213391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sQf5Wi5bR9sJquvPdIZYMGDe3S2FXEFCOImEDE6uDU=;
        b=K2nNx7QukmVQBAG3FcCAv2BEPnXuHlClyC9FLbJXAXA/HN6TrQTDWemn8M8+OVgDY7
         AagggCw/A8WTD2FI9/pkhVBKdjzcDpkU9cGWK5JEper6pkfV9DBAXDB3l+6f6cOIDkX+
         yQCtTKme3hE5nde6TR8i8F5cryEThXs2EhKavI0vGeh4KuNpGUf5ZpinBxmxr1FrkQsP
         fDFtCiI5VSxkObswhoa87zwQ6APE+mEk9u4lJPZ/FspIpgRrq32Y313oPCOXVsYn4x92
         50ccrgH524yrkqXrpBs/kRP8xFae0/ZSq+a5Z/+w3FbWa7y13Eq48sNu3wcjxS6zwm2p
         K8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608591; x=1773213391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sQf5Wi5bR9sJquvPdIZYMGDe3S2FXEFCOImEDE6uDU=;
        b=Ew0hbzH5IVkBX/yiITFc1lKIe6nIQ5Us6UtB1QLIRYbel4WIUbG0QB/Pn6Mh8+BNPe
         WdzaHEgM2qNZ8mUPN/tQtDTbaOpo9yOlCOinWcV05KnK9BUXOoNul3EQcJBxzM6g3har
         aY6cwcBaVWgre7NW9obeDMoQq8j5pZDeCq+HJsvSwGCaNs/0je1Jzw8pdCtloKrC0Gae
         GBQ3xvvReU0Y1YjWSBuBu9CKRwe2FaifXDSNBhpisSTMAxhQ0mtF36Q4hnl/64nVW6cr
         ylUf+/xXZHO7Ov9PsyWgkKErFFOjOWN2Dt4Zy6BhZBBMXamuXMvHSYsvcXGgQUYZJ5LC
         Fh9Q==
X-Gm-Message-State: AOJu0YxgbFx+QX1vrVQkwpwk6Rv4r91nUDZNFT+fxDefEyWDOpgDEYum
	2e4LQ2ytRHARKUlWzQ0xUkxvKxebNyRZJ1IXjrSEk4xKKa1wf4EJkaUveQytJ/7k+cSCy7V2OqG
	Upvjo4P15TK9O8Zk2eZ2b3D/kx3b3Vo4ls4E0UzvpslUTF/GUrMPRsYY6rnVHNE3Rt8jV
X-Gm-Gg: ATEYQzxwPLF72G16BJlYSNPPXE37L0F5ZX7c2Bl5WwsN7U0go/oZmDEUpcGpHsRObZb
	CHgXTqBUbGPlt3Gx+qkkx6xqzLF2U8qJQcJIaAL5AQrIfNWK833RCzUMSiWwfZOZh/jcHnE3n+e
	TEtP5t5C8iq2S2wd7xoENfoVs5QkKaSP3mahLb1M+L+phdojjZbAn3fJMBCjtkAkEH1EMgZFQS1
	JSCLkq20EgyQJc0aS5wUS1scLyOmn4SCh2QtuM9plnmQkAusdRiP1q9ffe0dwB6yiRccsVCaOyn
	E73CQw/HWichiJ0A5S5qv0tevp/4GmCHbeAkPrK9nl5wfDL1qF7QJEqj5i2SHnzaV/KVWMOLAUF
	2oJTf7sr6EofG4j24sd1HMDvxSWCkO+HdfrAMZHE0mtWgKP7Bx7fk4r4=
X-Received: by 2002:a05:6a20:160f:b0:38e:9220:ebbe with SMTP id adf61e73a8af0-3982ded0798mr1190609637.23.1772608591421;
        Tue, 03 Mar 2026 23:16:31 -0800 (PST)
X-Received: by 2002:a05:6a20:160f:b0:38e:9220:ebbe with SMTP id adf61e73a8af0-3982ded0798mr1190557637.23.1772608590157;
        Tue, 03 Mar 2026 23:16:30 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:29 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 09/16] wifi: cfg80211: add role-based PD peer limits
Date: Wed,  4 Mar 2026 12:45:31 +0530
Message-Id: <20260304071538.3833062-10-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=69a7dc50 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=EJHOIViBTtb90ylm7p4A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: yVxE4fl9wvGT7f_Y0bdR4UConyVrfzt4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX+XtwCL1fxmeT
 5jiinuinsUFK8WjjQgKpxdzpDuzeIwrk+cOwm1X0Rb0LMWh48b8ovDg8/I2UhmynfLD52iAnX7A
 iowKtQlaY6aiJDzFJEzRRvDDA9bzxtewokezGg74XbgylK+KMbM9wNwuqhBJX0U/o5Gj9IJ8gDs
 4BHkmDZK60vocaQIr3nHc2ZnjHY96CSoXV5iPl7GKa1NnajkFPMm4StFcinuKNk3sm1lLjODNNm
 ocM7/8A6UkAK8w9P8I03vSn2y4Of4yLTYfk6dzkWTnxB2RVIse5X46T0VAyOYw8Xs0YIUsiRQ/S
 wSn2/ZbojCRqe1WaekK3m5OOG3G/m5kF13hFzxfxBV8FnyCITqDOVKF2vUEMqipcOY8WZL+3K9e
 5Y/g7axDBHoBGeW1iluquux/pIWX/9xfH7kSRdTKrwjtZozUEgYT8EzMO3xpyyybM65pKjOX0Z4
 ZSDfubKHr0AnCOW1j6w==
X-Proofpoint-GUID: yVxE4fl9wvGT7f_Y0bdR4UConyVrfzt4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040058
X-Rspamd-Queue-Id: E3AEF1FB7AD
X-Rspamd-Server: lfdr
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32445-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Peer measurement capabilities currently advertise a single maximum
peer count regardless of device role for proximity detection (PD).
Some devices support different peer limits when operating as PD
initiator versus PD responder.

Introduce separate peer limit capabilities for each PD role. When a
device supports concurrent initiator and responder operation,
enforce the sum of both limits to prevent resource oversubscription.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h | 16 ++++++++++++++++
 net/wireless/nl80211.c       | 12 ++++++++++++
 net/wireless/pmsr.c          | 32 ++++++++++++++++++++++++++++----
 4 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index febd7bf50d88..8bbca2a98ac1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5776,6 +5776,16 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	multi-peer request this will indicate if the device can act
  *	simultaneously as initiator and a responder. Only valid if @pd_support
  *	is set.
+ * @pd_max_peer_ista_role: Maximum number of peers allowed for a device
+ *	operating in the ISTA role under proximity detection. Only valid if
+ *	@pd_support is set. Sum of both @pd_max_peer_ista_role and
+ *	@pd_max_peer_rsta_role is considered to enforce the max peers supported
+ *	in case the request is of peer-to-peer PD type.
+ * @pd_max_peer_rsta_role: Maximum number of peers allowed for a device
+ *	operating in the RSTA role under proximity detection. Only valid if
+ *	@pd_support is set. Sum of both @pd_max_peer_ista_role and
+ *	@pd_max_peer_rsta_role is considered to enforce the max peers supported
+ *	in case the request is of peer-to-peer PD type
  * @ftm: FTM measurement data
  * @ftm.supported: FTM measurement is supported
  * @ftm.asap: ASAP-mode is supported
@@ -5820,6 +5830,8 @@ struct cfg80211_pmsr_capabilities {
 	   randomize_mac_addr:1,
 	   pd_support:1,
 	   pd_concurrent_ista_rsta_support:1;
+	u32 pd_max_peer_ista_role;
+	u32 pd_max_peer_rsta_role;
 
 	struct {
 		u32 preambles;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 67cc1ce6d2a1..83d2a822c770 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7841,6 +7841,20 @@ enum nl80211_peer_measurement_peer_attrs {
  *	multi-peer request, the device can act simultaneously as initiator and
  *	a responder, where the multiple requests are being processed
  *	simultaneously
+ * @NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE: u32 attribute indicating the
+ *	maximum number of peers allowed for a device operating in the ISTA
+ *	(Initiator STA) role under proximity detection. Only valid if
+ *	%NL80211_PMSR_ATTR_PD_SUPPORT is set. Sum of both
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
+ *	max peers supported in case the request is of peer-to-peer PD type
+ * @NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE: u32 attribute indicating the
+ *	maximum number of peers allowed for a device operating in the RSTA
+ *	(Responder STA) role under proximity detection. Only valid if
+ *	%NL80211_PMSR_ATTR_PD_SUPPORT is set. Sum of both
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
+ *	%NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
+ *	max peers supported in case the request is of peer-to-peer PD type
  *
  * @NUM_NL80211_PMSR_ATTR: internal
  * @NL80211_PMSR_ATTR_MAX: highest attribute number
@@ -7855,6 +7869,8 @@ enum nl80211_peer_measurement_attrs {
 	NL80211_PMSR_ATTR_PEERS,
 	NL80211_PMSR_ATTR_PD_SUPPORT,
 	NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT,
+	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE,
+	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
 
 	/* keep last */
 	NUM_NL80211_PMSR_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2b7de56c466f..5222ac8e8471 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -418,6 +418,8 @@ nl80211_pmsr_attr_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 	[NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT] = {
 		.type = NLA_REJECT
 	},
+	[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE] = { .type = NLA_REJECT },
+	[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE] = { .type = NLA_REJECT },
 };
 
 static const struct nla_policy
@@ -2450,6 +2452,16 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
 		    nla_put_flag(msg,
 				 NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT))
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
 	caps = nla_nest_start_noflag(msg, NL80211_PMSR_ATTR_TYPE_CAPA);
 	if (!caps)
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index a230bb95f5e3..3ca0e589d7cc 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -317,12 +317,15 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
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
@@ -337,7 +340,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 	nla_for_each_nested(peer, peers, rem) {
 		count++;
 
-		if (count > rdev->wiphy.pmsr_capa->max_peers) {
+		if (count > capa->max_peers) {
 			NL_SET_ERR_MSG_ATTR(info->extack, peer,
 					    "Too many peers used");
 			return -EINVAL;
@@ -353,7 +356,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 		req->timeout = nla_get_u32(info->attrs[NL80211_ATTR_TIMEOUT]);
 
 	if (info->attrs[NL80211_ATTR_MAC]) {
-		if (!rdev->wiphy.pmsr_capa->randomize_mac_addr) {
+		if (!capa->randomize_mac_addr) {
 			NL_SET_ERR_MSG_ATTR(info->extack,
 					    info->attrs[NL80211_ATTR_MAC],
 					    "device cannot randomize MAC address");
@@ -378,6 +381,27 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 			goto out_err;
 		idx++;
 	}
+
+	/* Count PD requests and validate against PD peer limits */
+	if (capa->pd_support) {
+		pd_count = 0;
+
+		max_pd_peers = capa->pd_max_peer_ista_role +
+			       capa->pd_max_peer_rsta_role;
+
+		for (idx = 0; idx < req->n_peers; idx++) {
+			if (req->peers[idx].pd_request) {
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


