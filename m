Return-Path: <linux-wireless+bounces-8964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F91906513
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 09:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92F81F21CBE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466FA13A879;
	Thu, 13 Jun 2024 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vandijck-laurijssen.be header.i=@vandijck-laurijssen.be header.b="fbn/6sR4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay-b02.edpnet.be (relay-b02.edpnet.be [212.71.1.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A0B6A032
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263805; cv=none; b=J98l5QOnF5NEIi5Of0H1uTBM9w8PRj22Ex2iFv94pZc/QWqq5yrKquegM7M/2ubDr/E23AQx+oeDhlK9HIXlS3YD3sYin6NepEtS+IWBTVZp9OPZH5w4U+e4OHblk0A9EnmoPtbpL2hm+c+b/L28fpsf5e7JJ8wkW1e5DNwdyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263805; c=relaxed/simple;
	bh=SPRPoddjqTPalLoMVX7A4nBnMBIVGgIfz477iExiHNM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NyfgmTPjh7MwA45kX4Umrofzj8bPaiXJEgbozS3klCGTglmRuSJNgy9ghCmFR2vdOhxH1+yX4TstFsrY62H9Y+TeGPM1isUcQ0HLYK8X0VFahkvumX+FfUrr9hYqTf4P97sSDZOOQ64NUnhZB4KHXZYzz5kFnfVQJqAEdLv6YBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vandijck-laurijssen.be; spf=pass smtp.mailfrom=vandijck-laurijssen.be; dkim=pass (2048-bit key) header.d=vandijck-laurijssen.be header.i=@vandijck-laurijssen.be header.b=fbn/6sR4; arc=none smtp.client-ip=212.71.1.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vandijck-laurijssen.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vandijck-laurijssen.be
X-ASG-Debug-ID: 1718263791-214fdf170f409d3a0001-9xRsGE
Received: from srv21.vandijck-laurijssen.be (77.109.96.193.adsl.dyn.edpnet.net [77.109.96.193]) by relay-b02.edpnet.be with ESMTP id fZM1hxHS3ZoNPKFn; Thu, 13 Jun 2024 09:29:51 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.96.193.adsl.dyn.edpnet.net[77.109.96.193]
X-Barracuda-Apparent-Source-IP: 77.109.96.193
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
	by srv21.vandijck-laurijssen.be (Postfix) with ESMTPSA id 3267E5A3A71;
	Thu, 13 Jun 2024 09:29:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=vandijck-laurijssen.be; s=default; t=1718263791;
	bh=SPRPoddjqTPalLoMVX7A4nBnMBIVGgIfz477iExiHNM=;
	h=Date:From:To:Subject:From;
	b=fbn/6sR4oCt5MHZXgEwtFvyBuaaz+kMPa3gGTLMuKDzEfwBxTQJmSdL8JIJbYvg6u
	 ptLho49fJnoxh694fQ64LmRJojrgGJbXB50NNoHRPTbDLsRIXUwBEIvakAnlfofARy
	 gn/7RcmMlRLJlkqPHgw8tfDm8NsvW2++MRThuRKTinYx9aDPGmxwF2XqY4MShF6Rjl
	 5V41Oms/YSOCfmbX3fqJvsCEOQmXkLCWwy2IsxcxMr3cFjSI/aC4DEGd3HXkZqz2bs
	 ayk7V1FLwPMk24b5WJlg4wfPxclxIX1VUJqwPabhPuJZUh7XnUgIBpXQN6lxl64EkR
	 9NYvl/rNVTuhA==
Date: Thu, 13 Jun 2024 09:29:50 +0200
From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
Subject: brcmfmac: implement basic AP-follow-STA
Message-ID: <Zmqf7jCqwlQNGM_j@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: brcmfmac: implement basic AP-follow-STA
Mail-Followup-To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Barracuda-Connect: 77.109.96.193.adsl.dyn.edpnet.net[77.109.96.193]
X-Barracuda-Start-Time: 1718263791
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 8038
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.126180
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_RULE7568M          Custom Rule 7568M

