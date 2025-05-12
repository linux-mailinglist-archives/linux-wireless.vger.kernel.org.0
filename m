Return-Path: <linux-wireless+bounces-22871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EBAB418E
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 20:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A091F7B41EE
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3A5298271;
	Mon, 12 May 2025 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCXRrHsM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3BA298242;
	Mon, 12 May 2025 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073057; cv=none; b=K0KQ2q4Ha7LwAO/RyUJb6R9yUjXBR+WWF8WYQLsFVEgHV+QbT1NZeHYcem1x+y5FRYSKnq0COKmu3GPFidzDjkNGsqSgl6jFemtlD/XcI0OAzMBfnvWt/hdQHQnqeLv3Ada+UO/n19ndOUPNvJ1NXDPHJ4fCvboz1Bqar7bjF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073057; c=relaxed/simple;
	bh=B7MmUGyMEMUyla4md6J9bAqwlsP0cOIFyFAR4cdIpuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6rfSPYLKZREDjB/53oG6avx5mYp7YTIa56u4My4gL9I0cqV+i13mlxcDxCExnmwUIQxJVeShulx9UVonBXp+kAtiGjekfGG/pT0e4j6RzYXI99/ixn0wszuX3n3iHStMFk9J/mWEgCd3mLw5FK3ungpIeSwwFVIY7LGH0jCNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCXRrHsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B341AC4CEE9;
	Mon, 12 May 2025 18:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073055;
	bh=B7MmUGyMEMUyla4md6J9bAqwlsP0cOIFyFAR4cdIpuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XCXRrHsMgh5l4jXmcJQpAoKg4oKAXFw8UM9JrcngySg0oSB3PPQjtKROWe+eH5sQb
	 X/o2zUhpM4sMhZ5Ju/U+/miA8UpX+OqKX7YUuNc4iTj1WFXHsIWtnrh6qjx0/5fqVk
	 jsKHmzlwTq8x87UdjOx0bIrqlcFWJZOPCRd+hcnejShILH+1Gq5uNMdn9wcfPxV1IM
	 Q5Xl1I512qlUbkspFykjgfc5PgzJd5kMKa84Z+1X90Y64TB7WRpqWuYiskjQ22Fxsk
	 MlA4bGZHermoKcQjz1HF57PZK9wzjgk4BUjCpIpTD7iuOT4fM01UIPO7A4RMhlDK+S
	 DTXIRyN7woOPA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	miriam.rachel.korenblit@intel.com,
	emmanuel.grumbach@intel.com,
	somashekhar.puttagangaiah@intel.com,
	pagadala.yesu.anjaneyulu@intel.com,
	golan.ben.ami@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 11/15] wifi: iwlwifi: add support for Killer on MTL
Date: Mon, 12 May 2025 14:03:46 -0400
Message-Id: <20250512180352.437356-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180352.437356-1-sashal@kernel.org>
References: <20250512180352.437356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.6
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit ebedf8b7f05b9c886d68d63025db8d1b12343157 ]

For now, we need another entry for these devices, this
will be changed completely for 6.16.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219926
Link: https://patch.msgid.link/20250506214258.2efbdc9e9a82.I31915ec252bd1c74bd53b89a0e214e42a74b6f2e@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d4c1bc20971fb..69cf46c79b4b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -587,6 +587,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x7A70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 	IWL_DEV_INFO(0x7AF0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
 	IWL_DEV_INFO(0x7AF0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x7F70, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7F70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 	IWL_DEV_INFO(0x7E40, 0x1691, iwl_cfg_ma, iwl_ax411_killer_1690s_name),
-- 
2.39.5


