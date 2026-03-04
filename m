Return-Path: <linux-wireless+bounces-32450-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KliF7Dcp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32450-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:18:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD211FB7FA
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB5B030AFE2A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27DE36BCEA;
	Wed,  4 Mar 2026 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DMIpfscx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fiZqAP5g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38D36C0B4
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608606; cv=none; b=RWmI8UVmYdrHvyiM5j5On71lNzcgc7+4Jm2gQTlJuAnmeSGQNqzI5ij0TOalGfYPfhfAMKmo30n31Aay5S+Z7/W2e4zS/+HCNbnNeuwoBtGnqnWSnZQDTJOIKu5Zrpe/7/llW8KX+hQfiKifTJ3uqkdTO2JE6FRaEaQdUe7UuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608606; c=relaxed/simple;
	bh=t4bmfkjyZQm35MlHi/QFNggjpxSBd3zLaJ0yWBwo9mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aOz7vWagEZjAW7VvDrO458dNdqaxN5V+bl2PJ2IcVAb6IsbkvZf874r8fo1ys4FYll1YRvt5jADN+4FTTssF+XGDcxoaRlxjY9imwC1VQ46EVwD56Gt+mNBD4XCKLEUW4l3aUJWmH6LSAzCderhSAJqCq5HfuiebT0hxj490PCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DMIpfscx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fiZqAP5g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SU5P2861188
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4ZbwJ+BoIQz
	9kgJfn/UlvaRGvJZWFtbKu7/MulF05vk=; b=DMIpfscxyF4ZNTZiEp11PaHSIxl
	KkPTVbPxxnEVlq2XjGTKezDRkcO3vlNVJAlkNBQifv3+o7sgaxEm6dY/dcpxVdiZ
	qHRhmEqLfs2T9LiQIEHQQLM3kreIisuGYacVdWNarlYKitwF+Duu0+fCLF/Wn/vw
	D2W3m6LY+lR/hm+IdoVDzr91tNzRpSNBQWtovGxL//cRBwrnP3l4vtPTmL6GL2n2
	/ie7nx8YiJQ4PjycBQ7MUKGlbQ5BOUDsABdi92l2eWJadpUtGxM0WgZo+mQMMnwf
	43j1Hj5vbtRacunl0zdaiFznJtTBFJwkYZzDZzhtbIR3+wt5VML6QiP/1qQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp2c9jvgd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:42 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c737882b2easo260710a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608602; x=1773213402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZbwJ+BoIQz9kgJfn/UlvaRGvJZWFtbKu7/MulF05vk=;
        b=fiZqAP5gsOXYkTGMfe+EIaFjmZIvUdNP2YTjvNJmM9/bF72XooVOhNtuDnkPerTWO2
         0Wcj28ABd06a9LGcvGBcucZ/jyo4FjurQah3q0J6vnSqBsc9cg3AQKsq6GEaWuryP8Xy
         98DJy7yRbjeuuUsO/pHD+zxwpH0qqosXVNVMgqo40SmlsAnABbgLU2LcP6dXHGl9bqp6
         lPL/ENzNli6hsHTUAVLg2oLv1KAPf32wAdAcJTi9Jq98LlwjFyWPrDXsMlOwrvPTF3Ma
         mM5CwaaYZ9Dz1hmmueOGdSjVtLoMgHx4NzAQXIblUc/sNbW20m0COKUE1s7lXmp/yuyb
         A0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608602; x=1773213402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ZbwJ+BoIQz9kgJfn/UlvaRGvJZWFtbKu7/MulF05vk=;
        b=PCn70gOgUtOS6pG8T4DX7GNNG2ssok0WOFgpywJw8gGA7Hjpb4wmVkjwsIDsGD59T1
         +rr8wy2c3SbEcMIvmynq+jiKVor6V8zkTu74vuhRjIjLKOg7k9k8VLZFMvlhTlYvy7qy
         bzdzul7W2xQaVGdpeSLxqOa/03f23kY9MplpEz+C6QLBf/N9SbwwgIA3DacxzqT/ij3i
         jeHbNbKR5dTwLFMGFGvPzjKcRqju4vNy7FBlBoVSsROTVg5Vp/yXTFvjG1ZHyJLZ1x8T
         yzGmZ2mBGX9g3KJCLIU12bQVD2VpZhY+5Me0LxeGmHamD1raUvT3oxLakZfmZIJ5myCk
         C56g==
