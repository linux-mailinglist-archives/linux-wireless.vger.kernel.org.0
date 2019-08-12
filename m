Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E20389D37
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2019 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfHLLh1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Aug 2019 07:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbfHLLh1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Aug 2019 07:37:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20A21309277B;
        Mon, 12 Aug 2019 11:37:27 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B210F5C1D4;
        Mon, 12 Aug 2019 11:37:24 +0000 (UTC)
Date:   Mon, 12 Aug 2019 13:37:22 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] mt76: mt76x02u: enable multi-vif support
Message-ID: <20190812113721.GA6333@redhat.com>
References: <3edec94719a37a58576d530bba05dc629dfef2e0.1564750297.git.lorenzo@kernel.org>
 <20190805100947.GB17889@redhat.com>
 <CAJ0CqmVXC1-o3rXuho8rBqfa4Xip3WcxSTsQa=POdzXRZMaETg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ0CqmVXC1-o3rXuho8rBqfa4Xip3WcxSTsQa=POdzXRZMaETg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 12 Aug 2019 11:37:27 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 05, 2019 at 01:08:15PM +0200, Lorenzo Bianconi wrote:
> >
> > On Fri, Aug 02, 2019 at 04:36:20PM +0200, Lorenzo Bianconi wrote:
> > > Enable multi-interface support for mt76x02u driver. For the moment
> > > allow max two concurrent interfaces in order to preserve enough room
> > > for ps traffic since we are using beacon slots for it.
> > > I have successfully tested the following configuration:
> > > - AP + STA
> > > - AP0 + AP1
> >
> > The combination that did not work in my testing was STA + STA .
> > This should be fixed or disabled.
> >
> 
> Hi Stanislaw,
> 
> I have just tested STA/STA configuration and it works in my setup.

Confirmed, it works for me as well on current code base.

Tested-by: Stanislaw Gruszka <sgruszka@redhat.com>
