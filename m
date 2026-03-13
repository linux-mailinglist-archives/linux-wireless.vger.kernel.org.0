Return-Path: <linux-wireless+bounces-33216-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB/bA3wYtGlkgwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33216-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 15:00:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF18B284633
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 15:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC5F7307AFFB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2BB399009;
	Fri, 13 Mar 2026 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="cevxkFEt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409439657E;
	Fri, 13 Mar 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410013; cv=none; b=qh8o1Z5rxS9v/IAcwOFF9YsmXOmy/6rqXpMU5GGfwPd/0/NFsmu7vhICNb5emJo/OgN9AYXodhlvpNfe2QEQ3nTxccROUDVSG0QfUQTFZOaZ0OfObHynJCgfaSdRJ+fq6EeuORV7IlCpfGzvmOqjIRSL+TCsJhQ3EwCyKbJ8m6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410013; c=relaxed/simple;
	bh=cURSeb8d77uCwuTKLk8XRXcTqzI9CxyuoU6AcOisx5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqikklg7sLcPkyPVCg3JjYUGhxnp7PsdljC0uZ67hJ13dAM26gIB9ME8GZLDEiSuW0Th3dHEPbvJ46GRkGMQGO+PBFlCWg03RUusHOixrXx8OMIe6W2nhLdD4uDw+OeDShtTNm5X2bv6UOxNRYT8ePeuN18XWQkmrJ6TzNzajE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=cevxkFEt; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773410005; x=1774014805; i=georgmueller@gmx.net;
	bh=sU326B81AHABSZxumkQnBI+YeMPdBupeiusVZbEaiS0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cevxkFEtkeARnSw6RmVGCRZlNKT5t6a6V4nVWlq9Xbi/YcCqwh3/6ExI5RQ7PtIG
	 EKWGJ7TcxkeG/+gMXQhQ2jh2/nhGZokiAw8Yxv3l9Pz5ZQEb/Yyv37MOFtarKyxIQ
	 4eEA8OHepZB+bksvcvYxMMx756JycOHP26dtsidfSd+kJ7iXCM5bKCDL5ZQqVo2HU
	 p+8fGcgRyCLo5gdb9urI1Uxh1t2x8/4eeoaxGtb0Fa8h4YmIX2QyoSTq9rd06o9uE
	 TyyLcytnriUQKTDes1ECt8VnjVYwgigie0gqlHI2Iojdh3RGBYRmPIwZasTUqeP53
	 xdCFAcofFS9PpJwzDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1vwuDU28On-0052lv; Fri, 13
 Mar 2026 14:53:25 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com,
	rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [RFC PATCH v3 1/4] wifi: rtl8xxxu: move dynamic_tx_rpt_timing_counter from ra_info to priv
Date: Fri, 13 Mar 2026 14:53:18 +0100
Message-ID: <20260313135321.3196688-2-georgmueller@gmx.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313135321.3196688-1-georgmueller@gmx.net>
References: <20260313135321.3196688-1-georgmueller@gmx.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hEOcHvBfbPXTaF0CoqGh81uKV06Ew2RF9VcfPMiNPZSum4txNxI
 C3RTs6cIP3w3SFliY185Wis5g2Jl/agzNqDUvBswKa3kfnkiwmBO0sVccmPUl/h9B7dEA/u
 sWGJd9EcyGya4fG0b0afNYBDrByEzwgZ26tpNIyuu2y7vADDwxzQOrsmhTwxPM6q88ffaVx
 YXCEjBw5XrVocscN555IA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nSDWEJ1Atv0=;6YTaD3EVa9Aa+6/Vi+x14mor8WC
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33216-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF18B284633
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


