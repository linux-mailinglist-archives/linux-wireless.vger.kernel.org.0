Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87E6FA3B7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 03:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfKMCMC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 21:12:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730051AbfKMB6c (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 20:58:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA9C52245C;
        Wed, 13 Nov 2019 01:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610312;
        bh=AIoefMBkzTyQpQDx+wHLCeWHS00qU4UIZRBzUd3m66k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqbOg3pXj6R7rdr6s2w/g1plgrbhO8pMDBIQaw4paQUobxUEon7qsNWoxak9mS9bo
         goWV/NLqnOQO7dfcMMfiMNMHlB/TJ+q37A/uDxi2i6C+iJcvdqvxksYwP/XPFW/ZBh
         XSmC5ItvqwWl7IcucGtMDK/WW9xfB1genJ6oeBm0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 079/115] iwlwifi: mvm: don't send keys when entering D3
Date:   Tue, 12 Nov 2019 20:55:46 -0500
Message-Id: <20191113015622.11592-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit 8c7fd6a365eb5b2647b2c01918730d0a485b9f85 ]

In the past, we needed to program the keys when entering D3. This was
since we replaced the image. However, now that there is a single
image, this is no longer needed.  Note that RSC is sent separately in
a new command.  This solves issues with newer devices that support PN
offload. Since driver re-sent the keys, the PN got zeroed and the
receiver dropped the next packets, until PN caught up again.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index b205a7bfb828d..65c51c6983288 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -947,8 +947,10 @@ int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 {
 	struct iwl_wowlan_kek_kck_material_cmd kek_kck_cmd = {};
 	struct iwl_wowlan_tkip_params_cmd tkip_cmd = {};
+	bool unified = fw_has_capa(&mvm->fw->ucode_capa,
+				   IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 	struct wowlan_key_data key_data = {
-		.configure_keys = !d0i3,
+		.configure_keys = !d0i3 && !unified,
 		.use_rsc_tsc = false,
 		.tkip = &tkip_cmd,
 		.use_tkip = false,
-- 
2.20.1

