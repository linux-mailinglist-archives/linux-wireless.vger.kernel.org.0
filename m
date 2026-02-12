Return-Path: <linux-wireless+bounces-31778-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Lo1Fu8MjmmS+wAAu9opvQ
	(envelope-from <linux-wireless+bounces-31778-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:25:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7AB12FE0E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E2F63054D00
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865BB223DFF;
	Thu, 12 Feb 2026 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WU3JHyqB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cLgABQww"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057772066F7
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917060; cv=none; b=HioJGmEslvbMphg02+4kEGcKbu4b0KxH4NDaBYHodY01DTcCW55kxuLJSPH7w/bjvuMffL2vR6ewKctjFE6XKKh1sodB0aWXswMmdMiuatrdBssrwtgc4ka8aeEL+OxQaYpkVpPBtjHrTtYWBOe3ftaB1O3OHpxNUfnmcMQN+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917060; c=relaxed/simple;
	bh=5rrF/HMAIRC79+CCa1BDA8mb2bQGq5FRdBQWQrhsAMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij0AKdsbO4tFdYzeameopkNhCc+mTOMkSAF8hko5c498kDElDFhWBQLHk9KYbvTV6t8PR4ymIGmYQaecC/fWH2AnAsO9Pvr/gX6iBollscW45+iDgXaQfy++aULs17DrM6akhy48hEjeFtXxuON+2IYw0LM04XRvFMrwMZEsZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WU3JHyqB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cLgABQww; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CHHh6L1844891
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aPbALq5EWlVJj+SSy5g3TRuBJUzxMMl3cd+mPm8hOTA=; b=WU3JHyqBwr9MD3hQ
	hZcNh3oTlWx42S6EI2Gb1UulWVqwK54j0tNfW2Gyrkh3P803c4rSsnYM+G+Dp2fu
	+3NGmExQLSs6p8z7s69emkea2TX1WcNpXqvav74tU6p/YK4AulJpIJ800DYberHp
	vh9J91vc39mb5XICsdR9Fpry0hkGMM7HcDoDkDwLrZf9FhN0/120CkU+VJGC5u4t
	4fN5Hjhw9jWX66NQnHy8lTlGjz+rhc06UerfOYe+eYdHV6BIUmEqK9dogVGr7pE8
	L1LEEQHKVxf4GTHGKiy31OxS0wc0nH0h4pw1XQy2B/6MR0JyO2vZBX7NMq00p0cM
	/wQM+w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9k4w80ka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:24:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a943e214daso1881505ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 09:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770917057; x=1771521857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPbALq5EWlVJj+SSy5g3TRuBJUzxMMl3cd+mPm8hOTA=;
        b=cLgABQwwTYF5sdTIcLSM5hWGNHrbrB12sBVh3O72y4Ovy8gexNdu//kQQ9PxxWEyfV
         fI1/RLH1viJNGiX29gpZ4iXz+oHZ0xtVI+zZNyX7AzGReLdj/KHGw/+SJdithWHSkUn1
         7myB7aLhW7kirmW9/DHfYXCWqkn6TZ1tah0RvGpJ9T2dc0ekvr+hZdYYLiC+seZsAbYS
         yfF3m7VyaKR16ELpmoWAOeL0qnHDdUq+QPN0TZEdkCmz36QmLdUQUGXKLiyrdSJdwRFo
         xX60Z9mKCoCCrTnqtd52H9j5X8M8KWKUFG7GyTD1FjNup32FSypw0PuZ6/XXx3GeAwkW
         7ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917057; x=1771521857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aPbALq5EWlVJj+SSy5g3TRuBJUzxMMl3cd+mPm8hOTA=;
        b=siFBzsMKkyj1KM+UczepuK9Rsfk7MHA90xaGZqC49dT1Cr1sTWcjFN8F8BDeC8JjGk
         smGAR4622GckKxkyM9Jx6qx583UbHJq5hM20BoMro3uc7XELTah4mSYDafjWQzDftIxy
         cWS9hknwtjfuRdsKQ11HgJNlEMx10qyJgB0TdtxoYGC6xHDAwjIV82QYjflkhCMpUSwJ
         D5SnUQoaxy7AcTgxPGSqaa44TDwo9Hen8rHPuORYVlJgHuzZkUjyOtCOVS4IZcag6edI
         xjj7ny0UA39F6fnfjV6xeCgkCTnn1AGS4jugBtHWm+tYyT7VkXgIQY8NTcf2Nr3RtmQ1
         4ocA==
X-Gm-Message-State: AOJu0Yy9IfZ0Nos4RYfhwgMqIP7C0sEC2GRUuxvLUYWuwuRrlBH1QGii
	5NoApl6hyJ9vbPqcSEhFin4oG3F605fEwHsme4k46ouQRU0ndG7r/FGF2yWxqqW/HXcbQA0zS87
	r9Kh2x/rvxDk79EHHYktMTBndknp9qNO8Mp49utc/QcvCZq4QWlRKk+u5scIQdLb+ABMyYw==
X-Gm-Gg: AZuq6aJkhBeL6UYGxLynCE/ECEsdNpWMwrk3oLEV1BBSC75Vo8+Ui7cYddwiqUJ9Rea
	ln+exetrl6uUZAQzo3yoOOu6/rLM86rnOiw29V0GOzxssOXaAWyqMZovCZG1Iju4JjxBocfo9Gs
	PafkgoXVd17GJek6T6no6Ju1fQRo/l2Jz66U0asw/9uHVwjxhJ2xy/q1ORgF1lmmcydxh1Xlp99
	5JYeNTZFtzQERayc07Ec2+KDIMPtzCqpoQQo+k6aPTUZnOi4YFGl9qdZB1sNM5yz6StFoM00Hb8
	XVUivm9x/+sArSZ8vIynOpqrQYqGyE8VszdJ4jkthuvosC0wfz5pW5M+I1QGkmWRf0P2dWPWPUs
	FWZQcrODHVr9LsVWgnlmgEGjulSD5XtR0G/EAKGRxPtvoLRWwCiVUmTZnvmnuKabrMg==
X-Received: by 2002:a17:902:ebc8:b0:2a7:5751:5b30 with SMTP id d9443c01a7336-2ab396685d6mr38511175ad.12.1770917057216;
        Thu, 12 Feb 2026 09:24:17 -0800 (PST)
X-Received: by 2002:a17:902:ebc8:b0:2a7:5751:5b30 with SMTP id d9443c01a7336-2ab396685d6mr38510755ad.12.1770917056601;
        Thu, 12 Feb 2026 09:24:16 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2999879dsm57697675ad.80.2026.02.12.09.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 09:24:16 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 1/2] wifi: UHR: define DPS/DBE/P-EDCA elements and fix size parsing
