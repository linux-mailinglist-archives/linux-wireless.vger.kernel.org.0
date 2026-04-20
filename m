Return-Path: <linux-wireless+bounces-35029-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGdtKpLt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35029-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C489B428B07
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7F7D3014286
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886D038B159;
	Mon, 20 Apr 2026 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="duhOHiGb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YIyeUVGL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549638C42E
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676193; cv=none; b=kjV0yj4AVYI1YSlLE/HKLFnIQxOPMpHHDJAdLbYFfu84H+lj/jUwQDwOirzY4QmPl7eeP6q/jfHGPg5+rRp1r/9gx/fqBrDVwqy+XCLCklVfeDMndsYDhnEpvAZoepOFIQlDflurOZwTwn9lwmPb1n0mmZkzeQq1oAFTV0ypQE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676193; c=relaxed/simple;
	bh=xJ2ka2DfwxgZ3ovcPPe13uJuaiGfP9w187mC4Ic6i+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eduo/jgj2PwIA9YumqGDasMijwFRgN3Szt9o9wAbT8aMDuZMc0/zuxfQI4MyitGueIdi24TAkDSLl18ogkuSp6RovQMwmsq7oYV5HAYePi9ViUchmJsflJhWTeiUfC3O3B9IdNk2FJfPXFH+oC5EFh7/7NXhU/odVXY0iR2/9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=duhOHiGb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YIyeUVGL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K7WtVU1532112
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cNdKuJ291zI
	2OGKVnnDTnX9Baz+hKrmUVWH7OBhoDkQ=; b=duhOHiGbabIamDZCMYbCp9+TVHc
	Ez3FTXt4zW4L0XvmGnlx2dJu3ubpW6O1KTMDtOIIx6mjMn8YAI9cVhXGgReXYXEu
	Pc1SpQbc9gZa6xSvxKTENSaWW/lzli21fscGUgapzf2tzcBjOVaXxMQG8cOtBHaq
	coqvzTyEIu8xjFZRSXNZFUsfNhO1h5AYX11pI9h2133FE8VXBwxs0fhRBzDzEjea
	Thjb4eVtz3DN/UG6ZbwlxVWJS+NElWc467EvSQ94sUxWQp/qRZq40Bkup/p+yFG9
	DYDDfLO/3c2VV7aiMaOFt6ti2dpZ8RIYIhhiNZIWzkxNqfTO0Xaph2rrjHA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfus0nrg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35da1c703d1so3201430a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676185; x=1777280985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNdKuJ291zI2OGKVnnDTnX9Baz+hKrmUVWH7OBhoDkQ=;
        b=YIyeUVGLhpUFeiAmjf44oJ0DSgOr8gl6rO8TbnlXFMGmAIwCc7awAAwu/eXeXyOfpb
         n2Xry/E4Lf5t4JvyLhmUWnWoUIA1kWAnGoEJm/k3WTFXJ0aFtQGfDRmP1G2aWTmOhcv5
         F9VSKeEm/sD7wWh5J39SHw/o102dTh5fYRg/ff0yphxz0bEFs2sBAdk3y0Rsh43BfWGJ
         MX/mJ2faasXWORbFs8t7T/Szn4n5m8KzfapOdWpWQ8nzfOqx3//qUBe5mFQsbKewWar2
         zhKp1UlM6ReYnEoC8sh/dHg9n03YnJFc5KSIlVxte0a01mIvkEJKMcric8JJc/B0bkmn
         FK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676185; x=1777280985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cNdKuJ291zI2OGKVnnDTnX9Baz+hKrmUVWH7OBhoDkQ=;
        b=G3SJatfar4zr8ANZBhYnoI5g6rtAlc09AkWXlx8cqUOhT1RfidOeYPDFd9nz+3K2SM
         Omman6f8E2e2zu2Y33nNC33a8diA6ApU9ABbLNeDwGLL4AyIfsJjExghy5alWgP0IagQ
         3lT6eBhmoMcDXES1i0E2nXy180aOJFE6djVOsr9J2mZAUUMdBViSxqP8mbNjNn4BrZnd
         JMHlR6un9Eb/wolnr41LqiwaKWwnCIREKCmG123/fFaEKgJ/nr041sZ0r5ylpCVx4Xr3
         mChFXv+hXCyF42BYshE5cZNW5JXlJ7ncT7MTqFflOp4fLstyq43TiYDwJK7F/63db6f9
         ef+w==
