Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658931E68F9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 20:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391304AbgE1SBn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbgE1SBm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 14:01:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536B5C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 11:01:42 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeMqa-0051Vp-Cx; Thu, 28 May 2020 20:01:40 +0200
Message-ID: <7406af4a9e852d99735e1b1af63deed2f0c5d703.camel@sipsolutions.net>
Subject: Re: iwlist scanning: how to exclude old scan results from output?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bruno Dantas <wireless@dantas.airpost.net>,
        linux-wireless@vger.kernel.org
Date:   Thu, 28 May 2020 20:01:38 +0200
In-Reply-To: <99c4ece3-15ca-42cb-aa09-c86d466d6429@www.fastmail.com>
References: <afef8a7d-053e-4aaa-ace7-d320c32e8b7c@www.fastmail.com>
         <(sfid-20200528_174911_413757_32DBA783)>
         <a185a4283c1230965b520de52737427c91af9c22.camel@sipsolutions.net>
         <99c4ece3-15ca-42cb-aa09-c86d466d6429@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-05-28 at 12:48 -0400, Bruno Dantas wrote:
> > You should use 'iw' instead of 'iwlist', which does have options for
> > flushing the cache.
> 
> Thank you, Johannes.
> 
> I tried  iw  but it has the same issue (the "AndroidAP-bd" SSID is
> non-existent because my phone is physically turned off, 

Well, that _should_ work.

> but it shows up in the output):
> 
> $ sudo iw dev wlan0 scan flush
> ...
> 	TSF: 42037885 usec (0d, 00:00:42)
> 	freq: 2412
> 	beacon interval: 100 TUs
> 	capability: ESS Privacy ShortSlotTime (0x0411)
> 	signal: -31.00 dBm
> 	last seen: 11447 ms ago

Does it go away if you wait long enough for the "last seen" to go above
30 seconds (30000ms)? You should use "iw wlan0 scan dump" (no need for
sudo, and don't scan again) to check.

Because if not, then there's a bug in the references, and the entry is
just being kept alive by ... something. Did you previously connect to
it? Does it also happen if you never connect? Then I guess we'll need to
know what the kernel version is too. :)

johannes

