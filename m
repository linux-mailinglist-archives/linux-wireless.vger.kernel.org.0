Return-Path: <linux-wireless+bounces-37982-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 90TyHr9qOWohsQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37982-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 19:02:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 850DA6B15C2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 19:02:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=e6Grv25N;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37982-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37982-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B64053001CCA
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859F733BBD7;
	Mon, 22 Jun 2026 17:02:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25C3264F7
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 17:02:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147770; cv=none; b=QI6V6kMW8mnx5/K0UJcwYUSIUKOMljsPONmglgVeitHar4P9gTqxhXRbaeBUAxrkze0JC1eYMOLA/ZqvEQngFJDrQL9VBKDLOn21uYT6zaSqQJp3Js3YOZmrhMzvufXIQe4XnWYeHQPP+zM0HUZS74ROAXZ81EjZOZEO9MeDvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147770; c=relaxed/simple;
	bh=EZHkD4mdQnlwKm+86bxx72+51dBeJH5hXKgGGYN1yhY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YAL9NatN8+mvcf3Nlt7f9Gv1RUKopj+kTMuRVR0AjWdel+1wo4uo7gYbmtuExk7Uj2NzQ4mEVxihPxsEL/j+126u9vUy0awQ2o937vvYxyN9YKDytWZ0xrzFcQxCg/zygSqj6Zagszps1KgNMLki+ioxx9XfElEZ9mZZBHpY7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6Grv25N; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4624a44e152so3925170f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782147767; x=1782752567; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aI0ewwHvyMrkvcK8KJfglo+UjCMlya7TzXl0PFS/u7A=;
        b=e6Grv25NW8uE7CgyiEt3MF2NNunpO7oV9uiUCVbyTDO1hQBQaDg0Fh7uYvObrYxNta
         4mJH+PgUtkBF6QnNZxkvWI0WiovRr67h6IdWU22u2WCidddetmbkteiZUtIOmrcy0Y1d
         lgoWq9w92X62gekfxgQ7Jsnk6KgPzq6HfG6qtkdTQ1KjQpaC4P2TuqSv/mgOD2g5vWA2
         B1PVWoi4gCaKMxCF6B8dFA0rHwe/K+gKIwa1eTeuQcjCn7oApLSsbKJz0s4mIjXPN0MK
         MjZnNebmpo+TFcABeNL9+3ZMcdumGZM5kVaso+wI1lyY3Axs4RULY5TAq1ATjZsXHSLm
         o7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782147767; x=1782752567;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aI0ewwHvyMrkvcK8KJfglo+UjCMlya7TzXl0PFS/u7A=;
        b=BOzWJ7qHTqsz9PdpRMxwlHVKXR3aGpzID8uwCjpOSokycdrkzYjAjeckm8td65h4vB
         fJ9El3orJkAiwIfZuNsJ4ht/ZTU7wBK8Qgh2q34u/zZtvrXH4jC/MZjL+qv9AUxq6DMx
         7gHtsvfcyf08Z04qhIQHJAYPfG09cIa8HLkZWToCLSU9V/MYv0CzVNQihN7Y/DIrbbPB
         BqDgMCuJcbEfmn0yLb0gt5qQJjycEl/pD6I5PI8/LD85RdviJlbDkQSUu715tRx320IY
         N5zFwLx6bsMpRJkAoH49WTJT+5y/iOXeYkBHL2DmH61wdKUVn9PN7GOS346/tm87KTp0
         F7jA==
X-Gm-Message-State: AOJu0YwjEOYAKfbtYdgyhwAc3C5unKIAwXWxQFo4QXrUj8ip6oyF3Vim
	rBiQ6GoRBNVS3qUpBFbK3mGyIiWGjoTxLuiN6x3vgXfmeLNlPOR4on2p9UCSAg==
X-Gm-Gg: AfdE7cnYzn6b8k573i2txkcyCYWpvWoWb6uN7Nis8y+tODfVBZZkXzs00b2b9mEOq+a
	LZp0qVOll6bKu+Etl5WscIhlsIOpT9OVy8cCuox9023KZ6/0+XoauNT+hXFLjJHq7fkT7BxxUj1
	BbvueEWjkzqWWS1bOWDI0p1eYtbilhInUJySUShP5psmhTBmB4P56bOzd3Re8yIQZBgHYERMlZ0
	6Qu1ggvt5EbmXMoKjR3CZa4kPaKAFBqD0pWdNdy94mNgq6cmZqZP+h5QA8JnuKTOHwISE93B2O6
	jbT0MFta8A+jMVWX0gsWtm3/zwiFpzItnl7NrLEpKaDunlmiTKiJ/X+UcsZx/WV0iMLdPz7Itwu
	CVqvL78arDl3/OFuu9AigMf3ZeRMfNh/8jzJuUdxNW7iIwZ/P0b2VkfHVgY4/dEzx7rWntHHpwX
	7WNb0ZRhmNLCCrp7CYvvs=
