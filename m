Return-Path: <linux-wireless+bounces-20769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA0BA6DFD4
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A68C3A87CA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE1263C85;
	Mon, 24 Mar 2025 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="pKMjuk9/";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="cWwiFe9L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i165.smtp2go.com (e3i165.smtp2go.com [158.120.84.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E264263F29
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834065; cv=none; b=Ax3jyCWsRf54rjhfZ6FgRrG8kBYmIS64kbcf47UMb3pgziNI3ayLS2yxaPQsYkAM81aQSk/tWThFex8QAPQa+Ub71rV30NczW9CHxyHLfRwiMkpoZ3IyY2oKogfW1QOCs/BRsYvSgKjBcBS76rKySziY3vhw3zVRj5Gq+RLTQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834065; c=relaxed/simple;
	bh=vtZr+kdulmEXyEwSmc6+O2wvWASjNK0fs9aMJTZW71o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i3/MsmhAekaxm1nXEpwyy3+fjkSjj4KvDS+i29Pod2V4XRf+/VHzP7QPEPiTr4U+5PjcbCvzQxUR4Dlsb1dWBb47b2wygbo7prS9RQu7ebZ2+42WYxNt1iQBCqMIfyh/GAAfA3SeZbbWsp4VaHeXFLeX7zldEs6tsECatTqLf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=pKMjuk9/; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=cWwiFe9L; arc=none smtp.client-ip=158.120.84.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1742834060; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=BwuwOuq+8Kdc1kpOd1ZfhyKeU2liqexDzuOzbtKiZao=;
 b=pKMjuk9/qqAg81EjL5aCnBxUeEridwKbh+WvQ/ed8Gq+gjf1KgDven4bSnj1SzcNmpDSM
 mg/amIde4SDY4hiEIJe8UeoiUcequF0czEessoRdICToxsLcmoBx6EyHmxc0nWcStj+6oW1
 LabMPrCZ0Wa1LaXFi6UzTfHpJh9Kz25TdmlnVOZXhcFyxdcrSE9XsKdmqF8nhN2oIB0FmZT
 dLHIkBOnW3S8fGKpocjJWOF7JGF33szfzLh7PHZT5ApWYV/h57pIiT+80m8fvFLGGr8cAMv
 8Vjgeo44Bbu1qGXBIrzlJsS9TDbtpXdeTvG23ApN1RTRYWCgXy3ocWHmb/Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1742834060; h=from : subject
 : to : message-id : date;
 bh=BwuwOuq+8Kdc1kpOd1ZfhyKeU2liqexDzuOzbtKiZao=;
 b=cWwiFe9LuzSCwCEczS1+axqOvcvJunc7NJihJhZ7neLzkxmBf1Hhl9cGfdGpBYdHcKLAQ
 i84mI9zQDOqSHWE8RfZ0UVyyOTeH7zW1kv6gTvzN7gSHq0Wg004fZhlBCGt6chS7NVDsSfB
 5ea5igIrl8PrlGiQYKQTZoK9HmqVDPZGAQONuBs2nAKajRU4WpeICXxEHszSlWXjF3bxe9D
 rxeAvoJpVF62BpO8M8LM3YUs9I7tFHhxuW5NTHynGb/W1wE6I8aLxbfmMeXSwmofKX7x1X9
 Vi0ZYAI98fg3acK1Uha8i95gvg2H+a4NvjvA3169HiiRA1rN1c0QYw2aVAXA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1twkkj-4o5NDgrs054-kFOZ;
	Mon, 24 Mar 2025 16:34:17 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless v2 0/2] Fix packets processed after vif is stopped
Date: Mon, 24 Mar 2025 17:28:19 +0100
Message-Id: <cover.1742833382.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616st8gJk_fpU
X-smtpcorp-track: _-Q-zmYJZCGd.1NRQJBS7ei_w.CEjyQAltNCH

Those are a couple of fixes that prevent crashes due to processing
packets (especially multicast ones) for TX after vif is stopped (either
after a mesh interface left the group or interface is put down).

The first one ensure the key info passed to drivers through ieee80211
skb control block is up to date, even after key removal.

The second one ensure no packets get processed after vif driver private
data is cleared in ieee80211_do_stop().

v2:
  - Add Fixes tag
  - Clear SKB's control block key before in ieee80211_tx_dequeue()
    instead of ieee80211_tx_h_select_key()
  - Add wireless tag and fix type in subject
  - Because subject changed, v1 can be found at
    https://lore.kernel.org/lkml/cover.1741950009.git.repk@triplefau.lt/

Remi Pommarel (2):
  wifi: mac80211: Update skb's control block key in
    ieee80211_tx_dequeue()
  wifi: mac80211: Purge vif txq in ieee80211_do_stop()

 net/mac80211/iface.c | 3 +++
 net/mac80211/tx.c    | 1 +
 2 files changed, 4 insertions(+)

-- 
2.40.0


