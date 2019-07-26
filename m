Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C17678E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 15:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGZNcy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 09:32:54 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49182 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfGZNcx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 09:32:53 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hr0L6-0003tZ-7I; Fri, 26 Jul 2019 15:32:52 +0200
Message-ID: <eaaff61b1e35c43ee64f728c97a02bfcd15c295a.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211_hwsim: Register support for HE meshpoint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Sven Eckelmann <seckelmann@datto.com>
Date:   Fri, 26 Jul 2019 15:32:50 +0200
In-Reply-To: <3082836.hUm4yBdaKs@sven-edge>
References: <20190724163359.3507-1-sven@narfation.org>
         <20190724163359.3507-3-sven@narfation.org>
         <f2e16d10ce3eb3ff08c97c27424b824b8e012553.camel@sipsolutions.net>
         <3082836.hUm4yBdaKs@sven-edge>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-07-26 at 15:31 +0200, Sven Eckelmann wrote:

> As I already wrote:
> 
> > The first three things looks like wpa_supplicant problems. Seems to be 
> > caused by the way HE forces VHT to be enabled and now the tests fail 
> > which try to disable VHT. There was already a patch [0] for that but it
> > wasn't considered a good solution.
> > But beside these three things there are various other problems in 
> > > wpa_supplicant regarding HE with pending patches. So I've used 
> > wpa_supplicant 91b6eba7732354ed3dfe0aa9715dc4c0746e3336 with two 
> > additional patches [1,2] and increased the VM memory to 1024 MB. Also 
> > wireshark (tshark to be more precise) had to be updated to 
> > v3.1.0rc0-1192-gf64990438c

Ok, dunno. But I don't really want to break everything in the hwsim
tests, even if the kernel patch may be correct ... so I guess I'll wait
until you resubmit after some fixes go into wpa_s?

johannes