X-Received: by 2002:a05:600c:1550:b0:490:e913:656a with SMTP id 5b1f17b1804b1-49240e6c72dmr247675195e9.27.1782147766615;
        Mon, 22 Jun 2026 10:02:46 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249238bfbsm240050385e9.5.2026.06.22.10.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 10:02:46 -0700 (PDT)
Message-ID: <2a52d718-9e46-47f2-84a1-d8e7b1ed89a8@gmail.com>
Date: Mon, 22 Jun 2026 20:02:44 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 =?UTF-8?Q?Georg_Bi=C3=9Feling?= <georg.bisseling@sea-gmbh.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: Enable receiving control frames in
 monitor mode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37982-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,m:georg.bisseling@sea-gmbh.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 850DA6B15C2

From: Bitterblue Smith (S.E.A. Datentechnik GmbH) <rtl8821cerfe2@gmail.com>

By default RTL8723D, RTL8703B, RTL8812A, RTL8821A, and RTL8814A are
configured to filter out all control frames except PS-Poll, even in
monitor mode.

Handle FIF_CONTROL in rtw_ops_configure_filter(). When it's set,
configure REG_RXFLTMAP1 to let all control frames through. When it's
unset, restore the original value. Because some drivers configure
REG_RXFLTMAP1 differently, keep track of its value in a new member of
struct rtw_hal.

Signed-off-by: Bitterblue Smith (S.E.A. Datentechnik GmbH) <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/bf.c       | 6 ++++--
 drivers/net/wireless/realtek/rtw88/mac80211.c | 8 +++++++-
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8723x.c | 3 ++-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c | 3 ++-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 4 +++-
 drivers/net/wireless/realtek/rtw88/rtw8821c.h | 3 ++-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 7 +++++--
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 7 +++++--
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c | 3 ++-
 10 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/bf.c b/drivers/net/wireless/realtek/rtw88/bf.c
