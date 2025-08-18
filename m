Return-Path: <linux-wireless+bounces-26439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FC9B2B3E0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 00:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73191B2722A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 22:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4327700C;
	Mon, 18 Aug 2025 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="pSFGCJ0R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9612276030
	for <linux-wireless@vger.kernel.org>; Mon, 18 Aug 2025 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554415; cv=pass; b=m7y7HO2pR8OJ/j4ywXZnsKFjlRT/+Co/b8SN2VIM7G1nfZZ+O5xQnMcY9neevw+u4c/teAZxiTFQs/SGvLYa9DYwZQGE7w90K2oBqeVH5HUCKnRl0NMDpYNX7EZtPq5cel1Uzira8HhOZR0DvlT/0Ej5AVfqEu50aXwJHBlBEcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554415; c=relaxed/simple;
	bh=wlroUmMdjfn+3rY4uxvu0O/2dp8JqMNjLJC+Aj7xrPg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=KJ0cRQyCeo4h0lBh5INGA3tgAFYhfc2g3gZr5KNzGjdvBjjLoXg6+yE0RzmKa4R8aBXJs5R+0HSBDAezZ9U6w6WsWFS7wEekPK1D4ko56WH2fvy1OWumYjv2opb9xbgHkXT3QU9lm5sojj7vxiiirRpI3erT9H8baz0sAhXuyuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=pSFGCJ0R; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4c5RTf298yz3R81;
	Mon, 18 Aug 2025 22:00:06 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4c5RTf1L48z3m90;
	Mon, 18 Aug 2025 22:00:06 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1755554406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VOLFBeOEx6uxtP82CEkiFE/O7gmd8+gmD7YozJ75SQQ=;
	b=pSFGCJ0RKWQzu4U1CzeSZiozqZfjUQ/4DAL061mDUHnxXxUGsqAb4+hYY7twFLYj/7I8Mh
	asBJu5N83IYw7s5Jxd7aT2ypizDL5imJQJDQJeHLqtbIMKvGf4dIuGaOhouTq8oGQvqJ+t
	CU4vm8o4vudG+s+soJ4xrOJpMaOomdzP57u8Wgdm/Vgdc4wPY8XTF7pkCTMNlpY1RGlUCd
	xY2A0OtCP9PytjDvYe6Cm9drSW28zqJiZBI+kpClWoznOqzjS61E7433H2khKgqUHGjwer
	sd8bPK7ZCK9ZrN6UwTiE9GfdwPlpCeljgeiGwx0fphhsPftQeg6P6YN+wyy4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1755554406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VOLFBeOEx6uxtP82CEkiFE/O7gmd8+gmD7YozJ75SQQ=;
	b=txnLmpQcyu1Ckz7eI3yffa0phogBt6vGKry3HC/Q5CiGZ7vEm+XiFgNbJsMCcgM8VfWbkq
	p58vmI+TuFxSzL4efpZ9Bg9T02SK8XVUSEcyAThRWChBWTB3XlOgM9Z8cpTMeAK3lMIozo
	Z5qIs11KhNaeBsAr8O6BmimqqnMztfLa72Obag23+JOJcEeUj+o7CDCSrD6HmOlCcqxj8f
	XLJbRRCSQ4HibfnU8F2Pmy51Ojpmmym+unNZiTAQyDvhP1VIcAgKHv/ThInA9zrV79cEf3
	rAhJQK0U6GuRuFws4FfKU8HSZ5R57KTrTfoGPW/dFvk64O/qdwUN+E4oJvQ5Cw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1755554406; a=rsa-sha256; cv=none;
	b=pJ9TdLJw5QGBc8T77CjdLFEqwc1qOyVPetXDbUcALDjfkc58UhWjDie4IB/yGGEIjwqFxU
	+qr5qapLm6mUxCt0Pun1cVJsmP5FIxZXlULrGS5uzh6YDTRXHO2bRaKpeKSzMvuMDPNiyH
	QP80UeiWh2/EblpObe5DKUJRIp1FNglwuXayXjRzjQvJQ6TvJg0MhKYdZMWqs+x+AAjXSA
	EPM5uYCBMWcp50D/zNjos6UtkzwUQ0p+Kt/anGEodigAUJ9I045uWUsWgPbTGe+ha3f1i1
	iZjAj7g3hjV5DGA7MImBkybcJgn+bXKAlq5xSEBQtjNpBIl+hoJLh5oYXPnvAw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from mx-01.divo.sbone.de (mx-01.divo.sbone.de [IPv6:2003:a:140a:2200:6:594:fffe:19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature ECDSA (prime256v1) client-digest SHA256)
	(Client CN "mx-01.divo.sbone.de", Issuer "E6" (verified OK))
	(Authenticated sender: bz/mail)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4c5RTd6Tm2zrvX;
	Mon, 18 Aug 2025 22:00:05 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mx-01.divo.sbone.de (Postfix) with ESMTPS id 35B5BA64805;
	Mon, 18 Aug 2025 21:59:57 +0000 (UTC)
Received: from content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPS id 738C22D029E1;
	Mon, 18 Aug 2025 22:00:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	by content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742]) (amavisd-new, port 10024)
	with ESMTP id Ak39gs8um7dZ; Mon, 18 Aug 2025 22:00:02 +0000 (UTC)
Received: from strong-iwl0.sbone.de (strong-iwl0.sbone.de [IPv6:fde9:577b:c1a9:4902:a66b:b6ff:fe40:39a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPSA id B35442D029D8;
	Mon, 18 Aug 2025 22:00:02 +0000 (UTC)
Date: Mon, 18 Aug 2025 22:00:02 +0000 (UTC)
From: "Bjoern A. Zeeb" <bz@FreeBSD.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: mld: do not drop const with cast
Message-ID: <n4r5rr10-n3o3-r9r5-4s57-718oqo52o94n@SerrOFQ.bet>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

In iwl_mld_mu_mimo_iface_iterator() the last two arguments to
ieee80211_update_mu_groups() drop const by being cast to (u8 *).
Fix this to avoid warnings (errors on FreeBSD by default):
error: cast from 'const unsigned int (*)[2]' to 'unsigned char *' drops const qualifier [-Werror,-Wcast-qual]

Signed-off-by:	Bjoern A. Zeeb <bz@FreeBSD.org>
Sponsored-by:	The FreeBSD Foundation
---
  drivers/net/wireless/intel/iwlwifi/mld/notif.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index f17aeca4fae6..003b12b33d8a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -156,8 +156,8 @@ static void iwl_mld_mu_mimo_iface_iterator(void *_data, u8 *mac,
  		 * action frame, so no conversion is needed.
  		 */
  		ieee80211_update_mu_groups(vif, link_id,
-					   (u8 *)&notif->membership_status,
-					   (u8 *)&notif->user_position);
+					   (const u8 *)&notif->membership_status,
+					   (const u8 *)&notif->user_position);
  	}
  }

-- 
2.50.1

