Return-Path: <linux-wireless+bounces-35033-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AY3Fm/t5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35033-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD6428AF1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D3E5300B5BD
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9A338C414;
	Mon, 20 Apr 2026 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FKgRYaAW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OhOF9eo3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18438AC95
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676199; cv=none; b=EnHcuwB9dcyah8IKoJfmnIOU+Xdv/w0Y4k771h+WfwBbYmhxtXt9JiBsGOVkRIyrvYjytkmrkUrEZhXGUE8wCRab5DjESMpT9CYVjqmb5H5zqQMn0rWu5euiKnWScna66ifWMaemKoKiHgiSiDAOK2tJPNm3z9IEyk1xe/3FvAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676199; c=relaxed/simple;
	bh=MRQuYTzemytPAznK9rCJulCKC0/sCTimFsiBmmWw27g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sAWV3wPIdZyDwF9DFZbepjL/E9h/TkzhaBOjKra8EhYXlfZkqRILd8raaBkRMyMs5x9FrxtSJ6YVxDTC8xaPfUS93KI4DknkfJBkA77ul2Sj/NjY5CxckKnnWa+QMhXGkr+/3mrnJ4fxWb72xH/rOe7PB8asSCrkH6tzHDZdp+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FKgRYaAW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OhOF9eo3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K79IMA1598349
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5liF6sIL1Eu
	t1RqAMDmeYU8niYD4x67eBy9jUHEhW+w=; b=FKgRYaAWXtXH2CQT7eyWelYiVfw
	5s50CVF4g7D+grj//gCqvQWInqrI3ZExNVyMkdWoLLf8FERmG2TuIMoVnmpgn8/+
	GdcYVgvpFiLYh+JH7GERWMfnusF27senLParPC2JgZqgiJabkCKthpslvdseCpF/
	c22CrnjLgd7+oMO58Hf9elrjJKWa5SxAHDtj2kmKyKnB/wHRLo7JezCuF1YgloYb
	RGvlOkM/l3OFGfRWgu0tENq+UvN51FZ2/bKlJnhu9oMmLxUukuTmg7kh8zaju4Wx
	1Be05291yRtZS4N/HA4l33to5Sgd/0Ogk1O0kkQwDi2vcMtVcKY0EH45Q0A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfgngqrs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3594620fe97so6721678a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676196; x=1777280996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5liF6sIL1Eut1RqAMDmeYU8niYD4x67eBy9jUHEhW+w=;
        b=OhOF9eo3jGyOZfa8Ro4kove6xfk596v0WUASEMYiURDXKk3GXXI0slsuVUHbnSLN77
         vqBZMzKtZYOY1gKRgGzoYmLNXELvVybDfbS30+Id/cmVh7Eq/yG8IplUEQfqc0mceGQl
         l1tsi4jsrAEwCo4SH8ynshOmDXaZl5WPf6sxTkr5c5Xy3MFNlO80Se+xp5YpNCCYG5tF
         L8wkQqSpH8KqmxAE/Y3ImSruY0ItBxyboBUhhjqBJ5xTZLc03Yv6PSPibo8Z5cK39YrC
         7FmWgVt3MHiQqaA44SCRUR1/plLC4LkGM8YbW7UA2yOXoaEWyslSygat+G5AFCvQDGh2
         CGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676196; x=1777280996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5liF6sIL1Eut1RqAMDmeYU8niYD4x67eBy9jUHEhW+w=;
        b=UUEAtBEN2RbPczZ/O40/vw6Y1BHrGdDKSEpCRAnFeYSN0i9hEEXHx+Xju/TRY3hOcK
         FcD608y1pV8htOaxDzfO3Ax/qxrAZ0mgx3MfKvLWe+aI5Y/2aNOvg+sElNFGKUqe9xZu
         xwmJVp+LbN5v4hDL9TLn7OBLvLahWznVYTJRewlDh+OS5+FLNUxrZ+Qqi7+HiMVyjX+S
         nGP7MDohpsYp6RC/uZfgz6p+dzNL5YsnrgFfFCWp6fvP5kK2lI1ckLTSYBBqwrkmHLy1
         9ts5ihpYMmNQfGe3lsEEXPOYgIu/zVAlUHmi+d6Mvg9Q41Vne6shxrEVoY0+fOFxPzpa
         BIIA==
X-Gm-Message-State: AOJu0YyfwIDJ5v+fsuybZGWTnS6NvwrMbVEr58t5cyX6RgrJK6vDICIh
	q7+ekLTld5z6ZWeWUwv0B8bEOmbefm0SokUWR8lYccKeOxexdjJrGEIoHYQaMPWEPmqvl8mOndn
	X3AKWbEm7Gh0aPLseRZ+39q745wIqglFWyaEthzpJz9UWkdnqpd0P+6su1oxnkPIuOwFd