Date: Thu, 12 Feb 2026 22:54:00 +0530
Message-Id: <20260212172401.234059-2-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260212172401.234059-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20260212172401.234059-1-karthikeyan.kathirvel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kYMo-Jm-P8dpL4gKKbQTr8rUq5pHA3Nz
X-Authority-Analysis: v=2.4 cv=bfZmkePB c=1 sm=1 tr=0 ts=698e0cc2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=cEV9dx-XaWt1td_ywNsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEzMyBTYWx0ZWRfX0Iy3dytf3g4I
 ucZ7CF+l/aSalYNc58qzzSKPqyWcWJYjkKzWzz35AznZgM8ySMUGalIwFrZFmof3KYY7o1G2fjw
 xM4jNSwIOJWTfmuz93yzGfD4RdwV9HhU8qmrpHFRCVoGwBKEiRKsg3YPWN3dcNBr9BcLMI1ilnI
 0qDXy53s7ZtcM2JNZqJdH8U9940wFT4gB8dqenuVoicM9yuP5ikg439B/rwE5Zd4AdVYsud8cEF
 0BqIXioTQKR5G99s01/I5neQ2oIZKSxTqs1WeHv/k1mUDitomuwKdkV11NtvPGHro1TMeP6jXN5
 SESMK6ctAndx043WVCLkxt5LNzkwWVhPCO/WV5Q4EX/6SDpEK/yaN84N2gYxc635VLHEoGKXeos
 llEGN9FE+orB3cHxrjJEG3BiiakWx2weh4Y7zU7/+iwOEd1rVJDPqOl3jADgUIZFhyRfQwdgyKL
 aUVZi60PRPccG+oO1rg==
