Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D239B32EA38
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Mar 2021 13:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhCEMhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Mar 2021 07:37:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232388AbhCEMgt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Mar 2021 07:36:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34BB765004;
        Fri,  5 Mar 2021 12:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614947809;
        bh=tcCyjIUcckIclrRP9TFqBQeoTp9aM9UO7ALFlvgz4/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bg2VIOZuhZimFJzO+I9JijUxiT5CiozEbuZ7V+sBxwehItEyWJGjArYmmdDSDA5pw
         H4b6MpAruUI8f+I4furg48v9UAV2lpiipiQFSZ/r6QzUB5D7eLRBLCZ5NHlLgl7T7d
         nwbrHe+sGp3BfSxUygLAHQsdAsNvRil1FjJEFzak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Angus Ainslie <angus@akkea.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Kepplinger <martink@posteo.de>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Siva Rebbagondla <siva8118@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 19/52] rsi: Fix TX EAPOL packet handling against iwlwifi AP
Date:   Fri,  5 Mar 2021 13:21:50 +0100
Message-Id: <20210305120854.617629304@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305120853.659441428@linuxfoundation.org>
References: <20210305120853.659441428@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit 65277100caa2f2c62b6f3c4648b90d6f0435f3bc ]

In case RSI9116 SDIO WiFi operates in STA mode against Intel 9260 in AP mode,
the association fails. The former is using wpa_supplicant during association,
the later is set up using hostapd:

iwl$ cat hostapd.conf
interface=wlp1s0
ssid=test
country_code=DE
hw_mode=g
channel=1
wpa=2
wpa_passphrase=test
wpa_key_mgmt=WPA-PSK
iwl$ hostapd -d hostapd.conf

rsi$ wpa_supplicant -i wlan0 -c <(wpa_passphrase test test)

The problem is that the TX EAPOL data descriptor RSI_DESC_REQUIRE_CFM_TO_HOST
flag and extended descriptor EAPOL4_CONFIRM frame type are not set in case the
AP is iwlwifi, because in that case the TX EAPOL packet is 2 bytes shorter.

The downstream vendor driver has this change in place already [1], however
there is no explanation for it, neither is there any commit history from which
such explanation could be obtained.

[1] https://github.com/SiliconLabs/RS911X-nLink-OSD/blob/master/rsi/rsi_91x_hal.c#L238

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Angus Ainslie <angus@akkea.ca>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Martin Kepplinger <martink@posteo.de>
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20201015111616.429220-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/rsi/rsi_91x_hal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index a7b341e95e76..0da95777f1c1 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -238,7 +238,8 @@ int rsi_prepare_data_desc(struct rsi_common *common, struct sk_buff *skb)
 			rsi_set_len_qno(&data_desc->len_qno,
 					(skb->len - FRAME_DESC_SZ),
 					RSI_WIFI_MGMT_Q);
-		if ((skb->len - header_size) == EAPOL4_PACKET_LEN) {
+		if (((skb->len - header_size) == EAPOL4_PACKET_LEN) ||
+		    ((skb->len - header_size) == EAPOL4_PACKET_LEN - 2)) {
 			data_desc->misc_flags |=
 				RSI_DESC_REQUIRE_CFM_TO_HOST;
 			xtend_desc->confirm_frame_type = EAPOL4_CONFIRM;
-- 
2.30.1



