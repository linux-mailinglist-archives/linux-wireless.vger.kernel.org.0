Return-Path: <linux-wireless+bounces-35690-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MkSES4P82nywwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35690-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 10:13:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C449F1C3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81DCC3004D38
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585413EF665;
	Thu, 30 Apr 2026 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTXDE8fr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308BC39BFF8;
	Thu, 30 Apr 2026 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536806; cv=none; b=DAcrRpqR6CdIeFbWXeeb5OwZgTi/nWsHjBkW+rDQQfKuYVUox6N/WS218ibYthSRi6jYVOZX4JoLQ4H4IpWrz95JA29KogbJU1qcrSXJsmNVg8CsmQrlRQEyICdMZa1OUEjv75DMyNo+rupzLm2qOn8CVZdR+6FEnNPntVHfQ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536806; c=relaxed/simple;
	bh=S5S1PqKBAesjpTpYEqLG27Nkz48WzA2pnV6rZGQVgEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aX8ke7PqEey3Thqtq2asW6k6OTgJP8F0558c+Sovi5GLYVs3SnqVZ6leE9lKk5EepIA/d9EGaSwIaFQ+FCT4+576I2iuiryBbHgby8Okf9YDdcGVd1kcVSqVuTLS7Tv9vM0aDMyj5WzYNkO6sqgy8EhlHAfq6zhLgL3CsEvNLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTXDE8fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B149C2BCB4;
	Thu, 30 Apr 2026 08:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777536805;
	bh=S5S1PqKBAesjpTpYEqLG27Nkz48WzA2pnV6rZGQVgEs=;
	h=From:To:Cc:Subject:Date:From;
	b=oTXDE8frxBZ0w5tEZIHa5hvN8xdRvA0EISTX93AgrA3NxlQGMAD1VaitXS/nPac1a
	 NDqMLxS1rJtry5bkxJkDoFYUTwDPNCfsIV/tithH1tVKB8AEWBIKnHvgKasLLXYFHc
	 V5oXyUYjClSY2cvq5edqwTHkSjnN5Pp4rL2dmSrsF5ezCZsCRw6CvkislDoB5AkhTd
	 b57aOtINhJixsjaJVMJt+et0zVDHyR3a25L/YlSHi/lGTUotMlw6Hb4oaldnGLZW+g
	 hZvAkkJJXabPrs41wCYAiB/nMapaW8IKFkKrmLReEDxnoBaAuQy53fyqnRP+Mbuu3s
	 sFZw2UC8/D8zw==
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
	linux-omap@vger.kernel.org
Subject: [PATCH v4 0/3] wireless: p54 devicetree conversion
Date: Thu, 30 Apr 2026 10:12:39 +0200
Message-Id: <20260430081242.3686993-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D9C449F1C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35690-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,iki.fi,kemnade.info,kernel.org,baylibre.com,davemloft.net,gmail.com,google.com,sipsolutions.net,redhat.com,atomide.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Arnd Bergmann <arnd@arndb.de>

This is an older patch of mine that I lost track of. We already decided
a while ago that the OMAP2 platform should probably be removed entirely,
and this is the only known user, but it's probably a good idea to still
get the driver changes in, in case there are other out-of-tree users.

We probably don't have to worry about bisectability any more though,
so the devicetree and driver changes can just get merged independently
through the OMAP and wireless trees, respectively.

     Arnd

v3 Link: https://lore.kernel.org/all/20260427142355.2532714-1-arnd@kernel.org/
v2 Link: https://lore.kernel.org/all/20230404082401.1087835-1-arnd@kernel.org/

Cc: "Aaro Koskinen" <aaro.koskinen@iki.fi>
Cc: "Andreas Kemnade" <andreas@kemnade.info>
Cc: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Bartosz Golaszewski" <brgl@kernel.org>
Cc: "Benoît Cousson" <bcousson@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Eric Dumazet" <edumazet@google.com>
Cc: "Felipe Balbi" <balbi@kernel.org>
Cc: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Johannes Berg" <johannes@sipsolutions.net>
Cc: "Kevin Hilman" <khilman@baylibre.com>
Cc: "Krzysztof Kozlowski" <krzk+dt@kernel.org>
Cc: "Linus Walleij" <linusw@kernel.org>
Cc: "Paolo Abeni" <pabeni@redhat.com>
Cc: "Rob Herring" <robh+dt@kernel.org>
Cc: "Roger Quadros" <rogerq@kernel.org>
Cc: "Tony Lindgren" <tony@atomide.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-omap@vger.kernel.org


Arnd Bergmann (3):
  [net-next][v4] dt-bindings: net: add st,stlc4560/p54spi binding
  [net-next][v4] p54spi: convert to devicetree
  [omap][v4] ARM: dts: omap2: add stlc4560 spi-wireless node

 .../bindings/net/wireless/st,stlc4560.yaml    | 61 +++++++++++++++++
 MAINTAINERS                                   |  1 +
 arch/arm/boot/dts/ti/omap/omap2.dtsi          |  4 ++
 .../dts/ti/omap/omap2420-n8x0-common.dtsi     | 12 ++++
 arch/arm/mach-omap2/board-n8x0.c              | 18 -----
 drivers/net/wireless/intersil/p54/p54spi.c    | 66 +++++++------------
 drivers/net/wireless/intersil/p54/p54spi.h    |  3 +
 7 files changed, 103 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml

-- 
2.39.5


