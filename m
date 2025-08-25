Return-Path: <linux-wireless+bounces-26574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35038B335AB
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 06:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3A1165D47
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 04:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA027BF7D;
	Mon, 25 Aug 2025 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIitUTgQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145A279DCA;
	Mon, 25 Aug 2025 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097302; cv=none; b=M6/uamd1Dn6keEF9AveTGZXrmrddd51nBkDG2SrClaVDmOWOSjqp1YX0izvR8XXYieeWvjZcMY7tQRDVVX43+hMoo5cECPIn8Tjl65FmEzAFE22U1ngVo3xhbO0iW/TnDs36XkecH9qiqBEc/EIMNCwDbpY94vpRiVDOWRxeuwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097302; c=relaxed/simple;
	bh=W40kY5wbvrujI3XoYcNY8F73SYmOlQZdIoEMWzKo428=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yzvd4ly+b9aH4QRCGP35cTnSlr9KLFp8RV0N2eYpOM378kOVOKv/vWBIKs+wj0McXvM7JQoiH/s6YIqLUHtPWkHSmYDInRx6+S2aMgwHxmLJOW04hg3Q08ALfjKNF7dH7wPf9YhORuYbO7/F71yzX1uHT/cq+OtUoBM/Zeg45Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIitUTgQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-770522b34d1so821994b3a.1;
        Sun, 24 Aug 2025 21:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756097296; x=1756702096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zksa426wZGWz5xoWsOiI60ErY/o4m1oTspwldflGbw=;
        b=BIitUTgQ078Fgfzy0Ws8TqRPth67z4pBy0+ZWzd0TkmWsCPvjl6apTCvQhDxBhWupy
         gTd7K/l5hybgQlfWRtFvGbB8qKHXJH1Y3ZuJCfjpi5g9lo2cmWeVHfRhEBFk7L0bHv6z
         XHuxMS7jT4ChCOrVMkfgmQeVYXLBq1qyFY1QXOrrkGZ5pyXz0VF8nNyn0uBl8ltIHNNu
         iNzMzALNLfPZl82seJbxmqBUbUNc6SsO9JF/YwJ3DnPRlyt8WY7jwz3NaSz8g3NNvhMU
         jsVheZg0QF404F1RAD6qUmEB2ZHx7OephPv1EwtRlT3jr9uyKuAlGXziixFWYwj22q4B
         5uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756097296; x=1756702096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zksa426wZGWz5xoWsOiI60ErY/o4m1oTspwldflGbw=;
        b=r46TqXWiRynf0Q3h8nfM5riq7bd4byOEklVF7yaQNXKzIgqQqDWXvuyObMFUy7HNsv
         jhiEuQ2qHnIP5Mfa7DZHWeRRQdjcF5weW4V+2RR93Wg3nq5FVVRS+AON+NNh+3gmXKjd
         L37nnRqoCnD5p31QMIzIa1JikHS+EYyAy5AWnwxvoxF+02mldzyYVqdGBsqS3qs3WU4l
         vQ7K9xDcXD2Kmzea2FgYyWoyAbUoI9GQ2B0eQwVRGzEklgqgk9i5759OnghxDoneLPRG
         IQv/ix0FVrVc+EAdTJNHGMbzQhPQsZBDKK5cAT6HkiRm8nKnitgr5fhnvjfE4PQ3Ml56
         ZgNg==
X-Forwarded-Encrypted: i=1; AJvYcCUDLoXfo3V92Kg64tDwiGTb3z1EGrl6C3QUp8lCJi+TeU7XkIrfxFKVeppqlSaXKYfRTOeJhqiCs3RM@vger.kernel.org, AJvYcCUsBxJHn/RuWa/ue/cA4wt40+3pchsvzmyzQzru/9QlFP8BxUxF1i7RcwkuSEZUIv65Y+TOnrzV5iHMJ8xm@vger.kernel.org, AJvYcCW2BMLdzV6IPSDbARFPxzSb8GeHd03/hnWl1YlhLQJPpSdrbjo0RLDkNFSi2D32hg/v4hIm2cRjtfGmTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbStgtyTCf8wC559zx0F9tOx35o2oIlsXim9uZJq3ipd/bdmBR
	SCOwb2kPuA9Gy5BWXFw+6kARtiDnhmFVI/EgphmAkGvNbRTpHGUT+HEZX1I/PA==
X-Gm-Gg: ASbGncusYSHZJcMA6q8P3d7ZXN/L3nN5Z0FON1YO9mc6iP7nOcxzT9PsFsu7Khi5gGy
	kYOXeUKqi1lrVIastI7zmSEUjmLnU0PleA9u53ijRcREa5K8lrSi7q4yYuA0odJaQGn+Vtn3sB/
	3i1v2V6dKnBNy2j4xJJMVyXymaAJsw1Yn4HyMCgSmhPbY2nh0nmpmU48LZVg0/f8RCqmgrQMfCt
	2KTe6YY58glpm6PnBdjaVwSc/dApWuyaZa4H8XIYvRDVbROP4xcRDuK4Yon0y99YZ6ceOMaoLFv
	So58qaoALkDS2LWcwe4cENNlK1tFoOc9Uh4ZAYqMi9PS4XxqGSUKI5ojjhIdmEXKW3Rcel0UqDi
	AYhzDCaNYBKzrspZ2BSOhn8LyskxEwAFy6T5m3DQfcVQMtoUDY5ccddjJUuJKqo8w7Q==
X-Google-Smtp-Source: AGHT+IGMbvA1fRQJwmpM2k+yGypRyBq83t7qsLxSLdp+YurVFWf1dWesggIrkclU+8wcpw2f098ezw==
X-Received: by 2002:a05:6a20:5493:b0:240:10d2:adf5 with SMTP id adf61e73a8af0-24340b57600mr16289611637.2.1756097296348;
        Sun, 24 Aug 2025 21:48:16 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770400010a1sm6170153b3a.43.2025.08.24.21.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 21:48:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv3 2/3] wifi: ath9k: ahb: add led pin OF support
Date: Sun, 24 Aug 2025 21:48:11 -0700
Message-ID: <20250825044812.1575524-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825044812.1575524-1-rosenp@gmail.com>
References: <20250825044812.1575524-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old and removed platform code had support for assigning a value for
the LED pin for when the default is not correct. Effectively a fix for a
non working LED.

For setting an LED to active high, a negation of led-active-low is used,
as two drivers currently use that and no drivers use led-active-high or
something similar.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index c911b178dcc2..269a792c3256 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -662,6 +662,17 @@ static int ath9k_of_init(struct ath_softc *sc)
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
+	np = of_get_child_by_name(np, "led");
+	if (np) {
+		u32 led_pin;
+
+		if (!of_property_read_u32(np, "reg", &led_pin))
+			ah->led_pin = led_pin;
+
+		ah->config.led_active_high = !of_property_read_bool(np, "led-active-low");
+		of_node_put(np);
+	}
+
 	return 0;
 }
 
-- 
2.50.1


