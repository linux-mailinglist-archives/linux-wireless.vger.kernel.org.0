Return-Path: <linux-wireless+bounces-38151-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EwPiC/E9PmrqBwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38151-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:53:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8046CB7DD
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:53:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PX68cSLv;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LhiPlb9C;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38151-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38151-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32BF6301AB9D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5433E3DA4;
	Fri, 26 Jun 2026 08:53:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143C3E6DC5
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:53:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463983; cv=none; b=Lj9cTZQH6P1+vzBGxBdCq7bN0ptSrRXVdJC3F9mOjKbSEoaI+z81vmZCRd0/ySVLnv/s8V3353CdL1GxmvZKLFWa/1lFSc8V+yACt7JDpcNYMAk0CTkfQmJkCjv9myUCnA32BmVkjiti7LlPxWnFTtZvUbBT7NVoOvoluRang80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463983; c=relaxed/simple;
	bh=Zdqlu8RHnlPkAWaN2kClrteoMUvjN9eG8kn0p2YolO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I9ClWCppwfk6t8wpUu+tbNo35po4naxmeWRlFprKjb/rhzBoGyqU6BrOwk/XYRXO1uU+qjoknXxUGByqbuq1K+/Kl99bvWt217FLqmEWjEua7Z/KRY5psqVye5tD3gCvXTjrhRulxJTswhgM/2+3XxKE5iGDiRZH+LOTgZBDWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PX68cSLv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LhiPlb9C; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q8b0kn585424
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=e76UWCwc6Zt
	y76f2ndkxP//JiVgpvXZpHBLILeMqOkU=; b=PX68cSLv5Cby3pgZ1W7U+WMEgr1
	H66CEf1A9HBO9U8xDnKNb70C2hju/vgyrubNUeAgdKkyKt0mS1aCZj+YL1qH7uuB
	2S5aQ6SyRtFIpCthIjjEbvFXSNBFrpa8KNmuMCNyUtCnBByZuk0kwiIyc7ovaB1J
	N1c8JGRPrzC84gkyZCuLZ5mnPudlHBNpiWnM2ZD/+cUryCg0C/Mn30urIacLF9x4
	tPqlvyKfulVz7LtqHFbqTKZdp+pzs20L0dNwW2BW5oAv3RAd058k+8EjvzdFA2zX
	85r5NyqHdUn6q9IKgzbDMxKOqADJF0/TknnIVp4cLIel2LlTuM7NqDEJCyA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1p2tr1v1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 08:53:01 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c011c7cb9so1606979eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 01:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782463980; x=1783068780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e76UWCwc6Zty76f2ndkxP//JiVgpvXZpHBLILeMqOkU=;
        b=LhiPlb9CGZOdkjU70CuxyuWBUFcfwIK7k1cwHBWM8MNH7HhwFKL3ZNIT/YYJSZzScq
         znedct5Exo4dpB+GMH0iahwlmcrS9AqobEAdYMSdbVA2Rez2Goo9Ah5maTd1kPpUS8Wv
         m2NHk1U1Ag66GMfp/6fErRDGhxEUUUniBFcAMOuGJ/qNRJd62mYI7wu8oy+SmWx1Zlkr
         600Kyq0XQm5sSYECk+4SuORnoI3j9W78GDBnXbzzxTyr8JS7iVdqCOTT4ca/tsZE4nI7
         QUR/qfrPrpSBa7DyoIw81Cx8cNjESEJwkmv3YYWA8u4lbs/KDvJwHEqjrMXRrD083apX
         4m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463980; x=1783068780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e76UWCwc6Zty76f2ndkxP//JiVgpvXZpHBLILeMqOkU=;
        b=XSoxeeQLKWK74wtLR+4KCUb9el3O+etaBkUxkVGoIyBE72nFr2hEUyAjYgzNmi9VOG
         sadORYOTsC4hqHKAS3vjjgSXcMpG5OHDhNTJGjWqDKBTvDJlCrAtOghgBPZTTTH4VXV2
         Cwn0H8dTiJuJPCL+IfzSuWv+2ofjl31FBfiq3fjIriO7aPOthksT6dwIR8XiPEgw+EUt
         n55Aw/YmUwUWmk6mwvJi3qPav8K7gTzVtb2lMl5sGv+aB3WDVYPRIqbc2MlpAQes4rpg
         0fk+PpO6q/enrUQBjw3ciuq0omJMPaLeAbPZkNkSD2oK6nJ0lqCatQbyeJLSrJ79fTal
         u1Pw==
X-Gm-Message-State: AOJu0YxRh9kZ8Y9nQnb7wwVjhG/A9+sEh9yzx+tP/38Kx7ph8tOZ4Lhl
	AMOziyTS9D0Nod7IC6uwEjX2GcWmm2H6Q54lXO91W5fJ9U4ZdxoiL6nLvfvpTCD/IeVDciefthA
	OdOfVpcl6P+2I/Vx9yARilAERBlGnx/dnHG83T9XMfdl4NkfHqv/ImC0z53xcDsW3x7Ed
