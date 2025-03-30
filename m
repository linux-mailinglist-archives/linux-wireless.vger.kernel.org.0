Return-Path: <linux-wireless+bounces-20961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7567BA75922
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 11:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D386165C49
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEAA142E67;
	Sun, 30 Mar 2025 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJmpxFiB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FA78F30;
	Sun, 30 Mar 2025 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743327266; cv=none; b=oWyKyL/c/5XV/5EqJrtN0I7cc7DJqQtm8i62sMLRETwhU3H+P8xoRovmnLNkSnrXoScA6/x4er1GTI99Pn/yR6KxVcrRHe+BzPfrYtywSvPmB9Dl2B6A4mX3sOOgqppBHOc+M4JmUN//B2GzMS+sunnIZ+mhhwckhZfm3PZiFTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743327266; c=relaxed/simple;
	bh=vg/RGGBlj13dMmxRDoI/Meh3KgmZiOmKNYH/NewU9EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPQTcuq1+68JzJ4cJoIfiA5tfWfdZiMW540crYjDNZZWqzG7+g6oEd+TrmuBL4fzl/cLOMl4THh/6JPcM+mkhcyPxF/3tJNHoVYMkkGgrA1UGJFlmTyNgfod4nhSo77Un+4Y1oHuDBEvHLS0NBhrh33SRMjAb5U9Xl0UV2VwnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJmpxFiB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-301cda78d48so6351935a91.0;
        Sun, 30 Mar 2025 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743327265; x=1743932065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6EyuDgU5nrgjs6np3Q+Arkgxw1FSBvSpF/CHI128gA=;
        b=EJmpxFiBObotrR4X4rcA0kLiEafUD5nc1pRqejIHKzXTN8jdQgzgJyHGV6YmbFxn0c
         CvYgGbVkY0ygwRYVl3uB3uJ3g3NbT12ic4CYvFuRJqDxXomCM6h56dfR4nVC6f3NBA85
         pYDT3A588vkI/YU7BRcAe14mgGoFpJl9MdKf2ytPTmAvn2kqYJ4ZI3Km9x5gXcQycQq1
         QnIhsH6aXjveHCaGNfMhR1vjqb2+5hcPUZwIsq+8YfvqNCG3uUc7V1TAlpbi0qrle2u0
         aiOzG7qFM9WfFTAmfcMdldPbAv+C8NA5QGVDxJpqSX2S3bzi3PXudFc3LwOA1UMpImqW
         v1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743327265; x=1743932065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6EyuDgU5nrgjs6np3Q+Arkgxw1FSBvSpF/CHI128gA=;
        b=lY0Cs7cR2CEtVb4aGSEDUbpDadefXahg9DT2Q8uB0trQrBFTO0jt3Xd8OCo2Yt6w9F
         ON21gFWVsubf41lsQmVA9vfVo1Yvtxwr1VNynuuKV0c4V9qhuRkWRIH72aheOWb99MIV
         6b4n0/TFk+RUuWNJhpgKuvxF7oTMSQXJX8IrWYrujFYI0Snu+pp7eoisgtQIT4KhdniQ
         XYaMMe6m78UgEOivz6u40Ek0giqslzYZWzYd77vScbmErn35/Xbr9nJToz25fg5Xm2PU
         yuY5pn5le0amORH5H0bf1x9g0JgTsoKQxNsesx18dm1K5lEXFxLQ6tP6JfKmhW1ZIEzA
         7yIg==
X-Forwarded-Encrypted: i=1; AJvYcCX4VDQihcNJwPCQbKUEgxkBiQkEFAe4f239spB5OxVzqjEQVYzWwQUjZQ47DmfT8vaI8/rWEoxgbKJfrrnCmUA=@vger.kernel.org, AJvYcCXxMvXe8B/3CsRL4LC7FHbeMgEVkZhx9K7sYPmR8OE+Sze9P+qIOLVmEeTNALRPK/i22aRajL1cel6G5uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpFfBVWFPpbDDiS7Op0Sj5lvsKhu1MPklIdJLSbCA/rv3Bz84
	SoEey/ZchmOJg4n0u06odbditrfju0IBhbGGtedDuz9Nz5MCVIKs
X-Gm-Gg: ASbGncuvIGImikrUvCVoRJCeEw629vhCSt4n9HTGBYiIml+kvjLCKiwLmo4P7eW04Em
	0KCZ6m4caMIqe9V5BmZx+sTn7AFgwBF/d8MwVc21OD5G1f9Z7Fh0zUm3F1DvdeVpkNUmX2BMxW7
	pv42IK2ENk8+TE6w4wmNplEixK28JpSs/SJYBGULpPKJlqTz+GoS8iNTe7CDT9MYI46NL2wHMGd
	nQAy01cNxYHAG+chRLt1caXghs7d5092fq7FKAGnvuqUanxCjSUm98iBown447KUsAzbVaYlRCl
	LDqS5cGgnwXhCVPStahgmNIQMjB/rRw2gQli3iBVaTyfwTDwDSN6dIhK9Vi7
X-Google-Smtp-Source: AGHT+IFyL1pjZCQp4GL7b6jIJcPDa4HAki2IAGE1aOItt9UReNJfeQH1Ua6anvfuTfjFTOIxtDZphA==
X-Received: by 2002:a17:90b:134d:b0:2ff:69d4:6fe2 with SMTP id 98e67ed59e1d1-305320af42fmr7635668a91.16.1743327264644;
        Sun, 30 Mar 2025 02:34:24 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.226])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2291eec6fbdsm49065855ad.16.2025.03.30.02.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 02:34:24 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: johannes@sipsolutions.net
Cc: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	erick.archer@outlook.com,
	kvalo@kernel.org,
	abdun.nihaal@gmail.com,
	miriam.rachel.korenblit@intel.com,
	emmanuel.grumbach@intel.com,
	linville@tuxdriver.com,
	khoroshilov@ispras.ru,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix use after free access in at76_disconnect
Date: Sun, 30 Mar 2025 15:03:20 +0530
Message-ID: <20250330093320.22293-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory pointed to by priv is freed at the end of at76_delete_device
function (using ieee80211_free_hw). But the code then accesses the udev
field of the freed object to put the USB device. This may also lead to a
memory leak of the usb device. Fix this by using udev from interface.

Fixes: 29e20aa6c6af ("at76c50x-usb: fix use after free on failure path in at76_probe()")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/net/wireless/atmel/at76c50x-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 504e05ea30f2..97ea7ab0f491 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -2552,7 +2552,7 @@ static void at76_disconnect(struct usb_interface *interface)
 
 	wiphy_info(priv->hw->wiphy, "disconnecting\n");
 	at76_delete_device(priv);
-	usb_put_dev(priv->udev);
+	usb_put_dev(interface_to_usbdev(interface));
 	dev_info(&interface->dev, "disconnected\n");
 }
 
-- 
2.47.2


