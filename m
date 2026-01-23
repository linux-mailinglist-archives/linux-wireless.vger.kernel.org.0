Return-Path: <linux-wireless+bounces-31105-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAC5MsUZc2mwsAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31105-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 07:48:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503D71251
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 07:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AD713009517
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 06:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1350D1D5AD4;
	Fri, 23 Jan 2026 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j0tSiiUx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rze6c2MR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1271EA84
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150912; cv=none; b=EADhvnIDlzrQTjNxd8RrqiItG94loilLsidUF798xEtEhTaJFaTQHl3NkZ1cygXoBASxQodcyjofx99LdXDd7OZ5NT1QC3+Yg82G2axvFh7QTYGRK0VBhcd9tjFOX2dMPtqO1YcS8UZc8zXmkPaB+T9xrVPVnIL1ONsrPGjzBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150912; c=relaxed/simple;
	bh=IBRAQ+MlJJq6dlvlICYDoJkibuobTr2cgI18jj8duRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gol0tecwH0L04aENkZ0TX4y4bRVnaPSRwfcXxvd/rlCAPKpMhEHLUKtYads8s/CkgwYMFjdBkw0/vI+o79NVl8THYqOOht/T8gvjwKpbFfJh+a+85BFfSei7xnP7BVoRn0xDlTako7zIWWU6BWSjIVQSJeyD/9srnsKv7NYQktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j0tSiiUx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rze6c2MR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MMW5PA2915972
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 06:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=E74W34W/eG+
	FYxMKIL2lw+1iyQKgUkv2lDVmu9qYHfc=; b=j0tSiiUx5ZzsxJl5CyZpbxl6rdK
	pV74N4TvHJPYs17Jtmch5uK/fnLtN+9iIoDv/XmndWuPgrGtF9QsBYFlCDr7o+Jt
	cBeAW+J2uXVqrk9JgaS+4H7v5Sc7iKOS6DKiin2Rl+KIlE9frr2itCnttAc9JDyk
	ptSa3kae6SW9UEdSoFmYCu6vYhWLpeBwgQtha5o4z6KqGUw0bYNy6wdO2sHLVA74
	3pEB3qGhYWC9+mqioAkuAPJ2zbcl1E07ZWxqM0lhSHg7zLwHpueW8KhowfWZ9Jl1
	mH+7e+sL+JAwVnjFsNud6CIsCmohJ0cagaoixiw25Hk26VzfpzooJl068hA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buvs1sfq5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 06:48:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b70d8095daso1693968eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 22:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769150908; x=1769755708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E74W34W/eG+FYxMKIL2lw+1iyQKgUkv2lDVmu9qYHfc=;
        b=Rze6c2MRnMIi2hoQP1kIC6AFmRAdo5q/xDrswrpVpCNvVy3UHQ+Byti5Z1jqFdQBak
         YXRdlkWp1z+z6F9o58gXbT97bNmXEZEfVME4GM4eTEDFjMzGBIX1Q6L0K6ieANvzMZAo
         Rc9e6/MH1bubOgWA6UBTMfVvr5WTz4t+cCx6CIpUULg9erbq+IbSIlUGIYB5DUUQM3B8
         jjpvunPDtVPGj++vibRElLZNiFAhWdFlC2UnqsFGZavevpIRQQhiemwk8qvDzTuI5HW8
         0zdceWFBU4SYCFUsupFD4G4WZdX/L+wDhF3Bc4zOH6VR6lhtHGVnz/XS6CuBIXs2YQQf
         oixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769150908; x=1769755708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E74W34W/eG+FYxMKIL2lw+1iyQKgUkv2lDVmu9qYHfc=;
        b=Hky1EpicV/fZ3VZuB850BpPZaa2542wBeBMMzEIfPLsLwoSRxVwJ4GSANMltkQmNQ4
         lVqKw1EfmGsqRRzuGHEtXvf6HdUmyug1oyurOuBZroQ2Cz+LBA+a8xVL8CFSkU0R6SOV
         JtMsnx3sdc8wkj2vlrQlRvqGcq4n8tBXDeVDThN6WNa4lOGs9XOutRa4nreySwRXRH1L
         innssEb8aApJKxCVaWcm0tOFGkWgZsgzDfefq9rreJ+1MMtMxILAbhaRrx8RrUf37qa7
         xqlhMH8hHWTnxvZRtGQ2v1xzViFxyU8Cg6yJzlDRN4tICoKD1U7flMZuBwqDQ9KvOxCZ
         W74g==
