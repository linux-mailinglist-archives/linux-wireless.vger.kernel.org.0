Return-Path: <linux-wireless+bounces-20778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194C5A6E1A6
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 18:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B02716E874
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D0D267700;
	Mon, 24 Mar 2025 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggXUZl2D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7026462B;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838103; cv=none; b=j7b87UMzzA9ikHO4kSl6s1p7k1OC+K5UDCGB08cTUwYOIsr7CSV2EhBpS2aM/FKmd/Yp6CQWVRzkTrGJCu71hAzCe2O5D24TRRA2ZXMnJj5uiqfOzqzh8xxal0lljtu6lrC+1s7pUx07zsvuc3vB6Tt7/rQoMnCceAoPcx9dpxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838103; c=relaxed/simple;
	bh=sdcuRNAQFYtob6yEPETsohJyFlIPNbv+Zn2NcH7jrWI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W+arckCWzn42MWxDuHCr6N4ol7IqLGgy2WEeJILehQBb/XsbzJRsVc12sE7ij9C3sKZhQfUwLMlMLS9s2vymwVcjCdmrexjV6YnaIBk/vP6JpoOl9lBg3fR9DVsZBd0NqrsQmxoEERnH/pSJU+o3B7vE8w0FISGP2k5CMR/WsvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggXUZl2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59F0DC4CEDD;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742838102;
	bh=sdcuRNAQFYtob6yEPETsohJyFlIPNbv+Zn2NcH7jrWI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ggXUZl2Dd5l7WjVO+CYEAbKgabvZGg99YA5B/EVisoMp2IRaUmrU9NsnSCxseMTja
	 MHpKvbLiZQzsyVMLCtfa7Cdtm3RT4t4tXWSdWiH+LnwAsDD6Qj3kD8SE2MeFHeiqI5
	 ZanSVghZAvvxz8FKy/fcxzoeSIwA7V0ut54LTHiUQzP04L4sB9juoEn2JG6ay5tUPe
	 kbd9JqYK1M3HYW55W6nK9JEw8fiuF5TpOVSnwBu+QUUZBxIwKn8OQUBbuKKptGjSIk
	 /Zg7yJkNCjHr+CVRFvUCqYN8J8rtz+K/dvpANp6p7zh1yDvHO0Ck7DKqllXeaeF5n4
	 Nbe8z7IyFfXlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F2EC36002;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v5 0/5] dt-bindings: net: Add network-class.yaml schema
Date: Mon, 24 Mar 2025 18:41:37 +0100
Message-Id: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFKZ4WcC/43O20oEMQwG4FdZem2WNJlDx6t9D/GiM4m7VelAW
 8fDMu9uRxEFYdmrEPjz/TmbrCloNre7s0m6hBzmWJf2Zmemk49HhSB1N4TESMggBcYQJcRjhqj
 ldU5PMD37nMFx16tI1w9Cpt6PPiuMycfptAmICFIbJi1JFYqzlqq2JU8hlzm9fz2x2DrurulbL
 CA0LSly3xKiHB59jP5lX2PmvrILXU3RRg1D5+r3Lfb8j+IfqkW27hLFGyVOsBF5GDt7CG+h7Ke
 Pb6f56wyXnKY6xDQwdw5pbH6ddV0/AcDuXAC4AQAA
