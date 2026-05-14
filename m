Return-Path: <linux-wireless+bounces-36403-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HeVEG1CBWqATwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36403-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 05:33:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE153D544
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 05:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AB563037437
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 03:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081FE3A3E66;
	Thu, 14 May 2026 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SlMYov/u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZjJfjRAa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D4313523
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778729577; cv=none; b=X5TwjXJShwEoEpCTsyAcCzSq253/IUWwopsY+NazbDDjmTXwIXcEtop0dTuVLgPUbXXe2Q5mJ1fhgeeUaCCL1OrWFY7D8ewVEDerv9OhdrCV7iZv7rraaOKSgpnwfuApEIf5MHIj7MRXDMUk4g+YAWaijRQv4hBppGp3f7/N4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778729577; c=relaxed/simple;
	bh=evn6aUK2lZTX+DpcFxoBGqmpplMOzVbn/BwS/nehrLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DUA4G3Ht/EHqrCYLcw9DnweWFGEVek05dVxBQsZH4OXi+iOkHAAAh83bbV96pReju5GzsE+qtu/RoWjXTf9udJMh8XIX10e/5UovbZom2GbcXTgtDhcF8AtVC/Pfw7gypBvg5MfTMEPSUICO8qxd4LCkCqqD+3n3sUqg7vH/j9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SlMYov/u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZjJfjRAa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DNoxl13474707
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 03:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tDP19UPsXAB5jb3WMhsOr8
	Ux+xOl/E04ZRZxTZx20SQ=; b=SlMYov/ureiMOvwqcs8gNHO0d4fZ4K6I5IHMU0
	TNeDCj/sEaXnJBg4GXULHaikpVuSWCEFXlUtuF6oba09zp/0UiBoiJkmfxeTQh3m
	ZWJia5guTf6GtzGjOXoao9uA+A4Ua29MxrHOEXWhGh+6777zWkYicrvidu76bbYI
	+NhrdMQtJr5tBzTviAlgESqKMw3WS96uYBxCnl8Sa2M9pi/qM7qT8fLWA2OjM/NE
	5E3fz7nFOKbN3Eax4S+zjFzckdu4p0yKDGNoAomaOIRLYreStQ8ZOAOLDDXF7PBm
	8FI4yF9PlC2uTNR+KPfRHWMJtpjIpAnuU6tA9UN7r9AXC24A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p41bu54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 03:32:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b4654f9bb6so78205875ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 20:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778729574; x=1779334374; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDP19UPsXAB5jb3WMhsOr8Ux+xOl/E04ZRZxTZx20SQ=;
        b=ZjJfjRAa8xD6syf6X2ScvtPEdSbcJrROOYCmAWLjgBm7e8IVSQqcRYpVMrbojadSx8
         tUgN9YqQtF+lnv2MKX8GnNxFx9t2A8dCOA+Djne8lMvMYwfrUD6mqiUh0A06CK/DmHyd
         B5fFz3AiMxbdvn/V90l8urvduHTJlJV1mokuGbj68YBP/zyVdjTNHQKscOqJuGHFeUAU
         X/9Hx9km5418TsaON8krX2UUf2raE8cm4e+FKAVuztA2rPLYtRRy72LhWgraijwX/V5h
         84H/lo5NbwJlCg5nKYIbHGEJqhd8VlTSiDOfPm3YlMK+DrI9fImhQ0wiYgCfS3W/AIKl
         1E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778729574; x=1779334374;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDP19UPsXAB5jb3WMhsOr8Ux+xOl/E04ZRZxTZx20SQ=;
        b=ekZJ7FOtTGRrIXgS1tZSaBAeT/fCaz2jaw9wDuiRh2JB+Kqx/Bh9HdMRlLyCjKEeaO
         aicmSuWd0raPxzz6zX9Z8Lrv7m4Gy+LaovFxBojyW+Nb2pU8o82wQ/bKeYhGt+itQEXE
         QqOQxEHspqw/6M3vIONKB6sIuTCFMJv7pNSfzfCba0xYQmUTrbM6p7bmsivIpiBjzI2o
         /EPtfVnvV5/1fUXr866dIXzImrtVHMYdtrmcuo8Bm2uFiCISdcE3hgep2nRn/t6logIj
         Spl4FF5KnKspQrmU7in0gA3PpQrXvCsFEAR55Rf/uuc/lT8BY/0tdX6F/bFlN1Jop7rD
         donA==
