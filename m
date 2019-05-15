Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5AE1F618
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 15:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfEON7M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 09:59:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfEON7M (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 09:59:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBEE13005049;
        Wed, 15 May 2019 13:59:11 +0000 (UTC)
Received: from localhost (ovpn-204-245.brq.redhat.com [10.40.204.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D91F608AC;
        Wed, 15 May 2019 13:59:08 +0000 (UTC)
Date:   Wed, 15 May 2019 15:59:07 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
Message-ID: <20190515135906.GA3731@redhat.com>
References: <20190513094837.GB15694@redhat.com>
 <20190515093333.GA2333@redhat.com>
 <20190515094354.GA30757@localhost.localdomain>
 <20190515095440.GB3407@redhat.com>
 <20190515100343.GB30757@localhost.localdomain>
 <20190515103309.GA15134@redhat.com>
 <20190515111348.GC30757@localhost.localdomain>
 <20190515114615.GB15134@redhat.com>
 <20190515120741.GD30757@localhost.localdomain>
 <20190515134828.GA2992@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515134828.GA2992@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 15 May 2019 13:59:12 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 15, 2019 at 03:48:29PM +0200, Stanislaw Gruszka wrote:
> > Tx hangs occur in very particular conditions (e.g 200Mbps bidirectional
> > traffic) and moreover they do not always occur so I am not convinced they
> > are always EDCCA related and so I am not confident to remove the watchdog
> 
> I'm not opting for watchdog removal, but for full EDCCA removal.
On mt76x02, on other chips/firmwares it can work just fine.

Stanislaw
