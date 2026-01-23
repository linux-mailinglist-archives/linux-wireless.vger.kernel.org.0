Return-Path: <linux-wireless+bounces-31106-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEmWMs0Zc2mwsAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31106-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 07:48:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377071258
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 07:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60E2D300AB38
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 06:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BA12580F3;
	Fri, 23 Jan 2026 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GtMo1rO2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="arHBMhuS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745E61EA84
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150916; cv=none; b=BMFcRG52Qv5ByYHH0MNl+s3HhGNB+bXA4wQazfYdXxJaia2ip+QEsGkJCWH8bXY+s65Bqo/ZmMTUXITD1nICFZHXM3PxbFtW04sr7FDFEmr/z/ul7DwrXPG/cCAyLIA6ZlWw95WGQwyxnqt2u4nX01nwP0+Q3WU81rlbW8mHrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150916; c=relaxed/simple;
	bh=bE3K+8KgcVeiRSbnhpQGPHPRhHdDrU77n//3hXd1ciM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzZfPPqRizyLwQRmIZOSGiJVGRDlubX1ZcMf9trziD5YBWLF3+7TGJeb3XbK6+dAeuTBX1HXoOafxxtr0g7bGWD9F5pMAfZLmBRzGo+4EVDQ4GsMu2+5UGUO/nfOVoydqOhmJ20zDwRrxwwTtrOfTmz7ecl2qmrf0rjizrpXA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GtMo1rO2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=arHBMhuS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N56NJR3656617
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 06:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=P9bWwKhaQgd
	cXnYyI1XdVxlZib/2TpvD9aGUnR2lTXE=; b=GtMo1rO2z3He2BFsULvQbsg72Ym
	bLE5W99efwX7xwbo5Umm2xMmkBooBMZyX+3HPCFb07ZW3YCdFZ2o274CyvD7kmm+
	cTI3dTS6jirnNguyDaSGrYIdDvNulmLc0HMhKV+/p3h8x5PzurJ8FGKZpw0/n5NR
	TbwkXn6sUuy5YzQy5+fCewbEipcfECQVdKPk2s4OThHAnrqt9cBBDJO3JG5c7rYO
	y3Emm55+q9JE8ZzfZ88w2n749bffQyompzNxEUTB4nXgU2M/KaQxwLWX6ciuj/dM
	jxqnCq6/9cgHKHjPBsFhRLnp5QyWu7PYtshCkE9DAmconx3ayqlA/cCGfbA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv2hw8adn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 06:48:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b715b26fc3so2518060eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 22:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769150912; x=1769755712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9bWwKhaQgdcXnYyI1XdVxlZib/2TpvD9aGUnR2lTXE=;
        b=arHBMhuSK0Uf3eWwDwGOWn4Yq7C9TbN014wb5JYtpsG11Tj8SIyWuV46rOd5FAOore
         93AVTKduYp/nQUfc9dGWgruuAwawDK9ofzMMyor29pWnzIwpfNYBQYMZq/TAT6v/8X4I
         EdQ+5trKNzycXKQ5mQHUARes70owaK4cd+BjUvhbxq4EU8XNHJt9ga77bUbzmZkIwg1t
         YkxSe4ZE3DJ/3r9FRVG3+ZZfstBRQrp3IVNVsBs/rKioWo0uRa6rLWhf+WzTdM+BIbN1
         kmDVsM//oYsweMzW63s+T4ZcRUxYR0clWNi03bOauykGAqhH6l/Q/o0FUQQU47wPy8Sq
         cGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769150912; x=1769755712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9bWwKhaQgdcXnYyI1XdVxlZib/2TpvD9aGUnR2lTXE=;
        b=onHUbd9ptqbJqb119VywNsd7AR81tmDjN35PY5J2IZizJcqFqpi6Po8cxXlWUSL/lh
         xnXzHMappeKVJPBK3d9Toxpc5bMHTMebNezMk0hMJJY4hy66CACd8jkn4f7qYUoXh3t4
         bHGUKgC9m1s+mVmNlHTD6UnJHfnRDhUzRi8lJL8VasiuaI6umIJeoNqv+eHj8iay1oDI
         AQ0VER0tjasgF+E751PCFfhjrJCjDwswIJqX4I/WO2Z5rhuERvfKgqCKHCRLjA3WAvbt
         evjMaHVKvjaFjtlt6oDpW6z6coMPvUCReSDXvlZvZSdvflm7si8X1gztQvqA/Aii/R/F
         iMVA==