X-Gm-Gg: AeBDietZlhWoZ8M1Q9pIFwGjWJv4TbNrHZEYelNAVJanj/PCMrvrTMVe+ZUsQP0G8we
	y4achNQBpOVF6G0ksLtzI6MD87sMlfgq1YYwvQbDnNAAL5Jyxm6bAg902qG0ZuAogN8VUhJNd0i
	eKccVCKYSoR/YOQprZZGtdtOGFFruEcamGS9VnSCLFa3tywBYdRD4yXv13dq8eb/G0a1Oy5d5Bg
	jDh1alyo5sT9Zl4C9PNIgF0x7ZK+hCrISP4LOQ9ZLjldjNLS8xNYKbJfu7x51MzUNo473v+WPXT
	B0dpYZ+FvzTRpcFqZJ0holaCdyx7rr2Ht3KzQkZRLonu/sNp9n2J0pAyz34+ZpJ8iNI/9w8RGa0
	8ugYCo+yYc31VaiAeN3+B1P4H49BEXvcqJMiXPGMv6q4CDQK/7HE92n9X43sP/61llw==
X-Received: by 2002:a17:90b:390d:b0:35c:30a8:319 with SMTP id 98e67ed59e1d1-36140222bbbmr13631922a91.0.1776676195919;
        Mon, 20 Apr 2026 02:09:55 -0700 (PDT)
X-Received: by 2002:a17:90b:390d:b0:35c:30a8:319 with SMTP id 98e67ed59e1d1-36140222bbbmr13631888a91.0.1776676195350;
        Mon, 20 Apr 2026 02:09:55 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:55 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 10/13] wifi: cfg80211: add PD-specific preamble and bandwidth capabilities
Date: Mon, 20 Apr 2026 14:38:53 +0530
Message-Id: <20260420090856.2152905-11-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: v8gmdMG5vw43ukPkYpsS3wGo4Uxdu-mt
X-Proofpoint-GUID: v8gmdMG5vw43ukPkYpsS3wGo4Uxdu-mt
X-Authority-Analysis: v=2.4 cv=TK11jVla c=1 sm=1 tr=0 ts=69e5ed64 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=0bA3Y9Y9tSTTC1MyXRUA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfX0tbIym/aobWp
 Dhn9rVmHhtq22cq1/MaeTJxQFmhTEML8YRobZ1m39INCPfbJL35AvKOtXM2xc43Mpo5MLeJoK6i
 WPn0fdBgiOrcUXdcG2S7sUvGai1TumA43Sw8mUNGkEb0FnqM/YF6xrtIqVPm+yyumLvG/BAeAIh
 7mlZbPsGPhQAbB/x8dRl/XGzOzTnb+T9L40im4UPeZ47+SUp5CZfApvlnscOaBHODGjdQ6w2Cv4
 R77Y+TXJMNqb7L7goeETVKLkFa1YpismTr6IdHuTAZ/AebEdoGrgMQCyR1fn8pok2YO7NNMCkGO
 R8i9yRk45t7V4ChqzKvy6ETdRE3kTbWhTNvWJaIx2eeYeuHM9ONrXIaidoIczn83A9aiG1s1ZhI
 HJlo2dHp6MMCogXMFeaSXpIuo+qEsf12pGyFMjFA16LzkdoomYZngt0ObJcbqGhwNCvRFH/RzHY
 M3Z7VmM6nLnoowOKAEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200087
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35033-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1BBD6428AF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Devices may support different preamble and bandwidth configurations
for proximity detection (PD) ranging versus standard ranging. Add
separate pd_preambles and pd_bandwidths fields to
cfg80211_pmsr_capabilities to allow drivers to advertise PD-specific
capabilities.

Expose these over nl80211 using new attributes
NL80211_PMSR_FTM_CAPA_ATTR_PD_PREAMBLES and
NL80211_PMSR_FTM_CAPA_ATTR_PD_BANDWIDTHS, advertised only when
pd_support is set.

For PD requests, validate bandwidth and preamble against pd_bandwidths
and pd_preambles. For non-PD requests, validate against the existing
bandwidths and preambles fields.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 10 ++++++++++
 net/wireless/nl80211.c       | 12 ++++++++++++
 net/wireless/pmsr.c          | 21 +++++++++++++++++++--
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b16f36473b2f..1d19cb2f14fa 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6050,6 +6050,10 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  * @ftm.concurrent_ista_rsta_support: indicates if the device can
  *	simultaneously act as initiator and responder in a multi-peer
  *	measurement request. Only valid if @ftm.rsta_support is set.
