Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE266AD9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfGLKZN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 06:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfGLKZM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 06:25:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EFBC81F10;
        Fri, 12 Jul 2019 10:25:12 +0000 (UTC)
Received: from localhost (ovpn-204-58.brq.redhat.com [10.40.204.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AB281001B2B;
        Fri, 12 Jul 2019 10:25:11 +0000 (UTC)
Date:   Fri, 12 Jul 2019 12:25:10 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: Re: [RFC/RFT] rt2x00: do not set IEEE80211_TX_STAT_AMPDU_NO_BACK on
 tx status
Message-ID: <20190712102510.GA17258@redhat.com>
References: <20190704110652.3955-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704110652.3955-1-sgruszka@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 12 Jul 2019 10:25:12 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 04, 2019 at 01:06:52PM +0200, Stanislaw Gruszka wrote:
> According to documentation IEEE80211_TX_STAT_AMPDU_NO_BACK is suppose
> to be used when we do not recive BA (BlockAck). However on rt2x00 we
> use it when remote station fail to decode one or more subframes within
> AMPDU (some bits are not set in BlockAck bitmap). Setting the flag result
> in sent of BAR (BlockAck Request) frame and this might result of abuse
> of BA session, since remote station can sent BA with incorrect 
> sequence numbers after receiving BAR. This problem is visible especially
> when connecting two rt2800 devices.
> 
> Previously I observed some performance benefits when using the flag
> when connecting with iwlwifi devices. But currently possibly due
> to reacent changes in rt2x00 removing the flag has no effect on
> those test cases.
> 
> So remove the IEEE80211_TX_STAT_AMPDU_NO_BACK.
> 
> Perhaps we should send BAR exlicitly on BA session start/stop
> and when remote STA went to PowerSave mode (for AP) like mt76 does.
> But I do not understand for what this is needed.

This commit 

https://github.com/openwrt/mt76/commit/3e447e7797d64dbf4dc1dd5553d08be0d8150d7e

explained that sending BAR on stop aggregation is workaround for
buggy clients. I can implement that on rt2x00. But I will skip
sending BAR on remote station PS wakeup, since we do not implement
all PS related code in rt2x00.  

Stanislaw 
