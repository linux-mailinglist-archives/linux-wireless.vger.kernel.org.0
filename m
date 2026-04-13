Return-Path: <linux-wireless+bounces-34712-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMIdJLoO3WkOZQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34712-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:41:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A553EE1AC
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2F1A303DF45
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C383CBE62;
	Mon, 13 Apr 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqJ/uBHp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRPhOMMJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409313E1D0C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094792; cv=none; b=lXgm56GAHuxmd6f7xEQVtV8t490uEifI10bQs4U0b2qV90Yfs2sfzJ+ZCFvikqUs+zhqUzQjvodz9BrJnu22QtzBlrRGebnoaaBEgJ4/I7+/cfd0XHRZExAD1M0jJ0p3c7AHC/tw+VsUWEqNvLWM2C6rx5jZOvBh3SMoqgkP1gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094792; c=relaxed/simple;
	bh=bmgPwGudGghakFmxbFrKChGoiJ7GyvTTk9/Lo9IwaB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=peO/JSuDIwoJBnupJaC0mW1uQgyiwLLrncvutKaMnvfvxNtR+LX/enWF1Q0/7cOJjuQIbBNzBXo1z1iyQXRjDo8sGk4xVnaSjpxBzesSMD2H1+JSAXp718URFEJmj77htQBYAsLIiBGAohzI8vt5zGAJJ5xbwr1ZrX5OtY5m9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WqJ/uBHp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WRPhOMMJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DF5MmM3750461
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YpWNMz4aKcu
	mya9wURthP0nIkYmzkNu93gjr8BXTgq0=; b=WqJ/uBHp6Z/WbqCk9+wk5z1EwSL
	NruUeH2r8FwdxpeNU+vC/XbE7uCzK7LpYI9Zg8tJ7ZtCiaH13Yk2ogWDRnv86ZMR
	nke7VcUoV533quY8kDsYF42RC/LKJwAsSyyUehS28f2+mTTrjGvYWJmHogY94NV+
	hs34crQOGxAueTsqZ2oOg92C+ggIztpEGdNRYJ7tVi3XA72uRhx+IZTD877UMLBL
	LW3O/lbvc5HZfRgtNpiLZyQSlWJ5IOQnk40zE/K87iDzGs/EGYhkSa1ivyL8B8my
	MGisJEfxrumtoNy1/9mBNMTkv/jINB9CHLojcDXla3DL2uxvkpR+VzN5XOQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh2tu83a1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fb3bebb30so2245446a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 08:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776094789; x=1776699589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpWNMz4aKcumya9wURthP0nIkYmzkNu93gjr8BXTgq0=;
        b=WRPhOMMJZ+LM24oCk7IlNnGmmbsL/EN56fu15U9mCx9IF+uAbPRJSafVgS6lNFxAmm
         a9hrEZ0pJR1Vy5J6JdxzyK1dZygGKowe6z2QpHPy4z16XzeZqX7LCXKeumgO21ec16Q+
         02+4zYVqHR5z7QtGovUQozuydGnSuYgzEPailS/BwikORW47tE1E18akQD0yPxq37sWN
         HjMbkFfnJmFLgYCi/hjN7gEtxOPlswIUN/H3xnDYKN2skV1zcFUj8126G/MYeDRpqJRf
         Lf/x/xN5wl0OvUTZ9X/0SH7kdC+PHIJJdNXDPlUtp1ulHRrcT5tyJ1Gq/B0e+rC4oxzW
         YdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094789; x=1776699589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YpWNMz4aKcumya9wURthP0nIkYmzkNu93gjr8BXTgq0=;
        b=p4x0iQ07XBqn2qmA30TVD77HoA462QIm90HH1gNNBuYToyCKRbUbW1Kt9AdeAprO/C
         kX8yc6NMLrI3sxlE1mmbpV93+zirCqIm0J9azFTYG1PZtKMS5wj2UUMz7NdKYFHb9eFr
         sa/ID2jHhcO9jfzyZ3Is/P2Ndf5pEzCUYe/Eh2n3I56b4t9ZXqqP+sYNhxm9JamXss5d
         6Y/0WO/snIi9Em04DvoU+iZtfntAJcaWIGNVqzalq4uhEwtuzEg0kzVp1ADiKrsh0myU
         eDyC7IJX5A2p0mBWsAtJ9AcVHMjFH6IjtSteJj6v4NYKoi9RPn6jAjayrJ4wPW7nEUV1
         TfCg==
