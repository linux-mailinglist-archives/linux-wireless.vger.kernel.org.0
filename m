Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2F17A726
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCEOKB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:10:01 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49810 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgCEOKB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:10:01 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 70991CECEC;
        Thu,  5 Mar 2020 15:19:27 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] mac80211_hwsim: add frame transmission support over
 virtio
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c5319f6630be431c8680051fd4c33d59524683a2.camel@sipsolutions.net>
Date:   Thu, 5 Mar 2020 15:09:59 +0100
Cc:     linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E37B1033-8525-422A-AF10-5EEE5988FE57@holtmann.org>
References: <20200305143212.c6e4c87d225b.I7ce60bf143e863dcdf0fb8040aab7168ba549b99@changeid>
 <2F7ADB4C-8C2C-4DEC-80AF-9E2D6B55CA88@holtmann.org>
 <c5319f6630be431c8680051fd4c33d59524683a2.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

>>> This allows communication with external entities.
>>> 
>>> It also required fixing up the netlink policy, since NLA_UNSPEC
>>> attributes are no longer accepted.
>>> 
>>> Signed-off-by: Erel Geron <erelx.geron@intel.com>
>>> [port to backports, inline the ID, use 29 as the ID as requested,
>>> drop != NULL checks, reduce ifdefs]
>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> 
>> since the module now can auto-load, don’t you want to change radios = 2 to radio = 0?
> 
> Hmm. I didn't really want to change the behaviour there, and the auto-
> loading is *highly* unlikely, you need to specifically set up a vhost-
> user wmediumd (which I'm in the process of publishing).
> 
> And even then, you still need to have the radios, they just don't
> communicate directly with each other but will go into wmediumd over the
> virtio when you actually have virtio.
> 
> I'm not principally opposed to changing the default, but I'm not
> convinced it'd be related to this patch in any way.

can we just make it a Kconfig option that defaults to 2, but gets set to 0 when virtio support is included.

Regards

Marcel

