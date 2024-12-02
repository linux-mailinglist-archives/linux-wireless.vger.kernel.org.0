Return-Path: <linux-wireless+bounces-15813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886C99DF973
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 04:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0552CB20D00
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 03:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6602AD2A;
	Mon,  2 Dec 2024 03:19:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56E70805;
	Mon,  2 Dec 2024 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733109597; cv=none; b=prgvDSizveEFYhiabsdT2qVq44ie/LYhm3NTTRntnw/wW/ORAQl7q3jaV5c///bRLf2Gk3sw1oeRiZfr8Jval2KG8CRulwz/cCJgCOxIouqhr0J1f1BtveXIzdJy7mlWz2cKNJR4CidRNdB/iri5i/draYeRL0ev+g5bKtfAcMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733109597; c=relaxed/simple;
	bh=Nl0cH3ole0xzuAuTHOhtcuqlHx62T9z7X863QnqDIWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJTVx3Kov5FpW1fGKbfEQNiKKeHGfhZycDlm92/nAUwLXTFm/DDSOLYtrmt/bVmBSKqN8ynmRNW/Kp8tR2TktP1/Z2pDxkec+BAAZVYukI7YLm/BUvJeBmP11jnYVyvJSeWwUF16c7imKa0f/+JIc5Ho81s5QwdL/dMZECLmoBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso930363a91.1;
        Sun, 01 Dec 2024 19:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733109595; x=1733714395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7PGTzmjpPUY4RIlcJXB5Q1jmNe+Wfb9Ofzi2ziDYRw=;
        b=mJFSpwT21bwZUZ6/GRfOo7CJ50+78Z8WqYIqo41aJy0bFL8DnYa0jh5p4XNY9Bst0v
         Yt37Nt3D/ZX8f5Qi2q5LeQ++MRDJo3FT6iY8UuQQWA6kBOhQObqtD+hGxDDONEK9qX1q
         4tAr2lXYp7/OHJHJnK3NFrOmbCvjmj8TDR++zPYyOBh/7SQWZaZprBJAaJ3ZUiu3TyKv
         n6GJ6CQVfFdVvIzwvYdyFICC/RxKfXrtL3TiVnntjRcLunKIWNG6o9A6hvrdnBDG1ZaP
         BhuQAxPTQiPgVb2OxlGeLIQzmzsw+/PZQGqByp8fJHVCtQXUSDiXM0qatFWZpWGHLDU2
         EYVg==
X-Forwarded-Encrypted: i=1; AJvYcCUW/vMPwTxV5u4P67qIZfezWUIG58iszqlQGaKA/NI3SFYugrn9IGd7FAFpCHR3FCZR67tcetJDxxFDpWI=@vger.kernel.org, AJvYcCUZjxGn/DkAvx7E/Uj16Tez3OPZoOtYSjIbx06FRTusyCAOpDTIaiY0UriGS2yyqKd7HW2UHjVM5AQ5Y2w2FLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT2f68IPvAlKSVzRgvjRXhRu3ccN83pok+8Lly1CO9cks1J33m
	Y3Mf4p7PM5iqB9W9v0IvyOu6DLGW0bPNHGUieRvastDtisFmyb66
X-Gm-Gg: ASbGncvceTINtVdnwHpYDwoH3S3rjIp2slTTsRTLalZ1YLS1aQ4RanGlY3DB+cw0O2F
	dxVhpHRawwOerDwYlpysbUe/VL9RwyhomuUh1AYre4UaHsjH8iv/Rgs4ynKX/vMwvTHsivcDPGO
	fLnF7kO03MIuZYhbodDkHdgSkZumkpBN8oIXg0PHNenSyb8CLEXCTWBWCfan0MO20F6/oGTfa+Q
	UauR6kQb6DD7pSAfb3jnc0fjcQx784iY2tueVWV1jkZLiTeLIZKcPXKBeD6aH5nb1URQzEPVw==
X-Google-Smtp-Source: AGHT+IHPuvPyPPD6cvd+D5abHos051/bvNzDVRAVaVZTftg3J9BWL4z22siyBxu7rg8pdYMhYTe9LQ==
X-Received: by 2002:a17:90b:3505:b0:2ee:b4bf:2d12 with SMTP id 98e67ed59e1d1-2eeb4bf2eb3mr4701338a91.22.1733109594893;
        Sun, 01 Dec 2024 19:19:54 -0800 (PST)
Received: from kylin-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eed19aa971sm540723a91.1.2024.12.01.19.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 19:19:54 -0800 (PST)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: howard-yh.hsu@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	Bo.Jiao@mediatek.com,
	sujuan.chen@mediatek.com,
	chui-hao.chiu@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	make24@iscas.ac.cn,
	xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH -next 1/2] wifi: mt76: mt7996: fix overflows seen when writing limit attributes
Date: Mon,  2 Dec 2024 11:19:16 +0800
Message-Id: <20241202031917.23741-2-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202031917.23741-1-luoxueqin@kylinos.cn>
References: <20241202031917.23741-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DIV_ROUND_CLOSEST() after kstrtoul() results in an overflow if a large
number such as 18446744073709551615 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.
This commit was inspired by commit: 57ee12b6c514.

Fixes: 6879b2e94172 ("wifi: mt76: mt7996: add thermal sensor device support")
Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 5e96973226bb..3a175222f8ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -85,7 +85,7 @@ static ssize_t mt7996_thermal_temp_store(struct device *dev,
 		return ret;
 
 	mutex_lock(&phy->dev->mt76.mutex);
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 40, 130);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 40 * 1000, 130 * 1000), 1000);
 
 	/* add a safety margin ~10 */
 	if ((i - 1 == MT7996_CRIT_TEMP_IDX &&
-- 
2.34.1