+ * @ftm.pd_preambles: bitmap of preambles supported (&enum nl80211_preamble)
+ *	for PD ranging requests. Ignored if @ftm.type.pd_support is not set.
+ * @ftm.pd_bandwidths: bitmap of bandwidths supported (&enum nl80211_chan_width)
+ *	for PD ranging requests. Ignored if @ftm.type.pd_support is not set.
  */
 struct cfg80211_pmsr_capabilities {
 	unsigned int max_peers;
@@ -6096,6 +6100,8 @@ struct cfg80211_pmsr_capabilities {
 			   pd_support:1;
 		} type;
 		u8 concurrent_ista_rsta_support:1;
+		u32 pd_preambles;
+		u32 pd_bandwidths;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 1400adfee10b..f701b862e50f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8178,6 +8178,14 @@ enum nl80211_peer_measurement_attrs {
  *	to estimate the burst period to be given in the FTM request for the
  *	NTB ranging case. If non-zero, this value will be used to validate
  *	the nominal time in the FTM request.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_PREAMBLES: u32 bitmap of values from
+ *	&enum nl80211_preamble indicating the supported preambles for PD
+ *	ranging requests. Only valid if %NL80211_PMSR_FTM_TYPE_CAPA_ATTR_PD_SUPPORT
+ *	is set.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_BANDWIDTHS: u32 bitmap of values from
+ *	&enum nl80211_chan_width indicating the supported channel bandwidths
+ *	for PD ranging requests. Only valid if
+ *	%NL80211_PMSR_FTM_TYPE_CAPA_ATTR_PD_SUPPORT is set.
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -8214,6 +8222,8 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS,
 	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA,
 	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_PREAMBLES,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_BANDWIDTHS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0e0c66fe39db..322c7ed881d8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2614,6 +2614,18 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	if (cap->ftm.concurrent_ista_rsta_support &&
 	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_CONCURRENT_ISTA_RSTA_SUPPORT))
 		return -ENOBUFS;
+
+	if (cap->ftm.type.pd_support) {
+		if (cap->ftm.pd_preambles &&
+		    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_PREAMBLES,
+				cap->ftm.pd_preambles))
+			return -ENOBUFS;
+		if (cap->ftm.pd_bandwidths &&
+		    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_BANDWIDTHS,
+				cap->ftm.pd_bandwidths))
+			return -ENOBUFS;
+	}
+
 	nla_nest_end(msg, ftm);
 	return 0;
 }
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 46c444d0327b..202e2c46522b 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -17,11 +17,19 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	u32 preamble = NL80211_PREAMBLE_DMG; /* only optional in DMG */
 
 	/* validate existing data */
-	if (!(rdev->wiphy.pmsr_capa->ftm.bandwidths & BIT(out->chandef.width))) {
+	if (out->ftm.request_type == NL80211_PMSR_FTM_REQ_TYPE_INFRA &&
+	    !(capa->ftm.bandwidths & BIT(out->chandef.width))) {
 		NL_SET_ERR_MSG(info->extack, "FTM: unsupported bandwidth");
 		return -EINVAL;
 	}
 
+	if (out->ftm.request_type == NL80211_PMSR_FTM_REQ_TYPE_PD &&
+	    !(capa->ftm.pd_bandwidths & BIT(out->chandef.width))) {
+		NL_SET_ERR_MSG(info->extack,
+			       "FTM: unsupported bandwidth for PD request");
+		return -EINVAL;
+	}
+
 	/* no validation needed - was already done via nested policy */
 	nla_parse_nested_deprecated(tb, NL80211_PMSR_FTM_REQ_ATTR_MAX, ftmreq,
 				    NULL, NULL);
@@ -44,13 +52,22 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		}
 	}
 
-	if (!(capa->ftm.preambles & BIT(preamble))) {
+	if (out->ftm.request_type == NL80211_PMSR_FTM_REQ_TYPE_INFRA &&
+	    !(capa->ftm.preambles & BIT(preamble))) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE],
 				    "FTM: invalid preamble");
 		return -EINVAL;
 	}
 
+	if (out->ftm.request_type == NL80211_PMSR_FTM_REQ_TYPE_PD &&
+	    !(capa->ftm.pd_preambles & BIT(preamble))) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE],
+				    "FTM: invalid preamble for PD request");
+		return -EINVAL;
+	}
+
 	out->ftm.preamble = preamble;
 
 	out->ftm.burst_period = 0;
-- 
2.34.1