index 0d0ccbc7d00c..7313ecc5c82a 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.c
+++ b/drivers/net/wireless/realtek/rtw88/bf.c
@@ -137,7 +137,8 @@ void rtw_bf_cfg_sounding(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 	rtw_write8_mask(rtwdev, REG_SND_PTCL_CTRL, BIT_MASK_BEAMFORM,
 			RTW_SND_CTRL_SOUNDING);
 	rtw_write8(rtwdev, REG_SND_PTCL_CTRL + 3, 0x26);
-	rtw_write8_clr(rtwdev, REG_RXFLTMAP1, BIT_RXFLTMAP1_BF_REPORT_POLL);
+	rtwdev->hal.rxfltmap1 &= ~BIT_RXFLTMAP1_BF_REPORT_POLL;
+	rtw_write16(rtwdev, REG_RXFLTMAP1, rtwdev->hal.rxfltmap1);
 	rtw_write8_clr(rtwdev, REG_RXFLTMAP4, BIT_RXFLTMAP4_BF_REPORT_POLL);
 
 	if (vif->net_type == RTW_NET_AP_MODE)
@@ -269,7 +270,8 @@ void rtw_bf_enable_bfee_mu(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 	rtw_write16_set(rtwdev, REG_RXFLTMAP0, BIT_RXFLTMAP0_ACTIONNOACK);
 
 	/* accept NDPA and BF report poll */
-	rtw_write16_set(rtwdev, REG_RXFLTMAP1, BIT_RXFLTMAP1_BF);
+	rtwdev->hal.rxfltmap1 |= BIT_RXFLTMAP1_BF;
+	rtw_write16(rtwdev, REG_RXFLTMAP1, rtwdev->hal.rxfltmap1);
 }
 EXPORT_SYMBOL(rtw_bf_enable_bfee_mu);
 
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 766f22d31079..b01b98d24b0a 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -281,12 +281,18 @@ static void rtw_ops_configure_filter(struct ieee80211_hw *hw,
 	struct rtw_dev *rtwdev = hw->priv;
 
 	*new_flags &= FIF_ALLMULTI | FIF_OTHER_BSS | FIF_FCSFAIL |
-		      FIF_BCN_PRBRESP_PROMISC;
+		      FIF_BCN_PRBRESP_PROMISC | FIF_CONTROL;
 
 	mutex_lock(&rtwdev->mutex);
 
 	rtw_leave_lps_deep(rtwdev);
 
+	if (changed_flags & FIF_CONTROL) {
+		if (*new_flags & FIF_CONTROL)
+			rtw_write16(rtwdev, REG_RXFLTMAP1, 0xffff);
+		else
+			rtw_write16(rtwdev, REG_RXFLTMAP1, rtwdev->hal.rxfltmap1);
+	}
 	if (changed_flags & FIF_ALLMULTI) {
 		if (*new_flags & FIF_ALLMULTI)
 			rtwdev->hal.rcr |= BIT_AM;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9c0b746540b0..c6e981ba7986 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1963,6 +1963,7 @@ struct rtw_sar {
 
 struct rtw_hal {
 	u32 rcr;
+	u16 rxfltmap1;
 
 	u32 chip_version;
 	u8 cut_version;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
index 3f3e9b0c44e8..97e6f6a62c0d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
@@ -356,7 +356,8 @@ static int __rtw8723x_mac_init(struct rtw_dev *rtwdev)
 	rtw_write32(rtwdev, REG_TCR, BIT_TCR_CFG);
 
 	rtw_write16(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
-	rtw_write16(rtwdev, REG_RXFLTMAP1, WLAN_RX_FILTER1);
+	rtwdev->hal.rxfltmap1 = WLAN_RX_FILTER1;
+	rtw_write16(rtwdev, REG_RXFLTMAP1, rtwdev->hal.rxfltmap1);
 	rtw_write16(rtwdev, REG_RXFLTMAP2, WLAN_RX_FILTER2);
 	rtw_write32(rtwdev, REG_RCR, WLAN_RCR_CFG);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814a.c b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
index ca1079e12023..fa02aa299b5e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8814a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
@@ -400,7 +400,8 @@ static int rtw8814a_mac_init(struct rtw_dev *rtwdev)
 	rtw_write16(rtwdev, REG_RETRY_LIMIT, 0x3030);
 
 	rtw_write16(rtwdev, REG_RXFLTMAP0, 0xffff);
-	rtw_write16(rtwdev, REG_RXFLTMAP1, 0x0400);
+	rtwdev->hal.rxfltmap1 = 0x0400;
+	rtw_write16(rtwdev, REG_RXFLTMAP1, rtwdev->hal.rxfltmap1);
 	rtw_write16(rtwdev, REG_RXFLTMAP2, 0xffff);
 
 	rtw_write8(rtwdev, REG_MAX_AGGR_NUM, 0x36);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 246046da4f13..ee689fa3d87f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -248,7 +248,9 @@ static int rtw8821c_mac_init(struct rtw_dev *rtwdev)
 	rtw_write8_clr(rtwdev, REG_TX_PTCL_CTRL + 1, BIT_SIFS_BK_EN >> 8);
 
 	/* WMAC configuration */
-	rtw_write32(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
+	rtw_write16(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
+	rtwdev->hal.rxfltmap1 = WLAN_RX_FILTER1;
+	rtw_write16(rtwdev, REG_RXFLTMAP1, rtwdev->hal.rxfltmap1);
 	rtw_write16(rtwdev, REG_RXFLTMAP2, WLAN_RX_FILTER2);
 	rtw_write32(rtwdev, REG_RCR, WLAN_RCR_CFG);
 	rtw_write8(rtwdev, REG_RX_PKT_LIMIT, WLAN_RXPKT_MAX_SZ_512);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index 954e93c8020d..ea85b7e73050 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -139,7 +139,8 @@ extern const struct rtw_chip_info rtw8821c_hw_spec;
 #define WLAN_DRV_EARLY_INT	0x04
 #define WLAN_BCN_DMA_TIME	0x02
 
-#define WLAN_RX_FILTER0		0x0FFFFFFF
+#define WLAN_RX_FILTER0		0xFFFF
+#define WLAN_RX_FILTER1		0x0FFF
 #define WLAN_RX_FILTER2		0xFFFF
 #define WLAN_RCR_CFG		0xE400220E
 #define WLAN_RXPKT_MAX_SZ	12288
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 37b7a520fea0..a56c8befa077 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -202,7 +202,8 @@ static void rtw8822b_phy_set_param(struct rtw_dev *rtwdev)
 #define WLAN_DRV_EARLY_INT	0x04
 #define WLAN_BCN_DMA_TIME	0x02
 
-#define WLAN_RX_FILTER0		0x0FFFFFFF
+#define WLAN_RX_FILTER0		0xFFFF
+#define WLAN_RX_FILTER1		0x0FFF
 #define WLAN_RX_FILTER2		0xFFFF
 #define WLAN_RCR_CFG		0xE400220E
 #define WLAN_RXPKT_MAX_SZ	12288
@@ -273,7 +274,9 @@ static int rtw8822b_mac_init(struct rtw_dev *rtwdev)
 	rtw_write8(rtwdev, REG_BCNDMATIM, WLAN_BCN_DMA_TIME);
 	rtw_write8_clr(rtwdev, REG_TX_PTCL_CTRL + 1, BIT_SIFS_BK_EN >> 8);
 	/* WMAC configuration */
-	rtw_write32(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
+	rtw_write16(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
+	rtwdev->hal.rxfltmap1 = WLAN_RX_FILTER1;
+	rtw_write16(rtwdev, REG_RXFLTMAP1, rtwdev->hal.rxfltmap1);
 	rtw_write16(rtwdev, REG_RXFLTMAP2, WLAN_RX_FILTER2);
 	rtw_write32(rtwdev, REG_RCR, WLAN_RCR_CFG);
 	rtw_write8(rtwdev, REG_RX_PKT_LIMIT, WLAN_RXPKT_MAX_SZ_512);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 80c9f0c11e5c..64ba5dbfe2bd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1942,7 +1942,8 @@ static void rtw8822c_phy_set_param(struct rtw_dev *rtwdev)
 #define WLAN_EDCA_BE_PARAM	0x005EA42B
 #define WLAN_EDCA_BK_PARAM	0x0000A44F
 
-#define WLAN_RX_FILTER0		0xFFFFFFFF
+#define WLAN_RX_FILTER0		0xFFFF
+#define WLAN_RX_FILTER1		0xFFFF
 #define WLAN_RX_FILTER2		0xFFFF
 #define WLAN_RCR_CFG		0xE400220E
 #define WLAN_RXPKT_MAX_SZ	12288
@@ -2093,7 +2094,9 @@ static int rtw8822c_mac_init(struct rtw_dev *rtwdev)
 	rtw_write16(rtwdev, REG_EIFS, WLAN_EIFS_DUR_TUNE);
 	rtw_write8(rtwdev, REG_NAV_CTRL + 2, WLAN_NAV_MAX);
 	rtw_write8(rtwdev, REG_WMAC_TRXPTCL_CTL_H  + 2, WLAN_BAR_ACK_TYPE);
-	rtw_write32(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
+	rtw_write16(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
+	rtwdev->hal.rxfltmap1 = WLAN_RX_FILTER1;
+	rtw_write16(rtwdev, REG_RXFLTMAP1, rtwdev->hal.rxfltmap1);
 	rtw_write16(rtwdev, REG_RXFLTMAP2, WLAN_RX_FILTER2);
 	rtw_write32(rtwdev, REG_RCR, WLAN_RCR_CFG);
 	rtw_write8(rtwdev, REG_RX_PKT_LIMIT, WLAN_RXPKT_MAX_SZ_512);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw88xxa.c b/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
index 0fa943271fb6..2eaadcfec4cb 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
@@ -512,7 +512,8 @@ static int rtw88xxau_init_queue_priority(struct rtw_dev *rtwdev)
 static void rtw88xxa_init_wmac_setting(struct rtw_dev *rtwdev)
 {
 	rtw_write16(rtwdev, REG_RXFLTMAP0, 0xffff);
-	rtw_write16(rtwdev, REG_RXFLTMAP1, 0x0400);
+	rtwdev->hal.rxfltmap1 = 0x0400;
+	rtw_write16(rtwdev, REG_RXFLTMAP1, rtwdev->hal.rxfltmap1);
 	rtw_write16(rtwdev, REG_RXFLTMAP2, 0xffff);
 
 	rtw_write32(rtwdev, REG_MAR, 0xffffffff);
-- 
2.54.0


