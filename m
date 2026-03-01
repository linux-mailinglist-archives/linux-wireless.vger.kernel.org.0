Return-Path: <linux-wireless+bounces-32317-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAkEJ1aZo2neHgUAu9opvQ
	(envelope-from <linux-wireless+bounces-32317-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Mar 2026 02:41:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3852D1CB5FD
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Mar 2026 02:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5914831C1008
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Mar 2026 01:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819729B78D;
	Sun,  1 Mar 2026 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFuPS8Gb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146CC13B58A;
	Sun,  1 Mar 2026 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328646; cv=none; b=XB7dKTDcZGJJIvo7h/Ume4UofuY4Oy/DCNnLKYMAsHfMIKE+Rx8QpQZhtgWdNncwqnddZBPs95mia8OiqH2bkYP80Iz27QJJlliC1CY7i+R4/+OJ1xHTT6bHE1FQWE6U+e704y8QR37bhzFmXf10USzoTjC2yhi9ZW+UXVrmzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328646; c=relaxed/simple;
	bh=GrmOk027qfaPhIDoQatN4WoQI+9kjRjWmA81OczGAN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxkMZdedMbsfCW6PYdXxASB1oCJKZuQC0rwDH5atM5rLDlmWAPJD4n6AYtFITK9W4YdimHV6qZM+8qIezhT77EMo9KeDkAj9/YaI9v1cMtuixpWrvPhhZStv2CDlvqxDp0AFp5Yka0I5tWBUwfJ2u/ZLplSRu7DOcNlAu6GxFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFuPS8Gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80461C19421;
	Sun,  1 Mar 2026 01:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328645;
	bh=GrmOk027qfaPhIDoQatN4WoQI+9kjRjWmA81OczGAN4=;
	h=From:To:Cc:Subject:Date:From;
	b=fFuPS8GbHty5xGzOyEtbCKlR8ZY/yRS/EU7sWAvp6MiBQCLpzH/0NYzqUo1NHPYm0
	 xIF01xvkyyqRIGovfJGxWdXYKwrP9HFNyFLrebcPS693CSt3Lrl78g/UsVHw0llwwC
	 quqFFcVouMCYp4tyr1rFPvYeXePciMoNiEBtNdaLOfpcNC78Ysyov2EXeIY46V1ghU
	 tWvdQsLgh/fsVBO+i6bHd5/vEqXlou5kNAlQ1Wr6O718loE/bnt1TmBagpyC7Lhkhn
	 k5mEmCZDawkQR08IbMJURNyaZjKV4HtbW8saHyj7qBx/Asc5bgPpVHjMLHyX9mmC+H
	 uQPMI0bdM7XnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	manivannan.sadhasivam@oss.qualcomm.com
Cc: Johan Hovold <johan@kernel.org>,
	Chris Lew <quic_clew@quicinc.com>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: qrtr: Drop the MHI auto_queue feature for IPCR DL channels" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:30:42 -0500
Message-ID: <20260301013043.1688963-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32317-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,quicinc.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3852D1CB5FD
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 51731792a25cb312ca94cdccfa139eb46de1b2ef Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 22:21:44 +0530
Subject: [PATCH] net: qrtr: Drop the MHI auto_queue feature for IPCR DL
 channels

MHI stack offers the 'auto_queue' feature, which allows the MHI stack to
auto queue the buffers for the RX path (DL channel). Though this feature
simplifies the client driver design, it introduces race between the client
drivers and the MHI stack. For instance, with auto_queue, the 'dl_callback'
for the DL channel may get called before the client driver is fully probed.
This means, by the time the dl_callback gets called, the client driver's
structures might not be initialized, leading to NULL ptr dereference.

Currently, the drivers have to workaround this issue by initializing the
internal structures before calling mhi_prepare_for_transfer_autoqueue().
But even so, there is a chance that the client driver's internal code path
may call the MHI queue APIs before mhi_prepare_for_transfer_autoqueue() is
called, leading to similar NULL ptr dereference. This issue has been
reported on the Qcom X1E80100 CRD machines affecting boot.

So to properly fix all these races, drop the MHI 'auto_queue' feature
altogether and let the client driver (QRTR) manage the RX buffers manually.
In the QRTR driver, queue the RX buffers based on the ring length during
probe and recycle the buffers in 'dl_callback' once they are consumed. This
also warrants removing the setting of 'auto_queue' flag from controller
drivers.

Currently, this 'auto_queue' feature is only enabled for IPCR DL channel.
So only the QRTR client driver requires the modification.

Fixes: 227fee5fc99e ("bus: mhi: core: Add an API for auto queueing buffers for DL channel")
Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation")
Reported-by: Johan Hovold <johan@kernel.org>
Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldconsulting.com
Suggested-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/...
Acked-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251218-qrtr-fix-v2-1-c7499bfcfbe0@oss.qualcomm.com
---
 drivers/accel/qaic/mhi_controller.c   | 44 -----------------
 drivers/bus/mhi/host/pci_generic.c    | 20 +-------
 drivers/net/wireless/ath/ath11k/mhi.c |  4 --
 drivers/net/wireless/ath/ath12k/mhi.c |  4 --
 net/qrtr/mhi.c                        | 69 ++++++++++++++++++++++-----
 5 files changed, 60 insertions(+), 81 deletions(-)

diff --git a/drivers/accel/qaic/mhi_controller.c b/drivers/accel/qaic/mhi_controller.c
index 13a14c6c61689..4d787f77ce419 100644
--- a/drivers/accel/qaic/mhi_controller.c
+++ b/drivers/accel/qaic/mhi_controller.c
@@ -39,7 +39,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -55,7 +54,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -71,7 +69,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -87,7 +84,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -103,7 +99,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -119,7 +114,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -135,7 +129,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -151,7 +144,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -167,7 +159,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -183,7 +174,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -199,7 +189,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -215,7 +204,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -231,7 +219,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -247,7 +234,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -263,7 +249,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -279,7 +264,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -295,7 +279,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -311,7 +294,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -327,7 +309,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -343,7 +324,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -359,7 +339,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -375,7 +354,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -391,7 +369,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -407,7 +384,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -423,7 +399,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -439,7 +414,6 @@ static const struct mhi_channel_config aic100_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = true,
 		.wake_capable = false,
 	},
 };
