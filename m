Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250E710FA76
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 10:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLCJI4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 04:08:56 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:42222
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfLCJIz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 04:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575364134;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=0vBFo/NUierkS/j/s2t2Px4zI2x8R1nbKIELE4PD5M0=;
        b=Yp1m60H7XKJ5s57pdyZvR06t0vmzmva6r+EO/1nwT/wHoJtVIc92XdgLF48D94vF
        CgDN6Qx5O+en0usKLuRJ2bfHt8+2wEVU5K8CGf2ztvZOdqKsKt/EhG6jEePXh7N5EMj
        EFTYW8A9Db6YYxHe4z2nMnKlgJEfFHHDluW58Q6A=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575364134;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=0vBFo/NUierkS/j/s2t2Px4zI2x8R1nbKIELE4PD5M0=;
        b=Lf/ZCRCTWTKRspSXzaXHZ7L8tJRzRI3D3VFUm1qRyHOCuXa2a6HUh//3LooNxqZZ
        3UGwGg5g/R1GLZUsu0wsK8wOZlNVtjJn3Kho1aZB6o6YzrAb0pqC8HqEIRZjv92bO8E
        cdoj4xB02cJZJXjOGa3beKfCoDOR1xUGjynm8nZQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C1E0C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luciano Coelho <luciano.coelho@intel.com>
Cc:     Anders Kaseorg <andersk@mit.edu>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v1.2] Revert "iwlwifi: assign directly to iwl_trans->cfg in QuZ detection"
References: <alpine.DEB.2.21.999.1912010127330.108936@department-of-alchemy.mit.edu>
        <alpine.DEB.2.21.999.1912021653360.21300@department-of-alchemy.mit.edu>
        <alpine.DEB.2.21.999.1912021706060.21300@department-of-alchemy.mit.edu>
        <0101016ecab326d1-88123857-cf37-47ab-b452-13658625364c-000000@us-west-2.amazonses.com>
        <7808e30fc20684cc0b47a5caf36a747e179c035c.camel@intel.com>
Date:   Tue, 3 Dec 2019 09:08:54 +0000
In-Reply-To: <7808e30fc20684cc0b47a5caf36a747e179c035c.camel@intel.com>
        (Luciano Coelho's message of "Tue, 03 Dec 2019 09:41:54 +0200")
Message-ID: <0101016ecb05064e-722ee289-5d94-4275-a1f9-24dd0cfaeef7-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.12.03-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luciano Coelho <luciano.coelho@intel.com> writes:

> On Tue, 2019-12-03 at 07:39 +0000, Kalle Valo wrote:
>> Anders Kaseorg <andersk@mit.edu> writes:
>> 
>> > This reverts commit 968dcfb4905245dc64d65312c0d17692fa087b99.
>> > 
>> > Both that commit and commit 809805a820c6445f7a701ded24fdc6bbc841d1e4
>> > attempted to fix the same bug (dead assignments to the local variable
>> > cfg), but they did so in incompatible ways. When they were both merged,
>> > independently of each other, the combination actually caused the bug to
>> > reappear, leading to a firmware crash on boot for some cards.
>> > 
>> > https://bugzilla.kernel.org/show_bug.cgi?id=205719
>> > 
>> > Signed-off-by: Anders Kaseorg <andersk@mit.edu>
>> > ---
>> > [Nope it was more than just format=flowed damage. This one should be
>> > better for real.]
>> 
>> This is nitpicking but as a general comment I would prefer to use simple
>> version numbering v2, v3 and so on. Trying to sort v1.2 in a script is
>> awful. So calling this version v3 is very much preferred, it's not like
>> we are running out of numbers :)
>
> Kalle, this patch makes sense.  There was some merge damage because the
> functions were moved around and the local variables' names have
> changed, causing this mess.
>
> Can you please take this patch to v5.4 fixes when you're satisfied?

Ok, I assigned this to myself and queue for v5.5.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
