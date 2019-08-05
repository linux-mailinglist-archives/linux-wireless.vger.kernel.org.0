Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD4C816E4
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 12:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfHEKVX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 06:21:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbfHEKVX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 06:21:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2601B4E92A;
        Mon,  5 Aug 2019 10:21:23 +0000 (UTC)
Received: from localhost (ovpn-204-27.brq.redhat.com [10.40.204.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 924871000321;
        Mon,  5 Aug 2019 10:21:22 +0000 (UTC)
Date:   Mon, 5 Aug 2019 12:21:21 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Sid Hayn <sidhayn@gmail.com>
Cc:     helmut.schaa@googlemail.com,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: rt2x00usb warning while channel hopping
Message-ID: <20190805102120.GC17889@redhat.com>
References: <CAM0KTbCuryuOTV1LdsEF4LkBHV4cPGpLe9nwA68CVCoDQ-6fkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0KTbCuryuOTV1LdsEF4LkBHV4cPGpLe9nwA68CVCoDQ-6fkA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 05 Aug 2019 10:21:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 01, 2019 at 12:43:26PM -0400, Sid Hayn wrote:
> While testing wireless-testing kernel for some other fixes, I
> encountered this warning.  I have a few different chipsets and drivers
> all channel hopping in monitor mode on the test box, but I get this
> warning from rt2x00 over and over again (lots).  I am testing two
> patches from johill on top of wireless testing, I don't believe they
> are causing this, but I'll include them for completeness.
> 
> https://patchwork.kernel.org/patch/11063915/
> https://patchwork.kernel.org/patch/11069625/

The way to find out is drop those patches and see if the warning
is still there. But it still can be rt2x00 problem that is only
triggered with those patches, so let's try to debug. 
   
> I'm happy to test anything required, although I will be traveling next
> week which may cause delays.
<snip>

> [  170.055276] ------------[ cut here ]------------
> [  170.055305] WARNING: CPU: 3 PID: 5777 at
> rt2x00lib_config.cold.0+0xc/0x2a [rt2x00lib]

This seems to be warning at rt2x00ht_center_channel() in:

        for (i = 0; i < spec->num_channels; i++)
                if (spec->channels[i].channel == center_channel)
                        return i;

        WARN_ON(1);
        return conf->chandef.chan->hw_value;

So looks like we set channel that is not specified in rt2800 channels
table. Not sure at the moment if mac80211 provide wrong channel spec or
rt2x00 do something wrong. Please apply below patch and provide prints.

Stanislaw

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00config.c b/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
index 0ee1813e8453..5f6dadef9f7c 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
@@ -185,7 +185,11 @@ static u16 rt2x00ht_center_channel(struct rt2x00_dev *rt2x00dev,
 		if (spec->channels[i].channel == center_channel)
 			return i;
 
-	WARN_ON(1);
+	WARN_ONCE(1, "hw_value %d channel %d center_channel %d\n",
+		  conf->chandef.chan->hw_value,
+		  spec->channels[conf->chandef.chan->hw_value].channel,
+		  center_channel);
+
 	return conf->chandef.chan->hw_value;
 }
 