X-Gm-Message-State: AOJu0YxgYdL/s9ilJLQa4iA6fqwenY1sakgeGZtVYFp9NsiP6oIRnwMe
	70i5lyDlPcek/LfVXrdgRcA3O5EbwVcV1kH0cCRBR/l5EabwFFHDrdNbpEnc4UA0ddeAZ8pxR/5
	tdHAemFHyX/yipNJetlPo4j9OTF+q4CwGGjrOPhUK9u1jTqKSvswb+CmLpch4UOy3tQU3zq36Y1
	jbhA==
X-Gm-Gg: AeBDievblEaqxRI58RQLIgGI0BYi8Xsx64nrjYmWvnpDeXRo2DEXB1+Jc4qJYAvoWw7
	OgaxOpoTz14/nhnqYHmxmm2wwo7fawIv+llaJ8ibyKUS1Xa5sZFSu5nBf4pDJgYmAzQWy/6EAKp
	947NaTB+1SkoRznxxDuKpCrsM2kLVUPjOyTCPdrHxOrN+viMvRkjMx4I0+F4c6CZBSt7vbxiGTZ
	arTGF7djgt8ZTQ7CH1dVQwi6iHnDbLMkJCc0P4lrN8rrzNbH6pRDAYbw9I+CtiT/r5ldqur5Om/
	3MWxZFu3xzuA81ifzPMvMx7Y8Opbz6lHGkUr44kEPcUoyXYpVNMwMDL2GUoO3LSKyU8Cknwrlb4
	Z1rO+8crRVoMRmMQlaOeDhtNDsDztI+JlDVlHP9J2Sl9XrNBXnuhvXVe4wvghsGUWgh0iY1lwet
	fp/J1im9UDUaJdf8L9ytBqH/FZlw1eb1+MN0PtnE7tDk3DVar68uk=
X-Received: by 2002:a17:90b:3a4d:b0:34c:2db6:578f with SMTP id 98e67ed59e1d1-35e428412a8mr12739332a91.19.1776094788661;
        Mon, 13 Apr 2026 08:39:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3a4d:b0:34c:2db6:578f with SMTP id 98e67ed59e1d1-35e428412a8mr12739305a91.19.1776094788081;
        Mon, 13 Apr 2026 08:39:48 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e411ff4e1sm13000123a91.3.2026.04.13.08.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:39:47 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2 5/5] wifi: ath12k: add thermal cooling device support
Date: Mon, 13 Apr 2026 21:08:40 +0530
Message-Id: <20260413153840.1969931-6-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YV5CqTDWriC_LF55RiZjrkA0Fhf3oDdN
X-Proofpoint-GUID: YV5CqTDWriC_LF55RiZjrkA0Fhf3oDdN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MyBTYWx0ZWRfX5sa1bggrwRz5
 Xi9+5+PPJhqd6FmZJcBhW/dppy5iFBDEEJIQA8W2zdSNE3h213viImy7VDAgvE3Ihlyj9iXeNmF
 9NwPt0fBJTIsbmHAYowdY5sADAt/E7Gc1n23PxPiDgnF9wYt+b1b62F6P8OIFWaJSuzeQpMUFMW
 6oDaGmbwXjZBvjpRvEDCAz04q5Zq8K5vJ5mzU40WPXMLEgxEqHo6u2Kylhx49M8aGlY7Ij0kYZF
 Z1lH3kIGPfC182I/m4khYcJAqlpsEaFkHW6weT5s1qZHl3Q1+VQlnnz3Ax6B5nZB+hBKrPlThvZ
 bmnlmhu0rntYxfhWkS0iq8ABJempTsH58f4+qxG/QECOkh93I4I6PLX9S+pzFMyOabdD3uHPl7O
 Tkpkp9++MLClPGAWM8q5gWOX1v9e7E7UqzNIChl5ZJi2FyZpjFgTJiMbh4wb9SmqeBnFEXY82aP
 tfIShvSJWSlU6Ju2qYg==
