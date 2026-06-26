Return-Path: <linux-wireless+bounces-38153-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jotmO3s+PmorCAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38153-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:55:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2D76CB804
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:55:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=kD0jgvFB;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=d9lbUXDx;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38153-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38153-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B5830BCBD1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C13E5EF6;
	Fri, 26 Jun 2026 08:53:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FDA2EB859
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:53:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463988; cv=none; b=Y4r3E7H4DXSWf8HN6HetBohTGE2ULkGttUR5CMEgexv1qOMPYaveVwqnrbFeVXXAzrzGHUBCv2xIlXqO4avbKYsswI/rOrwLuM4ojEYmU7oaQXup7NVNhTkqiPIG/CeLFo5ArL4e7f21K143xRjuIQrNACNFl4zs0tBCB0a6ynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463988; c=relaxed/simple;
	bh=WvuJX7fEfr57/M+7aXtPptbz7sW/+ASni1sPIqGsqXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z7uiPmQLw/PB1KK6wuRI5vpiHA3PeUZ+/qZmXaDEGwxA0XbP9KOWFp10+WChyll2ND05SVdBGBTKOCW8tGOwjTOLJVSygwWn8O9s02HgqsbDgBG5EDdFAy9o+/HlVBK4VCq1sP5IK337gUxIaAeMHdm236RWFk8qpEjVFsrwjjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kD0jgvFB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d9lbUXDx; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q8b1wb585431
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rC2n29l+e+U
	5R273pH7NXFGAsfPxPHZc2q/3DT0Y/gc=; b=kD0jgvFB0mOR5cmOllPXB4QvFw4
	z6x7LK0rjjudEraIe4Q3vLSJtm88LY9q9SkZ8LtLf7q89q6VpeQcJNeJkgFsJSjq
	hfyUteUFXAQxq8jEyeuA2ap5PxCdYHDY0Tpn8d5aATauL6BDDc1CC+icQ8r+Elbh
	5Zg1VfRbYWP4P4sCNYNjTivgqHc8gcc8zjVAxrn9kkga8oFo7ek8XyhcoEYNhc6M
	jd510acfbtDo/sJVIvUDNunYCN8dVOwZ3hSioQhSqiK9RTvC6DO1H3oQ1k+IA9Sk
	eEP88GGDKbfaz9XLozLKru9Q8NcLgSPy7Vtqdcp1d2HVAzgAY3fdVKS+MZg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1p2tr1vm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:53:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c9bd8b9c7so669487eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782463985; x=1783068785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC2n29l+e+U5R273pH7NXFGAsfPxPHZc2q/3DT0Y/gc=;
        b=d9lbUXDxyYi5QWdpdE1Nj6zjy7H6sNl5mvZhkha/i8ceAKEtOHh/BGDaq/zr1CfFAx
         G/92RM+uwRQDxTkiqBbiJWS2pmQEfmdvXD9ABNTwikluXkMcEh3+tcBr7ctFZKf//zca
         IMYvM5RHgVW7y1qEk1dXfZvba9B/G5Lij1AsoarRpcMbo8CcZBhIjqeLTjfsIYNmVZwK
         r794UU3Hba2umbUEHqulCY3SzX2P4Z2WWh1lZewCzQuan+k3oqKPCvyvunOeNJe6P725
         5EVeD6ywaQx9+3MXmOsgdit9tEgQ3Qvoq6l425MJLVa/Aa/QEKfe73eR9YQ0WGs5Tevd
         FoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463985; x=1783068785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rC2n29l+e+U5R273pH7NXFGAsfPxPHZc2q/3DT0Y/gc=;
        b=GfYobipQ+M9DZsWIZmuEYAT0lD6K42q7CMiioeFfHuTBGS3gNISrVGwZpPYNx/mnNX
         F2W8BdDc1O51+nPrGro50PwLDrb0kX1XRraISgK/6uncTw+wtMce9i0SAfiwuQgp/bty
         ZizZS61OEOSfSyWQVxe4vImvNiq12hDN6kBhO42LUMQOaJbHXXvvwdoqbPmCdRXt2QiF
         ZcVXCgCpYszSNtVOP3O8edn2PFCDKODt0eb5DAerF4uAYNl828OWkE0xZfzCtI+sg6Sm
         Ip8IejBDoSIjUIgmvPcLFxjZ31NJHOaRhZRF+/+TxJgEQ0Ngovz0n8NJOBZpY9n70GVo
         U+6w==
X-Gm-Message-State: AOJu0YzNP/r20R+07oidof97d1KhCxqpKSFPCpSuKjG/edCZJMGyPuXx
	DNbp6GJjByz1Tx2Al7h2DgilhHFaqbtMj3bQc4strutDPXc1lBQD0tRm/TaPEijlIaQU+rC9Uy3
	jKOjVqo/t740zePKYS50I8xAYcSyzsDDVLdospXUg4aMRZhyNcCBi+e1Qf8IKq6a+R/anaoeWsm
	rd
