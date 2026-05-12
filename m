Return-Path: <linux-wireless+bounces-36288-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHdeE22xAmonvwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36288-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 06:49:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EA0519A96
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 06:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5DB1302A067
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C92C3257;
	Tue, 12 May 2026 04:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kBuMXMVB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iwuR8hp3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A351DF980
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 04:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561364; cv=none; b=mheWyRvRtPFJF12yghW430NennvGhroagTkNwZfMRL9K0DGQFxm1a4oaELxDKcAyZ8jiB16NnHUQTX61IA8QnbdjJrMETpe+tDylsYmUV5V0HGTJSm635twU4CfMaRCkUxuHaBU6pCKrB+V13d7H9ic9sw3ez+ur9EW2Ni+5Xp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561364; c=relaxed/simple;
	bh=WJFStmZXXBBcgKpckYOAjG0JfXh8GMy3h8ik9SZbkxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTTZHjE296WuVAMJIqeIuqFceSeHQir+Z7GMVMjjn6KSzXt7eLjTXu+VOP6HwFM5CaJHzeX79CzsFTSqjvQkOMwBdMZTWoMhSY/lf/RD4BgtUCoANw/bZkCPHwlGo1ReP/N3NHvRMTVWe0LeKeS2bg+rhh5uXYV9hTXhCrlvE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kBuMXMVB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iwuR8hp3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6mKh3384821
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 04:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=M7qw0Fy03F3
	odGqvlO/Dqk6ieb60Odj4xpF8aLqR5+0=; b=kBuMXMVBg/+vmLwQtJn5hmxkEYx
	q2qiSB0K9hjYjPoOH3vUgjsIfJfiiVTdLdKp/qGwznIkScW2LJgI1YHe4tCeZUGF
	l5xe+t7Dmpm7nSMB3plt8Rpw39ZXxCXfdrOdXV2UHDwX1zhk/jtriCGQ8aw8lQA+
	nXse2lTEu6Z6Rpukt9mUsSpUXvg/jyV4w6OEMzDaMKd4abnHcsFtXYk/JisLWfbh
	21BiAe5Mu9dTDhFpKm5QadMPscVWBqMfN3vM+oF9PXw6il6MO9WLTRz9kUD5TNrn
	l2gUUgajJ/2bYbgVGVwQt7bi7/wba7eQeok1MV8VyDwzLSE77/I6sr3FDbQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv4hfmg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 04:49:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so7895345eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 21:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778561361; x=1779166161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7qw0Fy03F3odGqvlO/Dqk6ieb60Odj4xpF8aLqR5+0=;
        b=iwuR8hp3suVWRny92xPVeFqYdD8/nNfy87kf34enR/qee7Z8MQcrHRaHdnQRkAgoob
         wsKABZXmBG4AHoddEs4333pUC50yGZuz+IT1HYM1vK6oRssts5AVvn/R8/5PRaQS8Rcg
         xrHNbgvHyXk/WSv8Hbthk8PpvekO++AI/oPhFp0NOIoEnkpKt72nFjMebVk0X5wJYXyN
         wGOvuFbFyDVI7ibScEqNPLcVscInOsiPT9K+APG+rAFYrn5z4ERN4sTGCZyF6OtwDUXr
         ejVL4iAMlyRw9dr9bwRaSNCi4h73/d20JGEghE9STiaMB8dEsOOXZucxUrKyl1tu7Afh
         uF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778561361; x=1779166161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7qw0Fy03F3odGqvlO/Dqk6ieb60Odj4xpF8aLqR5+0=;
        b=TTdt+BOFpzu1nK8TVe4k3FzodY84HsSr7PipVpeUcR7YadrDaap+tyf2MxwnXFREZQ
         5+U+Jxw4kNAKK2P19vHUoVzHKvA3K7/Mb8g+vWUT8aPOwhdBLzgkcimDBgLlVr8x+v8U
         NgCp6TLpuLghs0/9nBDIUsYUTLzcbou0Xz1dw5G5z4duGf9XYGdkWS7Bnt9o1ubzaj1s
         u06Q+CMIsQde0ardL/HurQM7IuYnGC7Y8W3eZqZ2GOj7SAo7CvSI/N90b5jNl6eeTDft
         nLrEpcmTB2cRhhrwrghwYnGA0n6tweb7y/QPGRB1EJfnWWjjJtiWT64rfMxTwNwoJd6v
         LLCA==
X-Forwarded-Encrypted: i=1; AFNElJ+Z0ccFVvm2eKRoiwi0thzc1yqp9ts65GqT80FJ27dU51dJWjDy9O6XNpv8L+jlX2XcEojegxeuYOwzkQsxTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVhOoajsC0AAqsnjk0FuL2umBEXHKhiIjIhCGLyGEx0jo321Z
	ZjTGyL5IvlVfMDy5EkaqWrisEEIql0RZT965YUGunwsjDaH1XjNeMN6tbkwHGK52BsUbMlHjdW1
	EDp+tqAdVpio/kOwDJJA3s2HumtBiPJOpzu/HMcidDQphqiolrVDdVSwl99y6DA1tq1OCPU76oz
	38IK2f
X-Gm-Gg: Acq92OGtKiMi+bT7LeFVspvYdYXRURc5k9o3DtwIKeYMHbsesm3MFQL2SNO7Q0eyIQo
	LV/cgP5OlKxTGDG0+/5eiZyHMK1FH7mS2IEqpYl09p0fdLWsLOvvi8KFOqixTg2JD64kdEg5SJC
	Y2opewPt77JFw/Kazf4VK9CVAsiTgYUtfXIz4lmZ0gKLfe5HntNqUK0ECxx7DDnvUzIapZgLalo
	J0kB8tJh6g1vZGTYDTHHcMyPIktECjKLsjXEJnCfo6dqS+W8L016EASsDLy3+msjsdAlsKH3zdW
	CFBUdZLTOFCUHWmMX1RY5g6z0OkKQDwz/ACsTTzRAn9Mk0zltjsr/Sl6sp4aQnyitcHrI/hKYm8
	eOr2C0YGpRdodw+ph7Fzw3Hv+YVCPJjUum8sOGOijReN2UMfwOzef1XYs972bTaUE9cVMdcL88i
	i1GQ==