X-Gm-Message-State: AOJu0YwedPFW25bkRxu5h9ldPnB+GJL3zoZXJTRuq5rttFLw/dKYEFvo
	K2ehs+NESvZOHw0z3xI7ZxUlfeXBWofOIxt6DUZzY/jMECoM9Kp84CeFwzN/tBwUT08SDf67ZXj
	p5vDxTtkQMmeJXiQymZxiTaYQ/5kNEsbj2Vx/DeKI233VG5AsCwsRZjHCEcNjn+Jaz+7F
X-Gm-Gg: AeBDieufpnzR+eNqSZwJAaAx6m17XX2Ma7taTyDOdrRrQITWV69lev/Clz/c/9+IBEs
	2HhmW95Z29d9dE6coQrHlVaT4UuZf+pzHI1qKGK8dqX9NihY7yBah5m6G9Hvx632QEMWNpQCwnd
	qdRJZHoqrgQBj9M1z4CYZ/iuopeDR5JbE5cl73Wdw++HejfDzEgRqquQ6kMz3oFXRHDWag4i4Yg
	CYp/wxeNA37jw/z99S3fbOaaAwimF6xWSY4tiOF2zQkNf/p5cc7BS6qejqTw1Xrhj0ZYELhisOT
	02hhebHms+TCpI+qlwxhX1kJ6DhWJG7+yAsHmCjJnC/GGqj50ukmCJiCQLh4flVC4QnVMr7qiod
	lAYzxdUUB3uS11PDSP2xhiDNTlUDZzvvUMgP64CMhoCUt9hKlCComaOAzi0ECRVWWeQ==
X-Received: by 2002:a17:90b:3882:b0:361:3224:2f5f with SMTP id 98e67ed59e1d1-3614049c8a4mr14430620a91.22.1776676184571;
        Mon, 20 Apr 2026 02:09:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3882:b0:361:3224:2f5f with SMTP id 98e67ed59e1d1-3614049c8a4mr14430595a91.22.1776676183979;
        Mon, 20 Apr 2026 02:09:43 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:43 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 05/13] wifi: cfg80211: add proximity detection capabilities to PMSR
Date: Mon, 20 Apr 2026 14:38:48 +0530
Message-Id: <20260420090856.2152905-6-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
References: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfXwUfXy2rnZsvL
 mwA1v1IA1N1+lotKkub5/Cn7FtwWX4pQj/gXr4NRpL1z9q0Pvar7uC1NbX4q1speuB8qYM51lRk
 ibTwC2vWBRNfgM1aix5WFs+oSwCSShRNV+1EGA/4/Jdf8nCQ/5OtJxqYDbHbGvfmploRRRsWlT0
 zWuzIzpE0+Kd4VsXyDLNHHJvnDk4Y4lmNtQn/CIKjRhMTe6117EJkxppadqTmM0jB8nkUbUFoW8
 iAC5tjNB+21acaKRWEGN0+6si8uLeRUNPAxstROKzjx/6S2Ilph27NU7/kYjG4KetUTPKhPT44T
 gmPfb6SyEEgYkATEiqxmtYS3PJNIQAOqnKSyJp+JDPZLgRAXfj1fYOYkyMHZlbqrWyXP+fQwJal
 rgqxAVkpDKilcydHC8vi+y0BpMsp+0y5ig5aY82c0+ueedMycFnOHgkzMWzgBE+BW/HVQUYHH2h
 BEo7+Mn+TrkbyDuDOiA==
