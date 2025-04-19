Return-Path: <linux-wireless+bounces-21752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA4A94240
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 10:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13118A2852
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Apr 2025 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE021AAA1E;
	Sat, 19 Apr 2025 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fY2PUlNv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5341A254C;
	Sat, 19 Apr 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745051394; cv=none; b=ODCSrVqJu4EErddPA+2n2hqXrWiBxPV+wG9VdWsmys1tImUBsre9iwfXgOnOhsvsMLn0/6+M04gAhdS3j4wYzvGXvtuDz/5y44ZPSorVAH8VLQxYc1crUeC+7YjvHxgv1Kw+BFcQTgCeg8baGRZRRM5zO0Ob1aSoZIOp8fxfokU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745051394; c=relaxed/simple;
	bh=gAscmcKNfnO0N3FLcOUQMab5Im0Tp2Z3a7oR01znvBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLfJnWpr50lbGvbig6dvlfeFl/kEuldb8ppD6aiIlKuQ8Smm+F4HRcdavd8TDQ2PkSzUW1mf5DIB2wuSMPZ4q5PuT1PzV1oI3f9xKjVoQVC1wspX6AqtlvObDdDQxvdcaOVeG6XG74jTLnLgn7YT76RQV1Nq0u+E1U4I4rqhJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fY2PUlNv; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 63ZxueZLbiSFB63a0u9oRv; Sat, 19 Apr 2025 10:29:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745051382;
	bh=QZ0M3YULwiTEHZp44mqFeUb6ZMxl5OzqThY94fuFEgw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fY2PUlNvMrebWHzDO3fXFKroyOGgqOjTtytwkM9ZrkUXLZxilpMrNhnckVOrhleI0
	 Xzvy+l/pDjuC74rEun5NefeZA+OXOxBSGy9+6DFu5snE3IGpyAJCVXry5AcM/eEbvQ
	 W8OHJ5AIt1TEzDZyWYJkJFm6Qp715JRoNqsovcfs/b/rtAHs8/IkoqN1jW5Txh+OUU
	 JlxG81w8mzYatxJzzdWutT5b0ai4vnYGhGmvgsub30CIJ3hwcJMMHY7jk6ovfdOzaC
	 KLowhTdpTizoPsNcmKgmIZ9vgijQxd/Qe3qmRCyhTpU9TpFZsW4U3uuHk9veuLRMJG
	 kecF+pAd6QQmQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Apr 2025 10:29:42 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org
Subject: [PATCH] wifi: ath10k: Constify structures in hw.c
Date: Sat, 19 Apr 2025 10:29:17 +0200
Message-ID: <504b4d5276d13f5f9c3bffcfdaf244006312c22b.1745051315.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Structures defined in hw.c are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  10357	    951	      0	  11308	   2c2c	drivers/net/wireless/ath/ath10k/hw.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  11125	    203	      0	  11328	   2c40	drivers/net/wireless/ath/ath10k/hw.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
---
 drivers/net/wireless/ath/ath10k/ce.c | 28 ++++++-------
 drivers/net/wireless/ath/ath10k/hw.c | 62 ++++++++++++++--------------
 drivers/net/wireless/ath/ath10k/hw.h | 34 ++++++++-------
 3 files changed, 64 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index afae4a8027f8..c6ee0cbb58e2 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -80,7 +80,7 @@ static inline u32 shadow_sr_wr_ind_addr(struct ath10k *ar,
 
 static inline unsigned int
 ath10k_set_ring_byte(unsigned int offset,
-		     struct ath10k_hw_ce_regs_addr_map *addr_map)
+		     const struct ath10k_hw_ce_regs_addr_map *addr_map)
 {
 	return ((offset << addr_map->lsb) & addr_map->mask);
 }
@@ -203,7 +203,7 @@ static inline void ath10k_ce_src_ring_dmax_set(struct ath10k *ar,
 					       u32 ce_ctrl_addr,
 					       unsigned int n)
 {
-	struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
+	const struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
 
 	u32 ctrl1_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
 					  ctrl_regs->addr);
@@ -217,7 +217,7 @@ static inline void ath10k_ce_src_ring_byte_swap_set(struct ath10k *ar,
 						    u32 ce_ctrl_addr,
 						    unsigned int n)
 {
-	struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
+	const struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
 
 	u32 ctrl1_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
 					  ctrl_regs->addr);