X-Gm-Gg: AfdE7cmDEJYT9m6e5IJG804dqS7yNXeW1EN83L+PFffvRZi03QcwRcY9Fn73AEtpnI8
	JqzHtgGfX3gMy+Z7SFePWdOJOO12OTsind4qJde4hK9QoD9W9UNEE51xrRpBGUqcP9VPfwj+ACW
	LRrzOZjGyrw35yQjgBgSh3m2bIonStqiy9QYeomKwPejiXmmC2XsOrnLQ5PaFUNCSI8TdO0PAY2
	35WfnjOKSbCxO4Zzu6QF4J7FMsRG8Y1Ujn43MF0PhHFGuVAGL8eXXvMGgEy0HhYaljf1qVw7Yo+
	EwHrP62JVIEva04hUVH/OH+1MAbxxmADbkpHseQ/exboyv7x0A7WUYPDgguPpQ8DDYcs1QWZXUC
	Av9p+OAnQpRwgQbhb5SbWIA4XumhzgvWNQzC0Uk+bcKu1wikQsUMpJUNMmyXUl4glSK30UCdc6A
	nWLLh6HUhfhNjJp/E8d3VH3AgtLm3NI+PJ/6WV
X-Received: by 2002:a05:7300:2152:b0:30c:43fb:3a69 with SMTP id 5a478bee46e88-30c84d9b4eemr5600229eec.6.1782463980371;
        Fri, 26 Jun 2026 01:53:00 -0700 (PDT)
X-Received: by 2002:a05:7300:2152:b0:30c:43fb:3a69 with SMTP id 5a478bee46e88-30c84d9b4eemr5600207eec.6.1782463979878;
        Fri, 26 Jun 2026 01:52:59 -0700 (PDT)
Received: from hu-ssramya-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca8b918sm17384044eec.28.2026.06.26.01.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:52:59 -0700 (PDT)
From: Sreeramya Soratkal <sreeramya.soratkal@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, sreeramya.soratkal@oss.qualcomm.com
Subject: [PATCH ath-next v2 1/3] wifi: ath12k: Use runtime device count in dp stats display
Date: Fri, 26 Jun 2026 14:22:51 +0530
Message-Id: <20260626085253.3927269-2-sreeramya.soratkal@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX8xk5o7oGn/fJ
 3jJuQ+kJILA8b422iq0BFxE2rThuyCgGTyZ2pj6R6tgiXKZTnSS6T5j2GtLC4FaiLtLGsY3cE23
 vO/Y0oB5gmDd5A5dHe3rPodO0jLxxQk=
X-Proofpoint-GUID: quLacdkUlJJ30dDyMCe3dReUk5Jan4WG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX50mXmBQk1UEc
 Ln7aKIlS8jYvOc2Qzi5J7e6px5R1ZYJcWbsef6vkWaXtul/AArqhMnTdGbRrIu7AyTSvfuopGct
 LBp3mgKnqWpg8PsbwTUNzj6VdT+zOIXtLoQiM/RhXPEyuCdKXSdgmE1lNFYIgdvNHxECyGhBee1
 ktLap7vy/04cRDZT2/Pu277py0/bP0YM+Ws5ZmvGlIiuxSbATP2BieWVweLYcfNzNZm5m3lcX9D
 5MXEgzmt5GxlboRHPRXI5OgXaI/UQmtfVtWHfgaDGZY6mIvT4yeEuBiJE1irDD+oo7dSDp6I7xQ
 1S7k6vANCs8Kn/RnV/DwLepGVfsRCu/E6N6c/HsGGPjAbdnT57GiComRynykFlQBwVnD8I56OIG
 tPaUibM9zTm+FzlCCX6MeIe4Yc+BwkEC5VJs9YAhOHVJSRhoqdmz/OIpQrIbVIcK3HHQ035kGkR
 0TnsVziP8VWNkxgpDRg==
X-Proofpoint-ORIG-GUID: quLacdkUlJJ30dDyMCe3dReUk5Jan4WG
X-Authority-Analysis: v=2.4 cv=IM8yzAvG c=1 sm=1 tr=0 ts=6a3e3ded cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=rbhcnOITtZTbLhSEK4kA:9 a=scEy_gLbYbu1JhEsrz4S:22
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38151-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB8046CB7DD

The REO Rx Received and Rx WBM REL SRC Errors display loops in
ath12k_debugfs_dump_device_dp_stats() iterate up to the compile-time
constant ATH12K_MAX_DEVICES.  This unconditionally prints zeros
in columns with no hardware behind it, making the output misleading.

Replace the compile-time bound with the runtime ab->ag->num_devices so
only live device slots appear in the output.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sreeramya Soratkal <sreeramya.soratkal@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index d17d4a8f1cb7..bab9d96d6acc 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1173,7 +1173,7 @@ static ssize_t ath12k_debugfs_dump_device_dp_stats(struct file *file,
 	for (i = 0; i < DP_REO_DST_RING_MAX; i++) {
 		len += scnprintf(buf + len, size - len, "Ring%d:", i + 1);
 
-		for (j = 0; j < ATH12K_MAX_DEVICES; j++) {
+		for (j = 0; j < ab->ag->num_devices; j++) {
 			len += scnprintf(buf + len, size - len,
 					"\t%d:%u", j,
 					 device_stats->reo_rx[i][j]);
@@ -1190,7 +1190,7 @@ static ssize_t ath12k_debugfs_dump_device_dp_stats(struct file *file,
 	for (i = 0; i < HAL_WBM_REL_SRC_MODULE_MAX; i++) {
 		len += scnprintf(buf + len, size - len, "%s:", wbm_rel_src[i]);
 
-		for (j = 0; j < ATH12K_MAX_DEVICES; j++) {
+		for (j = 0; j < ab->ag->num_devices; j++) {
 			len += scnprintf(buf + len,
 					 size - len,
 					 "\t%d:%u", j,
-- 
2.34.1


