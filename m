Return-Path: <linux-wireless+bounces-30203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCC6CEB04A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 02:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A2593003042
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 01:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269981C32FF;
	Wed, 31 Dec 2025 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="aMpv8/PS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC41A9FBC;
	Wed, 31 Dec 2025 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767146272; cv=pass; b=IpkHJk1BvpZXECJJCxg6dNt2TkYioeyGM4MRavFGzShdbZqcjmzu9bIkf5lz82IYmg1LkRPd4GFptzUOypBWzA0PGzqvtanmU5E9yTka/CDXbuhoTYRyjtsETrHYT+Yuz8WwWSuJAoTVF0IQYH7lWxfsnSYXs09Vd5HQty7iKDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767146272; c=relaxed/simple;
	bh=NTfybEqGyWH+bqAK8rv71K/w/hdsV+0xwpiS5pfFOvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7Mkg49BvVRLeBPul0+eyQwa9bim4smGskq8A/3swO5XEQXC54fTnpbJqO7vm9MVIgbeBLk4LQTF4sqZjT/GOSt9IiSxJUI+tOmbqXzlnjSu0D4FDsVXI2eDFksNFw4LBCOm+wixnxsv2oT2zxQ+U5yWMvp5LsiRZGb6S8DNCIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=aMpv8/PS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1767146267; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LXB4P32o/6Im+GgyA1hhQrpOBnq4LfM+/60G7rdHwB4SKDvYMN9gsr+l3UDRLKbJoh3ism3y/V2kcneAbzkI5JA4xxW6jW6NFEeZSXqEMJ3h8FWkuv/pIVQ1HtKNK4yoEik1ODnKfsE03p4vm+uK0En4Mw3yUB8S13q7VMG8sos=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767146267; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EiW1IbA6bFzy00CIMLyOdfR2O5jNGbPTQ/EW6iGfwdM=; 
	b=lCMSh5raa0CFru/bRAsJYzoVAkWiyWSzVtlswMB5L5oGay8uFMBSG991BB1cbTI0bDwPt3+9kTRZ7erPUXQh3e6xqZlvWf2mPqktJYyo9oGaviAY5l7AqogHXeQ4uie0ne5lIWoAPXbONft49g29F/nUQsDA9s/igU9420ATctQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767146267;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EiW1IbA6bFzy00CIMLyOdfR2O5jNGbPTQ/EW6iGfwdM=;
	b=aMpv8/PSeYMR20t6g0ctGfOhP7nX2bPqGr4iwahNUgbvoLGgonwurrwkMSIrRlt7
	Mdomj4AkiDWy494BK8y9uoSu48EfBRNTrVBGaRVX5wL6J61pfOOOKsYlW93BDLSwGby
	50ZusY4/IYoi0T6Z9GpRUEhA2n6CljE4wtesurzQ=
Received: by mx.zohomail.com with SMTPS id 1767146263578133.10283154068634;
	Tue, 30 Dec 2025 17:57:43 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH] iwlwifi: pcie: support shutdown operation
Date: Wed, 31 Dec 2025 09:57:36 +0800
Message-ID: <20251231015739.46024-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Kexec reboot does not reset PCI devices. If iwlwifi is left running,
the next kernel can time out during probe, breaking networking after
kexec:
kernel: iwlwifi 0000:06:00.0: Host monitor block 0x22 vector 0x0
kernel: iwlwifi 0000:06:00.0:     value [iter 0]: 0x00000000
kernel: iwlwifi 0000:06:00.0: probe with driver iwlwifi failed with error -110

Register iwl_pci_remove() as the PCI shutdown callback so the driver
runs its normal teardown path before handing control to the next kernel.

Signed-off-by: Li Chen <me@linux.beauty>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index dc99e7ac4726..c6d4079f7e1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1325,6 +1325,7 @@ static struct pci_driver iwl_pci_driver = {
 	.id_table = iwl_hw_card_ids,
 	.probe = iwl_pci_probe,
 	.remove = iwl_pci_remove,
+	.shutdown = iwl_pci_remove,
 	.driver.pm = IWL_PM_OPS,
 	.driver.coredump = iwl_pci_dump,
 };
-- 
2.52.0


