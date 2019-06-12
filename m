Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2B4302E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 21:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfFLTbY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 15:31:24 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55234 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfFLTbY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 15:31:24 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hb8xu-00078D-F8; Wed, 12 Jun 2019 21:31:22 +0200
Message-ID: <5d49245b9fc0fe9fbd323f96aa9f17b4f1d7dbd9.camel@sipsolutions.net>
Subject: Re: ROC event when CMD_FRAME duration expires
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <james.prestwood@linux.intel.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 12 Jun 2019 21:31:20 +0200
In-Reply-To: <f7ac0d5ebf9c3e863576c63b374b07a8e3f689b7.camel@linux.intel.com>
References: <b2df99eab3cd3c287187dcf91725530dfa000213.camel@linux.intel.com>
         (sfid-20190611_225154_549360_F87329DC) <292712d7505871a093bd596d2e03ec7d811370f9.camel@sipsolutions.net>
         <f7ac0d5ebf9c3e863576c63b374b07a8e3f689b7.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-06-12 at 12:18 -0700, James Prestwood wrote:
> On Wed, 2019-06-12 at 21:11 +0200, Johannes Berg wrote:
> > On Tue, 2019-06-11 at 13:51 -0700, James Prestwood wrote:
> > > Hi,
> > > 
> > > I see that the event CMD_CANCEL_REMAIN_ON_CHANNEL is emitted when a
> > > CMD_REMAIN_ON_CHANNEL duration expires, but this is not true for
> > > CMD_FRAME when sending offchannel and providing a duration. I see
> > > wpa_supplicant handles this with its own timeout, but couldn't the
> > > same
> > > event be emitted for CMD_FRAME if the duration expires?
> > 
> > I guess? I guess this is for a case where you actually have a wait
> > after
> > the TX, for waiting for a response?
> 
> Yes exactly. For example a GAS/ANQP request before association to some
> offchannel AP (that's at least our use case).

Makes sense, I guess. Send a patch? Seems easy enough.

johannes

