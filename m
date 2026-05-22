Return-Path: <linux-wireless+bounces-36792-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NlZLJQfEGqjTwYAu9opvQ
	(envelope-from <linux-wireless+bounces-36792-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 11:19:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE555B1061
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 11:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5576A300B506
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0053B7B76;
	Fri, 22 May 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GklYV3AD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YI9cwHmI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F8285CBA
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441526; cv=none; b=bIsNPlXYMyMywc+oD926XrLiNcqKz1RpaKjU1srrNH+3ontI6IHrCXbwJ/4Uqyim4NInbiUrWs6/Pw7Tx4cuBQph4npxAf+cPTQZN35UwTXRpfq+6Z4UT6ynur1MBz21rqHOwdhmYsqEGDanWORnbpP0cJsfuX7bfwIBWeSZmX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441526; c=relaxed/simple;
	bh=IhO3UT7GBxPP6FYZOK6ofkdrqot/BYndFeAkL9vaCAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5WDqb1Uf0IlrujSkHX6QzyGCsMoGeJyMPJdHageaJ2hpavDm/GKZhw7wQVyoZlQqEFznZS1xbc2tnF7teXtyI3MFF9biwDxiP/QREI36z+9ukhn+wyKE2I20gm0aLMw9PWDdrN14vt6HOk7ZM4XgnW9p7dTPJPMRPXxq/ULAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GklYV3AD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YI9cwHmI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M6ULPG1958709
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 09:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=n5rSxcitKGqRk5QxlpEsC9llgGvUZ1KFzU8
	I2bIAbY8=; b=GklYV3AD5kZpJnLYjdfOzvKhdBFv2q7EY8FZEWVqODPyysP6Rji
	0KuLJ5UtDH65u7TV79Y/OeVu00wcQ+9z6hjQ6SVPH8VZuK6IflV+kOxNjoWcFc6O
	MKhkQqwBXt8D3UVPf0HZtDXTnZdN7M1uQvxRHTr4O6f9S7Ee/PTtzIBxFLbIPY68
	oAu4SJ70cZpco2c7Qxjmo8zmg6yuoO1HSMDTPXL1TRwyzb6gKiJ3wmnxcgFgrR/8
	7lpkZ5yDdfMUT0n0P9pMSuublSU8qdi616aXXSx2FELw6etf8F1Kf+SJcWf54yEK
	18RhwxRkrsaCiDpdJZnnK52FKMB+ML5zeSg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eahxert9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 09:18:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c850ff84ddfso3229257a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779441522; x=1780046322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5rSxcitKGqRk5QxlpEsC9llgGvUZ1KFzU8I2bIAbY8=;
        b=YI9cwHmI/9YuWiBIe6S0jc3lzjgck3MKtraP8oEIVCkXRqBE8QPDI98uGh/u1deGOH
         tDiYv49xYnZ+qlY2gNrFnxAASkEbsJySY9YflyuuPFD7SomygRvaxY7SiBNgImb2saPx
         z9cJ66+zIjbRx5EmExhkhE1AwGfsoARkE4pirjEysQ+DKI++nP5zmlrMVTJGDGV0ssSx
         nYEHGovn+twuMF3WwbRsQCdojVViWtl08EQpanllorbB+VWvTwt0Rn8EoHYQqLcvXgJ7
         mw9v3FXEdw2TQOh3+ypBNruZBvZj5u3qxxEmehCzmuNRyPlo9DXoo49fApH+Q0jN3nr+
         HL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441522; x=1780046322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5rSxcitKGqRk5QxlpEsC9llgGvUZ1KFzU8I2bIAbY8=;
        b=mN1l7T0E0YXV1kC7BXn7Azo6OMH4SKdhAScs2mZhOTNvMMV8LcUqWWnmjmESO+gRPB
         O62MC+nzb5t70qQzFjjynPwosLYMoECkKFzXz9COVZfJpoAVfSdLnVnB0gNrXR/ZYoPG
         bls+kva5JkzLpTJMdH7ZIC4LLpP7/QtwXsJxwRV6sAiCICTHX7vAe774AKIghbnx9lFu
         /nMTKsgOXkHgMqThT8wLxkbFbL7aBkKmNDJIfPzaIWM9kOMz5INOMJEkwUDWJxH5kQl+
         +3f4ejV53o3TDNL5fai2cpnr/Xr5aR9qycMlMfpyTvXeW6AwIJ3g0atl8SJObAxyIHER
         RVAQ==
X-Gm-Message-State: AOJu0YyjQKp+PP7A4vHF9skR2TNFD6vIQiBG/5rSW01jmkTKMnwxr1jn
	rFWET9ev5UUSQeB4zpKP2D0XcmhsT0Ke/qfC1tOhRBBS5fxp+usphE9t8Zg6xQGhrVsGfhnQFM4
	BgAZKFJ8C9DHo8YNPJ+LsuxTBtaoQLlwjPvWHbrFKDA7UQ3c5tQXEvKR7HR3QxRlZL20zxeEVIe
	ymrw==
X-Gm-Gg: Acq92OFzjw6vgE3fdv+Iq+kefc5dGBueTuSA1UkVivWXLV4ZTjlmnj+GAEnGv8N6zab
	uAyJV+fdI8mLb/Pbhr/rbU9QGwlOnPkTBL1umW5kNxWwVpMyQIi7NCx5Qr96/y5MGOymf2CkbH8
	8Ff2MV1ZUSHy0A2PDwilIsp26g7OxCQEXj1FsK4NgVxc95TUgGYz9ZtRdn81UWifHY2PmoysM/B
	NJhg8OzbN/MJE7mNc+x0Q6iAP+4of0h/bbJWG4nKtmN17zrC4T1/MIv9zaijUTA4CdSbyta288e
	xyGKqWMqy9njd53dOFrdb+5G2of0JdXxnptRIrQnxeXSpEifWlStUORLil+2oAvG0Md9LSvZV/S
	sZ1wQBXfDiQN7afujloclgqFMoNk1y8l1f7ooI/lOfjuJpW1sHaeMUsZHbAtWQsQBdVlgsMxy8v
	JpFCDz948Hu1LQx0HrLK3txl1QHehaZOSyMZO+gE6OuHpIEfmyNOM=
X-Received: by 2002:a05:6a20:244c:b0:398:90e5:a9b9 with SMTP id adf61e73a8af0-3b328ec9e1fmr2808442637.27.1779441522233;
        Fri, 22 May 2026 02:18:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:244c:b0:398:90e5:a9b9 with SMTP id adf61e73a8af0-3b328ec9e1fmr2808401637.27.1779441521723;
        Fri, 22 May 2026 02:18:41 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85205616bdsm1017109a12.23.2026.05.22.02.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 02:18:41 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Prevent incorrect vif chanctx switch when handling multi-radio contexts
Date: Fri, 22 May 2026 14:48:28 +0530
Message-Id: <20260522091828.3199584-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5MiBTYWx0ZWRfXxLkANBpIebk9
 LpFqAENweg9XINOwvfnP4Iq8C34FJqBZor2tIO5fzW5kM2lytVyzTkgvmu4agI8ARsm3cdEeX3P
 Cw5QNXt8PKeK5Rlz4P/rjmkBmgCDn6A6n2xZgwT7hNRy6pbiqpr8/eqGZ/FpbVmJ6aTxtggWBXI
 oOfO6hn+HNbwJ6gfFqPb+6J6Ycbg2egfTeArjfAN9cpgUBPJ3l8Y3aLogEI4a2QSxU6RZRR99QY
 R6WL11wV0ZbHKmphpZfUL315NEEqCMFwOB0R8IVsuZGtbjRSwI4oz93g2DjBiKOI90z3I/mPU+w
 I3eTbVpNjS/o5jWTG6qwb2qbbazjYlIuN5KMghVRTamKx4ZRBS5nheo3SnR869iGQ1Hx5LW5c91
 oBU017+AhFkaFpcvxsTH3Rul4odIHnQ5/pI9StnvNC7JVpr7dcXRQC2VstKXY9fSc1jRfyK3vLy
 OkiJo7SVNTFZq0D+pCw==
X-Proofpoint-GUID: 43nSVIbJCAs1GxBb0OJxhvlSlnlQDULT
X-Proofpoint-ORIG-GUID: 43nSVIbJCAs1GxBb0OJxhvlSlnlQDULT
X-Authority-Analysis: v=2.4 cv=ar2CzyZV c=1 sm=1 tr=0 ts=6a101f73 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=sbVaVZ47SkDDcbqKZWIA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220092
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36792-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ABE555B1061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

When multiple links switch channel contexts around the same time, mac80211
may complete CSA for several links together and invoke
ath12k_mac_op_switch_vif_chanctx() with an array of vifs spanning more than
one underlying radio in a single-wiphy configuration.

The driver currently assumes that all entries in the vifs array belong to the
same radio and derives the radio context from the first element. On multi-radio
hardware, this can lead to incorrect vdev selection/updates and may corrupt
driver state when the number of vifs exceeds what a single radio supports.

Fix this by validating each vif's switch request and then processing vifs
grouped by their associated radio. For each vif, ensure the band does not
change across the switch and that both old/new channel contexts resolve to a
valid ath12k device. Reject attempts to move a vif between radios (not
supported for now) and return -EOPNOTSUPP to upper layers.

Then, iterate through the input vifs, collect all unprocessed entries that map
to the same radio, and invoke ath12k_mac_update_vif_chan() separately for each
radio group. This removes any reliance on mac80211 providing the array grouped
by radio or sharing old_ctx pointers across vifs.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Co-developed-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---

v2: Added Co-developed-by tag in the commit log.

 drivers/net/wireless/ath/ath12k/mac.c | 87 +++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 54081beb9a5f..5c8e25d40a98 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11476,6 +11476,9 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			continue;
 		}
 
