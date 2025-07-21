Return-Path: <linux-wireless+bounces-25758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121EFB0CA95
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 20:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6AD5189A2AA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19CC2BEFFF;
	Mon, 21 Jul 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naRqarPH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27071BD035;
	Mon, 21 Jul 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122691; cv=none; b=D/u51s+Cj+txkqXf+dQjCQhtTCLGkKYqN9DuH9O4RmUsE+Hz1MLHxFDchH2CSKb03muhA5C4MCUEj8kE5QZtjBfbdQiyqcHO1LDNt0E70YIkf/i9bxhrRPr0YoCVu8/Fv2JmoJ9Ce/+3i8sjnVVEGVvrypB3+taJFFsVwDfDus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122691; c=relaxed/simple;
	bh=NpWjjVobczJENJVaJiZdhq+RGOHgWA4MU3aijnQASKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TvGunEdjkHfwRYlXTUgDFCAv3KMjY13vLDvZP/QsmGD200liEltj4m0lSPN4WRnT5lPFc5L7X1zpGZL0u8Uel3TX0GklpUvzfdVH5sdPiiz0zE9VkHAFripEoIy3oWjqtkxE2LMB9WaYI/XP6diAbKHD9MmOLN5bDMeY7qi2iZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naRqarPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBDFC4CEED;
	Mon, 21 Jul 2025 18:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753122691;
	bh=NpWjjVobczJENJVaJiZdhq+RGOHgWA4MU3aijnQASKU=;
	h=From:To:Cc:Subject:Date:From;
	b=naRqarPHTZctLf8wxWX1LcSKh2cUmW2WOqoINgZKqwAJwOhkcNmtPWso7AJzhYggl
	 GglEPdwnHZf9B+9ctbXASWrsN70Cg25q+r4whWa8SZ7tPdjnxTQEQ5EhFzMfuDnu5h
	 KTzQvnVuJBWQsNcwiwyBEadbu0vBD3/xE7Of67rqwBusXJmXRAYkKKRTXzeLHyF5un
	 NEUMmX7010mGrNNkUthLxr4Gs8OTqAeBK7WudnPJPa34MHoaENhQxyk3TMASZ4UrRv
	 7H2FJE1hteGQaxh3JiiW0v3FaT20//TR86Bklbfj1rBISBfOqIEC7dUDYkNhOkNGeU
	 e2wW3YFjI6VQg==
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: nl80211: Set num_sub_specs before looping through sub_specs
Date: Mon, 21 Jul 2025 11:31:29 -0700
Message-Id: <20250721183125.work.183-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; i=kees@kernel.org; h=from:subject:message-id; bh=NpWjjVobczJENJVaJiZdhq+RGOHgWA4MU3aijnQASKU=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl17Y2ar394Sc5Miyrn+PSh7dTf0pLOA8rhuz99cbBhe +eZvkmvo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgF4CI+jAwHBQ8n88SsEbWz/3JS I1Lol62hGLvGGzPtc8d6yz82h5Yz/OFhrl6tFG8kVOKhe7BSnsX7mO+VZ63PEg79dppy9OcREW4 A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The processing of the struct cfg80211_sar_specs::sub_specs flexible
array requires its counter, num_sub_specs, to be assigned before the
loop in nl80211_set_sar_specs(). Leave the final assignment after the
loop in place in case fewer ended up in the array.

Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Cc: <linux-wireless@vger.kernel.org>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1c808b08b747..db8b089454ca 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17559,6 +17559,7 @@ static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
 	if (!sar_spec)
 		return -ENOMEM;
 
+	sar_spec->num_sub_specs = specs;
 	sar_spec->type = type;
 	specs = 0;
 	nla_for_each_nested(spec_list, tb[NL80211_SAR_ATTR_SPECS], rem) {
-- 
2.34.1


