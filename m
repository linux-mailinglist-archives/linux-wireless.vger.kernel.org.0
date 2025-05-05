Return-Path: <linux-wireless+bounces-22625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E09AAB200
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CBB7B8C5D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DDA41F4F3;
	Tue,  6 May 2025 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/wgz4TC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF032D47DE;
	Mon,  5 May 2025 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485652; cv=none; b=aWO0Di2OlhWRIblGGkAq4WYN4VPzzKaq2D92sNn4L7Tnuz9G07XHQ2vE+ujAv1Q7yMyZzNARRHQTUJpVAPMsB3AjeBe8Ebe+RUehUgvaOW2/RYAosf2x6/HOgPQNjKxjXtxxBm72oK5qAktc6I6jsaqbj91bxK41nURCRkIsUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485652; c=relaxed/simple;
	bh=BDysUVsvtSATMxdGWrcvRNC/TEmnIU1Qo9xNd3/2Z8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYWXOwzdHNa5TL3mG2rQT0KBdu9VUR71JZXZ0xqaTrewSSVpOVQYf8MpRGNkkzQjBr9eWbXk/3x0Jvmpeit6HIZxo15lDNOHEFtJT7D5mtIdtMxKwMGAuUIfc7KTWETklzljQYFKZ+1RglWBDKGyZ1V1MLXpUW2t0hJtbJfWfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/wgz4TC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA5EC4CEEE;
	Mon,  5 May 2025 22:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485652;
	bh=BDysUVsvtSATMxdGWrcvRNC/TEmnIU1Qo9xNd3/2Z8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/wgz4TCe4UcBhgC1+LZwjXpDA7fI46qCLA4VC40227vF0rkcfXRm6bviMd2CAzeV
	 GIspf+mew7PgIJbQmcRKQ2bQq+q6CKL2BDPli03bmom0nc4/aApkXKW4LU1TmK/f5J
	 iDHOujVRcfWN4gTmCrJs+dpJjNfjQBYRnw65b4Svr/CGPmwwwQYoM8ss4L67P1eVEg
	 CLtGafkAR590umHiNxD0HK/XBjtfSbdWn//LYz959EZ4oTVO6apO571EoJiyQ1jaPU
	 hDXYQq79JrrjLDfim6UXhB1RDMGKnzcwG8LqC9C9QLCF710oB8U1x/d6cAFMsKMlpZ
	 0fiUCHAtaQ8QA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 408/486] wifi: rtw89: fw: validate multi-firmware header before getting its size
Date: Mon,  5 May 2025 18:38:04 -0400
Message-Id: <20250505223922.2682012-408-sashal@kernel.org>
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
index 9346fe082040c..520dc0bc01956 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -563,12 +563,17 @@ static u32 rtw89_mfw_get_size(struct rtw89_dev *rtwdev)
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