X-Gm-Message-State: AOJu0YyYpnq8Tv4kBo3nFXjOM5nt+i66AGg35423Q/ijwDxZoBOTWNG/
	FluOdDli5OqQxMhApA7Lvp0IwyC07jF+p8C77OIOcloXQCW4/gDUL0U40L7IXXqdKL2+5qGDxK9
	QEHKxQJ3eM0Eg4T4LLfcT4NW+jQJcsCDzQGozkcTtaxm2Lcr40oMehXVNgrO7VwE+3vmJXnz+04
	QIAgLU
X-Gm-Gg: Acq92OGoOLWNLNEHr5gPwF4aGkkvn76tJSAdBU9C8qkPfmeB0pq8CKeyJAN8uz1AxVT
	V+gWXVdr0oZn7AdpeYEo21rZZ+eIf4xkqS62KgK75xs3BCwGiWdbMnMtlvh75B7YhYRITpzViwq
	eNSaENG0lgYtKgWkBHC1FC9/w3kHX939w/I0Bz2+37ZUNn5vhD+O9wUj2xaeDE0CnaZfxxLEvs3
	TAmHm/7p/GEF2AykeK6f3lrbrNn/jZnk09F5xb5r69YbnmSt5Bdeo0ek1WcEnLCoajzdR6ttZJf
	4AKGU8LQE77F0n5Emm7RRSJsje3PgkN5w42QuyaaxYOB1ALsplXeBOfEbeK88jRkGEbzSWZBEez
	7asOpwU7xYlwyMVAgeOcv1llk0v9VWBvl75E3PlWcSYzBRTYZrJb6yGYdF5nUVQpWe/lVS3+0qQ
	==
X-Received: by 2002:a17:902:db01:b0:2b9:cd2d:6f13 with SMTP id d9443c01a7336-2bd2716dbd0mr64567995ad.10.1778729574221;
        Wed, 13 May 2026 20:32:54 -0700 (PDT)
X-Received: by 2002:a17:902:db01:b0:2b9:cd2d:6f13 with SMTP id d9443c01a7336-2bd2716dbd0mr64567805ad.10.1778729573705;
        Wed, 13 May 2026 20:32:53 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05ba17sm7610165ad.22.2026.05.13.20.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 20:32:53 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 14 May 2026 11:32:51 +0800
Subject: [PATCH ath-current] wifi: ath12k: fix EHT TX MCS limitation due to
 wrong 20 MHz-only parsing
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-ath12k-fix-20mhz-only-mcs-map-v1-1-a38d4a9b21a2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGJCBWoC/43OzW7CMAwH8FdBOc8oX20oJ95j2iE4Do1GGkhKx
 Yf67st62Q6b4GLJsv37+8EK5UCFbVcPlmkKJaShNuJtxbC3w4EguNozyWXLtdBgx17IT/DhCpL
 H/g5pON4gYoFoT0Cms43tXKsNZ9U4Zaqbi//O6ingJWcaRvZRh30oY8q3JXsSy8qLMZMAAX6vl
 DfodUdml0pZny/2iCnGdS1LwCR/o+0zVFZUO0Iv0e03Uv+Dqh+0EeIZqr4/RYfNhreN0eoPdJ7
 nL3Fn60iIAQAA
X-Change-ID: 20260414-ath12k-fix-20mhz-only-mcs-map-e79a5a9d6470
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a054267 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Ss5F2DYwMVdF2Ol0r0oA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAzMSBTYWx0ZWRfXyG5fZvte02Xd
 uPjpX7dSRxLsT6Se9NV+P5DXea9u2pUqdkFK3IAiySlq7CuAYxsx2y7mfuqsetl2V/ENLYo1G9G
 eE3DQhbsczPuK076bYa196VUmqiwLv3ss8BtYxUnyLUmROQphlRAPwrnCrS6C9YGorFHicSmE5e
 2FiEUdqPPrDk10sOuo4YNnvshnmyrfaf9gaKAvfZiOiHDc9wZwMuKeNdhICrL63300qklVG13Aq
 ngSMiW7FeWSaBa6/q2I65HVGE0axMt6sMnrgHdAFeZAFH7FCEk/MF11F+BrTWqFsTLtLbLxriz3
 XAvU9tp0sQDDUNDGbTkZh3bJLrkU3FfyCcWFwXM4iSBNwR0sw2vlleWdYL6RvGE05CWUky9qtW4
 BfmrZj8phr6YAmv3mo7tS/xGFJe5/2YvzguLngXsuJ6A1vdIcc14swOwmYhYzqajKdvL8tIoI1n
 naag197DvQzW07T5TBA==
