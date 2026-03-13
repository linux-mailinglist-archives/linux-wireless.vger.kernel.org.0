Return-Path: <linux-wireless+bounces-33217-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHMPC+cZtGlLhQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33217-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 15:06:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96343284853
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 15:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCEF83152C82
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28212399036;
	Fri, 13 Mar 2026 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b="aKyjk9Ov"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B3C306D26;
	Fri, 13 Mar 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410013; cv=none; b=SBHnz3dW/X96wvN3pRAXY7F9kK/ftpt2aUkMJVpCJSx17cY6QO2M2s+fl04bJ+5sjyIBcrzdjWsNAGmSBnj1IK/QLv9aZhIRRZwk/EfxkKG+OWTQkC6Y6IEKFHf7s5lK/KfU+LklRdT5Wdp3dpD6n4QmobUYqcqTKuUrULb4RkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410013; c=relaxed/simple;
	bh=kuKkuOo1N7JjU1zn+9U9ylFBmN8O4rwy7Su/i7OeCkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crzTxs1OOf2Fdi6sp5vpAfp3m7KYtyQJmE3gzXKbBG1jU73NUzZ3Gqk22Kj2LfBCiQbfk5zSvXUS1lvQnDLA6fLM9tNRtZP2il5ttW+GZUmRO5ZlIWryb0ZMR1eSiR+dSAvXrPkUdMDejpduneRx3wndudC2xlnGkw5yBfqZRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=georgmueller@gmx.net header.b=aKyjk9Ov; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773410007; x=1774014807; i=georgmueller@gmx.net;
	bh=Iz8DYVgIBYAsMryw6xeY36fKvR5qpvNg5nOunNwpzgI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aKyjk9OvmZm6OOT7ozN1Ml7L1nFEDLwHXKk4BGU83WxgwGiA0NBc3Eb360OdOhMy
	 LsBFKbzalTK3Tt23NWHi8T88uAoR+OfFZ/yz7QO46hioZh8SZa9nDx5yP42S0cbIZ
	 s0NVKgiwB6WSzt39/82pH/KvHdgOSvGwvS4VB0mJkx5PcjSTy9W4K8mapR3cHI0Kl
	 Ff98V1Akz5O3Nnfp67KCGJ50b9dp202l4QWXRBBln0PUdNUByWQefTj/4dFieDbHE
	 3IxlDzl9F1EuCMv70pUdVgMw1X3IZAud5wwsX02HV5Cz81dGFy0lXXibdZp/dRbrF
	 eMciknH2qe3yYriPjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7QxL-1vXqrT3jcj-0182Rr; Fri, 13
 Mar 2026 14:53:26 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Jes.Sorensen@gmail.com,
	rtl8821cerfe2@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [RFC PATCH v3 2/4] wifi: rtl8xxxu: handle rate control for 8188e a per mac_id
Date: Fri, 13 Mar 2026 14:53:19 +0100
Message-ID: <20260313135321.3196688-3-georgmueller@gmx.net>
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
X-Provags-ID: V03:K1:rR+tWhra+gHR7k1CmMLYbLTDrCW7QK76vOSmK3PutijavBELjM4
 V0WsAodIb8tvMKLaA+e09coGYHf3yYFTW5Ra98OFSuW8dQoDTLfAca9jWf5Q/Y/ONHp5FP+
 CCVZSUfKwYeItV8p0Sk1HwNj8JBXw3lJSva53NzsLACtOmd/Y893Qe8u9CVo2kYbQSCPsF+
 FhQ15FdaqDhdor8at012w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+GflHdghnCs=;htbb0JAqtytLfGlhqkczAi3noWB
 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
 N+ktmJscC8SiyLH5dJFz/+VERktF3x76w==
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
	TAGGED_FROM(0.00)[bounces-33217-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgmueller@gmx.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96343284853
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

convert member ra_info to an array with one entry per mac id. This
allows having different rate control settings per connected station
in ap mode.

The max_macid_num is conservative. The old driver used 32 [1], some
other sources said 64 [2]. I have not enough adapters to test any of the
higher values. Given the usage of this chipset in nano dongles, I think
the 16 might be high enough.

[1] https://github.com/lwfinger/rtl8188eu/blob/f5d1c8df2e2d8b217ea0113bf2c=
f3e37df8cb716/include/sta_info.h#L28
[2] https://lore.kernel.org/linux-wireless/27e83382-4c84-1841-c428-d1e5143=
ea20c@gmail.com/

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
=2D--
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c | 12 ++++++------
 drivers/net/wireless/realtek/rtl8xxxu/core.c  | 19 ++++++++++++++-----
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  3 ++-
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/w=
ireless/realtek/rtl8xxxu/8188e.c
index de2837a91bbe..607ca62194fc 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1468,9 +1468,8 @@ static void rtl8188e_reset_ra_counter(struct rtl8xxx=
u_ra_info *ra)
 	ra->nsc_down =3D (n_threshold_high[rate_id] + n_threshold_low[rate_id]) =
>> 1;
 }
