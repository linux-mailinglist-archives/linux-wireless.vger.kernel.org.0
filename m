Return-Path: <linux-wireless+bounces-16134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2129EA93A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 08:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54110284195
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 07:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0678612BF02;
	Tue, 10 Dec 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="fAxJijdj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB877DA6C
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814294; cv=none; b=m9y+UDzcWFeoyqHqj0pVGIlv6dADuq4D0BSwVPEAWjBH2LZ9bqtQudT+ZNRIKMpCBYByHt9epoemOTZSqwslFkUmorMIO4DwQoB9uE/aKt5p/3JSXv7Waae3LIJFABV3WQsvbHqJbfuFLKaOTIQXeld7B177sR5U3utKHuopfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814294; c=relaxed/simple;
	bh=z/+Lzhci9t4FQVb2I1vQPsQ5ToHCf97+19+OLgUr590=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aj9tmQAHMa+n6uQmPhCZnu1jYZCEQWWSci19smWI2oND99KHTa2XmFj/mzmBXSC/sjNMuPPIMc6uphwThrakcUQ7+0TtRbSOWn2nSmhT8eva/W0DYBf/P67+eIbJPVL5xeYaaJrxOsY0IqHGfnN693dYlxlmNjFUqN15DlJK4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=fAxJijdj; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:18aa:0:640:5723:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 97E5060A90;
	Tue, 10 Dec 2024 10:04:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id g4grVOBOp0U0-AkekeEoV;
	Tue, 10 Dec 2024 10:04:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733814282; bh=1a53GWlwzV16Y8+9F6JLMHCZQRe754Lz6S6o9afPCMw=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=fAxJijdj9ngYo1EH3/bqWWf/k7A1lk7oQExteGPAdQN79vqhbgrbhTzGbVw0DRwPw
	 RjZcbkmOeapj/uU7kR64Cw2rDrq3ASBwOY7C1+1KlxXP/7s6fiLqfssT0DFiepXEMI
	 DLwpjVcsiD5r4HdPrIADwifU2VsjTRK8oexCL0uw=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()
Date: Tue, 10 Dec 2024 10:04:41 +0300
Message-ID: <20241210070441.836362-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'wlc_phy_iqcal_gainparams_nphy()', add gain range check to WARN()
instead of possible out-of-bounds 'tbl_iqcal_gainparams_nphy' access.
Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index d69879e1bd87..d362c4337616 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -23423,6 +23423,9 @@ wlc_phy_iqcal_gainparams_nphy(struct brcms_phy *pi, u16 core_no,
 				break;
 		}
 
+		if (WARN_ON(k == NPHY_IQCAL_NUMGAINS))
+			return;
+
 		params->txgm = tbl_iqcal_gainparams_nphy[band_idx][k][1];
 		params->pga = tbl_iqcal_gainparams_nphy[band_idx][k][2];
 		params->pad = tbl_iqcal_gainparams_nphy[band_idx][k][3];
-- 
2.47.1


