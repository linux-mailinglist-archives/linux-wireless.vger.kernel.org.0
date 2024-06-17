Return-Path: <linux-wireless+bounces-9107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA2290B216
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E035B313BD
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E956A1A3A76;
	Mon, 17 Jun 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYgjx6lJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E61A3A73;
	Mon, 17 Jun 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630796; cv=none; b=tLE+sSTP31Mzj9SDLtha+tDTrVtURd0hYcOBiw0O8R+X0NYdHCKeOmfar8OFobLSJloMV4vExcwh+sI6ZlMufFPARxzLMP+Gm0oGr6FkslmXo0spdkVRorO6BjXJiAFaUEd9k3o4ZQLVxcvQBrP+m/F2zUE0gCQCxNzOdRdUWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630796; c=relaxed/simple;
	bh=12g1k3KF3g1ap54ZWNVHI13FvDUwGgcpsUFGjd92otE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U77/o2nlIQZ8MMhAnTUFz9dLiW2XVH4waPvOPkD5hOrpz16PwG2uvFUPJnElhFEdJzDQy54IOoGruPDaYm+/IdMgYZqZyLikLoRNURnj/ey/DRQafQfIHfP4JN5HFgjKY/z2BcedZsvw0CTInarF+Z3GXGSxNmWy7mYW9nQX3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYgjx6lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73970C4AF48;
	Mon, 17 Jun 2024 13:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630796;
	bh=12g1k3KF3g1ap54ZWNVHI13FvDUwGgcpsUFGjd92otE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYgjx6lJn3wVpoahDdJtnwd/jvvuZtHF2y4pWxMqvjpo5GXh8Tp4u7fIFAj84rowh
	 CIio27ixN3rspE7aYyahApsk2zLBUr+qvf9w1Unl0XyE8FUdI/BTMQJeyDpn2MyyVA
	 Ezu4t6p1OSxdAl295azHljykRXEFr9HFVDZO6pl52CPv4PND8/pgqTnZbQ7mmYgNxu
	 k8pg6wYvMMQY/3/sOlHOzMMrVZeJ4DEON1x8Q0G7A6hgZfmm3ay2+/tNZhETwtrkPL
	 XksWHR8YQUXaKnjjIHdXYkkmf5XTNwoDHCS7M41aIMSKaHuj9rLjwxutkQvXKe/T9d
	 ERTduDc4y9JtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	shaul.triebitz@intel.com,
	benjamin.berg@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/21] wifi: iwlwifi: mvm: d3: fix WoWLAN command version lookup
Date: Mon, 17 Jun 2024 09:25:47 -0400
Message-ID: <20240617132617.2589631-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132617.2589631-1-sashal@kernel.org>
References: <20240617132617.2589631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

[ Upstream commit b7ffca99313d856f7d1cc89038d9061b128e8e97 ]

After moving from commands to notificaitons in the d3 resume flow,
removing the WOWLAN_GET_STATUSES and REPLY_OFFLOADS_QUERY_CMD causes
the return of the default value when looking up their version.
Returning zero here results in the driver sending the not supported
NON_QOS_TX_COUNTER_CMD.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240510170500.8cabfd580614.If3a0db9851f56041f8f5360959354abd5379224a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index c4c62bcbe67de..f9b004d139501 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1796,7 +1796,8 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 
 out:
 	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
-				    WOWLAN_GET_STATUSES, 0) < 10) {
+				    WOWLAN_GET_STATUSES,
+				    IWL_FW_CMD_VER_UNKNOWN) < 10) {
 		mvmvif->seqno_valid = true;
 		/* +0x10 because the set API expects next-to-use, not last-used */
 		mvmvif->seqno = le16_to_cpu(status->non_qos_seq_ctr) + 0x10;
-- 
2.43.0


