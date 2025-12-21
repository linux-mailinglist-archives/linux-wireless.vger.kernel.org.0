Return-Path: <linux-wireless+bounces-30035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A67CFCD4293
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Dec 2025 16:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56E1D30084D3
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Dec 2025 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E652FDC40;
	Sun, 21 Dec 2025 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEZBqOzZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F92417E0
	for <linux-wireless@vger.kernel.org>; Sun, 21 Dec 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766332702; cv=none; b=tfQg74gg9WY4IT535b0mgFcsjQuFCsyLXjuRgvjEpUxKjFvmg2PNgtbOIFy5otvkPmZxXeq96hbFnS90S456FPMNEw7EmQyG9kJwqpUGQFIDmai5TIjTF/o9Yv2HZwChHcKaRpNP6oBVbVtOJZGu4kDpqWY3mSX4AMJjRYrfWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766332702; c=relaxed/simple;
	bh=lkq5qhaPOy9GB/0N+6pHSvyWfFkF37st9nnLEmV0YXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQic/NBgRpYfeiSmwJkey739SuTS6TvZp9f32HE5wVdLQiYd7DMS10DpBGxW931m7KcbRrHuF4kSyEc9ngRwVGfV9nOSE6VmDKaMB4M+Pgd0Bcf/5xIQXE4jjyRGOIxXdP9WOt9uhYJs/ha3tQlrK3BsAAaXG/dw30g5oSCRXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEZBqOzZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-598f59996aaso4290206e87.1
        for <linux-wireless@vger.kernel.org>; Sun, 21 Dec 2025 07:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766332699; x=1766937499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kNeI+dhYeL+33zxK5LQPaTyz87+4mfQ+I3kJAxqFlR8=;
        b=AEZBqOzZtQijDxciz4EHE3NUb20C6SCtKaF4k+kkfwpawmpMdIPlwSdRSJlj4JS0DE
         q+R3vYQUMmGm/Wz88n7DN7EW24KzLr6bw/LawWWhblHgYlRwY1gHCnE3T7fXzuSGamIx
         eCh/wvBMgKZp17cfaLcqvWWMvHDgInCxavQIeolUUsiLgMBFkRdcuyopfw5GoHNhW+fs
         fyjZSr7QR8ajn6RgIo+MI9EHzs+tOHf337XjsaTJyAH5DNpOU83354/WL5CU/sEE/EKj
         UG29t5vnu4TRroN96kN/plwNZJ6ENBX38dHKkwa7wvwDE4g1qOQF44XdF7ggBTgMsX0n
         n2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766332699; x=1766937499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNeI+dhYeL+33zxK5LQPaTyz87+4mfQ+I3kJAxqFlR8=;
        b=NIac6IoV08PMrdPx+bTwVZ/DfWXd6bKsvcXi04oBQoO1ZGYUo6Sj7mMTib1RZ6gAa3
         qb9dT1Zml9ZSfQHCC8D6W4KMVcdOYT+HX/qWbzNKheaFgtzPyzG5k1Kgi2bayA/eWuGz
         3v+9/zl5t6JncpOhfhdPqwAVtnik9SciKBT6CKf9VS1fbpiB1VmLrKmu+dsBqCUUADwK
         +3Zl49E9ZFAeABGHfg/4yG4/FaaAaa2sjWCqQcOhI5NXpAs/C9L0ejFOmS2uwTK4beJH
         cwy32+MYncL0yCDzvWaJhEs+UAWX5sfumv5n4BS4V8rhJiK3jqhzy2fIy3rnCP7eBeJq
         hCeA==
X-Gm-Message-State: AOJu0YztKDou4Y8XRYruNrwp/SXurLLEEeYSnh3qW63vi5PF9HGHJLNy
	cWipBjSWwVG/EBN8KoU9MNrMlyQVCjB8W8Z0JGrbuxK7fUHO/m/D1BnKUmQT4yoO
X-Gm-Gg: AY/fxX57sJmq9h3VuchaEEdSFxGlR4BfB7YgWiDD+TZPGy65XR37M2wnvEZXBryNLSQ
	86Kb7TIGN3Esd8kFeyz0wI1oiX7d9ua4r7u3p0/RCjcCkBkPBtHg9JLHEKy7vQn4x/TnAZ3djCl
	1dM37fGWKFdY50fKzLS02TLWTs06XigXshOwP/QcWGLxV63buNaKJil3NVe752OB1d1uSJs/8oP
	t/v/GC/w3g0gaNMelYNYAg159QYWmuU+B/eEaqeR5qCTbuNaOABF/TfNgqvKlRcS0PhKaHae8AE
	iZYP54ldvd8CDII+SWe1T2IZUU1x9SqKyZqZOujnEgONRXr8+eMTEBltpeXlSHMJbdDW2oJPLDj
	yQh393U5bjK4MjOLMFsCorFIBuGu83DsBU7mQew9dDRppmi/PrYgbVeGowLUDLFDg509guLM2KL
	w=
X-Google-Smtp-Source: AGHT+IHdm338vAoXflPAN8iunsh7MDg3zRHLIvShdCzJhtVkx0t0KXG+vk8KpzbxDV4G5hGHMuLIPw==
X-Received: by 2002:a05:6512:ac5:b0:598:f361:68f7 with SMTP id 2adb3069b0e04-59a17cff3b6mr3446011e87.4.1766332698815;
        Sun, 21 Dec 2025 07:58:18 -0800 (PST)
Received: from prometheus ([85.11.110.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5fdbsm2379493e87.21.2025.12.21.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 07:58:18 -0800 (PST)
From: Szymon Wilczek <swilczek.lx@gmail.com>
To: linux-wireless@vger.kernel.org,
	libertas-dev@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Szymon Wilczek <swilczek.lx@gmail.com>,
	syzbot+67969ab6a2551c27f71b@syzkaller.appspotmail.com
Subject: [PATCH] wifi: libertas: fix WARNING in usb_tx_block
Date: Sun, 21 Dec 2025 16:58:06 +0100
Message-ID: <20251221155806.23925-1-swilczek.lx@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function usb_tx_block() submits cardp->tx_urb without ensuring that
any previous transmission on this URB has completed. If a second call
occurs while the URB is still active (e.g. during rapid firmware loading),
usb_submit_urb() detects the active state and triggers a warning:
'URB submitted while active'.

Fix this by enforcing serialization: call usb_kill_urb() before
submitting the new request. This ensures the URB is idle and safe to reuse.

Reported-by: syzbot+67969ab6a2551c27f71b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=67969ab6a2551c27f71b
Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
---
 drivers/net/wireless/marvell/libertas/if_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index b3c4040257a6..924ab93b7b67 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -426,6 +426,8 @@ static int usb_tx_block(struct if_usb_card *cardp, uint8_t *payload, uint16_t nb
 		goto tx_ret;
 	}
 
+	usb_kill_urb(cardp->tx_urb);
+
 	usb_fill_bulk_urb(cardp->tx_urb, cardp->udev,
 			  usb_sndbulkpipe(cardp->udev,
 					  cardp->ep_out),
-- 
2.52.0