=20
-static void rtl8188e_rate_decision(struct rtl8xxxu_ra_info *ra)
+static void rtl8188e_rate_decision(struct rtl8xxxu_priv *priv, struct rtl=
8xxxu_ra_info *ra)
 {
-	struct rtl8xxxu_priv *priv =3D container_of(ra, struct rtl8xxxu_priv, ra=
_info);
 	const u8 *retry_penalty_idx_0;
 	const u8 *retry_penalty_idx_1;
 	const u8 *retry_penalty_up_idx;
@@ -1669,7 +1668,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_p=
riv *priv, struct sk_buff *s
 	u32 *_rx_desc =3D (u32 *)(skb->data - sizeof(struct rtl8xxxu_rxdesc16));
 	struct rtl8xxxu_rxdesc16 *rx_desc =3D (struct rtl8xxxu_rxdesc16 *)_rx_de=
sc;
 	struct device *dev =3D &priv->udev->dev;
-	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
+	struct rtl8xxxu_ra_info *ra;
 	u32 tx_rpt_len =3D rx_desc->pktlen & 0x3ff;
 	u32 items =3D tx_rpt_len / TX_RPT2_ITEM_SIZE;
 	u64 macid_valid =3D ((u64)_rx_desc[5] << 32) | _rx_desc[4];
@@ -1688,6 +1687,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_p=
riv *priv, struct sk_buff *s
=20
 	for (macid =3D 0; macid < items; macid++) {
 		valid =3D false;
+		ra =3D &priv->ra_info[macid];
=20
 		if (macid < 64)
 			valid =3D macid_valid & BIT(macid);
@@ -1704,7 +1704,7 @@ void rtl8188e_handle_ra_tx_report2(struct rtl8xxxu_p=
riv *priv, struct sk_buff *s
=20
 			if (ra->total > 0) {
 				if (ra->ra_stage < 5)
-					rtl8188e_rate_decision(ra);
+					rtl8188e_rate_decision(priv, ra);
 				else if (ra->ra_stage =3D=3D 5)
 					rtl8188e_power_training_try_state(ra);
 				else /* ra->ra_stage =3D=3D 6 */
@@ -1781,7 +1781,7 @@ rtl8188e_update_rate_mask(struct rtl8xxxu_priv *priv=
,
 			  u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
 			  u8 macid)
 {
-	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
+	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info[macid];
=20
 	ra->rate_id =3D rateid;
 	ra->rate_mask =3D ramask;
@@ -1792,7 +1792,7 @@ rtl8188e_update_rate_mask(struct rtl8xxxu_priv *priv=
,
=20
 static void rtl8188e_ra_set_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8=
 rssi)
 {
-	priv->ra_info.rssi_sta_ra =3D rssi;
+	priv->ra_info[macid].rssi_sta_ra =3D rssi;
 }
=20
 void rtl8188e_ra_info_init_all(struct rtl8xxxu_ra_info *ra)
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wi=
reless/realtek/rtl8xxxu/core.c
index 794187d28caa..5ad23c5c9305 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -3921,6 +3921,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw =
*hw)
 	struct device *dev =3D &priv->udev->dev;
 	struct rtl8xxxu_fileops *fops =3D priv->fops;
 	bool macpower;
+	u16 mac_id;
 	int ret;
 	u8 val8;
 	u16 val16;
@@ -4393,9 +4394,16 @@ static int rtl8xxxu_init_device(struct ieee80211_hw=
 *hw)
 		priv->cfo_tracking.crystal_cap =3D priv->default_crystal_cap;
 	}
=20
-	if (priv->rtl_chip =3D=3D RTL8188E)
-		rtl8188e_ra_info_init_all(&priv->ra_info);
-
+	if (priv->rtl_chip =3D=3D RTL8188E)	{
+		priv->ra_info =3D kmalloc_array(RTL8188E_MAX_MAC_ID_NUM, sizeof(*priv->=
ra_info), GFP_KERNEL);
+		if (!priv->ra_info) {
+			ret =3D -ENOMEM;
+			goto exit;
+		}
+		for (mac_id =3D 0; mac_id < RTL8188E_MAX_MAC_ID_NUM; mac_id++) {
+			rtl8188e_ra_info_init_all(&priv->ra_info[mac_id]);
+		}
+	}
 	set_bit(RTL8XXXU_BC_MC_MACID, priv->mac_id_map);
 	set_bit(RTL8XXXU_BC_MC_MACID1, priv->mac_id_map);
=20
@@ -5338,7 +5346,7 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, str=
uct ieee80211_hdr *hdr,
 {
 	struct rtl8xxxu_priv *priv =3D hw->priv;
 	struct device *dev =3D &priv->udev->dev;
-	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info;
+	struct rtl8xxxu_ra_info *ra =3D &priv->ra_info[macid];
 	u8 *qc =3D ieee80211_get_qos_ctl(hdr);
 	u8 tid =3D qc[0] & IEEE80211_QOS_CTL_TID_MASK;
 	u32 rate =3D 0;
@@ -7895,6 +7903,7 @@ static int rtl8xxxu_probe(struct usb_interface *inte=
rface,
 err_set_intfdata:
 	usb_set_intfdata(interface, NULL);
=20
+	kfree(priv->ra_info);
 	kfree(priv->fw_data);
 	mutex_destroy(&priv->usb_buf_mutex);
 	mutex_destroy(&priv->syson_indirect_access_mutex);
@@ -7924,7 +7933,7 @@ static void rtl8xxxu_disconnect(struct usb_interface=
 *interface)
 	usb_set_intfdata(interface, NULL);
=20
 	dev_info(&priv->udev->dev, "disconnecting\n");
-
+	kfree(priv->ra_info);
 	kfree(priv->fw_data);
 	mutex_destroy(&priv->usb_buf_mutex);
 	mutex_destroy(&priv->syson_indirect_access_mutex);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/ne=
t/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 4a744b5c1aec..9ce820ff4793 100644
=2D-- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -76,6 +76,7 @@
 #define RTL_FW_PAGE_SIZE		4096
 #define RTL8XXXU_FIRMWARE_POLL_MAX	1000
=20
+#define RTL8188E_MAX_MAC_ID_NUM		16
 #define RTL8723A_CHANNEL_GROUPS		3
 #define RTL8723A_MAX_RF_PATHS		2
 #define RTL8723B_CHANNEL_GROUPS		6
@@ -1915,7 +1916,7 @@ struct rtl8xxxu_priv {
 	struct rtl8xxxu_btcoex bt_coex;
 	struct rtl8xxxu_ra_report ra_report;
 	struct rtl8xxxu_cfo_tracking cfo_tracking;
-	struct rtl8xxxu_ra_info ra_info;
+	struct rtl8xxxu_ra_info *ra_info;
 	u8 dynamic_tx_rpt_timing_counter; // 8188e specific
=20
 	bool led_registered;
=2D-=20
2.53.0


