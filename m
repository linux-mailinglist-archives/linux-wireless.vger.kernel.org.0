Return-Path: <linux-wireless+bounces-32454-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LfRNyP0p2mtmwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32454-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 09:58:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6021FD071
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 09:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06D8302D0A6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D1384224;
	Wed,  4 Mar 2026 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ALIoAtyb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I6YXmYH9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36B382F30
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614446; cv=none; b=pW3quchFmO3V+klE1ITajxC34SXXUw/TpYPAH2292WCifmdrmglV/xIvBNcFCcLX9vAOKt8Ly8OewZE/M5fV1QkOs/yXBQF2cCKw62nzrLFgsNTxaJl8HsFW77hqDvvsuUJQ80lwnRFZhJhRyVc5r2gKaB6VnuylDivRHOaVuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614446; c=relaxed/simple;
	bh=tHi0l4mNsc2+IpnBGiwFewwbno0HSiD4XB/tEArr5P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Egyv+nb1J/aH2UXQem/8qhyC0xx42ag6CFg5bhGnnXtCPhvOyYC3XRhMSSZ74Q0ECh1Wl7Vef9zVXrNVTCucqLKFuJNS5R3bPybnHCe3tYMJOt3pJ4iAFYZyiFNQ/EekqN9kctN2/jbFqlf2pqdgikLkaIfx2evGwE7tp7xtlv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ALIoAtyb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I6YXmYH9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SZ862306277
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 08:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mpJ/giTWeM/399F13a75/sTh7JH/7xefkR/ovT/YgeQ=; b=ALIoAtybhqd+Z66N
	wjJqGAK1B/bxPBo0IljCnRljlGk5VniQreGGNilXOQKlibf2EMOT/sf16VnFXDVD
	gmDPtYw/90c88xD+bvno5w4KzaTk/Mi2uES51+li9w5FfWxYz/dia34/30vVWbnJ
	2wI+qGisUwawA8w8ydZoEONT9aIVbGgmUZKcm8P+U5XBcWQkqWQK8+htC/mA5u2U
	gogf0W194ei7aqrfeKqRMpi/19S5/u9rFZ0AHb9g4ZSvK1Pydy/AXGSYsBk/fq6y
	aYzOo6a+Yi4wOuZQSwoZTRlKS1w6adrtu6LpfDcWDrYPyx1AFiQsOWlMfq3jaGXO
	F8SesQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpau8sdx2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 08:54:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c629a3276e9so25380685a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 00:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772614443; x=1773219243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpJ/giTWeM/399F13a75/sTh7JH/7xefkR/ovT/YgeQ=;
        b=I6YXmYH9bBTej/MG9epuXi6p7XCHAzM2JRoM2yqkclXzsMWSlTvhFz6Ds5nAJJR5DT
         tc/IuQfM4txT34qbCXbt2OheQd46QR0/oHNTre4Jt2EW4KIzoZsRWqwdsCTzWtzhB8M/
         QwOJQ6q8YtHxtsU17DVGsarS7ihw1NSuR7Un7a4Kt6k0v8GZXjQsTJaaCWwyYcsbSUja
         5EtwXOkR8jpR6x/8ntaensBGzQOy8cXbZNeP/VbI7gPv2dSPnQaqMhU+ob+VEPn5MxLZ
         BnJiUJcSJLA6aN1hvCWnsYsgn8lCaer6mMBq6clzuFTYvTogBIxBsxvzqvcBdqMp5kKn
         IKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772614443; x=1773219243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpJ/giTWeM/399F13a75/sTh7JH/7xefkR/ovT/YgeQ=;
        b=RZRfZoqnBKHIPdd3JBdm51nIj5jfD3B/dokk1F3h48RdGGyqjrelnz+DoXkris4PE4
         HAyPAtyIFS4xIzKuVC/vy3bm2n1WxBNpNKywOttjBFyuJsJtM+gM5R7xfcaHJbr8HYva
         qEs16VQJOtEWhCPTPDmSe+PzbfXbYmaxxtC3J6hwwL+lqRPOKsRL2IOAOR1wsFkAgwhw
         /2TxPgaj2mNggfBVlOHcXgtvimYDc+bsH/U6z9tRNqxnb9qnYfWnNo+zjXDZzBmG6vJC
         i8nEYjgYjXd9aiZQNaj1dQdA7fOkTfakXlRh0t5Rzx6JbcTG9XdFPdPdSQ3MaWaByd4q
         B2vg==
