Return-Path: <linux-wireless+bounces-25756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B590BB0CA63
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 20:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0D17AD1E6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26146219E93;
	Mon, 21 Jul 2025 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVb/Z0fq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99432B9A8;
	Mon, 21 Jul 2025 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121897; cv=none; b=trSL6WcnvPFkgjkOChAj/EAVrvJyS2uHSDs5gohb0Mev51gSqkvHKKTFWZMf+/sp9gsWKCyOOBbZcAIFwlrUwwoluDNTYkPj6IUAJiire2YHwxfPuUv1cYsBq0WjpSYBEyjnFWT1xPj42wT0aDTQF4C5Wv6qz21sfhr2rnRqhX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121897; c=relaxed/simple;
	bh=sTdqdr+or0m6zoDwN5ql7A5qIHEg53jj7f+Jo1+i0tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sq++f5qhXVd+eI2QEY+o3xcwIYQIqRQ9UUfI59Nc1o4yXg69t79AeA31Luv5rMn46Jk23zBQfBaG+Rv7aikHt2/lz0gr8jY7k1p3RRaF5HwTZ9l3eidcUIy+qpsNg0950AGPnLbqEHnda9AhP2gTspf+o6ng5A6nUu2m5wWLOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVb/Z0fq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6EAC4CEED;
	Mon, 21 Jul 2025 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753121896;
	bh=sTdqdr+or0m6zoDwN5ql7A5qIHEg53jj7f+Jo1+i0tQ=;
	h=From:To:Cc:Subject:Date:From;
	b=PVb/Z0fqiTP33p0axgayNekk9/96JzApdWTEFGdiBnrRW4dyNlqWvU2RGYDLjVVMi
	 09pSevJS1z8o++kjGjCZE9Fvw3RkWVURic9gKcm9Ppc8PvXtAxmUAavJjx27meYIcP
	 qclpxzKH2qR0hWb/C1L4QJE21CEN5IqFWda3QIUCx1MHdN4oG6SXC9ZhR5R1ynkpG2
	 D+gFNhusOdxZE9eod1F0j6ymeCi2U2UnpPmU1tR7MaoNUMsiGM+3bETqDw1DaDP4Sd
	 m5HQzC1lsezHPIZxuE5t5++OX4ByRC5+r2pESLmp8PZ0hXFpcc3mvwo1kzeN5ZQpSQ
	 U22dPv9LZ7YwQ==
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
	Chi-hsien Lin <chi-hsien.lin@infineon.com>,
	James Prestwood <prestwoj@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ting-Ying Li <tingying.li@cypress.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: cyw: Fix __counted_by to be LE variant
Date: Mon, 21 Jul 2025 11:18:14 -0700
Message-Id: <20250721181810.work.575-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=kees@kernel.org; h=from:subject:message-id; bh=sTdqdr+or0m6zoDwN5ql7A5qIHEg53jj7f+Jo1+i0tQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl1LWmP9/UtS5wVc+Bl7Ay5jqP37/hnHuEvZp0T8qpr5 /OQ+c0HOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZSP42RoX/elrnSxRPKrFes 85ct3rslY0rL/xXdpm97b248MnG5TSkjw/U0zuUfUrfvCFyccvnVBV7jUhbXw8ef9ERefiG72Py JNRsA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In brcmf_cyw_mgmt_tx() the "len" counter of the struct
brcmf_mf_params_le::data flexible array is stored as little-endian via
cpu_to_le16() so the __counted_by_le() variant must be used:

	struct brcmf_mf_params_le *mf_params;
	...
	mf_params_len = offsetof(struct brcmf_mf_params_le, data) +
			(len - DOT11_MGMT_HDR_LEN);
	mf_params = kzalloc(mf_params_len, GFP_KERNEL);
	...
        mf_params->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);

Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Cc: James Prestwood <prestwoj@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ting-Ying Li <tingying.li@cypress.com>
Cc: <linux-wireless@vger.kernel.org>
Cc: <brcm80211@lists.linux.dev>
Cc: <brcm80211-dev-list.pdl@broadcom.com>
Cc: <linux-hardening@vger.kernel.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
index 08c69142495a..669564382e32 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
@@ -80,7 +80,7 @@ struct brcmf_mf_params_le {
 	u8 da[ETH_ALEN];
 	u8 bssid[ETH_ALEN];
 	__le32 packet_id;
-	u8 data[] __counted_by(len);
+	u8 data[] __counted_by_le(len);
 };
 
 #endif /* CYW_FWIL_TYPES_H_ */
-- 
2.34.1


