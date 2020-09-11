Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190812669C4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 22:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgIKUxE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 16:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgIKUxC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 16:53:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A528C061573;
        Fri, 11 Sep 2020 13:53:02 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kGq2W-002Ob1-5x; Fri, 11 Sep 2020 22:53:00 +0200
Message-ID: <9f992ca7731f966fdc45a38a13c202898e92f2b2.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Fix radiotap header channel flag for 6GHz band
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Date:   Fri, 11 Sep 2020 22:52:58 +0200
In-Reply-To: <010101747eef4d8b-8b5fdae5-790f-4d19-a2df-fba00350baa3-000000@us-west-2.amazonses.com>
References: <010101747ab7b9c0-45fa1c2a-3bb5-44e8-8e6d-457cad2e9845-000000@us-west-2.amazonses.com>
         <1cc7242cd00cd5141a56f17a7f5c80700485aa39.camel@sipsolutions.net>
         <010101747eef4d8b-8b5fdae5-790f-4d19-a2df-fba00350baa3-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-09-11 at 20:50 +0000, Aloka Dixit wrote:
> 
> > Not that anything even cares ... so there's no point in adding a 6GHz
> > flag to radiotap.
> > 
> Separate flag for 6GHz would have been best option, but I still think 
> better to set 5GHz as 6GHz frequencies start in 5GHz range.

But why? wireshark probably needs to be adjusted anyway, so it can just
look at the frequency instead? And it would pretend that it's now an
"11a" frame ... so that clearly never was important, since that hasn't
been true since HT.

johannes

