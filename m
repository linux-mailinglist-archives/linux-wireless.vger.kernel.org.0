Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4627A181285
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 09:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgCKIBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 04:01:45 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43834 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgCKIBp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 04:01:45 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jBwJD-000jiT-43; Wed, 11 Mar 2020 09:01:43 +0100
Message-ID: <9fe23cf27e3c3497073406014d1040bf21450b1f.camel@sipsolutions.net>
Subject: Re: [PATCH mac80211-next] virt_wifi: implement ndo_get_iflink
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Taehee Yoo <ap420073@gmail.com>, linux-wireless@vger.kernel.org,
        Cody Schuffelen <schuffelen@google.com>
Date:   Wed, 11 Mar 2020 09:01:41 +0100
In-Reply-To: <20200305090636.28221-1-ap420073@gmail.com> (sfid-20200305_100646_961996_48E37F6F)
References: <20200305090636.28221-1-ap420073@gmail.com>
         (sfid-20200305_100646_961996_48E37F6F)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-03-05 at 09:06 +0000, Taehee Yoo wrote:
> ->ndo_get_iflink() is useful for finding lower interface.
> 
> Test commands:
>     ip link add dummy0 type dummy
>     ip link add vw1 link dummy0 type virt_wifi
>     ip link show vw1
> 
> Before:
>     9: vw1: <BROADCAST,MULTICAST> ...
> After:
>     9: vw1@dummy0: <BROADCAST,MULTICAST> ...

So I guess from a netdev layering perspective that makes sense, but I'd
like to hear from Cody if that's really desired from a testing
perspective?

This driver is fundamentally a testing tool and doesn't really have a
place in a production system, so I'd be more likely to look at the
testing needs for this.

Thanks,
johannes