X-Change-ID: 20230203-dt-bindings-network-class-8367edd679d2
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=sdcuRNAQFYtob6yEPETsohJyFlIPNbv+Zn2NcH7jrWI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn4ZlTrhhrbvdN7q/q0xl8VBJwCdheUpabZJum5
 tkfNRJDy32JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+GZUwAKCRBgAj/E00kg
 cjJoD/445obenDkJ2ww6j/V4OnGgHkP5M0egpahzT0SriANaT7QkIObfDbx9udE25Un6znndbgt
 8vUbYA91FAokbS4DkynY4cXKxi46j7HOYnAicew45FZGRZaLajzGiIXVwvuQXn/F7hJtLDmUBUK
 XrOlCDQrtMRKfH06dxoZITN9SWhp3aBm6Huq+9nBnw+xIkQUblfcWFdnRWkcyn/6tuuYZMvBnwJ
 K66LZW3tL8nHZiEzrIMX3CD63GUo2kGfzqK3cmB7j9Dp3WGC0jh8iCgjUY2bsZije1q8K1m40OQ
 LSmgTZJctX903izdObj6fvhuOl0nqvVBv+X9IZbL7EA9ykSdACJE4S4NoLnt6knBmcDJOCYwO/o
 JaHIQh7VP9OuBX2raJcNMy3XcM3N+EdP6wH7omOzTeFMPiR299/EFLUnSl49NTdho+792cDHc9f
 46IwQ0P3TDkfxNAtFAR2rXkzwwdWNASfz5JuvrpnUvY1NI5PpUwjQ30sG088EOPKdBUMlrOEIKL
 ee20LJGG2aOL0vD+dJnzrqXQv2uCr7P3Edm/ea+ZPXOJ89mOF0gGw5cuGXH3AYAUIFTpLd1rXQW
 0D4esR1/YpfKoxq/0S2FUFdpqCk+MhTF/FQy+rcfD7PtVhecHx9VZZBqZKP+KYAJCfbXCS4AVwp
 haOaR4i1hClUEsA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

The Devicetree Specification, Release v0.3 specifies in section 4.3.1
a "Network Class Binding". This covers MAC address and maximal frame
size properties. "local-mac-address" and "mac-address" with a fixed
"address-size" of 48 bits are already in the ethernet-controller.yaml
schema so move those over.

Keep "address-size" fixed to 48 bits as it's unclear if network protocols
using 64-bit mac addresses like ZigBee, 6LoWPAN and others are relevant for
this binding. This allows mac address array size validation for ethernet
and wireless lan devices.

"max-frame-size" in the Devicetree Specification is written to cover the
whole layer 2 ethernet frame but actual use for this property is the
payload size. Keep the description from ethernet-controller.yaml which
specifies the property as MTU.

Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v5:
- Incorrect DCO chain, missing SoB. (Krzysztof)
- Improved address-bits description. (Krzysztof)
- Link to v4: https://lore.kernel.org/r/20250319-dt-bindings-network-class-v4-0-2329336802b4@ixit.cz

Changes in v4:
- Changed the mailing list address (Rob)
- Copyied the whole description for the max-frame-size, including the
  MTU x max-frame-size contradiction. (Rob)
- Link to v3: https://lore.kernel.org/r/20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz

Changes in v3:
- Incorporated wireless-controller.yaml suggestion (Andrew)
- Link to v2: https://lore.kernel.org/r/20230203-dt-bindings-network-class-v2-0-499686795073@jannau.net

Changes in v2:
- Added "max-frame-size" with the description from ethernet-controller.yaml
- Restrict "address-size" to 48-bits
- Fix the mac-address array size to 6 bytes
- Drop duplicate default value from "max-frame-size" description
- Link to v1: https://lore.kernel.org/r/20230203-dt-bindings-network-class-v1-0-452e0375200d@jannau.net

---
David Heidelberg (2):
      dt-bindings: net: Add generic wireless controller
      dt-bindings: wireless: qcom,wcnss: Use wireless-controller.yaml

Janne Grunau (3):
      dt-bindings: net: Add network-class schema for mac-address properties
      dt-bindings: wireless: bcm4329-fmac: Use wireless-controller.yaml schema
      dt-bindings: wireless: silabs,wfx: Use wireless-controller.yaml

 .../bindings/net/ethernet-controller.yaml          | 25 +-----------
 .../devicetree/bindings/net/network-class.yaml     | 46 ++++++++++++++++++++++
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |  2 +-
 .../bindings/net/wireless/silabs,wfx.yaml          |  5 +--
 .../bindings/net/wireless/wireless-controller.yaml | 23 +++++++++++
 .../devicetree/bindings/soc/qcom/qcom,wcnss.yaml   |  5 ++-
 6 files changed, 76 insertions(+), 30 deletions(-)
---
base-commit: 882a18c2c14fc79adb30fe57a9758283aa20efaa
change-id: 20230203-dt-bindings-network-class-8367edd679d2

Best regards,
-- 
David Heidelberg <david@ixit.cz>