X-Gm-Message-State: AOJu0Yza6YNx9GHDwwWEvKu97g6C/vrDxGkVioo2s51BYH2BA+PDLb0P
	4XnX2kJ5ni6uSFT+7j/sk6PLk/jjmLx0h8/K3lBKHYyrUoIdseIHPefJnyhHJf5zUdZ+cfz+3Ca
	qfzOR+TU6WRruB+jkNsOmZnVKtxEyakRowMhjRfQ7em0teQ0ORjnXqG3i2VaeY+ptGwaf+w==
X-Gm-Gg: ATEYQzwJMd9VLDKNtV6ZI41uUUkcpGjCSwDWGGz4lwd7gMqim7GFLR66uKtMgYVMF/r
	zYKYvuHQi4J7780q8Ee8Orm5KOQvSIYGXI0oy050GnozaMgpGPhSx9UhGr8sSvImcvXgJ12j8/a
	XblT4iskAU30Fz0Byn6E2lBuPYi046+x0MZhq//UpXbMnOvScDEXIGMJ2HvTW/o0MXcwsrYWz8o
	cmz6HH0rDLLKDhADSb+Ul3+ZXlPCAKNMvAvtifihlkASxZCm/wiMeiqgNIDSrFIbPO2ybeEaZL1
	Y1cdrHSN2+6YWvpS4kO/o1jKTdmwZQy7KKSUdPgSDiYEQplSRQPaWonHJvxCjcRf9LJPsZ9S9nN
	oNeudzmi9IB28+akcp3y0XZpRVDhP56fZexckCMZGs+sCzBuHK9eqn2HlLtwzGnmkkw==
X-Received: by 2002:aa7:88c3:0:b0:827:2ec9:e1bc with SMTP id d2e1a72fcca58-82972ce8983mr1377268b3a.61.1772614443125;
        Wed, 04 Mar 2026 00:54:03 -0800 (PST)
X-Received: by 2002:aa7:88c3:0:b0:827:2ec9:e1bc with SMTP id d2e1a72fcca58-82972ce8983mr1377253b3a.61.1772614442507;
        Wed, 04 Mar 2026 00:54:02 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01a9dasm18205140b3a.49.2026.03.04.00.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:54:02 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH wireless-next v5 1/2] wifi: UHR: define DPS/DBE/P-EDCA elements and fix size parsing
Date: Wed,  4 Mar 2026 14:23:42 +0530
Message-Id: <20260304085343.1093993-2-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304085343.1093993-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20260304085343.1093993-1-karthikeyan.kathirvel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AJS1/0o2 c=1 sm=1 tr=0 ts=69a7f32b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=cEV9dx-XaWt1td_ywNsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: PFHC7pMF1zpF5tHLHo0JCgoM4tmXUDl6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX0XZarz8R1K1D
 oHsc4yz2kQlZK9rrlaCVKgwwZQIOvMsXrSrX56wRRRO8ckcanZ9mnYN4N8gF4HRhM2I7Q56vwMZ
 9m2i4RboiuOy2kXR788NeQqxKNl1swFWa7YCU/6YXFVqY39Fud34Srt4dL5+GDLFTPMJkB3QWne
 LUUL7j5vke2MP6CqO1a5r3phhF2Ho6p2AozBsrxXqxaZVHdlh2mni4kPVNurMMJK2EEoZMV1DjC
 9LK+3lPWsPn6Kj2MhXyhhVMSHY7R3yIzhGA75FxtAu6RmMlVmaFcgeV2G3pNRILDigLnC18rmgm
 tI/DcazmG6ZgyI2T0dRYfrSx9JOq6Mqh7QXxi71NmOzLYi9u4e4ayippyfXo2BzxZmKXGWV6YX/
 dQBoMpMSb1dYg0nCI0bMvPEpr9XEME1Gf3d3YxZIarxeAhAf4GNIB159fCKLuzsGsqG60gS+ChD
 VlKO2odsRVu2T5y4YGA==
X-Proofpoint-GUID: PFHC7pMF1zpF5tHLHo0JCgoM4tmXUDl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040067
X-Rspamd-Queue-Id: 4E6021FD071
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-32454-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
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
 include/linux/ieee80211-uhr.h | 271 +++++++++++++++++++++++++++++++++-
 1 file changed, 265 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
