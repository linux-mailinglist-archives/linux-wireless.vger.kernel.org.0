Return-Path: <linux-wireless+bounces-32447-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBAYJZ3cp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32447-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A60C1FB7DC
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E38230A8721
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC48E344DA8;
	Wed,  4 Mar 2026 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/8Mi5ok";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OnRoRvff"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879F364936
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608597; cv=none; b=oO8g+JRVcUNAddGkrHRhLtx93Zgu8w75nhMO4I8vqayeHOX/GeBavjnkgV3WDzSr7USJ0OFk3q2PTYjvY2biO8tcMBNkMyWOG/4/4FAfgFkayGesLoUWSeFiTEwzkRPPGAgbRtnPV+APtvX/r9PBj6GrLwsBePeNrcqPUNmNru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608597; c=relaxed/simple;
	bh=Ca4To/6elh+x+nWKxfnYy+GsNpreGBcN9fkxMCNcJaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i6qtpHWbUu4T7rz5hZMg3xIBdC+4Oa7VycCwu6vroHf2dCzzTzjREviF0EtQORCY5vH1qNFCKyhT46qaNXmkFgAq4lSTQR/r9T8QqAg+DzEinzUS5yCjswQOOSZgzrB+wG2gLS2OEDCQEwC7elUeqU+Mi/AtVnKx0xHZeeiu4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/8Mi5ok; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OnRoRvff; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6246DKBt1203575
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aTyvOY9gpgY
	8g4HU/VWEWJ262nVobZT1iwolBP4tCiA=; b=F/8Mi5ok17e0Z6TtgyakPRHYYy8
	f90qC0Q+r2/QLiaGV2ht7vnFLuJqHMh1ZzRo/b6h+r+oV5/gMqY8XWN1YwaUpUp8
	67784foTQLDtkBET6n1Q2HYUJ2uK4GaRXFjV8Qjtoo7mydKqF7rAflyXd7m1xbKj
	bQgXcz/GhtYAIM5e89znXMi10zPZ1Vi8R6EDBEXcs83/vrNiYpIEwr0cj+y0lQPl
	zoP+mRtAkp469HDgKQVByEKaSFl45ojeewYv0FJx9yQ+ezebkft09uoU+nhUGHk0
	5L0W1IpinHMglGdyLBfPwa7Ez52H6Ml9Ya1VEWwNezAwUmir3LKVN15u5tQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpf9c0601-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:35 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c73781252edso1440401a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608595; x=1773213395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTyvOY9gpgY8g4HU/VWEWJ262nVobZT1iwolBP4tCiA=;
        b=OnRoRvfflZPuB2hbve9/CdF/PgytjnYHsNr4UPFOrv/J9FOVmn+iamZiAvpHfJnmfx
         xoOTXf0fs0ZqV8VCieuuO2uR33pxY1L1+yxGCMQKNHdw7AUuE3gbGOoq/HV939YEkWG0
         05pggFlKOl6BZKCLWk3r0ykxxlA2VnrNHuSN5tDBBqROicNsPeH7apaxf5Hm9EhceFHc
         zpmjRy2AeqAd1mmMNgzF/eNSkYBUjVXAGMBZ36PAismvKZS/xlQMt0A3HPyMzhfx10QP
         KybulbphB3Fq+R8QFKvb14p+OXWrW1UNS/vy5pfS4Y7/q1iPoYWAT3Lp9idGcBTfLmvZ
         iJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608595; x=1773213395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aTyvOY9gpgY8g4HU/VWEWJ262nVobZT1iwolBP4tCiA=;
        b=BjvygkwmwuTO4yXeGySzCHfm6LGaG+mV0SVpoxRtIQGYPF+yCV1zkfQ7RC8ngd1bG9
         cNtLDXejfOr7tj1ThRCdHeosGT/hxpcqghfexNfLiPtrJQTedsHbh5y9HC3OfqO5dTd9
         9RWd4yE5oxbMglh5hBJOqm+hyRfFiX7F32/YaLmcfOefeNS1b+56z6wqxFgqYFY2e6ua
         HqmJv86phQxxNFU+PO1gHfcccYc6u4SFCc6dIM8bk+wa/ZNP4/W/BY1K37CJBdPLBSrT
         FC/7bnDPRnF/wy0D1ulD/i+fN1+/QyuigV2lsIoVn2ONLerAgax55071wcwtiZmt0ybf
         t3Zw==
