Return-Path: <linux-wireless+bounces-17904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAE3A1B4C5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 12:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 748257A382A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEE91D63C5;
	Fri, 24 Jan 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsTdII0k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB361E495
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737718438; cv=none; b=TLfnZgJ+xjR4Kz4EuXPykVCVjQLB8JTJlaGSpF2Zdrh9MzBwQjuzVtf5wRIfoENep+R6EvQ+0v8EDvNPpSR9vi5/GVPGZtjuKNOnr0HWqnfJesiO0bWjiKTJI1FQHgAKSa4ftQfwQfpixCzaHdg9v4YuGaSH1J44WhOyx08DCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737718438; c=relaxed/simple;
	bh=hy+xx9EY8mMRhUbJ1dJ508UqJBUWQQhM0ZOd9c3lLDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZoIq5EZ43hExf1+ie7ov7BrSXD7VEkzUUqEMH5sNKlTbL0DR5HjeLJfvorolYU1ewyJWTCcZp9lOmkQg6J8Pn4qqi9tJD/LshLpnMYJ1cyOQ9ZEaymgOW36vL6YhKRTnE2kT7/q9AS+1D4M4lNl7dofqX8wyb/dKZjCvf5O2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsTdII0k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361f664af5so22113555e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 03:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737718435; x=1738323235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZHTFOr6mzASyJiqjEsg5h+YdNb9ENSDizFr9pr9b9Y=;
        b=JsTdII0k4lVIFg/W7w00/lrwu9MpVj/jufTh1VdPjow2S158Jk/VnyOJkkI8XaSB59
         ns/jQ+F7og5eNQIVRdBXTZLbD44L+wXamqwuxyDk1KsebdwBc6FGwgEOorZSpQtVIZAr
         ex2QXU/TfC1Vt/dXmKViNowdxz+v8kK81UVL9mGBe2cyTmYLDTELH7WpW96RqTS9oJPF
         w9VuzV2JpQeX2YQsMvyB3JgHMcni2764tVBVAdznNt1acxYJpKo8+srDJ3k7Cfnl/MwN
         0r1mBxnobAUOWVSvLATeRkH+xTulpzxR+h/NvvFWJO+CL+zuGT6DhkVEkx98z6w1tjPa
         5vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737718435; x=1738323235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZHTFOr6mzASyJiqjEsg5h+YdNb9ENSDizFr9pr9b9Y=;
        b=JwASQH/ozMr0tvpS2EqXxsffc0NNoKlUOtlDWQUpV8Hmm8Oi/y3WmCuqwkhR5POsiq
         Yo7qhVON1WxrORUC38rr3J/K/XvDv3a+pfGsiP/4EVsWp3sYPGgE9AR4Dq/nwqq/NrI5
         aLByGOU9n4sWFgAseAJKT2J3kykW+02SfdejMHYcAwB03MVD8M2KHtuN9CABK6UeLfsG
         sGVWjli2hhYhsKXH0tjMq9qQyGMIDRFf3L+xpn1RYmgjV5Zucy+nIiQa+IcGumcyuTdl
         B3vTTRMl2BJVUaikU01RJbSjJe2SRRK9rEQPLUwWlM9Nbtb37dNwK06wV4oo/8pst4rO
         IJzA==
X-Gm-Message-State: AOJu0YxfoLZ+LZ8kz0eHwo7a0+h04RPYjon6UNmdwEqXPfE1I5YjOu/p
	6+XHE23FKKh7LyXDkFKyexVULVC99tUYddiOKfsWrMzxacyCvzRv
X-Gm-Gg: ASbGncv9m+guyaTydJnPxsPuz/UO3HSjcYXf6A9xK7swC0B5OZmj/k402UWSHT8CIM9
	hqWluMNpzK/zmnguiZHS3R79PBe/YJtsEvoZrf7I93SY8mvtlzYlGr3YkG9a5UpZAHlG3bOvNVe
	jbHu3Nk+OAbk8X+leo24NEhHs05lbPcwei2vtNfaEcJVoVXQRzNRduci9fybk3k1D7/D0IAXk11
	vjR8sxX9l2iG9p0j+EuaOVTig57HkYUbqDohUCslxPkl5p7jUd2M6dKZYitI+JwOhBKICFSApVm
	5vp+dJhKwdfDDennMDa8UXJDEtIq2PEMquJSRg==
X-Google-Smtp-Source: AGHT+IFIon0QxIEYkRWq8atTmgYtYSFe9y3nYelSDKpU30OJeKufnVQiJMnr7y5AXij/rREgQ3sWOQ==
X-Received: by 2002:a5d:6d86:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-38bf5655264mr27438023f8f.2.1737718434891;
        Fri, 24 Jan 2025 03:33:54 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb101sm2478153f8f.66.2025.01.24.03.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:33:53 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fbx: fix ath12k_hal_tx_cmd_ext_desc_setup() info1 override
Date: Fri, 24 Jan 2025 12:33:52 +0100
Message-ID: <20250124113352.93638-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since inception there is an obvious typo laying around in
ath12k_hal_tx_cmd_ext_desc_setup(). Instead of intitializing + adding
flags to tcl_ext_cmd->info1, we initialize + override. This is needed to
make broadcast frames work with ethernet encapsulation.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index e0b85f959cd4a..00437736e0322 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -117,7 +117,7 @@ static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
 			       le32_encode_bits(ti->data_len,
 						HAL_TX_MSDU_EXT_INFO1_BUF_LEN);
 
-	tcl_ext_cmd->info1 = le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
+	tcl_ext_cmd->info1 |= le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
 				le32_encode_bits(ti->encap_type,
 						 HAL_TX_MSDU_EXT_INFO1_ENCAP_TYPE) |
 				le32_encode_bits(ti->encrypt_type,
-- 
2.48.1


