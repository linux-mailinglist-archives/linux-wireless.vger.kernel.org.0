Return-Path: <linux-wireless+bounces-22873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB51AB41F9
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 20:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B533B7D9C
	for <lists+linux-wireless@lfdr.de>; Mon, 12 May 2025 18:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1703129CB45;
	Mon, 12 May 2025 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaj1JxaX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38729CB3F;
	Mon, 12 May 2025 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073104; cv=none; b=qjzsMGQcAp9FtToyWHzju0255O/pbtDdEFas8wjal62GxkMs1FdEZA1F8zr4XCQUotBh2/nCRslPveYzr0ICZUcjWbblNUS0kYMjhwNWb7yz6DbjhOU5rqLMavOjZ01vtWcCt6SoHSzu/NsAxXjlLjJBIopFNlYgbKkhfz+JRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073104; c=relaxed/simple;
	bh=OE0rYqavy8Ez1wG36WARsHKqGiWp68Rk8ZLAoTRRx8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PvcnF7H7gib9hMTJfjIFE3vx2qz/6aseo43FpCb4GuVJV/jXd/wmZkYpQKB3vctsai2jEixgYmv1RScGq6ti5vB+oxzktfoINwVHSq9FSmcEgOTTL6yNmw5HBNA59oQZSU5ypE2krNF6pOlC9xUreL9cEr4aYW06PBObtB2aMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaj1JxaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2C2C4CEF0;
	Mon, 12 May 2025 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073103;
	bh=OE0rYqavy8Ez1wG36WARsHKqGiWp68Rk8ZLAoTRRx8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iaj1JxaXJygAT8lXFIp8th9Oo132Y4FNdDUmLd5A2CYik198MuGua2k1s2qGXXvcR
	 XrkSfNdUc5F/fsW70GoYg8R2pfOMgvSdD4d/ewatOopZpeohBEORA2HaLOhFnmCnC6
	 weyNSLmfvXC65SlwMLSqzI2NRf8nAFjoA649yMtNbKJVgcsKMS3SSF8iqjFZh9mce6
	 JqU9rgSo7noahCvA7qrdnqaEqxaeXor7Ho9w2Ovw2xE3s8ls6J1SDbtYOA5v9OyPdt
	 786p7ueUgKpzHkuC0xQozrL7i2wOtqF0kZa64rUS6DvpY7BnBXHa3L384/U0NErx7s
	 4zl/bK/dD+phQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	miriam.rachel.korenblit@intel.com,
	emmanuel.grumbach@intel.com,
	somashekhar.puttagangaiah@intel.com,
	shaul.triebitz@intel.com,
	golan.ben.ami@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 4/6] wifi: iwlwifi: add support for Killer on MTL
Date: Mon, 12 May 2025 14:04:50 -0400
Message-Id: <20250512180452.437844-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180452.437844-1-sashal@kernel.org>
References: <20250512180452.437844-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.90
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
index 4a2de79f2e864..c01a9a6f06a4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -580,6 +580,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x7A70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 	IWL_DEV_INFO(0x7AF0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
 	IWL_DEV_INFO(0x7AF0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x7F70, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7F70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 	IWL_DEV_INFO(0x7E40, 0x1691, iwl_cfg_ma, iwl_ax411_killer_1690s_name),
-- 
2.39.5


