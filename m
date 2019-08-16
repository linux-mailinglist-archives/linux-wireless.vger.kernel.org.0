Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6956B907F1
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfHPSys convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 14:54:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47369 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfHPSys (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 14:54:48 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id C7371CED26;
        Fri, 16 Aug 2019 21:03:29 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Flag for detecting 802.11r Fast BSS Transition support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+ASDXOyXb0dPGOrjQR7C-b6dyftiZhkta3cwG28B9sC5wxHxQ@mail.gmail.com>
Date:   Fri, 16 Aug 2019 20:54:46 +0200
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Matthew Wang <matthewmwang@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kirtika Ruchandani <kirtika@google.com>, j@w1.fi
Content-Transfer-Encoding: 8BIT
Message-Id: <7687225C-D965-479E-BAE8-769B0AEADD76@holtmann.org>
References: <CAAooHFeLWrY_wmCp-HWqygh8gnKsfpoPCky7SykOBKZgXkb8OQ@mail.gmail.com>
 <20190403210200.GA93453@google.com>
 <211816ff03cf188d834a21b1fbc98b4f8c5b81f4.camel@sipsolutions.net>
 <CA+ASDXOyXb0dPGOrjQR7C-b6dyftiZhkta3cwG28B9sC5wxHxQ@mail.gmail.com>
To:     Brian Norris <briannorris@chromium.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Brian,

>> So I guess you'd have to figure out what operations the drivers need to
>> support then? I'm not even sure how wpa_s would handle this for SME
>> offload devices.
> 
> I'm not intimately familiar with FT, but it looks like the only thing
> wpa_supplicant is asking for is NL80211_CMD_UPDATE_FT_IES. I see
> exactly one driver that implements this, but there's no flag for it.
> Well, I guess we could just run the command and look for EOPNOTSUPP...

this kind of API design and usage is bad. Try-and-error approach is just not sustainable. Even while it is late to add a proper flag that indicates support, we need to do this to make nl80211 better for the future.

Regards

Marcel

