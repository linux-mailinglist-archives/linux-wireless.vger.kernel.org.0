Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBEA9A7D1
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 08:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404002AbfHWGvp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 02:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732321AbfHWGvo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 02:51:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 957FE2A09BB;
        Fri, 23 Aug 2019 06:51:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA2562633B;
        Fri, 23 Aug 2019 06:51:43 +0000 (UTC)
Date:   Fri, 23 Aug 2019 08:51:41 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: Re: [RFC/RFT v2] rt2x00: do not set IEEE80211_TX_STAT_AMPDU_NO_BACK
 on tx status
Message-ID: <20190823065141.GA10462@redhat.com>
References: <20190712103228.17658-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712103228.17658-1-sgruszka@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 23 Aug 2019 06:51:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 12, 2019 at 12:32:28PM +0200, Stanislaw Gruszka wrote:
> According to documentation IEEE80211_TX_STAT_AMPDU_NO_BACK is suppose
> to be used when we do not receive BA (BlockAck). However on rt2x00 we
> use it when remote station fail to decode one or more subframes within
> AMPDU (some bits are not set in BlockAck bitmap). Setting the flag result
> in sent of BAR (BlockAck Request) frame and this might result of abuse
> of BA session, since remote station can sent BA with incorrect
> sequence numbers after receiving BAR. This problem is visible especially
> when connecting two rt2800 devices.
> 
> Previously I observed some performance benefits when using the flag
> when connecting with iwlwifi devices. But currently possibly due
> to recent changes in rt2x00 removing the flag has no effect on
> those test cases.
> 
> So remove the IEEE80211_TX_STAT_AMPDU_NO_BACK.
> 
> Additionally partially mimic mt76 behaviour: send BAR when
> starting/stopping BA session to workaround problems with some buggy
> clients. Do not sent BAR on PS wakeup since we lack all PS handling
> code what mt76 has.

Currently Felix posted patch that removed sending BAR on BA session
stop. And I do not see necessity for sending BAR on start, so I will
precede with first version of this patch, that just remove NO_BACK
flag. 

Stanislaw
