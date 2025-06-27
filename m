Return-Path: <linux-wireless+bounces-24633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1604DAEC1A5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 23:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58481C61CE1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 21:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602402ECD10;
	Fri, 27 Jun 2025 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Ulv877Cy";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Jw1/s8Sg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8853283FE5
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751058116; cv=none; b=SsmPhwzUFdLIkVXgK/tACtFeBRZdG3+b9QHl9BMtIJPhVhXHkkj112WpbXBXpbNvJR/ycJkVSb++WUi6c15Mz2Py+hx26NYhxHee7gQhmtBOlIXQOfRAmWFHUhlSnB81M/AEdnr8aLgh0YrW1NyExe8T69wKwPxnKNL6AAc1r+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751058116; c=relaxed/simple;
	bh=EqsjFcnoV7wkCfCblGpMw/2Zo+KMh0FeYoLwiaCPx8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAwIhttZg26yRw8ntGfV6iYVXnTpW+Va80hKqWIqFnN38otIcrFk27y4ySQ0nyNd1jIfExXim9o0DPSBB3yFAhwNXHbLLo/88dqBdpiFqRDHh+0SyvM+y/Zs7fn9nRkb167l9yKGTRnakVjMyKkkdwSyFvSOq35tw5aaVNSxtHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Ulv877Cy reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Jw1/s8Sg; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1751059014; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=EPjNXSD+QUTAQdHPBF1PZFOR+NJM45qYXx5B36QYUrI=; b=Ulv877Cy6GSz/29gbVphAz7YMp
	OdylGxob02CFcR1Q2TqKmsTdEPeVOLzMK9lQzlmLfVkD+KUquHvRbJecsZB54oQsWvvXlS6M8NdOv
	PMggmj27Hu1yyhDmN83Sg0ON0E6a22s711cHjFQHIdeu3IhKh2cr7lg0weJIWWQ/sy++x+BqpOJlD
	LVU1RE+3FtCw5v5FkJlpmkfpWmuM57Au6trjGI+EvAFwgM9xJqTgH7H1uIiHhyg7c3RYbbf4SOG6r
	3WcQPhrG8ZrnN1+Z0iSY2X8yct1tNjq+Mg6Yiz6ov2CABP4vqcZoZZ+HcJuoBTioKmE6FxzxG5SSi
	gnRlIqrQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1751058114; h=from : subject
 : to : message-id : date;
 bh=EPjNXSD+QUTAQdHPBF1PZFOR+NJM45qYXx5B36QYUrI=;
 b=Jw1/s8Sgqu9K3uylDxF0nAUedN7mrtRxhwl19RN4J/DC9AlMu9ETs6nfBs63O2HZ6lE3/
 Up1USLh9uSSxEMaorGP2ikb53030yNWNxxx5wfTwaU8rUXruBygb+ZBI5OWqGpoRx/CX1PX
 ZbzoYNTNQCCdzwV8xX4GbXNa3eTG/nb7G+49Dalx0spvpaOXPeRPVv7O+zZ2J4uD1u6erzX
 Jsb/ZP3fH4tYRveiDnvxvH6mUDyHw260mq65WwyYBnGH9rCJCNAHmkGQ5D9XdqGP46BnwLY
 4hrzz/2a9evhtw3ovTw0Ff1rXtvI0ZlJ5CmS6sS8oSbpvqh3Ge8yoyIKiiKQ==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uVG7V-TRk3aB-BP; Fri, 27 Jun 2025 20:56:25 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uVG7V-4o5NDgrjV9w-omjN; Fri, 27 Jun 2025 20:56:25 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless-next 3/3] wifi: mac80211: Correctly init MLO link in
 ieee80211_8023_xmit()
Date: Fri, 27 Jun 2025 22:46:49 +0200
Message-Id: <8ddf1dd6362e0ad57a98505b0d195554ebc91b7c.1751057146.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1751057146.git.repk@triplefau.lt>
References: <cover.1751057146.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: x_rOwYRXS2DB.OeLepUlhKppq.gDiOOQ7FvHY
Feedback-ID: 510616m:510616apGKSTK:510616s0p5iKs-_9
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
index d58b80813bdd..f65fb96a498e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4637,6 +4637,8 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 
 	info->flags |= IEEE80211_TX_CTL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
+	info->control.flags |= u32_encode_bits(IEEE80211_LINK_UNSPECIFIED,
+					       IEEE80211_TX_CTRL_MLO_LINK);
 
 	if (key)
 		info->control.hw_key = &key->conf;
-- 
2.40.0


