Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF99B63402
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfGIKMe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 06:12:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfGIKMe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 06:12:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC76890C7A;
        Tue,  9 Jul 2019 10:12:28 +0000 (UTC)
Received: from localhost (unknown [10.43.2.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52B471001B34;
        Tue,  9 Jul 2019 10:12:26 +0000 (UTC)
Date:   Tue, 9 Jul 2019 12:12:24 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCH 3/3] mt76: usb: use full intermediate buffer in mt76u_copy
Message-ID: <20190709101223.GB3099@redhat.com>
References: <1562079961-15527-1-git-send-email-sgruszka@redhat.com>
 <1562079961-15527-4-git-send-email-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562079961-15527-4-git-send-email-sgruszka@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 09 Jul 2019 10:12:34 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 02, 2019 at 05:06:01PM +0200, Stanislaw Gruszka wrote:
> Instead of use several 4 bytes usb requests, use full 32 bytes buffer
> to copy data to device. With the change we use less requests and copy
> exact data size to the device regardless size is multiple of 4 or not.

And this does not work correctly on some usb hosts, request which
are not multiple of 4 do not ended being written to hardware, 
what results in original problem of having last part of beacon
corrupted.

I would prefer to drop this set - and I would post 2 patches
(first patch fixed and third dropped). But since this is now in
Felix's wireless tree I guess I need to post fixes on top of this
set?

Stanislaw
