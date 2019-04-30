Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B873FD51
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfD3P6N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 11:58:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfD3P6M (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 11:58:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8EAE03082B6B;
        Tue, 30 Apr 2019 15:58:12 +0000 (UTC)
Received: from localhost (ovpn-204-103.brq.redhat.com [10.40.204.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAA489F3B3;
        Tue, 30 Apr 2019 15:58:09 +0000 (UTC)
Date:   Tue, 30 Apr 2019 17:58:08 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     yhchuang@realtek.com, linux-wireless@vger.kernel.org,
        johannes@sipsolutions.net, pkshih@realtek.com, tehuang@realtek.com,
        Larry.Finger@lwfinger.net, briannorris@chromium.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v9 00/14] rtw88: mac80211 driver for Realtek 802.11ac
 wireless network chips
Message-ID: <20190430155808.GA3019@redhat.com>
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
 <87sgtzwtst.fsf@purkki.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgtzwtst.fsf@purkki.adurom.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 30 Apr 2019 15:58:12 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 30, 2019 at 03:40:02PM +0300, Kalle Valo wrote:
> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> >
> > This is a new mac80211 driver for Realtek 802.11ac wireless network chips.
> > rtw88 now supports RTL8822BE/RTL8822CE now, with basic station mode
> > functionalities. The firmware for both can be found at linux-firmware.
> 
> This looks very good now. I did a quick review of the driver and had few
> netpicks but nothing really blocking applying this. So I have now
> combined these patches into one big patch and pushed it to the pending
> branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=284d1e4e3311cfe67c1c57ccc275ff0f5666aeea
> 
> I appreciate if people could do a quick check and make sure that I
> didn't do anything stupid when folding the patches.

I've build pending branch and done few quick tests on Realtek
8822CE device. Everything works ok.

> I'm planning to
> apply this to master branch still today evening so that it makes to
> tomorrow's linux-next build, and I can get it to net-next before the
> merge window starts on Sunday.

Yay! Great :-)

Stanislaw
