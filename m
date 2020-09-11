Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE8926699C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 22:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgIKUkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 16:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIKUkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 16:40:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE5DC061573
        for <linux-wireless@vger.kernel.org>; Fri, 11 Sep 2020 13:40:04 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kGppw-002OGR-Jh; Fri, 11 Sep 2020 22:40:00 +0200
Message-ID: <5225561f9f5c104bc84ab6e7f183de0ab5e0ea6d.camel@sipsolutions.net>
Subject: Re: [RFC] mac80211: Add radiotap channel flag option for 6GHz band
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 22:39:59 +0200
In-Reply-To: <010101747ee4b985-86863ec8-33e2-4f78-9d9b-93110bfa29fc-000000@us-west-2.amazonses.com>
References: <010101747ee4b985-86863ec8-33e2-4f78-9d9b-93110bfa29fc-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-09-11 at 20:39 +0000, Aloka Dixit wrote:
> Radiotap header needs a new channel flag for 6GHz packets.
> This change uses value 0x200 for new enum balue for 6GHz which was
> previously used for passsive scan flag but has since been removed.

You can't just add to radiotap in a kernel patch ...

But also, just today I replied elsewhere saying that we don't really
need a flag at all?

johannes

