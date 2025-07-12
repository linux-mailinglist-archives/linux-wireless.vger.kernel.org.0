Return-Path: <linux-wireless+bounces-25328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9B7B02D26
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 23:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B2A4A2EAC
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 21:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668952367B1;
	Sat, 12 Jul 2025 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIrX18QM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9BA1FF1C7;
	Sat, 12 Jul 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354301; cv=none; b=go8KChcByN9CFAynk7bEMOXE8/o6pMhnWev6QpMqRqcOw3ZJUt18htbnFYTyxg4K2ChSR+qvAzqd7lVNvBb71Ot94yHAq1d7VQ6TH/szP9NOlx61aV6gLjCT4BAk6Sve6hRWxbfVVoczPMPOzJbfCfYlDynmWwA0r9buaPshYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354301; c=relaxed/simple;
	bh=oR7MXeK2kNeHBJiihl3hom/RSoggd1b4/7OVwsS+/io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clVFNcWt5H0dY6YrMfV5L0bc5nPZK9Yt1kjuJ0ql24tLPz10EpK1elxKXSdWZuE3ONuZkD+WGsiTFr8DwmSPF6C2a51W5qnXfjFm4ePSrU6HPB4uuOdEd3sEq2a/YroNFNPm8X/ArE+qBW/MI4s2sGFLUIuZR1KxuC+iuRid47g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIrX18QM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74b54af901bso2035938b3a.2;
        Sat, 12 Jul 2025 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752354299; x=1752959099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejYbSlwrvFkbrHBW6bffd77Xp+VgExQz5WmoZWm5X3A=;
        b=lIrX18QMw0gNxbEk9andzez5R2viTfRXahWa2nLtKHXDDZnPa08KfxI/hw/fW4R28h
         k2jfsbL7B/V8yK/BFi/jugQ7wyMu7Zr/wDFKejInn+PQJJ9jem1hNcMMYgeexqzmvHmP
         2pMcKwDXlG4H9wd+o6XNyCU8WbIjawO+wNwUxsQURhYPXnNyA2CDYpPQssdljpkoinNh
         +CRoOYOUbOV4tnQNU9xSJjRL0WRvM8XSWCG7VBYNPsiyHVc36T9mtnD6dEFHTqmiqnxl
         ES6QUjubnPEbEQiTUPZjHhiB/K8GQWpCnIAfVWAgAqVaXGQrFxrVOET6Km0HmTKmNi76
         SB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354299; x=1752959099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejYbSlwrvFkbrHBW6bffd77Xp+VgExQz5WmoZWm5X3A=;
        b=UiqoxY5XAgVQCvjrl+rsC2yVyjqGKzQvkIGc3rT5BoUu4ElXUgsieRGIsWHQgnGWQ1
         ezzEU61tnfAJ9tysA8j0MoDFAbiRKYtXRwo79vh3Xb40fGs9z7G14LDK+4uP3vhUj1Eu
         7VL1RO4XgE+GdSAB93SfzdBgHqC7+lqnZHRe0jyGCv1+mCUUZhCOFPkOvmiY1bdpFQQe
         0syPnAvGtG5Lc2uHkIOUpChbe7w9x6Go7JRdTzXPysZm+xpEfDNY7PvAw27J5jFaGrV5
         W6/Z7HDnxeLt8UeUObK97DPAam4axbdXHWH9afQuAqI92EU5zAbcG5SNKmD1oQFrM4WN
         GPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeCD4oHT554XkrRBgjWKjGWZzvzneMsOo4Ic13oJxYGL+mZrmiikMDiQ8WxZjiyy5KYrH7rME1iB/tKA==@vger.kernel.org, AJvYcCWYfAfz6Xkp2MyppcUFNE8mQrr+MkCJsvqWzG4DZ+cin2mz9fcHuSkK20iDxNdgqqQEb2eWf5z9g7G7@vger.kernel.org, AJvYcCWsUs1PLadSsdpn7tZ+/GoTkJhtkf7Bg3G2tUn5iIamY3B1s6CeM06vgX9mOfO7TlCcR9UPW5bDXdma1Imi@vger.kernel.org
X-Gm-Message-State: AOJu0YzWplD+lBBTYDui4SUYYntWZf97lgieqSQAjiKxu3NCJwpBYz3z
	pqlCWoctZmtSkoxcW66OvaVSVA+01Djyp7pFvoWH05zJkozXJYWzboPZrubtwmZ0
X-Gm-Gg: ASbGncu/vQgB253vKvCQbMEcjJdRzU9w6k1DeqI3XVUPUrdxBjP7yU83reI502KYpYF
	DsinDvnpWzs19E2nHPT4eltU+rk66/UyHFpvcWdXPCYwBUQrNH/EWQ2hARazP2t5HOsA7yyJTn7
	xCmHT9VnkHUS7bWjXinBYUDq9e8l5Z9jCH5vq6L6xBWI/pmkpX6PNqmTJ/lgxgCdJSgEJ2KG5db
	E7X10Oh8LTzi7Xe13EmVFJam/XJH6zihuih2+n0iCtVhY3yhWOWwmvHQZ729JjpxSWrySBodvcj
	vKBi6mGN5IGN+eQ9zIPs79V/N1XdImCxaa8sekjNXqVBOlwatdc/W5cWJD8SWhFjPA+wwZu+uXc
	YaJU=
X-Google-Smtp-Source: AGHT+IH+1if3RW5zQDx5NFLjOzn1Iy9WzIcJAUTGZjLlAWikIuAA6K+2n56KMZrocse6CCNK9iTVig==
X-Received: by 2002:a05:6a20:c709:b0:215:efed:acfc with SMTP id adf61e73a8af0-2311dd59489mr17727971637.7.1752354299008;
        Sat, 12 Jul 2025 14:04:59 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5d30sm7988645b3a.5.2025.07.12.14.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:04:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv4 wireless-next 7/7] dt-bindings: net: wireless: rt2800: add
Date: Sat, 12 Jul 2025 14:04:48 -0700
Message-ID: <20250712210448.429318-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250712210448.429318-1-rosenp@gmail.com>
References: <20250712210448.429318-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device-tree bindings for the RT2800 SOC wifi device found in older
Ralink/Mediatek devices.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../bindings/net/wireless/ralink,rt2880.yaml  | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml b/Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml
new file mode 100644
index 000000000000..a92aedf6ba01
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/ralink,rt2880.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink RT2880 wireless device
+
+maintainers:
+  - Stanislaw Gruszka <stf_xl@wp.pl>
+
+description: |
+  This node provides properties for configuring RT2880 SOC wifi devices.
+  The node is expected to be specified as a root node of the device.
+
+allOf:
+  - $ref: ieee80211.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ralink,rt2880-wifi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    wifi@110180000 {
+      compatible = "ralink,rt2880-wifi";
+      reg = <0x10180000 0x40000>;
+      clocks = <&sysc 16>;
+      interrupt-parent = <&cpuintc>;
+      interrupts = <6>;
+    };
-- 
2.50.0


