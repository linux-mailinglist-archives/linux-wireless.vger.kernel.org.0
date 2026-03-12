Return-Path: <linux-wireless+bounces-33106-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBwwCdrNsmmPPwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33106-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:29:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8AC2735C3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 15:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BDDE31BD0D8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BA5347FD0;
	Thu, 12 Mar 2026 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="LqFm57Zr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF136D9E7;
	Thu, 12 Mar 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325353; cv=none; b=LdViabaBn6pkOqWEBlDlnR65rWoB4fSboiEmZixB5CvKsWg1n0amEVSUzKWZgS158N8gzKk/YjMvj06H++wLavhvtlJOeufekvfXoh1oZpZHnMmlW9tF8I/kHfZOMjCO9xBw/BbanmmQON8QwcXlNbFu+Rqhlm+XRizLcmZY26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325353; c=relaxed/simple;
	bh=I/2q3R1JamFsbA0YXQYidwP9i0QU3VXbv8dmjJrQb7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uYct25UCTJAyBC4I4MVYg+h3+tz+6dq/1uZE8U7jvDR2ZcRVJUqrSF9L3HSNMAiwufkt+4ivBFHEOlYHdGu4seqwpfOi6sMdphykAUrKvvz8NsPfh+O9oNDA1uz8dbhm/pyHEH473rlBQ1EAW34bGMo+51V79rygwXF+qCfzhZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=LqFm57Zr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773325348; x=1773930148; i=georgmueller@gmx.net;
	bh=pWh/z2sfrDxyEiKeshwrhMoxbcjpc0e0oVAWv8zMufA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LqFm57Zr3lyhvMzn4iGwL2tjtdzyQDjJ++AjZpA0U6GQ76nueI1iTSA9le6HbgbM
	 JPzXINRVYDZtzX8MOCg6/JELNOMB+APlCa0GR1Am4QbubGrFwYyk6X3fWUP8O4Wm0
	 9mgiSABc9RLHJbMvMhKPa3wzB5FddV+bQ2bHrmkMxQn2+KwDyrCHGqD4mx5GFlGNf
	 ZHeNzTlNx2Ml9iu04+vXuTsJ0pB24jElEzvQu38TT33cK5LTsIEnlvqJ3PJ6rSUDw
	 w2YQI4SJQda1ZUhZfojPfV6udIuruGxqd/rwT/qTqXi5P2unHnSXodJFDGgIpvFYN
	 CxPCwZuK7gvJphOuow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1w2KpF3Qa2-0020B7; Thu, 12
 Mar 2026 15:22:27 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [PATCH] wifi: rtl8xxxu: Enable AP mode for RTL8188EU
Date: Thu, 12 Mar 2026 15:21:55 +0100
Message-ID: <20260312142155.2642993-1-georgmueller@gmx.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LlfzIP1FXBPLp6MpLNm+ozSZGZhauTDefnG0Cs/DnEHztcoKuc9
 ZRSIETZIEDYMa8XSmvOJymyMh4OScxa/XVM6mPobW9aLQOFuFkUNvV+ktsCaAWv65JCTq+i
 SEWxcZUoo5SGp/HKlXl7AQFgrfUla7H1BvGpapFTvfZoEOPAchXvTu8r4mPWB/lDolz29Rz
 o03dLQDD+z7i/qHwYjUcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iZjMBwINjEw=;fVY5BuRSADbYidPQvJwgaTUxmAh
 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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33106-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.net:+];
	FREEMAIL_FROM(0.00)[gmx.net];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F8AC2735C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow devices with this driver to be used as a wireless access point.

I successfully tested this with a TP-Link TP-Link TL-WN725N adapter.

Experiments two years ago failed, but some other improvements to the
driver seemed to have resolved theses issues.

The max_macid_num is conservative. The old driver used 32 [1], some
other sources said 64. I have not enough adapters to test any of the
higher values. Given the usage of this chipset in nano dongles, I think
the 16 might be high enough.

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
=2D--
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/w=
ireless/realtek/rtl8xxxu/8188e.c
index 766a7a7c7d28..c6aecb28d28b 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1867,6 +1867,8 @@ struct rtl8xxxu_fileops rtl8188eu_fops =3D {
 	.init_reg_pkt_life_time =3D 1,
 	.gen2_thermal_meter =3D 1,
 	.max_sec_cam_num =3D 32,
+	.supports_ap =3D 1,
+	.max_macid_num =3D 16,
 	.adda_1t_init =3D 0x0b1b25a0,
 	.adda_1t_path_on =3D 0x0bdb25a0,
 	/*
=2D-=20
2.53.0