X-Forwarded-Encrypted: i=1; AJvYcCUHyLf/gbODWK+a07vcAK/3fk0U7/p8SRxyRwFIX/geKotoIU+ZOp1xU3+cL6JN4ekk754k0U8q/Vpxl98B7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtBm234Xqxx+sEEoWTYyrRvlTzQzdeQYzJLYP0b5suw6pUZWeu
	Jfl9nYgHGr0TNeLHucO6uV5MVrUfLarlfUcUKStP+W2epNd+At8cGhKxLmOaQuDlNn3Uk3uZblY
	ELWwT06P/zN8LGBpHbEVIbfSI0SA03TfXNDZq47zhU372BL3DwIPI/i97MTEMCtxQ/us0TNVXLE
	/i7Q==
X-Gm-Gg: AZuq6aKiVYbAIaNbfWxVMKc+SHMr+9Cif7sZuW3FFBQZJGmsPGe3PMLNWxHM08g9am+
	MU+bqa6E34V3wunaZrV92xkBVI287UryxvdZtSyLUfJCpuasFMCF8X0GvGTE0jZYfGQwqUpo4hW
	5jWgmtxJcn2nzhh8fbfPaVppy1gNdjDZie/qDznSRupHdSnFdJHwYOcmEo/83ydhW/TewxTlmu0
	+bp7CldXCW7LZBtbKoY1jiHfzylkYy4GHIvEe1djnSzLlgzT1ONQjCBbS+jVOd019CaxM9iTs/p
	5hBWMIgUlLVuXvXoG2JyKiLrF59CEgF4C6NO3wqXcSA8mCOByanyzas338BknxW5LJ7ucIVNdT0
	0zNjkjksCLY2PMgo+Fr40CXIiF6CpqOYwS0bl88pkEUkxZfvuUZjYyZ9tOCiGX1SOjQ==
X-Received: by 2002:a05:7300:570a:b0:2ae:51fa:b7ec with SMTP id 5a478bee46e88-2b739bce0bdmr1023591eec.25.1769150907730;
        Thu, 22 Jan 2026 22:48:27 -0800 (PST)
X-Received: by 2002:a05:7300:570a:b0:2ae:51fa:b7ec with SMTP id 5a478bee46e88-2b739bce0bdmr1023568eec.25.1769150907050;
        Thu, 22 Jan 2026 22:48:27 -0800 (PST)
Received: from san-w175-na3-01.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90d13esm2819484c88.2.2026.01.22.22.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 22:48:26 -0800 (PST)
From: Wei Zhang <wei.zhang@oss.qualcomm.com>
To: jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wei.zhang@oss.qualcomm.com
Subject: [PATCH ath-next 1/2] wifi: ath12k: add WMI support for spatial reuse parameter configuration
Date: Thu, 22 Jan 2026 22:48:16 -0800
Message-ID: <20260123064817.364047-2-wei.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: 7gZALPC2wpg42hoQbJa0Q7U69yKxW7hL
X-Proofpoint-ORIG-GUID: 7gZALPC2wpg42hoQbJa0Q7U69yKxW7hL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1MCBTYWx0ZWRfX/yyVcjK9401/
 SlND81eaqjP8AzT+96LIqA0zDDFnDai4xqUhfEswERtJrCkj29CH8+pFJ32xHsrdTzk47j69ZI/
 5pOBpJItCK0UG/4sLxWZ5IqxlKe/Ppa5CAjBP/c8jeXJWsWONxNInjd2qGi70PqxNvFftjJiePz
 6f03H+VsU0UjUXzPo5GrXZzVNs+wDqf2O0u2nNE6usavPpkfaYa5A6wZn90CN51apzODZK44swQ
 zjeSiXHiHEKQKf0l0OE8JfGdJsIjTz67HuQ7Jry+ajELJbGXKi9VzJvi1+mMFOk8YeIl5cyjCOd
 UZIFhAMzPo5UuDzPYuQGv/OGjUKwp4E91cDOGHL7XHAUbjUwDSRbOwfQ+Pd5OY4niGv8+LTvIdg
 GMAxdhwf7ldPEyAQfAoY6Q+62AtQ79ytCQCqKhedYJy8Pu4Ibi0O4acvXvVyvSi/uL+ndQ61gYg
 XnXDYKPI8vxPahzLNTQ==
