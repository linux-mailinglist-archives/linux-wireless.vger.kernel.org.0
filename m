Return-Path: <linux-wireless+bounces-15804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915D29DE6CE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 13:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577A3282393
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2024 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4C01A0B0E;
	Fri, 29 Nov 2024 12:58:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8401A00F2;
	Fri, 29 Nov 2024 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885110; cv=none; b=lQ+r/inb/RvSb2t4Q5v1mksSHKGFztTNH4j+2DEMFz8OHn4WtgQOB5DnuEz1jKNA/fktQnZKb1GWC6+WBS25I/4ShzAyFVv3rONeuFZfWZALNtzSC09F0IJRULXF5QZSPSaQZj5+9wYhzCIuJ5OSpwzSweS6UGSZydqw0muGD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885110; c=relaxed/simple;
	bh=WQW0VX2zENKV5aW7BUpDJv5AdgIb7aMYczBV2AtkVN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSAT1rhtJBk7ZNrKSGYgYIGFOB3o3LeLZs86sSKry3m8Imtxi9AV2ZhBvKpvodEVBoCV8GNcdgmAMJMy8PESsPRQkI3HzTs84fu/+LNx6cIQZA85OhJxhweiNdmWNcy1ngFK6nNkVZXavzrVe+DlvA9gx0jrfz7qKcXz1BWF6PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 29 Nov
 2024 15:58:22 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 29 Nov
 2024 15:58:21 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Luca Coelho
	<luciano.coelho@intel.com>, Kalle Valo <kvalo@codeaurora.org>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Johannes
 Berg" <johannes.berg@intel.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.4/5.10 1/1] wifi: iwlwifi: mvm: Fix a memory corruption issue
Date: Fri, 29 Nov 2024 04:58:13 -0800
Message-ID: <20241129125813.25555-2-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241129125813.25555-1-n.zhandarovich@fintech.ru>
References: <20241129125813.25555-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 8ba438ef3cacc4808a63ed0ce24d4f0942cfe55d ]

A few lines above, space is kzalloc()'ed for:
	sizeof(struct iwl_nvm_data) +
	sizeof(struct ieee80211_channel) +
	sizeof(struct ieee80211_rate)

'mvm->nvm_data' is a 'struct iwl_nvm_data', so it is fine.

At the end of this structure, there is the 'channels' flex array.
Each element is of type 'struct ieee80211_channel'.
So only 1 element is allocated in this array.

When doing:
  mvm->nvm_data->bands[0].channels = mvm->nvm_data->channels;
We point at the first element of the 'channels' flex array.
So this is fine.

However, when doing:
  mvm->nvm_data->bands[0].bitrates =
			(void *)((u8 *)mvm->nvm_data->channels + 1);
because of the "(u8 *)" cast, we add only 1 to the address of the beginning
of the flex array.

It is likely that we want point at the 'struct ieee80211_rate' allocated
just after.

Remove the spurious casting so that the pointer arithmetic works as
expected.

Fixes: 8ca151b568b6 ("iwlwifi: add the MVM driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/23f0ec986ef1529055f4f93dcb3940a6cf8d9a94.1690143750.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Nikita: no cast to (u8 *) is present in older kernels so just
ensure that (void *) cast is used on a modified channels pointer
rather than incrementing (void *) pointer after.]
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 287f9c551525..c3d7d0e06c87 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -653,7 +653,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 		mvm->nvm_data->bands[0].n_channels = 1;
 		mvm->nvm_data->bands[0].n_bitrates = 1;
 		mvm->nvm_data->bands[0].bitrates =
-			(void *)mvm->nvm_data->channels + 1;
+			(void *)(mvm->nvm_data->channels + 1);
 		mvm->nvm_data->bands[0].bitrates->hw_value = 10;
 	}
 
-- 
2.25.1