X-Proofpoint-GUID: Lr0qYtLRZebcbyDWPO8XsGs5lyoIBKQt
X-Authority-Analysis: v=2.4 cv=PMQ/P/qC c=1 sm=1 tr=0 ts=69e5ed59 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=QzfdAXJDw7fyW8JDDGgA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Lr0qYtLRZebcbyDWPO8XsGs5lyoIBKQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200087
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35029-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C489B428B07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce Proximity Detection (PD) capabilities in Peer Measurement
Service (PMSR) as defined in the Wi-Fi Alliance specification
"Proximity Ranging (PR) Implementation Consideration Draft 1.9 Rev 1
section 3.3". This enables devices to advertise peer to peer ranging
support.

Restructure FTM capabilities in cfg80211_pmsr_capabilities to replace
the single support_rsta flag with nested ista and rsta sub-structs,
each carrying per-mode flags for Non-Trigger Based (NTB), Trigger Based
(TB), and EDCA based ranging. This allows drivers to advertise detailed
role and protocol support for both initiator and responder roles.

Add support to pass additional ISTA and RSTA role capabilities to
userspace using new nested ISTA_CAPS and RSTA_CAPS attributes. The
legacy RSTA_SUPPORT flag is retained for backward compatibility.

Add NL80211_PMSR_FTM_CAPA_ATTR_TYPE_CAPS nested attribute using the
nl80211_peer_measurement_ftm_type_capa enum with two sub-flags:
NL80211_PMSR_FTM_TYPE_CAPA_ATTR_INFRA_SUPPORT for STA-to-AP or
AP-to-STA ranging, and NL80211_PMSR_FTM_TYPE_CAPA_ATTR_PD_SUPPORT
for peer-to-peer ranging.

Add CONCURRENT_ISTA_RSTA_SUPPORT as a FTM capability flag indicating
the device can simultaneously act as initiator and responder in a
multi-peer measurement request.

Extend FTM capabilities with antenna configuration fields
(max_no_of_tx_antennas, max_no_of_rx_antennas) for the PR Element
during PASN negotiation, and ranging interval limits
(min_allowed_ranging_interval_edca, min_allowed_ranging_interval_ntb)
to advertise device timing constraints for EDCA and NTB-based ranging.

Update the FTM request validation path in pmsr.c to check RSTA
requests against the per-mode rsta capabilities (NTB, TB, EDCA),
rejecting requests for modes the device does not support.

Co-developed-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 60 +++++++++++++++++++++++-
 include/uapi/linux/nl80211.h | 78 +++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 91 +++++++++++++++++++++++++++++++++++-
 net/wireless/pmsr.c          | 22 ++++++++-
 4 files changed, 245 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0ab0a99fa824..16b03a074f58 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5908,7 +5908,45 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	(0 means unknown)
  * @ftm.max_total_ltf_rx: maximum total number of LTFs that can be received
  *	(0 means unknown)