X-Proofpoint-GUID: kYMo-Jm-P8dpL4gKKbQTr8rUq5pHA3Nz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120133
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31778-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DC7AB12FE0E
X-Rspamd-Action: no action

Add UHR Operation and Capability definitions and parsing helpers:

- Define ieee80211_uhr_dps_info, ieee80211_uhr_dbe_info,
  ieee80211_uhr_p_edca_info with masks.
- Update ieee80211_uhr_oper_size_ok() to account for optional
  DPS/DBE/P-EDCA blocks.
- Move NPCA pointer position after DPS Operation Parameter if it is
  present in ieee80211_uhr_oper_size_ok().
- Move NPCA pointer position after DPS info if it is present in
  ieee80211_uhr_npca_info().

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 include/linux/ieee80211-uhr.h | 257 +++++++++++++++++++++++++++++++++-
 1 file changed, 251 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
index 132acced7d79..23fb3acf700a 100644
--- a/include/linux/ieee80211-uhr.h
+++ b/include/linux/ieee80211-uhr.h
@@ -29,11 +29,200 @@ struct ieee80211_uhr_operation {
 #define IEEE80211_UHR_NPCA_PARAMS_MOPLEN		0x00400000
 #define IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES	0x00800000
 
+/**
+ * struct ieee80211_uhr_npca_info - npca operation information
+ *
+ * This structure is the "NPCA Operation Parameters field format" of "UHR
+ * Operation Element" fields as described in P802.11bn_D1.3
+ * subclause 9.4.2.353. Refer Figure 9-aa4.
+ *
+ * Please refer IEEE80211_UHR_NPCA*
+ * @params:
+ *	NPCA Primary Channel - NPCA primary channel
+ *	NPCA_Min Duration Threshold - Minimum duration of inter-BSS activity
+ *	NPCA Switching Delay -
+ *		Time needed by an NPCA AP to switch from the
+ *		BSS primary channel to the NPCA primary channel
+ *		in the unit of 4 µs.
+ *	NPCA Switching Back Delay -
+ *		Time to switch from the NPCA primary channel
+ *		to the BSS primary channel in the unit of 4 µs.
+ *	NPCA Initial QSRC -
+ *		Initialize the EDCAF QSRC[AC] variables
+ *		when an NPCA STA in the BSS
+ *		switches to NPCA operation.
+ *	NPCA MOPLEN -
+ *		Indicates which conditions can be used to
+ *		initiate an NPCA operation,
+ *		1 -> both PHYLEN NPCA operation and MOPLEN
+ *		NPCA operation are
+ *		permitted in the BSS
+ *		0 -> only PHYLEN NPCA operation is allowed in the BSS.
+ *	NPCA Disabled Subchannel Bitmap Present -
+ *		Indicates whether the NPCA Disabled Subchannel
+ *		Bitmap field is present. A 1 in this field indicates that
+ *		the NPCA Disabled Subchannel Bitmap field is present
+ * @dis_subch_bmap:
+ *		A bit in the bitmap that lies within the BSS bandwidth is set
+ *		to 1 to indicate that the corresponding 20 MHz subchannel is
+ *		punctured and is set to 0 to indicate that the corresponding
+ *		20 MHz subchannel is not punctured. A bit in the bitmap that
+ *		falls outside of the BSS bandwidth is reserved. This field is
+ *		present when the value of the NPCA Disabled Subchannel Bitmap
+ *		Field Present field is equal to 1, and not present, otherwise
+ */
 struct ieee80211_uhr_npca_info {
 	__le32 params;
 	__le16 dis_subch_bmap[];
 } __packed;
 
+#define IEEE80211_UHR_DPS_PADDING_DELAY			0x0000003F
+#define IEEE80211_UHR_DPS_RESERVED1			0x000000C0
+#define IEEE80211_UHR_DPS_TRANSITION_DELAY		0x00003F00
+#define IEEE80211_UHR_DPS_RESERVED2			0x0000C000
+#define IEEE80211_UHR_DPS_ICF_REQUIRED			0x00010000
+#define IEEE80211_UHR_DPS_PARAMETERIZED_FLAG		0x00020000
+#define IEEE80211_UHR_DPS_LC_MODE_BW			0x001C0000
+#define IEEE80211_UHR_DPS_LC_MODE_NSS			0x01E00000
+#define IEEE80211_UHR_DPS_LC_MODE_MCS			0x1E000000
+#define IEEE80211_UHR_DPS_MOBILE_AP_DPS_STATIC_HCM	0x20000000
+#define IEEE80211_UHR_DPS_RESERVED3			0xC0000000
+
+/**
+ * struct ieee80211_uhr_dps_info - DPS operation information
+ *
+ * This structure is the "DPS Operation Parameter field" of "UHR
+ * Operation Element" fields as described in P802.11bn_D1.3
+ * subclause 9.4.1.87. Refer Figure 9-207u.
+ *
+ * Please refer IEEE80211_UHR_DPS*
+ * @dps_params:
+ *	DPS Padding Delay -
+ *		Indicates the minimum MAC padding
+ *		duration that is required by a DPS STA
+ *		in an ICF to cause the STA to transition
+ *		from the lower capability mode to the
+ *		higher capability mode. The DPS Padding
+ *		Delay field is in units of 4 µs.
+ *	DPS Transition Delay -
+ *		Indicates the amount of time required by a
+ *		DPS STA to transition from the higher
+ *		capability mode to the lower capability
+ *		mode. The DPS Transition Delay field is in
+ *		units of 4 µs.
+ *	ICF Required -
+ *		Indicates when the DPS assisting STA needs
+ *		to transmit an ICF frame to the peer DPS STA
+ *		before performing the frame exchanges with
+ *		the peer DPS STA in a TXOP.
+ *			1 -> indicates that the transmission of the
+ *			ICF frame to the peer DPS STA prior to
+ *			any frame exchange is needed.
+ *			0 -> ICF transmission before the frame
+ *			exchanges with the peer DPS STA is only
+ *			needed if the frame exchange is performed
+ *			in the HC mode.
+ *	Parameterized Flag -
+ *		0 -> indicate that only 20 MHz, 1 SS,
+ *		non-HT PPDU format with the data
+ *		rate of 6, 12, and 24 Mb/s as the
+ *		default mode are supported by the
+ *		DPS STA in the LC mode
+ *		1 -> indicate that a bandwidth up to the
+ *		bandwidth indicated in the LC Mode
+ *		Bandwidth field, a number of spatial
+ *		streams up to the NSS indicated in
+ *		the LC Mode Nss field, and an MCS up
+ *		to the MCS indicated in the LC Mode
+ *		MCS fields are supported by the DPS
+ *		STA in the LC mode as the
+ *		parameterized mode.
+ *	LC Mode Bandwidth -
+ *		Indicates the maximum bandwidth supported
+ *		by the STA in the LC mode.
+ *	LC Mode NSS -
+ *		Indicates the maximum number of the spatial
+ *		streams supported by the STA in the LC mode.
+ *	LC Mode MCS -
+ *		Indicates the highest MCS supported by the STA
+ *		in the LC mode.
+ *	Mobile AP DPS Static HCM -
+ *		1 -> indicate that it will remain in the DPS high
+ *		capability mode until the next TBTT on that
+ *		link.
+ *		0 -> otherwise.
+ */
+struct ieee80211_uhr_dps_info {
+	__le32 dps_params;
+} __packed;
+
+#define IEEE80211_UHR_DBE_OPER_BANDWIDTH			0x07
+#define IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES	0x08
+#define IEEE80211_UHR_DBE_OPER_RESERVED				0xF0
+#define IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP		0xFFFF
+/**
+ * struct ieee80211_uhr_dbe_info - DBE operation information
+ *
+ * This structure is the "DBE Operation Parameters field" of
+ * "UHR Operation Element" fields as described in P802.11bn_D1.3
+ * subclause 9.4.2.353. Refer Figure 9-aa6.
+ *
+ * Please refer IEEE80211_UHR_DBE_OPER*
+ * @dbe_params:
+ *	B0-B2 - DBE Bandwidth field is set to indicate
+ *	expanded bandwidth for DBE mode
+ *	Value 0 is reserved.
+ *	Set to 1 to indicate 40 MHz DBE bandwidth.
+ *	Set to 2 to indicate 80 MHz DBE bandwidth.
+ *	Set to 3 to indicate 160 MHz DBE bandwidth.
+ *	Set to 4 to indicate 320-1 MHz DBE bandwidth.
+ *	Set to 5 to indicate 320-2 MHz DBE bandwidth.
+ *	Values 6 to 7 are reserved.
+ *	B3 - DBE Disabled Subchannel Bitmap Present.
+ * @dis_subch_bmap: DBE Disabled Subchannel Bitmap field is set to indicate
+ *	disabled 20 MHz subchannels within the DBE Bandwidth.
+ */
+struct ieee80211_uhr_dbe_info {
+	u8 dbe_params;
+	__le16 dis_subch_bmap[];
+} __packed;
+
+#define IEEE80211_UHR_P_EDCA_ECWMIN		0x0F
+#define IEEE80211_UHR_P_EDCA_ECWMAX		0xF0
+#define IEEE80211_UHR_P_EDCA_AIFSN		0x000F
+#define IEEE80211_UHR_P_EDCA_CW_DS		0x0030
+#define IEEE80211_UHR_P_EDCA_PSRC_THRESHOLD	0x01C0
+#define IEEE80211_UHR_P_EDCA_QSRC_THRESHOLD	0x0600
+#define IEEE80211_UHR_P_EDCA_RESERVED		0x7800
+/**
+ * struct ieee80211_uhr_p_edca_info - P-EDCA operation information
+ *
+ * This structure is the "P-EDCA Operation Parameters field" of
+ * "UHR Operation Element" fields as described in P802.11bn_D1.3
+ * subclause 9.4.2.353. Refer Figure 9-aa5.
+ *
+ * Please refer IEEE80211_UHR_P_EDCA*
+ * @p_edca_ec: The P-EDCA ECWmin, P-EDCA and ECWmax
+ *	fields indicate the CWmin and CWmax
+ *	value that are used by a P-EDCA STA during P-EDCA contention.
+ * @p_edca_params: The AIFSN field indicate the AIFSN value that are
+ *	used by a P-EDCA STA during P-EDCA contention.
+ *	The CW DS field indicate the value used
+ *	for the randomization of the transmission slot of the DS-CTS
+ *	frame. The value 3 is reserved. The value 0 indicate that
+ *	randomization not enabled.
+ *	The P-EDCA PSRC threshold field indicates the maximum number
+ *	of allowed consecutive DS-CTS transmissions. The value 0 and
+ *	values greater than 4 are reserved
+ *	The P-EDCA QSRC threshold field indicates the value of the
+ *	QSRC[AC_VO] counter to be allowed to start P-EDCA contention.
+ *	The value 0 is reserved.
+ */
+struct ieee80211_uhr_p_edca_info {
+	u8 p_edca_ec;
+	__le16 p_edca_params;
+} __packed;
+
 static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
 					      bool beacon)
 {
@@ -47,19 +236,52 @@ static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
 	if (beacon)
 		return true;
 
-	/* FIXME: DPS, DBE, P-EDCA (consider order, also relative to NPCA) */
+	/* DPS Operation Parameters (fixed 4 bytes) */
+	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DPS_ENA)) {
+		needed += sizeof(struct ieee80211_uhr_dps_info);
+		if (len < needed)
+			return false;
+	}
 
