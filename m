Return-Path: <linux-wireless+bounces-20781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BFDA6E17C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 18:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A57C7A38AA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C0267736;
	Mon, 24 Mar 2025 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0tldqZf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3926770C;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838103; cv=none; b=B7/f/ItPtcUPKjv0liM/BN19h+98sAWA9vRE5HmL30f7E3Bk4omw3MbgkEHHnt1QorOmFkuckI0MEcANg3J/mrd4c4peMSkEt8p4xCUNY51JyXg+602IADMk01RflY6LGMc4V4s7/cC5kV6m7yAYvm7H4ramQjwIjCwrLLWLjQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838103; c=relaxed/simple;
	bh=5OytaDh6zsIvmiqUM0rUqzV78/Ku7Yax3ssKpgevVbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JT54HQaLKOSsK1rADsfckG2eKB0NfsUZpMOrk3SJMwAxZ/019B1l/D+fKzC/KPjp+6go8Bqlix7vgfuYlKbQZTyR3a+XlGoYBi0L1jOgFbNYtgqnT5eJauU0KeZ5qQTZRAXPnV/qwfy6Se4kn60IidHLugy//b5VsObbsTJ+1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0tldqZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFFC5C4CEED;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742838102;
	bh=5OytaDh6zsIvmiqUM0rUqzV78/Ku7Yax3ssKpgevVbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R0tldqZf9f7arnaw3etozhGtv7b2aVT+KKkrvC8jjL0BIDgNl6evR1bYUQ90IpMa1
	 D7eVsvoempw15TGLlRArLj+49BVJ7qAU3GODnD0mF834ZkIgb50WMZY8Td6DLoKgqs
	 ta5LSHbYxlEkDtaXHoxTDKJnAyhGFQTukANGzyg359mIvtJJdEmQrJ7R+bj8hj2YQ7
	 66Nmp+sA+Nnfaxbxs4mDzJd0LsmJXY2FWk8RQsMVXrEp8fbuH4BwziyOsAED947XRY
	 41Yd4pSbhImrrmZESmHSW+9f82/AjKJmwZto/pwCQiUqOF4NzHXj41f+LkavxkKDxs
	 XoBSkph+a1BvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7548C36002;
	Mon, 24 Mar 2025 17:41:42 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Mar 2025 18:41:41 +0100
Subject: [PATCH v5 4/5] dt-bindings: wireless: silabs,wfx: Use
 wireless-controller.yaml
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250324-dt-bindings-network-class-v5-4-f5c3fe00e8f0@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=1+Q97VlsmTPyLRAWooczMv5yLKsXFA3Pd6AXggMFbak=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn4ZlUF/zgQhHhLaKXCphlup97trhKf8Or6du6C
 ZNMKVUlw6WJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+GZVAAKCRBgAj/E00kg
 cmJgD/9j/3y+cVi7+Qtvbk//nZ7RVgZDDN0GAGbjJrZ+UEjhd/6vdeBvEr3JWAyGNuhtvLMxTbr
 GUoqEG2rpmlf7KgZTmFa+v3Eon8FcTNrQLP1IqMRG49r/zx2L9tmh0VF6iNa2FjjXCGdwzJjXb3
 72ngNCiIkcBrJ4AI6IoY2f7BZ4fD2ou2E8Lv5JXo0p80OJTff5XkSrGhFDZiqMck2Ip2GHVVepZ
 l25HdjQoeqciRJF2FtmEnrtwIQotAUaSJre6AEM8gUXJz5ehWZBwpKQaBDKl5dzzZUbbNecPLRJ
 MDuljAtFfSLzdgzdTzFhrIu2z3onhjnULad06GyRCTn5JPxJrtgki7MixamRWtoteMILrSpH31T
 Xpnfijb1cyMQNhhpKliDnckjHJ18oagCOqHv4wpb9zzm5aB6VxmZ9gFwFinxecQ4uXZXE64iY7H
 RR2vxZNg+AdyI4hp3B1xOupk+75jyqSpEGbNwwOis0VhefAuAlkRh82pBEuGdayW8jO8gRKlYxq
 0HDe0Dqz6ak/TRJaFIywDIBGDw8Lro5/DOQ+g5dkGAJB1ak6UK4qO4SFEcYPgYUA4s11C8DQ1z2
 Xi91+LtieCa+/pWl/sSSC43yaHahkgcLOEb8lb3qtID1bM5/eObrx0hqj90mglvU1k6qzceNH52
 syrqHitgj1VP83g==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Janne Grunau <j@jannau.net>

Instead listing local-mac-address and mac-address properties, reference
wireless-controller.yaml schema. The schema brings in constraints for the
property checked during `make dtbs_check`.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml b/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
index 84e5659e50ef3125b5063fbebcaf1d2b2bdb7398..6c0888ae4c4e172edf2a5f6249cb8aed5ed11681 100644
--- a/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
@@ -71,15 +71,12 @@ properties:
       "Platform Data Set" in Silabs jargon). Default depends of "compatible"
       string. For "silabs,wf200", the default is 'wf200.pds'.
 
-  local-mac-address: true
-
-  mac-address: true
-
 required:
   - compatible
   - reg
 
 allOf:
+  - $ref: /schemas/net/wireless/wireless-controller.yaml#
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 unevaluatedProperties: false

-- 
2.49.0



