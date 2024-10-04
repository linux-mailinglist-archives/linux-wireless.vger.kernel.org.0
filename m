Return-Path: <linux-wireless+bounces-13499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDC2990077
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 12:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8383F1F24BDB
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BB314C5B3;
	Fri,  4 Oct 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoWHCZ34"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B714C58C;
	Fri,  4 Oct 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036212; cv=none; b=nyTAQwqkK2sDO60l0sQuSktrbwNSEkEFUCDgOlZqfRl1BMG1D6ei0qRMbmedhclzza68W7Jc5p4ynI6dKAuKJZEjOfk+gw77E/eW/wfymbnWNgDlTWpmAlUgjq84O8LtlybArT6BcMMUCh/Sb6y/Ld17UuROHbvdkJgWfVWkEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036212; c=relaxed/simple;
	bh=YkIMmrQMwa7Yj68raLRBt22W+4xtX1ACU97HB82MVhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VT/a1RTnnNsCS53Y37CdVaI4JXVHB2oeTNH+6v35WwPekkQzKREbHBU3LUlW6m23FdBMWudmsNmuLSMoORwH+xhMNqnXmwayKHR9XPHGsSRQJrxn7+Ur/z+pd5OtCNMNwOJ9KntiPxBS1z+DxRS/iQfY6yYtEHawy/W461m9ZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoWHCZ34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ED1C4CECE;
	Fri,  4 Oct 2024 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728036210;
	bh=YkIMmrQMwa7Yj68raLRBt22W+4xtX1ACU97HB82MVhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VoWHCZ34ZjLX+0q9hkYnI3sTnnoqY9TNAKljAjaRQj4abnQZqQ+v7NMK4wBOM0Yco
	 nhIqRsAiIqilVj65/X5oBp9BgOgz1HyuDxDIH9S2hl8kXbRggCaUDC7H3mjk7pvH2N
	 iPSH/GJQvS8NCuwv+F9oHEIl57ZX6A1EutOiUVu0gc/62kWNJPf+mq9nkPXv+ggEXY
	 ZDzQFwYrzkoj4mbveewGXuAQWMuEEFvOaOQs7565EcX40OtyQQTeYWrVLtmDkQ/8Da
	 lU6u3Oy+7H3PSMQphODut4jY6mCQkZyBi+eSfT2Kz6DIrg5TrxGpD2C5ohQKaFnXhp
	 mzVnHZVaxe/SA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 04 Oct 2024 11:03:21 +0100
Subject: [PATCH RFC net 1/2] MAINTAINERS: consistently exclude wireless
 files from NETWORKING [GENERAL]
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-maint-net-hdrs-v1-1-41fd555aacc5@kernel.org>
References: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
In-Reply-To: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

We already exclude wireless drivers from the netdev@ traffic, to
delegate it to linux-wireless@, and avoid overwhelming netdev@.

Many of the following wireless-related sections MAINTAINERS
are already not included in the NETWORKING [GENERAL] section.
For consistency, exclude those that are.

* 802.11 (including CFG80211/NL80211)
* MAC80211
* RFKILL

Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..ea3ea2c0d3fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16197,8 +16197,19 @@ F:	lib/random32.c
 F:	net/
 F:	tools/net/
 F:	tools/testing/selftests/net/
+X:	Documentation/networking/mac80211-injection.rst
+X:	Documentation/networking/mac80211_hwsim/
+X:	Documentation/networking/regulatory.rst
+X:	include/net/cfg80211.h
+X:	include/net/ieee80211_radiotap.h
+X:	include/net/iw_handler.h
+X:	include/net/mac80211.h
+X:	include/net/wext.h
 X:	net/9p/
 X:	net/bluetooth/
+X:	net/mac80211/
+X:	net/rfkill/
+X:	net/wireless/
 
 NETWORKING [IPSEC]
 M:	Steffen Klassert <steffen.klassert@secunet.com>

-- 
2.45.2


