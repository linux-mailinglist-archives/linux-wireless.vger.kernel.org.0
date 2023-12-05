Return-Path: <linux-wireless+bounces-434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C42805AAF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 18:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710721C20DB6
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846036928B;
	Tue,  5 Dec 2023 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="hGdueItI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D07083
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 09:06:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3333131e08dso4520800f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 Dec 2023 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1701795996; x=1702400796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ugvsFKAItoLjKrCDlNdSuts7Cy16Xu5/2UPE/n5rav4=;
        b=hGdueItIYsb0IklhxfY7lgRwFdsSfVpM50G6FbA9fvWS/Jj9MzhMYzpzN14Y9g9oS9
         ZeQRsYt70kvKVpEwINhUgVR6eAXg/c7kTZDHfeQucgv2Y+UT0SFJXYPV2j1QvvQZkCiX
         X4Miui3+c3+PTyYqblbQILCBoks+wCjVD2v4Wuo+K5uAvm2Q7yMspXodAuvUkMznp8C9
         ZUdksj/6SPs9/GTdXgj2ukSLdAsAAMBXLfxodGxq1sJQEx1ce/ZeLMwq3DU0jLjgq7DP
         UMLobjTrBZ8xwLh9vbrwup3n0nxOkjLq6VKlXzbP4f6++kxSnQDB0rjqTzNd8WkjsdUj
         HQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795996; x=1702400796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugvsFKAItoLjKrCDlNdSuts7Cy16Xu5/2UPE/n5rav4=;
        b=uMmeFCV+15zEj6v6gJYq8vmS5eD7LjFadytwKcbs9ZKbtGVF4CGS+FrT0yVxz4gPTB
         XOFhpz4h1L+9HZKKtQQcyrNFN08FPaLGRKD4HkgRptU+4F3NsK5kgeVnJrtLQl1/d+WH
         1s2OmqRzCqoe6TicrTX1AqhshBeHuJhoWpZikug9mZxTKFh1gMZ+r7dDjzIWI2A10aXZ
         uuwtHgoMfSsB5i9K1CT0tIGU+rRJaCFDbjlAD6MQqOb8gduTmP8BI2/zb4sXf9W730WS
         tPsQ9El+VbQXP25M5EWUypcgAvQ/2ozmw6KplIvyFGYHyK/iocqW8VWTPUXVm8Yd3pAW
         AT4A==
X-Gm-Message-State: AOJu0YyI/9yCboXKrqJGS61UtahMzFsGcNEBRJt/shKskJvCJtZV3ON5
	WNUuUKysvB2727k2J8R0RPxNFw==
X-Google-Smtp-Source: AGHT+IG+R60Nr0QhTNVmoezS3c4T8UEQKi0hHB3s288YAdhH7cBiBcFIaQIX7knoHmNK5qYeYG63rA==
X-Received: by 2002:a05:600c:1f90:b0:40b:337d:cad6 with SMTP id je16-20020a05600c1f9000b0040b337dcad6mr675246wmb.29.1701795995896;
        Tue, 05 Dec 2023 09:06:35 -0800 (PST)
Received: from hyang-ThinkStation-P620.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040596352951sm22922250wmq.5.2023.12.05.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:06:35 -0800 (PST)
From: Hancheng Yang <hyang@freebox.fr>
To: toke@toke.dk
Cc: hyang@freebox.fr,
	linux-wireless@vger.kernel.org,
	kvalo@kernel.org
Subject: [PATCH 1/1] ath9k: reset survey of current channel after a scan started
Date: Tue,  5 Dec 2023 18:06:23 +0100
Message-Id: <20231205170623.3029689-1-hyang@freebox.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the `ath_set_channel()` function, we only reset surveys that are not
from the current channel. This leads to the accumulation of survey data for
the current channel indefinitely. This may not be the most optimal 
approach, as we want the ACS to rely on the most recent survey.
So reset the survey data for the current channel at the start of each scan.

Signed-off-by: Hancheng Yang <hyang@freebox.fr>
---
 drivers/net/wireless/ath/ath9k/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 859210b586c2..bb94b0dd86bb 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -2383,7 +2383,22 @@ static void ath9k_sw_scan_start(struct ieee80211_hw *hw,
 {
 	struct ath_softc *sc = hw->priv;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
+	struct cfg80211_chan_def *chandef = &sc->cur_chan->chandef;
+	struct ieee80211_channel *chan = chandef->chan;
+	int pos = chan->hw_value;
 	set_bit(ATH_OP_SCANNING, &common->op_flags);
+
+	/* Reset current survey */
+	if (!sc->cur_chan->offchannel) {
+		if (sc->cur_survey != &sc->survey[pos]) {
+			if (sc->cur_survey)
+				sc->cur_survey->filled &= ~SURVEY_INFO_IN_USE;
+			sc->cur_survey = &sc->survey[pos];
+		}
+
+		memset(sc->cur_survey, 0, sizeof(struct survey_info));
+		sc->cur_survey->filled |= SURVEY_INFO_IN_USE;
+	}
 }
 
 static void ath9k_sw_scan_complete(struct ieee80211_hw *hw,
-- 
2.34.1


