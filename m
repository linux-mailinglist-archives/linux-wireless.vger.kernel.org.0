Return-Path: <linux-wireless+bounces-22691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E164AACE41
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684D21C253AC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FD01F582E;
	Tue,  6 May 2025 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Cv9L8gwB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400531DED60
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560584; cv=none; b=QS24/3VISf2LeledNWQelmiy+Rk9NY9to9mvPJqljHkNCzJs79bA5B9onyMLbo6be2EIME9Dk6g93bLgsn8AseCsZ34ikNaWujv5qSDrJXrMTagXBqaellX/tVsjbsub2g9DSpnZrspbBp2wBmxwXCzfjgpCii6XN47hVhnkVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560584; c=relaxed/simple;
	bh=4/ZPAPrZutoNbRRnih9zR9SMlxucZ4vxksHVgFMl82k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEHS5bZ7DRsL23JJoaR3zkBC1w+m17OVQTaUYmycoJMYQLDQ7bV1EboZcywTNgPJoA+0bvgOpP0ne29HLBcxP1AYwznisST2OnD1fTlwZurx+4CKxahfb7JGR+L/MWNzb6QtbTJq9f8gAWhz1vouDIqkJtAisMSWZrIEXzSUH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Cv9L8gwB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=xjIUekjNJLkZ40QcpOFB/hP4wN9D7yjwdP5LMCsNoFI=; t=1746560583; x=1747770183; 
	b=Cv9L8gwBEssD/Mgb+izLa6uF3b2CPjrmEOslkgk3Tfr4Xc7HAKLUGdJdRpyP6eCnTequXnXKIJ7
	bu58ynQtwOC02tQpoIrhCRccYWi0XXdfSuMen+0cGXwD64bCaRijVTBmi652Aq+YwSswpOMGmhy0Z
	mY0mIlIUMGvcaBxW4bI3bh5jd632IWcD72FPqCE6IG6eE9f7jwCuQRru4+GESIFbidKJwDk5kuT+b
	UmF8hmrLiUyrYV0WcxBbKRUblzMDRt6mxPJUyYD8Rliy+GoVoC7hy2rasDmIBji0p0jjFcQlCP8Oi
	cTNdw6G6l6XhbH+31csqRyqvMRGl7DxHDzFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCOBw-00000006KMD-0CW4;
	Tue, 06 May 2025 21:43:00 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: iwlwifi: add support for Killer on MTL
Date: Tue,  6 May 2025 21:42:59 +0200
Message-ID: <20250506214258.2efbdc9e9a82.I31915ec252bd1c74bd53b89a0e214e42a74b6f2e@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For now, we need another entry for these devices, this
will be changed completely for 6.16.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219926
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index debeea2b3ae5..00056e76ea3d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -588,6 +588,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x7A70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 	IWL_DEV_INFO(0x7AF0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
 	IWL_DEV_INFO(0x7AF0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x7F70, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7F70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 	IWL_DEV_INFO(0x7E40, 0x1691, iwl_cfg_ma, iwl_ax411_killer_1690s_name),
-- 
2.49.0


