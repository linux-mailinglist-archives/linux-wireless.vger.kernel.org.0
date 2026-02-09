Return-Path: <linux-wireless+bounces-31650-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PlWIAZ2iWlm9gQAu9opvQ
	(envelope-from <linux-wireless+bounces-31650-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 06:52:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E97CF10BE3F
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 06:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3188430185BA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 05:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53F12638B2;
	Mon,  9 Feb 2026 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZZJP2aVt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bxl4TxIg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293924A06B
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770616187; cv=none; b=phjV66DkXeNxoP7UezlOyebbaXa+m1odUT5Fvg5CTAts60OMIVuFv1Jq40ftckJfyzs8CnPnbOBZ+S4vY9YDNOGPTbaNjPzF1i7R90qE2ailS35CExYHUP5D1Bwf2S1irbj8HsQ6I2pqW+k2OYOQ5ZxxeMeXHzPZ2/Y3dvte3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770616187; c=relaxed/simple;
	bh=1H1wl6akBiJvKs4nUPBoFxWWBxuk613Qhx69dd8OTvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MsqbmtlpDLy+ka9ZXTAPdlJhrJm0vRvMr78k88BXoHKpS9fD/nUHRgf7+fRvCHRL/GM65bHHL4lY+LghkHVxQL8Njoc5/070SQ5bJtwUIBRfclU5Ixtcp1PriPMFHvAZ0AIGx+8bd5dKZ9AMlEBkI/HsZ+3uVat6BcLaDs+xozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZZJP2aVt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bxl4TxIg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618DEfTD2099750
	for <linux-wireless@vger.kernel.org>; Mon, 9 Feb 2026 05:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=UbViPxpX1XKSB+nOZnAN6/+UQrnqoUbMH6W
	Xsor8KYw=; b=ZZJP2aVtl9boV0eFTInkitplKk54SzEmhEeRLgNN4YT0vNvfxYY
	a1BS5+MnHEv/OVoH20I2hVAp3kuZPpPJXWwvPPyj350yFAlUuil04k9gv6I4s0bJ
	z+zkSUuBBopElafKd5L+QisV/Uck9zWByZx9LOxMPBieSzfMrYfYmYz7pg1M1epO
	LSrszXYvLUhKr0Qi3bMWvUxqp9GbfqY+gYhfmFqhavYSeLQQNuM9R+SQQHNBwwZ1
	c+mfTvbr3QU7yjOl8wedAjCycdIdCh6PxKtPwKSL2ya4obsV2IBNLo2wQYQMpewi
	3Su2rzSOQsEpkyUUuq6Qq8El8XdD4rDqhgw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c64hnk8m3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 05:49:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c44bf176so1875956a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 08 Feb 2026 21:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770616186; x=1771220986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbViPxpX1XKSB+nOZnAN6/+UQrnqoUbMH6WXsor8KYw=;
        b=bxl4TxIgLasCZJy8yVJAg+kdubBkbCybmu1KUtMSA4Mc4Exh1M4I5bLyYkXNe4M/+1
         Jbv+2fVjIeyFLG5/NZltcDxZhRIX8gqIr3f7ES8fFBFzFutKDXWagUqMuVjgz4e0hUNq
         i5BUPlvqzLpQZfC4atCG9Mbi6/bFoEUk18R6o5qrY6VS1H3tcdETqmrvai4eSR2Af/Ct
         ZoR88X8ehbxw6KEkKRlmpe65bAqQeQ/H4AhyToaKPRcCZzk3hH1dNv5aCZYq4mxRIytJ
         ko1wr+j+1zO/Q6pDgfz98FOghacNq7JEObslso9gz8ZPOkUeBftOi9FR03h3rfBtfzwF
         yh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770616186; x=1771220986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbViPxpX1XKSB+nOZnAN6/+UQrnqoUbMH6WXsor8KYw=;
        b=MB4PKlXAlh2+iBxZ8kI/pLJkFa6LYZb1M4q46aLfg6fm2f2GZhaEGKVnaE0HExU8lh
         XoB+NvkNCol3xow+muOY6i0pRTmGUupVT2LPvBOG9Jf3d6K+5wnz3yjjfFxp+pQLaB3x
         pmGBaFB3SsSuKVmOm5Kkj5kuwJRduerm1W/wDRTJ/yR+W3X3k3esIh9A6iIO8Xs93PLy
         CLgDg2iDbZijkiTg1X1Wert9b0Pu9mzCkpZtifuDEr1b4fPpKCxFFrwlW6V7uC1MkmHy
         pG3sJpK57cwe/jD5dscfsqFQeA+zQ5OPHebAhCCUckC0dml0+/DXBi8F6PjticUH6MjF
         rZcQ==
X-Gm-Message-State: AOJu0YwWBsTRCp109Uz48uzDDVbZ4PF03Ievybx30ZWB2EXP4v4QO0EI
	sUuGPDqSMpAR8q0GDUoAGzU5h7PqZgCIkNvI3K4W16KPBkm3J3e1l0BrmpFZK7SnJ/t///0NZxN
	W+4AXZ8uxeVjE08ezQbvidrWbrqgws+CP/pX0njuPCs6kyZBwodPaq23tLhnY6UsB5NVZbQ==
X-Gm-Gg: AZuq6aLZK6Kvtp+4FwmsmOu0RSKkQa3GGMyaIAEJ4rnKEllcAW4iEPkmayZx8IneYFl
	Ovxl3UE3MCMIxAniUF/XavXtUiCKvYudNn39XgX3XrdD0IW8h6PbOUTxLTmt2/NjAT9I9CJ0qlX
	pMJG579VhqqhA7+FewLClIoktLS4ir3PMJ7VhEz5MWb9rCe/l2p6bJcintplifdz3IJH72+lfaM
	uKFC/5E5Q5GFENEGhS/Bc+LcotDyPolAQPo7Fn92vCUg6AhUIwuqCrc/KgA5FaHDz/Iy7Pycqky
	Uw33vP4/BUb7UBZNzKd00Me5OYW2SPayZ3c/Td9jIfELWuYhjtcx8rLU82HEHmGopjiapbu6iV/
	xdFyfyQBMkwBHwlcmRkbLILWe2QmH7ejG3H1d9lgqSl0Pc45/9QWwLAuyH+SuBtz09t31G6ewEv
	vCQAhmE6niqRmLTFGXfSTa6Vd9sFyBwCONBVz3SzcKnw==
X-Received: by 2002:a17:90b:268b:b0:34f:63b7:a1f5 with SMTP id 98e67ed59e1d1-354b3e2f135mr8769363a91.21.1770616185891;
        Sun, 08 Feb 2026 21:49:45 -0800 (PST)
X-Received: by 2002:a17:90b:268b:b0:34f:63b7:a1f5 with SMTP id 98e67ed59e1d1-354b3e2f135mr8769347a91.21.1770616185369;
        Sun, 08 Feb 2026 21:49:45 -0800 (PST)
Received: from hu-tmariyap-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb4fbd26sm8599371a12.1.2026.02.08.21.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 21:49:44 -0800 (PST)
From: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <praneesh.p@oss.qualcomm.com>,
        Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Fix legacy rate mapping for monitor mode capture
Date: Mon,  9 Feb 2026 11:19:24 +0530
Message-Id: <20260209054924.2713072-1-thiraviyam.mariyappan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dQiokd_72nE5TewwbwfxseXBLq6XOpHC
X-Proofpoint-ORIG-GUID: dQiokd_72nE5TewwbwfxseXBLq6XOpHC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA0NiBTYWx0ZWRfX3gQMTq7FT+XN
 TwHzA6NXdEb4UXSP36Oal84UWVVBgg9mmUWigYeQTIbe8iMD8gAoWjmfMlR/RJwqwJesqo/ZzqX
 N0ukV24/emA+QPtTPC5Mi51jnGxCy0Zk/j+wkd7r8i7cZFEZiCEeUsaDZHlyOGa1vwk9wUThx9e
 fKuVxQmvzCO0SSzh5HeXgdzfrL+r7bVRyIHasKliq9DR1Ov57J6PVtr51LM9MIj2A9d63naprzk
 VbG8J9KeMulmcLPWj69LWiy4oKogx7WIyWmjlgOf/4EVvo3R91RtQBRUfl8uD2KzBaDLrH788b/
 Y7EO5nnDWAvhLLkhz9V70KbwaZEXTE2w5JaAoH37KoYWrIZvb+8JivzwPDNDWLLiq1pJXFCMP2l
 6XG2SkjshNJw24vDDrdTCSw3NXaoiwBqBJjfjk+Qnc5Nun54usgD+sergJlRtie+lZ3ERXP8mqE
 +/hnlLFi7v4M9/CSUEA==
X-Authority-Analysis: v=2.4 cv=SNlPlevH c=1 sm=1 tr=0 ts=6989757a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=EAQaFSq_8DWymkYZqBMA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31650-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[thiraviyam.mariyappan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E97CF10BE3F
X-Rspamd-Action: no action

From: P Praneesh <praneesh.p@oss.qualcomm.com>

The current implementation incorrectly reports legacy CCK and OFDM rates
in monitor mode radiotap headers. The rate field displays wrong values,
for example showing 11 Mbps when the actual rate is 1 Mbps. This occurs
because the HAL layer uses a unified enum for both CCK and OFDM rates
without distinguishing between long/short preamble variants and proper
rate mapping to hardware rate indices.

The root cause is threefold:

1. The hal_rx_legacy_rate enum conflates CCK and OFDM rates into a
   single enumeration, making it impossible to differentiate between
   802.11b CCK rates (with long/short preamble variants) and 802.11a/g
   OFDM rates.

2. The L-SIG-B parsing function maps hardware rate values to the wrong
   enum values. For CCK rates, it incorrectly combines long and short
   preamble cases (e.g., cases 2 and 5 both map to 2 Mbps), losing
   preamble information critical for proper rate identification.

3. The mac layer's rate-to-index conversion function does not properly
   handle the precedence between long preamble, short preamble, and
   OFDM rates when matching hardware rate values.

Split the hal_rx_legacy_rate enum into two separate enumerations:
hal_rx_legacy_rate for CCK rates with explicit long preamble (LP) and
short preamble (SP) variants, and hal_rx_legacy_rates_ofdm for OFDM
rates. This separation allows proper identification of rate types and
preamble modes.

Introduce a new mapping ath12k_wifi7_hal_mon_map_legacy_rate_to_hw_rate()
that converts HAL CCK rate enums to hardware rate indices defined in
ath12k_hw_rate_cck. This ensures the rate field in ppdu_info contains
the correct hardware rate index that matches the mac layer's expectations.

Update the L-SIG-B parsing to map each hardware rate value (1-7) to its
corresponding CCK rate enum with proper preamble designation:
- Cases 1-4: Long preamble (1, 2, 5.5, 11 Mbps)
- Cases 5-7: Short preamble (2, 5.5, 11 Mbps)

Update the L-SIG-A parsing to use the new OFDM-specific enum values,
maintaining the existing rate mapping for 802.11a/g OFDM rates.

Refactor the mac layer's ath12k_mac_hw_rate_to_idx() function to
implement proper matching precedence:
1. First match OFDM rates using the IEEE80211_RATE_MANDATORY_A flag
2. Then match CCK short preamble rates
3. Finally match CCK long preamble rates as fallback

Add helper macros ATH12K_MAC_RATE_A_M and ATH12K_MAC_RATE_B to improve
readability of the rate table initialization and ensure the mandatory
flag is set for OFDM rates.

This fix ensures monitor mode captures display accurate rate information
in the radiotap header, correctly distinguishing between 1 Mbps and
11 Mbps, and properly identifying preamble types for CCK rates.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.h         | 31 +++++---
 drivers/net/wireless/ath/ath12k/mac.c         | 51 +++++++------
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 76 +++++++++++++++----
 3 files changed, 108 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 43e3880f8257..bf4f7dbae866 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -268,21 +268,28 @@ enum hal_rx_reception_type {
 };
 
 enum hal_rx_legacy_rate {
-	HAL_RX_LEGACY_RATE_1_MBPS,
-	HAL_RX_LEGACY_RATE_2_MBPS,
-	HAL_RX_LEGACY_RATE_5_5_MBPS,
-	HAL_RX_LEGACY_RATE_6_MBPS,
-	HAL_RX_LEGACY_RATE_9_MBPS,
-	HAL_RX_LEGACY_RATE_11_MBPS,
-	HAL_RX_LEGACY_RATE_12_MBPS,
-	HAL_RX_LEGACY_RATE_18_MBPS,
-	HAL_RX_LEGACY_RATE_24_MBPS,
-	HAL_RX_LEGACY_RATE_36_MBPS,
-	HAL_RX_LEGACY_RATE_48_MBPS,
-	HAL_RX_LEGACY_RATE_54_MBPS,
+	HAL_RX_LEGACY_RATE_LP_1_MBPS,
+	HAL_RX_LEGACY_RATE_LP_2_MBPS,
+	HAL_RX_LEGACY_RATE_LP_5_5_MBPS,
+	HAL_RX_LEGACY_RATE_LP_11_MBPS,
+	HAL_RX_LEGACY_RATE_SP_2_MBPS,
+	HAL_RX_LEGACY_RATE_SP_5_5_MBPS,
+	HAL_RX_LEGACY_RATE_SP_11_MBPS,
 	HAL_RX_LEGACY_RATE_INVALID,
 };
 
+enum hal_rx_legacy_rates_ofdm {
+	HAL_RX_LEGACY_RATE_OFDM_48_MBPS,
+	HAL_RX_LEGACY_RATE_OFDM_24_MBPS,
+	HAL_RX_LEGACY_RATE_OFDM_12_MBPS,
+	HAL_RX_LEGACY_RATE_OFDM_6_MBPS,
+	HAL_RX_LEGACY_RATE_OFDM_54_MBPS,
+	HAL_RX_LEGACY_RATE_OFDM_36_MBPS,
+	HAL_RX_LEGACY_RATE_OFDM_18_MBPS,
+	HAL_RX_LEGACY_RATE_OFDM_9_MBPS,
+	HAL_RX_LEGACY_RATE_OFDM_INVALID,
+};
+
 enum hal_ring_type {
 	HAL_REO_DST,
 	HAL_REO_EXCEPTION,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6c534f0d59ce..035937dde5c6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -164,30 +164,31 @@ static const struct ieee80211_channel ath12k_6ghz_channels[] = {
 	CHAN6G(233, 7115, 0),
 };
 
+#define ATH12K_MAC_RATE_A_M(bps, code) \
+	{ .bitrate = (bps), .hw_value = (code),\
+	  .flags = IEEE80211_RATE_MANDATORY_A }
+
+#define ATH12K_MAC_RATE_B(bps, code, code_short) \
+	{ .bitrate = (bps), .hw_value = (code), .hw_value_short = (code_short),\
+	  .flags = IEEE80211_RATE_SHORT_PREAMBLE }
+
 static struct ieee80211_rate ath12k_legacy_rates[] = {
 	{ .bitrate = 10,
 	  .hw_value = ATH12K_HW_RATE_CCK_LP_1M },
-	{ .bitrate = 20,
-	  .hw_value = ATH12K_HW_RATE_CCK_LP_2M,
-	  .hw_value_short = ATH12K_HW_RATE_CCK_SP_2M,
-	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
-	{ .bitrate = 55,
-	  .hw_value = ATH12K_HW_RATE_CCK_LP_5_5M,
-	  .hw_value_short = ATH12K_HW_RATE_CCK_SP_5_5M,
-	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
-	{ .bitrate = 110,
-	  .hw_value = ATH12K_HW_RATE_CCK_LP_11M,
-	  .hw_value_short = ATH12K_HW_RATE_CCK_SP_11M,
-	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
-
-	{ .bitrate = 60, .hw_value = ATH12K_HW_RATE_OFDM_6M },
-	{ .bitrate = 90, .hw_value = ATH12K_HW_RATE_OFDM_9M },
-	{ .bitrate = 120, .hw_value = ATH12K_HW_RATE_OFDM_12M },
-	{ .bitrate = 180, .hw_value = ATH12K_HW_RATE_OFDM_18M },
-	{ .bitrate = 240, .hw_value = ATH12K_HW_RATE_OFDM_24M },
-	{ .bitrate = 360, .hw_value = ATH12K_HW_RATE_OFDM_36M },
-	{ .bitrate = 480, .hw_value = ATH12K_HW_RATE_OFDM_48M },
-	{ .bitrate = 540, .hw_value = ATH12K_HW_RATE_OFDM_54M },
+	ATH12K_MAC_RATE_B(20, ATH12K_HW_RATE_CCK_LP_2M,
+			  ATH12K_HW_RATE_CCK_SP_2M),
+	ATH12K_MAC_RATE_B(55, ATH12K_HW_RATE_CCK_LP_5_5M,
+			  ATH12K_HW_RATE_CCK_SP_5_5M),
+	ATH12K_MAC_RATE_B(110, ATH12K_HW_RATE_CCK_LP_11M,
+			  ATH12K_HW_RATE_CCK_SP_11M),
+	ATH12K_MAC_RATE_A_M(60, ATH12K_HW_RATE_OFDM_6M),
+	ATH12K_MAC_RATE_A_M(90, ATH12K_HW_RATE_OFDM_9M),
+	ATH12K_MAC_RATE_A_M(120, ATH12K_HW_RATE_OFDM_12M),
+	ATH12K_MAC_RATE_A_M(180, ATH12K_HW_RATE_OFDM_18M),
+	ATH12K_MAC_RATE_A_M(240, ATH12K_HW_RATE_OFDM_24M),
+	ATH12K_MAC_RATE_A_M(360, ATH12K_HW_RATE_OFDM_36M),
+	ATH12K_MAC_RATE_A_M(480, ATH12K_HW_RATE_OFDM_48M),
+	ATH12K_MAC_RATE_A_M(540, ATH12K_HW_RATE_OFDM_54M),
 };
 
 static const int
@@ -732,11 +733,17 @@ u8 ath12k_mac_hw_rate_to_idx(const struct ieee80211_supported_band *sband,
 		if (ath12k_mac_bitrate_is_cck(rate->bitrate) != cck)
 			continue;
 
-		if (rate->hw_value == hw_rate)
+		/* To handle 802.11a PPDU type */
+		if ((!cck) && (rate->hw_value == hw_rate) &&
+		    (rate->flags & IEEE80211_RATE_MANDATORY_A))
 			return i;
+		/* To handle 802.11b short PPDU type */
 		else if (rate->flags & IEEE80211_RATE_SHORT_PREAMBLE &&
 			 rate->hw_value_short == hw_rate)
 			return i;
+		/* To handle 802.11b long PPDU type */
+		else if (rate->hw_value == hw_rate)
+			return i;
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index bd741532b7dc..074df2ab6bbf 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -405,6 +405,42 @@ ath12k_wifi7_dp_mon_hal_rx_parse_user_info(const struct hal_receive_user_info *r
 	}
 }
 
+static __always_inline u8
+ath12k_wifi7_hal_mon_map_legacy_rate_to_hw_rate(u8 rate)
+{
+	u8 ath12k_rate;
+
+	/* Map hal_rx_legacy_rate to ath12k_hw_rate_cck */
+	switch (rate) {
+	case HAL_RX_LEGACY_RATE_LP_1_MBPS:
+		ath12k_rate = ATH12K_HW_RATE_CCK_LP_1M;
+		break;
+	case HAL_RX_LEGACY_RATE_LP_2_MBPS:
+		ath12k_rate = ATH12K_HW_RATE_CCK_LP_2M;
+		break;
+	case HAL_RX_LEGACY_RATE_LP_5_5_MBPS:
+		ath12k_rate = ATH12K_HW_RATE_CCK_LP_5_5M;
+		break;
+	case HAL_RX_LEGACY_RATE_LP_11_MBPS:
+		ath12k_rate = ATH12K_HW_RATE_CCK_LP_11M;
+		break;
+	case HAL_RX_LEGACY_RATE_SP_2_MBPS:
+		ath12k_rate = ATH12K_HW_RATE_CCK_SP_2M;
+		break;
+	case HAL_RX_LEGACY_RATE_SP_5_5_MBPS:
+		ath12k_rate = ATH12K_HW_RATE_CCK_SP_5_5M;
+		break;
+	case HAL_RX_LEGACY_RATE_SP_11_MBPS:
+		ath12k_rate = ATH12K_HW_RATE_CCK_SP_11M;
+		break;
+	default:
+		ath12k_rate = rate;
+		break;
+	}
+
+	return ath12k_rate;
+}
+
 static void
 ath12k_wifi7_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
 				  struct hal_rx_mon_ppdu_info *ppdu_info)
@@ -415,25 +451,32 @@ ath12k_wifi7_dp_mon_parse_l_sig_b(const struct hal_rx_lsig_b_info *lsigb,
 	rate = u32_get_bits(info0, HAL_RX_LSIG_B_INFO_INFO0_RATE);
 	switch (rate) {
 	case 1:
-		rate = HAL_RX_LEGACY_RATE_1_MBPS;
+		rate = HAL_RX_LEGACY_RATE_LP_1_MBPS;
 		break;
 	case 2:
-	case 5:
-		rate = HAL_RX_LEGACY_RATE_2_MBPS;
+		rate = HAL_RX_LEGACY_RATE_LP_2_MBPS;
 		break;
 	case 3:
-	case 6:
-		rate = HAL_RX_LEGACY_RATE_5_5_MBPS;
+		rate = HAL_RX_LEGACY_RATE_LP_5_5_MBPS;
 		break;
 	case 4:
+		rate = HAL_RX_LEGACY_RATE_LP_11_MBPS;
+		break;
+	case 5:
+		rate = HAL_RX_LEGACY_RATE_SP_2_MBPS;
+		break;
+	case 6:
+		rate = HAL_RX_LEGACY_RATE_SP_5_5_MBPS;
+		break;
 	case 7:
-		rate = HAL_RX_LEGACY_RATE_11_MBPS;
+		rate = HAL_RX_LEGACY_RATE_SP_11_MBPS;
 		break;
 	default:
 		rate = HAL_RX_LEGACY_RATE_INVALID;
+		break;
 	}
 
-	ppdu_info->rate = rate;
+	ppdu_info->rate = ath12k_wifi7_hal_mon_map_legacy_rate_to_hw_rate(rate);
 	ppdu_info->cck_flag = 1;
 }
 
@@ -447,31 +490,32 @@ ath12k_wifi7_dp_mon_parse_l_sig_a(const struct hal_rx_lsig_a_info *lsiga,
 	rate = u32_get_bits(info0, HAL_RX_LSIG_A_INFO_INFO0_RATE);
 	switch (rate) {
 	case 8:
-		rate = HAL_RX_LEGACY_RATE_48_MBPS;
+		rate = HAL_RX_LEGACY_RATE_OFDM_48_MBPS;
 		break;
 	case 9:
-		rate = HAL_RX_LEGACY_RATE_24_MBPS;
+		rate = HAL_RX_LEGACY_RATE_OFDM_24_MBPS;
 		break;
 	case 10:
-		rate = HAL_RX_LEGACY_RATE_12_MBPS;
+		rate = HAL_RX_LEGACY_RATE_OFDM_12_MBPS;
 		break;
 	case 11:
-		rate = HAL_RX_LEGACY_RATE_6_MBPS;
+		rate = HAL_RX_LEGACY_RATE_OFDM_6_MBPS;
 		break;
 	case 12:
-		rate = HAL_RX_LEGACY_RATE_54_MBPS;
+		rate = HAL_RX_LEGACY_RATE_OFDM_54_MBPS;
 		break;
 	case 13:
-		rate = HAL_RX_LEGACY_RATE_36_MBPS;
+		rate = HAL_RX_LEGACY_RATE_OFDM_36_MBPS;
 		break;
 	case 14:
-		rate = HAL_RX_LEGACY_RATE_18_MBPS;
+		rate = HAL_RX_LEGACY_RATE_OFDM_18_MBPS;
 		break;
 	case 15:
-		rate = HAL_RX_LEGACY_RATE_9_MBPS;
+		rate = HAL_RX_LEGACY_RATE_OFDM_9_MBPS;
 		break;
 	default:
-		rate = HAL_RX_LEGACY_RATE_INVALID;
+		rate = HAL_RX_LEGACY_RATE_OFDM_INVALID;
+		break;
 	}
 
 	ppdu_info->rate = rate;

base-commit: 2c1ba9c2adf0fda96eaaebd8799268a7506a8fc9
-- 
2.34.1


