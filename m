Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F37094EBA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 22:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfHSUJR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 16:09:17 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47280 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfHSUJR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 16:09:17 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hznxr-0003oD-Gz; Mon, 19 Aug 2019 22:09:15 +0200
Message-ID: <5bc077f7b2f017da7c027edd27a543910dd6ac32.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: Extended Key ID support for mvm and dvm
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Date:   Mon, 19 Aug 2019 22:09:14 +0200
In-Reply-To: <52914e64663283eeff9445b8b1fb37986c15223d.camel@sipsolutions.net> (sfid-20190819_220332_573678_41D0461A)
References: <20190819180540.2855-1-alexander@wetzel-home.de>
         <204c346ab9fc71865e4cb5f5c29ec33ca05050e2.camel@sipsolutions.net>
         <da471544-3370-8ba1-2265-d02ab09cdcee@wetzel-home.de>
         <52914e64663283eeff9445b8b1fb37986c15223d.camel@sipsolutions.net>
         (sfid-20190819_220332_573678_41D0461A)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-08-19 at 22:03 +0200, Johannes Berg wrote:
> 
> > While less desirable we still could get that working: The mvm driver 
> > would have to detect the key borders and then tell the firmware to 
> > switch over to the other key. But we would have to make sure to not 
> > re-enable A-MPDU aggregation till the card really has switched.

> So probably you're right, and we'd have to disable A-MPDUs until we have
> no outstanding old-key-retransmits, but that seems manageable.

Actually, we probably have to even delay the key switch until there are
no more frames to retransmit, because the hardware is involved to some
extent and it won't know about two keys or something... Not really sure
how it all works though, off the top of my head.

johannes

