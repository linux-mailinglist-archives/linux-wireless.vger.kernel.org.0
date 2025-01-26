Return-Path: <linux-wireless+bounces-17957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076AA1CAE0
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B08B1887EF4
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F87211489;
	Sun, 26 Jan 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp0qUbgn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FD1A38E1;
	Sun, 26 Jan 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903769; cv=none; b=NzKRte+sE2qxUU0MBwJTtHQj4TtXw7yZB0yASmZ0MX+gdIVBcXhDpI2/HfWq6AJud4twM1zyLrECQFiT7TQhgl3lN9GitwWqdP4G+5sN/bosrqDhtTdEk38oTkRDymz5tmCPsayMSWHXL9obPD2ob/HulpfZTe6e5AdZ/8vALhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903769; c=relaxed/simple;
	bh=gZXa/QlzUTnZNzVf8+mlAdBz4gVYIciL2oZ+rzjJKkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TuO5jOoAkTBMY2thip496VxpXSRsM6yurRZgrVrE8X5X8DKo0uDDv2Pq5YGB8mQBY3yVXcEONO8T0JbMRcmY88WE6MJYy1AOaNIGqA/qTjhaZmunX8Bj94eqK/DMksePAUDfGaFm3YrogPFlqrZHAPR+v4XExSGP+fGRgr5cQpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp0qUbgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB447C4CED3;
	Sun, 26 Jan 2025 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903769;
	bh=gZXa/QlzUTnZNzVf8+mlAdBz4gVYIciL2oZ+rzjJKkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fp0qUbgnDjoUuXtvEjYmyWToacfAz2gLHAhGheFS938srts3KY0tnfvUH98bM9KhQ
	 M8wL9D3X1Cyr150MCIesuBSLhXNt6FUPdo7NU1BB1HIwjtgs+s8S57COAhQ/EggPaU
	 9BdzZj0ScpkwBE2dTOTPysNNe5A+THcvYeJIGaFVqp2AvqRyZfrNDq2i6PbJ5vT+hU
	 qD96bDtG9NPDglAQ9KWKoL/pMpA94j+ayl4zJoimpgLzIhrII1x2YxuaoHmeSC5efn
	 gy3G6+QTkRDs25YeW4CnIcYL0BFD6UMNTiPZLre/3Choe/F+VWhGzFvZTJiObuxpEl
	 Xayr5DdtFG0tQ==
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
Subject: [PATCH AUTOSEL 6.12 16/29] wifi: iwlwifi: avoid memory leak
Date: Sun, 26 Jan 2025 10:01:57 -0500
Message-Id: <20250126150210.955385-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150210.955385-1-sashal@kernel.org>
References: <20250126150210.955385-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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
index 0bc32291815e1..a26c5573d2091 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -108,7 +108,7 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
 				    size_t expected_size)
 {
 	union acpi_object *obj;
-	int ret = 0;
+	int ret;
 
 	obj = iwl_acpi_get_dsm_object(dev, rev, func, NULL, guid);
 	if (IS_ERR(obj)) {
@@ -123,8 +123,10 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
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
@@ -145,8 +147,9 @@ static int iwl_acpi_get_dsm_integer(struct device *dev, int rev, int func,
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


