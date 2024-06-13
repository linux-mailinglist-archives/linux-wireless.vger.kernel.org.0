Return-Path: <linux-wireless+bounces-8957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36A1906269
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44AF1C21A27
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3561018028;
	Thu, 13 Jun 2024 03:04:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1813440F
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247864; cv=none; b=UPjZZY0qE5t5a1/0TYs2Kk85dt35fY/CCvWO42GnqEy61LZGZFBElTkc6TVb3dYCkuSR9t6l+FZCuo4kBMEAk9n0wtPruFXbiDDYFqCYdq+L1eLYBAbjZTSRZbrBZzWQFMn/4v+Aou9H8KIOzyaO2B35KNbOYKJ8xhi1cFtSDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247864; c=relaxed/simple;
	bh=X46nB7yMp0/gqmqHnr6a8KtwWTNIE5EIsP3Ib0g+0c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOMP+/2H+FKKMyqkI5EqnVMv0JwkrEStXCtQgv9NGR0AyTP85Em8HfN9x1O9gKs7J378C9uR5x18cTf/8frmJuX+SAyoX+W16lTqVf3uh7MOS02pK4iJ0HbITx4c77soVHgd51ulAVkKdlwX2eeENcXLMRM1WkCq0Ak5SxqKDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24c5ec50da1so92155fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247862; x=1718852662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jO8Gc5RDctWw/ZhCBLlPB6OeGfOoPDaHWniwL5VRGE=;
        b=gZgTxxNrwKx1MQ5+DQyvu3NctTk3IHTuLbyijoTaWX/LmDPUBflstgUONLVMEASakc
         Vg05IQGaOqbg2l5wFQFY7UyvI4GnszPW4jg3mlPPe5EpsZoORRglyXeRMLnqgdjcQ2VD
         wx/4FshF/guk5vr5GYY2Xz6pIjwy2CFxJvBVsS1vWn6wRB4SZDUdDA/Kl4IyZbqV5J+x
         B1DOoLfUNbGu5GpACOwDvMmoXqQ035of/AmV/lRvSXIqB96smA8LbZb3zXtq8fRdQQHA
         MM9XGacrT3DwBk8o8eg0W1XzD4v4iUu6kTlRqa1Z0t2bNpd1/xBdEThNuLbXoxFOqRCh
         y0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV6VGblz3xHpw+So8QdsHAS+aibaPKk873eA2cCDIieR3//rybQ5Y1OITK3Z9r0PbW0avZB96rpHoRQlWFfLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcugqvp51nTSH6XiVphSKjv0lVM7a0z1aQaBltGZoSskRzYCa
	GfIGowqc7BFyECX6cljjlz4MmIyW170KzF7jDaZGcB1/j1d4MNd+
X-Google-Smtp-Source: AGHT+IFGHgXP29zx8KF95nPLg6SntZXj7M9MxPR4qFdAyLnNZf/Wwbn8J1+lymEzEjIjt3HPXJT4lA==
X-Received: by 2002:a4a:8552:0:b0:5ba:ca86:a025 with SMTP id 006d021491bc7-5bb3b7a9135mr3998243eaf.0.1718247862043;
        Wed, 12 Jun 2024 20:04:22 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:20 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 47/47] wifi: mt76: mt7925: simpify mt7925_mcu_sta_cmd logic by removing fw_offload
Date: Wed, 12 Jun 2024 20:02:41 -0700
Message-Id: <20240613030241.5771-48-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613030241.5771-1-sean.wang@kernel.org>
References: <20240613030241.5771-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

The mt7925 only supports offload firmware making the fw_offload check
redundant. This update simplifies the logic in "mt7925_mcu_sta_cmd"
by removing the unnecessary check for fw_offoad.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 7156ba092302..c0b27d28a6d1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1643,7 +1643,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	if (info->link_sta || !info->offload_fw)
+	if (info->link_sta)
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
 					      info->link_sta,
 					      info->enable, info->newly);
-- 
2.34.1


