Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A666C42FD2
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 21:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfFLTSl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 15:18:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:26770 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfFLTSk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 15:18:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 12:18:39 -0700
X-ExtLoop1: 1
Received: from jprestwo-test.jf.intel.com ([10.54.74.49])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2019 12:18:39 -0700
Message-ID: <f7ac0d5ebf9c3e863576c63b374b07a8e3f689b7.camel@linux.intel.com>
Subject: Re: ROC event when CMD_FRAME duration expires
From:   James Prestwood <james.prestwood@linux.intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Wed, 12 Jun 2019 12:18:25 -0700
In-Reply-To: <292712d7505871a093bd596d2e03ec7d811370f9.camel@sipsolutions.net>
References: <b2df99eab3cd3c287187dcf91725530dfa000213.camel@linux.intel.com>
         (sfid-20190611_225154_549360_F87329DC) <292712d7505871a093bd596d2e03ec7d811370f9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-06-12 at 21:11 +0200, Johannes Berg wrote:
> On Tue, 2019-06-11 at 13:51 -0700, James Prestwood wrote:
> > Hi,
> > 
> > I see that the event CMD_CANCEL_REMAIN_ON_CHANNEL is emitted when a
> > CMD_REMAIN_ON_CHANNEL duration expires, but this is not true for
> > CMD_FRAME when sending offchannel and providing a duration. I see
> > wpa_supplicant handles this with its own timeout, but couldn't the
> > same
> > event be emitted for CMD_FRAME if the duration expires?
> 
> I guess? I guess this is for a case where you actually have a wait
> after
> the TX, for waiting for a response?

Yes exactly. For example a GAS/ANQP request before association to some
offchannel AP (that's at least our use case).

Thanks,
James
> 
> johannes
> 