index 132acced7d79..982960734ef8 100644
--- a/include/linux/ieee80211-uhr.h
+++ b/include/linux/ieee80211-uhr.h
@@ -29,11 +29,216 @@ struct ieee80211_uhr_operation {
 #define IEEE80211_UHR_NPCA_PARAMS_MOPLEN		0x00400000
 #define IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES	0x00800000
 
+/**
+ * struct ieee80211_uhr_npca_info - npca operation information
+ *
+ * This structure is the "NPCA Operation Parameters field format" of "UHR
+ * Operation Element" fields as described in P802.11bn_D1.3
+ * subclause 9.4.2.353. See Figure 9-aa4.
+ *
+ * Refer to IEEE80211_UHR_NPCA*
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
+#define IEEE80211_UHR_DPS_TRANSITION_DELAY		0x00003F00
+#define IEEE80211_UHR_DPS_ICF_REQUIRED			0x00010000
+#define IEEE80211_UHR_DPS_PARAMETERIZED_FLAG		0x00020000
+#define IEEE80211_UHR_DPS_LC_MODE_BW			0x001C0000
+#define IEEE80211_UHR_DPS_LC_MODE_NSS			0x01E00000
+#define IEEE80211_UHR_DPS_LC_MODE_MCS			0x1E000000
+#define IEEE80211_UHR_DPS_MOBILE_AP_DPS_STATIC_HCM	0x20000000
+
+/**
+ * struct ieee80211_uhr_dps_info - DPS operation information
+ *
+ * This structure is the "DPS Operation Parameter field" of "UHR
+ * Operation Element" fields as described in P802.11bn_D1.3
+ * subclause 9.4.1.87. See Figure 9-207u.
+ *
+ * Refer to IEEE80211_UHR_DPS*
+ * @params:
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
+	__le32 params;
+} __packed;
+
+#define IEEE80211_UHR_DBE_OPER_BANDWIDTH			0x07
+#define IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES	0x08
+
+/**
+ * enum ieee80211_uhr_dbe_oper_bw - DBE Operational Bandwidth
+ *
+ * Encoding for the DBE Operational Bandwidth field in the UHR Operation
+ * element (DBE Operation Parameters).
+ *
+ * @IEEE80211_UHR_DBE_OPER_BW_40: 40 MHz operational DBE bandwidth
+ * @IEEE80211_UHR_DBE_OPER_BW_80: 80 MHz operational DBE bandwidth
+ * @IEEE80211_UHR_DBE_OPER_BW_160: 160 MHz operational DBE bandwidth
+ * @IEEE80211_UHR_DBE_OPER_BW_320_1: 320-1 MHz operational DBE bandwidth
+ * @IEEE80211_UHR_DBE_OPER_BW_320_2: 320-2 MHz operational DBE bandwidth
+ */
+enum ieee80211_uhr_dbe_oper_bw {
+	IEEE80211_UHR_DBE_OPER_BW_40 = 1,
+	IEEE80211_UHR_DBE_OPER_BW_80 = 2,
+	IEEE80211_UHR_DBE_OPER_BW_160 = 3,
+	IEEE80211_UHR_DBE_OPER_BW_320_1 = 4,
+	IEEE80211_UHR_DBE_OPER_BW_320_2 = 5,
+};
+
+/**
+ * struct ieee80211_uhr_dbe_info - DBE operation information
+ *
+ * This structure is the "DBE Operation Parameters field" of
+ * "UHR Operation Element" fields as described in P802.11bn_D1.3
+ * subclause 9.4.2.353. See Figure 9-aa6.
+ *
+ * Refer to IEEE80211_UHR_DBE_OPER*
+ * @params:
+ *	B0-B2 - DBE Operational Bandwidth field, see
+ *	"enum ieee80211_uhr_dbe_oper_bw" for values.
+ *	Value 0 is reserved.
+ *	Value 1 indicates 40 MHz operational DBE bandwidth.
+ *	Value 2 indicates 80 MHz operational DBE bandwidth.
+ *	Value 3 indicates 160 MHz operational DBE bandwidth.
+ *	Value 4 indicates 320-1 MHz operational DBE bandwidth.
+ *	Value 5 indicates 320-2 MHz operational DBE bandwidth.
+ *	Values 6 to 7 are reserved.
+ *	B3 - DBE Disabled Subchannel Bitmap Present.
+ * @dis_subch_bmap: DBE Disabled Subchannel Bitmap field is set to indicate
+ *	disabled 20 MHz subchannels within the DBE Bandwidth.
+ */
+struct ieee80211_uhr_dbe_info {
+	u8 params;
+	__le16 dis_subch_bmap[];
+} __packed;
+
+#define IEEE80211_UHR_P_EDCA_ECWMIN		0x0F
+#define IEEE80211_UHR_P_EDCA_ECWMAX		0xF0
+#define IEEE80211_UHR_P_EDCA_AIFSN		0x000F
+#define IEEE80211_UHR_P_EDCA_CW_DS		0x0030
+#define IEEE80211_UHR_P_EDCA_PSRC_THRESHOLD	0x01C0
+#define IEEE80211_UHR_P_EDCA_QSRC_THRESHOLD	0x0600
+
+/**
+ * struct ieee80211_uhr_p_edca_info - P-EDCA operation information
+ *
+ * This structure is the "P-EDCA Operation Parameters field" of
+ * "UHR Operation Element" fields as described in P802.11bn_D1.3
+ * subclause 9.4.2.353. See Figure 9-aa5.
+ *
+ * Refer to IEEE80211_UHR_P_EDCA*
+ * @p_edca_ec: P-EDCA ECWmin and ECWmax.
+ *	These fields indicate the CWmin and CWmax values used by a
+ *	P-EDCA STA during P-EDCA contention.
+ * @params: AIFSN, CW DS, PSRC threshold, and QSRC threshold.
+ *	- The AIFSN field indicates the AIFSN value used by a P-EDCA STA
+ *	  during P-EDCA contention.
+ *	- The CW DS field indicates the value used for randomization of the
+ *	  transmission slot of the DS-CTS frame. The value 3 is reserved.
+ *	  The value 0 indicates that randomization is not enabled.
+ *	- The P-EDCA PSRC threshold field indicates the maximum number of
+ *	  allowed consecutive DS-CTS transmissions. The value 0 and values
+ *	  greater than 4 are reserved.
+ *	- The P-EDCA QSRC threshold field indicates the value of the
+ *	  QSRC[AC_VO] counter required to start P-EDCA contention. The
+ *	  value 0 is reserved.
+ */
+struct ieee80211_uhr_p_edca_info {
+	u8 p_edca_ec;
+	__le16 params;
+} __packed;
+
 static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
 					      bool beacon)
 {
@@ -47,19 +252,52 @@ static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
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
+		if (dbe->params &
+		    IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES) {
+			needed += sizeof(dbe->dis_subch_bmap[0]);
+			if (len < needed)
+				return false;
+		}
 	}
 
 	return len >= needed;
