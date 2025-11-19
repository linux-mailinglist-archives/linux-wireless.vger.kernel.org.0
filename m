Return-Path: <linux-wireless+bounces-29128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56195C6D82A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 09:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBE354EECE1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 08:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78935329C61;
	Wed, 19 Nov 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTXcESib"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2E2F49F1;
	Wed, 19 Nov 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541693; cv=none; b=maF/Zj699SFPpmLRDuPqRyf7Cm3aJORzJz4YQEDx/swWJ5509jdPL/NH8GZwrwGHDT4noAu6fWZgKBFyHYWFigUiyUvegdeVdQNc6/Oyx4kREpS9bfxtZDzVgJWVxkXSeh/KOfJhFj1MYS2pG0LfhTDG8d0r9tR2CKGK0Nhf/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541693; c=relaxed/simple;
	bh=dksIa9QT6oEbWiAmLz25H8n5pzertf8zaOAbLvM1J0k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IvU+yBduhtjv2M0eRgrchXQfFZBPPH82+RUxw5wS5EBry16gSUJjMSM83nLy0/t4XdWybly6DRiKnADu8H5sI3fUqZ+Wzh5BzWj5LmyCdRZm5Xt+Ia7IMnMWDGWq+97Yhvw9+/LEQEm9RCCM2x72+OuL6KO/QGo8DZsx+QReSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTXcESib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC27C4CEF5;
	Wed, 19 Nov 2025 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763541692;
	bh=dksIa9QT6oEbWiAmLz25H8n5pzertf8zaOAbLvM1J0k=;
	h=Date:From:To:Cc:Subject:From;
	b=lTXcESiboV/AhVdMwTc5oSQdgg30Hlfpmy4Bk/LRPnoOLlkc8kZSCD6sYk7rRWWc/
	 ixEyUXceUQt/v2z1ZQkRm7Plvb3pS0DrgXTqG8SaDnImgTq0Uh/3JyNBkFrdc/MqhO
	 6rQkzUfBnj60A0ZbnaYIhVm0k1sARAz1TorUAJ0wqpIPTzZa7dew1t425adzcTkcpr
	 o693kk4Cq5/iaesGeMEmBtQqGhPmn3eGQvg0Ak0QLCY3hnDJS1oUCVRzKVuLcdOUo8
	 H03CpwsWFnIjdqkvjBV9fWqfRI+LO4DxOrA2AfNliRrs6F1YTPZxGzAj/KX4IQb1wG
	 VomU+Qnr3sDQA==
Date: Wed, 19 Nov 2025 17:41:26 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <aR2CtqZI3atH0HmE@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declarations (which in a couple of cases happens
to be in a union, so we're moving the entire unions) to the end of the
corresponding structures. Notice that `struct il_tx_beacon_cmd`,
`struct il4965_tx_resp`, and `struct il3945_tx_beacon_cmd` are flexible
structures, this is structures that contain a flexible-array member.

With these changes fix the following warnings:

11 drivers/net/wireless/intel/iwlegacy/common.h:526:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
11 drivers/net/wireless/intel/iwlegacy/commands.h:2667:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
4 drivers/net/wireless/intel/iwlegacy/3945.h:131:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/intel/iwlegacy/3945.h     | 4 +++-
 drivers/net/wireless/intel/iwlegacy/commands.h | 4 +++-
 drivers/net/wireless/intel/iwlegacy/common.h   | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945.h b/drivers/net/wireless/intel/iwlegacy/3945.h
index fb1e33c89d0e..ed63b31fee9a 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945.h
+++ b/drivers/net/wireless/intel/iwlegacy/3945.h
@@ -123,13 +123,15 @@ enum il3945_antenna {
 #define IEEE80211_FRAME_LEN             (IEEE80211_DATA_LEN + IEEE80211_HLEN)
 
 struct il3945_frame {
+	struct list_head list;
+
+	/* Must be last as it ends in a flexible-array member. */
 	union {
 		struct ieee80211_hdr frame;
 		struct il3945_tx_beacon_cmd beacon;
 		u8 raw[IEEE80211_FRAME_LEN];
 		u8 cmd[360];
 	} u;
-	struct list_head list;
 };
 
 #define SUP_RATE_11A_MAX_NUM_CHANNELS  8
diff --git a/drivers/net/wireless/intel/iwlegacy/commands.h b/drivers/net/wireless/intel/iwlegacy/commands.h
index b61b8f377702..2e665072f6d3 100644
--- a/drivers/net/wireless/intel/iwlegacy/commands.h
+++ b/drivers/net/wireless/intel/iwlegacy/commands.h
@@ -2664,10 +2664,12 @@ struct il3945_beacon_notif {
 } __packed;
 
 struct il4965_beacon_notif {
-	struct il4965_tx_resp beacon_notify_hdr;
 	__le32 low_tsf;
 	__le32 high_tsf;
 	__le32 ibss_mgr_status;
+
+	/* Must be last as it ends in a flexible-array member. */
+	struct il4965_tx_resp beacon_notify_hdr;
 } __packed;
 
 /*
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 4c9836ab11dd..21f1c7702add 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -518,13 +518,15 @@ struct il_channel_info {
 #define IEEE80211_FRAME_LEN             (IEEE80211_DATA_LEN + IEEE80211_HLEN)
 
 struct il_frame {
+	struct list_head list;
+
+	/* Must be last as it ends in a flexible-array member. */
 	union {
 		struct ieee80211_hdr frame;
 		struct il_tx_beacon_cmd beacon;
 		u8 raw[IEEE80211_FRAME_LEN];
 		u8 cmd[360];
 	} u;
-	struct list_head list;
 };
 
 enum {
-- 
2.43.0


