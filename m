Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEAFA155A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 12:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfH2KDl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 06:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbfH2KDl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 06:03:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE0E4106E289;
        Thu, 29 Aug 2019 10:03:40 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C72660C05;
        Thu, 29 Aug 2019 10:03:40 +0000 (UTC)
Date:   Thu, 29 Aug 2019 12:03:37 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Sergey Maranchuk <slav0nic0@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: rt2x00: 5Ghz signal power degradation with linux 5.2 kernel
Message-ID: <20190829100336.GA1930@redhat.com>
References: <CAJp6tx-L0Q4_OaUp+xMod0jsLjAByqnbrvk=JbEq5LOxTdhr_g@mail.gmail.com>
 <CAJp6tx-RcubaTdL4tK1fuLv08s-pqU+RQz4m1mb1LRhg3625zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJp6tx-RcubaTdL4tK1fuLv08s-pqU+RQz4m1mb1LRhg3625zw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 29 Aug 2019 10:03:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 29, 2019 at 12:42:44PM +0300, Sergey Maranchuk wrote:
> I got some problem after upgrade kernel to 5.2 version (debian testing
> linux-image-5.2.0-2-amd64). 5Ghz client  stopped to see AP.
> Some tests with 1metre distance between client-AP: 2.4Ghz  -22dBm, for
> 5Ghz - 53dBm !, for longer distance (8m + walls) 2.4 - 61dBm, 5Ghz not
> visible.
> All works fine with kernel 4.19 and on windows 10, other devices also
> see AP without any problems with same distance.

After looking on the changlog most possible cause of it seems to be
commit 9ad3b55654455258a9463384edb40077439d879f:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9ad3b55654455258a9463384edb40077439d879f

Please try to revert it, and see if that improve rx signal level. 

It that would not help, please try to narrow regression to two
consecutive kernel versions - it is: 4.19 -> 5.0 or 5.0 -> 5.1
or 5.1 -> 5.2 ?

Stanislaw
