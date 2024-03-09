Return-Path: <linux-wireless+bounces-4505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D1876EE8
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 04:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328031C20C11
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 03:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F772DF9F;
	Sat,  9 Mar 2024 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="cm9ABFlu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D9C27269;
	Sat,  9 Mar 2024 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709954054; cv=none; b=blbRetJwUEXVwcQNGF1LZbRQVLTvpXI1CZeVMqV4gYUfWGDUaFw0+EKl84i3lgh9JUJiT9oo3wgU9rCLfrNGANPkyY0wdWZOOtFSo563d9zHa/BDFu9FhAuHKCet9A57UOjPG1Bdbw29XwecngBgieumOtiBprXjiqRz1qo73Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709954054; c=relaxed/simple;
	bh=WJcq/6TzFWbS0B0v6wATw70iSKAipfCLTJwpZIyvltw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Usczd13wvGvbPLfzqUWpAkiCj9632s4nbxGBHeYwccNZ1RF3DbccZ886iMdWH2OG0pMRLhhMli9NtAsvIvIdLDvmsTrIU74jM1U1BaYoIlG5jE+RFFdOy8eTkty6GuCev5H31jvA8ZRnGAlMbe8iHWCTQdsabTDuBlMZc+/Alqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=cm9ABFlu; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id ECCC687D2D;
	Sat,  9 Mar 2024 04:14:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709954049;
	bh=9ZLRhz108bLVoXPyvecqoKo8hPm+so89oLO+wcL/NP0=;
	h=From:To:Cc:Subject:Date:From;
	b=cm9ABFluWmjvv1sNx3ppyv0pssiqs4dcp5F0zZhkueKV+XY3odSZbFEbx+oq0wLbI
	 ZjzeZg/fCjF1GuTriPrCrDcoSvCIobssgxZWdkua+rZnoM5O3Fmj5Vwb8BJjBxnrsH
	 Pdrs/zf1f55Rbtpn2IMLXJlwlrpLVx1FrNM9aPPZaLnoGVFMbLdx8IPlgNCbuUBnQH
	 lC4hbsZE2vEhSW+lK9MqqatzhT3ElxMzkwTJRLufpg3iWvT/D4dUjwQ0ShAG58GvM6
	 fQcLOKYZylOZRgC7DU1Hng+lgk5lxJvQVx5a3LJ5H1uPyNv8dFqz2P3Eq0aR0ZVikP
	 u4dFCZhDBo3GA==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	van Spriel <arend@broadcom.com>
Subject: [PATCH] dt-bindings: net: wireless: brcm,bcm4329-fmac: Add CYW43439 DT binding
Date: Sat,  9 Mar 2024 04:13:17 +0100
Message-ID: <20240309031355.269835-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon. The
WiFi part is capable of 802.11 b/g/n. This chip is present e.g.
on muRata 1YN module. Extend the binding with its DT compatible.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: van Spriel <arend@broadcom.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 4aa521f1be8cd..e564f20d8f415 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -44,6 +44,7 @@ properties:
               - brcm,bcm4366-fmac
               - cypress,cyw4373-fmac
               - cypress,cyw43012-fmac
+              - infineon,cyw43439-fmac
           - const: brcm,bcm4329-fmac
       - enum:
           - brcm,bcm4329-fmac
-- 
2.43.0


