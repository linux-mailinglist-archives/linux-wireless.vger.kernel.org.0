Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9043F4B71
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 15:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhHWNHM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 09:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbhHWNHE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 09:07:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CD7C061757
        for <linux-wireless@vger.kernel.org>; Mon, 23 Aug 2021 06:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Uk7gR7DqqbsvkWJa4huXiKSphAE1bA3HhmiPpKT7P3Y=;
        t=1629723982; x=1630933582; b=Mx2j7lnQRxm1ukkBoi2YXC+U62/3twn2JqoVswR7TqMPLh0
        jjA0Z6UVCqGP5wQ90ZWKEmRiiAhLdwSsNBhKLWEYyZuUGAiGdD49BnTg2LDxB/bdmcdlVabTqpgew
        bJr0OGeyoWN+9VjHdBO8UkekoIypfeswZeR2xoz7xp0ZcqgBoM85FaO+Ky6DPgnewkYh2dyjxj9L5
        649V88GA5dbvxsYlPdup+d29xXkkkVyjA9kIS7G3YJDKtvrljTwQyp/IZsTTel/qaDBmvOBj+uuX/
        JZZQRDDRwB/wEt8E2C5jAJw1J3NM9gMyLrVDQQVdbIjpPHRemI3AH+5O6DpipKUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mI9ed-00EqsQ-Mo; Mon, 23 Aug 2021 15:06:19 +0200
Message-ID: <8eac660ee029530811fa63d59dd223a98af952ce.camel@sipsolutions.net>
Subject: Re: 5.14-rc3 lockdep warning, iwlwifi 9560
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 23 Aug 2021 15:06:18 +0200
In-Reply-To: <CAJCQCtQqqrN2-AApnOwbTQYxARA5GEfiTPKQDoEmYKdSm0Jhxw@mail.gmail.com>
References: <CAJCQCtSXJ5qA4bqSPY=oLRMbv-irihVvP7A2uGutEbXQVkoNaw@mail.gmail.com>
         <480c17405d7735bed3148c3085f93e3d278acadd.camel@sipsolutions.net>
         <CAJCQCtQqqrN2-AApnOwbTQYxARA5GEfiTPKQDoEmYKdSm0Jhxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2021-08-21 at 00:22 -0600, Chris Murphy wrote:
> Hi Johannes,
> 
> Filed a bug
> https://bugzilla.kernel.org/show_bug.cgi?id=214123

Thanks, I looked at it this, if you want to try a patch, try this:

https://p.sipsolutions.net/d27dfc58efe3313c.txt

johannes

