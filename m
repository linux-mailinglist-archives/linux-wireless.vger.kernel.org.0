Return-Path: <linux-wireless+bounces-35916-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJKaEhYB+ml1HAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35916-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:39:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D284CF923
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C42D3009CDF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2DE38BF7A;
	Tue,  5 May 2026 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3UqU+XI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cna3xv4b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA036CE02
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991953; cv=none; b=tybzOiBd3uJpb2mC5NdGBEN4dlN9Gwi07pvNazs9CaDXiMx795Mox7YK8WRabe+v20NWQAs1+Egx0zfZDRCpVyNwaVlyxiQ/7DNnwx8MTJgJayys+0ZE42RuIN+mF+r+Ps2Q89oUr4z5ekUpe7z5EnX2XJeGHw4cpT7vD5Iutnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991953; c=relaxed/simple;
	bh=RkEnrEbV9+XYJ08TMJsZgitRwIKwa/uq1klrB5tz+w0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/VGfkT96TqydH5qSiKgcOVBoJ7kPx92T79An2o2Ho/J5XrivnYws73CHi2tMK1l+Sj5TmN8+QXMmcDM5Ew58L4CWiF9EBOZ0bQkHm5x2pQAZPHeRvPp2x6LRTyyDYvg84L4dTxgqLHwhkSEjrKoWqxR9ynkTUojyeUdy0hXPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I3UqU+XI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cna3xv4b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6459VRY02859173
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 14:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7w2jzuTsl7V
	qy1OwTlK7qU/Odevc1NEfSotLinMWOYk=; b=I3UqU+XIaCXadnm5qxIwE1NHuIL
	6OR0phEcypLgGbTiDKfaSn0mFvSCzHr+eSwR6nnlHI5RbmyXTHloMNiSFwugDe6x
	Egf8z8Vy03FmexA9UcrA7zO56jHfvUuu+zRWorMmEw3ypwzznF86PpWgXTWUoCFH
	W7rqJ/zrc1ai/0/MaqCACyiPgMUcd/6pkha0bmFnopo8vhqPfCvHO49id4NU+cny
	Gp0GQqcHfAb7PgJkaM79q0DwlRd9YUWqZTxjU+NZh8eMve2c49+WsMeDwTsKIJ9j
	W8rbsHh5DgwxyN0sgXX+t5703M62nmxCGoMF/7SXi932mFtFflO4ggoOjiw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dye0ah7yr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 14:39:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35fbb57764aso6681320a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777991950; x=1778596750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w2jzuTsl7Vqy1OwTlK7qU/Odevc1NEfSotLinMWOYk=;
        b=Cna3xv4b97SzWaC7kqrKaEUoillxUi4UWWO5B8x0uxyeJNHt3PmRVI746v0ubWpnwM
         ds5AnVbHk4jImYnoe+yg4/48IAkaJFtoJ2vN/3C9visxxaLXe9k3hL9Ji+DLYj0ZyA3r
         aHVWJ7CKLsICHyMX5diQJblLSbNXxtYR2RljFXN0fUeTJOMH57/GTn9BJdByLlhkHKab
         uC5fxbxjQ2gVXfKmHRM9Hnrt5sLZ0MlDqFHwJ5VrGMt8QA+uC5IBtZ0hruUSsz+Ul8OW
         5dJt5s99D2IsDTFEgOPsVOpfWIf1XPYoL+NpQLXMXb5xAE4whlycjuIU6IQqIYzHrdMT
         TJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777991950; x=1778596750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7w2jzuTsl7Vqy1OwTlK7qU/Odevc1NEfSotLinMWOYk=;
        b=mEOUuq+7WgPy2VM0he3r0DE8TgYDILi5/IRxCshkDvgcohzbCWh8vEPBSjeLNNvLEk
         UiV4dxkoPN8jWCWDRxLLEg4w14rwjbfRpQr/pUgewY75SFzCNgR7T6eY9UEbh7DShqKC
         u0+l/t06Cisb7Rta4mMYyMUxq8TbGA9FNKHb5CKjaIy+K3gfE+55L6ZJuYgQ+qEHhtj0
         qLJwXkuoSnMnWE1fjQfw4XBI/RV3eJKz8wK/8vPQECYdXoQxAA61eStptDEjT5DAUn9o
         xDafT+RhrSBVHNMFotTichwnNDJiLjGDmSzwdewtwNZN9HdMOtdffFH1vigXw0f92JyG
         4qDA==