@@ -458,7 +432,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -474,7 +447,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -490,7 +462,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -506,7 +477,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -522,7 +492,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -538,7 +507,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -554,7 +522,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -570,7 +537,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -586,7 +552,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -602,7 +567,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -618,7 +582,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -634,7 +597,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -650,7 +612,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -666,7 +627,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -682,7 +642,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -698,7 +657,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -714,7 +672,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 		.wake_capable = false,
 	},
 	{
@@ -730,7 +687,6 @@ static const struct mhi_channel_config aic200_channels[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = true,
 		.wake_capable = false,
 	},
 };
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index e3bc737313a2f..0884a384b77fc 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -94,22 +94,6 @@ struct mhi_pci_dev_info {
 		.doorbell_mode_switch = false,		\
 	}
 
-#define MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(ch_num, ch_name, el_count, ev_ring) \
-	{						\
-		.num = ch_num,				\
-		.name = ch_name,			\
-		.num_elements = el_count,		\
-		.event_ring = ev_ring,			\
-		.dir = DMA_FROM_DEVICE,			\
-		.ee_mask = BIT(MHI_EE_AMSS),		\
-		.pollcfg = 0,				\
-		.doorbell = MHI_DB_BRST_DISABLE,	\
-		.lpm_notify = false,			\
-		.offload_channel = false,		\
-		.doorbell_mode_switch = false,		\
-		.auto_queue = true,			\
-	}
-
 #define MHI_EVENT_CONFIG_CTRL(ev_ring, el_count) \
 	{					\
 		.num_elements = el_count,	\
@@ -329,7 +313,7 @@ static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
 	MHI_CHANNEL_CONFIG_UL(14, "QMI", 4, 0),
 	MHI_CHANNEL_CONFIG_DL(15, "QMI", 4, 0),
 	MHI_CHANNEL_CONFIG_UL(20, "IPCR", 8, 0),
-	MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(21, "IPCR", 8, 0),
+	MHI_CHANNEL_CONFIG_DL(21, "IPCR", 8, 0),
 	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
 	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
 	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 64, 2),
@@ -762,7 +746,7 @@ static const struct mhi_channel_config mhi_telit_fn980_hw_v1_channels[] = {
 	MHI_CHANNEL_CONFIG_UL(14, "QMI", 32, 0),
 	MHI_CHANNEL_CONFIG_DL(15, "QMI", 32, 0),
 	MHI_CHANNEL_CONFIG_UL(20, "IPCR", 16, 0),
-	MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(21, "IPCR", 16, 0),
+	MHI_CHANNEL_CONFIG_DL(21, "IPCR", 16, 0),
 	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 1),
 	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 2),
 };
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index acd76e9392d31..d2c44f7f9b622 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -34,7 +34,6 @@ static const struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 	},
 	{
 		.num = 21,
@@ -48,7 +47,6 @@ static const struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = true,
 	},
 };
 