X-Gm-Message-State: AOJu0Yym6ZLUngKemAlOxbjSETjzYG4jkd1akb1w3AF6Gp9PBG9/EMu7
	dz1qF3K7Hdxzv1EHEuUYx+PfhDrb0JOyaslWPPzI9dNxxckEHCx94GbKhHur3YEfsMT7V0ypmxA
	D9c4M6bwarFn/1XvdpyIBb63kanMt/lwlvFFLztpHIBILjjkn5d3nhTvH7QT0nWH7kfqw
X-Gm-Gg: ATEYQzxoUzpXsTUtyXjh1vCfYMlM/SMPA5zbQgN+ozO7DUNuhYXwYGlRaBR6bydQEDv
	YuYV333BjvLZO3UEyK+gm10eOQPKsAUJ4XcZRPVqj2qJn/PobwfGGxClUn2mprYwAawbN5ySER2
	O19cBflonluDfj686uAJvCW0eC5klYwNfUbHXnz324wrDYNGr52gMJwvy/JcLz6Cj7ltnZqXhlV
	/99KfZvZEGRYuYiE87ObWYCMrjfH4VviM1PTQikZgg8xifRPaDcluW9LwS7Q6dEB2ww6EyE1wmP
	wsvGfEcc1Op/6sLv0doTfesuim3s/xCJ/Vzixn5say9u2ZgOMXy14T0J20Hkc4v3brGto0unmpK
	/OMX8tQtNF3xXkwq21TuotGrOSjfXuOjhqloCB9qfv1rUopHpKLjGYH0=
X-Received: by 2002:a05:6a21:a518:b0:395:730:c1b3 with SMTP id adf61e73a8af0-3982ded076dmr1046912637.25.1772608594965;
        Tue, 03 Mar 2026 23:16:34 -0800 (PST)
X-Received: by 2002:a05:6a21:a518:b0:395:730:c1b3 with SMTP id adf61e73a8af0-3982ded076dmr1046888637.25.1772608594444;
        Tue, 03 Mar 2026 23:16:34 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:34 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 11/16] wifi: cfg80211: add PD-specific preamble and bandwidth capabilities
Date: Wed,  4 Mar 2026 12:45:33 +0530
Message-Id: <20260304071538.3833062-12-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX3u+9lw21KiHa
 Sc5wVt/7aWB5Lc4Ci6rFo4qKGSCAvlyYYeldulsGO4PakICKlb8H96qCYZR/wWXOimKI0pdcdR8
 dijsnztxFZ5BMALmaLLSq4jsPdOGWzXoFbGQjO/7n2FFV696lGDcllQmawZ7mnjDojIpyuDrDPo
 4gJruBwYADP1LADkRz0wIVt62sTXAvjdqHyBUUk2MjmgZY9CWL8+YkPqnyjRoRgoXgGoEze2X//
 ua3DuXkMJOfNdqQ5nJjgICMaI7T1mgmjk1wmGHQRDepGaxVOnPT8h3+OFX6Wi+TBzS3tUXbsZW6
 I7i/hpA+Xflf7HJRQIZy/+1mXGO7Cixy7bag/ngu3C6+selhKiqMKS5DKITeWs+08LFjoP+hAgs
 APgZJDscQ41e5JQ+Alr5wiTAZ0tBulywgcDYPqhA5kHdAkAQEl36gaKO5vdSANyOUC3lQNc8SQD
 WglrKMLYbbqBpY7FPcw==
X-Proofpoint-GUID: e1gI9s_k_ZsmN4tvd8f3yCVPctmhRKp5
X-Authority-Analysis: v=2.4 cv=S4LUAYsP c=1 sm=1 tr=0 ts=69a7dc53 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=hlLq49h-dZ90OnsncDQA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: e1gI9s_k_ZsmN4tvd8f3yCVPctmhRKp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040058
X-Rspamd-Queue-Id: 0A60C1FB7DC
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
	TAGGED_FROM(0.00)[bounces-32447-lists,linux-wireless=lfdr.de];
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

Some devices support different preamble and bandwidth configurations
for proximity detection (PD) versus standard ranging, but capabilities
currently report only a single set for all FTM measurements.

Introduce separate preamble and bandwidth capability reporting for PD
requests with EDCA and NTB-based ranging, allowing devices to advertise
different supported preambles and bandwidths for PD operations.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 16 ++++++++++++++++
 include/uapi/linux/nl80211.h | 22 ++++++++++++++++++++++
 net/wireless/nl80211.c       | 12 ++++++++++++
 net/wireless/pmsr.c          | 21 +++++++++++++++++++--
 4 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1b663627a0e6..61651ecc3c9d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5832,6 +5832,18 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  * @ftm.support_rsta: supports operating as RSTA in PMSR FTM request
  * @ftm.support_edca_responder: supports operating as FTM responder in PMSR FTM
  *	request for EDCA-based ranging
