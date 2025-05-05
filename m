Return-Path: <linux-wireless+bounces-22534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960D5AAA6E6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD054A2D29
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238F5330AC0;
	Mon,  5 May 2025 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoZ9VEP5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9F330AB7;
	Mon,  5 May 2025 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484545; cv=none; b=qf0fV1f6FsrmnS3nnZwMr3VaRMgzVeqVU4SQsH0ucKwVougDOwMJFCnrbfi0m7AGLt0tj5WXR+TG4symKg2zWItdiOQra5vK59ozW+C2gA8wZ3+mD7793DTJoaV7F3ZEdliQ9RwqiHkUbfy98DEkCZcNv9s/vzr2JJzzqmzx+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484545; c=relaxed/simple;
	bh=xnuNC+Q6D2hlHOL5WtUzsxPOsQCqX33zSI02nE+MXTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XRKNOMALyCNulEoyLLgWbn7kj6gABC++odLhHcSsgKCes7w/3h3RbVikgkjUl4wrm5Y/eMBCq3rZKCBQSrBt7THuvxmZfuJxaDKp2//eL9KIZRjdWX5EO+alUZmJJpwjPJjEIm7jYHzND27QqLm1deuGJRQug9RbO+ccbosog58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoZ9VEP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E7DC4CEEE;
	Mon,  5 May 2025 22:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484544;
	bh=xnuNC+Q6D2hlHOL5WtUzsxPOsQCqX33zSI02nE+MXTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoZ9VEP5IPTZfYOJUSnfZrciDVusQuzsyls2FZvKKFJOWyDlrD5Y7wFgipNeMcmcl
	 kr2vqA+1Mex1G7iFaI6M7rRup8levVdA+vczYxDc1twKlSNrPoLijjTESPqPtU93by
	 +7jFVSwkByY9GOh6nx6sb2vhC0xsOHQxc2l1IuAWgfc5+qVauuMnNv6TXk0A4fm1iU
	 OQOCtZgQdFRT9rFEm7vlN+Klr1/2+DV8fobWupJHtzRsrk/YP+z/2D9Pq8vIwkLCrV
	 s//FnHqmyfR/Tva8KtQVu+4oBQVr3REjx9lWgbyRsEjG9OU/c7xpLC6EU9XEQFGPLk
	 VJ0egqX9w0u7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 527/642] wifi: rtw89: fw: validate multi-firmware header before getting its size
Date: Mon,  5 May 2025 18:12:23 -0400
Message-Id: <20250505221419.2672473-527-sashal@kernel.org>
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

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 2b8bdc5237014cc61784b3676cbaca5325959f3d ]

To access firmware elements appended after multi-firmware, add its size
as offset to get start address of firmware elements.

         +-----+-------+------+---------+--------------+ --
         | sig | fw_nr | rsvd | version | reserved     |   \
         +---------------------------------------------+   |
 fw 0    | cv | type | mp | rsvd | shift | size | rsvd |   |
         +---------------------------------------------+   |
 fw 1    | cv | type | mp | rsvd | shift | size | rsvd |   |
         +---------------------------------------------+   |
 fw N-1  |                  ...                        |   |
         +=============================================+   | mfw size
         |               fw 0 content                  |   |
         +=============================================+   |
         |               fw 1 content                  |   |
         +=============================================+   |
         |                  ...                        |   |
         +=============================================+   |
         |               fw N -1 content               |   |
         +=============================================+ --/
         |             fw element TLV X                |
         +=============================================+
         |             fw element TLV Y                |
         +=============================================+
         |             fw element TLV Z                |
         +=============================================+

To avoid Coverity warning when getting mfw size, validate it header ahead.

Addresses-Coverity-ID: 1544385 ("Untrusted array index read")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250203072911.47313-5-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f4b3438615541..aed0647955d8e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -601,12 +601,17 @@ static u32 rtw89_mfw_get_size(struct rtw89_dev *rtwdev)
 		(const struct rtw89_mfw_hdr *)firmware->data;
 	const struct rtw89_mfw_info *mfw_info;
 	u32 size;
+	int ret;
 
 	if (mfw_hdr->sig != RTW89_MFW_SIG) {
 		rtw89_warn(rtwdev, "not mfw format\n");
 		return 0;
 	}
 
+	ret = rtw89_mfw_validate_hdr(rtwdev, firmware, mfw_hdr);
+	if (ret)
+		return ret;
+
 	mfw_info = &mfw_hdr->info[mfw_hdr->fw_nr - 1];
 	size = le32_to_cpu(mfw_info->shift) + le32_to_cpu(mfw_info->size);
 
-- 
2.39.5


