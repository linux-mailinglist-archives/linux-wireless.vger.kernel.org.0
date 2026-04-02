Return-Path: <linux-wireless+bounces-34308-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNeaIjv7zWlYkAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34308-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 07:14:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF955383E30
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 07:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B6743018D60
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 05:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD4935959;
	Thu,  2 Apr 2026 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qd+fUoH/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LNWNAZ1f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5B2E3FE
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 05:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106872; cv=none; b=qgFt3mvllLjVmfwVHtPTZaujFEWni+ZlDbmNtFPS/YrUzswYRfLcOOzvbWtdTBoCJcjAf9FzwGIEi10NQsPwSNhXNye9486qoE/nWSpjbPzhvWZIB0kuY4lbkfNsd4pOrLM5//OvgV+Z9xz1daBuq+pD7Uqu0BQZm2dkLIXF+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106872; c=relaxed/simple;
	bh=L86Cg2tX0iWcu73CG88/kR6Q2xbYaYlUwhiaZDTGXNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K5NrWzq0oBpLcdNt+WXUql9ac3IToqg27stEIZCptuK2Fn2W3C/3yafitBrciQWdMM8tD+Bhfp/rxAuIZwwoHwKMYH5iSOCuOjp4I8rWpZRMWj0L27k3gK1kuN6E1kS3C3lEPUPl2RA6Vo2okIJWWFbbAbRNMnNbUTtm0cpKyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qd+fUoH/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LNWNAZ1f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M5PLW3958492
	for <linux-wireless@vger.kernel.org>; Thu, 2 Apr 2026 05:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ze9UmSNIj/3iPt4j8tPt2plfwrglInSEO+r
	/gtfPlXY=; b=Qd+fUoH/qYdoO6aGc0SGciYh4I755YmK6aFXsEV0MP04glZCRjO
	MkfgmlX4nvf/xt4YORjlQJaMJitWcjpkX4QqnNR4dTUICM6mQ6qjOh5WI++jwXh3
	DgQ8dgdCTshVWQ8R+eRLArLuKbnyn02fgKZIC1jWQXIkOWA7binrLXq0bvC7lSBz
	EtVs6kB+z+84ucNQb7GRyON3gGoyy0EcW8BjARGYB3OIZEG4Vz2agYbsmjmXaXqC
	HnXqy2wQawehR9jcSheHutg12/J0eTNJ3XGHpNH5xtW5Rx5KN/qDLrbP34/ROQka
	sU0yN9IIJtmC1h8Qf/DYAg+yzH54Dh3mPrQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9aw5hd90-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2026 05:14:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b242062308so12000005ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 22:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775106869; x=1775711669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ze9UmSNIj/3iPt4j8tPt2plfwrglInSEO+r/gtfPlXY=;
        b=LNWNAZ1fiW8Hk2IewfHer342ogkYcR9+5Hvn9KXhCdYIoHY6JOvQ/EqClN8ursxvwL
         SGj5uauOzE0x8zeCHjFmjLYfkv56m6IYL2TX/VmdP5spEkbkiV+GDfxbbZr0QUkBXHhE
         cYNf3e9xIf9jofnwJiRioL0insn4Yxd1wDqNDhLNaI6PDNkKbzZX7HnRQoVIB0Ip2Azt
         +nVHA79dG+pe999UypayUboDPxDIMvyjMvYrZ7m709ARj1OmEwkAH4wBjD+krSUvD/+0
         /l1049lkyWDdvCB6DkQoTILzMjkyZbkTvPsQH0Qr+ZA+PSfXJnH3dm/iUrxvxNef21Kw
         dt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775106869; x=1775711669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze9UmSNIj/3iPt4j8tPt2plfwrglInSEO+r/gtfPlXY=;
        b=F41SekqBQat4OF1QJqrHzI//N0Nk/62p8FbK2VzWdzyhplN/8t5EZ1io5ITHq3EqEY
         nsWrpw9UNCe7R5ENIU4qDRtofDiUj/sL+f5XnlKZzuGGUX1Vqqkpa9MXa+qAhny6yRPG
         ZWzWiCmM2mWw3eswM7lfq5Ga1AsbMuIUnQ1qZH3uqpFZ8opd4i4SubsY2LT2hfCh1+9z
         Wsj83egvUSt6+DTQQoNcnmIp/AfIFDrHxnWrTEZy1R2daZxzGRjVoTAum4cPO7S1RAt9
         AdbMlAVmveSk1MEABdjG6flsHtbgqn2kiy1+w2V6yGX19ssEb5QGBZfa6+0IvZuqo8HD
         9yYw==
