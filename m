Return-Path: <linux-wireless+bounces-35948-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJLJCA4o+mmHKQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35948-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:25:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E914D1FEA
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 19:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3ED0304A6E6
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82209481FB7;
	Tue,  5 May 2026 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b="pVRmpnwh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.mokrynskyi.com (mail.mokrynskyi.com [65.109.39.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198AC4A2E10
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.39.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001878; cv=none; b=b4CElg35rQb/a3YBxjbd81NGl4zNdywmPMG6b5V5VWRYmYr8YI99iYba55dXa3AwZme62aAZUNMLp3959Exa7wakiFJyrH7imCHBQub9hi/p9sehv6pbyafEkMwNXynvYrwuc8+C8SCjQB+qz3ct3BoM9u3cRt0erT7M8WRcFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001878; c=relaxed/simple;
	bh=zqBdiN/P9j2XO8gD6COc3WuRH6mpXG5dLkn+wymDqQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdE8oJJkJf/KJB7i6qjMHbzvAHf49bZVJa19QiJry+n/Nwl3QlivMU4gBNKeR7tgeXwFWOxzc/FdjYeod4TIFyhxdinkZIB30/rAtS+CT0bOPccFZNPR/VP+rwTobOdV7vH2Kf6E/84iQ9IunbQXmSPt07blPZFWgazDf0iGj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com; spf=pass smtp.mailfrom=mokrynskyi.com; dkim=pass (2048-bit key) header.d=mokrynskyi.com header.i=@mokrynskyi.com header.b=pVRmpnwh; arc=none smtp.client-ip=65.109.39.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mokrynskyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mokrynskyi.com
From: Nazar Mokrynskyi <nazar@mokrynskyi.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mokrynskyi.com;
	s=dkim; t=1778001871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrPVsXYF+rEIhZTNZMoNGMlP2TTLr2NqMrps8rU1RAk=;
	b=pVRmpnwheC58nBJJ5PhOGpyLIuqJq/d7UwqKiPb/AfPBZHgx4msVlbScsErcyGxq/qqh5U
	jMb5kOjZD9q9+WNiTu/9MsOvbzREKAuyZAaf/QGqcvi7Q4t+3D6XgXCjELbq2SpWVyYGDz
	MVJzbzfCgv1+Z8GhAv0UdBlTHYz5b4NiBEDnPo5UE3D7PWFREXu7NcgyIE6snrGrEPOFxm
	pZQ9gmkqnDsrqaDJuiCvyx9+55MbvvcSSUfNZFFL+qPnjlAZ3z4HfL3wepWh+DlW/piRv1
	6OPre1Gd2wxA7GnuwolxzAFHtJ6PmOwLgV8Eja79ZZ9eaeFKhTN/Djqc+ciOOQ==
Authentication-Results: mail.mokrynskyi.com;
	auth=pass smtp.mailfrom=nazar@mokrynskyi.com
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	jeff.johnson@oss.qualcomm.com,
	Nazar Mokrynskyi <nazar@mokrynskyi.com>
Subject: [PATCH 1/2] wifi: ath12k: skip PCIe global reset on initial power-up
Date: Tue,  5 May 2026 20:24:14 +0300
Message-ID: <20260505172415.566328-2-nazar@mokrynskyi.com>
In-Reply-To: <20260505172415.566328-1-nazar@mokrynskyi.com>
References: <20260505172415.566328-1-nazar@mokrynskyi.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----
X-Rspamd-Queue-Id: 72E914D1FEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mokrynskyi.com,reject];
	R_DKIM_ALLOW(-0.20)[mokrynskyi.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35948-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nazar@mokrynskyi.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mokrynskyi.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mokrynskyi.com:email,mokrynskyi.com:dkim,mokrynskyi.com:mid]

ath12k_pci_sw_reset() unconditionally calls ath12k_pci_soc_global_reset()
regardless of whether the device is being powered up for the first time or
recovering from a previous run. The global reset drops the PCIe link and
relies on the host root complex to perform physical link retraining before
the MHI BHI register can be accessed.

When the device is passed through to a VM via VFIO, no physical link
retraining occurs after the reset since QEMU's virtual PCIe bridge does
not implement hardware LTSSM negotiation. As a result, all subsequent
MMIO reads return 0xffffffff and MHI initialization fails with -EREMOTEIO.

On initial power-up, vfio-pci has already performed a Function Level
Reset before handing the device to the guest driver, placing it in a
known clean state equivalent to what the global reset achieves. The global
reset is therefore redundant on power-up and only necessary on the
shutdown/recovery path where it tears down an already-running firmware.

Skip ath12k_pci_soc_global_reset() when power_on is true to allow MHI
initialization to succeed under VFIO passthrough without affecting bare
metal behavior.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nazar Mokrynskyi <nazar@mokrynskyi.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 375277ca2..a3d7aeb72 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -303,7 +303,8 @@ static void ath12k_pci_sw_reset(struct ath12k_base *ab, bool power_on)
 
 	ath12k_mhi_clear_vector(ab);
 	ath12k_pci_clear_dbg_registers(ab);
-	ath12k_pci_soc_global_reset(ab);
+	if (!power_on)
+		ath12k_pci_soc_global_reset(ab);
 	ath12k_mhi_set_mhictrl_reset(ab);
 }
 
-- 
2.43.0


