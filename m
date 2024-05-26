Return-Path: <linux-wireless+bounces-8069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE978CF6D8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 01:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8CF1F218C4
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2024 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F317552;
	Sun, 26 May 2024 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BptGGv9u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD41A2C2C
	for <linux-wireless@vger.kernel.org>; Sun, 26 May 2024 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716767067; cv=none; b=Y3JCIP0JsgpjXTnxX/l/oI4TulbjUuBX5Jh2zy1775j351+JBOuIUm1vs3ONh029imWEBOjassypFKLJNOs+G5NxL0M90BBa7QgMzTWZsqQbbkJ7Ej3fI5r51opMRZqSHmZOCygc8Or5fRLpyzgD1XvdGCyOqGUG2k36Lf8H+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716767067; c=relaxed/simple;
	bh=EG/v3ldJQ0swnVDamUNHUMEZeKXEvin3Dy0Erpva3sI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kM1qdmDKoirTBuDhkyu2JMo1bYDsl/1ueVl9DQvssSRJsoqgDHVsXdlao4SdEGgx8L4d0epZnBkKsIvFk87LkhQaPdsyqq/6WqCPopZhC0tsntbJSpPbc+QLX179ODsNPF72ASsuUKpZK/FA1cw0ZsIefd2wFZ+wJLS4T8lhL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BptGGv9u; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-529644ec0ebso3470365e87.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 May 2024 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716767064; x=1717371864; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YqcIR8VHl37tK5h7WdSzO/hWbEWN1LVDAobDz25bb6U=;
        b=BptGGv9uEP3WZo3X2hK4dn2floZgr8qzQz3vaZVZo5vEGdnxiU7CqOaKexGGB0QVeE
         GUYnMQAyU6ev0GIgp7zXxDi2mEXKBnG1j1tj01PCO4t/HF7ulVWWfkVykNVsdIfQ2dqn
         3MsgaTECy8rP41JVn0oBzHvpEHOCBl8a5QhtqcWX3RLPWcJAU4RqBGwEgOqzAB1xaXjd
         ljziXdF0aTaOWA9aDK3pzqOS1jVCzrhg0WgCkkp0ZhRbavQ373VRcwrv0GWBkGLVQnzZ
         0PK5BppE0+7W3tK+I256kupZxnqj6der9MC7kn7GMkmSV4U5dh3PSzrjZZrss443LRDN
         vw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716767064; x=1717371864;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqcIR8VHl37tK5h7WdSzO/hWbEWN1LVDAobDz25bb6U=;
        b=J6qAn78C42MgLhTa+/35X2ndZE8jOwtqA8Otbn6URtmGFxVOyguPAWc4Kzfg26i312
         RixdI170/CP60fBnycGyKII5ar4gno1MA9fwxbgzJOTBi3vh1Q+FXm971Xar6Pdk1R6e
         ut4iGP/ncb8oG20uCBH/QIinWl5/wyM8VR/44/se7ggSq4J7vc8JJ6r9JnqpTFxgnFsR
         sUC+fwvEdaOPBozY6UrzkbE+Z3WrG46Rv7XmYutPVXiHmVxHo5DnnTWbpE+pFSJyxn9V
         2OCbGVAlv8w0VMnexltJP3hXcsUXysu2yL1Y49aaVzfx6YELpq/649YhDNyZqsY4wszA
         Im/Q==
X-Gm-Message-State: AOJu0YxUxNuvlAxfX/SuJrkkNo4ZJPoYR6aq9KyqV0ZU09ZvnrjVl4LL
	xYhZyfSPGROnrzRNNDcLnzkmv3zhSDcR8gaE8diRuPGWiTLKsTVSdup8NskemBfVG3Iob81e7xb
	TWhjbxS+cFs7nLXpyxQ29I1Rt5Y9MDG8c
X-Google-Smtp-Source: AGHT+IHfdvRv60BtdhYXAxTuAOpugBrxVCQo1KrMjtHoWKf4cC1bjlif7iwt46DYbZ7WwPvv8TJpwkS5+lg9udN3CLs=
X-Received: by 2002:a05:6512:1390:b0:522:2ada:c02e with SMTP id
 2adb3069b0e04-5296736b884mr8578358e87.53.1716767064181; Sun, 26 May 2024
 16:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: James Dutton <james.dutton@gmail.com>
Date: Mon, 27 May 2024 00:43:48 +0100
Message-ID: <CAAMvbhGyheFdWSrDzM_i10n9s06n3G2wX6O_S68VUZyP-a9p+A@mail.gmail.com>
Subject: [PATCH] wifi: mac80211: add input validation to sta_stats_decode_rate()
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Validation is required as a result of parameters derived from
received wifi packets.

Signed-off-by: James Courtier-Dutton <james.dutton@gmail.com>
---
 net/mac80211/sta_info.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index da5fdd6f5c85..bab05c6b1bcc 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2437,11 +2437,26 @@ static void sta_stats_decode_rate(struct
ieee80211_local *local, u32 rate,
         int band = STA_STATS_GET(LEGACY_BAND, rate);
         int rate_idx = STA_STATS_GET(LEGACY_IDX, rate);

+        if (WARN_ON_ONCE(!local))
+            break;
+
+        if (WARN_ON_ONCE(!rinfo))
+            break;
+
+        if (WARN_ON_ONCE(band >= NUM_NL80211_BANDS))
+            break;
+
         sband = local->hw.wiphy->bands[band];

+        if (WARN_ON_ONCE(!sband))
+            break;
+
         if (WARN_ON_ONCE(!sband->bitrates))
             break;

+        if (WARN_ON_ONCE(rate_idx >= sband->n_bitrates))
+            break;
+
         brate = sband->bitrates[rate_idx].bitrate;
         if (rinfo->bw == RATE_INFO_BW_5)
             shift = 2;
-- 
2.43.0

