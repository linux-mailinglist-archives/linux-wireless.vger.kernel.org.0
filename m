Return-Path: <linux-wireless+bounces-37989-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HewMGbsCOmoi0AcAu9opvQ
	(envelope-from <linux-wireless+bounces-37989-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 05:51:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB16B3E2A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 05:51:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=E5hjDdL7;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VZQ+42Li;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37989-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37989-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F8C43016667
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 03:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADC927AC57;
	Tue, 23 Jun 2026 03:51:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12C63B9
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 03:51:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186679; cv=none; b=D0fJQLhlaVqACJ1pm9pNw8LmVjPHIZRdeJ3PiwpzHSfeDrgmUX8NQlEvy1bbZFZQJFLhVCJkVXzAD9+qUHmL7mx3vXa4ScP2CU/okJTPZtDiewhri5qZIXKlnTEcrAsi8Q6iTyiDOxRTZ1GOEwayXRsk1GcWySrgNfzKYHc+stA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186679; c=relaxed/simple;
	bh=4DUq/c0KuTnqki8QeQGpUPfxVFH6gHrexqXptyzn/Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bh8Idz+OuPMzEQw4ojgvbN/Qs7DY8lp/USt93p8llWmPDd4VxSTowS1unQnSICOpfXyKVMWdIqF4NZrB7eeK0b0g7pbFeHXRMoa9HAR5hqknRy3ebABSG2h9OFXob0mNIRpjLdu1o34Ors4+I+ahiNDNCDHm+jkhlkxkySIdUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E5hjDdL7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VZQ+42Li; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0kQBQ2599642
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 03:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=i2FMV4qXXYG6SBDoZjlw8oaGTiGHYxPxZX7
	e/s/Cgp0=; b=E5hjDdL7Iy5xa/BM+M6tqnyYF8bm57nYyJ00J0i/JWFR/T4OPk+
	qQSVwQf+AxsSMY5kS3QIUFDaxiFmAfQfubxV0aWonHIGg+OzjLRUCXuHLfqH0isx
	V+/dvHB1l0/UVwI4ok1dRVV8RMggahsS/Smn8S7tFFt/CQtantloDHf5k4G68ZLe
	jmD74k4OzeZeF/7rUhfxrmLr02IT8T9573JK2xzOgKUN6+yQPYUHI34yba4XptVz
	Eb+4TYh5yqdSAa4hWoRJ5k+Zg5d1p4BoJ1ElAZFg97ncvaw1lECu/NlFs+azWkTD
	N5ap/ofwLkIZ9k4Ru+/BXo3TyDm1ygQMR0w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5yeasbr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 03:51:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c6a3ece0d8so39728055ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 20:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782186670; x=1782791470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i2FMV4qXXYG6SBDoZjlw8oaGTiGHYxPxZX7e/s/Cgp0=;
        b=VZQ+42LikWifHsvzPqVC2Ox4pNwKp/qPiC874T4WGDRuhPaZp3/gTqFYvNajNAdLVZ
         yWCs2PQIy1jm8ONBgKzG1IGG9WLkl7NMUotACwtIt2ehUO8TOL+VeiYSZpGzXAbe/VWg
         p4RkDdjh+u/pFZkFaJdMFBmk3G4t+UCLXOtNRN0W5cLnXOL/wS1UkUGYsFP6Gqp1PXZa
         W4GAsr7XuFVjso5i7UtnIZN9nd+ihDn1W0GlybS+oht16FWTaAVn+MR5M+swQtTSg31o
         cvHbelhVlbH/lUY2VfOBVDTyN/CaoKmbQ+msS+PBrcuxCQXq10stcjVDVzwjWDENVgjB
         rsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782186670; x=1782791470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2FMV4qXXYG6SBDoZjlw8oaGTiGHYxPxZX7e/s/Cgp0=;
        b=jwnvDgsRQYw9mnu+Wm5aSMLA/+C4Sm0rwVhu4BLrlDkaZoVmiOLE8JmVWL5jYtqbVD
         XVMrrPkNz2Dc91Yyza7dhBVBX2NvmlZ0PW67RI6PFnqmYhyzvsdF2b2ELAjgr9JZyKA0
         bGnOhqof3ITq8DZrxNIDCgHNysVJfAo40LplJbIzrVYGDdJedc2aYsS4T2fkihGRMhJ9
         SzeGMWd0luD2QtNEuZ9M3b/BBdY2MR9SKdqg3geQCOM0dMZUQjg+YgAnNuXUZJ3q/Xsr
         OixWmm0EAaD+cMQdDIBxDHLl5Hk5Gxg57u6GnLcw/pSLq89GP8waKcRH6GPfP9oTJzy9
         4JaQ==
X-Gm-Message-State: AOJu0YxwXSIgxiMAqkcQwrrVTimmIbeL35n9FYcpu53Zd8uffCrlz1kv
	M3ZJLFUMC4dghrMjVsQlTqPXFtSP44A9XPswvmv2yJJYxLq0IWlXkeHYWmq5Te9heQwuI5OiNh+
	e7rteXzk9aHHibDnY4IJiaPcraOvIjBK6jaTPiDdjn7Wpdo1Md5nuadFaBwmbZ5/45U9UHGorzt
	Dp4w==
X-Gm-Gg: AfdE7ckBiMp1B86QGZ7bqnmQ0iu43j1SiP221ocaUjRSot30XVke0mQkE11sJAVj/eb
	u/qdMbTHBZWiVZD66Cj/fQaTTS8LeTHH7sPeOXOurGn1v6VjJYsuQzEdAF1J/vDC0P0z6jc0MnI
	48ICC/yoS8d0OVZFiof2rhMXKhbmIjeuX6oI5UnLFYXKMEFufFSQq/7Sov7YMGYTB9buFhujbxa
	TLEGoLxmfNY98HZxfxOzUK4+HQhXJ5mtAsMVT24KhazfPuzkyUgcB9El4H41BtcLOgrpEjeqwbt
	eAyRXjkx3wEXO5p2IEp4evBG4CozpfohlZbOeSm9FmGcOSNpGN00pbfk2UgUztsqm2OQmFTSQEr
	01nEoiFVzleWU4pEEKYJ88U0jwWJMdNMS7wNgoe46V5XQkNEF6dCJmCvfkH+4kqDNycd0AejUqD
	KMhptfTJEkVi4bW/CXnSaM2o3LPIwZ+vYGNw==
X-Received: by 2002:a17:902:ce82:b0:2c7:c4b8:60eb with SMTP id d9443c01a7336-2c7c4b8678dmr18585085ad.3.1782186669970;
        Mon, 22 Jun 2026 20:51:09 -0700 (PDT)
X-Received: by 2002:a17:902:ce82:b0:2c7:c4b8:60eb with SMTP id d9443c01a7336-2c7c4b8678dmr18584885ad.3.1782186669526;
        Mon, 22 Jun 2026 20:51:09 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aa5f1sm110095495ad.78.2026.06.22.20.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 20:51:09 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: remove unused QMI definitions
Date: Tue, 23 Jun 2026 09:21:04 +0530
Message-Id: <20260623035104.3765404-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _DxokE-Rdh1O7XhqHjPCd6thh34RXgkP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAyNyBTYWx0ZWRfX+1fwg94jg14W
 IFJxal8FF5/JIYtgAR6q1td7j9nJF2x54ERvFeqIG+dDwBsxPM58afgOXZzH9KreMe6Wpm8flNn
 lL5D//eJCetpWcON/QDcFBOwaLouK6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAyNyBTYWx0ZWRfXwzL3y0e3r30C
 T5SyA9TQvOoxTa6LIdrwY7tp5LeF8x9xeCORKzQes9lFtGRbs0ecuSYdX2zubkfy9xD07iNySaP
 kUDgTso2h15gc8greKuAJuchD0BTliYpdWn2WFAoFDNYgVocL6bI+GGi9+JOvFihIDNP2sGTm2n
 JMna/9j//K4wdyz7EhNjukHDSATxlrkNLdOiwgMrQQe7djDdcNdURk8uOmp8Ivzm83/Dt6nR863
 R8xx+sWybmMH3sGE2zzb1SDuRyDBVZRM3FAQJaBkwwNxpeIhC6YrUT0nLQHaD5wOowsPtbsqP4I
 nkog06g1Evumkdjc71+ecMyWd/Tpn2c5qWeW1VUlgQmDRr5RF3Da8nhtnYt4WFNc5QgLhyv4aC3
 UKX7ICXJaew4LBatkHiVN4GK8tBKd31v+CHaRNakJLUArHaQstLv/QA/rBL+8pMCZEU2Gb8XYVq
 C5lhmS41LugZN4RCh6w==
X-Proofpoint-GUID: _DxokE-Rdh1O7XhqHjPCd6thh34RXgkP
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a3a02af cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=hj2YK8iUnCGhfojHIzIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230027
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37989-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAAB16B3E2A

The driver contains several unused QMI definitions such as response
length macros, message IDs, firmware segment length definitions, and
CALDB address size definitions.

Remove these unused definitions as they are not referenced anywhere in
the driver.

No functional change intended.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/qmi.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 2a63e214eb42..80a9b42a2548 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -13,7 +13,6 @@
 #define ATH12K_HOST_VERSION_STRING		"WIN"
 #define ATH12K_QMI_WLANFW_TIMEOUT_MS		10000
 #define ATH12K_QMI_MAX_BDF_FILE_NAME_SIZE	64
-#define ATH12K_QMI_CALDB_ADDRESS		0x4BA00000
 #define ATH12K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01	128
 #define ATH12K_QMI_WLFW_SERVICE_VERS_V01	0x01
 #define ATH12K_QMI_WLFW_SERVICE_INS_ID_V01	0x02
@@ -24,9 +23,7 @@
 #define ATH12K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01	32
 #define ATH12K_QMI_RESP_LEN_MAX			8192
 #define ATH12K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	52
-#define ATH12K_QMI_CALDB_SIZE			0x480000
 #define ATH12K_QMI_BDF_EXT_STR_LENGTH		0x20
-#define ATH12K_QMI_FW_MEM_REQ_SEGMENT_CNT	3
 #define ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01 4
 #define ATH12K_QMI_DEVMEM_CMEM_INDEX	0
 
@@ -160,8 +157,6 @@ struct ath12k_qmi {
 
 #define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		261
 #define QMI_WLANFW_HOST_CAP_REQ_V01			0x0034
-#define QMI_WLANFW_HOST_CAP_RESP_MSG_V01_MAX_LEN	7
-#define QMI_WLFW_HOST_CAP_RESP_V01			0x0034
 #define QMI_WLFW_MAX_NUM_GPIO_V01			32
 #define QMI_WLANFW_MAX_PLATFORM_NAME_LEN_V01		64
 #define QMI_WLANFW_MAX_HOST_DDR_RANGE_SIZE_V01		3
@@ -267,8 +262,6 @@ struct qmi_wlanfw_host_cap_resp_msg_v01 {
 
 #define QMI_WLANFW_PHY_CAP_REQ_MSG_V01_MAX_LEN		0
 #define QMI_WLANFW_PHY_CAP_REQ_V01			0x0057
-#define QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN		18
-#define QMI_WLANFW_PHY_CAP_RESP_V01			0x0057
 
 struct qmi_wlanfw_phy_cap_req_msg_v01 {
 };
@@ -285,8 +278,6 @@ struct qmi_wlanfw_phy_cap_resp_msg_v01 {
 
 #define QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN		54
 #define QMI_WLANFW_IND_REGISTER_REQ_V01				0x0020
-#define QMI_WLANFW_IND_REGISTER_RESP_MSG_V01_MAX_LEN		18
-#define QMI_WLANFW_IND_REGISTER_RESP_V01			0x0020
 #define QMI_WLANFW_CLIENT_ID					0x4b4e454c
 
 struct qmi_wlanfw_ind_register_req_msg_v01 {
@@ -322,12 +313,8 @@ struct qmi_wlanfw_ind_register_resp_msg_v01 {
 	u64 fw_status;
 };
 
-#define QMI_WLANFW_REQUEST_MEM_IND_MSG_V01_MAX_LEN	1824
 #define QMI_WLANFW_RESPOND_MEM_REQ_MSG_V01_MAX_LEN	888
-#define QMI_WLANFW_RESPOND_MEM_RESP_MSG_V01_MAX_LEN	7
-#define QMI_WLANFW_REQUEST_MEM_IND_V01			0x0035
 #define QMI_WLANFW_RESPOND_MEM_REQ_V01			0x0036
-#define QMI_WLANFW_RESPOND_MEM_RESP_V01			0x0036
 #define QMI_WLANFW_MAX_NUM_MEM_CFG_V01			2
 #define QMI_WLANFW_MAX_STR_LEN_V01                      16
 
@@ -385,9 +372,7 @@ struct qmi_wlanfw_fw_ready_ind_msg_v01 {
 };
 
 #define QMI_WLANFW_CAP_REQ_MSG_V01_MAX_LEN	0
-#define QMI_WLANFW_CAP_RESP_MSG_V01_MAX_LEN	207
 #define QMI_WLANFW_CAP_REQ_V01			0x0024
-#define QMI_WLANFW_CAP_RESP_V01			0x0024
 
 enum qmi_wlanfw_pipedir_enum_v01 {
 	QMI_WLFW_PIPEDIR_NONE_V01 = 0,
@@ -500,8 +485,6 @@ struct qmi_wlanfw_cap_req_msg_v01 {
 };
 
 #define QMI_WLANFW_BDF_DOWNLOAD_REQ_MSG_V01_MAX_LEN	6182
-#define QMI_WLANFW_BDF_DOWNLOAD_RESP_MSG_V01_MAX_LEN	7
-#define QMI_WLANFW_BDF_DOWNLOAD_RESP_V01		0x0025
 #define QMI_WLANFW_BDF_DOWNLOAD_REQ_V01			0x0025
 /* TODO: Need to check with MCL and FW team that data can be pointer and
  * can be last element in structure
@@ -529,8 +512,6 @@ struct qmi_wlanfw_bdf_download_resp_msg_v01 {
 };
 
 #define QMI_WLANFW_M3_INFO_REQ_MSG_V01_MAX_MSG_LEN	18
-#define QMI_WLANFW_M3_INFO_RESP_MSG_V01_MAX_MSG_LEN	7
-#define QMI_WLANFW_M3_INFO_RESP_V01		0x003C
 #define QMI_WLANFW_M3_INFO_REQ_V01		0x003C
 
 struct qmi_wlanfw_m3_info_req_msg_v01 {
@@ -543,7 +524,6 @@ struct qmi_wlanfw_m3_info_resp_msg_v01 {
 };
 
 #define QMI_WLANFW_AUX_UC_INFO_REQ_MSG_V01_MAX_MSG_LEN	18
-#define QMI_WLANFW_AUX_UC_INFO_RESP_MSG_V01_MAX_MSG_LEN	7
 #define QMI_WLANFW_AUX_UC_INFO_REQ_V01	0x005A
 
 struct qmi_wlanfw_aux_uc_info_req_msg_v01 {
@@ -556,13 +536,9 @@ struct qmi_wlanfw_aux_uc_info_resp_msg_v01 {
 };
 
 #define QMI_WLANFW_WLAN_MODE_REQ_MSG_V01_MAX_LEN	11
-#define QMI_WLANFW_WLAN_MODE_RESP_MSG_V01_MAX_LEN	7
 #define QMI_WLANFW_WLAN_CFG_REQ_MSG_V01_MAX_LEN		803
-#define QMI_WLANFW_WLAN_CFG_RESP_MSG_V01_MAX_LEN	7
 #define QMI_WLANFW_WLAN_MODE_REQ_V01			0x0022
-#define QMI_WLANFW_WLAN_MODE_RESP_V01			0x0022
 #define QMI_WLANFW_WLAN_CFG_REQ_V01			0x0023
-#define QMI_WLANFW_WLAN_CFG_RESP_V01			0x0023
 #define QMI_WLANFW_MAX_STR_LEN_V01			16
 #define QMI_WLANFW_MAX_NUM_CE_V01			12
 #define QMI_WLANFW_MAX_NUM_SVC_V01			24
@@ -605,9 +581,7 @@ struct qmi_wlanfw_wlan_cfg_resp_msg_v01 {
 };
 
 #define ATH12K_QMI_WLANFW_WLAN_INI_REQ_V01	0x002F
-#define ATH12K_QMI_WLANFW_WLAN_INI_RESP_V01	0x002F
 #define QMI_WLANFW_WLAN_INI_REQ_MSG_V01_MAX_LEN		7
-#define QMI_WLANFW_WLAN_INI_RESP_MSG_V01_MAX_LEN	7
 
 struct qmi_wlanfw_wlan_ini_req_msg_v01 {
 	/* Must be set to true if enable_fwlog is being passed */

base-commit: 1547a99cd8d8c1ab3e04dbd92b72b3b5f7cb85a9
-- 
2.34.1