X-Received: by 2002:a05:7300:478e:b0:2dd:405f:89b3 with SMTP id 5a478bee46e88-2f858348089mr9746717eec.0.1778561361126;
        Mon, 11 May 2026 21:49:21 -0700 (PDT)
X-Received: by 2002:a05:7300:478e:b0:2dd:405f:89b3 with SMTP id 5a478bee46e88-2f858348089mr9746703eec.0.1778561360548;
        Mon, 11 May 2026 21:49:20 -0700 (PDT)
Received: from san-w175-na3-01.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d43b4sm16032926eec.11.2026.05.11.21.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 21:49:20 -0700 (PDT)
From: Wei Zhang <wei.zhang@oss.qualcomm.com>
To: jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.zhang@oss.qualcomm.com
Subject: [PATCH ath-next 1/2] wifi: ath12k: fix inconsistent arvif state in vdev_create error paths
Date: Mon, 11 May 2026 21:49:04 -0700
Message-ID: <20260512044906.1735821-2-wei.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512044906.1735821-1-wei.zhang@oss.qualcomm.com>
References: <20260512044906.1735821-1-wei.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZrTd7d7G c=1 sm=1 tr=0 ts=6a02b151 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ZZFM_UldhxCcaClkVvkA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA0MSBTYWx0ZWRfX7asXJXRFb6Gw
 +tsAOFe5q7vTaLo6r+cADcZkv+X0zjwHGJrtRmLSkIxEa8t37UGOFyb4Jcvou+5ZquoRT/efS9t
 RF5rzb5AUjc+veZQqqFHvQayZvuaMvETMki4tG23NMbr5Q8f2Gn6l07iE4DMXCfdGZHHGQ2hgAC
 mlqm1FdzeZCZqa07Hl4PBPnZG2gffMQ9lXD2pU252Rby9w5i/kq8yGodlWrwlcD87zPvjOhPC4H
 4WouceSLhKvyd+E9NAjmnBFd8BUG2QTcWkil9XUAcHjtss2AQYU03ct0JKi8ax4FRHaVUDMcjqO
 TB1ubK9Hv100mSfiz6ZPk1w8PYAmFJMryp9qOnNi4wia/HSeyE1WUJrz0uYAkVPhLXPGjh3NHyq
 ylIZgXfvBk/JwKbdaXpvpqmYiP+gBHqtpLdOYwSuI+s/1VoFnNLrOCFTMLFPxcWO/YOiytLIfGF
 39IJhemT6dpxGmP9x8A==
X-Proofpoint-ORIG-GUID: gB-3PqdbUCWIrDgGPFyoyFnqXD4neUog
X-Proofpoint-GUID: gB-3PqdbUCWIrDgGPFyoyFnqXD4neUog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120041
X-Rspamd-Queue-Id: B9EA0519A96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36288-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.zhang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

ath12k_mac_vdev_create() has three error path issues that leave arvif
in an inconsistent state:

1. When ath12k_wmi_vdev_create() fails, the function returns directly
   without clearing arvif->ar, which was already set before the WMI
   call. Subsequent code checking arvif->ar to determine vdev readiness
   will see a non-NULL value despite no vdev existing in firmware.

2. When ath12k_wmi_send_peer_delete_cmd() fails in err_peer_del, the
   code jumped to err: skipping the DP peer cleanup and vdev rollback,
   leaving num_created_vdevs, vdev maps and arvif list membership live.

3. When ath12k_wait_for_peer_delete_done() fails, the code jumped to
   err_vdev_del: skipping the DP peer cleanup.

Fix by changing the ath12k_wmi_vdev_create() failure to goto err instead
of returning directly, routing both err_peer_del failure paths through
err_dp_peer_del: for proper DP peer and vdev rollback, and consolidating
the arvif state cleanup at err:.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 477cabfdb776 ("wifi: ath12k: modify link arvif creation and removal for MLO")
Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2dc7dba53ec8..8f8456509468 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10290,7 +10290,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	if (ret) {
 		ath12k_warn(ab, "failed to create WMI vdev %d: %d\n",
 			    arvif->vdev_id, ret);
-		return ret;
+		goto err;
 	}
 
 	ar->num_created_vdevs++;
@@ -10437,13 +10437,13 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
 				    arvif->vdev_id, arvif->bssid);
-			goto err;
+			goto err_dp_peer_del;
 		}
 
 		ret = ath12k_wait_for_peer_delete_done(ar, arvif->vdev_id,
 						       arvif->bssid);
 		if (ret)
-			goto err_vdev_del;
+			goto err_dp_peer_del;
 
 		ar->num_peers--;
 	}
@@ -10460,8 +10460,6 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 
 	ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->num_created_vdevs--;
-	arvif->is_created = false;
-	arvif->ar = NULL;
 	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ab->free_vdev_map |= 1LL << arvif->vdev_id;
 	ab->free_vdev_stats_id_map &= ~(1LL << arvif->vdev_stats_id);
@@ -10470,6 +10468,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	spin_unlock_bh(&ar->data_lock);
 
 err:
+	arvif->is_created = false;
 	arvif->ar = NULL;
 	return ret;
 }
-- 
2.34.1


