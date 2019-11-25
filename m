Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D9D109833
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 05:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfKZEDk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 23:03:40 -0500
Received: from 9.mo7.mail-out.ovh.net ([46.105.60.248]:48980 "EHLO
        9.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfKZEDk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 23:03:40 -0500
X-Greylist: delayed 16800 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2019 23:03:40 EST
Received: from player793.ha.ovh.net (unknown [10.108.54.94])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0BC0A140809
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 23:08:23 +0100 (CET)
Received: from awhome.eu (p57B7E051.dip0.t-ipconnect.de [87.183.224.81])
        (Authenticated sender: postmaster@awhome.eu)
        by player793.ha.ovh.net (Postfix) with ESMTPSA id 6E01FC81FD09
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 22:08:23 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1574719702;
        bh=CIEjwWIxYU4yQrgRZykyd/00SlotQiFNdp0k4W8qymU=;
        h=From:Subject:To:Date;
        b=JMOSYiKg2ElsCUCH60alog+xr4b6HVX3uzpOexaqrqLSVfCx6sIBfpyGgZQexZIKt
         vyiMbzd9PApZi9F2yY92Ms9jnDgGauf5nGzQv3DF/BTAnyXxboeV0q/6yBj0fMrzP5
         JBZe/mPD2npeYsguHnT0ZqiUgqFSDjFGVn3KIGsE=
Subject: Intel Wireless Gigabit 11100 VR support or datasheet?
To:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <795f8f6d-b77d-f349-c687-a79607cc4e63@wetzel-home.de>
Date:   Mon, 25 Nov 2019 23:08:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5825124644220509380
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeiuddgudehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffuvffkffgfgggtgfesthejredttdefjeenucfhrhhomheptehlvgigrghnuggvrhcuhggvthiivghluceorghlvgigrghnuggvrhesfigvthiivghlqdhhohhmvgdruggvqeenucffohhmrghinhepihhnthgvlhdrtghomhenucfkpheptddrtddrtddrtddpkeejrddukeefrddvvdegrdekudenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrlhgvgigrnhguvghrseifvghtiigvlhdqhhhomhgvrdguvgdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Is anyone working on Linux WiGig support and/or has any data sheets for 
any Intel WiGig card? I can find neither...

I'm interested in any documentation about the Intel WiGig cards, but I 
find only the marketing material and nothing really useful when you want 
to write a driver for the card...

I would like to get at least an impression how much effort it would be 
to write a driver able to get at least the WiGig Serial Extension (WSB) 
working and maybe try my hand at that.

Here the card I have to play around with:
https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/wireless-gigabit-11100-vr-antenna-m-10042r-product.pdf

Alexander
