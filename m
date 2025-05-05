Return-Path: <linux-wireless+bounces-22626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C29AAB204
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EA0161B59
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ADF41F519;
	Tue,  6 May 2025 00:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly6sMsiM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194225C80A;
	Mon,  5 May 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485653; cv=none; b=j+ifxZfvnmLJM238kEipIbiyP2IZCps/SCHji3laaSTAIR4lYEMi+7s09izE37QmN79O3aQY5wWbDwhlZRt5t5VKl2HNJ9cEwmQJc0YFYZtseFRG9DxcPO2Gv1odHk9pcQkvgzeR47Bljd07v1RIcA+QRFb2U4L0kHN/TtWcqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485653; c=relaxed/simple;
	bh=X1MGSto8owJXPYQbFsgBcykCrX0+To6OlBLwOsYNXbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DoQxsE3+3wqz33wSPI/yz2POilFEMQw1MHLHfQhevyTtD8SFr2X3Bkh85mPs40wuatb/kbfbAvq79kGZzQPsizGXC5/d+uPM7S7Y3r9c2KIy61ul7w3BN+5Y3XaxNu2KWZnT58uwB+8fhi0hiu9WcnpjQicjfrHk8oYLhlI8c24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly6sMsiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4010C4CEED;
	Mon,  5 May 2025 22:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485653;
	bh=X1MGSto8owJXPYQbFsgBcykCrX0+To6OlBLwOsYNXbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ly6sMsiMl2zqo6GaFutI1kqwIHMy3vxmVDEvr/oRJ1dLnVONAoK0bDiwblRT/q23s
	 rmwFhP1tykyRiQA0fMU1V8D/T+b0C9zGEpQy6vTh4AFhCFFpPh39/UKR5xRb0eF6Qb
	 dc7N9oEVjN/Ga4psbTEDnb0H6IWGJKILUYnkCoG1wiGMMAK2SqnFTIns47A+h/bPXH
	 nxM1nYItyWgMHEKyfDwDAvOknbBdm3QltWVt6xfTyb116TNwWfJSrsiC2nfooLLibO
	 LifQHz2sMzuqzlsi2C48iXIRmBdGI6X4wgjf7OFXcCPx6ABXHWR5P82ehD5AgzYWQW
	 Gv6Fxq9RqgOow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 409/486] wifi: rtw89: fw: validate multi-firmware header before accessing
Date: Mon,  5 May 2025 18:38:05 -0400
Message-Id: <20250505223922.2682012-409-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 1f0efffd597893404aea5c3d4f1bdaa1c61d4434 ]

A firmeware file contains multi-firmware with a header to represent
contents. The mfw_hdr->fw_nr is to define number of firmware in file.

         +-----+-------+------+---------+--------------+
         | sig | fw_nr | rsvd | version | reserved     |
         +---------------------------------------------+ --
 fw 0    | cv | type | mp | rsvd | shift | size | rsvd |   \
         +---------------------------------------------+   |
 fw 1    | cv | type | mp | rsvd | shift | size | rsvd |   | mfw_hdr->fw_nr
         +---------------------------------------------+   |
 fw N-1  |                  ...                        |   /
         +=============================================+ --
         |               fw 0 content                  |
         |       (pointed by fw0 shift/size)           |
         +=============================================+

To avoid Coverity warning, validate header is in range of firmware size,
and also validate the range of actual firmware content is in range.

Addresses-Coverity-ID: 1494046 ("Untrusted loop bound")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250203072911.47313-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 520dc0bc01956..e5c90050e7115 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -501,6 +501,30 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev,
 	}
 }
 
+static int rtw89_mfw_validate_hdr(struct rtw89_dev *rtwdev,
+				  const struct firmware *firmware,
+				  const struct rtw89_mfw_hdr *mfw_hdr)
+{
+	const void *mfw = firmware->data;
+	u32 mfw_len = firmware->size;
+	u8 fw_nr = mfw_hdr->fw_nr;
+	const void *ptr;
+
+	if (fw_nr == 0) {
+		rtw89_err(rtwdev, "mfw header has no fw entry\n");
+		return -ENOENT;
+	}
+
+	ptr = &mfw_hdr->info[fw_nr];
+
+	if (ptr > mfw + mfw_len) {
+		rtw89_err(rtwdev, "mfw header out of address\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static
 int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 			struct rtw89_fw_suit *fw_suit, bool nowarn)
@@ -511,6 +535,7 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 	u32 mfw_len = firmware->size;
 	const struct rtw89_mfw_hdr *mfw_hdr = (const struct rtw89_mfw_hdr *)mfw;
 	const struct rtw89_mfw_info *mfw_info = NULL, *tmp;
+	int ret;
 	int i;
 
 	if (mfw_hdr->sig != RTW89_MFW_SIG) {
@@ -523,6 +548,10 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 		return 0;
 	}
 
+	ret = rtw89_mfw_validate_hdr(rtwdev, firmware, mfw_hdr);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < mfw_hdr->fw_nr; i++) {
 		tmp = &mfw_hdr->info[i];
 		if (tmp->type != type)
@@ -552,6 +581,12 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 found:
 	fw_suit->data = mfw + le32_to_cpu(mfw_info->shift);
 	fw_suit->size = le32_to_cpu(mfw_info->size);
+
+	if (fw_suit->data + fw_suit->size > mfw + mfw_len) {
+		rtw89_err(rtwdev, "fw_suit %d out of address\n", type);
+		return -EFAULT;
+	}
+
 	return 0;
 }
 
-- 
2.39.5