X-Gm-Message-State: AOJu0YwChNU7rLfmGV0pLoaCMX8G9sV8q3JwAC2c3uu1kARaruo6zG18
	AatUgPeMGBke7QFxLpHSUYbckaR3ymRp5X68N/OeCpc6dLyVFfDdEMb9GFrjbc2cXl2RYva9WyH
	fcDGAwjtOjKUI9lt9mcxtj1VQ1ZztXp9/+VxEdxM7N3O7GVx4IiOVFUJzd9lkL1xnnkaC7w==
X-Gm-Gg: AeBDiet7QNst0QfMRidjTJaoiLXBtZ0WLRKTiCOfWxWlR1jLB7P19jgml/kbF11lrya
	Kmf0svtLF6Fh0+V6F9hV8BdMGM1YxyMic/nzQF2A5Au9OlQzvFawX0Tg5NjL8vRhIf62Hx2ZGTM
	Yoh35FQOzG7rU76EqLivwdZDyL7kQ7o9//Qz5zhTVslDizGmPWQx9kliNFZr4gbYc+knPcf8/Zi
	FutqlWbBd0HQtdQHA5CCyDpYeEd4chbStW8xdypmnn/oVUTpNKl+7RecUcv/cuaflRRFysmitKz
	QoGUc8i9mpVIDVIblTZx8wi3fAIWzE64vHBEZYuaCtJh6/ZGpWiBK2aDRshEGGKE1idaq8pC/co
	CICvuxI8gPMgjYULOhqIlWxqe4F9jnCoZ6zrLAQngvRJ6PLKy4mW2gvD8vfND8FaX2xUGMZli/3
	0LdXVYnYGSZ7UDnOWEaxh5KJfFEj1gY4spZtn7E7LeXvbeCg==
X-Received: by 2002:a17:90b:4b0b:b0:35d:aa02:d776 with SMTP id 98e67ed59e1d1-365722540e7mr3205579a91.2.1777991950111;
        Tue, 05 May 2026 07:39:10 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0b:b0:35d:aa02:d776 with SMTP id 98e67ed59e1d1-365722540e7mr3205521a91.2.1777991949341;
        Tue, 05 May 2026 07:39:09 -0700 (PDT)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36578259e7fsm2831030a91.2.2026.05.05.07.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 07:39:08 -0700 (PDT)
From: Amith A <amith.a@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com,
        Aishwarya R <aishwarya.r@oss.qualcomm.com>
Subject: [PATCH ath-next 2/2] wifi: ath12k: Add debugfs support to simulate incumbent signal interference
Date: Tue,  5 May 2026 20:08:53 +0530
Message-Id: <20260505143853.295368-3-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505143853.295368-1-amith.a@oss.qualcomm.com>
References: <20260505143853.295368-1-amith.a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0MCBTYWx0ZWRfX6huvPHINQC5W
 oDvgFJ82LBTuay8IMsUm+N6G3ILhZD/NyybfYPUnCDNZ7ornesHQCcIKPyVAdgMjwxe8KE2hQrp
 7BcKmaDMxByaV4fHrgCCBtMaE0BdRWewNe6Cp/hFksTOCFWXzLF49X+WzJBficnTQV8/oFC22zh
 0mzBrZm9ZA5/uNBSvW8sM0ZVGcosZLJH0R2LX44rcibDoyDBpF7t5/FJ5F6KkOP1CxqPKqXCkxt
 Q1b3qYCIYWQpDeraHBEd9M72tQxf6ApMq9W/WFIcYmkSk1rllvw1ogAzvcAPxc0Z/3DS+PTYXcw
 GJbrFtSZkeGEevQnER/wGevUszas4tkjj/L6rtkIs7TbIGeerGjc0HAHzazal60/DVQ2aQA3jEp
 NpmX9Y4Oi7NJumi9FOb7MDmgfdIajldv/PtJsZws/fq6NrwBeOcNo1uWIZIR4AxEb3agPOeDW/C
 aKA3L1a1HPcwtKoWe4Q==
