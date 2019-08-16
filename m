Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042EA8FF13
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 11:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfHPJdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 05:33:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfHPJdF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 05:33:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 331273082B40;
        Fri, 16 Aug 2019 09:33:05 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D00A484006;
        Fri, 16 Aug 2019 09:33:04 +0000 (UTC)
Date:   Fri, 16 Aug 2019 11:33:02 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Emil Karlson <jekarl@iki.fi>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Subject: Re: Ap mode regression in linux-5.3-rc1 in rt2800usb
Message-ID: <20190816093302.GA2158@redhat.com>
References: <20190813215000.6cc27ade@lettuce>
 <20190814085018.GA29199@redhat.com>
 <20190816110012.63982001@lettuce>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20190816110012.63982001@lettuce>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 16 Aug 2019 09:33:05 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 11:00:12AM +0300, Emil Karlson wrote:
> Greetings
> 
> On Wed, 14 Aug 2019 10:50:19 +0200
> Stanislaw Gruszka <sgruszka@redhat.com> wrote:
> 
> > (cc linux-wireless mailing list)
> > 
> > On Tue, Aug 13, 2019 at 09:50:00PM +0300, Emil Karlson wrote:
> > > Greetings
> > > 
> > > After upgrading my ap running rt2800usb to linux-5.3-rc1 I noticed
> > > an unusual problem of not being able to connect to my ap with my
> > > android devices (nexus7/flo and nexus5x/bullhead), from tcpdump it
> > > seemed ap was receiving packets from the android devices after
> > > successful association, but android devices were not seeing the
> > > dhcp replies.
> > > 
> > > I reverted drivers/net/wireless/ralink to the state it is in v5.2.8
> > > and android clients can connect again normally. I did not
> > > explicitly set watchdog parameter to any value.
> 
> > Most suspicious are 710e6cc1595e and 41a531ffa4c5 .
> 
> It seems to me that reverting only
> 710e6cc1595e25378c4b9977f7a8b4ad4a72a109
> allows all my android devices to successfully connect to the internet.

Please test attached patch as proposed fix for
710e6cc1595e25378c4b9977f7a8b4ad4a72a109 and report back. Thanks.

Stanislaw

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rt2x00_clear_ivs_on_start.patch"

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 4a996550288e..cbec2131e943 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -6095,6 +6095,15 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 	}
 
 	/*
+	 * Clear encryption initialization vectors on start, but keep them
+	 * for watchdog reset. Otherwise we will have wrong IVs and not be
+	 * able to keep connections after reset.
+	 */
+	if (!test_bit(DEVICE_STATE_RESET, &rt2x00dev->flags))
+		for (i = 0; i < 256; i++)
+			rt2800_register_write(rt2x00dev, MAC_IVEIV_ENTRY(i), 0);
+
+	/*
 	 * Clear all beacons
 	 */
 	for (i = 0; i < 8; i++)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index d35ef06c5c7a..1dd54a0d083d 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -659,6 +659,7 @@ enum rt2x00_state_flags {
 	DEVICE_STATE_ENABLED_RADIO,
 	DEVICE_STATE_SCANNING,
 	DEVICE_STATE_FLUSHING,
+	DEVICE_STATE_RESET,
 
 	/*
 	 * Driver configuration
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index ad063c920323..c3eab767bc21 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1253,13 +1253,14 @@ static int rt2x00lib_initialize(struct rt2x00_dev *rt2x00dev)
 
 int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 {
-	int retval;
+	int retval = 0;
 
 	if (test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags)) {
 		/*
 		 * This is special case for ieee80211_restart_hw(), otherwise
 		 * mac80211 never call start() two times in row without stop();
 		 */
+		set_bit(DEVICE_STATE_RESET, &rt2x00dev->flags);
 		rt2x00dev->ops->lib->pre_reset_hw(rt2x00dev);
 		rt2x00lib_stop(rt2x00dev);
 	}
@@ -1270,14 +1271,14 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 	 */
 	retval = rt2x00lib_load_firmware(rt2x00dev);
 	if (retval)
-		return retval;
+		goto out;
 
 	/*
 	 * Initialize the device.
 	 */
 	retval = rt2x00lib_initialize(rt2x00dev);
 	if (retval)
-		return retval;
+		goto out;
 
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
@@ -1286,11 +1287,13 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 	/* Enable the radio */
 	retval = rt2x00lib_enable_radio(rt2x00dev);
 	if (retval)
-		return retval;
+		goto out;
 
 	set_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags);
 
-	return 0;
+out:
+	clear_bit(DEVICE_STATE_RESET, &rt2x00dev->flags);
+	return retval;
 }
 
 void rt2x00lib_stop(struct rt2x00_dev *rt2x00dev)

--MGYHOYXEY6WxJCY8--
