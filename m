Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3F18CED2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2019 10:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfHNIuU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Aug 2019 04:50:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfHNIuU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Aug 2019 04:50:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9318B30083EE;
        Wed, 14 Aug 2019 08:50:20 +0000 (UTC)
Received: from localhost (unknown [10.40.205.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2720082201;
        Wed, 14 Aug 2019 08:50:19 +0000 (UTC)
Date:   Wed, 14 Aug 2019 10:50:19 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Emil Karlson <jekarl@iki.fi>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Subject: Re: Ap mode regression in linux-5.3-rc1 in rt2800usb
Message-ID: <20190814085018.GA29199@redhat.com>
References: <20190813215000.6cc27ade@lettuce>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813215000.6cc27ade@lettuce>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 14 Aug 2019 08:50:20 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(cc linux-wireless mailing list)

On Tue, Aug 13, 2019 at 09:50:00PM +0300, Emil Karlson wrote:
> Greetings
> 
> After upgrading my ap running rt2800usb to linux-5.3-rc1 I noticed an
> unusual problem of not being able to connect to my ap with my android
> devices (nexus7/flo and nexus5x/bullhead), from tcpdump it seemed ap
> was receiving packets from the android devices after successful
> association, but android devices were not seeing the dhcp replies.
> 
> I reverted drivers/net/wireless/ralink to the state it is in v5.2.8 and
> android clients can connect again normally. I did not explicitly set
> watchdog parameter to any value.
> 
> Do you have any insights or is this already fixed?

Most likely is not fixed. We have those new commits in 5.3:

41a531ffa4c5 rt2x00usb: fix rx queue hang
0f47aeeada2a rt2800: do not enable watchdog by default
e403fa31ed71 rt2x00: add restart hw
710e6cc1595e rt2800: do not nullify initialization vector data
09db3b000619 rt2800: add pre_reset_hw callback
759c5b599cf4 rt2800: initial watchdog implementation
2034afe4db4a rt2800: add helpers for reading dma done index
9f3e3323e996 rt2x00: allow to specify watchdog interval

Most suspicious are 710e6cc1595e and 41a531ffa4c5 .

Could you test by reverting one single commit on 5.3
(first 710e6cc1595e and if that not help 41a531ffa4c5)
and check if it makes the problem gone?

Stanislaw
