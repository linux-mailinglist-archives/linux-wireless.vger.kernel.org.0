Return-Path: <linux-wireless+bounces-25265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 626E8B01976
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 12:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8EE1CC002D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7F827F72D;
	Fri, 11 Jul 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="El+AFRfd";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="OgpNjjQg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC42A92E
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228811; cv=none; b=gdmJ7gLR7kf/kutTjkB5u7ULfoCCyjOkhCsKAqDWmmg0ZBKTavgtykGrFbTvO2i7AtdsRd3kCRTP6voyVvoHb7Bb/WlfFVbekcIqCIHj8EcRk2Ekhap3F1kxh8FQDfvZtXdp5LfBzVc0+JqKMBUtFCvL49hlQPxUAKSy4Krtt9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228811; c=relaxed/simple;
	bh=iYW1urDA+J8ItpsBASZ/fIer3hBLBgL3fsKPeaG4LEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MbcJtJEYKaBpAQEiqC8EEO7CfjBjl1UeLghoAIXlT2zo7WGOA6UfSaSpNIpLFNuaKQ7cYYLSfYeIzGWcSuoGhSjlH6ISkGYdmxVH/rrUa8YnTxvJFgPiIAu+cbL7vSsbh6q8aEDlfBofMgSUunEaEwT7S6ZqAuw4E2GrBPVpTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=El+AFRfd reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=OgpNjjQg; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1752229708; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=X0gOzHc7MjO+Xkrz1FdedGsE2tBnHEgnmzARquvVn0E=; b=El+AFRfdTdNkaRMnwnlsxcFoIE
	PZ0JCDnnegZWNuTIB/5S+x2ezKIj+gxAfR+E6pOc8jGDH+AyhkL8A7CiA5mRgpc2SarnKGYW61i7x
	qQioNp6AcZfWhCvbjBZ/czSA55aj0YCWxTW0xx3BNqJ39sj2muVtuIXKkjzhGv5nTIDjypC29LU8i
	RhXpD/CCM8SJfBEjnu5yyYroSzS8mmAbxM6HQ2G6iGdjGOG/ZSpWT85IHG/nDjRv2Q3as8uP+GGKJ
	9UUw8fSy8yoLQKKBKXxGgJN5jEzqV3oIqAGl4WiHLc4zq5Chwso5OIng1Sls2U3Oe1ci2bQlfHJwQ
	by5z/Zow==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752228808; h=from : subject
 : to : message-id : date;
 bh=X0gOzHc7MjO+Xkrz1FdedGsE2tBnHEgnmzARquvVn0E=;
 b=OgpNjjQgbTKshsjSjtPOU7PXSYcZi4ejMfbQDts9/fI0wkg0I1TKdWYZVUGxyzzdACuyf
 2UYgJ/Yuk0Fo5gnSOU79h/4ZVt+I4h746cTw/RjK4Ia1s5hL3PeeEMwiSKoeEKYn9rRKd6I
 YF2VZtHZFeVjrfXbvHZ+73aRz7ATFleeqKPu2HFJVtnYIY0l3W08SNG02VrP3mox92KhFyF
 P81yE5lAoHKkECKAqpCGS6lzwuC7WN4gH9BaktFJBvKJs8TiaJyozKSods89zrHJP2a7xzW
 e4RVPuPGMb7JCeH5iZjUdlToHW05dr+sLiZtuE85vGB+THiQqKUQnYOXo7XQ==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAkv-TRk6D0-RY; Fri, 11 Jul 2025 10:13:25 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAkv-4o5NDgrrfkz-mXyv; Fri, 11 Jul 2025 10:13:25 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH v2 wireless-next 2/3] wifi: mac80211: Correctly init MLO
 link in ieee80211_8023_xmit()
Date: Fri, 11 Jul 2025 12:03:19 +0200
Message-Id: <a62f4c066c967c954648a409e5e1fa185d6edeb6.1752225123.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1752225123.git.repk@triplefau.lt>
References: <cover.1752225123.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: u3EdaAOs_mY6.AMKpHQb8KdKb.ivF2-wf2ZpY
Feedback-ID: 510616m:510616apGKSTK:510616sbg9r1WNUf
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

The IEEE80211_TX_CTRL_MLO_LINK info is the only part of
ieee80211_tx_control where a 0 value has a specific meaning. Thus this
should always be initialized with IEEE80211_LINK_UNSPECIFIED if there is
no MLO link information associated with the skb, even using when 802.11
hw encap offloading.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6fa883a9250d..1d6b976bba72 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4638,6 +4638,8 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 
 	info->flags |= IEEE80211_TX_CTL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
+	info->control.flags |= u32_encode_bits(IEEE80211_LINK_UNSPECIFIED,
+					       IEEE80211_TX_CTRL_MLO_LINK);
 
 	if (key)
 		info->control.hw_key = &key->conf;
-- 
2.40.0