@@ -231,7 +231,7 @@ static inline void ath10k_ce_dest_ring_byte_swap_set(struct ath10k *ar,
 						     u32 ce_ctrl_addr,
 						     unsigned int n)
 {
-	struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
+	const struct ath10k_hw_ce_ctrl1 *ctrl_regs = ar->hw_ce_regs->ctrl1_regs;
 
 	u32 ctrl1_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
 					  ctrl_regs->addr);
@@ -313,7 +313,7 @@ static inline void ath10k_ce_src_ring_highmark_set(struct ath10k *ar,
 						   u32 ce_ctrl_addr,
 						   unsigned int n)
 {
-	struct ath10k_hw_ce_dst_src_wm_regs *srcr_wm = ar->hw_ce_regs->wm_srcr;
+	const struct ath10k_hw_ce_dst_src_wm_regs *srcr_wm = ar->hw_ce_regs->wm_srcr;
 	u32 addr = ath10k_ce_read32(ar, ce_ctrl_addr + srcr_wm->addr);
 
 	ath10k_ce_write32(ar, ce_ctrl_addr + srcr_wm->addr,
@@ -325,7 +325,7 @@ static inline void ath10k_ce_src_ring_lowmark_set(struct ath10k *ar,
 						  u32 ce_ctrl_addr,
 						  unsigned int n)
 {
-	struct ath10k_hw_ce_dst_src_wm_regs *srcr_wm = ar->hw_ce_regs->wm_srcr;
+	const struct ath10k_hw_ce_dst_src_wm_regs *srcr_wm = ar->hw_ce_regs->wm_srcr;
 	u32 addr = ath10k_ce_read32(ar, ce_ctrl_addr + srcr_wm->addr);
 
 	ath10k_ce_write32(ar, ce_ctrl_addr + srcr_wm->addr,
@@ -337,7 +337,7 @@ static inline void ath10k_ce_dest_ring_highmark_set(struct ath10k *ar,
 						    u32 ce_ctrl_addr,
 						    unsigned int n)
 {
-	struct ath10k_hw_ce_dst_src_wm_regs *dstr_wm = ar->hw_ce_regs->wm_dstr;
+	const struct ath10k_hw_ce_dst_src_wm_regs *dstr_wm = ar->hw_ce_regs->wm_dstr;
 	u32 addr = ath10k_ce_read32(ar, ce_ctrl_addr + dstr_wm->addr);
 
 	ath10k_ce_write32(ar, ce_ctrl_addr + dstr_wm->addr,
@@ -349,7 +349,7 @@ static inline void ath10k_ce_dest_ring_lowmark_set(struct ath10k *ar,
 						   u32 ce_ctrl_addr,
 						   unsigned int n)
 {
-	struct ath10k_hw_ce_dst_src_wm_regs *dstr_wm = ar->hw_ce_regs->wm_dstr;
+	const struct ath10k_hw_ce_dst_src_wm_regs *dstr_wm = ar->hw_ce_regs->wm_dstr;
 	u32 addr = ath10k_ce_read32(ar, ce_ctrl_addr + dstr_wm->addr);
 
 	ath10k_ce_write32(ar, ce_ctrl_addr + dstr_wm->addr,
@@ -360,7 +360,7 @@ static inline void ath10k_ce_dest_ring_lowmark_set(struct ath10k *ar,
 static inline void ath10k_ce_copy_complete_inter_enable(struct ath10k *ar,
 							u32 ce_ctrl_addr)
 {
-	struct ath10k_hw_ce_host_ie *host_ie = ar->hw_ce_regs->host_ie;
+	const struct ath10k_hw_ce_host_ie *host_ie = ar->hw_ce_regs->host_ie;
 
 	u32 host_ie_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
 					    ar->hw_ce_regs->host_ie_addr);
@@ -372,7 +372,7 @@ static inline void ath10k_ce_copy_complete_inter_enable(struct ath10k *ar,
 static inline void ath10k_ce_copy_complete_intr_disable(struct ath10k *ar,
 							u32 ce_ctrl_addr)
 {
-	struct ath10k_hw_ce_host_ie *host_ie = ar->hw_ce_regs->host_ie;
+	const struct ath10k_hw_ce_host_ie *host_ie = ar->hw_ce_regs->host_ie;
 
 	u32 host_ie_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
 					    ar->hw_ce_regs->host_ie_addr);
@@ -384,7 +384,7 @@ static inline void ath10k_ce_copy_complete_intr_disable(struct ath10k *ar,
 static inline void ath10k_ce_watermark_intr_disable(struct ath10k *ar,
 						    u32 ce_ctrl_addr)
 {
-	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
+	const struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
 
 	u32 host_ie_addr = ath10k_ce_read32(ar, ce_ctrl_addr +
 					    ar->hw_ce_regs->host_ie_addr);
@@ -396,7 +396,7 @@ static inline void ath10k_ce_watermark_intr_disable(struct ath10k *ar,
 static inline void ath10k_ce_error_intr_disable(struct ath10k *ar,
 						u32 ce_ctrl_addr)
 {
-	struct ath10k_hw_ce_misc_regs *misc_regs = ar->hw_ce_regs->misc_regs;
+	const struct ath10k_hw_ce_misc_regs *misc_regs = ar->hw_ce_regs->misc_regs;
 
 	u32 misc_ie_addr = ath10k_ce_read32(ar,
 			ce_ctrl_addr + ar->hw_ce_regs->misc_ie_addr);
@@ -410,7 +410,7 @@ static inline void ath10k_ce_engine_int_status_clear(struct ath10k *ar,
 						     u32 ce_ctrl_addr,
 						     unsigned int mask)
 {
-	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
+	const struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
 
 	ath10k_ce_write32(ar, ce_ctrl_addr + wm_regs->addr, mask);
 }
@@ -1230,7 +1230,7 @@ void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id)
 {
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
-	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
+	const struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
 	u32 ctrl_addr = ce_state->ctrl_addr;
 
 	/*
diff --git a/drivers/net/wireless/ath/ath10k/hw.c b/drivers/net/wireless/ath/ath10k/hw.c
index 8fafe096adff..84b35a22fc23 100644
--- a/drivers/net/wireless/ath/ath10k/hw.c
+++ b/drivers/net/wireless/ath/ath10k/hw.c
@@ -212,40 +212,40 @@ const struct ath10k_hw_regs wcn3990_regs = {
 	.pcie_intr_fw_mask			= 0x00100000,
 };
 
-static struct ath10k_hw_ce_regs_addr_map wcn3990_src_ring = {
+static const struct ath10k_hw_ce_regs_addr_map wcn3990_src_ring = {
 	.msb	= 0x00000010,
 	.lsb	= 0x00000010,
 	.mask	= GENMASK(17, 17),
 };
 
-static struct ath10k_hw_ce_regs_addr_map wcn3990_dst_ring = {
+static const struct ath10k_hw_ce_regs_addr_map wcn3990_dst_ring = {
 	.msb	= 0x00000012,
 	.lsb	= 0x00000012,
 	.mask	= GENMASK(18, 18),
 };
 
-static struct ath10k_hw_ce_regs_addr_map wcn3990_dmax = {
+static const struct ath10k_hw_ce_regs_addr_map wcn3990_dmax = {
 	.msb	= 0x00000000,
 	.lsb	= 0x00000000,
 	.mask	= GENMASK(15, 0),
 };
 
-static struct ath10k_hw_ce_ctrl1 wcn3990_ctrl1 = {
+static const struct ath10k_hw_ce_ctrl1 wcn3990_ctrl1 = {
 	.addr		= 0x00000018,
 	.src_ring	= &wcn3990_src_ring,
 	.dst_ring	= &wcn3990_dst_ring,
 	.dmax		= &wcn3990_dmax,
 };
 
-static struct ath10k_hw_ce_regs_addr_map wcn3990_host_ie_cc = {
+static const struct ath10k_hw_ce_regs_addr_map wcn3990_host_ie_cc = {
 	.mask	= GENMASK(0, 0),
 };
 
-static struct ath10k_hw_ce_host_ie wcn3990_host_ie = {
+static const struct ath10k_hw_ce_host_ie wcn3990_host_ie = {
 	.copy_complete	= &wcn3990_host_ie_cc,
 };
 
-static struct ath10k_hw_ce_host_wm_regs wcn3990_wm_reg = {
+static const struct ath10k_hw_ce_host_wm_regs wcn3990_wm_reg = {
 	.dstr_lmask	= 0x00000010,
 	.dstr_hmask	= 0x00000008,
 	.srcr_lmask	= 0x00000004,
@@ -255,7 +255,7 @@ static struct ath10k_hw_ce_host_wm_regs wcn3990_wm_reg = {
 	.addr		= 0x00000030,
 };
 
-static struct ath10k_hw_ce_misc_regs wcn3990_misc_reg = {
+static const struct ath10k_hw_ce_misc_regs wcn3990_misc_reg = {
 	.axi_err	= 0x00000100,
 	.dstr_add_err	= 0x00000200,
 	.srcr_len_err	= 0x00000100,
@@ -266,19 +266,19 @@ static struct ath10k_hw_ce_misc_regs wcn3990_misc_reg = {
 	.addr		= 0x00000038,
 };
 
-static struct ath10k_hw_ce_regs_addr_map wcn3990_src_wm_low = {
+static const struct ath10k_hw_ce_regs_addr_map wcn3990_src_wm_low = {
 	.msb	= 0x00000000,
 	.lsb	= 0x00000010,
 	.mask	= GENMASK(31, 16),
 };
 
-static struct ath10k_hw_ce_regs_addr_map wcn3990_src_wm_high = {
+static const struct ath10k_hw_ce_regs_addr_map wcn3990_src_wm_high = {
 	.msb	= 0x0000000f,
 	.lsb	= 0x00000000,
 	.mask	= GENMASK(15, 0),
 };
 
-static struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_src_ring = {
+static const struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_src_ring = {
 	.addr		= 0x0000004c,
 	.low_rst	= 0x00000000,
 	.high_rst	= 0x00000000,
@@ -286,18 +286,18 @@ static struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_src_ring = {
 	.wm_high	= &wcn3990_src_wm_high,
 };
 
-static struct ath10k_hw_ce_regs_addr_map wcn3990_dst_wm_low = {
+static const struct ath10k_hw_ce_regs_addr_map wcn3990_dst_wm_low = {
 	.lsb	= 0x00000010,
 	.mask	= GENMASK(31, 16),
 };
 
-static struct ath10k_hw_ce_regs_addr_map wcn3990_dst_wm_high = {
+static const struct ath10k_hw_ce_regs_addr_map wcn3990_dst_wm_high = {
 	.msb	= 0x0000000f,
 	.lsb	= 0x00000000,
 	.mask	= GENMASK(15, 0),
 };
 
-static struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_dst_ring = {
+static const struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_dst_ring = {
 	.addr		= 0x00000050,
 	.low_rst	= 0x00000000,
 	.high_rst	= 0x00000000,
@@ -305,7 +305,7 @@ static struct ath10k_hw_ce_dst_src_wm_regs wcn3990_wm_dst_ring = {
 	.wm_high	= &wcn3990_dst_wm_high,
 };
 
-static struct ath10k_hw_ce_ctrl1_upd wcn3990_ctrl1_upd = {
+static const struct ath10k_hw_ce_ctrl1_upd wcn3990_ctrl1_upd = {
 	.shift = 19,
 	.mask = 0x00080000,
 	.enable = 0x00000000,
@@ -344,25 +344,25 @@ const struct ath10k_hw_values wcn3990_values = {
 	.ce_desc_meta_data_lsb		= 4,
 };
 
-static struct ath10k_hw_ce_regs_addr_map qcax_src_ring = {
+static const struct ath10k_hw_ce_regs_addr_map qcax_src_ring = {
 	.msb	= 0x00000010,
 	.lsb	= 0x00000010,
 	.mask	= GENMASK(16, 16),
 };
 
-static struct ath10k_hw_ce_regs_addr_map qcax_dst_ring = {
+static const struct ath10k_hw_ce_regs_addr_map qcax_dst_ring = {
 	.msb	= 0x00000011,
 	.lsb	= 0x00000011,
 	.mask	= GENMASK(17, 17),
 };
 
-static struct ath10k_hw_ce_regs_addr_map qcax_dmax = {
+static const struct ath10k_hw_ce_regs_addr_map qcax_dmax = {
 	.msb	= 0x0000000f,
 	.lsb	= 0x00000000,
 	.mask	= GENMASK(15, 0),
 };
 
-static struct ath10k_hw_ce_ctrl1 qcax_ctrl1 = {
+static const struct ath10k_hw_ce_ctrl1 qcax_ctrl1 = {
 	.addr		= 0x00000010,
 	.hw_mask	= 0x0007ffff,
 	.sw_mask	= 0x0007ffff,
@@ -375,31 +375,31 @@ static struct ath10k_hw_ce_ctrl1 qcax_ctrl1 = {
 	.dmax		= &qcax_dmax,
 };
 
-static struct ath10k_hw_ce_regs_addr_map qcax_cmd_halt_status = {
+static const struct ath10k_hw_ce_regs_addr_map qcax_cmd_halt_status = {
 	.msb	= 0x00000003,
 	.lsb	= 0x00000003,
 	.mask	= GENMASK(3, 3),
 };
 
-static struct ath10k_hw_ce_cmd_halt qcax_cmd_halt = {
+static const struct ath10k_hw_ce_cmd_halt qcax_cmd_halt = {
 	.msb		= 0x00000000,
 	.mask		= GENMASK(0, 0),
 	.status_reset	= 0x00000000,
 	.status		= &qcax_cmd_halt_status,
 };
 
-static struct ath10k_hw_ce_regs_addr_map qcax_host_ie_cc = {
+static const struct ath10k_hw_ce_regs_addr_map qcax_host_ie_cc = {
 	.msb	= 0x00000000,
 	.lsb	= 0x00000000,
 	.mask	= GENMASK(0, 0),
 };
 
-static struct ath10k_hw_ce_host_ie qcax_host_ie = {
+static const struct ath10k_hw_ce_host_ie qcax_host_ie = {
 	.copy_complete_reset	= 0x00000000,
 	.copy_complete		= &qcax_host_ie_cc,
 };
 
-static struct ath10k_hw_ce_host_wm_regs qcax_wm_reg = {
+static const struct ath10k_hw_ce_host_wm_regs qcax_wm_reg = {
 	.dstr_lmask	= 0x00000010,
 	.dstr_hmask	= 0x00000008,
 	.srcr_lmask	= 0x00000004,
@@ -409,7 +409,7 @@ static struct ath10k_hw_ce_host_wm_regs qcax_wm_reg = {
 	.addr		= 0x00000030,
 };
 
-static struct ath10k_hw_ce_misc_regs qcax_misc_reg = {
+static const struct ath10k_hw_ce_misc_regs qcax_misc_reg = {
 	.axi_err	= 0x00000400,
 	.dstr_add_err	= 0x00000200,
 	.srcr_len_err	= 0x00000100,
@@ -420,19 +420,19 @@ static struct ath10k_hw_ce_misc_regs qcax_misc_reg = {
 	.addr		= 0x00000038,
 };
 
-static struct ath10k_hw_ce_regs_addr_map qcax_src_wm_low = {
+static const struct ath10k_hw_ce_regs_addr_map qcax_src_wm_low = {
 	.msb    = 0x0000001f,
 	.lsb	= 0x00000010,
 	.mask	= GENMASK(31, 16),
 };
 
-static struct ath10k_hw_ce_regs_addr_map qcax_src_wm_high = {
+static const struct ath10k_hw_ce_regs_addr_map qcax_src_wm_high = {
 	.msb	= 0x0000000f,
 	.lsb	= 0x00000000,
 	.mask	= GENMASK(15, 0),
 };
 
-static struct ath10k_hw_ce_dst_src_wm_regs qcax_wm_src_ring = {
+static const struct ath10k_hw_ce_dst_src_wm_regs qcax_wm_src_ring = {
 	.addr		= 0x0000004c,
 	.low_rst	= 0x00000000,
 	.high_rst	= 0x00000000,
@@ -440,18 +440,18 @@ static struct ath10k_hw_ce_dst_src_wm_regs qcax_wm_src_ring = {
 	.wm_high        = &qcax_src_wm_high,
 };
 
-static struct ath10k_hw_ce_regs_addr_map qcax_dst_wm_low = {
+static const struct ath10k_hw_ce_regs_addr_map qcax_dst_wm_low = {
 	.lsb	= 0x00000010,
 	.mask	= GENMASK(31, 16),
 };
 
-static struct ath10k_hw_ce_regs_addr_map qcax_dst_wm_high = {
+static const struct ath10k_hw_ce_regs_addr_map qcax_dst_wm_high = {
 	.msb	= 0x0000000f,
 	.lsb	= 0x00000000,
 	.mask	= GENMASK(15, 0),
 };
 
-static struct ath10k_hw_ce_dst_src_wm_regs qcax_wm_dst_ring = {
+static const struct ath10k_hw_ce_dst_src_wm_regs qcax_wm_dst_ring = {
 	.addr		= 0x00000050,
 	.low_rst	= 0x00000000,
 	.high_rst	= 0x00000000,
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 442091c6dfd2..7ffa1fbe2874 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -289,19 +289,22 @@ struct ath10k_hw_ce_ctrl1 {
 	u32 sw_wr_mask;
 	u32 reset_mask;
 	u32 reset;
-	struct ath10k_hw_ce_regs_addr_map *src_ring;
-	struct ath10k_hw_ce_regs_addr_map *dst_ring;
-	struct ath10k_hw_ce_regs_addr_map *dmax; };
+	const struct ath10k_hw_ce_regs_addr_map *src_ring;
+	const struct ath10k_hw_ce_regs_addr_map *dst_ring;
+	const struct ath10k_hw_ce_regs_addr_map *dmax;
+};
 
 struct ath10k_hw_ce_cmd_halt {
 	u32 status_reset;
 	u32 msb;
 	u32 mask;
-	struct ath10k_hw_ce_regs_addr_map *status; };
+	const struct ath10k_hw_ce_regs_addr_map *status;
+};
 
 struct ath10k_hw_ce_host_ie {
 	u32 copy_complete_reset;
-	struct ath10k_hw_ce_regs_addr_map *copy_complete; };
+	const struct ath10k_hw_ce_regs_addr_map *copy_complete;
+};
 
 struct ath10k_hw_ce_host_wm_regs {
 	u32 dstr_lmask;
@@ -328,8 +331,9 @@ struct ath10k_hw_ce_dst_src_wm_regs {
 	u32 addr;
 	u32 low_rst;
 	u32 high_rst;
-	struct ath10k_hw_ce_regs_addr_map *wm_low;
-	struct ath10k_hw_ce_regs_addr_map *wm_high; };
+	const struct ath10k_hw_ce_regs_addr_map *wm_low;
+	const struct ath10k_hw_ce_regs_addr_map *wm_high;
+};
 
 struct ath10k_hw_ce_ctrl1_upd {
 	u32 shift;
@@ -355,14 +359,14 @@ struct ath10k_hw_ce_regs {
 	u32 ce_rri_low;
 	u32 ce_rri_high;
 	u32 host_ie_addr;
-	struct ath10k_hw_ce_host_wm_regs *wm_regs;
-	struct ath10k_hw_ce_misc_regs *misc_regs;
-	struct ath10k_hw_ce_ctrl1 *ctrl1_regs;
-	struct ath10k_hw_ce_cmd_halt *cmd_halt;
-	struct ath10k_hw_ce_host_ie *host_ie;
-	struct ath10k_hw_ce_dst_src_wm_regs *wm_srcr;
-	struct ath10k_hw_ce_dst_src_wm_regs *wm_dstr;
-	struct ath10k_hw_ce_ctrl1_upd *upd;
+	const struct ath10k_hw_ce_host_wm_regs *wm_regs;
+	const struct ath10k_hw_ce_misc_regs *misc_regs;
+	const struct ath10k_hw_ce_ctrl1 *ctrl1_regs;
+	const struct ath10k_hw_ce_cmd_halt *cmd_halt;
+	const struct ath10k_hw_ce_host_ie *host_ie;
+	const struct ath10k_hw_ce_dst_src_wm_regs *wm_srcr;
+	const struct ath10k_hw_ce_dst_src_wm_regs *wm_dstr;
+	const struct ath10k_hw_ce_ctrl1_upd *upd;
 };
 
 struct ath10k_hw_values {
-- 
2.49.0


