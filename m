Return-Path: <linux-wireless+bounces-10772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F19D943B13
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E5A1C21935
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4EF157A6B;
	Thu,  1 Aug 2024 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NykxxJeY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50887157A5C;
	Thu,  1 Aug 2024 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471167; cv=none; b=RYHbYBOdhUYXJC9g3EYCaufZALfsup7WcxjwaRVDMrekY8ts1onuDZiP4fkh2QU9y6IrjxmiQcyklJI+HNOjaMEi4ZtLappoR6x+kmJZzoWIy/PlDwcwYIIMn2zjkmD/j+6VZ7Jxpxkg+1pBdFdVCtuslstP7b1m0yjb2uvRgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471167; c=relaxed/simple;
	bh=Svz7MM7FQ/i+557Tb0GazJirswKadLoLUEhQnxSQe+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTMnBIJxR05knGIKyQ8U03g1FOyHJgV5IP+ts39WrAs/uyM8jpqTUqNiPEnHwzKmKd5wLhL6FOJ7Q0iO7a2qSSLx7/kGit8AVbwl6MeuFQvFvcZaafkFUi/ftv+6xTsGWCXT19fnlegRbCnsFe2fWfRAKZV2Deo8lY8tjR+DOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NykxxJeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C170C32786;
	Thu,  1 Aug 2024 00:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471167;
	bh=Svz7MM7FQ/i+557Tb0GazJirswKadLoLUEhQnxSQe+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NykxxJeYNzQ7XV9pcCNQ5voyhOsybEtr0JXupsvGeu1vSIgEwEZ7C2ProZnYkJ5mm
	 pSHUAjbINjeyz6AQDIMUGPTi+aCIU2Pxqqd73CIAkZtMSthFjhb7kOH+nx5OTNoUOb
	 MWox2EZm6HgUT8WpaIppVXGMSD3TTHMwepVM2AgHPLl9HHLaWEmxuQsSgC1LHpLFI8
	 FB2lGoaGmQNv+gP+lYI5yPJHlUevvakvqLIlzFKuwKbkxKih7KYF/O8WQJ+M6u05lj
	 ZHXN5PkMQt8G3265P8YVPdbLGPTUxfo/lkvWlCNgovBVlYpMlGLkh2z3fGdP581vkV
	 uy/3OIzjgy/ug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 039/121] wifi: ath11k: initialize 'ret' in ath11k_qmi_load_file_target_mem()
Date: Wed, 31 Jul 2024 19:59:37 -0400
Message-ID: <20240801000834.3930818-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

[ Upstream commit 199f149e97dc7be80e5eed4b232529c1d1aa8055 ]

smatch flagged the following issue:

drivers/net/wireless/ath/ath11k/qmi.c:2401 ath11k_qmi_load_file_target_mem() error: uninitialized symbol 'ret'.

The reality is that 'ret' is initialized in every path through
ath11k_qmi_load_file_target_mem() except one, the case where the input
'len' is 0, and hence the "while (remaining)" loop is never entered.
But to make sure this case is also handled, add an initializer to the
declaration of 'ret'.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240504-qmi_load_file_target_mem-v1-2-069fc44c45eb@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index d4a243b64f6c3..aa160e6fe24f1 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2293,7 +2293,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 	struct qmi_txn txn;
 	const u8 *temp = data;
 	void __iomem *bdf_addr = NULL;
-	int ret;
+	int ret = 0;
 	u32 remaining = len;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
-- 
2.43.0


