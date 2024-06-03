Return-Path: <linux-wireless+bounces-8431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1330E8D8595
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 16:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4497D1C21976
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70B4A12;
	Mon,  3 Jun 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVZOqzRP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C9132110
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426591; cv=none; b=ZmowWMG6BxJ4AWhNHaLW7Mu29QyU6n98/PubXg0e1me3yliMy5LUxKiN5+o0H3SEi9H7teHV3cTFB7xVkqto5+OIPOVXOBwxBRiTRLMmEMKxtoPwYhzPBMpVzNK9mN976Nd8VfJhkYhuYUsnq0+4SF6+YzQq54nZcNbrpfiLf0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426591; c=relaxed/simple;
	bh=ow0fEWWea1jx2ZjaK8GJAMb/IDY9vQGpO1LNRUbvGi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNLNQAHyK5gbUftf9RXMdhfJKSIm2Yusj7zJV2ZElx79K7FLn+jLPOtMcnhWyn+9ablQGLu2u6WTTzHITqswZuD3AI5e8pCji8Bp02Wr44az2pwXmOO3As1yTkx/LOQiN2reWF6wq4th80R2QqMzLmADnX6/ZbAGazOJgQ6gBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVZOqzRP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a68f10171bdso176428266b.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jun 2024 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717426588; x=1718031388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktq42OAqjUxxky1D2VC+Am9p4JG4+KqAJfFuVWyhBGQ=;
        b=XVZOqzRPc6UQqqbVWrZ/JBwvwnVCaxepkjAy9ds4+OlhLQoPdV4f1fxUK7GggZEWcJ
         DUStmTwwdogrXnGUtDODXFdyPi3LySIM/uVPnEgnYxly4r7QYTV5+RdkPRx25rpWvJcf
         19YkftSVh8Umpb3UeABFXQdn4CNLJ5mOST7Goo517XfC3Y5oSXXbFpAZr8u2QDRWmXBU
         UwoihPXxfRY5Juwhfo8KamQ1DidIS4WFf/S4msLmO/oEk5Ik25lATmBz/usqzufQMyG0
         PuYC2jIzS+4BFDCeG7pG2L6FN2lZ4wrPoh5AJYYG4SIFj0knF7LuuSrIs78FL5xYirmw
         tU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717426588; x=1718031388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktq42OAqjUxxky1D2VC+Am9p4JG4+KqAJfFuVWyhBGQ=;
        b=M72B5lgIYeYRb/a77lez1jQ9xs8P1s4f8AtKiaTIC9LREeNITIAoPbNPPwaQO8PdYF
         XTFyt5cO8VD2KG8AD8iGdrEPKlKdprStiJr/3dyGJeVPIp7ofXs8yx0Kp9LahzZEwY/b
         OIUeqIs0lMrunkIfA2o9rc3/sigEqjnQnxUhdrDajHMZGXMS2jsNoyDLDook9OEch5KS
         K/J4AA7Si4e9o2vChNmlEI90XotylAQQWN0JZ08J/ABOuzu6jZ64Oh1b9c7/l35cutVQ
         28IFrktDfOys0xQog9KVlLHpWi0wCyG2FZr2XFnbmJ34wzgU7JkNhFSljjLWoErz8QLi
         sfew==
X-Gm-Message-State: AOJu0YxDacTl/EysRn3jICHKlmGnBbSvvWxgBErePWgIOny2BperC0RH
	raTLz0LrUJsUWP59FMUXI1xMVkrmvFc2hgEYlwYTLujSJUkM/X58CWoxbw==
X-Google-Smtp-Source: AGHT+IHD/upMljKdlZR1f4dAkFTQ0cKHe2CpRh7lm3gmWXdLkLglBLIz+/94KKUCKeF2g4s2jxdQkA==
X-Received: by 2002:a17:906:6acd:b0:a5a:81b0:a6a9 with SMTP id a640c23a62f3a-a6821c6e73bmr740719166b.53.1717426587410;
        Mon, 03 Jun 2024 07:56:27 -0700 (PDT)
Received: from mslusarz-hyperv.mshome.net (1779df417e104.rev.snt.net.pl. [213.192.104.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb3444bfsm494666166b.201.2024.06.03.07.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 07:56:26 -0700 (PDT)
From: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <marcin.slusarz@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>
Subject: [PATCH] wifi: rtw88: usb: drop rx skbs when device is not running
Date: Mon,  3 Jun 2024 16:56:20 +0200
Message-Id: <20240603145620.1858957-1-marcin.slusarz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CA+GA0_v1rpoFrRVxpKpYqOrjdxEecn_m3+RKwxYc9H761dpMvw@mail.gmail.com>
References: <CA+GA0_v1rpoFrRVxpKpYqOrjdxEecn_m3+RKwxYc9H761dpMvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marcin Ślusarz <mslusarz@renau.com>

Avoids WARN_ON(!local->started) in ieee80211_rx_list, after
the patch that disables power management of 8821CU.

Signed-off-by: Marcin Ślusarz <mslusarz@renau.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index e1b66f339cca..c25fd4b193a7 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -570,6 +570,11 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 			continue;
 		}
 
+		if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags)) {
+			dev_kfree_skb_any(skb);
+			continue;
+		}
+
 		skb_put(skb, pkt_stat.pkt_len);
 		skb_reserve(skb, pkt_offset);
 		memcpy(skb->cb, &rx_status, sizeof(rx_status));
-- 
2.25.1


