Return-Path: <linux-wireless+bounces-33219-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MVwFGQZtGkihQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33219-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 15:04:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A64284768
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 15:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED9A7319560E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF00399358;
	Fri, 13 Mar 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="W7XX/ubN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75EF398910;
	Fri, 13 Mar 2026 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410019; cv=none; b=misWeyCCVvJyeOlwfjqFTVJ6QDXDVBqw9ToIXkuwVDiHAc+jnN2nPTycwlc26YTKUi82ca+HzbEg94bimGeMCma8o61POlmj/Q+cJ51rT+RJ+GQi0NkmIHbVRY9PaPk47JFs5q/pW8mg9tjBVwmqMMNEk73dXFlA3nbxsjxZuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410019; c=relaxed/simple;
	bh=Ev/C5VI3XmElXhMIXtw53Ut73SZi5/csrEWIvoB4MGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzlptmH9Eu4KTmnU6em4hzQi3Z6P0aVcPKDuFUGxdsGv7ltXtbUlFqyt0ZT72iQi55/cIXicSqKrYf71ilDGJc30324K8v5dpNlm8VptrkcJZdTeOIkjzn5byJF72gHWN9T1mr0YahQbi95/E3eYXm9dM3Qkul5q+9SeVKr0+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=W7XX/ubN; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773410012; x=1774014812; i=georgmueller@gmx.net;
	bh=sVDwYWZE6JgmTFrLJ9o/fxiZ/qqbRfI8tnAaxDTv2Hk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W7XX/ubNQWTnzlWHxoQe+Ii8vznaCazVYF0+lC2gK1Cv70TohhAd4g9o7NG4zlQk
	 8cqn5+fPh/TsHZkC11wmGS3ibH0mXY2uKDVWsXfc6Gq5+R3//X9Ym4dTtKrCyyJQc
	 YcQWQyxhM8Efhe5KCurLZwoVhM3f83kzlXxmqD1TK6oAqdWafhAYBiOOADfXORKz9
	 i9KD8uDo0J1QBb58OUGaZ0AU9LD/ZAAiS0F6I0yFmzXkTthKzY+METMXIM56646WO
	 o4i9jg3O5RZHYXh+W0o2YUsU9q6pOev4xiyi7YC5rkX9c4j4ks04ym6ZMjhrVGZeq
	 4vTg0/8rosZmOxeZ5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1vNqRu39xx-00eNad; Fri, 13
 Mar 2026 14:53:31 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com,
	rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [RFC PATCH v3 4/4] wifi: rtl8xxxu: Enable AP mode for RTL8188EU
Date: Fri, 13 Mar 2026 14:53:21 +0100
Message-ID: <20260313135321.3196688-5-georgmueller@gmx.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313135321.3196688-1-georgmueller@gmx.net>
References: <20260313135321.3196688-1-georgmueller@gmx.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x4lYjiGWjOCbcW9Wha0/doEzYNydqTj0Sajpt3m0KYtzfPrHXUw
 n5d2/i4MuK595lE+74A4WvwehchufsSrIIsWVF+5mrviQFkXdtK+LwO6b3bZ6Xv0CRBzbAL
 T9sd5HYYiNHXNXtwIq7HxSkuSBqgq3MwEXdGzQszOMgwqNH3LGxWSSYdFajL1wTuvFuzK5V
 lWlnYOx+1Mk8qdorksSIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:htm/yoRnPYc=;+bSC/4B7Or/Fxwh8KDZxJSV+PKz
 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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33219-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9A64284768
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow devices with this driver to be used as a wireless access point.

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
=2D--
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/w=
ireless/realtek/rtl8xxxu/8188e.c
index 607ca62194fc..67fd77944d67 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1867,6 +1867,8 @@ struct rtl8xxxu_fileops rtl8188eu_fops =3D {
 	.init_reg_pkt_life_time =3D 1,
 	.gen2_thermal_meter =3D 1,
 	.max_sec_cam_num =3D 32,
+	.supports_ap =3D 1,
+	.max_macid_num =3D RTL8188E_MAX_MAC_ID_NUM,
 	.adda_1t_init =3D 0x0b1b25a0,
 	.adda_1t_path_on =3D 0x0bdb25a0,
 	/*
=2D-=20
2.53.0


