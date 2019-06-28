Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D759C75
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 15:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfF1NEM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 09:04:12 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:50244 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfF1NEM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 09:04:12 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hgqXx-0001ML-7T; Fri, 28 Jun 2019 15:04:09 +0200
Message-ID: <48a43287e65e1d24082dea2cc32ca14998acb8d1.camel@sipsolutions.net>
Subject: Re: [RFC 0/8] nl80211: add 6GHz band support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org, Jouni Malinen <j@w1.fi>,
        Tova Mussai <tova.mussai@intel.com>
Date:   Fri, 28 Jun 2019 15:04:06 +0200
In-Reply-To: <9ba78df6-18a3-5c1c-6c57-3fa71531b460@broadcom.com> (sfid-20190527_224659_799325_3B1770C5)
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
         <df53f969297fea1f3c8101cd2c1571a957985d2a.camel@sipsolutions.net>
         <16aeb2310e8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
         <9ba78df6-18a3-5c1c-6c57-3fa71531b460@broadcom.com>
         (sfid-20190527_224659_799325_3B1770C5)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend, all,

Sorry. No, my thoughts aren't really more concrete, but Tova is starting
to work on this now.

> This came up in discussion with my colleagues today and I would say from 
> mac80211 perspective there is more to it than just scanning. In short 
> the 6GHz band is for HE-only operation so for example only HE rates may 
> be used. As the bitrates are in ieee80211_supported_band having a 
> separate 6GHz band seems to have a (slight?) advantage.

Hmm, that's a good point too, I hadn't really looked _too_ much at 6GHz
stuff.

Jouni, what do you think?

Perhaps we should just have both. I mean, we can treat this as a
separate band, and still have code to handle operating classes properly,
right?

johannes