X-Proofpoint-GUID: w4AWecOQWMNCBsoNmGwKM6qpaNLFqxy9
X-Proofpoint-ORIG-GUID: w4AWecOQWMNCBsoNmGwKM6qpaNLFqxy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140031
X-Rspamd-Queue-Id: 91DE153D544
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36403-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

When connecting to an AP configured for EHT 20 MHz with a full EHT
MCS/NSS map (supporting MCS 0-13)

Supported EHT-MCS and NSS Set
    EHT-MCS Map (BW <= 80MHz): 0x444444
        .... .... .... .... .... 0100 = Rx Max Nss That Supports EHT-MCS 0-9: 4
        .... .... .... .... 0100 .... = Tx Max Nss That Supports EHT-MCS 0-9: 4
        .... .... .... 0100 .... .... = Rx Max Nss That Supports EHT-MCS 10-11: 4
        .... .... 0100 .... .... .... = Tx Max Nss That Supports EHT-MCS 10-11: 4
        .... 0100 .... .... .... .... = Rx Max Nss That Supports EHT-MCS 12-13: 4
        0100 .... .... .... .... .... = Tx Max Nss That Supports EHT-MCS 12-13: 4

TX throughput is observed to be significantly lower than expected.
Investigation shows that TX rates are limited to EHT MCS 11, even though
the AP advertises support for EHT MCS 12/13.

The root cause is an incorrect parsing of the Supported EHT-MCS and NSS
Set element in ath12k_peer_assoc_h_eht().

IEEE Std 802.11be-2024 Figure 9-1074as describes the format for 20
MHz-Only Non-AP STAs.

IEEE Std 802.11be-2024 Figure 9-1074at describes the format for all
other AP and non-AP STAs.

Currently the first format is parsed when the peer advertises no wider
HE channel width support, without considering whether it is an AP or a
non-AP STA. This is incorrect: the peer AP's capabilities must be parsed
using Figure 9-1074at even when it operates on 20 MHz only. Parsing it
as Figure 9-1074as causes rx_tx_mcs13_max_nss to be interpreted as zero,
which is then passed to firmware, leading firmware to assume the peer
does not support MCS 13 and to limit TX rates at MCS 11.

Fix this by parsing the Figure 9-1074as format only when the peer is a
20 MHz-Only non-AP STA, i.e. when the local interface operates as AP or
mesh point.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 6c95151e2e77 ("wifi: ath12k: Add EHT MCS/NSS rates to Peer Assoc")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fbdfe6424fd7..42b04bd7f677 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3446,7 +3446,9 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 		arg->peer_eht_mcs_count++;
 		fallthrough;
 	default:
-		if (!(link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
+		if ((vif->type == NL80211_IFTYPE_AP ||
+		     vif->type == NL80211_IFTYPE_MESH_POINT) &&
+		    !(link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
 		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
 			bw_20 = &eht_cap->eht_mcs_nss_supp.only_20mhz;
 
@@ -3475,7 +3477,9 @@ static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
 	arg->punct_bitmap = ~arvif->punct_bitmap;
 	arg->eht_disable_mcs15 = link_conf->eht_disable_mcs15;
 
-	if (!(link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
+	if ((vif->type == NL80211_IFTYPE_AP ||
+	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
+	    !(link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
 	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
 		if (bw_20->rx_tx_mcs13_max_nss)
 			max_nss = max(max_nss, u8_get_bits(bw_20->rx_tx_mcs13_max_nss,

---
base-commit: 6a7693873b20680a3c33bae0c9f9cb3185f64ade
change-id: 20260414-ath12k-fix-20mhz-only-mcs-map-e79a5a9d6470

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


