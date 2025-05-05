Return-Path: <linux-wireless+bounces-22523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1A3AAA6C8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC513A50B1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56DB296709;
	Mon,  5 May 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsBwoz4i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15F296702;
	Mon,  5 May 2025 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484496; cv=none; b=fJjIDsoZCJiZb8y4LB/VwVGgEmrJNvho7qMyQN4wUZsueHybKVGh52d4YVw4m2w7RKZHaVuGaYtO4nTAERcKaKnIJPA7U227JaN1na6fxor7nxqFJEG6LJfTv9wjmX8ORXdZszocL4/555ywTnei3yxkUdtJO1Mm58+Za0pfB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484496; c=relaxed/simple;
	bh=P4n+TN3p6oAQF6VXu33TJ7KZEL1mp4qonjxDkB2xrb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idFp2SmNnGvPUCWTVe6xyk24TxMecE6A5oA7xsp6YkUdZ2OxcBlq2ludQm+IjLE5gvdZqhN4U3j7ud7JwcbBYMKVR4XmlDbuzMggmWd4Hi6y4I7RKZvUP/StpcEjcwpFRHIQvgDGCB3nEdfBBBUWLgJDe+q95C+D8BKG5jZ0jDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsBwoz4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F55AC116B1;
	Mon,  5 May 2025 22:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484495;
	bh=P4n+TN3p6oAQF6VXu33TJ7KZEL1mp4qonjxDkB2xrb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsBwoz4i4H2XuaQ1Ow2mPZz7bFXiCN3lebC/ZBSmPpq1o8I3IN9WdK1AYQPH/TX0U
	 y3h/b64VOSLxx0FECXvw/Frxy/BGeYXrecHj1sQa7PZjygDHEcCvwq/cXTax7FMsQG
	 IH/Ee8fWDPTSRgYpJFCrtLq6jf1g60vEjRov4tas/aXeBP79H0uwEHsISs1hHU+Ob+
	 P2+stwuBS0VyV9Ej71ER0gPI7um7M383cFdW8qO7fHGmHdXGtZq8KLDNQkX5PwN85s
	 RLNM3Ze+WOfe0ngOKBSMo9K4rug665hMVvIVtV5XXxWp8eW4fGaMJUHJKSeLwsNM/W
	 wfj+XQyFJqJ0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 500/642] wifi: iwlwifi: don't warn during reprobe
Date: Mon,  5 May 2025 18:11:56 -0400
Message-Id: <20250505221419.2672473-500-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 696cca64308dc641d0bbe4aa2c09dd9752aa288d ]

During reprobe, the sw state is being destroyd, and so is the
connection. When the peer STA is being removed, the opmode sends a
command to flush the TXQs of the STA and uses iwl_trans_wait_txq_empty.

This one warns if the FW is not alive, but it really shouldn't if
there is a FW error - and return silently instead, just like we do when
sending a hcmd.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20250205145347.76425b10e5a0.I3bf0de2eb090a8b94c4e36d93dd91df61fadb808@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 0ab6b2cfbcbdc..ece60d4352a97 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -676,6 +676,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_txq_enable_cfg);
 
 int iwl_trans_wait_txq_empty(struct iwl_trans *trans, int queue)
 {
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
+		return -EIO;
+
 	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
 		      "bad state = %d\n", trans->state))
 		return -EIO;
-- 
2.39.5


