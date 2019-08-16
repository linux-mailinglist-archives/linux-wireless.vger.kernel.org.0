Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED968FCE6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 10:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfHPIAT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 04:00:19 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:58191 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfHPIAT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 04:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZMHHL5jXCHia4KYz6zLJzGtMJy7uSZy2XpIK1XJOMZc=; b=tJa7HYaG2gkKVPwfFvZaQ5vdYC
        ZptE/oLg9uFfhP9GuDGiVeIPZ3Hwl6LZd4Qw+zeouDzA7TTjfzI0CpxMt6qnB3SQ2NG7yeboVZXQ/
        z11Q9CF8gnGUuvkym5pSqVHynssTyUpFoeJE2o/ilUm4MOkIhzt7GzZzG54WMwnTOU5gotvy2of7X
        g1M3Enia8oqyvYT2EBxKzFXpl1TjNYSSflhV1IkJCFyddObQ6FF2CIMGM76L3oqV+M9WxnDM8mkgS
        PiYAQhr6lS00mWuNbk34Kffd+YVnouqhW4TqZavBt7aRYftArqIbTkULUAiduYMTVezy+9UVZNBRb
        R6M8CNUQ==;
Received: from [194.100.106.190] (helo=lettuce)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jekarl@iki.fi>)
        id 1hyX9h-0005QR-15; Fri, 16 Aug 2019 11:00:13 +0300
Date:   Fri, 16 Aug 2019 11:00:12 +0300
From:   Emil Karlson <jekarl@iki.fi>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Subject: Re: Ap mode regression in linux-5.3-rc1 in rt2800usb
Message-ID: <20190816110012.63982001@lettuce>
In-Reply-To: <20190814085018.GA29199@redhat.com>
References: <20190813215000.6cc27ade@lettuce>
        <20190814085018.GA29199@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 194.100.106.190
X-SA-Exim-Mail-From: jekarl@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greetings

On Wed, 14 Aug 2019 10:50:19 +0200
Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> (cc linux-wireless mailing list)
> 
> On Tue, Aug 13, 2019 at 09:50:00PM +0300, Emil Karlson wrote:
> > Greetings
> > 
> > After upgrading my ap running rt2800usb to linux-5.3-rc1 I noticed
> > an unusual problem of not being able to connect to my ap with my
> > android devices (nexus7/flo and nexus5x/bullhead), from tcpdump it
> > seemed ap was receiving packets from the android devices after
> > successful association, but android devices were not seeing the
> > dhcp replies.
> > 
> > I reverted drivers/net/wireless/ralink to the state it is in v5.2.8
> > and android clients can connect again normally. I did not
> > explicitly set watchdog parameter to any value.

> Most suspicious are 710e6cc1595e and 41a531ffa4c5 .

It seems to me that reverting only
710e6cc1595e25378c4b9977f7a8b4ad4a72a109
allows all my android devices to successfully connect to the internet.

Best Regards
-Emil