X-Forwarded-Encrypted: i=1; AJvYcCXbVsF1Um5urGtqwknRyrNr+gSyeU76T/HmR3Q/9STBe0Cg4QDvcHyttxgeMhDu6mRn9zBUSKzOuV1UYPh2JA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcLATAnZOpveVPdKJbYD27yyT2nS6Ymo3QIgt14CRMUTB22t+
	94YFu5fYtbee3LLdbH9LXU1XXeJKAC0hza+DpM1pq/73ZzpJn44BDc+oHekDEXIczhV7kF2PdOb
	Wko7cKx3OvZT4yQAsRm9Abiqq0RQDLOAfbb4GOe3G5OUH2Kp5uJb16mzpshwjI9abUqLYng==
X-Gm-Gg: AZuq6aJv7jDcnDP4jgWM9N932LL9sgjjI/Y52s3MdPV3QFIex2OgoA4PoeN45jvuCQn
	JdWqU+qNhRJR0g+XaE+ZjrHt/kH+c2O3OgZM0PuZxvLdqoysRbxEbaaMG/LL4I2A1eAs7/5yR5V
	vDK3FZAtEbQC3retLsLb451xY8DWycogyRcK0NlnJfz8vj2/rvTWAxouhwJjATnb+DC35DpWpVJ
	PFBWzAweMghvLM9H+oIXVKw4qlHXtluSC3M+6Rp3BknLiz77AlzovprBbL4c4cpiI5vCjbeHDV1
	v7QfNZQZWvxYFuPiwhwdBcW/s2Bv0XJaNU8sbg7FC7wwb7raRdqoFGWXd2C8j8DVY23edn+cMQk
	0TmbkZkFI0g1SXEC/T/XIkC7juPe6Aozgi3Z9l7T0BaG38jLCI3vdSXOno4VT99Ma8g==
X-Received: by 2002:a05:7022:f94:b0:123:2d9d:a90d with SMTP id a92af1059eb24-1247dbbbd43mr896856c88.17.1769150912152;
        Thu, 22 Jan 2026 22:48:32 -0800 (PST)
X-Received: by 2002:a05:7022:f94:b0:123:2d9d:a90d with SMTP id a92af1059eb24-1247dbbbd43mr896842c88.17.1769150911523;
        Thu, 22 Jan 2026 22:48:31 -0800 (PST)
Received: from san-w175-na3-01.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90d13esm2819484c88.2.2026.01.22.22.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 22:48:31 -0800 (PST)
From: Wei Zhang <wei.zhang@oss.qualcomm.com>
To: jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wei.zhang@oss.qualcomm.com
Subject: [PATCH ath-next 2/2] wifi: ath12k: support OBSS PD configuration for AP mode
Date: Thu, 22 Jan 2026 22:48:17 -0800
Message-ID: <20260123064817.364047-3-wei.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123064817.364047-1-wei.zhang@oss.qualcomm.com>
References: <20260123064817.364047-1-wei.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rjhhM1Z5MJcyI2HzDnoZ3Uo5bgrf2z_s
X-Proofpoint-ORIG-GUID: rjhhM1Z5MJcyI2HzDnoZ3Uo5bgrf2z_s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1MCBTYWx0ZWRfXyB04telDuobh
 NPzDHitnegRXFAEPagsbFqjeGpAZHmssX9+gJLI1upIb65ZMcPM/6NzOcdQTKTMBCfK+CQ8IcYt
 PdFttzVnrnR8REkCa8yJ/4sWWLIIEkrTQmLjpQTNaJFRMI5XkQP10IOvpBzk6BUpmsoXNqMn6ue
 bl9kHi3/K291Ff4lbzcy5xJLUXKGk/YKdnV34WHtX7dXiBg1Y4Uqlm6+J2Bi0IBHdhhSnfjYaIY
 Gwu+0WuMzxiDb+xZZrCbTrExP7Nzcvys4GVV5o+Y1FUVbt4Ix+22/la4R9Cg9RLOLjNSHgpiBjf
 g5nQu8GzSQ+MudGT19o4A3OBiiorEz5xnNaO2XH3kOkPmi6aufto60Kc5AR8ix3nNUpIuJK2u2w
 h7kiRMzNx46c+inbVYLWUP4rqYDFHMAxHmF7pBCYsW/M6ofB8W95h/3fJ2IjY6YGgjQc2pX8Bnh
 PY1ViYunaWseiGE57fg==
X-Authority-Analysis: v=2.4 cv=A4Rh/qWG c=1 sm=1 tr=0 ts=697319c1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_f8bPs4Hj4x37lDDkkEA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230050
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31106-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.zhang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5377071258
X-Rspamd-Action: no action

