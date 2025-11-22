Return-Path: <linux-wireless+bounces-29260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E186DC7D645
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 20:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F36C351615
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 19:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE30E2C1580;
	Sat, 22 Nov 2025 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLsk/ZiY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B9C2C11C9
	for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763839349; cv=none; b=inEFEmrXpH/G/V60tvdevkTo2AEqK85S3+sbm/x4cekY8DqyEK5fO6neLiGLChfy0M3CVHtqGYPDjxeAEvZ6RE55P7vwx4wVROfPBb3L3vmFgZxz+4QGvjnvGAxIAnXKUZyJFGCbQyV+XptoIyST/bmc0UDDTUBfQS13+y6+vAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763839349; c=relaxed/simple;
	bh=Nv8No0C0xLcsG15+YA8xb+P/x5nTE1FDnmuasstlKu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maHAxJAQSeOyMU5FVbJuJ/Ee9ZbG1DlwWQJhnsPRhH2iTi80H+PO5iCIwRb8yVus7+qbTYNrlQ7vFRdLldPuzIHzp5aM0ttcxq/s0V0iP6k/tgMBtdc0wpspN16x+G9lMoQ3mKdQ4XMFYwE9wpa+gIb0D0iZ1MBw6IYZ/JpvJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLsk/ZiY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-644fcafdce9so4735667a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 11:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763839346; x=1764444146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUSadXQNRFjDuFnbdZigKoHybbmKkhY0LQ1b00Pjt68=;
        b=XLsk/ZiY6AzhTRLrKOH5Dxrxiu5yLpfrUkeK57lP8Xu6RgXB/pMfWx/B2qy/aFkkU2
         rwkuZv7r/VP2sLKuzaQNtUdTUBT1vyfQfiXJqZcvXAtIIDnLXjaXmnqdR+34SigHQOOK
         n/WVFs0OXtLTACuNACtUHVGxFzgDhkunSywJzRTzvYpC2ooVFTZiX5cii7ksJ/XzgwX+
         XRlNlGwkVnkP1kxc0tUAPUulSXJ6wtNoocjqVickj1KWUOc3th5kEv3ovVMcreGMD5/t
         CVbUxe05OYn2yW0votWqaTxgF+Xpg9TFZsE/Zx3lo15a8FTkiTR6bL06cBUmi40rMNCv
         srLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763839346; x=1764444146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUSadXQNRFjDuFnbdZigKoHybbmKkhY0LQ1b00Pjt68=;
        b=Db/hwLTwSg0PUC34nzipkUI/LGbarMuWJPE2303RwGBP3b8y4ZsWMHHVZo3vjTHsqk
         8A5hcrPdz2oj0fhu2PxtV0kxMJXvqNdve+7oyKAMqiUnUcFOrZL+5OHNzp023+nYmgxa
         zxWIi9OWj8qa42r+b9B0M6aKYZBWYJuX9/obvpw8NFsF0zRIZt+sTb6OfCV6HrE7OhAW
         834uqW68iYjOfCFLlaxSr5N83U2xNRt4H+/Oo06Fj2yzfk3IwhFV9+GksHJMdlNhExIf
         4g0IrEbiXAfG2graxtwvmyQ/0Ypyp2XUvn/FmHtmKybH6ZVjbwthuRJLoJlv71p23E6k
         F3/g==
X-Gm-Message-State: AOJu0Yw2+yK3LceQtYFINeZevfMYjPGImnf3gF6BgzR66pgIBOfMyQnv
	zrX7cCo97FtZgkIlpLRypR+aiuZpmUaoPJfIihgnzH9QTvZAoy0kS8nO5qHkmn+U
X-Gm-Gg: ASbGncudyglhE2qBx3CuAC1g7e/y7qlGwog48xO17IKw4a+Qy04aSomlr8/dZ+gVeYE
	+3z6ZxnHq3rtGtZ81OFb8/rGmtSGjjCVgSe6Svb6827k0iFqxrbaDAkpUzgH3hThMwAOFawml87
	HpZ/rW3CMmTjPiJXGHItBUdaW6zOGfC7i15k8NHmnL3T1vj2qmUIHzpVW4Bgp3ki/7WyMbKkFcR
	mEcQ/SimQC/N29CNUlYn2akBD7l2sawUxb5rrOa4i/Ub1PXzoGoVi5US8+nBx04w1wQIJHfvRT2
	UHo+GTT7RgvH09M+T+BBJquG31Knk/RNofSAJXZkRzCgBR9tBK6P8v7UeO5GmePp2DF0O9JqWAs
	LK99BOIMZ0rEtwA3bjDxkFY97IbGEbr2YRBhv6NVprCsMwEltVq+csjwPzf5pkgTPrRXO9vgeXz
	N7K9Ok+O4JeduxIWSxIlSndhiPGr3uerxEUxv26dljiqKT8nWQtU8=
X-Google-Smtp-Source: AGHT+IGzRPXeyIoyl46Wswp3AEqncAPp3xfW1JEx6I6hzFHhaAppkd4xOAsp3cy5bFz8oOM2ow9+Og==
X-Received: by 2002:a05:6402:27d1:b0:641:3b4f:4dc8 with SMTP id 4fb4d7f45d1cf-6455469dca9mr5339522a12.31.1763839345748;
        Sat, 22 Nov 2025 11:22:25 -0800 (PST)
Received: from hp.lan (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d321sm7517378a12.20.2025.11.22.11.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 11:22:25 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v4 wireless-next 3/4] wifi: cfg80211: events, report background radar
Date: Sat, 22 Nov 2025 20:17:05 +0100
Message-ID: <20251122192204.6866-4-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122192204.6866-1-janusz.dziedzic@gmail.com>
References: <20251122192204.6866-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case we report radar event add also information
this is connected with background one, so user mode
application like hostapd, could check it and behave
correctly.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/wireless/nl80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f7c118bb8bec..40f8a8f3dc08 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21097,6 +21097,13 @@ nl80211_radar_notify(struct cfg80211_registered_device *rdev,
 			goto nla_put_failure;
 	}
 
+	if (rdev->background_radar_wdev &&
+	    cfg80211_chandef_identical(&rdev->background_radar_chandef,
+				       chandef)) {
+		if (nla_put_flag(msg, NL80211_ATTR_RADAR_BACKGROUND))
+			goto nla_put_failure;
+	}
+
 	if (nla_put_u32(msg, NL80211_ATTR_RADAR_EVENT, event))
 		goto nla_put_failure;
 
-- 
2.43.0


