Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6122545B8
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 15:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgH0NKh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgH0NKN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 09:10:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C329FC061233
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 06:10:08 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kBHfL-00BbGI-3c; Thu, 27 Aug 2020 15:10:07 +0200
Message-ID: <9037f817f2b65ca469967eff6c4b7301d4ae796e.camel@sipsolutions.net>
Subject: Re: [PATCH V3 4/9] mac80211: add multiple bssid/ema support to bcn
 templating
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 27 Aug 2020 15:10:06 +0200
In-Reply-To: <20200812150050.2683396-5-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
         <20200812150050.2683396-5-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-08-12 at 17:00 +0200, John Crispin wrote:
> Extend ieee80211_beacon_get_template() to allow generation of EMA beacons.
> Drivers for hardware that does not support ema offloading can use this
> function to update their becaons after they receive beacon completion
> events from the hardware.
> 

This all seems really quite simple when you have the software fallbacks,
so is there any chance you could add it to hwsim, in particular for
hostap tests? I'm sure Jouni would also appreciate tests for this on the
hostap side.

johannes