Configure HE OBSS PD for spatial reuse in ath12k based on mac80211
HE SPR parameters in AP mode. This adds a pdev-level helper that
programs SRG/non-SRG OBSS PD thresholds, per-AC enablement, SR prohibit
control, and SRG/non-SRG BSS color and partial BSSID bitmaps via WMI.

Replace the previous vdev-level OBSS SPR command usage with the new
pdev-level configuration path, allowing firmware to apply HE spatial
reuse behavior according to the HE SPR/OBSS PD settings provided by
mac80211.

Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 170 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h |   3 +
 drivers/net/wireless/ath/ath12k/wmi.h |   1 +
 3 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index cdb72439dcf4..8b66a6b58abd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4505,6 +4505,166 @@ static void ath12k_wmi_vdev_params_up(struct ath12k *ar,
 			    arvif->vdev_id, ret);
 }
 
+static int ath12k_mac_config_obss_pd(struct ath12k_link_vif *arvif,
+				     const struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	struct ath12k_wmi_obss_pd_arg obss_pd_arg = {};
+	u32 srg_bitmap[2], non_srg_bitmap[2];
+	struct ath12k *ar = arvif->ar;
+	u32 param_id, pdev_id;
+	u32 param_val;
+	int ret;
+
+	if (ar->ab->hw_params->single_pdev_only)
+		pdev_id = ath12k_mac_get_target_pdev_id_from_vif(arvif);
+	else
+		pdev_id = ar->pdev->pdev_id;
+
+	/* Set and enable SRG/non-SRG OBSS PD threshold */
+	param_id = WMI_PDEV_PARAM_SET_CMD_OBSS_PD_THRESHOLD;
+	if (ar->monitor_started || !he_obss_pd->enable) {
+		ret = ath12k_wmi_pdev_set_param(ar, param_id, 0, pdev_id);
+		if (ret)
+			ath12k_warn(ar->ab,
+				    "failed to set OBSS PD threshold for pdev %u: %d\n",
+				    pdev_id, ret);
+		return ret;
+	}
+
+	/*
+	 * This service flag indicates firmware support for SRG/SRP-based
+	 * spatial reuse. It also specifies whether OBSS PD threshold values
+	 * should be interpreted as dB (offset) or dBm (absolute) units.
+	 */
+	obss_pd_arg.srp_support = test_bit(WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT,
+					   ar->ab->wmi_ab.svc_map);
+
+	if (!(he_obss_pd->sr_ctrl &
+	      IEEE80211_HE_SPR_NON_SRG_OBSS_PD_SR_DISALLOWED)) {
+		if (he_obss_pd->sr_ctrl & IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT)
+			obss_pd_arg.non_srg_th = ATH12K_OBSS_PD_MAX_THRESHOLD +
+						 he_obss_pd->non_srg_max_offset;
+		else
+			obss_pd_arg.non_srg_th = ATH12K_OBSS_PD_NON_SRG_MAX_THRESHOLD;
+
+		if (!obss_pd_arg.srp_support)
+			obss_pd_arg.non_srg_th -= ATH12K_DEFAULT_NOISE_FLOOR;
+
+		obss_pd_arg.non_srg_enabled = true;
+	}
+
+	if (he_obss_pd->sr_ctrl & IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT) {
+		obss_pd_arg.srg_th = ATH12K_OBSS_PD_MAX_THRESHOLD +
+				     he_obss_pd->max_offset;
+		obss_pd_arg.srg_enabled = true;
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "pdev %u OBSS PD sr_ctrl 0x%x srg_th %d dBm non_srg_th %d dBm\n",
+		   pdev_id, he_obss_pd->sr_ctrl,
+		   obss_pd_arg.srg_th, obss_pd_arg.non_srg_th);
+
+	param_val = ath12k_wmi_build_obss_pd(&obss_pd_arg);
+	ret = ath12k_wmi_pdev_set_param(ar, param_id, param_val, pdev_id);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to set OBSS PD threshold for pdev %u: %d\n",
+			    pdev_id, ret);
+		return ret;
+	}
+
+	/* Enable OBSS PD for all access category */
+	param_id  = WMI_PDEV_PARAM_SET_CMD_OBSS_PD_PER_AC;
+	param_val = 0xf;
+	ret = ath12k_wmi_pdev_set_param(ar, param_id, param_val, pdev_id);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to set OBSS PD per ac for pdev %u: %d\n",
+			    pdev_id, ret);
+		return ret;
+	}
+
+	/* Set SR prohibit */
+	param_id  = WMI_PDEV_PARAM_ENABLE_SR_PROHIBIT;
+	param_val = !!(he_obss_pd->sr_ctrl &
+		       IEEE80211_HE_SPR_HESIGA_SR_VAL15_ALLOWED);
+	ret = ath12k_wmi_pdev_set_param(ar, param_id, param_val, pdev_id);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to set SR prohibit for pdev %u: %d\n",
+			    pdev_id, ret);
+		return ret;
+	}
+
+	if (!obss_pd_arg.srp_support)
+		return 0;
+
+	memcpy(srg_bitmap, he_obss_pd->bss_color_bitmap, sizeof(srg_bitmap));
+	/* Set SRG BSS color bitmap */
+	ret = ath12k_wmi_pdev_set_srg_bss_color_bitmap(ar, pdev_id, srg_bitmap);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to set SRG bss color bitmap for pdev %u: %d\n",
+			    pdev_id, ret);
+		return ret;
+	}
+
+	/* Enable BSS colors for SRG */
+	ret = ath12k_wmi_pdev_srg_obss_color_enable_bitmap(ar, pdev_id, srg_bitmap);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to enable SRG bss color bitmap pdev %u: %d\n",
+			    pdev_id, ret);
+		return ret;
+	}
+
+	memcpy(srg_bitmap, he_obss_pd->partial_bssid_bitmap, sizeof(srg_bitmap));
+	/* Set SRG partial bssid bitmap */
+	ret = ath12k_wmi_pdev_set_srg_partial_bssid_bitmap(ar, pdev_id, srg_bitmap);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to set SRG partial bssid bitmap for pdev %u: %d\n",
+			    pdev_id, ret);
+		return ret;
+	}
+
+	/* Enable partial bssid mask for SRG */
+	ret = ath12k_wmi_pdev_srg_obss_bssid_enable_bitmap(ar, pdev_id, srg_bitmap);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to enable SRG bssid bitmap pdev %u: %d\n",
+			    pdev_id, ret);
+		return ret;
+	}
+
+	/*
+	 * No explicit non-SRG bitmap from mac80211; enable all colors/bssids
+	 * as non-SRG candidates. Actual SRG members are filtered by SRG bitmaps.
+	 */
+	memset(non_srg_bitmap, 0xff, sizeof(non_srg_bitmap));
+
+	/* Enable BSS colors for non-SRG */
+	ret = ath12k_wmi_pdev_non_srg_obss_color_enable_bitmap(ar, pdev_id,
+							       non_srg_bitmap);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to enable non SRG color bitmap pdev %u: %d\n",
+			    pdev_id, ret);
+		return ret;
+	}
+
+	/* Enable partial bssid mask for non-SRG */
+	ret = ath12k_wmi_pdev_non_srg_obss_bssid_enable_bitmap(ar, pdev_id,
+							       non_srg_bitmap);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to enable non SRG bssid bitmap pdev %u: %d\n",
+			    pdev_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 					struct ath12k_link_vif *arvif,
 					struct ieee80211_bss_conf *info,