@@ -99,7 +97,6 @@ static const struct mhi_channel_config ath11k_mhi_channels_qcn9074[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 	},
 	{
 		.num = 21,
@@ -113,7 +110,6 @@ static const struct mhi_channel_config ath11k_mhi_channels_qcn9074[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 08f44baf182a5..2dbdb95ae7bea 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -31,7 +31,6 @@ static const struct mhi_channel_config ath12k_mhi_channels_qcn9274[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 	},
 	{
 		.num = 21,
@@ -45,7 +44,6 @@ static const struct mhi_channel_config ath12k_mhi_channels_qcn9274[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = true,
 	},
 };
 
@@ -96,7 +94,6 @@ static const struct mhi_channel_config ath12k_mhi_channels_wcn7850[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = false,
 	},
 	{
 		.num = 21,
@@ -110,7 +107,6 @@ static const struct mhi_channel_config ath12k_mhi_channels_wcn7850[] = {
 		.lpm_notify = false,
 		.offload_channel = false,
 		.doorbell_mode_switch = false,
-		.auto_queue = true,
 	},
 };
 
diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
index 69f53625a049d..80e341d2f8a45 100644
--- a/net/qrtr/mhi.c
+++ b/net/qrtr/mhi.c
@@ -24,13 +24,25 @@ static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
 	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
 	int rc;
 
-	if (!qdev || mhi_res->transaction_status)
+	if (!qdev || (mhi_res->transaction_status && mhi_res->transaction_status != -ENOTCONN))
 		return;
 
+	/* Channel got reset. So just free the buffer */
+	if (mhi_res->transaction_status == -ENOTCONN) {
+		devm_kfree(&mhi_dev->dev, mhi_res->buf_addr);
+		return;
+	}
+
 	rc = qrtr_endpoint_post(&qdev->ep, mhi_res->buf_addr,
 				mhi_res->bytes_xferd);
 	if (rc == -EINVAL)
 		dev_err(qdev->dev, "invalid ipcrouter packet\n");
+
+	/* Done with the buffer, now recycle it for future use */
+	rc = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, mhi_res->buf_addr,
+			   mhi_dev->mhi_cntrl->buffer_len, MHI_EOT);
+	if (rc)
+		dev_err(&mhi_dev->dev, "Failed to recycle the buffer: %d\n", rc);
 }
 
 /* From QRTR to MHI */
@@ -72,6 +84,29 @@ static int qcom_mhi_qrtr_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
 	return rc;
 }
 
+static int qcom_mhi_qrtr_queue_dl_buffers(struct mhi_device *mhi_dev)
+{
+	u32 free_desc;
+	void *buf;
+	int ret;
+
+	free_desc = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
+	while (free_desc--) {
+		buf = devm_kmalloc(&mhi_dev->dev, mhi_dev->mhi_cntrl->buffer_len, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, buf, mhi_dev->mhi_cntrl->buffer_len,
+				    MHI_EOT);
+		if (ret) {
+			dev_err(&mhi_dev->dev, "Failed to queue buffer: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 			       const struct mhi_device_id *id)
 {
@@ -87,20 +122,30 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
 	qdev->ep.xmit = qcom_mhi_qrtr_send;
 
 	dev_set_drvdata(&mhi_dev->dev, qdev);
-	rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
-	if (rc)
-		return rc;
 
 	/* start channels */
-	rc = mhi_prepare_for_transfer_autoqueue(mhi_dev);
-	if (rc) {
-		qrtr_endpoint_unregister(&qdev->ep);
+	rc = mhi_prepare_for_transfer(mhi_dev);
+	if (rc)
 		return rc;
-	}
+
+	rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
+	if (rc)
+		goto err_unprepare;
+
+	rc = qcom_mhi_qrtr_queue_dl_buffers(mhi_dev);
+	if (rc)
+		goto err_unregister;
 
 	dev_dbg(qdev->dev, "Qualcomm MHI QRTR driver probed\n");
 
 	return 0;
+
+err_unregister:
+	qrtr_endpoint_unregister(&qdev->ep);
+err_unprepare:
+	mhi_unprepare_from_transfer(mhi_dev);
+
+	return rc;
 }
 
 static void qcom_mhi_qrtr_remove(struct mhi_device *mhi_dev)
@@ -151,11 +196,13 @@ static int __maybe_unused qcom_mhi_qrtr_pm_resume_early(struct device *dev)
 	if (state == MHI_STATE_M3)
 		return 0;
 
-	rc = mhi_prepare_for_transfer_autoqueue(mhi_dev);
-	if (rc)
+	rc = mhi_prepare_for_transfer(mhi_dev);
+	if (rc) {
 		dev_err(dev, "failed to prepare for autoqueue transfer %d\n", rc);
+		return rc;
+	}
 
-	return rc;
+	return qcom_mhi_qrtr_queue_dl_buffers(mhi_dev);
 }
 
 static const struct dev_pm_ops qcom_mhi_qrtr_pm_ops = {
-- 
2.51.0