X-Gm-Message-State: AOJu0YyL/4RlSNhxEuPc9AeuPOxJzPfriaKWSOJZRi1/ytslSLHwGZmq
	MMEkD3n/CS8EDJtbarIEluG9/oXRepiJIYgI6gEK4FqnZdSfkksB9NgqzoJK0Edrs9qDp4LbR3Z
	WP4naRam7ePv5fGBGyu7UpSadxKYBiRzWcib7IB1snQXOmFMhCfumn93wuVrB7JAwUOpT/mZ+Jc
	M5tQ==
X-Gm-Gg: AeBDievP1WLElaWd1WzIzpoNMYk1Nk7XE//hDJca3+QMP1fP1zTUVmKifuhb1xidaJJ
	m8kFlWBxzNIVwdvShEmVTZvyYj38XDJ88ronmtMIiqGtSejK5Cv9sew89CmURRWj+q+xxsdORIU
	nCfMdoH4Idls12GACuP2FzKA6yCHIzpYm301jkCS2dXpji90o+ZE4qPfgJiVbScbgk0Y0PnEydV
	AdMv4TiIsEoQ7XGZzPoIx0ZE0by7F40P383ZnI8zY+WgMzlLtVddAhwxaZPpuP2U5pM8S7xInax
	yObDPhVEyt9rGcaj3tfk8t3hYRf50g1wIaz0KvqESizb/73UMvae57sP7uQx1qGO339rP1hCeQT
	VltNhpX6nlGXDHjugX0OtjuuEeeusi3mmVkQl3DvzHHvaA7YKPZ3BiJlEeRdcDWn0c6gHSK5m2E
	U+k51Kj2V2I0mMqLpcu4hKLOSfuelNPT7qvH7hufh3FM2Xg8Wb
X-Received: by 2002:a17:903:38d0:b0:2b0:59fd:bbe5 with SMTP id d9443c01a7336-2b27586171dmr20050545ad.4.1775106868791;
        Wed, 01 Apr 2026 22:14:28 -0700 (PDT)
X-Received: by 2002:a17:903:38d0:b0:2b0:59fd:bbe5 with SMTP id d9443c01a7336-2b27586171dmr20050245ad.4.1775106868152;
        Wed, 01 Apr 2026 22:14:28 -0700 (PDT)