- * @ftm.support_rsta: supports operating as RSTA in PMSR FTM request
+ * @ftm.ista: initiator role capabilities
+ * @ftm.ista.support_ntb: supports operating as ISTA in PMSR FTM request for
+ *	NTB ranging.
+ * @ftm.ista.support_tb: supports operating as ISTA in PMSR FTM request for
+ *	TB ranging.
+ * @ftm.ista.support_edca: supports operating as ISTA in PMSR FTM request for
+ *	EDCA based ranging.
+ * @ftm.rsta: responder role capabilities
+ * @ftm.rsta.support_ntb: supports operating as RSTA in PMSR FTM request for
+ *	NTB ranging.
+ * @ftm.rsta.support_tb: supports operating as RSTA in PMSR FTM request for
+ *	TB ranging.
+ * @ftm.rsta.support_edca: supports operating as RSTA in PMSR FTM request for
+ *	EDCA based ranging.
+ * @ftm.max_no_of_tx_antennas: maximum number of transmit antennas supported for
+ *	EDCA based ranging (0 means unknown)
+ * @ftm.max_no_of_rx_antennas: maximum number of receive antennas supported for
+ *	EDCA based ranging (0 means unknown)
+ * @ftm.min_allowed_ranging_interval_edca: Minimum EDCA ranging
+ *	interval supported by the device in milli seconds. (0 means unknown).
+ *	Applications can use this value to estimate the burst period to be
+ *	given in the FTM request for the EDCA based ranging case. If
+ *	non-zero, this value will be used to validate the burst period in
+ *	the FTM request.
+ * @ftm.min_allowed_ranging_interval_ntb: Minimum NTB ranging
+ *	interval supported by the device in milli seconds. (0 means unknown).
+ *	Applications can use this value to estimate the burst period to be
+ *	given in the FTM request for the NTB ranging case. If non-zero,
+ *	this value will be used to validate the nominal time in the FTM
+ *	request.
+ * @ftm.type: ranging type capabilities
+ * @ftm.type.infra_support: supports infrastructure ranging (STA-to-AP or
+ *	AP-to-STA) as part of Proximity Detection
+ * @ftm.type.pd_support: supports peer-to-peer ranging as mentioned in the
+ *	specification "PR Implementation Consideration Draft 1.9 rev 1" where
+ *	PD stands for proximity detection
+ * @ftm.concurrent_ista_rsta_support: indicates if the device can
+ *	simultaneously act as initiator and responder in a multi-peer
+ *	measurement request. Only valid if @ftm.rsta_support is set.
  */
 struct cfg80211_pmsr_capabilities {
 	unsigned int max_peers;
@@ -5934,7 +5972,25 @@ struct cfg80211_pmsr_capabilities {
 		u8 max_rx_sts;
 		u8 max_total_ltf_tx;
 		u8 max_total_ltf_rx;
-		u8 support_rsta:1;
+		struct {
+			u8 support_ntb:1,
+			   support_tb:1,
+			   support_edca:1;
+		} ista;
+		struct {
+			u8 support_ntb:1,
+			   support_tb:1,
+			   support_edca:1;
+		} rsta;
+		u8 max_no_of_tx_antennas;
+		u8 max_no_of_rx_antennas;
+		u32 min_allowed_ranging_interval_edca;
+		u32 min_allowed_ranging_interval_ntb;
+		struct {
+			u8 infra_support:1,
+			   pd_support:1;
+		} type;
+		u8 concurrent_ista_rsta_support:1;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 53d22194e75d..e540cd21b9e7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8100,6 +8100,46 @@ enum nl80211_peer_measurement_attrs {
  *	This limits the allowed combinations of LTF repetitions and STS.
  * @NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT: flag attribute indicating the
  *	device supports operating as the RSTA in PMSR FTM request
+ * @NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS: nested attribute containing ISTA
+ *	(initiator) role capabilities. Uses the same sub-attributes as
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS: nested attribute containing RSTA
+ *	(responder) role capabilities.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB: flag attribute (used inside
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS or
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS) indicating NTB ranging support.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB: flag attribute (used inside
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS or
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS) indicating TB ranging support.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA: flag attribute (used inside
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS or
+ *	%NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS) indicating EDCA based ranging
+ *	support.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_TYPE_CAPS: nested attribute containing ranging
+ *	type capabilities. Uses sub-attributes from
+ *	&enum nl80211_peer_measurement_ftm_type_capa.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_CONCURRENT_ISTA_RSTA_SUPPORT: flag attribute
+ *	indicating that the device can simultaneously act as initiator and
+ *	responder in a multi-peer measurement request. Only valid if
+ *	@NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT is set.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS: u32 attribute indicating
+ *	the maximum number of transmit antennas supported for EDCA based ranging
+ *	(0 means unknown)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS: u32 attribute indicating
+ *	the maximum number of receive antennas supported for EDCA based ranging
+ *	(0 means unknown)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA: u32 attribute indicating
+ *	the minimum EDCA ranging interval supported by the device
+ *	in milli seconds. (0 means unknown). Applications can use this value
+ *	to estimate the burst period to be given in the FTM request for the
+ *	EDCA based ranging case. If non-zero, this value will be used to
+ *	validate the burst period in the FTM request.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB: u32 attribute indicating
+ *	the minimum NTB ranging interval supported by the device
+ *	in milli seconds. (0 means unknown). Applications can use this value
+ *	to estimate the burst period to be given in the FTM request for the
+ *	NTB ranging case. If non-zero, this value will be used to validate
+ *	the nominal time in the FTM request.
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -8125,12 +8165,50 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_TX,
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_RX,
 	NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT,
+	NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS,
+	NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS,
+	NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB,
+	NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB,
+	NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA,
+	NL80211_PMSR_FTM_CAPA_ATTR_TYPE_CAPS,
+	NL80211_PMSR_FTM_CAPA_ATTR_CONCURRENT_ISTA_RSTA_SUPPORT,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS,
+	NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS,
+	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA,
+	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX = NUM_NL80211_PMSR_FTM_CAPA_ATTR - 1
 };
 
+/**
+ * enum nl80211_peer_measurement_ftm_type_capa - FTM ranging type capability
+ *	sub-attributes, used inside %NL80211_PMSR_FTM_CAPA_ATTR_TYPE_CAPS
+ * @__NL80211_PMSR_FTM_TYPE_CAPA_ATTR_INVALID: invalid
+ *
+ * @NL80211_PMSR_FTM_TYPE_CAPA_ATTR_INFRA_SUPPORT: flag attribute indicating
+ *	that the device supports infrastructure ranging (STA-to-AP or
+ *	AP-to-STA) as part of Proximity Detection
+ * @NL80211_PMSR_FTM_TYPE_CAPA_ATTR_PD_SUPPORT: flag attribute indicating that
+ *	the device supports peer-to-peer ranging as mentioned in the
+ *	specification "PR Implementation Consideration Draft 1.9 rev 1" where
+ *	PD stands for proximity detection
+ *
+ * @NUM_NL80211_PMSR_FTM_TYPE_CAPA_ATTR: internal
+ * @NL80211_PMSR_FTM_TYPE_CAPA_ATTR_MAX: highest attribute number
+ */
+enum nl80211_peer_measurement_ftm_type_capa {
+	__NL80211_PMSR_FTM_TYPE_CAPA_ATTR_INVALID,
+
+	NL80211_PMSR_FTM_TYPE_CAPA_ATTR_INFRA_SUPPORT,
+	NL80211_PMSR_FTM_TYPE_CAPA_ATTR_PD_SUPPORT,
+
+	/* keep last */
+	NUM_NL80211_PMSR_FTM_TYPE_CAPA_ATTR,
+	NL80211_PMSR_FTM_TYPE_CAPA_ATTR_MAX = NUM_NL80211_PMSR_FTM_TYPE_CAPA_ATTR - 1
+};
+
 /**
  * enum nl80211_peer_measurement_ftm_req - FTM request attributes
  * @__NL80211_PMSR_FTM_REQ_ATTR_INVALID: invalid
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e40b1898ab02..51046d749581 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2502,10 +2502,97 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_TOTAL_LTF_RX,
 			cap->ftm.max_total_ltf_rx))
 		return -ENOBUFS;
-	if (cap->ftm.support_rsta &&
-	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT))
+
+	if (cap->ftm.ista.support_ntb || cap->ftm.ista.support_tb ||
+	    cap->ftm.ista.support_edca) {
+		struct nlattr *ista_caps;
+
+		ista_caps = nla_nest_start_noflag(msg,
+						  NL80211_PMSR_FTM_CAPA_ATTR_ISTA_CAPS);
+		if (!ista_caps)
+			return -ENOBUFS;
+		if (cap->ftm.ista.support_ntb &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB))
+			return -ENOBUFS;
+		if (cap->ftm.ista.support_tb &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB))
+			return -ENOBUFS;
+		if (cap->ftm.ista.support_edca &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA))
+			return -ENOBUFS;
+		nla_nest_end(msg, ista_caps);
+	}
+
+	if (cap->ftm.rsta.support_ntb || cap->ftm.rsta.support_tb ||
+	    cap->ftm.rsta.support_edca) {
+		struct nlattr *rsta_caps;
+
+		/*
+		 * Set the generic RSTA_SUPPORT flag if any of the specific
+		 * ranging modes is supported to maintain the backward
+		 * compatibility.
+		 */
+		if (nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_RSTA_SUPPORT))
+			return -ENOBUFS;
+
+		rsta_caps = nla_nest_start_noflag(msg,
+						  NL80211_PMSR_FTM_CAPA_ATTR_RSTA_CAPS);
+		if (!rsta_caps)
+			return -ENOBUFS;
+		if (cap->ftm.rsta.support_ntb &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_NTB))
+			return -ENOBUFS;
+		if (cap->ftm.rsta.support_tb &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_TB))
+			return -ENOBUFS;
+		if (cap->ftm.rsta.support_edca &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_SUPPORT_EDCA))
+			return -ENOBUFS;
+		nla_nest_end(msg, rsta_caps);
+	}
+
+	if (cap->ftm.max_no_of_tx_antennas &&
+	    nla_put_u8(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_TX_ANTENNAS,
+		       cap->ftm.max_no_of_tx_antennas))
+		return -ENOBUFS;
+
+	if (cap->ftm.max_no_of_rx_antennas &&
+	    nla_put_u8(msg, NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS,
+		       cap->ftm.max_no_of_rx_antennas))
+		return -ENOBUFS;
+
+	if (cap->ftm.min_allowed_ranging_interval_edca &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA,
+			cap->ftm.min_allowed_ranging_interval_edca))
 		return -ENOBUFS;
 
