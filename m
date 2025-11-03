Return-Path: <linux-wireless+bounces-28512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D00BC2DF3B
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 20:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CB084E2144
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 19:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD5629E116;
	Mon,  3 Nov 2025 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi8CNnaz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1829DB88
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199780; cv=none; b=r7fMaryO7/qw7dMsHaVUlPy8PDALRbbIAg/u/Xt0jdG9QVirl3y02fWwLphbx1r2n/Q0P6Gt8c0YWGemq5az32+c2kjDTE4KS4QD30WL8gmteO192mL6ixsIBQkuHspxZL+BCY3EFItq9rXJYbYXjwvp3nDe5lR742EbOo+yfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199780; c=relaxed/simple;
	bh=lvQE9IXDjViYDaZqGsXBfbyMcW8IDJzareNHsQ1mwz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJhCBv7Sg5LpuauRH+BgKEpJrAd4rc9ZXA4eNZomD89HAukxCTJnpbdKphQSNKf0gNoE/rNZ+zXRcZu82jrpwjaFJWGOh7ahHNnDqoNjQdc7lecIiDCVeB385pK/Rw0F73Two7ZwF+v02fSxv0XvT+wRBKs2+kpn3kbRAAHMDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi8CNnaz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b0f54370ecso33651385a.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 11:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762199778; x=1762804578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCNIkCfDGhzdHNevSGLa4u02mQfcHltPe0YUYtYtgr8=;
        b=Vi8CNnaz+3rRH99TDTiJw+e6WztwnefucKI6lfr302cWROE1oL/tmtBOjZBryrFp3z
         Sa/auLfQoZe86wK7rnANd2Tz/GypT7VenF3aN08GUPTTODZ9WCXRjmNtRFilZNVZpoQ4
         dQcfVsAWsASeugTL8zHKGaD812KEPTm6clttBs6e4uQUVIGW43SceHi1riCKCCgilUNC
         5BST7z8pMrbWfuOA1VRCdf5IRHUIZSA8mQehB1BOai+JTNYXvpDECck1MbkZGq8si75B
         zbezMk0R7g2vvLpBLaVSFRuo3Z+l1UNUBvCDH5j6V8vQbz168y1OBa1TCSxYI6uF0KbS
         FbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762199778; x=1762804578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCNIkCfDGhzdHNevSGLa4u02mQfcHltPe0YUYtYtgr8=;
        b=sQJJki9rZ7FxmtshGX6gWsEogFth7TnWgY2sotkmogmVVcAXNFu6QtjCbRw4jR12dl
         1tlBmDkRnka9w69LHsmF7mCPKTCAwUqLH1bNV0nlJ8B/y98v8XJmgHT9oJQrn4urMjzu
         0PCZtas4Wmg4/ZDGftInEJDtLsaS9XDI5sGhU0jaO19Ve/w5VICzBUsmOk/aid/WqSsm
         YirDAamRZUe7Unj/RQarJse/rZh2Kq8oKVuqVgf9wITudqZ6zDBfmpjqVJnt9gfQZvKu
         Az3ZeNEDr+fBJPxuwMRvhK+oHzQQt7xHaeNVixAHLSMhqfg9lRSHCBagQ3qxbI3yzonX
         pbFw==
X-Forwarded-Encrypted: i=1; AJvYcCXDPYFNZcCoRd7dr+FnT94vEL/Ppw1kgHwKlyie4jPtA6P2cjTNTsIFr1GzgFFqs19IaZbRUSutnty3Ti2UjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+RQ7521NJL3g91r9KjXpUOr9/FV9XTJO5oMf2V+pgfEBzl9ZS
	tDC+pFNVykzu//mrI/zC1XCh5HE4i1znW5rK7R2iljkLGw95BGpUUGxk
X-Gm-Gg: ASbGncvlH8ubElRmhY0n+RcLGcXcqe9eM/VwkoJdFGdPehRO5RauSv8qT/hPQsve2Ny
	5SXqBBOmi1pJhPq1jfZITFhPpKYRMSJylUpbTQ8FSrMX9zisUDAB5jUw6jq+4rU10d1xAovm6yr
	OYjlEQTRJnPmgV5tXlcb4/HU/EO0mYXZ7aEsAj05r+1bCwlhz+YpC8ASnXEpE0CSVXb7qe6bZwC
	uxZID1pl9wFdDHmjuJ6u3BUi3Dlg1qtrm2xR7FCdnD4O9+mdaw3SDvZ/sDW9EjYOLYHi4YxZ+Cp
	+/GietZiV0HhddLE8j7wpUeWBigJPcfXDW0l/7+hN3QadP6dW5RW4WyTt6+NESn+sVGf+F1bMwJ
	XwdddzHz/xnWTnjfcyikH/Fj7ryCHOp70Xxx6mKXBLnUmywUnauP1P++rKpUuqJoatTjVuPa1wG
	7EziZKGuZ7woV8Nqf+gifAeTYFCDKzEHD++4DVhMdSbWS2vKXjWIdkQmwCvYoLvraOOkIoNDecQ
	yr/qULAmB3SmnLrS8NnqD5UD4agzGrGjvM27T6ZCN4=
X-Google-Smtp-Source: AGHT+IGoVRYSbVBd89q40CWkubpNIEtt6jIcApZg1DKN4itrnqMDZ3LKzFY5+VURygVr+d/v4qFT4w==
X-Received: by 2002:a05:620a:7118:b0:8a1:94de:cdc4 with SMTP id af79cd13be357-8ab9b883c55mr1524316385a.83.1762199778179;
        Mon, 03 Nov 2025 11:56:18 -0800 (PST)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f543a01csm47274085a.15.2025.11.03.11.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:56:17 -0800 (PST)
From: pip-izony <eeodqql09@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Pontus Fuchs <pontus.fuchs@gmail.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ar5523: fix integer underflow in ar5523_data_rx_cb()
Date: Mon,  3 Nov 2025 14:55:20 -0500
Message-ID: <20251103195519.3152385-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

In ar5523_data_rx_cb(), the `rxlen` variable is derived from desc->len,
which is provided by the USB device.

The function checks for an upper bound (rxlen > ar->rxbufsz) and for a
zero value (!rxlen), but it fails to check for a proper lower bound
against the size of the descriptor.

If a malicious device provides an `rxlen` value that is positive
but smaller than sizeof(struct ar5523_rx_desc), the subtraction in
the call to skb_put() will result in an integer underflow.

This passes a very large unsigned value to skb_put(), which then
triggers a kernel panic upon detecting the potential buffer overflow.

Fix this by adding a check to ensure `rxlen` is at least
sizeof(struct ar5523_rx_desc) before performing the substraction.

Fixes: b7d572e1871df ("ar5523: Add new driver")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/net/wireless/ath/ar5523/ar5523.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 1230e6278f23..dfaccf241560 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -589,6 +589,12 @@ static void ar5523_data_rx_cb(struct urb *urb)
 		goto skip;
 	}
 
+	if (rxlen < sizeof(struct ar5523_rx_desc)) {
+		ar5523_dbg(ar, "RX: Bad descriptor (len=%d is too small)\n",
+			   rxlen);
+		goto skip;
+	}
+
 	skb_reserve(data->skb, sizeof(*chunk));
 	skb_put(data->skb, rxlen - sizeof(struct ar5523_rx_desc));
 
-- 
2.43.0