+		if (WARN_ON(!arvif))
+			continue;
+
 		ath12k_dbg(ab, ATH12K_DBG_MAC,
 			   "mac chanctx switch vdev_id %i freq %u->%u width %d->%d\n",
 			   arvif->vdev_id,
@@ -12267,23 +12270,85 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 				 int n_vifs,
 				 enum ieee80211_chanctx_switch_mode mode)
 {
-	struct ath12k *ar;
+	struct ath12k *curr_ar, *new_ar, *group_ar;
+	struct ieee80211_vif_chanctx_switch *v;
+	int i, j, count = 0;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	ar = ath12k_get_ar_by_ctx(hw, vifs->old_ctx);
-	if (!ar)
-		return -EINVAL;
+	if (n_vifs == 0)
+		return 0;
 
-	/* Switching channels across radio is not allowed */
-	if (ar != ath12k_get_ar_by_ctx(hw, vifs->new_ctx))
-		return -EINVAL;
+	struct ath12k **ar_map __free(kfree) = kzalloc_objs(*ar_map, n_vifs);
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
-		   "mac chanctx switch n_vifs %d mode %d\n",
-		   n_vifs, mode);
-	ath12k_mac_update_vif_chan(ar, vifs, n_vifs);
+	if (!ar_map)
+		return -ENOMEM;
+
+	for (i = 0; i < n_vifs; i++) {
+		v = &vifs[i];
+
+		if (v->old_ctx->def.chan->band != v->new_ctx->def.chan->band) {
+			ath12k_generic_dbg(ATH12K_DBG_MAC,
+					   "mac chanctx switch band change not supported\n");
+			return -EOPNOTSUPP;
+		}
+
+		curr_ar = ath12k_get_ar_by_ctx(hw, v->old_ctx);
+		new_ar = ath12k_get_ar_by_ctx(hw, v->new_ctx);
+
+		if (!curr_ar || !new_ar) {
+			ath12k_generic_dbg(ATH12K_DBG_MAC,
+					   "unable to determine device for the passed channel ctx\n");
+			ath12k_generic_dbg(ATH12K_DBG_MAC,
+					   "Old freq %d MHz (device %s) to new freq %d MHz (device %s)\n",
+					   v->old_ctx->def.chan->center_freq,
+					   curr_ar ? "valid" : "invalid",
+					   v->new_ctx->def.chan->center_freq,
+					   new_ar ? "valid" : "invalid");
+			return -EINVAL;
+		}
 
+		/* Switching a vif between two radios is not allowed */
+		if (curr_ar != new_ar) {
+			ath12k_dbg(curr_ar->ab, ATH12K_DBG_MAC,
+				   "mac chanctx switch to another radio not supported\n");
+			return -EOPNOTSUPP;
+		}
+
+		ar_map[i] = curr_ar;
+	}
+
+	/* Group vifs by radio (ar) and process each group independently. */
+	bool *processed __free(kfree) = kzalloc_objs(*processed, n_vifs);
+
+	if (!processed)
+		return -ENOMEM;
+
+	struct ieee80211_vif_chanctx_switch *group_vifs __free(kfree) =
+						kzalloc_objs(*group_vifs, n_vifs);
+
+	if (!group_vifs)
+		return -ENOMEM;
+
+	for (i = 0; i < n_vifs; i++) {
+		if (processed[i])
+			continue;
+
+		group_ar = ar_map[i];
+
+		count = 0;
+		for (j = 0; j < n_vifs; j++) {
+			if (!processed[j] && ar_map[j] == group_ar) {
+				group_vifs[count++] = vifs[j];
+				processed[j] = true;
+			}
+		}
+
+		ath12k_dbg(group_ar->ab, ATH12K_DBG_MAC,
+			   "mac chanctx switch n_vifs %d mode %d\n",
+			   count, mode);
+		ath12k_mac_update_vif_chan(group_ar, group_vifs, count);
+	}
 	return 0;
 }
 EXPORT_SYMBOL(ath12k_mac_op_switch_vif_chanctx);

base-commit: 30d516006fa1f72f957c18c6171f5680dcdebfb0
-- 
2.34.1


