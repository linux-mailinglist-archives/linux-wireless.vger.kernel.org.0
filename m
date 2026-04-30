Return-Path: <linux-wireless+bounces-35691-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GLvMX8R82kIxAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35691-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 10:23:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F88E49F314
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 10:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E652303AB5E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA183FB073;
	Thu, 30 Apr 2026 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekheWX4/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B872741B5;
	Thu, 30 Apr 2026 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536811; cv=none; b=NIL/P5MXk4AZgxHKMHrM6+mv9P5UO8nxTOa3VClGeQJkRaiCyGTVybhaKqGxM1Eda1xq5fY00cMLY+RzjRE8Rn97wpwcUcNeYEh63rz2zNFkfb3B+upGq4S57o8qojCaiQRb0EyBXuVlW+Mck8AX6c/2rLeB8Fid3/nc0ava0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536811; c=relaxed/simple;
	bh=xsi624i78i7UxPUmtUrpKv8Ot7ojpl1pbv+PGQAhgxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fNjyfVwW2WTIBGUvKCUhQ4iTegtTSqyN/NES3rmkmrXguuHcRKcHfJfF+yKj/63ZZfoUlc90N9uvZKlNAdqBqUP+W3B1AiN5nk1uE+sW1TqTGCZLuSXN5FjM3cLj9XsTpx2y8PttQ5HAlE97nX2HZdgmqxPBAlNZJh6kVzzdF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekheWX4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D3DC2BCB3;
	Thu, 30 Apr 2026 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777536811;
	bh=xsi624i78i7UxPUmtUrpKv8Ot7ojpl1pbv+PGQAhgxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekheWX4/nOV+LQYrlsrNsWaJI9JLPY9wgmMc4O0eGKqhVav0gNwyfvk7XgH+bq3Vx
	 Q4hbJNU1BQzOohzTNTFF7HkEnAVjiZWn4MK5J2RflTCAtHM1mevAvLpOsK8cmwW8Hw
	 FS46fk17iednFEpbiqU26aXQfssaDkQbVwfLtm2NmnNQNi2Z0E/L8xdL+iMsciQ3zG
	 DoVbk4TU0I+P9L30S73Y+5FH8ttIPe3sXIaf1EFpMoOsCJUphC+EE2uoCoRPLRwQaN
	 v5OKmx1Ng7wnlCOorELnDmNrbjqvw54keOX6jRKRd2Fgld7VwEalWczKkENxBK/Qra
	 Qm7WHRdLvB4qQ==
From: Arnd Bergmann <arnd@kernel.org>
To: netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Aaro Koskinen" <aaro.koskinen@iki.fi>,
	"Andreas Kemnade" <andreas@kemnade.info>,
	"Bartosz Golaszewski" <brgl@kernel.org>,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Felipe Balbi" <balbi@kernel.org>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Johannes Berg" <johannes@sipsolutions.net>,
	"Kevin Hilman" <khilman@baylibre.com>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Linus Walleij" <linusw@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Rob Herring" <robh+dt@kernel.org>,
	"Roger Quadros" <rogerq@kernel.org>,
	"Tony Lindgren" <tony@atomide.com>,
	linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Christian Lamparter <chunkeey@gmail.com>
Subject: [PATCH v4 1/3 net-next] dt-bindings: net: add st,stlc4560/p54spi binding
Date: Thu, 30 Apr 2026 10:12:40 +0200
Message-Id: <20260430081242.3686993-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260430081242.3686993-1-arnd@kernel.org>
References: <20260430081242.3686993-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F88E49F314
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arndb.de,iki.fi,kemnade.info,kernel.org,baylibre.com,davemloft.net,gmail.com,google.com,sipsolutions.net,redhat.com,atomide.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-35691-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email]
X-Spam: Yes

From: Arnd Bergmann <arnd@arndb.de>

The SPI version of Prism54 was sold under a couple of different
names and supported by the Linux p54spi driver, but there was
never a DT binding for it.

Document the four known names of this device and the properties
that are sufficient for its use on the Nokia N8x0 tablet.

As I don't have this hardware or documentation for it, this is
purely based on existing usage in the driver.

Link: https://lore.kernel.org/all/e8dc9acb-6f85-e0a9-a145-d101ca6da201@gmail.com/
Acked-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v4: renamed file to st,stlc4560, matching the primary compatible string
    require st,stlc4560 string
---
 .../bindings/net/wireless/st,stlc4560.yaml    | 61 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml b/Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml
new file mode 100644
index 000000000000..979c8d7d859a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/st,stlc45xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST/Intersil/Conexant stlc45xx/p54spi/cx3110x SPI wireless device
+
+maintainers:
+  - Christian Lamparter <chunkeey@gmail.com>
+
+description:
+  The SPI variant of the Intersil Prism54 wireless device was sold
+  under a variety of names, including Conexant CX3110x and
+  ST Microelectronics STLC5460.
+
+allOf:
+  - $ref: ieee80211.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: st,stlc4560
+      - items:
+          - enum:
+              - cnxt,3110x
+              - isil,p54spi
+              - st,stlc4550
+          - const: st,stlc4560
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  powerdown-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wifi@0 {
+            compatible = "st,stlc4560";
+            reg = <0>;
+            spi-max-frequency = <48000000>;
+            interrupts-extended = <&gpio 23>;
+            powerdown-gpios = <&gpio 1>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 86ca9297edab..67cf5ae5b652 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20093,6 +20093,7 @@ M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/p54
+F:	Documentation/devicetree/bindings/net/wireless/st,stlc45xx.yaml
 F:	drivers/net/wireless/intersil/
 
 PACKET SOCKETS
-- 
2.39.5


