Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B475130AB63
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 16:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhBAPbu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 10:31:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231742AbhBAPbf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 10:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612193405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQGXaRvz7lPPymEQxbqxXAbl1iywQTVXeuQRPD1q22M=;
        b=cJgaMMcpBs9CfhJHAleZOMmFgK44HWt0htzkJcfGGgVSTTXCO4QHH4hWU/rlh7cMGBWI1h
        3wwbqJ3lfct0n/tySsGrYF2ehRONsQNl+TwUAUS6XPU5Y7oUU6JFcDeiVEH1rSPqE2kog1
        GamnILBAdPuTFFXiI7DzSkHUdj5859w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-KGVgUmLVPXehOOeXRCeVFA-1; Mon, 01 Feb 2021 10:30:01 -0500
X-MC-Unique: KGVgUmLVPXehOOeXRCeVFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C069D107ACE3;
        Mon,  1 Feb 2021 15:30:00 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-234.ams2.redhat.com [10.36.112.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 625BD5C1A1;
        Mon,  1 Feb 2021 15:29:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 1/1] staging: rtl8723bs: Move wiphy setup to after reading the regulatory settings from the chip
Date:   Mon,  1 Feb 2021 16:29:56 +0100
Message-Id: <20210201152956.370186-2-hdegoede@redhat.com>
In-Reply-To: <20210201152956.370186-1-hdegoede@redhat.com>
References: <20210201152956.370186-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 81f153faacd0 ("staging: rtl8723bs: fix wireless regulatory API
misuse") moved the wiphy_apply_custom_regulatory() call to earlier in the
driver's init-sequence, so that it gets called before wiphy_register().

But at this point in time the eFuses which code the regulatory-settings
for the chip have not been read by the driver yet, causing
_rtw_reg_apply_flags() to set the IEEE80211_CHAN_DISABLED flag on *all*
channels.

On the device where I initially tested the fix, a Jumper EZpad 7 tablet,
this does not cause any problems because shortly after init the
rtw_reg_notifier() gets called fixing things up. I guess this happens
into response to receiving a (broadcast) packet with regulatory info
from the access-point ?

But on another device with a RTL8723BS wifi chip, an Acer Switch 10E
(SW3-016), the rtw_reg_notifier() never gets called. I assume that some
fuse has been set on this device to ignore regulatory info received from
access-points.

This means that on the Acer the driver is stuck in a state with all
channels disabled, leading to non working Wifi.

We cannot move the wiphy_apply_custom_regulatory() call back, because
that call must be made before the wiphy_register() call.

Instead move the entire rtw_wdev_alloc() call to after the Efuses have
been read, fixing all channels being disabled in the initial channel-map.

Fixes: 81f153faacd0 ("staging: rtl8723bs: fix wireless regulatory API misuse")
Cc: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index b2208e5f190a..301ffff12e82 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -339,8 +339,6 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 
 	padapter = rtw_netdev_priv(pnetdev);
 
-	rtw_wdev_alloc(padapter, dvobj_to_dev(dvobj));
-
 	/* 3 3. init driver special setting, interface, OS and hardware relative */
 
 	/* 4 3.1 set hardware operation functions */
@@ -378,6 +376,8 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 		goto free_hal_data;
 	}
 
+	rtw_wdev_alloc(padapter, dvobj_to_dev(dvobj));
+
 	/* 3 8. get WLan MAC address */
 	/*  set mac addr */
 	rtw_macaddr_cfg(&psdio->func->dev, padapter->eeprompriv.mac_addr);
-- 
2.29.2

