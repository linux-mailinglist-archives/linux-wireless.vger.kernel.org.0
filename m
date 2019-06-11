Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8DA41674
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 22:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406913AbfFKUvs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 16:51:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:34331 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406629AbfFKUvq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 16:51:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 13:51:46 -0700
X-ExtLoop1: 1
Received: from jprestwo-test.jf.intel.com ([10.54.74.49])
  by orsmga008.jf.intel.com with ESMTP; 11 Jun 2019 13:51:45 -0700
Message-ID: <b2df99eab3cd3c287187dcf91725530dfa000213.camel@linux.intel.com>
Subject: ROC event when CMD_FRAME duration expires
From:   James Prestwood <james.prestwood@linux.intel.com>
To:     linux-wireless@vger.kernel.org
Date:   Tue, 11 Jun 2019 13:51:12 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I see that the event CMD_CANCEL_REMAIN_ON_CHANNEL is emitted when a
CMD_REMAIN_ON_CHANNEL duration expires, but this is not true for
CMD_FRAME when sending offchannel and providing a duration. I see
wpa_supplicant handles this with its own timeout, but couldn't the same
event be emitted for CMD_FRAME if the duration expires?

Looking in mac80211/offchannel.c: ieee80211_roc_notify_destroy:

if (!roc->mgmt_tx_cookie)
	cfg80211_remain_on_channel_expired(&roc->sdata->wdev,
					   roc->cookie, roc->chan,
					   GFP_KERNEL);

In the case of CMD_FRAME, mgmt_tx_cookie is set, so this event does not
get emitted. Could the same expire event be emitted when mgmt_tx_cookie
is set as well? This would eliminate the need for userspace to keep a
timeout tracking this.

If this is ok I can send a patch (Looks like all I would need to do is
remove the if, and include the correct cookie, roc->cookie or roc-
>mgmt_tx_cookie).

Thanks,
James

