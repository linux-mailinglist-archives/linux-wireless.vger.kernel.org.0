Return-Path: <linux-wireless+bounces-14618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11429B3DA0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 23:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767C3B226AC
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 22:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7CE1EBA14;
	Mon, 28 Oct 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap1AIsDv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5691E0B7F;
	Mon, 28 Oct 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153972; cv=none; b=mUh3xPXIhWr7+3+G7ckUCcv/teSIjw9nvKxqf7+FuMeH5HRvODE+MyYEI0eAuvPOKCdndlQIrLUyCa8hD6dQRpSaROIzVTm+Hi3GcB5dHZ2vlY2b0G2lIdfdl8sTQiq5fKgFav4DrCHbJUJDRCZGs2QPRxmv4UpGFNGa+nOtNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153972; c=relaxed/simple;
	bh=JRSA4dpwK26Ru8uzCDZ5U/2hQHPIbURI0Yl0IlzmWjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rxskNWg3QnJB/0oGPcGjdyvZVKNICW8A6rJcPo4vDflzGq8PbrpnLyp7q2fRb4gK79DUC849I5EGJjyxs9kW79wtEDWW9XS1Ot+oeVWVTD9L6B9nLO+NLsfd/IY6CenMguzk2ArEM5P9kOk6a1RuLJJVNweVreaRvOYya2FssHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap1AIsDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37D5CC4CEC3;
	Mon, 28 Oct 2024 22:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730153972;
	bh=JRSA4dpwK26Ru8uzCDZ5U/2hQHPIbURI0Yl0IlzmWjc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ap1AIsDvNldkGY3jO3qmvCR/siF3OM2GncLgV02F4YhHG0JIzl4GcbZJWj2axYJyB
	 h7oTsGH53bPc/3RzoLW+dhMLez2/g2O+7qyD02cQdkdI8KLxzNGKWLsrFwfs2GoBSu
	 BUb0EVBfE4NdgMsuRU7uetYGtTlxRVBNyP/qG4sYKViUUaFU778p2HfGFCr0/KoLuH
	 4pKbzeXepg5oRQcKQg6pOSJmr51F2qcSvGcAWpmYVRNGmNjktjXNqp6d0jjwfjVGIN
	 nkODRoizqBpT920LonrSFzqMFlLSoY/2B2k9tf9UIJb5eBcwHDObKjF/rlrpv3EXiH
	 T5G84CGLjG8Bw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C17D5B845;
	Mon, 28 Oct 2024 22:19:32 +0000 (UTC)
From: Aleksei Vetrov via B4 Relay <devnull+vvvvvv.google.com@kernel.org>
Date: Mon, 28 Oct 2024 22:18:40 +0000
Subject: [PATCH] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-nl80211_parse_sched_scan-bounds-checker-fix-v1-1-bb640be0ebb7@google.com>
X-B4-Tracking: v=1; b=H4sIAL8NIGcC/x2N0QqDMAxFf0XyvEAbu1H2K2NIbeMsG1USHAPx3
 w17uXDOw7k7KEtlhXu3g/C3al2agb90kOfUXoy1GAM5Ct5RxPaJjrwf1iTKg+aZi21qOC5bK4o
 m8psFp/rDfI2BpuDHeOvBiquw6f/b43kcJzdtLVt9AAAA
X-Change-ID: 20241028-nl80211_parse_sched_scan-bounds-checker-fix-c5842f41b863
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Aleksei Vetrov <vvvvvv@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730153971; l=1312;
 i=vvvvvv@google.com; s=20241028; h=from:subject:message-id;
 bh=iIxi2KLWI9wR0O0GYIDrc+V7xEplQHQGoi5qT4A15RA=;
 b=nTOEDZOton4avNlJ6GBQTWY3r29X14NRdFDJOLfoDH49KG2clQxQJmvJdqbubmFEyKHEVRiN4
 PyZlcBL9LotC8KqGQeQ4HeKzs+3geaLrffksSsD42ikKStOsGeu0SUB
X-Developer-Key: i=vvvvvv@google.com; a=ed25519;
 pk=b4c4Uc4EKDS3ie6P4xhkyobon88ZGFLMHyo8kw1IuM4=
X-Endpoint-Received: by B4 Relay for vvvvvv@google.com/20241028 with
 auth_id=257
X-Original-From: Aleksei Vetrov <vvvvvv@google.com>
Reply-To: vvvvvv@google.com

From: Aleksei Vetrov <vvvvvv@google.com>

The channels array in the cfg80211_scan_request has a __counted_by
attribute attached to it, which points to the n_channels variable. This
attribute is used in bounds checking, and if it is not set before the
array is filled, then the bounds sanitizer will issue a warning or a
kernel panic if CONFIG_UBSAN_TRAP is set.

This patch sets the size of allocated memory as the initial value for
n_channels. It is updated with the actual number of added elements after
the array is filled.

Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d7d099f7118ab5d5c745905abdea85d246c2b7b2..9b1b9dc5a7eb2a864da7b0212bc6a156b7757a9d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9776,6 +9776,7 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 	request = kzalloc(size, GFP_KERNEL);
 	if (!request)
 		return ERR_PTR(-ENOMEM);
+	request->n_channels = n_channels;
 
 	if (n_ssids)
 		request->ssids = (void *)request +

---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241028-nl80211_parse_sched_scan-bounds-checker-fix-c5842f41b863

Best regards,
-- 
Aleksei Vetrov <vvvvvv@google.com>