Received: from hu-rdevanat-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749ecbd1sm19441755ad.83.2026.04.01.22.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:14:27 -0700 (PDT)
From: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        Harshitha Prem <harshitha.prem@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Create symlink for each radio in a wiphy
Date: Thu,  2 Apr 2026 10:44:02 +0530
Message-Id: <20260402051402.3903795-1-roopni.devanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Q9jfIo2a c=1 sm=1 tr=0 ts=69cdfb36 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=jmIJ6Y7K9lkSVFxMRE0A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: D0znsq1WWkC_UeY1CDHJH6Ah2V1VlzJg
X-Proofpoint-ORIG-GUID: D0znsq1WWkC_UeY1CDHJH6Ah2V1VlzJg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0MyBTYWx0ZWRfX4amjqiN+xk2l
 nM5SYB6aOmSCcQhZQ/mZ4DmOz+sgle1hkAeZmAwx9KOLg7ORdaPHOsWXkT7DxsJruqH9ra8fU3c
 dlD5a2ufC89E2qK7OevLen2UjSsB51wJUyNbNHzvxk8l0CUrbLSVPAxW1VNRSaJ4AwosWv52XgU
 eH/AoWfbs9fLwaubFR/+mFU/0JmAaqSP8+5EczYHYS9zsjG4eTLZTDH1zAKQ+WmCTlYl+TkyVxr
 6ip7+gccqY2nzGrOT29dlLWAwxjXCTfxYmlIlEvntxbtxZ1Lrg79pPd5MWO113s5v2yc2xDfp2u
 OoyVjy61va83TUBpuaAm3JC8CcEu126F4gz7c3fxFGvG4y843UCS3omLINx7MK1S3YTn2uoNbEf
 sCn+Eb7SS8lH5jWP1cztKXKIxjzZMxzja/t/srBsxzCxK5Dez91+9Dspy8dY1jot2HZODo1WN9n
 uSRWTKggMNTOB71XrNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020043
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34308-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[roopni.devanathan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF955383E30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In single-wiphy design, when more than one radio is registered as a
single-wiphy in the mac80211 layer, the following warnings are seen:

1. debugfs: File 'ath12k' in directory 'phy0' already present!
2. debugfs: File 'simulate_fw_crash' in directory 'pci-0000:57:00.0' already present!
   debugfs: File 'device_dp_stats' in directory 'pci-01777777777777777777777:57:00.0' already present!

When more than one radio is registered as a single-wiphy, symlinks for
all the radios are created in the same debugfs directory:
/sys/kernel/debug/ieee80211/phyX/ath12k, resulting in warning 1. When a
symlink is created for the first radio, since the 'ath12k' directory is
not present, it will be created and no warning will be thrown. But when
symlink is created for more than one radio, since the 'ath12k'
directory was already created for symlink for radio 1, a warning is
thrown complaining that 'ath12k' directory is already present. To resolve
warning 1, create symlink for each radio in separate debugfs directories.
For the first radio, the symlink will always be the 'ath12k' directory.
This ensures that the existing directory structure is retained for
single-wiphy and multi-wiphy architectures. In single-wiphy architecture
with multiple radios, create symlink in separate debugfs directories
introduced by mac80211.

Existing debugfs directory in single-wiphy architecture:
/sys/kernel/debug/ieee80211/phyX/ath12k is a symlink to
/sys/kernel/debug/ath12k/pci-0001:01:00.0/macY

Proposed debugfs directory in single-wiphy architecture with one radio:
/sys/kernel/debug/ieee80211/phyX/ath12k is a symlink to
/sys/kernel/debug/ath12k/pci-0001:01:00.0/mac0

Proposed debugfs directory in single-wiphy architecture with more than
one radio:
/sys/kernel/debug/ieee80211/phyX/radio0/ath12k is a symlink to
/sys/kernel/debug/ath12k/pci-0001:01:00.0/mac0 and
/sys/kernel/debug/ieee80211/phyX/radioY/ath12k is a symlink to
/sys/kernel/debug/ath12k/pci-0001:01:00.0/macY

Where X is phy index and Y is radio index, seen in
'iw phyX info | grep Idx'. Two symlinks for the first radio are to ensure
compatibility with the existing design. Add radio_idx inside ar, to track
the radio index in probing order.

API ath12k_debugfs_pdev_create() that creates SoC entries is called more
than once when hardware group starts up, resulting in warning 2. To
resolve this warning, remove all other calls to this API and add one
inside the ath12k_core_pdev_create(). This API carries all pdev-specific
initializations and can conveniently hold a call to
ath12k_debugfs_pdev_create().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: Harshitha Prem <harshitha.prem@oss.qualcomm.com>
Signed-off-by: Harshitha Prem <harshitha.prem@oss.qualcomm.com>
Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c    |  4 ++--
 drivers/net/wireless/ath/ath12k/core.h    |  2 ++
 drivers/net/wireless/ath/ath12k/debugfs.c | 29 +++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.c     |  2 +-
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index c31c47fb5a73..2519e2400d58 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -835,8 +835,6 @@ static int ath12k_core_soc_create(struct ath12k_base *ab)
 		goto err_qmi_deinit;
 	}
 
-	ath12k_debugfs_pdev_create(ab);
-
 	return 0;
 
 err_qmi_deinit:
