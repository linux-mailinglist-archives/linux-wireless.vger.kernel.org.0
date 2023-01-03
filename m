Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D270965C008
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 13:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbjACMl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 07:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbjACMl0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 07:41:26 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAE6DF68
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 04:41:25 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a16so24395607qtw.10
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jan 2023 04:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr1P2m3QGY64uK4Hr8KjO71zO/BKXEV5BxS5c+e6GrE=;
        b=IJKFCQKWuRh4cVITb7XZKAJ3pacTGWtZL9pMd5aH7ADayKHEa6gqUAu0QIZXS1GeYC
         1eR3NJXU82UzIk8M8y00Akkx5uCAjknMiO8iqVs09bMUvQ6imRCle+GJxscpopfYFaMd
         5XjhPiOXLpzooTTE5EOKKberZVNEm5G8PPn9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr1P2m3QGY64uK4Hr8KjO71zO/BKXEV5BxS5c+e6GrE=;
        b=lC28BsZB7OBDDHKYLCLDbpLZuQKq4ll3HaOK4rmqYtV7y3hymAOANVmsQ0bbEisG7y
         8XuAYjWH89ln/J3s2xvD0nF4AIKGNsHQubbuaA/Nf8JIrCAI63RO6270KG9Ya6IJ4gSl
         kAG8Q5Dk4RWQvgIP4HfAjkU5n45sEIXJCNB7cYJ1PegMBDX/mAVlpQGslXRMnD/r9ofZ
         Sgp+Vle2N1Eb+YsO3wRwdODZXnOqCB3Z7I/Rjk4PC86tZub60LXqe9Qe02eRZbfPOz9t
         GLmyvBNl9APD6Y+yJj3Ul4jjHcbL9W4FtJdkvSKMbFM+lc9GtDgnwP8WLwmasahjTFyI
         tQIw==
X-Gm-Message-State: AFqh2kpqR2Nc7B8e/8CUy+U84uZnDtZxO3TyNmTwFK8AqW6UVJhCCCJP
        t2q2POgPUvghMa9FIdtZGuXi+VEv98JqM3tb
X-Google-Smtp-Source: AMrXdXs1nsFS7f6TOeJBpqIR6MEXHSEJs/nzmAQdHiYTVZ+Q4hS1leuTqXP/JG7QrOUGbUyE4Lb+YA==
X-Received: by 2002:a05:622a:230e:b0:3a4:e849:a235 with SMTP id ck14-20020a05622a230e00b003a4e849a235mr66067756qtb.34.1672749684884;
        Tue, 03 Jan 2023 04:41:24 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.com ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id t1-20020ac865c1000000b003a7e4129f83sm18439047qto.85.2023.01.03.04.41.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 04:41:24 -0800 (PST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH for-6.2 1/3] wifi: brcmfmac: avoid handling disabled channels for survey dump
Date:   Tue,  3 Jan 2023 13:41:15 +0100
Message-Id: <20230103124117.271988-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230103124117.271988-1-arend.vanspriel@broadcom.com>
References: <20230103124117.271988-1-arend.vanspriel@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c8a1af05f15b6236"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000c8a1af05f15b6236
Content-Transfer-Encoding: 8bit

An issue was reported in which periodically error messages are
printed in the kernel log:

[   26.303445] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
[   26.303554] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin failed with error -2
[   26.516752] brcmfmac_wcc: brcmf_wcc_attach: executing
[   26.528264] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Jan  4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d2e
[   27.076829] Bluetooth: hci0: BCM: features 0x2f
[   27.078592] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
[   27.078601] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342
[   30.142104] Adding 102396k swap on /var/swap.  Priority:-2 extents:1 across:102396k SS
[   30.590017] Bluetooth: MGMT ver 1.22
[  104.897615] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail, reason -52
[  104.897992] brcmfmac: cfg80211_set_channel: set chanspec 0xd022 fail, reason -52
[  105.007672] brcmfmac: cfg80211_set_channel: set chanspec 0xd026 fail, reason -52
[  105.117654] brcmfmac: cfg80211_set_channel: set chanspec 0xd02a fail, reason -52
[  105.227636] brcmfmac: cfg80211_set_channel: set chanspec 0xd02e fail, reason -52
[  106.987552] brcmfmac: cfg80211_set_channel: set chanspec 0xd090 fail, reason -52
[  106.987911] brcmfmac: cfg80211_set_channel: set chanspec 0xd095 fail, reason -52
[  106.988233] brcmfmac: cfg80211_set_channel: set chanspec 0xd099 fail, reason -52
[  106.988565] brcmfmac: cfg80211_set_channel: set chanspec 0xd09d fail, reason -52
[  106.988909] brcmfmac: cfg80211_set_channel: set chanspec 0xd0a1 fail, reason -52