+ * @ftm.pd_edca_preambles: bitmap of preambles supported
+ *	(&enum nl80211_preamble) in case of PD request with EDCA based
+ *	initiator or responder role. ignored if @pd_support is not set.
+ * @ftm.pd_ntb_preambles: bitmap of preambles supported
+ *	(&enum nl80211_preamble) in case of PD request with NTB based
+ *	initiator or responder role. ignored if @pd_support is not set.
+ * @ftm.pd_edca_bandwidths: bitmap of bandwidths supported
+ *	(&enum nl80211_chan_width) in case of PD request with EDCA based
+ *	initiator or responder role. ignored if @pd_support is not set.
+ * @ftm.pd_ntb_bandwidths: bitmap of bandwidths supported
+ *	(&enum nl80211_chan_width) in case of PD request with NTB based
+ *	initiator or responder role. ignored if @pd_support is not set.
  */
 struct cfg80211_pmsr_capabilities {
 	unsigned int max_peers;
@@ -5867,6 +5879,10 @@ struct cfg80211_pmsr_capabilities {
 		u32 min_allowed_ranging_interval_ntb;
 		u8 support_rsta:1,
 		   support_edca_responder:1;
+		u32 pd_edca_preambles;
+		u32 pd_ntb_preambles;
+		u32 pd_edca_bandwidths;
+		u32 pd_ntb_bandwidths;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 174592017486..f064d6a260fb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7942,6 +7942,24 @@ enum nl80211_peer_measurement_attrs {
  * @NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB: u32 attribute indicating
  *	the minimum NTB ranging interval supported by the device
  *	in milli seconds. (0 means unknown)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES: u32 bitmap of values from
+ *	&enum nl80211_preamble indicating the supported preambles for FTM in
+ *	case of PD based EDCA initiator or responder role.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES: u32 bitmap of values from
+ *	&enum nl80211_preamble indicating the supported preambles for FTM in
+ *	case of PD based NTB initiator or responder role.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS: u32 bitmap of values from
+ *	&enum nl80211_chan_width indicating the supported channel
+ *	bandwidths for FTM in case of PD based EDCA initiator or responder role.
+ *	Note that a higher channel bandwidth may be configured to allow for
+ *	other measurements types with different bandwidth requirement in the
+ *	same measurement.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS: u32 bitmap of values from
+ *	&enum nl80211_chan_width indicating the supported channel
+ *	bandwidths for FTM in case of PD based NTB initiator or responder role.
+ *	Note that a higher channel bandwidth may be configured to allow for
+ *	other measurements types with different bandwidth requirement in the
+ *	same measurement.
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -7972,6 +7990,10 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS,
 	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA,
 	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e6969578f4f1..1deedb1c6c50 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2412,6 +2412,18 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
 			cap->ftm.min_allowed_ranging_interval_ntb))
 		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES,
+			cap->ftm.pd_edca_preambles))
+		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES,
+			cap->ftm.pd_ntb_preambles))
+		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS,
+			cap->ftm.pd_edca_bandwidths))
+		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
+			cap->ftm.pd_ntb_bandwidths))
+		return -ENOBUFS;
 
 	nla_nest_end(msg, ftm);
 	return 0;
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index f2bbbf8eb6f2..c4c027fc0b63 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -17,11 +17,19 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	u32 preamble = NL80211_PREAMBLE_DMG; /* only optional in DMG */
 
 	/* validate existing data */
-	if (!(rdev->wiphy.pmsr_capa->ftm.bandwidths & BIT(out->chandef.width))) {
+	if (!out->pd_request &&
+	    !(rdev->wiphy.pmsr_capa->ftm.bandwidths & BIT(out->chandef.width))) {
 		NL_SET_ERR_MSG(info->extack, "FTM: unsupported bandwidth");
 		return -EINVAL;
 	}
 
+	if (out->pd_request &&
+	    !(rdev->wiphy.pmsr_capa->ftm.pd_edca_bandwidths & BIT(out->chandef.width)) &&
+	    !(rdev->wiphy.pmsr_capa->ftm.pd_ntb_bandwidths & BIT(out->chandef.width))) {
+		NL_SET_ERR_MSG(info->extack, "FTM: unsupported bandwidth for pd request");
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
+	if (!out->pd_request && !(capa->ftm.preambles & BIT(preamble))) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE],
 				    "FTM: invalid preamble");
 		return -EINVAL;
 	}
 
+	if (out->pd_request &&
+	    !(capa->ftm.pd_ntb_preambles & BIT(preamble)) &&
+	    !(capa->ftm.pd_edca_preambles & BIT(preamble))) {
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


