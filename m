Return-Path: <linux-wireless+bounces-18766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3059FA30B09
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 13:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B27166193
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C104621E0BC;
	Tue, 11 Feb 2025 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB2qmMx1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170321A424;
	Tue, 11 Feb 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275312; cv=none; b=BOfBkCVhjVtjCS58g85w8P69X7CEHgWuVvN9+wzsrWd/ngL0+nEDK2OcgV1Ih7VGNshq7gmQbw0BoAlr6nev/Ybw3hAqdNGSku3yOghrSE6GeKddP4PWaiXR7QMyYWLlev9y13Q49ScHaHPJhl35Vhoemr+744IbqhA7PRmxuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275312; c=relaxed/simple;
	bh=Ap1q4LgkrLbGyYRLWcKtA1t6kyY/N7ouDJbyAdy3y1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYfqnKhSXxiQwGbK1AZrzNnrKSBL7VSkTZpNaI1uEobnP2xf6Zkuvz7kHRaNnwGsWFmlwpqeuRhVP55Eff7L0PuIktw0WjuZu3naMPnJ8bT7zhk85TPq47UnzOPqqYB6iPxH5XdkJaF5AMrAsRQa509W1Uv7dgBbiC3qyWKUuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB2qmMx1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dd91c313bso1431242f8f.3;
        Tue, 11 Feb 2025 04:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739275309; x=1739880109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N9nv58w02wJpkfqRyDXBfeCG5CiiQvz6kgd+N3dJY8=;
        b=UB2qmMx1Vboi6B/MlebjV5Fw5lbXfxS6t9P12rl5VqgNbWXLrO0AI7+uMshNTBX/2A
         F0tFQx8kAszdHbxIP+yzVlfNMxzZv4RoaURtvmkOOC0VV9QEYFcfjk8LcK78TxC2lTg2
         hiyme57GzVVZgml1GPcpKsnIpS8u7p9aQwmxOgy5cewyThCvoQmfz+IySERubmjHThsL
         jaCm4wRt9aqdmQKvO+fHBQBko2InuDhccHppgEuX29g0+LKyB0yrZEAljoLNWkKtvxLQ
         Ha/W0YpxAyb/8Tvr2w9+ZMI4R3WOnQf89sBZi2j8a2H4mXrSGhYZsiHhfSnlm4G9s3qF
         UQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275309; x=1739880109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N9nv58w02wJpkfqRyDXBfeCG5CiiQvz6kgd+N3dJY8=;
        b=Fc9D9dn+TccAnHCm+PApnndxhTyncIPRGuYpWC3EMLhWwRPJ5CchraWxN4iczrTUPe
         U50yOc2TG1nyc8y6CzzR2yAurgw9SAAjUCn4MTOmtdefEECLI62Df4FSNYh0h6ntFblf
         bPvPxag3VVd5WqSeYH0OBFeXOnZ2BGct38V6ozM1PEcy4HEuJWRQJa6XXt0W7Ts6iaij
         TIfGR2Npz7pm9cKflVuDNA69c4/ER0D0cFEBIwHbZrPFdfbgJ2fdycVvfHH+IJ20PppW
         72nxNSQk3eikkaKYjrhNv8ytrI73RPhIDHe72JQf6/OYCeD8Wptcr8Qv/Hz2fBW4xeW5
         dPyg==
X-Forwarded-Encrypted: i=1; AJvYcCXCCptEDPXr+ULPJYRq0VJi4S/hsEWuME1Mh96rQw3tiPxupkSiWWewc4C/AsfFHgpxMVhX5Jpqx0gFT75BNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfLDCr/oZeTtxgCwKlWfA1BsCPSVrkEaLkcso364xkIYB8Nwl
	ppx6hmE4CkWjSMoXE6gq3LH8lnfSPDqedTChtUlLEFiltQgSTSRXsheXdg==
X-Gm-Gg: ASbGnctY7bt3KGSWP0/OXiufa3Bh+izn5PhoaUBvKpKtTqVKWsmAjUIFJhhfc7pQIuw
	6SdlxZxPclWA6xRRJwRDxsFE79SAVTo3h9ZYhP5Aeci4WahRVPRhZv69gs7Gxm2qr/cHJBiEk7D
	kP3zqM1gFmX7TQfA4WXbtuan1uUZnMlBmP+mZ1WnM7JIes+/3LU15B0W9kaj2SdEZKU8CZtfopK
	3y0BHDf6Sf+2OPs+U931z9JCwWycxVM126qvunkH05YhYTqALAqdadxcCI52pxPu4DdUMljS/Zm
	MUVoXkCOMUE5Ac1s1djnrmsUMtc4UJLjJg==
X-Google-Smtp-Source: AGHT+IGoxsW7NNJKPkOMXlVtFVClrvSB7fBX6qtHIsoTsQ7Fc16KZ+dBnpUEqaz2LtZmEkVproYa7Q==
X-Received: by 2002:a05:6000:1862:b0:38d:de34:32ed with SMTP id ffacd0b85a97d-38de41be586mr2862212f8f.34.1739275308848;
        Tue, 11 Feb 2025 04:01:48 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:ac07:4372:f96c:546e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc933ff9fsm12466658f8f.96.2025.02.11.04.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:01:48 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v5 08/10] netlink: specs: support nested structs in genetlink legacy
Date: Tue, 11 Feb 2025 12:01:25 +0000
Message-ID: <20250211120127.84858-9-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211120127.84858-1-donald.hunter@gmail.com>
References: <20250211120127.84858-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nested structs are already supported in netlink-raw. Add the same
capability to the genetlink legacy schema.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-legacy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index ed64acf1bef7..c02ed8089746 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -152,6 +152,9 @@ properties:
                   the right formatting mechanism when displaying values of this
                   type.
                 enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+              struct:
+                description: Name of the nested struct type.
+                type: string
         # End genetlink-legacy
 
   attribute-sets:
-- 
2.48.1


