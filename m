Return-Path: <linux-wireless+bounces-33210-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JELJOcOtGlvfwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33210-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:19:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B62839D4
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C9153008C92
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955030E831;
	Fri, 13 Mar 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="Km1Lj2Pj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871D3BB40;
	Fri, 13 Mar 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407961; cv=none; b=mVODbXeVCHsVe8ZbQWKvlu++Nujbn83DaoC/gCz9e3Qpk2bgyuPrU/374A0+80BBOOt5DSqn7d8VLGEYPU8K7DwA97auivN89q7AdK3wOJTrLb/uafX701QI3vgnfAb/p6KjY75lPei5ut+InQGrQNa7ykp3rBomydr6RtKUbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407961; c=relaxed/simple;
	bh=cURSeb8d77uCwuTKLk8XRXcTqzI9CxyuoU6AcOisx5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8rZ8JbgHxppVbI3XBzWF/Uccbe0X9zUe0mSgHgfALYSnPBQgP8soIj8iYHz/zeylWtjwUkzVKDC0S/xsMh9y2oMgzM+PFln5ELxujOAq4vv2DSoNDblEkJx2AeoAz20ywcXJ16rfYMLQFmWQ0yqeyp23FKmpaMABp5U6DxT3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=Km1Lj2Pj; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773407958; x=1774012758; i=georgmueller@gmx.net;
	bh=sU326B81AHABSZxumkQnBI+YeMPdBupeiusVZbEaiS0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Km1Lj2Pj8j/6JxFAdpizdTlPyfGFs/NvdH1hmXwb8UswO19Z5HtOTVlQsXps1X22
	 QMaZe27kI1uTqJ15SrzCuggVPF2A/vtCEVeoYA8RiMS1v66DoWaCEzoQfbJSEXfm/
	 AzamvMIpL5y8gUAFbJX83lVsATtgZXgukK/CO8TslFcLV2utxtdGUG1M9vZXipUHe
	 Fp1DXSZMyuqnfjD7sZrxbOshv9pLP3hjOq9uJReQ+8j8OEjjKA26+3Fwi7jwHNJ+8
	 Hu3jYP0GA0TXEaNQTqp6Pj2AWWl2cR4EI0F05rU6CVOc9GyKk5rWtopXUdv+KwU/u
	 cetzhHr6ok9Wa7ZArg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpf3-1vL7hh066Z-00lFRn; Fri, 13
 Mar 2026 14:19:18 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com,
	rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [RFC PATCH v2 1/4] wifi: rtl8xxxu: move dynamic_tx_rpt_timing_counter from ra_info to priv
Date: Fri, 13 Mar 2026 14:18:46 +0100
Message-ID: <20260313131849.3148013-2-georgmueller@gmx.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313131849.3148013-1-georgmueller@gmx.net>
References: <20260313131849.3148013-1-georgmueller@gmx.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YbVxgbGLT03AElLy8OcYyqVm2H9S6L/1GS5Ds/ttJbmLxwsJDZn
 eqFyOZxaMhJz4SkR+1RZQYOXlY0Zy8l4rXPKKplNjp6KzwLdsQwAcCeu4Z+Np6kuPeb+IpF
 xtZw0XqGfxK+cAsYvLWRkp0fyc48g39o/LAlr4uYYUQQTbAB+2mRpv9QmFuITP0QP0Q0HNw
 Ck0kazoDUQsz0v87TqPXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WF4ppsnkgZo=;1GrJIfvp0/UMixjpjY+mZ5ag5vq
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33210-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	DKIM_TRACE(0.00)[gmx.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 901B62839D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dynamic_tx_rpt_timing_counter is not per mac_id, but used across all
mac_ids.
=2D--
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c    | 8 ++++----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/w=
ireless/realtek/rtl8xxxu/8188e.c
index 766a7a7c7d28..de2837a91bbe 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1550,14 +1550,14 @@ static void rtl8188e_rate_decision(struct rtl8xxxu=
_ra_info *ra)
 	}
=20
 	if (ra->decision_rate =3D=3D ra->pre_rate)
-		ra->dynamic_tx_rpt_timing_counter++;
+		priv->dynamic_tx_rpt_timing_counter++;
 	else
-		ra->dynamic_tx_rpt_timing_counter =3D 0;
+		priv->dynamic_tx_rpt_timing_counter =3D 0;
=20
-	if (ra->dynamic_tx_rpt_timing_counter >=3D 4) {
+	if (priv->dynamic_tx_rpt_timing_counter >=3D 4) {
 		/* Rate didn't change 4 times, extend RPT timing */
 		rtl8188e_set_tx_rpt_timing(ra, INCREASE_TIMING);
-		ra->dynamic_tx_rpt_timing_counter =3D 0;
+		priv->dynamic_tx_rpt_timing_counter =3D 0;
 	}
=20
 	ra->pre_rate =3D ra->decision_rate;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/ne=
t/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 9fb2583ffffc..4a744b5c1aec 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1756,7 +1756,6 @@ struct rtl8xxxu_ra_info {
 	u16 drop;
 	u16 rpt_time;
 	u16 pre_min_rpt_time;
-	u8 dynamic_tx_rpt_timing_counter;
 	u8 ra_waiting_counter;
 	u8 ra_pending_counter;
 	u8 ra_drop_after_down;
@@ -1917,6 +1916,7 @@ struct rtl8xxxu_priv {
 	struct rtl8xxxu_ra_report ra_report;
 	struct rtl8xxxu_cfo_tracking cfo_tracking;
 	struct rtl8xxxu_ra_info ra_info;
+	u8 dynamic_tx_rpt_timing_counter; // 8188e specific
=20
 	bool led_registered;
 	char led_name[32];
=2D-=20
2.53.0