@@ -4796,9 +4956,13 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 			ath12k_wmi_send_twt_disable_cmd(ar, ar->pdev->pdev_id);
 	}
 
-	if (changed & BSS_CHANGED_HE_OBSS_PD)
-		ath12k_wmi_send_obss_spr_cmd(ar, arvif->vdev_id,
-					     &info->he_obss_pd);
+	if (changed & BSS_CHANGED_HE_OBSS_PD) {
+		if (vif->type == NL80211_IFTYPE_AP)
+			ath12k_mac_config_obss_pd(arvif, &info->he_obss_pd);
+		else
+			ath12k_wmi_send_obss_spr_cmd(ar, arvif->vdev_id,
+						     &info->he_obss_pd);
+	}
 
 	if (changed & BSS_CHANGED_HE_BSS_COLOR) {
 		if (vif->type == NL80211_IFTYPE_AP) {
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 422bd3b095cd..7b50c5976384 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -138,6 +138,9 @@ struct ath12k_reg_tpc_power_info {
 	struct ath12k_chan_power_info chan_power_info[ATH12K_NUM_PWR_LEVELS];
 };
 
+#define ATH12K_OBSS_PD_MAX_THRESHOLD		-82
+#define ATH12K_OBSS_PD_NON_SRG_MAX_THRESHOLD	-62
+
 extern const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default;
 
 #define ATH12K_SCAN_11D_INTERVAL		600000
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 2a81819ef543..0bf0a7941cd3 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2259,6 +2259,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
 	WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT = 244,
+	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
 	WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT = 253,
 
 	WMI_MAX_EXT_SERVICE = 256,
-- 
2.34.1