This happens in brcmf_cfg80211_dump_survey() because we try a disabled
channel. When channel is marked as disabled we do not need to fill any
other info so bail out.

Fixes: 6c04deae1438 ("brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection")
Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c       | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index bff3128c2f26..478ca3848c64 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7937,6 +7937,9 @@ cfg80211_set_channel(struct wiphy *wiphy, struct net_device *dev,
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
 
+	if (chan->flags & IEEE80211_CHAN_DISABLED)
+		return -EINVAL;
+
 	/* set_channel */
 	chspec = channel_to_chanspec(&cfg->d11inf, chan);
 	if (chspec != INVCHANSPEC) {
@@ -7961,7 +7964,6 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 	struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
 	struct brcmf_dump_survey survey = {};
 	struct ieee80211_supported_band *band;
-	struct ieee80211_channel *chan;
 	struct cca_msrmnt_query req;
 	u32 noise;
 	int err;
@@ -7987,13 +7989,10 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 	}
 
 	/* Setting current channel to the requested channel */
-	chan = &band->channels[idx];
-	err = cfg80211_set_channel(wiphy, ndev, chan, NL80211_CHAN_HT20);
-	if (err) {
-		info->channel = chan;
-		info->filled = 0;
+	info->filled = 0;
+	info->channel = &band->channels[idx];
+	if (cfg80211_set_channel(wiphy, ndev, info->channel, NL80211_CHAN_HT20))
 		return 0;
-	}
 
 	/* Disable mpc */
 	brcmf_set_mpc(ifp, 0);
@@ -8028,7 +8027,6 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 	if (err)
 		goto exit;
 
-	info->channel = chan;
 	info->noise = noise;
 	info->time = ACS_MSRMNT_DELAY;
 	info->time_busy = ACS_MSRMNT_DELAY - survey.idle;
@@ -8040,7 +8038,7 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 		SURVEY_INFO_TIME_TX;
 
 	brcmf_dbg(INFO, "OBSS dump: channel %d: survey duration %d\n",
-		  ieee80211_frequency_to_channel(chan->center_freq),
+		  ieee80211_frequency_to_channel(info->channel->center_freq),
 		  ACS_MSRMNT_DELAY);
 	brcmf_dbg(INFO, "noise(%d) busy(%llu) rx(%llu) tx(%llu)\n",
 		  info->noise, info->time_busy, info->time_rx, info->time_tx);
-- 
2.32.0


--000000000000c8a1af05f15b6236
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAnryhDfDgtKDMTZ3BZ
+Sv2JorM53BXaMD/KZYKWYUQRjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzAxMDMxMjQxMjVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAAsgqBsfh9kggRIwO/QXnTMtOoqzHZsqiAkR6
6IZwCOTsr7O8Ham/XTVoYZNSU/e2J1Q8O36VPretAYz1/3UqQB6+uHn0VvhP06WsdlVJPsiweNPe
OBaBM/S7t0YPvAKMQskJyWrC0nH9FE7H7iE0ESyHojSHz1WsNPGjEH8vi4FHt1VqbDWVlYesAqI+
9B0ke2yNAHl0zteOX95+HWergRiV1AheYvWjLk+pzVcUH1lZMQ1btqEY/HU/Xc9b9Kp3Vekh4wBN
JzSeU9CqySkhKF/CNji37XNtTx6EZAgVuzYbkuG7ofgfWrUH10NvvMquMKd/xdKkLcP2sc3R+dz9
ZA==
--000000000000c8a1af05f15b6236--
