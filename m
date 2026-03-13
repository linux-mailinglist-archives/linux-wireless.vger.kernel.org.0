Return-Path: <linux-wireless+bounces-33218-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBIgExcetGlLhQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33218-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 15:24:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C8284E10
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 15:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6CF930EA01D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327AA39A04B;
	Fri, 13 Mar 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="MhPL4F0K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C5337689;
	Fri, 13 Mar 2026 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410015; cv=none; b=ChwHw0R9TIWOjB6fSRcuN0Ex7djkg40xmKssCC1YYhJh6a5YL4NBantBc0tLqw3klU8ZrvMgcsOmDQAMBI9zeROyfBo9bmmZJytgDnrK26NR3njcYMBb5gr8EQe1x7EyIJRp6p/GacROHt5g6wZJCBLufBNz4HNYmoSfln6qR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410015; c=relaxed/simple;
	bh=plr8UFlrvttBLqS3JXUr1ZQGA/EYWYmJgQ7wgmMv8+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTtwlkoyYsN8fFIVWOuI38CLaIAzEFBY2Jq87yPtAU0OZbIs/5KiG4W5Br+WwVBTFcyFcREoPKcTv75taDBrGDuQryu8nceQ3hMxaMWp5p+3Gy8pZYGUm25sAlu7TvSNU83kztrk4PkWrXOHAcrMSZf0ej8Zj59HABpfprZEBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=MhPL4F0K; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773410008; x=1774014808; i=georgmueller@gmx.net;
	bh=82NWvBMzgO3SS1TrS1CxxVCXjJnUnI+5VsLP1SIakQg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MhPL4F0KDJb194kYwgGE8W96RsyGwvtGV+iMt4Yk+0Ouqt7fNdAWmJwKU2THXLFG
	 ie0lETdZIaBX5WfrV7wrWRxfgfw5AalT1eNBOp1Sxp3HDwRyyabaTJA96weGzwU9d
	 fjn687ap+Lmy8MPhLlCaKb/kvZoJcfkWULoNdEDJ2z/5tbqPmFxbzZmPwCPMHlPfo
	 9NUDcqh5l0IPknS9UX534ybf4colipyj/f7KDIjkTbAI9birrnEno5EpPc1jPdfpd
	 ryBfVntfbBK4jWMt2QK9jLrld7qaGLurnA0sc+pI8wdsN+BheJm9haw/aKqoSlJvA
	 ERWjNTdtmYQcPh0YhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1vWTHc2mLg-0151FC; Fri, 13
 Mar 2026 14:53:28 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com,
	rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [RFC PATCH v3 3/4] wifi: rtl8xxxu: update max report mac id on station add / remove for 8188e chips
Date: Fri, 13 Mar 2026 14:53:20 +0100
Message-ID: <20260313135321.3196688-4-georgmueller@gmx.net>
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
X-Provags-ID: V03:K1:N6+m9iiW/mQwlc7hPSBCXoB/fdktVo8HuFzuEJe7I7VVSkXQo2J
 1OKWoJTzVMfUC0HClKO4/FH3nAaVGhQB85WNPzAO164PL+iiq96NgL4mXeo3khWtF+TWj+K
 p6yHpQnn5Epys0KxHVj4n0hcIqK+ha3MOshPjJKF1MvtS8N98q1Zu+3xsgZ/woTMnSjLW9p
 EHT+NP/hK0k0XE2DRzDaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MhcJahJORqY=;mqR7qQwE/QFVT2S+UwsxJ9WBULF
 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
 sLdqJflFQk3VmCfMpOzI
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33218-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 628C8284E10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=2D--
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 23 +++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wi=
reless/realtek/rtl8xxxu/core.c
index 5ad23c5c9305..15fc4843edb2 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -3884,6 +3884,15 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv=
)
 	rtl8xxxu_write8(priv, REG_RSV_CTRL, val8);
 }
=20
+static u8 rtl8xxxu_max_acquired_macid(struct rtl8xxxu_priv *priv)
+{
+	u8 macid;
+
+	macid =3D find_last_bit(priv->mac_id_map, RTL8XXXU_MAX_MAC_ID_NUM);
+
+	return macid;
+}
+
 static u8 rtl8xxxu_acquire_macid(struct rtl8xxxu_priv *priv)
 {
 	u8 macid;
@@ -7499,6 +7508,7 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *hw,
 	struct rtl8xxxu_sta_info *sta_info =3D (struct rtl8xxxu_sta_info *)sta->=
drv_priv;
 	struct rtl8xxxu_vif *rtlvif =3D (struct rtl8xxxu_vif *)vif->drv_priv;
 	struct rtl8xxxu_priv *priv =3D hw->priv;
+	u8 max_mac_id;
=20
 	mutex_lock(&priv->sta_mutex);
 	ewma_rssi_init(&sta_info->avg_rssi);
@@ -7510,6 +7520,11 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *hw=
,
 			return -ENOSPC;
 		}
=20
+		if (priv->rtl_chip =3D=3D RTL8188E) {
+			max_mac_id =3D rtl8xxxu_max_acquired_macid(priv);
+			rtl8xxxu_write8(priv, REG_TX_REPORT_CTRL + 1, max_mac_id + 1);
+		}
+
 		rtl8xxxu_refresh_rate_mask(priv, 0, sta, true);
 		priv->fops->report_connect(priv, sta_info->macid, H2C_MACID_ROLE_STA, t=
rue);
 	} else {
@@ -7535,10 +7550,16 @@ static int rtl8xxxu_sta_remove(struct ieee80211_hw=
 *hw,
 {
 	struct rtl8xxxu_sta_info *sta_info =3D (struct rtl8xxxu_sta_info *)sta->=
drv_priv;
 	struct rtl8xxxu_priv *priv =3D hw->priv;
+	u8 max_mac_id;
=20
 	mutex_lock(&priv->sta_mutex);
-	if (vif->type =3D=3D NL80211_IFTYPE_AP)
+	if (vif->type =3D=3D NL80211_IFTYPE_AP) {
 		rtl8xxxu_release_macid(priv, sta_info->macid);
+		if (priv->rtl_chip =3D=3D RTL8188E) {
+			max_mac_id =3D rtl8xxxu_max_acquired_macid(priv);
+			rtl8xxxu_write8(priv, REG_TX_REPORT_CTRL + 1, max_mac_id + 1);
+		}
+	}
 	mutex_unlock(&priv->sta_mutex);
=20
 	return 0;
=2D-=20
2.53.0


