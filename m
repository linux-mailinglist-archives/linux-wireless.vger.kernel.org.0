Return-Path: <linux-wireless+bounces-22535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF1DAAA72C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7D09851D0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67A33106A;
	Mon,  5 May 2025 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWg2vsLZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B7331065;
	Mon,  5 May 2025 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484546; cv=none; b=R0QdgYcQw8qDugOqSE83ZwkLgv4n+yoQcgXoG/73MbFX9yTOIS4MurbF3ZoIKnb39YbHKkyJ2mnM2qrWggi8m2T4Eqog6itgGRH75qwpAqsyfrf7XYlY7L5nbnCGW3AUcE3dClJ73r2MmJ0C3u7zmuMDxWDAyHgMP2SdOFpktlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484546; c=relaxed/simple;
	bh=5WwxI4WcgwBIVddiwo9TQOGFDxTroCYJxSv5AI7bRtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HV4XZbb2GKyNb+dQRSuRY5r9A/avZ3TeJ+YSmltL/qTroiN69U9A4hN1pyw0b3Gm8om7Z9h5gAykKuhpfL0s4IuH+o24GAkzv4ABYY5pOUyqKpDeAO8zqKDh0rHAlMSN8f4z1b4KT221TeE7OYpt7BfpYdmVfRFj0ZY1jemRWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWg2vsLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B814C4CEED;
	Mon,  5 May 2025 22:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484545;
	bh=5WwxI4WcgwBIVddiwo9TQOGFDxTroCYJxSv5AI7bRtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWg2vsLZINb3kU01cF+P4WUGzUbaIlALrRQyJQOdxW4xVUY7jVh6Cob7vGw2JjzuH
	 wUKFN0B0SdtFLLBoH8/hHraCH4s76bFnFZdMabo8TnSeXfclsiAGGE01HSeF1HkVUT
	 gkUn/QhDdPU2nHRZtfkR6X7VJtdVTsXUgscXtCdonku05nhPZroDCINSwFG+gWi2Y9
	 hWk0Sf1gTQtCUSOEzySOsRU/WmPymhT7tx+16mI9Y0RrGm31KGGKiSOdItfUuQSjmH
	 ItGZrUzUL9gZQWpztkQ0gDUtjmjHRsAauuRAa4uZR5VWNtYC2WM+0DG0SaAA4WaYQ2
	 SFmzZBOubiy/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 528/642] wifi: rtw89: fw: validate multi-firmware header before accessing
Date: Mon,  5 May 2025 18:12:24 -0400
Message-Id: <20250505221419.2672473-528-sashal@kernel.org>
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
index aed0647955d8e..1fbcba718998f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -539,6 +539,30 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev,
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
@@ -549,6 +573,7 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 	u32 mfw_len = firmware->size;
 	const struct rtw89_mfw_hdr *mfw_hdr = (const struct rtw89_mfw_hdr *)mfw;
 	const struct rtw89_mfw_info *mfw_info = NULL, *tmp;
+	int ret;
 	int i;
 
 	if (mfw_hdr->sig != RTW89_MFW_SIG) {
@@ -561,6 +586,10 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 		return 0;
 	}
 
+	ret = rtw89_mfw_validate_hdr(rtwdev, firmware, mfw_hdr);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < mfw_hdr->fw_nr; i++) {
 		tmp = &mfw_hdr->info[i];
 		if (tmp->type != type)
@@ -590,6 +619,12 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
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


