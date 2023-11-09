Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F667E641C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Nov 2023 08:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjKIHBT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 02:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjKIHBO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 02:01:14 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202972D65
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 23:01:02 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A970jKU21378924, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A970jKU21378924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Nov 2023 15:00:45 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Nov 2023 15:00:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 9 Nov 2023 15:00:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 9 Nov 2023 15:00:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes.berg@intel.com>
Subject: RE: [RFC PATCH 1/2] wifi: mac80211: simplify non-chanctx drivers
Thread-Topic: [RFC PATCH 1/2] wifi: mac80211: simplify non-chanctx drivers
Thread-Index: AQHaEpuhHzH+6vRleUu0AYICrNDybLBxhgvw
Date:   Thu, 9 Nov 2023 07:00:45 +0000
Message-ID: <8bf4b564a53d42f9a180c569c060d10a@realtek.com>
References: <20231109003040.4b25d42b8b14.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid>
In-Reply-To: <20231109003040.4b25d42b8b14.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Johannes Berg <johannes@sipsolutions.net>
> Sent: Thursday, November 9, 2023 7:31 AM
> To: linux-wireless@vger.kernel.org
> Cc: Johannes Berg <johannes.berg@intel.com>
> Subject: [RFC PATCH 1/2] wifi: mac80211: simplify non-chanctx drivers
> 
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There are still surprisingly many non-chanctx drivers, but in
> mac80211 that code is a bit awkward. Simplify this by having
> those drivers assign 'emulated' ops, so that the mac80211 code
> can be more unified between non-chanctx/chanctx drivers. This
> cuts the number of places caring about it by about 15, which
> are scattered across - now they're fewer and no longer in the
> channel context handling.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---

Because old firmware can't support chanctx, rtw89 and mt76 could fall back 
to remove chanctx ops. I think we need to add below changes along with
this patch.

(I did 'drivers/net/wireless$ git grep add_chanctx | grep NULL' to find them)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 502be22dbe36..0a98a1627b64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -684,9 +684,9 @@ mt792x_get_mac80211_ops(struct device *dev,
        if (!(*fw_features & MT792x_FW_CAP_CNM)) {
                ops->remain_on_channel = NULL;
                ops->cancel_remain_on_channel = NULL;
-               ops->add_chanctx = NULL;
-               ops->remove_chanctx = NULL;
-               ops->change_chanctx = NULL;
+               ops->add_chanctx = ieee80211_emulate_add_chanctx;
+               ops->remove_chanctx = ieee80211_emulate_remove_chanctx;
+               ops->change_chanctx = ieee80211_emulate_change_chanctx;
                ops->assign_vif_chanctx = NULL;
                ops->unassign_vif_chanctx = NULL;
                ops->mgd_prepare_tx = NULL;
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c689fc2b2d49..390956622181 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4452,9 +4452,9 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
                     !RTW89_CHK_FW_FEATURE(BEACON_FILTER, &early_fw);

        if (no_chanctx) {
-               ops->add_chanctx = NULL;
-               ops->remove_chanctx = NULL;
-               ops->change_chanctx = NULL;
+               ops->add_chanctx = ieee80211_emulate_add_chanctx;
+               ops->remove_chanctx = ieee80211_emulate_remove_chanctx;
+               ops->change_chanctx = ieee80211_emulate_change_chanctx;
                ops->assign_vif_chanctx = NULL;
                ops->unassign_vif_chanctx = NULL;
                ops->remain_on_channel = NULL;



Ping-Ke