@@ -72,12 +310,15 @@ static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
 static inline const struct ieee80211_uhr_npca_info *
 ieee80211_uhr_npca_info(const struct ieee80211_uhr_operation *oper)
 {
+	const u8 *pos = oper->variable;
+
 	if (!(oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)))
 		return NULL;
 
-	/* FIXME: DPS */
+	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DPS_ENA))
+		pos += sizeof(struct ieee80211_uhr_dps_info);
 
-	return (const void *)oper->variable;
+	return (const void *)pos;
 }
 
 static inline const __le16 *
@@ -131,6 +372,24 @@ ieee80211_uhr_npca_dis_subch_bitmap(const struct ieee80211_uhr_operation *oper)
 #define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES	0x08
 #define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES	0x10
 
+/**
+ * enum ieee80211_uhr_dbe_max_supported_bw - DBE Maximum Supported Bandwidth
+ *
+ * As per spec P802.11bn_D1.3 "Table 9-bb5—Encoding of the DBE Maximum
+ * Supported Bandwidth field".
+ *
+ * @IEEE80211_UHR_DBE_MAX_BW_40: Indicates 40 MHz DBE max supported bw
+ * @IEEE80211_UHR_DBE_MAX_BW_80: Indicates 80 MHz DBE max supported bw
+ * @IEEE80211_UHR_DBE_MAX_BW_160: Indicates 160 MHz DBE max supported bw
+ * @IEEE80211_UHR_DBE_MAX_BW_320: Indicates 320 MHz DBE max supported bw
+ */
+enum ieee80211_uhr_dbe_max_supported_bw {
+	IEEE80211_UHR_DBE_MAX_BW_40 = 1,
+	IEEE80211_UHR_DBE_MAX_BW_80 = 2,
+	IEEE80211_UHR_DBE_MAX_BW_160 = 3,
+	IEEE80211_UHR_DBE_MAX_BW_320 = 4,
+};
+
 struct ieee80211_uhr_cap_mac {
 	u8 mac_cap[5];
 } __packed;
-- 
2.34.1


