Return-Path: <linux-wireless+bounces-36187-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBR6J/RUAWpvVQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36187-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:03:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E6507C77
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 855CF300A7E3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 04:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4AA54652;
	Mon, 11 May 2026 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cqT/ljFb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zk8PYIHK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8BC271468
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778472178; cv=none; b=dMR6EQ7hlpEo3wdQEBo8o+y/SLi/u68kb3/cw0jLkNlFwDqejqMoB0ydZ+SyGtzlAQ50xmvEve8eKX20R3j7txLD667YuNnulAbDaqm95fEqXh+SNpoX2Hv+wyCHZNMY9NiwYokIlakWmbf1OMOijyrM2IDw0Yw970p7N4Gveig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778472178; c=relaxed/simple;
	bh=/rqueYPvw5dZvfamLQU5ov6HIRR5Dcq11BD4XYqsgpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IsmD3GrSYgEmpqRlWUgIykQpEYpoEo0MGquzyKdsCapPHBTNG9/YQz1yihqL24Zy/YAINSlOCrbv39fwmMZyZaRiX+2S9wZS6v0baW+jTMiEtMqjj2/YYUzDHGNSAUHKF9Cvlo4053JN6oDX+Z/CKncOKlLNyWWzQ2jcvf4rURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cqT/ljFb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zk8PYIHK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64A8eZOI1861646
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rV0ICYiszQY
	c3S4jZWSNWvmLyvcxkJgwvd5Dn21gKDE=; b=cqT/ljFbPcGIerFj3EW7ABNVEzf
	a0ILBl4cRabFxbkItKBWygdly3xvEg3FmRJoko/OeHiKwiyCZuuy3hyOe6V/eLyu
	rrNJvWb1RK50rxnRRj4X5k5kgm3f4pwDg4JIBqrcBd0LVMs3dp7icEsdkY/LqY8O
	mffiXV1CCCiDKKQQHNs+lMVnu9gTxEQM46b0+ZJXIYgbuGhZ6cuOjd3sKRExDSlA
	gMTUZYX7Bt5y7G+tCrJ2aVHPXghpgBeTXOp3haicLtHSi1q3LKrEDezepSKci9mi
	3hWotee2xIZShCl0oyCqws+lMugSm0O/27VDFt5PeakbhaK8L9GjaBQIaxg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1t9q4kk0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:02:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c82894155ceso894160a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 21:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778472175; x=1779076975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV0ICYiszQYc3S4jZWSNWvmLyvcxkJgwvd5Dn21gKDE=;
        b=Zk8PYIHKboUT/b44iDu0gdNGoTofjukENchvS8rcE5YSeaWAlX/Np6BV7SbSTLYE4/
         v5g4P7FOxElQBPxnc3dXxvQUrRBLhowvh58WrRzE/LaVoRu/rpo+gIDZQ3lx+R7DMedu
         4MrnJgFma1oTx3jar+V91BA28LsiZ+RKsQyI8M2Hv+8PBb3PR8lKvwk4OfnwmJPRTr5J
         V8vz6Jc1gt5Lt84AZ0jZ5LhOgQw2WiSSsFDbQ1q9ZbbsxNz5CFkkL9LNxzm8gk34v4dU
         /IYZM5KXuoStYnAa7wQSeHT/HWskjNgh3KPFNKccTIIySu0L+J95idJwN1ZaSNabETxX
         DREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778472175; x=1779076975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rV0ICYiszQYc3S4jZWSNWvmLyvcxkJgwvd5Dn21gKDE=;
        b=DvsyEDrJiHCJUn3cTvN5wL9FvMRakS4yWKqyWewDtszQei+5cpcyHGFli096z0qbEk
         TAAhLlo+zILbXIhY+OS34bBWrDec9+7yaaFKnnZQxvId+D0aJtQxiuDOkKHxjsj0d2kC
         NYJbyWYf3DPlJfBzdXUBMo1kW5nZBamy3Hk6WNJsxtyrJy3IM1Fx2+x4OllMX6vVUefN
         ud0dvWUjiZlrW3R/OLR0GPXkKg/uA6DDyaTiUZ9cetQUHO5OuYZoZc+FGxE92TFOHE/T
         tWK85Rip8asP+pthnJ8GpzhqlyJt+RczB0ZdugAYuFK01GulRsU9/kEBf6HbjdbpdsXl
         R/2A==
