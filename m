Return-Path: <linux-wireless+bounces-29284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A644C809BE
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 13:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 655594E4CD9
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731271F4CB3;
	Mon, 24 Nov 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="kn4sBauE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A56381C4
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989021; cv=none; b=BjyoYdtlcOTqX6PIaGEcj/72saH3mlrNFVi/RcMxDIRCBaf+wRXdIBX/b34c8dCzcnVT31prGKWODLuGAsm4saIaIg3n3NaiWP+O0gHuaM9g3KyrHCI7GOAExR28INeje4jH2k4GYn40lAedNYQq0+XWQnChMacvVgnMRCbZdMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989021; c=relaxed/simple;
	bh=DZ6daHKe6tsH/7KkvjoZax2T7tJhaO2XlO0bOTWDK74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=slSPBOJzp+IrF9TTfjrDixs3jvI7ruDV7SvXRAw82j7mEBbtLBVbYngj/8/a9GLSWX3hXWPX33ak9z4HkAnI5jo+kHONqrewbsIE11X2Zn/hAGvwpDRLA7KDmWQ2C1Fl9wPApd1TP5gkjS6HXamEjGf3CJyzCCTkMwO5KlzIbHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=kn4sBauE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso2619294b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 04:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1763989019; x=1764593819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6pcuS6eSJpyUobyjhS4UZKs6ezzMq2e67y52CNqKOU=;
        b=kn4sBauEPRlYgFYvg2/d1ZnTSAhYWSV/uq1V6/s9glN12H8F4MxwG4DDeGTlIw4E2B
         oXLt0zWWROxRf7leKAIKMduMR4xNulaAE0m/pR7PYAlyf69OCmaYHZ6uFI474CklHP6F
         T7uxtSdtyxVpND9cXjC3w7KgMaSq1Ee8M5cVGauMFauJlxzA8uFwjzUTvo/GZ8+LtHEL
         nOWZ9HDJInWbt59czzYtbQFezd5Tn1S34Ton4/cpsYTdk8hJpUE3bev5TzH9xVqnhgB1
         3hGfrFS52BpeIwaND18W6+T4EliDut1We7QlaFvuIhe5QPfOIwbeEZw3DkoBnJmhNw+T
         p6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763989019; x=1764593819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6pcuS6eSJpyUobyjhS4UZKs6ezzMq2e67y52CNqKOU=;
        b=Y7jBiJ/cPJzZ5QbJ0hrM6J52vkcEueQfs+t3yhWxn+SiBpEXAKUrAnUBNs/JxVNJ/L
         1/aFxbyko1ugb2nEh1dPqlY4lZK+lj1g21rdOeXMgHveC2oJw1jNxs3bWBvW1zEbPFkc
         ESQqs6CjfUaDaEllHZ4+0wa61hFEXoGJ12Cjf8tQS6BOyWUmBjqAdNmqjDrVaoLcWtre
         NrQMl9/iheYTqchn/xC0gEblLVcxpuJtz2jqbvbxWdsTUJ/ZQVgIj1wMPeJ7fTjwV8hU
         yknd8yC54eZkR1BSz4o6DHi1pKaVnHogTpVOSGvD6DAeTYYnqWK27kSmlsNrCBZ9nhF5
         VUZw==
X-Gm-Message-State: AOJu0Yx3xsS9GOWi0zqO1dvmAYVWvjDRIakB7fNvne+vQxU6K3Qe4Z9U
	QOIXg8cD04UsSWXy09iRG/cPRAa2BXawyWm6UOd++Hay3oFtCwsarRGV8/VGiwFZN8bEEA8VxwU
	bMTnTyw==
X-Gm-Gg: ASbGncvDcRPyudMMY7csP67PWrsyI0bWSikXjER8dLKC9qS0uNuXVE932MhATw2Glic
	KX1ZRCwx1rnvgYsEhGbQvtnb/j+XcyE/QdUV4lR8FngPe0qz6lCGHv1uSMgfJvpUgPNGQZjes4h
	/1Q+8t7Nlb6LMFk+lteSDMaaanL0+m7j9C5PYJYGjafR3HbQ3mik8d7cCEZCgBOCD7TBdaL0wBl
	Rmxdx5/ctqdF5BhoaKDcJJ7aN9b2/CGevoN1ex+e8Ib/Ld4DL0okbn68nrIo4d759IqFWK3M+GG
	PEwc7hu4AxiRkhSf086vZZv/ReTX8Aq6aWmz/pKFNWpLi2X2Yy2IOjTH1uFHPpubOlxYYVQgSyS
	KLlzTvA0fjak13/WHLDZ9NokxSEEld0TLzpoFkkQ8xvMvu+hB4MaJfRZ0JGXzITZ8dmVln9L4hZ
	Er3fS5FFBWITaGATJ2H5OFcq0URlnqda3b
X-Google-Smtp-Source: AGHT+IG/JuoL1wJ1L+vnrZAe2XToiUiGgx0b4HoXnYH3e5PiFP9wx13DauisuIMrZqEw6NNPO8PmRg==
X-Received: by 2002:a05:6a20:72a2:b0:35e:b02b:4efd with SMTP id adf61e73a8af0-3613e5abfa4mr16094427637.27.1763989018787;
        Mon, 24 Nov 2025 04:56:58 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:901d:f4cb:e17b:7573:51c8:8809])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fae9e2sm13240109a12.31.2025.11.24.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 04:56:58 -0800 (PST)
From: Ria Thomas <ria.thomas@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	lachlan.hodges@morsemicro.com,
	pradeep.reddy@morsemicro.com,
	simon@morsemicro.com,
	Ria Thomas <ria.thomas@morsemicro.com>
Subject: [PATCH v2] wifi: mac80211: correct FILS status codes
Date: Mon, 24 Nov 2025 18:26:37 +0530
Message-Id: <20251124125637.3936154-1-ria.thomas@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251124061111.3627341-1-ria.thomas@morsemicro.com>
References: <20251124061111.3627341-1-ria.thomas@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FILS status codes are set to 108/109, but the IEEE 802.11-2020
spec defines them as 112/113. Update the enum so it matches the
specification and keeps mac80211 consistent with standard values.

Fixes: a3caf7440ded ("cfg80211: Add support for FILS shared key authentication offload")
Signed-off-by: Ria Thomas <ria.thomas@morsemicro.com>
---
v2:
 - Correct the Fixes: tag to reference the right commit.
---
 include/linux/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index ddff9102f633..1f4679092e69 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3594,8 +3594,8 @@ enum ieee80211_statuscode {
 	WLAN_STATUS_DENIED_WITH_SUGGESTED_BAND_AND_CHANNEL = 99,
 	WLAN_STATUS_DENIED_DUE_TO_SPECTRUM_MANAGEMENT = 103,
 	/* 802.11ai */
-	WLAN_STATUS_FILS_AUTHENTICATION_FAILURE = 108,
-	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 109,
+	WLAN_STATUS_FILS_AUTHENTICATION_FAILURE = 112,
+	WLAN_STATUS_UNKNOWN_AUTHENTICATION_SERVER = 113,
 	WLAN_STATUS_SAE_HASH_TO_ELEMENT = 126,
 	WLAN_STATUS_SAE_PK = 127,
 	WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING = 133,
-- 
2.25.1