X-Gm-Gg: AfdE7cm3pSnoHgIl53Sg9HSSLfxBbqi4Jo8hadtdX8k4fOKY9AQ6CGxVY6zURI4DreQ
	JgsJzxXF4WNInOUIFedcpLXmGJRXCFZi9u2I3L8Bq9U32KItkL2RBMNi3rKZjVekujKFRmpK1su
	6dCDUbO27fT7iJN6KhRdmY5RniNlR3i3hZ215B5FK7Gw0gcRXANlPmlzTu5otCBfob0Ua8meiIK
	BWDpA8T1gTqubrizN28xtpgQjCh29mUXcQtxm6n8nGi74ijob7L3cbUFf9CbfPTU6zjKjZC/DRG
	VMtWVdE/J5jMzhCiyErBdosS0hAuNwh+/KjpEH8UZnYtETbIOZQ8q4Ut95MqNqNn6t4Ied+bxMr
	UGh3kGBs13eUsDD6CL7ma4PAZ6OxZ8VosWTu29vD2fziBP6V7nARTiBUd4T+CurNUXIIe/9Nqyn
	B6yYALQdLwt7Jz3R+DRfY8isqW5P/wXNlgXs5I
X-Received: by 2002:a05:7300:3b2c:b0:30c:50cd:840c with SMTP id 5a478bee46e88-30c84db3032mr6385295eec.11.1782463985038;
        Fri, 26 Jun 2026 01:53:05 -0700 (PDT)
X-Received: by 2002:a05:7300:3b2c:b0:30c:50cd:840c with SMTP id 5a478bee46e88-30c84db3032mr6385276eec.11.1782463984484;
        Fri, 26 Jun 2026 01:53:04 -0700 (PDT)
Received: from hu-ssramya-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca8b918sm17384044eec.28.2026.06.26.01.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:53:04 -0700 (PDT)
From: Sreeramya Soratkal <sreeramya.soratkal@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, sreeramya.soratkal@oss.qualcomm.com
Subject: [PATCH ath-next v2 3/3] wifi: ath12k: Show per-radio center freq in dp stats
Date: Fri, 26 Jun 2026 14:22:53 +0530
Message-Id: <20260626085253.3927269-4-sreeramya.soratkal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
References: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfXxyktLjZYI3iw
 vl2Ld+i1vNEJ+XNP2g3MM+497crJ9s2/oi7pmMdpoagz400tfUKYHm2mEPRNf7MxavaDErhXp+o
 O7rGuH4Ir/Ns5vSq9JfuAwtBlmMKIGQ=
X-Proofpoint-GUID: LY1_2aVMTxCkPmSbpOYbGb0KdVx3PBvo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfXz3B/luwVqxba
 +5xyrwfo+09eK8HDr7W1gH6d/7ul9wUV9k3nAW81rJLxWFNc+PeVwMXKicd/LmlNQrzjkuxCw8k
 hNj4Ev78R1OhAaMhw8yAjKAums7oUUC+byxvKDS4PBPRbbuPUUqSymH770YbPR/C3pBqWjlqt3K
 MueMO4Js5v53u35/pmNXKTtIqTyVFrbpRY6P12/4eQPkCoNaAG5+IEaqXgRZ/auqH1TgWWZ7eal
 3ZKM/7vYPM25JxhbVhhyeV9u867gkF0Lmx29P9BwsnNkdBpw2/F90PLZLXLBO7dy7hpcLwwf1Ce
 MceIgZ8vj0SF7S/NVvmsl2jcfFngP2O/gIrfg7C9o15KG1jy3Mb7JKjr2p/QKwIoiym0h6e277b
 g2wPGaT4e0MhsUbTH8LZBx2kxtHu3JdSQDQWbNfol28cMk3Ir1KKhlNbE/ieZA7jZvB+0324h2d
 xveDCufn34yL1igNSfA==
X-Proofpoint-ORIG-GUID: LY1_2aVMTxCkPmSbpOYbGb0KdVx3PBvo
X-Authority-Analysis: v=2.4 cv=IM8yzAvG c=1 sm=1 tr=0 ts=6a3e3df1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=JlNIVIk9kHasGwjauWMA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260070
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38153-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:sreeramya.soratkal@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sreeramya.soratkal@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sreeramya.soratkal@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C2D76CB804

Currently, the frequency on which each radio is operating
is not available in device_dp_stats. This information is
helpful in debugging the channel-specific throughput and
is available with iw/nl80211 dump.

Extend the device_dp_stats dump to display the center
frequency in the existing per-radio loop.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sreeramya Soratkal <sreeramya.soratkal@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/debugfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 57c213111259..d54995b7adb2 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1031,6 +1031,7 @@ static ssize_t ath12k_debugfs_dump_device_dp_stats(struct file *file,
 	struct ath12k_device_dp_stats *device_stats = &dp->device_stats;
 	int len = 0, i, j, ret;
 	struct ath12k *ar;
+	u32 center_freq;
 	const int size = 4096;
 	static const char *rxdma_err[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX] = {
 		[HAL_REO_ENTR_RING_RXDMA_ECODE_OVERFLOW_ERR] = "Overflow",
@@ -1164,6 +1165,12 @@ static ssize_t ath12k_debugfs_dump_device_dp_stats(struct file *file,
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ath12k_mac_get_ar_by_pdev_id(ab, DP_SW2HW_MACID(i));
 		if (ar) {
+			spin_lock_bh(&ar->data_lock);
+			center_freq = ar->rx_channel ? ar->rx_channel->center_freq : 0;
+			spin_unlock_bh(&ar->data_lock);
+			len += scnprintf(buf + len, size - len,
+					 "\nradio%d center_freq: %u\n",
+					 i, center_freq);
 			len += scnprintf(buf + len, size - len,
 					"\nradio%d tx_pending: %u\n", i,
 					atomic_read(&ar->dp.num_tx_pending));
-- 
2.34.1