X-Authority-Analysis: v=2.4 cv=RJ+D2Yi+ c=1 sm=1 tr=0 ts=69dd0e46 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=mMz0IJLIata36CLxof0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130153
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
	TAGGED_FROM(0.00)[bounces-34712-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 08A553EE1AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add thermal cooling device support to control the temperature by throttling data
transmission. Throttling is performed by suspending data TX queues according to
a configured duty-cycle off percentage. The thermal cooling device allows users
to configure the duty-cycle off percentage and operate the device with the
selected value.

User configuration updates a single duty-cycle off percentage, which is applied
uniformly by the host and treated as only one temperature level. This value
remains in effect until updated again by the user. All other thermal throttling
parameters continue to use their default firmware provided values.

Reject invalid duty-cycle off percentage values that fall outside the supported
range. Register a cooling device to allow the thermal framework to query and set
the current throttle state, report the maximum supported state, and keep the
host state in sync with successful firmware updates. A throttle state of zero
restores the default firmware thermal configuration.

Command to set the duty-cycle off percent:
echo 40 > /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device0/cur_state

Command to read duty-cycle off percent:
cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device0/cur_state

Command to read the maximum duty-cycle off percent:
cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device0/max_state

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c     |   1 +
 drivers/net/wireless/ath/ath12k/thermal.c | 107 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/thermal.h |  14 +++
 3 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2a221ee83cad..4718802cec50 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -14821,6 +14821,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	init_completion(&ar->completed_11d_scan);
 	init_completion(&ar->regd_update_completed);
 	init_completion(&ar->thermal.wmi_sync);
+	mutex_init(&ar->thermal.lock);
 
 	ar->thermal.temperature = 0;
 	ar->thermal.hwmon_dev = NULL;
diff --git a/drivers/net/wireless/ath/ath12k/thermal.c b/drivers/net/wireless/ath/ath12k/thermal.c
index 6f70c11c1098..97fc49c40ac1 100644
--- a/drivers/net/wireless/ath/ath12k/thermal.c
+++ b/drivers/net/wireless/ath/ath12k/thermal.c
@@ -76,6 +76,73 @@ void ath12k_thermal_init_configs(struct ath12k *ar)
 	ar->thermal.tt_level_configs = &tt_level_configs[cfg_idx][0];
 }
 
+static int
+ath12k_thermal_get_max_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long *state)
+{
+	*state = ATH12K_THERMAL_THROTTLE_MAX;
+
+	return 0;
+}
+
+static int
+ath12k_thermal_get_cur_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long *state)
+{
+	struct ath12k *ar = cdev->devdata;
+
+	mutex_lock(&ar->thermal.lock);
+	*state = ar->thermal.throttle_state;
+	mutex_unlock(&ar->thermal.lock);
+
+	return 0;
+}
+
+int ath12k_thermal_set_throttling(struct ath12k *ar, u32 throttle_state)
+{
+	struct ath12k_wmi_thermal_mitigation_arg param = {};
+	struct ath12k_wmi_tt_level_config_param cfg = {};
+	int ret;
+
+	param.num_levels = 1;
+	cfg.dcoffpercent = throttle_state;
+	param.levelconf = &cfg;
+
+	ret = ath12k_wmi_send_thermal_mitigation_cmd(ar, &param);
+	if (ret)
+		ath12k_warn(ar->ab, "failed to send thermal mitigation cmd: %d\n",
+			    ret);
+
+	return ret;
+}
+
+static int
+ath12k_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long throttle_state)
+{
+	struct ath12k *ar = cdev->devdata;
+
+	if (throttle_state > ATH12K_THERMAL_THROTTLE_MAX)
+		return -EINVAL;
+
+	scoped_guard(mutex, &ar->thermal.lock) {
+		if (ar->thermal.throttle_state == throttle_state)
+			return 0;
+		ar->thermal.throttle_state = throttle_state;
+	}
+
+	if (throttle_state == 0)
+		return ath12k_thermal_throttling_config_default(ar);
+
+	return ath12k_thermal_set_throttling(ar, throttle_state);
+}
+
+static const struct thermal_cooling_device_ops ath12k_thermal_ops = {
+	.get_max_state = ath12k_thermal_get_max_throttle_state,
+	.get_cur_state = ath12k_thermal_get_cur_throttle_state,
+	.set_cur_state = ath12k_thermal_set_cur_throttle_state,
+};
+
 static ssize_t ath12k_thermal_temp_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -132,6 +199,7 @@ ATTRIBUTE_GROUPS(ath12k_hwmon);
 
 static int ath12k_thermal_setup_radio(struct ath12k_base *ab, int i)
 {
+	char pdev_name[20];
 	struct ath12k *ar;
 	int ret;
 
@@ -139,6 +207,28 @@ static int ath12k_thermal_setup_radio(struct ath12k_base *ab, int i)
 	if (!ar)
 		return 0;
 
+	ar->thermal.cdev =
+		thermal_cooling_device_register("ath12k_thermal", ar,
+						&ath12k_thermal_ops);
+	if (IS_ERR(ar->thermal.cdev)) {
+		ret = PTR_ERR(ar->thermal.cdev);
+		ar->thermal.cdev = NULL;
+		ath12k_err(ar->ab, "failed to register cooling device: %d\n",
+			   ret);
+		return ret;
+	}
+
+	scnprintf(pdev_name, sizeof(pdev_name), "cooling_device%u",
+		  ar->hw_link_id);
+
+	ret = sysfs_create_link(&ar->ah->hw->wiphy->dev.kobj,
+				&ar->thermal.cdev->device.kobj, pdev_name);
+	if (ret) {
+		ath12k_err(ab, "failed to create cooling device symlink: %d\n",
+			   ret);
+		goto unregister_cdev;
+	}
+
 	ar->thermal.hwmon_dev =
 		hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
 						  "ath12k_hwmon", ar,
@@ -148,14 +238,22 @@ static int ath12k_thermal_setup_radio(struct ath12k_base *ab, int i)
 		ar->thermal.hwmon_dev = NULL;
 		ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
 			   ret);