+	/* NPCA Operation Parameters (fixed 4 bytes + optional 2 bytes) */
 	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)) {
 		const struct ieee80211_uhr_npca_info *npca =
-			(const void *)oper->variable;
+			(const void *)(data + needed);
 
 		needed += sizeof(*npca);
-
 		if (len < needed)
 			return false;
 
-		if (npca->params & cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES))
+		if (npca->params &
+		    cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES)) {
 			needed += sizeof(npca->dis_subch_bmap[0]);
+			if (len < needed)
+				return false;
+		}
+	}
+
+	/* P-EDCA Operation Parameters (fixed 3 bytes) */
+	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_PEDCA_ENA)) {
+		needed += sizeof(struct ieee80211_uhr_p_edca_info);
+		if (len < needed)
+			return false;
+	}
+
+	/* DBE Operation Parameters (fixed 1 byte + optional 2 bytes) */
+	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DBE_ENA)) {
+		const struct ieee80211_uhr_dbe_info *dbe =
+			(const void *)(data + needed);
+
+		needed += sizeof(*dbe);
+		if (len < needed)
+			return false;
+
+		if (dbe->dbe_params &
+		    IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES) {
+			needed += sizeof(dbe->dis_subch_bmap[0]);
+			if (len < needed)
+				return false;
+		}
 	}
 
 	return len >= needed;