X-Gm-Message-State: AOJu0YzLHCh5pK8JyTivNaAfjBK7+ZEpmk4TaS00LTWdJh8YeTel7Poz
	JzFhPNKkx2DBK9f2LsYhX2/5p+SnVkhlmFnShdNGQu02cauFHmOvgfoGLRxDvH4g/68BnIlVdft
	CxwE0j+pcR0JR9PSRJ7ziwSBTrSTexNs3uEdqqs4GeIsBy5i0ej2scVyTdVqto4EUvpxLkOC4TV
	Fv
X-Gm-Gg: ATEYQzwV/RQBzuvYEVE5zqj5wDyQLw/seTw8tXwK0BLf074BqFrHOsY03kj8ZUa3C8L
	NU+r2Ss1ejLLB2gLWi+15O53bJoPGRGgKzZuzmUntNpQ+gUOH/abODbfHjNEdJz+4QTa1finWOs
	BWYsQq2Rx03ce07IKmN5cdAm3/H1Uc4zQnuHSYU7MR3rHkvdxlkdOKUMwND+bW3VN47BdcvKLEA
	rasA5Vy75On6bITETINf46894s8LfFpBcLHVnVoGOOXn242741Yn84PMvF5Tvds2lKqzPd7demX
	IAoa4cMziEIdRiEYXwGS5BmxT07cSl5ac6QZFyfyaU8STov9uqVZ953WVoKED83VlqpM/TTwLzH
	UqOxJR33MrZwzErDzwoX9/ZxZ2GYXGfbyf/hMKbDRIHO/jIvAbVcJJ5w=
X-Received: by 2002:a05:6a20:4321:b0:35d:d477:a7ea with SMTP id adf61e73a8af0-3982decca5dmr1135656637.19.1772608601615;
        Tue, 03 Mar 2026 23:16:41 -0800 (PST)
X-Received: by 2002:a05:6a20:4321:b0:35d:d477:a7ea with SMTP id adf61e73a8af0-3982decca5dmr1135635637.19.1772608601072;
        Tue, 03 Mar 2026 23:16:41 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:40 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 14/16] wifi: cfg80211: add MAC randomization support for PD requests
Date: Wed,  4 Mar 2026 12:45:36 +0530
Message-Id: <20260304071538.3833062-15-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX00MGZOfKGh9I
 NR3VrB5zhGvLu5BKu3JO5GyAKUWNn/xgIR8tu4SnULTcafBjLH/4jICyLShnsfzbx7/8JHHsVu1
 L0367baYG9VOOKsjgLXZU/v8qIDl3JxZ/nuMnXUTSk/sQftnmpMWXTHGeFSHkO4/TLXBRZtVRmK
 esi7KME8FY+pqMTO200d0waZTS3EFf/h3WDGzQDthR4VzKHM3Af4wqRAupJMZl+SjQxS/cJVw78
 j5e48OXIwF9E5KnSpN2u9Y07IAtSXDED+zACeAo0AAfMOvzmjT4aLEj8N7x6+67x/cbtAct1RUG
 jefowbg3Y0oBsq/O04sCwUxTqtpoOWGoLuLCtepLB/3mx6ZkYmglGfQY4WooHSD5fpHemaETJyR
 P2G+8XTOrKrvcBcca8r7dcjWiUAwOLxd51K7YzA8I2TpWjxyECpXd5SbSsKn25LsTPaylIgjClj
 D9ktUz7hgwFd+WHLCKA==
X-Proofpoint-ORIG-GUID: Q94hHVqhMLSVADIj2zEmZ9DmN-3CTYrB
X-Proofpoint-GUID: Q94hHVqhMLSVADIj2zEmZ9DmN-3CTYrB
X-Authority-Analysis: v=2.4 cv=EefFgfmC c=1 sm=1 tr=0 ts=69a7dc5a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=dwHZau_51_vYx2LytkEA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040058
X-Rspamd-Queue-Id: 0BD211FB7FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32450-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Enable MAC address randomization for proximity detection requests to
maintain privacy throughout the entire PD session workflow. When
enabled, use the same randomized MAC address for discovery,
authentication, and ranging measurements, ensuring consistent identity
protection across all phases.

Add a capability flag for devices to advertise PD MAC randomization
support and validate that randomization is only requested when the
device supports it. This ensures consistent MAC address usage across
all phases of proximity detection while preventing invalid
configurations where randomization is requested but not supported by
hardware.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  7 ++++++-
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       |  8 ++++++++
 net/wireless/pmsr.c          | 10 ++++++++++
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8dc2ccafb88b..6f7abb118a27 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5794,6 +5794,10 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	multi-peer request this will indicate if the device can act
  *	simultaneously as initiator and a responder. Only valid if @pd_support
  *	is set.