Hi,

/* context */
We (Yamabiko) have an application where we migrated to a bcm4339 sdio wifi chip.
We use it in AP+STA mode: when the chip is detected (wlan+ add uevent),
we call 'run iw dev wlan0 interface add wap0 type __ap' and start
wpa_supplicant on wlan0 and hostapd on wap0.
The STA is more important than the AP.
We have 'roamoff' parameter set. We observed problems with the firmware roaming
before and switched to wpa_supplicant roaming.

We run a linux v5.4.24 derivative.

/* problem */
We observed that the chip is able to switch channel for wpa_supplicant to
connect to a different channel, but it soon looses connection because hostapd
does not change channel too.

This did work with our previous wifi chip (realtek 88x2 something), which notifies
hostapd that it switched.

/* patch description */
I went down and ended up modifying the brcmfmac driver, patch appended below.
For contributing on these mailing lists, I ported it to yesterday's master.
The idea is that whenever a STA issues a connect with channel info, the AP's
will switch to it too. This implies a small glitch in the AP radio, which already
occurred before my patch. it seems that the wifi chip cannot modify radio settings
per virtual interface, although the API to the wifi chip suggests it can (that is
most probable a more generic communication used for other chips that can do this).
The channel switch is also reported to userspace.

To be less invasive, this new behaviour is put behind
a module parameter 'ap_follow_sta'.

/* questions */
1. do you consider this new behaviour an improvement to include in mainline kernel?
2. if not, I still want to ask for a quick review of my implementation,
   for major mistakes. We at Yamabiko have other expertise than wifi.
3. In order to switch channel, I need to provide a frequency and a bandwidth.
   I found it hard to discover if the wifi chip supports different bandwidths
   per virtual interface. Nor did I really discover where in the driver I could
   retrieve the currently used bandwidth. So I hardcoded 20MHz bandwidth
   in brcmf_cfg80211_connect() to use for my new brcmf_ap_follow_sta().
   Any suggestion how I could improve that?

Kind regards,
Kurt Van Dijck

commit df8e547cc1ae24e2a780aec548098fa25d24dbdc
Author: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Date:   Tue Jun 11 15:46:53 2024

    brcmfmac: implement basic AP-follow-STA
    
    By experience, a bcm4339 maintains differenct channel parameters per vif,
    while it can only handle 1 channel at a time.
    This commit adds a module parameter, ap_follow_sta, that when enabled,
    will switch active AP's to the new channel when a STAtion connects
    and provides channel information.
    
    I use the chip with roamoff=1 set.
    In my setup, using 1 AP and 1 STA on the wireless device,
    the STA constantly looses connection to it AP, unless the AP is manually
    configured to use the same channel.
    With this patch and module parameter activated, the AP switches automatically.
    
    Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5fe0e671ecb36..c0d7f11cdb9a8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -895,6 +895,79 @@ static bool brcmf_is_ibssmode(struct brcmf_cfg80211_vif *vif)
 	return vif->wdev.iftype == NL80211_IFTYPE_ADHOC;
 }
 
