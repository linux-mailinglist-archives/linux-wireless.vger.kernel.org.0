Return-Path: <linux-wireless+bounces-33212-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEAxAV0PtGlvfwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33212-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:21:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93174283AAD
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 14:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 324F5329775B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DFF32F765;
	Fri, 13 Mar 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="NctgNxXF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC31329E40;
	Fri, 13 Mar 2026 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407964; cv=none; b=VbtrhvVbB3F2ubTcXrd9T9eBJyvp1ExOcqwZ1fhVNTlD+n5cl7W8s/SRqoYTMrZNoX4mFaov3ErSOSOFHQotwzLkUJrMTYrMXTjfMjbIcOmjqPitlJpdHmHofUlPze7czEzPaCaoM5psvVkR5cP3cwSfDygMZLmr6oOs9pkQS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407964; c=relaxed/simple;
	bh=aaFokvLY10mt9Ln7LLVjg+UiGI4sCBsjNTANlsst+g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mq/9iU5+w3RSkfx7SiuJv1FKHQTpYiGu8tiM9IghPOGXhsZ5rkLk5ItCKSgrpon6VzVObB+MGRpsz/LInmhi/xS+yE6soHleBoUG6Ea4Ov0tbpjIZw0eswhyef98FUtRqyX2JEnSW4P6P+UdFxc3F2lKLPQi4+0y+l/jfVS0tmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=NctgNxXF; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773407961; x=1774012761; i=georgmueller@gmx.net;
	bh=TnHI/tI0V99d+1imxpAMCANQra4EtbBSJAuGqKiQS+s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NctgNxXF6nwNv8B1P24nxuwvUeQqZPF380UhH3CTtJaRDYrwnZvahcZU/e8mNGkZ
	 s/Y0atXSba8Zb4fd25cUVwHQXI5xGvjdhJscgRXLpY1orUrVNU+QBUlvd08vJ8wRO
	 R3CkoUj3MvfnGXv57CA0hE/FVoKMUWeldacvc550zueaflBr4UiFBX8X7/SBOWCaP
	 WYXXo5O/PJFrd2Jrjr//5ObtpBB+G2eg6ZkorGLqqR8DClAUHeXC2CNNshEuCa/Vu
	 It8MeS4kMJxsyvkPncuh9NmsKCY1Fgc/1n6mLULF87Wuy4/5H/bT5I0M9Va1TxRxH
	 6i1455/tVP3AHjGy3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf07E-1vQKkl1S94-00hh3y; Fri, 13
 Mar 2026 14:19:21 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com,
	rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [RFC PATCH v2 3/4] wifi: rtl8xxxu: update max report mac id on station add / remove for 8188e chips
Date: Fri, 13 Mar 2026 14:18:48 +0100
Message-ID: <20260313131849.3148013-4-georgmueller@gmx.net>
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
X-Provags-ID: V03:K1:dMUZFCmFxwPOt2HaAy5ZWJEXWxJ1LD/27vPbWWUIZS/zsp+ePCY
 Ae2ld01XYax41I+oUYtjyqf9Srb+siNCtCb7y0zQdHvPyz4tfKkaskaE2dcAn1EDRdXKURU
 D5RwIw1iSncisUx9ukyF3E+DPrvzlgPgLzM+5Nt1kMpaZ7+KkiX0kbaBaxxIVaBc4ETc5ll
 ordrke8zDIRpRjfggINQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kzpex89Qyq4=;AeWKQU65NrSk+gOvF42Nx8uD6UN
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33212-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93174283AAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=2D--
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 22 +++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wi=
reless/realtek/rtl8xxxu/core.c
index ea4dcca9d22a..6d97bb212f75 100644
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
@@ -7537,8 +7552,13 @@ static int rtl8xxxu_sta_remove(struct ieee80211_hw =
*hw,
 	struct rtl8xxxu_priv *priv =3D hw->priv;
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


