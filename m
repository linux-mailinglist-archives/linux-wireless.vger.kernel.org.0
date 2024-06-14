Return-Path: <linux-wireless+bounces-9008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A999089F1
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 12:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB271F21227
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FBF1940AA;
	Fri, 14 Jun 2024 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5Bwq0o6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437FE19414D
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360932; cv=none; b=Cb4I8mvE8v7WNTB+9V9Ax9X06xyV2I4ou+qsfGchRmJ6ifckV74vfYeUs5CMdVTGlQDELviCPcca2KShDOO0F3g+7MlOLg5glG6JFUJVR2L247Z1xVrXRE80X1Mpar2d5jGnA1XXDzbqYDgx3ZYkI+c+ZxIxE7jDsk+fr37I4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360932; c=relaxed/simple;
	bh=wPWwJRRIaoSICVwJZc8x8QfxOZ0r9W+zSR0QF3AOlrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0cxUR+MsgxzxrwCnXgK+oxHNcWkRLmnOIMAIFrOMZ+GzBwUUYAqspk9DSossnACHch2DTvvAhKmmgvYVCxjeFSLoq+NpFVIQzBkJ3krmOeYBehOYmNabqt3Qo75ZBU7hqZ926EPEnvx/qNpik5p6drgEx8Pe19+fJmpRDeCOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5Bwq0o6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57cbc2a2496so1602666a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 03:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718360927; x=1718965727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIavNrSwHK3DKdtt5n1tn0yzXiZB9uoF5USbtpIYRHs=;
        b=V5Bwq0o6S6o0jEBpENhxnHUHqH27hJN8JKQ4SwdUGqNvkYVpyNdxna+qQPKWkdNHTi
         kYDYKLFWwMHAUYsdQ+PLB/MU/XolXnDKd0ag9kdyx77PC41TPScTTWKqa5spM9DZnqQh
         8iMm3qV+o5avUok8SQaM8B+TtkVZrdzPqapG/CI/poc1S1c46FX+vn/cxGK5aL6yM/bn
         Ffks8CnAhDVB+iZ0dj+hOIvpYfbY8wf/jMDK7JYHxQI2+ivV2CDXxKImWSQQLAn+lDS+
         A0LRP4xZ/MYu+EHupgW9/XoDpZKb5BNHzh/RszJf05utER+oLF43lCfB8nmjbb+8jLRq
         Bagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718360927; x=1718965727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIavNrSwHK3DKdtt5n1tn0yzXiZB9uoF5USbtpIYRHs=;
        b=mi0Xpy41YyoQw2hW47M+DCLP+Sdcmovd9h47+dJ2mZKh+aPK0PG2D4e0dId17I+J9X
         0NcfWrJhN0c1nJvdEYQ8tyvQo6ypz8h1RB6mfB5+eqbHH2pV3hw/WpkPEmu4ntU8OltG
         KCGXNL4OnPisOVx1dFULNN13ZkEgt6BK5gvVoroIdI0nD91nNNt6Eju6TSxmygxe1QIT
         ZNAAWHK/WlzzJI6FURH3DVJ1t1l+P8FULy8iImNrnX/xB5PLEJfLPdhuq+qO4uWnovOC
         qpI626b64Ff59zrFaFUxSpIRU+2CaR7EKKCCIXH9Zw3vK6KuFlanmiERTagadUKi8HkM
         r52Q==
X-Gm-Message-State: AOJu0YyBeYIWDyNVkAjK/8asQ4p0+9As0mguDz+t1G2Oczmfk1zz2eZ3
	G0UK3Rk2Tkv2ZSn3lFn7w6/RprccfqOtGq25Y/EFgL3ylvbcaD3G1lF/ew==
X-Google-Smtp-Source: AGHT+IEv865GQxhTdi/MnWJLdv7FLyTs2tZsdXtM5C7B/5l2rg6cxqByxa2WY3ZzxvQSFT9MRV9lJg==
X-Received: by 2002:a17:906:33da:b0:a6f:1445:9de8 with SMTP id a640c23a62f3a-a6f60dc4f22mr202845566b.54.1718360926769;
        Fri, 14 Jun 2024 03:28:46 -0700 (PDT)
Received: from mslusarz-hyperv.mshome.net (078088142095.jeleniagora.vectranet.pl. [78.88.142.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db61f6sm169006566b.57.2024.06.14.03.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:28:46 -0700 (PDT)
From: "=?UTF-8?q?Marcin=20=C5=9Alusarz?=" <marcin.slusarz@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] wifi: rtw88: usb: unbreak multicast
Date: Fri, 14 Jun 2024 12:28:35 +0200
Message-Id: <20240614102835.518348-1-mslusarz@renau.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CA+GA0_vcUneM4Uo8fg0=4sCK049uhjv+NskotRbNg9Em0cnyUQ@mail.gmail.com>
References: <CA+GA0_vcUneM4Uo8fg0=4sCK049uhjv+NskotRbNg9Em0cnyUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

High queue is not functioning, for some reason.
Broken by 076f786a0ae14a81f40314b96a2d815e264bc213

Signed-off-by: Marcin Ślusarz <mslusarz@renau.com>
Cc: Po-Hao Huang <phhuang@realtek.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index c25fd4b193a7..aacc5a105b15 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -492,9 +492,6 @@ static u8 rtw_usb_tx_queue_mapping_to_qsel(struct sk_buff *skb)
 
 	if (unlikely(ieee80211_is_mgmt(fc) || ieee80211_is_ctl(fc)))
 		qsel = TX_DESC_QSEL_MGMT;
-	else if (is_broadcast_ether_addr(hdr->addr1) ||
-		 is_multicast_ether_addr(hdr->addr1))
-		qsel = TX_DESC_QSEL_HIGH;
 	else if (skb_get_queue_mapping(skb) <= IEEE80211_AC_BK)
 		qsel = skb->priority;
 	else
-- 
2.25.1


