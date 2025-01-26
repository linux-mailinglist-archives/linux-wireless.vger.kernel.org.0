Return-Path: <linux-wireless+bounces-17964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DB6A1CB7F
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144E4165BBB
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE52225A23;
	Sun, 26 Jan 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaB5NX0F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BB225A20;
	Sun, 26 Jan 2025 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903857; cv=none; b=UcGMn5kYgoZfYErSiANKBBYtPjpOGzg8bRE+zAvnMG4DqezM9xxvIdP2gKpJTn2c6BLvQbIEM7oXrEWalrgajcWBaSQf1KbnyTrc84LsyL3L7IqLdkRFepfMbG2fC3rWZARQkrJVdfDBnHm0x5ioaOJN5VJr1WiJf0le1VUuoE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903857; c=relaxed/simple;
	bh=UsLVsl2XtgE4wc2rsdjdzQRQkr3FO/BnQrqO1GliBEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELRiyqQ7GCGJ6RXK0tzNgtvkSrO7z2cECqUYGAXIvqtU26o9TpVQ2PkDtc3O6PByD/Xh1W7NgZaHD4Jr+HgvtDtxUTWMXqy6F4eh6yiCOZX4j5EUi4pvNjBNyKA5eCh5g4Q146rlWQfKbHlFiNaXsZa9hhYMLD0/Nys9vfVNpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaB5NX0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86096C4CEE2;
	Sun, 26 Jan 2025 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903856;
	bh=UsLVsl2XtgE4wc2rsdjdzQRQkr3FO/BnQrqO1GliBEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EaB5NX0FKw1aXhNNe4DAEI9z0lXfsan9WkcdZpq9OWXW9BYI6cznEgQVXFC+Krhlb
	 Lpypb5/nEAJzYJfxUPFzQnT/ytDV7AAuMpC/I5uFPfLwekYAQAXzUtkmYsSTpwRY+o
	 8v8nYSPU5plnY9gPIhKQKzmQXHl9l7pf5N/wly8r3fRYYxcJKiHE94bbwJjhi/VP54
	 CbYlsxldSRZ0ycMVCf30Z2T3cakyfvpARp2hmOt6dSoWS4NoTos8x6Gfm4DIiVs8jG
	 8VEGTpy4fZNvYKYP27cClLbXnzsekVIq8Uf7Y1wbkt9l4MqqhD9iLP1e1NjJ5m1n+k
	 XAhfV7PvC3tdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	pagadala.yesu.anjaneyulu@intel.com,
	dan.carpenter@linaro.org,
	somashekhar.puttagangaiah@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/17] wifi: iwlwifi: avoid memory leak
Date: Sun, 26 Jan 2025 10:03:46 -0500
Message-Id: <20250126150353.957794-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150353.957794-1-sashal@kernel.org>
References: <20250126150353.957794-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 80e96206a3ef348fbd658d98f2f43149c36df8bc ]

A caller of iwl_acpi_get_dsm_object must free the returned object.
iwl_acpi_get_dsm_integer returns immediately without freeing
it if the expected size is more than 8 bytes. Fix that.

Note that with the current code this will never happen, since the caller
of iwl_acpi_get_dsm_integer already checks that the expected size if
either 1 or 4 bytes, so it can't exceed 8 bytes.

While at it, print the DSM value instead of the return value, as this
was the intention in the first place.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20241228223206.bf61eaab99f8.Ibdc5df02f885208c222456d42c889c43b7e3b2f7@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index c96dfd7fd3dc8..84980f6a0d603 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -123,7 +123,7 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 				    size_t expected_size)
 {
 	union acpi_object *obj;
-	int ret = 0;
+	int ret;
 
 	obj = iwl_acpi_get_dsm_object(dev, rev, func, NULL, guid);
 	if (IS_ERR(obj)) {
@@ -138,8 +138,10 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 	} else if (obj->type == ACPI_TYPE_BUFFER) {
 		__le64 le_value = 0;
 
-		if (WARN_ON_ONCE(expected_size > sizeof(le_value)))
-			return -EINVAL;
+		if (WARN_ON_ONCE(expected_size > sizeof(le_value))) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		/* if the buffer size doesn't match the expected size */
 		if (obj->buffer.length != expected_size)
@@ -160,8 +162,9 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 	}
 
 	IWL_DEBUG_DEV_RADIO(dev,
-			    "ACPI: DSM method evaluated: func=%d, ret=%d\n",
-			    func, ret);
+			    "ACPI: DSM method evaluated: func=%d, value=%lld\n",
+			    func, *value);
+	ret = 0;
 out:
 	ACPI_FREE(obj);
 	return ret;
-- 
2.39.5