X-Authority-Analysis: v=2.4 cv=Wtkb99fv c=1 sm=1 tr=0 ts=69fa010f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=E_qLJZnl5bbyJCvZBeAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 7670HR30C03NbJCFC230EPwiUTi311Li
X-Proofpoint-ORIG-GUID: 7670HR30C03NbJCFC230EPwiUTi311Li
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050140
X-Rspamd-Queue-Id: D8D284CF923
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35916-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Aishwarya R <aishwarya.r@oss.qualcomm.com>

Add debugfs support to simulate incumbent signal interference from the
host for testing purposes. The debugfs entry is created only for 6 GHz
radio when firmware advertises the support through
WMI_TLV_SERVICE_DCS_INCUMBENT_SIGNAL_INTERFERENCE_SUPPORT flag.

Debugfs command:
echo <interference_bitmap> > /sys/kernel/debug/ath12k/pci-000X/macX/simulate_incumbent_signal_interference

Each bit in the interference_bitmap represents a 20 MHz segment. Bit 0
corresponds to the primary 20 MHz segment, regardless of its position
within the operating bandwidth. Bit 1 represents the next adjacent 20 MHz
segment, bit 2 the lower 20 MHz segment of the adjacent 40 MHz segment,
and so on-progressing sequentially across the bandwidth..

Example:
echo 0xF0 > /sys/kernel/debug/ath12k/pci-0002:01:00.0/mac0/simulate_incumbent_signal_interference
This indicates that all the subchannels in the secondary 80 MHz segment
were affected.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/debugfs.c | 46 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.c     | 36 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     | 14 +++++++
 3 files changed, 96 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 8c81a1c22449..d17d4a8f1cb7 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1450,6 +1450,44 @@ static const struct file_operations fops_pdev_stats = {
 	.llseek = default_llseek,
 };
 
+static ssize_t
+ath12k_write_simulate_incumbent_signal_interference(struct file *file,
+						    const char __user *user_buf,
+						    size_t count, loff_t *ppos)
+{
+	struct ath12k *ar = file->private_data;
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
+	struct wiphy *wiphy = ath12k_ar_to_hw(ar)->wiphy;
+	u32 chan_bw_interference_bitmap;
+	int ret;
+
+	if (ah->state != ATH12K_HW_STATE_ON)
+		return -ENETDOWN;
+
+	/*
+	 * Bitmap uses the firmware primary-based ordering documented in
+	 * ath12k_wmi_transform_interference_bitmap() & intf_map_80.
+	 */
+	if (kstrtou32_from_user(user_buf, count, 0, &chan_bw_interference_bitmap))
+		return -EINVAL;
+
+	wiphy_lock(wiphy);
+	ret = ath12k_wmi_simulate_incumbent_signal_interference(ar, chan_bw_interference_bitmap);
+	if (ret)
+		goto exit;
+
+	ret = count;
+
+exit:
+	wiphy_unlock(wiphy);
+	return ret;
+}
+
+static const struct file_operations fops_simulate_incumbent_signal_interference = {
+	.write = ath12k_write_simulate_incumbent_signal_interference,
+	.open = simple_open,
+};
+
 static
 void ath12k_debugfs_fw_stats_register(struct ath12k *ar)
 {
@@ -1515,6 +1553,14 @@ void ath12k_debugfs_register(struct ath12k *ar)
 			    ar, &fops_tpc_stats_type);
 	init_completion(&ar->debug.tpc_complete);
 
+	if (ar->mac.sbands[NL80211_BAND_6GHZ].channels &&
+	    test_bit(WMI_TLV_SERVICE_DCS_INCUMBENT_SIGNAL_INTERFERENCE_SUPPORT,
+		     ar->ab->wmi_ab.svc_map)) {
+		debugfs_create_file("simulate_incumbent_signal_interference", 0200,
+				    ar->debug.debugfs_pdev, ar,
+				    &fops_simulate_incumbent_signal_interference);
+	}
+
 	ath12k_debugfs_htt_stats_register(ar);
 	ath12k_debugfs_fw_stats_register(ar);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index b9e107cfd869..4ec5b12f703b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -10561,6 +10561,42 @@ int ath12k_wmi_send_tpc_stats_request(struct ath12k *ar,
 	return ret;
 }
 
