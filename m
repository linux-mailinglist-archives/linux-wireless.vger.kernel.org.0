Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9185738070
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 00:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfFFWUK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 18:20:10 -0400
Received: from mx4.wp.pl ([212.77.101.12]:25586 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfFFWUK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 18:20:10 -0400
Received: (wp-smtpd smtp.wp.pl 12353 invoked from network); 7 Jun 2019 00:20:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1559859608; bh=GIkT1Ll09EE9S+CZbZkslEYfN4hqNOKcaVTMfY+qgzY=;
          h=From:To:Cc:Subject;
          b=eO7F7uLbgDGBREZZqw3hcCk2qSVIYDXvxrYj4Kn+8xZoCb/+B2NElFooo/BZyjPw2
           k2TiQj6RfibdxfXSgYnKdpi4skdgquH9+H2R2vtZSYdR3ibB/Um2OP6JAJpNDgDi3U
           MQBFf5Rn2u9rQeGsFW+NorFg1D2wEtwSCBNBo10I=
Received: from 014.152-60-66-biz-static.surewest.net (HELO cakuba.netronome.com) (kubakici@wp.pl@[66.60.152.14])
          (envelope-sender <kubakici@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <lorenzo.bianconi@redhat.com>; 7 Jun 2019 00:20:07 +0200
Date:   Thu, 6 Jun 2019 15:19:43 -0700
From:   Jakub Kicinski <kubakici@wp.pl>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] mt7601u: fix possible memory leak when the device is
 disconnected
Message-ID: <20190606151943.3de435d8@cakuba.netronome.com>
In-Reply-To: <CAJ0CqmW4SMCPxDAR360XO-kpev-5kHAgqaai9uSAiXth2WP36A@mail.gmail.com>
References: <27c6d00cfb5936978cfb8304c6e1f03973905848.1559835089.git.lorenzo@kernel.org>
        <20190606114845.4026270e@cakuba.netronome.com>
        <CAJ0CqmUCch1dU1J24XDOg_fg35BfWLWjvXc3nV7QN6JHgWhZJw@mail.gmail.com>
        <20190606143627.575c2499@cakuba.netronome.com>
        <CAJ0CqmW4SMCPxDAR360XO-kpev-5kHAgqaai9uSAiXth2WP36A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 28633885924831caa02399d25888ca5e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [geMk]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 7 Jun 2019 00:05:56 +0200, Lorenzo Bianconi wrote:
> I guess this can be a future improvement, do you agree?

Def.

> Do I need to resubmit this patch?

My only concern is the Fixes tag, then.  In the good old days we could
just wait a bit ourselves, now some bot will autoselect it, ugh.

But up to you, for the code:

Acked-by: Jakub Kicinski <kubakici@wp.pl>
