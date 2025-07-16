Return-Path: <linux-wireless+bounces-25547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA2B07B94
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 18:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B9C1891659
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46ED21CC4E;
	Wed, 16 Jul 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axSyWosD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826F17BD6
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684907; cv=none; b=Y08Jz+ouynr352M/SR/e1xqAUp3MYeBwD6kilA0lY58Qpt5VZdQC41FRjNNktnM0JPHdWkDBGKa2y8lYAXfpi8UuSp+7PCVkhq5xy5UaGr1K4CkasojQPW6W7pSkNFmBykrBAnhlTZnUvbaMYWLc0tOelh/gza0v6XiYAgJYpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684907; c=relaxed/simple;
	bh=BObnVU/QmOm8UCJaw0U4L5pMhQ2SzxjYDWHlVfa7iU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWTRvAWX8oKevtdrl+cPpVkkavvponnQMffFAmLJfIHcD0scRCmpnblmmhx1KQMXaoCOURBYJTSbuITZcwqyc3zv3zqyoypNE7QCFJXEYmGimXeuukRPs6tLefdB9dAqojytrL+kSVbdTh2st1emi6DSkNDMk6BQKmyDWGjZ1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axSyWosD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so8061066b.3
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752684900; x=1753289700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qSfhvA5DDk0Uw+pNRWZ1+jpEl314OEr9sJWy/5fHeVQ=;
        b=axSyWosDcDopRhV43Pl3WDmlxzKudB2yi1D4Uk6z8LfGgZHytL/kDriXDhD8dnEmjj
         cfPrJMFp0QhjsX0B1JrJWnZuWobgqPcSEQjKqbTdq0/uojW0ZxIAwi7Jwaf6crfEvgxJ
         mFxTmsIkNX+/Lt2uEjofGRXltDcZxO091AFvHIHOrfm7RUNy/Z9hYcGLQQ8/ERe5hh9H
         mxUY96uyGj59CV6hNLsIZMAfRIjYlIlUw/qvZzANyCArofISs+jY0xvVGDmhlXi3DyJp
         4jC5psMC/AWULMmakcfgXkUVoSajmLTUj60Q6e7Zg6RKXJP2Q2Chrt5ITA/buzfDeIw7
         JGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752684900; x=1753289700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSfhvA5DDk0Uw+pNRWZ1+jpEl314OEr9sJWy/5fHeVQ=;
        b=c1yL66lAOZWNyDAIrmlh3jZsKagJQ6Tfr8gMqKpxOEf4Dvm7P5aV+K6AXjoznDz24p
         hm3iAtQJAz/Bz4BNkzbmYeoVzf8vjA5H02VekwaaHgAwAENQfw96XMVuZS8szksNEVvi
         /461qdEivfpHLdKb0h8JFP8SsvArpsxm2xPkvzz0WITyZKkS5wBBdSG80sUB1WZwNJeB
         Ge3kCj/XDj79OUrX006MUn3J51G/SacKYpSzkjvchZwk+vWDTxeIaeN3sHZAAoY7gacf
         ZQgqrvXhxIlrATrPeWlkSSbh/kA94hFx0N+0I2a4XkkKU5au4bRHplszNiRhy0VXkIOF
         TIVQ==
X-Gm-Message-State: AOJu0YwxL8x051uOfTG8AzOefR9fpHUOXciUI0OPe3pPECxyj+N6Kbi5
	xXVGymJTT/3N+vrGcQ+ZpN5Iymm8A8Tw2yO3aAeq9PrAeKEsNWoHYT47aQ6KTA==
X-Gm-Gg: ASbGncsU2mEk+nPom9axDE9iZWrLJgfqG2ahVn0WUpwRyq2aofdjWsrksU25KWPe6n4
	MRIEf2B4RJ9Lau1CSkfWZL5T1envheOF6yz2GoSr4PwpBSUdtlVxKsxSHIqtdnNf9R3qJLpcBgc
	fGF2UEApiY1G/wIw/hc8Lhiv1xb/2HOm+s7MsUYPddtUydnTwDKWQ/IA+dhUiFsLvSn4ESkbq5v
	X2/X0DgcN8yBtbKuSg2IQUN2RiT1bIZA9HyoK8AiVFeM919HunccV8eRs7DHPiIHhl3JrHyFfoV
	Xft8knriBzfEhdKkcMY+3HeJuZAlEBdvSB+Aj/Dh3EEaGdeg1KcbKie7qBi1E3FaXrj0I9f1p6R
	mnjll2IX+QpOKlhLwycUqG2rp8JHPnvFR0gyV6v6o79ScsVK5WTpmgwP6c74U
X-Google-Smtp-Source: AGHT+IGMqX0ObWsxX6vxQK/JhldiEX/lhBm5ZOtzK8L5fqzSIO5mXHK0in2vynXziOqquV2gCgKKzw==
X-Received: by 2002:a17:907:d38a:b0:ae0:b604:894c with SMTP id a640c23a62f3a-ae9ce10e832mr309124866b.48.1752684899972;
        Wed, 16 Jul 2025 09:54:59 -0700 (PDT)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82669cfsm1205851466b.83.2025.07.16.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:54:59 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH] wifi: mt76: mt7921: don't disconnect when CSA to DFS chan
Date: Wed, 16 Jul 2025 18:54:01 +0200
Message-ID: <20250716165443.28354-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When station mode, don't disconnect when we get
channel switch from AP to DFS channel. Most APs
send CSA request after pass background CAC. In other
case we should disconnect after detect beacon miss.

Without patch when we get CSA to DFS channel get:
"kernel: wlo1: preparing for channel switch failed, disconnecting"

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 40954e64c7fc..5881040ac195 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1459,11 +1459,8 @@ static int mt7921_pre_channel_switch(struct ieee80211_hw *hw,
 	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
 		return -EOPNOTSUPP;
 
-	/* Avoid beacon loss due to the CAC(Channel Availability Check) time
-	 * of the AP.
-	 */
 	if (!cfg80211_chandef_usable(hw->wiphy, &chsw->chandef,
-				     IEEE80211_CHAN_RADAR))
+				     IEEE80211_CHAN_DISABLED))
 		return -EOPNOTSUPP;
 
 	return 0;
-- 
2.43.0