X-Authority-Analysis: v=2.4 cv=faSgCkQF c=1 sm=1 tr=0 ts=697319bd cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=OEGGlgRjERhNdV2A9hcA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
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
	TAGGED_FROM(0.00)[bounces-31105-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 1503D71251
X-Rspamd-Action: no action

Add WMI support for configuring SRG and non-SRG OBSS PD bitmaps at
the pdev level. The new commands allow the host to set BSS color bitmaps,
partial BSSID bitmaps, and the corresponding enable masks used for
SRG/non-SRG OBSS PD processing.

Introduce new WMI command IDs, TLV tags, a service flag
(WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT), and a bitmap payload
structure required by these commands. These additions are needed to
support HE Spatial Reuse and firmware-managed OBSS PD behavior.

The APIs introduced in this patch will be utilized in an upcoming patch.

Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 142 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  46 +++++++++
 2 files changed, 188 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index cce3d699112d..7617fc3a2479 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -126,6 +126,14 @@ struct wmi_tlv_mgmt_rx_parse {
 	bool frame_buf_done;
 };
 
+struct wmi_pdev_set_obss_bitmap_arg {
+	u32 tlv_tag;
+	u32 pdev_id;
+	u32 cmd_id;
+	const u32 *bitmap;
+	const char *label;
+};
+
 static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 	[WMI_TAG_ARRAY_BYTE] = { .min_len = 0 },
 	[WMI_TAG_ARRAY_UINT32] = { .min_len = 0 },
@@ -3560,6 +3568,140 @@ ath12k_wmi_send_obss_spr_cmd(struct ath12k *ar, u32 vdev_id,
 	return ret;
 }
 
+u32 ath12k_wmi_build_obss_pd(const struct ath12k_wmi_obss_pd_arg *arg)
+{
+	u32 param_val = 0;
+
+	param_val |= u32_encode_bits((u8)arg->srg_th, GENMASK(15, 8));
+	param_val |= u32_encode_bits((u8)arg->non_srg_th, GENMASK(7, 0));
+
+	if (arg->srp_support)
+		param_val |= ATH12K_OBSS_PD_THRESHOLD_IN_DBM;
+
+	if (arg->srg_enabled && arg->srp_support)
+		param_val |= ATH12K_OBSS_PD_SRG_EN;
+
+	if (arg->non_srg_enabled)
+		param_val |= ATH12K_OBSS_PD_NON_SRG_EN;
+
+	return param_val;
+}
+
+static int ath12k_wmi_pdev_set_obss_bitmap(struct ath12k *ar,
+					   const struct wmi_pdev_set_obss_bitmap_arg *arg)
+{
+	struct wmi_pdev_obss_pd_bitmap_cmd *cmd;
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	const int len = sizeof(*cmd);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_obss_pd_bitmap_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(arg->tlv_tag, len);
+	cmd->pdev_id = cpu_to_le32(arg->pdev_id);
+	memcpy(cmd->bitmap, arg->bitmap, sizeof(cmd->bitmap));
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "wmi set pdev %u %s %08x %08x\n",
+		   arg->pdev_id, arg->label, arg->bitmap[0], arg->bitmap[1]);
+
+	ret = ath12k_wmi_cmd_send(wmi, skb, arg->cmd_id);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send %s: %d\n", arg->label, ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
+int ath12k_wmi_pdev_set_srg_bss_color_bitmap(struct ath12k *ar,
+					     u32 pdev_id, const u32 *bitmap)
+{
+	struct wmi_pdev_set_obss_bitmap_arg arg = {
+		.tlv_tag = WMI_TAG_PDEV_SRG_BSS_COLOR_BITMAP_CMD,
+		.pdev_id = pdev_id,
+		.cmd_id = WMI_PDEV_SET_SRG_BSS_COLOR_BITMAP_CMDID,
+		.bitmap = bitmap,
+		.label = "SRG bss color bitmap",
+	};
+
+	return ath12k_wmi_pdev_set_obss_bitmap(ar, &arg);
+}
+
+int ath12k_wmi_pdev_set_srg_partial_bssid_bitmap(struct ath12k *ar,
+						 u32 pdev_id, const u32 *bitmap)
+{
+	struct wmi_pdev_set_obss_bitmap_arg arg = {
+		.tlv_tag = WMI_TAG_PDEV_SRG_PARTIAL_BSSID_BITMAP_CMD,
+		.pdev_id = pdev_id,
+		.cmd_id = WMI_PDEV_SET_SRG_PARTIAL_BSSID_BITMAP_CMDID,
+		.bitmap = bitmap,
+		.label = "SRG partial bssid bitmap",
+	};
+
+	return ath12k_wmi_pdev_set_obss_bitmap(ar, &arg);
+}
+
+int ath12k_wmi_pdev_srg_obss_color_enable_bitmap(struct ath12k *ar,
+						 u32 pdev_id, const u32 *bitmap)
+{
+	struct wmi_pdev_set_obss_bitmap_arg arg = {
+		.tlv_tag = WMI_TAG_PDEV_SRG_OBSS_COLOR_ENABLE_BITMAP_CMD,
+		.pdev_id = pdev_id,
+		.cmd_id = WMI_PDEV_SET_SRG_OBSS_COLOR_ENABLE_BITMAP_CMDID,
+		.bitmap = bitmap,
+		.label = "SRG obss color enable bitmap",
+	};
+
+	return ath12k_wmi_pdev_set_obss_bitmap(ar, &arg);
+}
+
+int ath12k_wmi_pdev_srg_obss_bssid_enable_bitmap(struct ath12k *ar,
+						 u32 pdev_id, const u32 *bitmap)
+{
+	struct wmi_pdev_set_obss_bitmap_arg arg = {
+		.tlv_tag = WMI_TAG_PDEV_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
+		.pdev_id = pdev_id,
+		.cmd_id = WMI_PDEV_SET_SRG_OBSS_BSSID_ENABLE_BITMAP_CMDID,
+		.bitmap = bitmap,
+		.label = "SRG obss bssid enable bitmap",
+	};
+
+	return ath12k_wmi_pdev_set_obss_bitmap(ar, &arg);
+}
+
+int ath12k_wmi_pdev_non_srg_obss_color_enable_bitmap(struct ath12k *ar,
+						     u32 pdev_id, const u32 *bitmap)
+{
+	struct wmi_pdev_set_obss_bitmap_arg arg = {
+		.tlv_tag = WMI_TAG_PDEV_NON_SRG_OBSS_COLOR_ENABLE_BITMAP_CMD,
+		.pdev_id = pdev_id,
+		.cmd_id = WMI_PDEV_SET_NON_SRG_OBSS_COLOR_ENABLE_BITMAP_CMDID,
+		.bitmap = bitmap,
+		.label = "non SRG obss color enable bitmap",
+	};
+
+	return ath12k_wmi_pdev_set_obss_bitmap(ar, &arg);
+}
+
+int ath12k_wmi_pdev_non_srg_obss_bssid_enable_bitmap(struct ath12k *ar,
+						     u32 pdev_id, const u32 *bitmap)
+{
+	struct wmi_pdev_set_obss_bitmap_arg arg = {
+		.tlv_tag = WMI_TAG_PDEV_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
+		.pdev_id = pdev_id,
+		.cmd_id = WMI_PDEV_SET_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMDID,
+		.bitmap = bitmap,
+		.label = "non SRG obss bssid enable bitmap",
+	};
+
+	return ath12k_wmi_pdev_set_obss_bitmap(ar, &arg);
+}
+
 int ath12k_wmi_obss_color_cfg_cmd(struct ath12k *ar, u32 vdev_id,
 				  u8 bss_color, u32 period,
 				  bool enable)
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index fdc203fdba0a..2a81819ef543 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -374,6 +374,12 @@ enum wmi_tlv_cmd_id {
 	WMI_PDEV_DMA_RING_CFG_REQ_CMDID,
 	WMI_PDEV_HE_TB_ACTION_FRM_CMDID,
 	WMI_PDEV_PKTLOG_FILTER_CMDID,
+	WMI_PDEV_SET_SRG_BSS_COLOR_BITMAP_CMDID = 0x403b,
+	WMI_PDEV_SET_SRG_PARTIAL_BSSID_BITMAP_CMDID,
+	WMI_PDEV_SET_SRG_OBSS_COLOR_ENABLE_BITMAP_CMDID,
+	WMI_PDEV_SET_SRG_OBSS_BSSID_ENABLE_BITMAP_CMDID,
+	WMI_PDEV_SET_NON_SRG_OBSS_COLOR_ENABLE_BITMAP_CMDID,
+	WMI_PDEV_SET_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMDID,
 	WMI_PDEV_SET_BIOS_SAR_TABLE_CMDID = 0x4044,
 	WMI_PDEV_SET_BIOS_GEO_TABLE_CMDID = 0x4045,
 	WMI_PDEV_SET_BIOS_INTERFACE_CMDID = 0x404A,
@@ -1076,6 +1082,9 @@ enum wmi_tlv_pdev_param {
 	WMI_PDEV_PARAM_RADIO_CHAN_STATS_ENABLE,
 	WMI_PDEV_PARAM_RADIO_DIAGNOSIS_ENABLE,
 	WMI_PDEV_PARAM_MESH_MCAST_ENABLE,
+	WMI_PDEV_PARAM_SET_CMD_OBSS_PD_THRESHOLD = 0xbc,
+	WMI_PDEV_PARAM_SET_CMD_OBSS_PD_PER_AC = 0xbe,
+	WMI_PDEV_PARAM_ENABLE_SR_PROHIBIT = 0xc6,
 };
 
 enum wmi_tlv_vdev_param {
@@ -1987,6 +1996,12 @@ enum wmi_tlv_tag {
 	WMI_TAG_SERVICE_READY_EXT2_EVENT = 0x334,
 	WMI_TAG_FILS_DISCOVERY_TMPL_CMD = 0x344,
 	WMI_TAG_MAC_PHY_CAPABILITIES_EXT = 0x36F,
+	WMI_TAG_PDEV_SRG_BSS_COLOR_BITMAP_CMD = 0x37b,
+	WMI_TAG_PDEV_SRG_PARTIAL_BSSID_BITMAP_CMD,
+	WMI_TAG_PDEV_SRG_OBSS_COLOR_ENABLE_BITMAP_CMD = 0x381,
+	WMI_TAG_PDEV_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
+	WMI_TAG_PDEV_NON_SRG_OBSS_COLOR_ENABLE_BITMAP_CMD,
+	WMI_TAG_PDEV_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
 	WMI_TAG_TPC_STATS_GET_CMD = 0x38B,
@@ -4925,6 +4940,12 @@ struct wmi_obss_spatial_reuse_params_cmd {
 	__le32 vdev_id;
 } __packed;
 
+struct wmi_pdev_obss_pd_bitmap_cmd {
+	__le32 tlv_header;
+	__le32 pdev_id;
+	__le32 bitmap[2];
+} __packed;
+
 #define ATH12K_BSS_COLOR_COLLISION_SCAN_PERIOD_MS		200
 #define ATH12K_OBSS_COLOR_COLLISION_DETECTION_DISABLE		0
 #define ATH12K_OBSS_COLOR_COLLISION_DETECTION			1
@@ -6329,6 +6350,18 @@ struct ath12k_wmi_rssi_dbm_conv_info_arg {
 /* each WMI cmd can hold 58 channel entries at most */
 #define ATH12K_WMI_MAX_NUM_CHAN_PER_CMD	58
 
+#define ATH12K_OBSS_PD_THRESHOLD_IN_DBM		BIT(29)
+#define ATH12K_OBSS_PD_SRG_EN			BIT(30)
+#define ATH12K_OBSS_PD_NON_SRG_EN		BIT(31)
+
+struct ath12k_wmi_obss_pd_arg {
+	bool srp_support;
+	bool srg_enabled;
+	bool non_srg_enabled;
+	s8  srg_th;
+	s8  non_srg_th;
+};
+
 int ath12k_wmi_cmd_send(struct ath12k_wmi_pdev *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath12k_wmi_alloc_skb(struct ath12k_wmi_base *wmi_sc, u32 len);
@@ -6432,6 +6465,19 @@ int ath12k_wmi_send_twt_enable_cmd(struct ath12k *ar, u32 pdev_id);
 int ath12k_wmi_send_twt_disable_cmd(struct ath12k *ar, u32 pdev_id);
 int ath12k_wmi_send_obss_spr_cmd(struct ath12k *ar, u32 vdev_id,
 				 struct ieee80211_he_obss_pd *he_obss_pd);
+u32 ath12k_wmi_build_obss_pd(const struct ath12k_wmi_obss_pd_arg *arg);
+int ath12k_wmi_pdev_set_srg_bss_color_bitmap(struct ath12k *ar, u32 pdev_id,
+					     const u32 *bitmap);
+int ath12k_wmi_pdev_set_srg_partial_bssid_bitmap(struct ath12k *ar, u32 pdev_id,
+						 const u32 *bitmap);
+int ath12k_wmi_pdev_srg_obss_color_enable_bitmap(struct ath12k *ar, u32 pdev_id,
+						 const u32 *bitmap);
+int ath12k_wmi_pdev_srg_obss_bssid_enable_bitmap(struct ath12k *ar, u32 pdev_id,
+						 const u32 *bitmap);
+int ath12k_wmi_pdev_non_srg_obss_color_enable_bitmap(struct ath12k *ar, u32 pdev_id,
+						     const u32 *bitmap);
+int ath12k_wmi_pdev_non_srg_obss_bssid_enable_bitmap(struct ath12k *ar, u32 pdev_id,
+						     const u32 *bitmap);
 int ath12k_wmi_obss_color_cfg_cmd(struct ath12k *ar, u32 vdev_id,
 				  u8 bss_color, u32 period,
 				  bool enable);
-- 
2.34.1