X-Gm-Message-State: AOJu0YxLOcsA1E9WnIR+qu7Mg0gTtyTICUj3hQwIh5AcFFqKzfIvqQQg
	QJGgwOQufXmi1MeJzt3K0q9EczuOwaHX4GYYe9sAHeEXpigdCshpbYSaYiwgsPNCGy2PoLfaSGx
	4PfUQPZSmgyl0BjUOiDq1cxX7wXrvqsMhIHHRBVUbMTal0ApgKlQ4DT80nWyOAM341hvriQ==
X-Gm-Gg: Acq92OEZuHniiShHTWhUwdPgyGUTxIp5rkooPtRUfcVfV5ATxWJbzXSba5GcCyVGqNW
	m45T9D8S5e/ZFQNo5c42R4uSDJuOiKxx438h1XVL/fEjcGRFjHQtrmFcJNYtLzoBuEy9hoffqJb
	74zSniimIhlFe42qnztqfj/GUKtAXPdUgxd0vCcXmlgkcJQpSKyXSfXW5ElDUb8fZqq1KOjXE/x
	GpywIqrjkpkJnF8/76jQxA52NsGHs3piTiSBJzrp2Dfi2DUSScJAiaTC/YRRfTRtIIfa4Qx/E1M
	FnWEXCpjE6PF/bTGL9j/BdPuRCCwSiXzr0lCV3Wr9uDdEW1auJ/eFLLOboR4dwEd+hTr2fNu/e5
	c3pT80eA7JgoLGxkF9gdzPeUZUdIu3rLT/JsJZP6XVoSg7Ml7rHKZFXkdN5ajQrxNiXayqtpySM
	QN+LACBFCf0Iu5Gsv8E2UeLwBLq8ZjxhFTCE8=
X-Received: by 2002:a05:6a00:1891:b0:837:e9cc:d458 with SMTP id d2e1a72fcca58-83e39150f1amr7787007b3a.10.1778472174494;
        Sun, 10 May 2026 21:02:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:1891:b0:837:e9cc:d458 with SMTP id d2e1a72fcca58-83e39150f1amr7786966b3a.10.1778472173935;
        Sun, 10 May 2026 21:02:53 -0700 (PDT)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf0cesm22792259b3a.46.2026.05.10.21.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:02:53 -0700 (PDT)
From: Amith A <amith.a@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com,
        Aishwarya R <aishwarya.r@oss.qualcomm.com>
Subject: [PATCH ath-next v2 2/2] wifi: ath12k: Add debugfs support to simulate incumbent signal interference
Date: Mon, 11 May 2026 09:32:42 +0530
Message-Id: <20260511040242.1351792-3-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511040242.1351792-1-amith.a@oss.qualcomm.com>
References: <20260511040242.1351792-1-amith.a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1PTestvJRZ58Xu3wivDYcCRGiBhcgryM
X-Proofpoint-ORIG-GUID: 1PTestvJRZ58Xu3wivDYcCRGiBhcgryM
X-Authority-Analysis: v=2.4 cv=J7yaKgnS c=1 sm=1 tr=0 ts=6a0154ef cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=E_qLJZnl5bbyJCvZBeAA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA0MSBTYWx0ZWRfXx4ZlbNxtPjlN
 9757a/+6IASPKLV+GufIk89pOhxHYpdIv6V0QE5uFBhbmnpg7ikTCk4EiTmoz3rvsOxX+6KzbKQ
 yoOxhuT/w5pvcRg/z0H39TIb3jlJLpI+7xLJJ6WUAYPVnkhwU3K+a2r87+FR8HY0idFKQNlisT/
 uKVypKivbCZs8fTUqmCUeZUbLx8hQbkuAStU+1okkbsOeqVsaAKwUlYXhymzHHI/5VtAmRLSCx8
 fY4Rh51GTVjQ8cnrZ5fdroII1hQ+K1Kovy4/HwDze9I8HKn8lf0ULXnDfIzChfuoLfsSP15pgfH
 PeA6JNCGAx9/pDpEqk0kfE48toLbOSMVPYvBXjhE6KOtNOHOMmgtYXlrLTVad/ulw3dfEDa0zQF
 uvTLB33eSwO8A3xH7Tu05BytJ4akcfrWaVozCbw6CmDuOrmA0eGyFzPqQ+btTTZ2yMcVf6RPFNq
 T7zU8HuAKmu6XsgAkfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110041
X-Rspamd-Queue-Id: 505E6507C77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36187-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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
index 8609c612aa2c..25e61cc7e5ac 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -10568,6 +10568,42 @@ int ath12k_wmi_send_tpc_stats_request(struct ath12k *ar,
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


