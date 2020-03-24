Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED601913B2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 15:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgCXOxq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 10:53:46 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:37258 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgCXOxq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 10:53:46 -0400
Received: by mail-qk1-f176.google.com with SMTP id x3so7950616qki.4
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2020 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W4o0JwmaC1F4lYZmK0sp1ajR0HvHBf4gQneA2MWVHcw=;
        b=sQ2NxvwSEEMRZe3dINQG4JWAjN7B66N2WCgPDkp4Ef2u4iDy/Y9seVbcGNA9MAdguO
         0pBuIKjXp7Gy/LH6RmUvSZUE8nzyPPvNvQg+neSlOnfHyEcT0jwsdJwe60Io1L2L00Cu
         NunkBT2glb40S+dN6BxbqDq17QegM4Z5IEk0IwIYtGPYCht4++4QmKR0ZC1YSmqOk03U
         CPv3I8IKF94CKdUkKViNZp0s8JsX4ObhAwWzwy1GMv+29GhUzPisxhMVe5Dg2T7akkqq
         mS78HpIYjUmRGKgOxFl/emTXk6HC3ZMbx7BGW1c+pAYoCHSN4Q0n8Nac112aqqm+ZUbW
         1Y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W4o0JwmaC1F4lYZmK0sp1ajR0HvHBf4gQneA2MWVHcw=;
        b=fC0cD5Pke877p1xQDJlVk2RBG5+OcP64xDRPMrhRpwKUDYemTuZUiGHEZHGJo7I3Z0
         L0RW4XeVz44EcJrHIiPNYvb8VU0v4U3N7eWoJP+nj8Xpu97wT4hWdLtGb/HxpkXy4o3x
         EZjhDJ82YvvSOfoizUMfaJZ5sw5Cd21Ug7JExO833sUmMnMIBSpi+0whnPtXOp1KD97A
         RuEyzbwMv+QrWyi1kQqNjBzr9/Sf69g76vFs/iV8iXTlMlGWLFZL0o885JO7XIG+acuq
         gBj5swKsEI11RLdgjWI+cKQoiXdfm6/jWe2ci3buwlG/BNX7GIgaFnpxULQd5nMbKv8E
         ZFZA==
X-Gm-Message-State: ANhLgQ16sdoePXeSCVyKjmSEMmXTvJl3Ox6N6swwuZxIAbvEEIiWGETX
        G6HRdBBZvEH4fus2Y4YaGWyTNw==
X-Google-Smtp-Source: ADFU+vsDS6KxfCv0SAlirs3IyLxILP2DrNzyz8lsm3SfwRD4dBOPGmzznm+vls8BsGEM071MG51qNA==
X-Received: by 2002:a37:817:: with SMTP id 23mr23988823qki.221.1585061625678;
        Tue, 24 Mar 2020 07:53:45 -0700 (PDT)
Received: from elrond.bobcopeland.com (CPE30b5c2fb365b-CMa456cc3dfbbf.cpe.net.cable.rogers.com. [99.232.51.173])
        by smtp.gmail.com with ESMTPSA id z66sm13329166qkb.94.2020.03.24.07.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:53:45 -0700 (PDT)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 2BDC4FC007E; Tue, 24 Mar 2020 10:53:44 -0400 (EDT)
Date:   Tue, 24 Mar 2020 10:53:44 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Masashi Honma <masashi.honma@gmail.com>
Subject: Re: wmediumd MAC implementation/simulation
Message-ID: <20200324145344.GA17278@bobcopeland.com>
References: <30484acdee4cd19078673f4f4229dfae49b17804.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30484acdee4cd19078673f4f4229dfae49b17804.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 23, 2020 at 02:56:46PM +0100, Johannes Berg wrote:
> I wonder if this should be split, implementing a "real" MAC for hwsim,
> and then sending also the ACKs "properly", perhaps implementing RTS/CTS
> behaviour in the MAC, etc.?

The reason I did it this way was to go more for rough approximation rather
than fidelity to get whatever simplifications that allows.  For example,
loop really only considers a single frame at a time (and all of its rateset)
rather than all the possible stations that could be sending at a given time
step.  That is good enough for comparing rate controllers, and doing some
mesh testing with a few one-off hacks bolted on top, but nowhere near
complete.

That said, splitting them apart and having more realistic mac layer sounds
reasonable -- how do you anticipate it looking?

> Or perhaps then that's too much complexity and I should just teach ns3
> the hwsim virtio interface?

Up to you :)

-- 
Bob Copeland %% https://bobcopeland.com/