+int ath12k_wmi_simulate_incumbent_signal_interference(struct ath12k *ar,
+						      u32 chan_bw_interference_bitmap)
+{
+	struct wmi_unit_test_arg wmi_ut = {};
+	struct ath12k_link_vif *arvif;
+	struct ath12k_vif *ahvif;
+	bool arvif_found = false;
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ahvif = arvif->ahvif;
+		if (arvif->is_started && ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
+			arvif_found = true;
+			break;
+		}
+	}
+
+	if (!arvif_found)
+		return -EINVAL;
+
+	wmi_ut.args[ATH12K_WMI_INCUMBENT_SIGNAL_TEST_INTF] =
+		ATH12K_WMI_UNIT_TEST_INCUMBENT_SIGNAL_INTF_TYPE;
+	wmi_ut.args[ATH12K_WMI_INCUMBENT_SIGNAL_TEST_BITMAP] =
+		chan_bw_interference_bitmap;
+
+	wmi_ut.vdev_id = arvif->vdev_id;
+	wmi_ut.module_id = ATH12K_WMI_INCUMBENT_SIGNAL_UNIT_TEST_MODULE;
+	wmi_ut.num_args = ATH12K_WMI_INCUMBENT_SIGNAL_MAX_TEST_ARGS;
+	wmi_ut.diag_token = ATH12K_WMI_INCUMBENT_SIGNAL_UNIT_TEST_TOKEN;
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "Triggering incumbent signal interference simulation, interference bitmap: 0x%x\n",
+		   chan_bw_interference_bitmap);
+
+	return ath12k_wmi_send_unit_test_cmd(ar, &wmi_ut);
+}
+
 int ath12k_wmi_connect(struct ath12k_base *ab)
 {
 	u32 i;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index d74f7fca7678..b5b3e472631c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2269,6 +2269,8 @@ enum wmi_tlv_service {
 
 	WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT = 281,
 
+	WMI_TLV_SERVICE_DCS_INCUMBENT_SIGNAL_INTERFERENCE_SUPPORT = 286,
+
 	WMI_TLV_SERVICE_11BE = 289,
 
 	WMI_TLV_SERVICE_WMSK_COMPACTION_RX_TLVS = 361,
@@ -4244,6 +4246,10 @@ struct wmi_addba_clear_resp_cmd {
 #define DFS_UNIT_TEST_MODULE	0x2b
 #define DFS_UNIT_TEST_TOKEN	0xAA
 
+#define ATH12K_WMI_INCUMBENT_SIGNAL_UNIT_TEST_MODULE	0x18
+#define ATH12K_WMI_INCUMBENT_SIGNAL_UNIT_TEST_TOKEN	0
+#define ATH12K_WMI_UNIT_TEST_INCUMBENT_SIGNAL_INTF_TYPE	1
+
 enum dfs_test_args_idx {
 	DFS_TEST_CMDID = 0,
 	DFS_TEST_PDEV_ID,
@@ -4251,6 +4257,12 @@ enum dfs_test_args_idx {
 	DFS_MAX_TEST_ARGS,
 };
 
+enum ath12k_wmi_incumbent_signal_test_args_idx {
+	ATH12K_WMI_INCUMBENT_SIGNAL_TEST_INTF,
+	ATH12K_WMI_INCUMBENT_SIGNAL_TEST_BITMAP,
+	ATH12K_WMI_INCUMBENT_SIGNAL_MAX_TEST_ARGS,
+};
+
 /* update if another test command requires more */
 #define WMI_UNIT_TEST_ARGS_MAX DFS_MAX_TEST_ARGS
 
@@ -6682,6 +6694,8 @@ int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
 				       struct ath12k_reg_tpc_power_info *param);
 int ath12k_wmi_send_mlo_link_set_active_cmd(struct ath12k_base *ab,
 					    struct wmi_mlo_link_set_active_arg *param);
+int ath12k_wmi_simulate_incumbent_signal_interference(struct ath12k *ar,
+						      u32 chan_bw_interference_bitmap);
 int ath12k_wmi_alloc(void);
 void ath12k_wmi_free(void);
 
-- 
2.34.1