+ * @pd_randomize_mac_addr_conn: flag attribute in capability indicating that MAC
+ *	address randomization is supported in connected state for PD request.
+ *	if capable the MAC address used for discovery, authentication will be
+ *	used for ranging too. only valid if @pd_support is set
  * @pd_max_peer_ista_role: Maximum number of peers allowed for a device
  *	operating in the ISTA role under proximity detection. Only valid if
  *	@pd_support is set. Sum of both @pd_max_peer_ista_role and
@@ -5861,7 +5865,8 @@ struct cfg80211_pmsr_capabilities {
 	u8 report_ap_tsf:1,
 	   randomize_mac_addr:1,
 	   pd_support:1,
-	   pd_concurrent_ista_rsta_support:1;
+	   pd_concurrent_ista_rsta_support:1,
+	   pd_randomize_mac_addr_conn:1;
 	u32 pd_max_peer_ista_role;
 	u32 pd_max_peer_rsta_role;
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index cafa73280758..9c647c184e7f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7855,6 +7855,11 @@ enum nl80211_peer_measurement_peer_attrs {
  *	%NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE and
  *	%NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE is considered to enforce the
  *	max peers supported in case the request is of peer-to-peer PD type
+ * @NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR_CONNECTED: flag attribute in
+ *	capability indicating that MAC address randomization is supported for
+ *	PD request in connected state. if capable the MAC address used for
+ *	discovery, authentication will be used for ranging too. only valid if
+ *	%NL80211_PMSR_ATTR_PD_SUPPORT is set
  *
  * @NUM_NL80211_PMSR_ATTR: internal
  * @NL80211_PMSR_ATTR_MAX: highest attribute number
@@ -7871,6 +7876,7 @@ enum nl80211_peer_measurement_attrs {
 	NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT,
 	NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE,
 	NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
+	NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR_CONNECTED,
 
 	/* keep last */
 	NUM_NL80211_PMSR_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 02e7c9f9b12f..281a15226edb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -424,6 +424,9 @@ nl80211_pmsr_attr_policy[NL80211_PMSR_ATTR_MAX + 1] = {
 	},
 	[NL80211_PMSR_ATTR_PD_MAX_PEER_ISTA_ROLE] = { .type = NLA_REJECT },
 	[NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE] = { .type = NLA_REJECT },
+	[NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR_CONNECTED] = {
+		.type = NLA_REJECT
+	},
 };
 
 static const struct nla_policy
@@ -2481,6 +2484,11 @@ static int nl80211_send_pmsr_capa(struct cfg80211_registered_device *rdev,
 		    nla_put_u32(msg, NL80211_PMSR_ATTR_PD_MAX_PEER_RSTA_ROLE,
 				cap->pd_max_peer_rsta_role))
 			return -ENOBUFS;
+
+		if (cap->pd_randomize_mac_addr_conn &&
+		    nla_put_flag(msg,
+				 NL80211_PMSR_ATTR_PD_RANDOMIZE_MAC_ADDR_CONNECTED))
+			return -ENOBUFS;
 	}
 	caps = nla_nest_start_noflag(msg, NL80211_PMSR_ATTR_TYPE_CAPA);
 	if (!caps)
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 2897876e45b2..b5e8af89c57e 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -383,6 +383,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 	const struct cfg80211_pmsr_capabilities *capa;
 	struct cfg80211_pmsr_request *req;
 	struct nlattr *peers, *peer;
+	bool use_random_mac = false;
 
 	capa = rdev->wiphy.pmsr_capa;
 
@@ -429,6 +430,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 					       req->mac_addr_mask);
 		if (err)
 			goto out_err;
+		use_random_mac = true;
 	} else {
 		memcpy(req->mac_addr, wdev_address(wdev), ETH_ALEN);
 		eth_broadcast_addr(req->mac_addr_mask);
@@ -460,6 +462,14 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 					err = -EINVAL;
 					goto out_err;
 				}
+
+				if (use_random_mac &&
+				    !capa->pd_randomize_mac_addr_conn) {
+					NL_SET_ERR_MSG(info->extack,
+						       "PD mac randomization not supported");
+					err = -EINVAL;
+					goto out_err;
+				}
 			}
 		}
 	}
-- 
2.34.1


