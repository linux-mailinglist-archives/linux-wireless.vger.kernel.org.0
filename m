Return-Path: <linux-wireless+bounces-20377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 355D1A60FE6
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 12:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4561B62245
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 11:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D91FDE02;
	Fri, 14 Mar 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="kOfCcXPo";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="jhZ87SOo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186A1FAC25
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951550; cv=none; b=ogwt/twnQqADF4UET+qaFUTDgWTdy5I3EvsEtALTDyQiY7LqaNDoVXOKxscjCSyVKeguzQdxA8KCXHrG9bIrqxyodGl/61BC9mKTrKA6RnLzeLqP/LbIBu+/hGehZUUarM61Amr8BZRCcI2paaIIgX2fSjDG8bKNE1AgC8twjEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951550; c=relaxed/simple;
	bh=K/z4t4NOhqkkqSl6CQ+AsBENi23rk6XIpH50FaBpmSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZVSxu2vw/vmCrsiZFRr0cWaLDYQP0b13S8tSEeMZb+Pl/3q8qfy2M7I3qo2y1Ukd/D22I6Ia3Tz3tal3InSTQp0Chq3U5qtXdgrkDttlVfjXHArI4d/pRQJUQRX0N6WxajSR8HvYJQv70luE6g4WdjgDNY0zB/Lggb6RSiNZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=kOfCcXPo; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=jhZ87SOo; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1741950634; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=Q/0NWtuCGURDovv9ooP86q0n2kOTSTLmQGJcGN0Cr98=;
 b=kOfCcXPoySfKmladAOxyR2nJgF3UFK3jN/kFMiY8Xors3TwN4FFLhwB8Us7TcBPJii/Ox
 meO8MOstkr1Yp7b6NXr2PnvY/YV2j7qWHwRQnVHa1u3rElNokTl30E+I9sCUaSuMxdIWiws
 icG1gyKMvmYmNKhR20pw5AodBBXsWzIbnq9yUmH0lfGah00io2aySq4OWtodsZ2YWHyWFy4
 7GzZPosEAfz+Yi1hbUhVReJ0b9GnJ1RtxHwPpG16/11fuHrTsCJ4uwCvCPgqgbNjbCZAS4z
 kQxIb/0gUJUI4ZmTkYy6fYEYMRM+XEVTRpyKUQUtqB9Ya3WTN7l2WMmXw6QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1741950634; h=from : subject
 : to : message-id : date;
 bh=Q/0NWtuCGURDovv9ooP86q0n2kOTSTLmQGJcGN0Cr98=;
 b=jhZ87SOoS4DUr/OFTgVZauFjnGPzcOpOBBqtuuEhw6tJToW4rcLRoVnjuLFNWmC3luzjP
 GBw0FNsduBnKoqade2iRs9GorjmpvuDaJWSs1MjAXe1LWD5VEEkE1dITRVCQMGK+uMIlKb0
 FcJSb5K8HCsbVga0vtZA87W+ZCRzr4Z2kVFdJdpYHHxJkwx7wb+pfBdzybq/Yi32Bmb3sQW
 5clG4SSNqqUZxirdTaiwgHG4DfDRErL4RmxLRyaDFgNHr2f0vKHI+3o5YUyAlA5YY0iGPsT
 bF5eKHhAzjq2+Y5EAH2Kbq9PVn9bPYC68zw+xTilPgz+svCmuNgH7Stvua5Q==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tt2vv-4o5NDgroS7Q-rZnl;
	Fri, 14 Mar 2025 11:10:31 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 0/2] Fixes packet processes after vif is stopped
Date: Fri, 14 Mar 2025 12:04:23 +0100
Message-Id: <cover.1741950009.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sFgC3_wmkW
X-smtpcorp-track: 5j9G6O2-OHEO.M_34vN0r6sca.QcOB6AXtC30

Those are a couple of fixes that prevent crashes due to processing
packets (especially multicast ones) for TX after vif is stopped (either
after a mesh interface left the group or interface is put down).

The first one ensure the key info passed to drivers through ieee80211
skb control block is up to date, even after key removal.

The second one ensure no packets get processed after vif driver private
data is cleared in ieee80211_do_stop().

As I tried to explain in second patch footnote, I can still see a
theoretical reason that packets get queued after ieee80211_do_stop()
call. But I was not able to reproduce it, so I may be missing a
something here; making that more as an open question.

Remi Pommarel (2):
  wifi: mac80211: Update skb's NULL key in ieee80211_tx_h_select_key()
  wifi: mac80211: Purge vif txq in ieee80211_do_stop()

 net/mac80211/iface.c | 3 +++
 net/mac80211/tx.c    | 6 ++++++
 2 files changed, 9 insertions(+)

-- 
2.40.0


