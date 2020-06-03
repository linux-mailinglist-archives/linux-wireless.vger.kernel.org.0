Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29A1ED1D7
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 16:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgFCONv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFCONt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 10:13:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B63AC08C5C0
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 07:13:49 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jgU9K-008j9L-Lh; Wed, 03 Jun 2020 16:13:46 +0200
Message-ID: <ea1507a76adb346dc46c934d2905ab055b0f9236.camel@sipsolutions.net>
Subject: Re: BUG: deadlock on flushing mgmt registrations update work
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>,
        linux-wireless@vger.kernel.org
Date:   Wed, 03 Jun 2020 16:13:44 +0200
In-Reply-To: <e8143f03-d4a7-16ee-2e9a-e8d676ffef6d@tu-ilmenau.de> (sfid-20200603_161057_505290_069F30A5)
References: <e8143f03-d4a7-16ee-2e9a-e8d676ffef6d@tu-ilmenau.de>
         (sfid-20200603_161057_505290_069F30A5)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-06-03 at 16:10 +0200, Markus Theil wrote:
> While running hostapd tests, the following deadlock showed up:
> 
> cfg80211_mgmt_registrations_update_wk locks the rtnl lock, which
> is already hold by nl80211 when going into __cfg80211_unregister_wdev,
> which flushes cfg80211_mgmt_registrations_update_wk.

Hah, at least the work item lockdep detection is still working ;)

(just the other day I was telling someone the story of how I added that)

I'll take a look tomorrow.

johannes