@@ -72,12 +294,16 @@ static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
 static inline const struct ieee80211_uhr_npca_info *
 ieee80211_uhr_npca_info(const struct ieee80211_uhr_operation *oper)
 {
+	const u8 *pos;
+
 	if (!(oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)))
 		return NULL;
 
-	/* FIXME: DPS */
+	pos = oper->variable;
+	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DPS_ENA))
+		pos += sizeof(struct ieee80211_uhr_dps_info);
 
-	return (const void *)oper->variable;
+	return (const void *)pos;
 }
 
 static inline const __le16 *
@@ -131,6 +357,25 @@ ieee80211_uhr_npca_dis_subch_bitmap(const struct ieee80211_uhr_operation *oper)
 #define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES	0x08
 #define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES	0x10
 
+/**
+ * enum ieee80211_dbe_bandwidth - DBE Bandwidth
+ *
+ * As per spec P802.11bn_D1.3 "Table 9-bb5—Encoding of the DBE Maximum
+ * Supported Bandwidth field"
+ *
+ * @IEEE80211_DBE_BANDWIDTH_40MHZ: Indicate 40 MHz DBE bandwidth
+ * @IEEE80211_DBE_BANDWIDTH_80MHZ: Indicate 80 MHz DBE bandwidth
+ * @IEEE80211_DBE_BANDWIDTH_160MHZ: Indicate 160 MHz DBE bandwidth
+ * @IEEE80211_DBE_BANDWIDTH_320MHZ: Indicate 320 MHz DBE bandwidth
+ *
+ */
+enum ieee80211_dbe_bandwidth {
+	IEEE80211_DBE_BANDWIDTH_40MHZ = 1,
+	IEEE80211_DBE_BANDWIDTH_80MHZ = 2,
+	IEEE80211_DBE_BANDWIDTH_160MHZ = 3,
+	IEEE80211_DBE_BANDWIDTH_320MHZ = 4,
+};
+
 struct ieee80211_uhr_cap_mac {
 	u8 mac_cap[5];
 } __packed;
-- 
2.34.1