+	if (cap->ftm.min_allowed_ranging_interval_ntb &&
+	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
+			cap->ftm.min_allowed_ranging_interval_ntb))
+		return -ENOBUFS;
+
+	if (cap->ftm.type.infra_support || cap->ftm.type.pd_support) {
+		struct nlattr *pd_caps;
+
+		pd_caps = nla_nest_start_noflag(msg,
+						NL80211_PMSR_FTM_CAPA_ATTR_TYPE_CAPS);
+		if (!pd_caps)
+			return -ENOBUFS;
+
+		if (cap->ftm.type.infra_support &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_TYPE_CAPA_ATTR_INFRA_SUPPORT))
+			return -ENOBUFS;
+
+		if (cap->ftm.type.pd_support &&
+		    nla_put_flag(msg, NL80211_PMSR_FTM_TYPE_CAPA_ATTR_PD_SUPPORT))
+			return -ENOBUFS;
+
+		nla_nest_end(msg, pd_caps);
+	}
+
+	if (cap->ftm.concurrent_ista_rsta_support &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_CONCURRENT_ISTA_RSTA_SUPPORT))
+		return -ENOBUFS;
 	nla_nest_end(msg, ftm);
 	return 0;
 }
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index afc0e3f931ec..c21f693fac29 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -188,10 +188,28 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	}
 
 	out->ftm.rsta = !!tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA];
-	if (out->ftm.rsta && !capa->ftm.support_rsta) {
+	if (out->ftm.rsta && out->ftm.non_trigger_based &&
+	    !capa->ftm.rsta.support_ntb) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
-				    "FTM: RSTA not supported by device");
+				    "FTM: NTB RSTA not supported by device");
+		return -EOPNOTSUPP;
+	}
+
+	if (out->ftm.rsta && out->ftm.trigger_based &&
+	    !capa->ftm.rsta.support_tb) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
+				    "FTM: TB RSTA not supported by device");
+		return -EOPNOTSUPP;
+	}
+
+	if (out->ftm.rsta && !out->ftm.non_trigger_based &&
+	    !out->ftm.trigger_based &&
+	    !capa->ftm.rsta.support_edca) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
+				    "FTM: EDCA RSTA not supported by device");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.34.1


