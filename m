Return-Path: <linux-wireless+bounces-10564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A26C93DF66
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 14:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759861C20A56
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48866F2E2;
	Sat, 27 Jul 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTDsDIRL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0A351016;
	Sat, 27 Jul 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722084659; cv=none; b=BS/A1n9Cnc+/4y67uwd0lN688/w7VFPUR3GHi3cdBFoZcTbSX6KaKApge1GNxMJsmBgNWh599L7Xle1rynOl/Om6/ONt0oeWDYYQImH4HBfZxjhGfskev2zPSQ19N7bFQaLQsW2DFOJV+V5bhiZT/rVqnV7fBCCkIRj3365eoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722084659; c=relaxed/simple;
	bh=daeORxYFFkHRNTRySRS69lWfO9yt2vMF0zZaT96ryvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rs+ACVYE7gZyfAg/3Y4CXsmzsjhJT2sTUYFqwChQICLtrPJdqnr05cx+Yz5CC+zVnWTvWag9T0EYoJZnPRuG/l791oDCRfprT77QK53sWcTAm1w61wBOtvhxtJFGIKk73QyNfhERCco9m+M0hfPRgZvPilyJ4SQ6U1U93x5s04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTDsDIRL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-368712acb8dso319037f8f.2;
        Sat, 27 Jul 2024 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722084656; x=1722689456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YrSePS2tjkAvXk+3ojAAHSx1Ti5vY7/fuIVJdHRQLH4=;
        b=dTDsDIRLjN6CiliOuya2pzCI+RPvJEWang8A8XGlmXu9+e++x13EeIEsnOD8+2mRaV
         4hcr1UXopzLYjePhOPy3C1no5J3c1KquZVuKJE2Uc+yJHcTpXXDZxrBXjh8ZqYRSgJsv
         PbyW42c3MSrBb0DaerviUnj40Fw5qqhPO0Yi8CS679Is4RjpV+cDVA6oS8XPaXcFQvfE
         gAj+3AAlNCh4DHeG5UBlNPtrsNko0PNuh0Cm0OwQ5cbBZj6nMpFqu1qr8nlJxtZa+E2m
         8Td81E+VvGWqRwm+epZuWw7o/hdjEQNEOx8oI37uoctZZqZ5CEd/3dZjAt1puzu1pP+K
         PXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722084656; x=1722689456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrSePS2tjkAvXk+3ojAAHSx1Ti5vY7/fuIVJdHRQLH4=;
        b=voxfbPxSVaWVFE4OpozxrxNz4pXMbmikBEVGEkzMSfUELqcjXm0i3MtOUE5d29r+L+
         VgmJ87pKjbM4m1g6d527J+ZsxnzvheikYoJ4jlvTQsEwvk+boq459O1OeIdeXkdZNs9W
         W2cxKdHcoLj4nWV7qyUIAY2WT3gGlHOpl+/Qvypai2ZW3BkENV1OTFM9XqA29CPuVnpZ
         OyxOArDH7KMXDwVB39tbQQVSt/DFSu6hFnb5nnzN88ftyavtVCfD1FIpNCnwl0TA7JW/
         itdqg8T7wCKdoZW3M7KraP7Pt1tfl/uuuwvSL2OR6knoPpbxAM/G1nkBxg2Bp15HqCHh
         hkfA==
X-Forwarded-Encrypted: i=1; AJvYcCUKhNQjp5VJ8j4x+9JbUuaU4MKBIdUGR7tm6/ocdVVRd9/RQI2ePNI3FM+jYWBHCVtIvIjzVw8Rd2Db4Cc7BdG2mkrPng7ekiQO/ilT0ADzTA0oUWoK0c2gwCfMzFdx
X-Gm-Message-State: AOJu0Ywvtb4lOiz9VJdlCOTeO2+So5jRo75eyCzBfMEY4OYus2MRXQv/
	F+PS9Wb1uwVz7aZjgpvbSaTj/3lfOBw9AmbvQxsCxGYfcl812V35
X-Google-Smtp-Source: AGHT+IGTlhXQcIAISdmF0dJP5y3BG7A66wxgRwdaUabvKjbB5K/oAgVKfT650r3iMkZxiElhM1zXGQ==
X-Received: by 2002:adf:e5cc:0:b0:366:eb45:6d55 with SMTP id ffacd0b85a97d-36b5d0afc01mr1749663f8f.49.1722084655778;
        Sat, 27 Jul 2024 05:50:55 -0700 (PDT)
Received: from sacco.station (net-2-44-141-41.cust.vodafonedsl.it. [2.44.141.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b368638fbsm7489383f8f.103.2024.07.27.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 05:50:55 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: johannes@sipsolutions.net,
	sashal@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH v5.15] wifi: mac80211: check basic rates validity
Date: Sat, 27 Jul 2024 14:50:33 +0200
Message-ID: <20240727125033.1774143-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

commit ce04abc3fcc62cd5640af981ebfd7c4dc3bded28 upstream.

When userspace sets basic rates, it might send us some rates
list that's empty or consists of invalid values only. We're
currently ignoring invalid values and then may end up with a
rates bitmap that's empty, which later results in a warning.

Reject the call if there were no valid rates.

[ Conflict resolution involved adjusting the patch to accommodate
changes in the function signature of ieee80211_parse_bitrates,
specifically the updated first parameter ]

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reported-by: syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com
Tested-by: syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=19013115c9786bfd0c4e
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 net/mac80211/cfg.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f277ce839ddb..85abd3ff07b4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2339,6 +2339,17 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	if (!sband)
 		return -EINVAL;
 
+	if (params->basic_rates) {
+		if (!ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
+					      wiphy->bands[sband->band],
+					      params->basic_rates,
+					      params->basic_rates_len,
+					      &sdata->vif.bss_conf.basic_rates))
+			return -EINVAL;
+		changed |= BSS_CHANGED_BASIC_RATES;
+		ieee80211_check_rate_mask(sdata);
+	}
+
 	if (params->use_cts_prot >= 0) {
 		sdata->vif.bss_conf.use_cts_prot = params->use_cts_prot;
 		changed |= BSS_CHANGED_ERP_CTS_PROT;
@@ -2362,16 +2373,6 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		changed |= BSS_CHANGED_ERP_SLOT;
 	}
 
-	if (params->basic_rates) {
-		ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
-					 wiphy->bands[sband->band],
-					 params->basic_rates,
-					 params->basic_rates_len,
-					 &sdata->vif.bss_conf.basic_rates);
-		changed |= BSS_CHANGED_BASIC_RATES;
-		ieee80211_check_rate_mask(sdata);
-	}
-
 	if (params->ap_isolate >= 0) {
 		if (params->ap_isolate)
 			sdata->flags |= IEEE80211_SDATA_DONT_BRIDGE_PACKETS;
-- 
2.43.0


