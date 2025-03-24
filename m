Return-Path: <linux-wireless+bounces-20777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB6A6E1A4
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 18:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0434516DC14
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E752F2676E3;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig2n0jQp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF09264617;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838102; cv=none; b=eI2YUOpfAokuZ+Vg2O0RkknKnaXi35pqAnHfVP/d0eCul4AvUV9NwWMTPN1GQbKxxfRewVzm82KoIkyrjQCCpadsAW1X92dUwOp2hF9LnjR90aK5vuQOEw3CQPguVpKlTmgx2fDc2q57Z7/WcXGMw5owr0SyPnf7AbWeqLSjZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838102; c=relaxed/simple;
	bh=8PFrtxpnJpLFkdaeNeF+Kojf2rI5Gt9WPBc0gGLSfzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u2P701ezt0xcNFd2tSmAkabfEp7A/MzEnq0x1jo36juuNjEVtRPLbxbVL6XqhOwMp6b+dJgQG9JarKcvUDladu4HT4gQpfhsw06uhqgRk7JO88NcCLJC8jLLzhwIGOXyOGZ5u3jFXmoqAXdizGClYBrAaS9MBWJ/60ItTI+bVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig2n0jQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85334C4CEEF;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742838102;
	bh=8PFrtxpnJpLFkdaeNeF+Kojf2rI5Gt9WPBc0gGLSfzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ig2n0jQp/tRrUP/isobTD5FA47J2zoG/kTryfUGI1GGxLH64kBHF8vlGQedfZVK8w
	 y+rtw0NPTMF08NCUn8yoth5YfDYXQMM1H3QeQuo50mdDQVH+C2jXZpOhFe0yB4EOtk
	 3MeKDsa5gkFo0iN2wmG0Nmn6hG1xw0oAC6zEr0f14yXDBnsxpmopxVIJRQ1A+Ze8Yg
	 sQ6HCc/r8Ha9Ciius+Vjje+6nTdu23qgsxadiSUBRpAckHKHvVM6S77LouYukB62s/
	 Ydr4APVyW2G2f2AzbMzFqwLaDuyngV7jYoJSac/7LgLcVh0u1bEyKbiU77ruuge/rO
	 n/7yCrCfGoTlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B721C36008;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Mar 2025 18:41:39 +0100
Subject: [PATCH v5 2/5] dt-bindings: net: Add generic wireless controller
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-dt-bindings-network-class-v5-2-f5c3fe00e8f0@ixit.cz>
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
In-Reply-To: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>, 
 Mailing List <devicetree-spec@vger.kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=s4h8B9gNJQ6JIaRS+FZDFjTYjzD5y6gNzE0ffwMuDco=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn4ZlUkO2OTp2AzhwK0TqhMqWIaIvFxzYIv7hU4
 sC1q5W8JXGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+GZVAAKCRBgAj/E00kg
 ctX+EACIls3D2cw/sYf6yNpFF7jMddNcznl3sRLq0U1Gq9Qpqn/AgYTzBJXrYWOyGxwhoO3hegV
 XZIj25cuIt6LQglWdRSdQ+sF0s1ta/419YsW2ACTqCWRfh8YZvXVLeiCGB3JcsgDW9usnOSR1Rq
 AGAYg0uegeuRC9Sx2XL+ydP3Y8BhmVdRTvy3Axxl0E4WjS++hCsAnukU0Ju3RJo9Q4Qc5iQAu2I
 hKvmzxRxF22/do9WKRea5LFe8/5P+nc23dvqF253VsOELmU/6v93iE7dYDluB2oyQnxvxWeNWLA
 s8He4wM7PDJOeysx19z6LJ5WqFfu1XVq66U1KHOsxoJed7Lm2humQSmQdVXccwjoHfy/vpZR0Zg
 qLCqTJPrsOrfTnzeXzpCp9HCJjQnZQpbJkOdLVuE0cjaSpS6dejVpWDdGZS6GueJAy3wV61jvBQ
 VYMX3QHRMJCVVN/z3N1NxMLjFzlhzu/+iX9jTlctE6gvB1TUD/0ILv+ainKo6XrHQahwh9hQzoB
 lQa+apHVJhkaaILysbh3KHnsqjvojDCOqT4UTyJJRJ3JEYXrFlZ+IO9Yieyi45/ZPjnCKALZUUe
 QSU12CiBMB+QJdBXtETwNFowKfPLsuRti24UbsIjbhFPKd7ljtNqgpdcDATIJJUTGfk6EwwIxye
 EJtNFGT07HwaRFg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Wireless controllers share the common properties.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/net/wireless/wireless-controller.yaml | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/wireless-controller.yaml b/Documentation/devicetree/bindings/net/wireless/wireless-controller.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7379f6c1aa05c15a5bc7b34df6502cc174af9a90
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/wireless-controller.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/wireless-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wireless Controller Common Properties
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+properties:
+  $nodename:
+    pattern: "^wifi(@.*)?$"
+
+allOf:
+  - $ref: ieee80211.yaml#
+  - $ref: /schemas/net/network-class.yaml#
+
+additionalProperties: true
+
+...
+

-- 
2.49.0



