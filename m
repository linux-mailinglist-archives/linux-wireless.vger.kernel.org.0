Return-Path: <linux-wireless+bounces-999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C938818C25
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 17:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF153B23909
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4F31D542;
	Tue, 19 Dec 2023 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlKHoXQ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD61D54D
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 16:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AE0C433C7;
	Tue, 19 Dec 2023 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703003119;
	bh=7oSvgq4JUwHb5Q5T5Bm2zUMKqmnVB5WU5E9lSwQcjvU=;
	h=From:To:Cc:Subject:Date:From;
	b=RlKHoXQ7W3p8qdZdU7PAgnrU1DORVdLe3fe7IXkqZszILIXysLF4rnKr2DkG5vNt4
	 ptTtAHTyG8NagE4Jc2S3QACpXqRnylLgoDOJqnirnFKQMQyUEExdVXJeTB4DAtI271
	 ApKZHwumhPLNmyVSTASQQCIbTEM3M8BAegczLDsMS23crANtjOKiLHJahe/HEYTz0f
	 2MDv4ga48mbYMmKPnUMNJdakYMKiCMwVDTWxbN5h98Fk1lxW2YHov2R0D+mKSpBK+V
	 qdvXOBkdfrE4c70litbSzOav2MF/9SwoG3zlBRN2ieUcUuRiHjW9UUBzmf6if54+rz
	 MN3bWQbIvywLA==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: chunkeey@googlemail.com
Subject: [PATCH] wifi: p54: fix GCC format truncation warning with wiphy->fw_version
Date: Tue, 19 Dec 2023 18:25:16 +0200
Message-Id: <20231219162516.898205-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC 13.2 warns:

drivers/net/wireless/intersil/p54/fwio.c:128:34: warning: '%s' directive output may be truncated writing up to 39 bytes into a region of size 32 [-Wformat-truncation=]
drivers/net/wireless/intersil/p54/fwio.c:128:33: note: directive argument in the range [0, 16777215]
drivers/net/wireless/intersil/p54/fwio.c:128:33: note: directive argument in the range [0, 255]
drivers/net/wireless/intersil/p54/fwio.c:127:17: note: 'snprintf' output between 7 and 52 bytes into a destination of size 32

The issue here is that wiphy->fw_version is 32 bytes and in theory the string
we try to place there can be 39 bytes. wiphy->fw_version is used for providing
the firmware version to user space via ethtool, so not really important.
fw_version in theory can be 24 bytes but in practise it's shorter, so even if
print only 19 bytes via ethtool there should not be any practical difference.

I did consider removing fw_var from the string altogether or making the maximum
length for fw_version 19 bytes, but chose this approach as it was the least
intrusive.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/intersil/p54/fwio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
index b52cce38115d..c4fe70e05b9b 100644
--- a/drivers/net/wireless/intersil/p54/fwio.c
+++ b/drivers/net/wireless/intersil/p54/fwio.c
@@ -125,7 +125,7 @@ int p54_parse_firmware(struct ieee80211_hw *dev, const struct firmware *fw)
 			   "FW rev %s - Softmac protocol %x.%x\n",
 			   fw_version, priv->fw_var >> 8, priv->fw_var & 0xff);
 		snprintf(dev->wiphy->fw_version, sizeof(dev->wiphy->fw_version),
-				"%s - %x.%x", fw_version,
+				"%.19s - %x.%x", fw_version,
 				priv->fw_var >> 8, priv->fw_var & 0xff);
 	}
 

base-commit: 4e87ca403e2008b9e182239e1abbf6876a55eb33
-- 
2.39.2


