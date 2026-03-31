Return-Path: <linux-wireless+bounces-34250-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAoVAERFzGm+RgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34250-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 00:05:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E04937249D
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 00:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10ABA30041C7
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 22:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC883C872F;
	Tue, 31 Mar 2026 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="ZR9WyAz5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9F38F647
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994754; cv=pass; b=Sm3MHN9s8jScS8hK39uGqtYfXO/Lkhhy8pvgRvXncLZS0LNegBRHaYtLKFFXIKqjJyfzt54eUpq04YIUTLDlLyk2oj8OYxRHGb++RsOmqYEa71f375durgd9SFx9mFQd97g+S8TrTdT2TFrbpZk1S9kc70ubjwap66YK+PztERY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994754; c=relaxed/simple;
	bh=7n0QLihEez16Y9uHZ6K6NQYRSG3kzEJw19JuoftbVSQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=U6bCHEWvM9j2XP0moHuq4Bvn6dMEvQmZYeHnDOPxz4N784fvCC6pommeWLjGl6/+ZrOMWIX/pyOcK4892d3EAM1nyIh/wWy/zJFZ5xikf0I6DfPvudk8MOxJ9PGQuAIhWScdu9LHxuTB4VXx7xcVa70TKLqNrEUQ+q0vw3+XICc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=ZR9WyAz5; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R13" (not verified))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4flhyR27f3z3L1g;
	Tue, 31 Mar 2026 22:05:51 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R13" (not verified))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4flhyR0ybPz3jNt;
	Tue, 31 Mar 2026 22:05:51 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1774994751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ER5k6Tx8YoT0LOhGRtOGolHA5M4cofhM+9sr7u6XgO0=;
	b=ZR9WyAz5mlh62aDJ8Po2nBr803Iqg3CF6+mYc5EB9w2Wv8Ja3YcIwEBknddHDxuuiuVvnG
	77Z/d712NbVfJhJhHVyQ4ByhJukr0SotmQpKRkNBAkvI96ioaUb+3gvZoVBcTYv91YkLej
	inGQD2c/IzbU+S6SraiG1qpbQyopZWPHrKxPM6XLErVGuvTQ91d8Q6AkJccGdCZ9fEgsnx
	gxVR6t+naIEtDPzoZhWnAucG0T04MmxuDBjL1RGRNxPEAl2Nhl42b6YdqwUP5/5NTDHZl3
	DVmQYlxgomH+Sag1BNMJ3KAXsuWOEcM8P9FR/tT63K4PJ25r2ANdE4tDlmKgJw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1774994751; a=rsa-sha256; cv=none;
	b=TnjXYw8wgXKQRvsq7SWhZC0YdAyAdxJeIIsjlaJFEONgNLy41GrOwSPnwGPk1+fShJf/Sk
	jUhIodJv/wQ5wHGknGrOCG1F41z7xkmXCzAfTqdoz8+On82uG+KA0x57ShIp6ctib6DCEe
	cxoUR4cYqcSlFoKlcmvKFqpCmG/JDNE2VKuQ5kIhf9P4eiPXNZBugVbAAQhUEhm9rXYbV+
	5htmlhvmT5ZImb68e4YaLvkN+YQPs4Nf7zhN6iAdoOH8WPncr8k4RoFMKH2yT0wJMmAs/H
	Xt9361LV0xwGv5bFn47VCevMsv8WFLTjSBr/LX9l+3jTUeq0LGsE/6ArTMpGmg==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1774994751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ER5k6Tx8YoT0LOhGRtOGolHA5M4cofhM+9sr7u6XgO0=;
	b=QW4mMZiaZz1bkbD7I39InBFeMEgMVaUwveWaovIKO2s4txZ/2bZ92kVDvwry9lWbNsyxbl
	TyfpjAG2GLGyLFU3G4GlUIm3GhZ5DOFpy2KUiVIteDLQP67T3G4o3brIEV+RsmUupK1Aag
	wHab2kux8E9rRyMCF5QNF1gNLAAuj0qeYNxg3wwx8kmsJT8o2i9GhxDwYZ3QA7K9y7mlNG
	9DKo7PFVlKaFed9ltAAyyZjPH30uow0DhzbAiKet0Se4LySvCvOw7AEHz7wAKJZ7PS4IQ8
	+6qfrYhdZAC90LMexMMmQcF/9eR5S/hqyT6wM7ll/STTQb2wa9bxPnmPrk0+Uw==
Received: from mx-01.divo.sbone.de (mx-01.divo.sbone.de [IPv6:2003:a:140a:2200:6:594:fffe:19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature ECDSA (prime256v1) client-digest SHA256)
	(Client CN "mx-01.divo.sbone.de", Issuer "E7" (not verified))
	(Authenticated sender: bz/mail)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4flhyQ6T5Nz5Yb;
	Tue, 31 Mar 2026 22:05:50 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mx-01.divo.sbone.de (Postfix) with ESMTPS id 01B1AA64805;
	Tue, 31 Mar 2026 22:05:27 +0000 (UTC)
Received: from content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPS id DDA9B2D029E9;
	Tue, 31 Mar 2026 22:05:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	by content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742]) (amavisd-new, port 10024)
	with ESMTP id 7Wp4oFCQP8cg; Tue, 31 Mar 2026 22:05:48 +0000 (UTC)
Received: from nv.t4-02.sbone.de (nv.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPSA id 9F1A52D029D8;
	Tue, 31 Mar 2026 22:05:47 +0000 (UTC)
Date: Tue, 31 Mar 2026 22:05:47 +0000 (UTC)
From: "Bjoern A. Zeeb" <bz@FreeBSD.org>
To: linux-wireless@vger.kernel.org
cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
    Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
    Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] wifi: mt76: fix argument to ieee80211_is_first_frag()
Message-ID: <83s4psnr-popo-8789-757o-npr2n9n7rs2o@SerrOFQ.bet>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[freebsd.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[freebsd.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34250-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,SerrOFQ.bet:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[freebsd.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[bz@FreeBSD.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9E04937249D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ieee80211_is_first_frag() operates on the seq_ctrl not the frame_control
header field. Pass the correct one in; otherwise the results may vary.

Fixes:		30ce7f4456ae4 ("mt76: validate rx CCMP PN")
Link:		https://cgit.freebsd.org/src/commit/sys/contrib/dev/mediatek/mt76/mac80211.c?id=c67fd35e58c6ee1e19877a7fe5998885683abedc
Sponsored-by:	The FreeBSD Foundation
Signed-off-by:	Bjoern A. Zeeb <bz@FreeBSD.org>
---
  drivers/net/wireless/mediatek/mt76/mac80211.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 75772979f438..76b93326a997 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1316,7 +1316,7 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
  		 * All further fragments will be validated by mac80211 only.
  		 */
  		if (ieee80211_is_frag(hdr) &&
-		    !ieee80211_is_first_frag(hdr->frame_control))
+		    !ieee80211_is_first_frag(hdr->seq_ctrl))
  			return;
  	}

-- 
2.51.2

