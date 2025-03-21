Return-Path: <linux-wireless+bounces-20671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B5A6BD1D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 15:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F133B982A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 14:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7061DFF7;
	Fri, 21 Mar 2025 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAAaP09q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB31D798E
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567742; cv=none; b=O4uWibMjmXWMWC7zpPtL8+/uGqZGkQN9S4o1cq14LgRz6CmCNuzR34x3wWb0OZ8DKanYKWCiw+D5PtyknEcqEpctLmSDUoIeC02sD54pmxueuxASniWP0WXEQQgBvIJgWXSgvh+LICjMGtOd1FmD6zFmwUA4fUX13EpA8A7fJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567742; c=relaxed/simple;
	bh=2fWMldJmgwMUu39tdUGRd4PbG+rFiQ2bc0jCTZUfh8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CLOQUkRyO1mUPUsYwe8i/xl5SliNTV8bPYBN/4v3mpC8cT87VK5ibkICgAuNwDCO3daxyGJQ6+fKAvI3XoJ0VRK5qSUC3KzWV7AhTQ0Wiyvdcs57B5gG1AEbzJnsAVuIQ6lX+WBvr48CXvPVJkV5tk13hIvJiv7PSCWpfMG+UFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aAAaP09q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3996af42857so2085091f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567739; x=1743172539; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PPRppdrVJ7KjI6wixZGEvPAU+S5utOovE0gqiXmI0c=;
        b=aAAaP09qNuJblyS4TtpIdwnKa8aYrpNyeRhPqWeeQSFO1f1eE5c3k14Jfel0LkSBt6
         nnHwpvKWEjjnlv/FrgIIssRMLWtVqaesxqr3QGq2scm76uwOzd5Mimg3A3tXp7KUFheg
         /IxbIZrjbJ3fFFND1LK9ItekDVG9YLnDNxCDFpmj/Wf7nfj5+X3Dl+66kdXpblOoMVuE
         2cDroYA/mKt+8c8nvYo/+7Z5cYjSoJPDEoqCw4/G7VCK0vfMXHOUncYJ2yfNmagirg9M
         JhpNhJVr64SWvBeCMiIOiLbxwunGI0E4Mc0eDThYfIT+TLk+P1xB23RnJrxPT7hO0JcQ
         nuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567739; x=1743172539;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PPRppdrVJ7KjI6wixZGEvPAU+S5utOovE0gqiXmI0c=;
        b=gjl3BNH8pwPfrboEENbIVy6A9HOlZ7n9W61ixTEyVauxHGBhk0T+dvombykboOrlUO
         3wq5eDQoc1ZIbv1cRMfXLuqFtoNZKU2CUUHE4L9wpmKD5JUCQEqTIIvCgXWM7EzPNtCc
         z+Nvkp1ec1YDuLQE5+AnGyjwOjMf7eidbbp+PtVnaVGYiJesMqLaHSHXSRizRmUerGsr
         Sa0gDmVzX0iruAgJyVtloK2RPkZ8N6zwGbwHlzQJDB9B79oezvQYubD63wtHRzh4fwwM
         cWYH1qfOFnxSEB4hqZ0kG/z83vmimT1VduSY4P5nKFctuhLxmuzwTDuLCFcxudk8H6Ya
         hpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7ly3W01fwen/k69t8CCb3R5E5nFl0yEGolJAcUfGHbq4RJ23Fr0SmSmiT20pjCFycioomJh1k7o+fbrLp1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMWl+6SGcy7yEGCg3byG7BvQVLrzTB2cRPs48DhhlJmzW6v4w
	DYWKSJcs0jEyepUmBiEQ18yUKvzj/q0Q9fDXd+14S3kt6MafLe2QuKTyfGB9Xfo=
X-Gm-Gg: ASbGncuMD4BPIPrPQSQNJralT/6A9sTj+uiJeCKDzYmD5bgKczMGHwiU1Anhwnb4Y9e
	C/3+T2OISm4n64b6F0hRKtgKmxFQ6A9GsB5NKtO2AfhVj94gifzzNpWmO14RuIiy5G7auv0iIGm
	2cgYYorT7S+fGdyfW3XUpRNTyEcqLuiPfJf266YBC6qkpkTO0vmtxZWWitQ4JkktsmrAmGKzquv
	DrPkD+NZ/n2o5jLMX5OVj6xhr+4UBK0z1kXONMAQPdQYzROJtM+skjmPm6Z+YblEzYmLm8hq1ik
	tx+1vw8Dn5rNbNioAHZMeKA9JVPc2PYG82GkV4gJIBVtgXRdRg==
X-Google-Smtp-Source: AGHT+IF2afE+amq9nc4FEedeUCaZRhGRjLvVfJvTuEgevNOAdUUfdZR/acRzOI2V9GG7bPnUNFsa8Q==
X-Received: by 2002:a05:6000:1fa9:b0:390:e9ee:f27a with SMTP id ffacd0b85a97d-3997f93e053mr3439159f8f.28.1742567738601;
        Fri, 21 Mar 2025 07:35:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9b26a6sm2493540f8f.44.2025.03.21.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:35:38 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:35:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>,
	Howard Hsu <howard-yh.hsu@mediatek.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7996: remove duplicate check in
 mt7996_mcu_sta_mld_setup_tlv()
Message-ID: <fde7246b-08a2-4c2f-b2dc-c3fd0e6b300b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "msta_link" pointer has two NULL checks.  Delete the second check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index ddd555942c73..03539e20f5c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2242,9 +2242,6 @@ mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 		if (!link)
 			continue;
 
-		if (!msta_link)
-			continue;
-
 		mld_setup_link->wcid = cpu_to_le16(msta_link->wcid.idx);
 		mld_setup_link->bss_idx = link->mt76.idx;
 		mld_setup_link++;
-- 
2.47.2