-		return ret;
+		goto remove_sysfs;
 	}
 
 	return 0;
+
+remove_sysfs:
+	sysfs_remove_link(&ar->ah->hw->wiphy->dev.kobj, pdev_name);
+unregister_cdev:
+	thermal_cooling_device_unregister(ar->thermal.cdev);
+	ar->thermal.cdev = NULL;
+	return ret;
 }
 
 static void ath12k_thermal_cleanup_radio(struct ath12k_base *ab, int i)
 {
+	char pdev_name[20];
 	struct ath12k *ar;
 
 	ar = ab->pdevs[i].ar;
@@ -164,6 +262,13 @@ static void ath12k_thermal_cleanup_radio(struct ath12k_base *ab, int i)
 
 	hwmon_device_unregister(ar->thermal.hwmon_dev);
 	ar->thermal.hwmon_dev = NULL;
+
+	scnprintf(pdev_name, sizeof(pdev_name), "cooling_device%u",
+		  ar->hw_link_id);
+	sysfs_remove_link(&ar->ah->hw->wiphy->dev.kobj, pdev_name);
+
+	thermal_cooling_device_unregister(ar->thermal.cdev);
+	ar->thermal.cdev = NULL;
 }
 
 int ath12k_thermal_register(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/thermal.h b/drivers/net/wireless/ath/ath12k/thermal.h
index 33231bb3683c..30e7b0880e05 100644
--- a/drivers/net/wireless/ath/ath12k/thermal.h
+++ b/drivers/net/wireless/ath/ath12k/thermal.h
@@ -7,9 +7,12 @@
 #ifndef _ATH12K_THERMAL_
 #define _ATH12K_THERMAL_
 
+#include <linux/mutex.h>
+
 #define ATH12K_THERMAL_SYNC_TIMEOUT_HZ (5 * HZ)
 
 #define ATH12K_THERMAL_DEFAULT_DUTY_CYCLE 100
+#define ATH12K_THERMAL_THROTTLE_MAX 100
 
 enum ath12k_thermal_cfg_idx {
 	/* Internal Power Amplifier Device */
@@ -26,6 +29,10 @@ struct ath12k_thermal {
 	int temperature;
 	struct device *hwmon_dev;
 	const struct ath12k_wmi_tt_level_config_param *tt_level_configs;
+	struct thermal_cooling_device *cdev;
+	/* Serialize thermal operations and hwmon reads */
+	struct mutex lock;
+	u32 throttle_state;
 };
 
 #if IS_REACHABLE(CONFIG_THERMAL)
@@ -34,6 +41,7 @@ void ath12k_thermal_unregister(struct ath12k_base *ab);
 void ath12k_thermal_event_temperature(struct ath12k *ar, int temperature);
 int ath12k_thermal_throttling_config_default(struct ath12k *ar);
 void ath12k_thermal_init_configs(struct ath12k *ar);
+int ath12k_thermal_set_throttling(struct ath12k *ar, u32 throttle_state);
 #else
 static inline int ath12k_thermal_register(struct ath12k_base *ab)
 {
@@ -57,5 +65,11 @@ static inline int ath12k_thermal_throttling_config_default(struct ath12k *ar)
 static inline void ath12k_thermal_init_configs(struct ath12k *ar)
 {
 }
+
+static inline int ath12k_thermal_set_throttling(struct ath12k *ar,
+						u32 throttle_state)
+{
+	return 0;
+}
 #endif
 #endif /* _ATH12K_THERMAL_ */
-- 
2.34.1