@@ -869,6 +867,8 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
 		goto err_dp_pdev_free;
 	}
 
+	ath12k_debugfs_pdev_create(ab);
+
 	return 0;
 
 err_dp_pdev_free:
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 59c193b24764..046249c8763e 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -588,6 +588,7 @@ struct ath12k_dbg_htt_stats {
 struct ath12k_debug {
 	struct dentry *debugfs_pdev;
 	struct dentry *debugfs_pdev_symlink;
+	struct dentry *debugfs_pdev_symlink_default;
 	struct ath12k_dbg_htt_stats htt_stats;
 	enum wmi_halphy_ctrl_path_stats_id tpc_stats_type;
 	bool tpc_request;
@@ -673,6 +674,7 @@ struct ath12k {
 	u8 pdev_idx;
 	u8 lmac_id;
 	u8 hw_link_id;
+	u8 radio_idx;
 
 	struct completion peer_assoc_done;
 	struct completion peer_delete_done;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 358031fa14eb..8c81a1c22449 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1473,18 +1473,35 @@ void ath12k_debugfs_register(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hw *hw = ar->ah->hw;
-	char pdev_name[5];
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct dentry *ath12k_fs;
 	char buf[100] = {};
+	char pdev_name[5];
 
 	scnprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
 
 	ar->debug.debugfs_pdev = debugfs_create_dir(pdev_name, ab->debugfs_soc);
 
 	/* Create a symlink under ieee80211/phy* */
-	scnprintf(buf, sizeof(buf), "../../ath12k/%pd2", ar->debug.debugfs_pdev);
-	ar->debug.debugfs_pdev_symlink = debugfs_create_symlink("ath12k",
-								hw->wiphy->debugfsdir,
-								buf);
+	if (ar->radio_idx == 0) {
+		scnprintf(buf, sizeof(buf), "../../ath12k/%pd2",
+			  ar->debug.debugfs_pdev);
+		ath12k_fs = hw->wiphy->debugfsdir;
+
+		/* symbolic link for compatibility */
+		ar->debug.debugfs_pdev_symlink_default = debugfs_create_symlink("ath12k",
+										ath12k_fs,
+										buf);
+	}
+
+	if (ah->num_radio > 1) {
+		scnprintf(buf, sizeof(buf), "../../../ath12k/%pd2",
+			  ar->debug.debugfs_pdev);
+		ath12k_fs = hw->wiphy->radio_cfg[ar->radio_idx].radio_debugfsdir;
+		ar->debug.debugfs_pdev_symlink = debugfs_create_symlink("ath12k",
+									ath12k_fs,
+									buf);
+	}
 
 	if (ar->mac.sbands[NL80211_BAND_5GHZ].channels) {
 		debugfs_create_file("dfs_simulate_radar", 0200,
@@ -1513,7 +1530,9 @@ void ath12k_debugfs_unregister(struct ath12k *ar)
 
 	/* Remove symlink under ieee80211/phy* */
 	debugfs_remove(ar->debug.debugfs_pdev_symlink);
+	debugfs_remove(ar->debug.debugfs_pdev_symlink_default);
 	debugfs_remove_recursive(ar->debug.debugfs_pdev);
 	ar->debug.debugfs_pdev_symlink = NULL;
+	ar->debug.debugfs_pdev_symlink_default = NULL;
 	ar->debug.debugfs_pdev = NULL;
 }
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 553ec28b6aaa..c2b747f1b9f5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -15065,6 +15065,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_hw_group *ag,
 		ar->hw_link_id = pdev->hw_link_id;
 		ar->pdev = pdev;
 		ar->pdev_idx = pdev_idx;
+		ar->radio_idx = i;
 		pdev->ar = ar;
 
 		ag->hw_links[ar->hw_link_id].device_id = ab->device_id;
@@ -15132,7 +15133,6 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 		if (!ab)
 			continue;
 
-		ath12k_debugfs_pdev_create(ab);
 		ath12k_mac_set_device_defaults(ab);
 		total_radio += ab->num_radios;
 	}

base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
-- 
2.43.0