+/* by experience, bcm4339 keeps a channel per VIF, but it can only track 1 channel
+ * If a station connects, try to move the AP's to the same channel
+ * We could also modify the AP channel when AP starts, but that does
+ * not avoid station disconnect, nor speed things up, so leave it like that
+ */
+static inline int brcmf_switch_channel(struct brcmf_if *ifp, u16 chanspec,
+		struct cfg80211_chan_def *chandef)
+{
+	int err, err2;
+
+	/* notify intent to userspace */
+	cfg80211_ch_switch_started_notify(ifp->ndev, chandef, 0);
+
+	/* Firmware 10.x requires setting channel after enabling
+	 * AP and before bringing interface up.
+	 */
+	err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_DOWN, 1);
+	if (err < 0) {
+		bphy_err(ifp->drvr, "BRCMF_C_DOWN 1 error (%d)\n", err);
+		return err;
+	}
+	err = brcmf_fil_iovar_int_set(ifp, "chanspec", chanspec);
+	if (err < 0)
+		bphy_err(ifp->drvr, "Set Channel failed: chspec=%d, %d\n",
+				chanspec, err);
+	/* still proceed and bring iface up */
+	err2 = brcmf_fil_cmd_int_set(ifp, BRCMF_C_UP, 1);
+	if (err2 < 0)
+		bphy_err(ifp->drvr, "BRCMF_C_UP 1 error (%d)\n", err2);
+
+	if (!err)
+		/* notify userspace */
+		cfg80211_ch_switch_notify(ifp->ndev, chandef);
+	return err;
+}
+
+static int brcmf_ap_follow_sta(struct brcmf_if *ifp,
+		struct cfg80211_chan_def *chandef)
+{
+	struct brcmf_pub *drvr = ifp->drvr;
+	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(drvr->wiphy);
+	u16 chanspec = chandef_to_chanspec(&cfg->d11inf, chandef);
+	struct brcmf_if *lifp;
+	int j;
+	int channel;
+	int ochannel;
+	int err = 0, err2;
+
+	channel = ieee80211_frequency_to_channel(chandef->center_freq1);
+	for (j = 0; j < ARRAY_SIZE(drvr->iflist); ++j) {
+		lifp = drvr->iflist[j];
+		if (!lifp || lifp == ifp)
+			continue;
+
+		if (!test_bit(BRCMF_VIF_STATUS_AP_CREATED,
+					&lifp->vif->sme_state))
+			/* no AP yet */
+			continue;
+		/* find old channel for this VIF */
+		ochannel = ieee80211_frequency_to_channel(
+				lifp->vif->wdev.chandef.center_freq1);
+		if (ochannel != channel) {
+			bphy_err(drvr, "%s ch %i..%i", netdev_name(lifp->ndev),
+					ochannel, channel);
+			/* notify intent to userspace */
+			err2 = brcmf_switch_channel(lifp, chanspec, chandef);
+			if (err2 && !err)
+				err = err2;
+		}
+	}
+	return err;
+}
+
 /**
  * brcmf_mon_add_vif() - create monitor mode virtual interface
  *
@@ -2551,6 +2624,13 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
 		ext_join_params->scan_le.passive_time = cpu_to_le32(-1);
 		ext_join_params->scan_le.nprobes = cpu_to_le32(-1);
 	}
+	if (sme->channel && brcmf_want_ap_follow_sta) {
+		struct cfg80211_chan_def chandef = {};
+
+		cfg80211_chandef_create(&chandef, sme->channel,
+				NL80211_CHAN_NO_HT /*?*/);
+		brcmf_ap_follow_sta(ifp, &chandef);
+	}
 
 	brcmf_set_join_pref(ifp, &sme->bss_select);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873d..d0c0b23a95c46 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -63,6 +63,10 @@ static int brcmf_roamoff;
 module_param_named(roamoff, brcmf_roamoff, int, 0400);
 MODULE_PARM_DESC(roamoff, "Do not use internal roaming engine");
 
+int brcmf_want_ap_follow_sta;
+module_param_named(ap_follow_sta, brcmf_want_ap_follow_sta, int, 0600);
+MODULE_PARM_DESC(ap_follow_sta, "AP follows STA channel in AP+STA mode");
+
 static int brcmf_iapp_enable;
 module_param_named(iapp, brcmf_iapp_enable, int, 0);
 MODULE_PARM_DESC(iapp, "Enable partial support for the obsoleted Inter-Access Point Protocol");
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
index 2be2986d2110a..287c055c4ec84 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
@@ -61,6 +61,11 @@ struct brcmf_mp_device {
 	} bus;
 };
 
+/* ad-hoc module parameter
+ * it affects runtime behaviour, and may safely changed after init
+ */
+extern int brcmf_want_ap_follow_sta;
+
 void brcmf_c_set_joinpref_default(struct brcmf_if *ifp);
 
 struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,

