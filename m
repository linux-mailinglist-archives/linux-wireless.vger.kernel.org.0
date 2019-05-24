Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E86D297B5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2019 13:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391341AbfEXL4o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 May 2019 07:56:44 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:54872 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391289AbfEXL4o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 May 2019 07:56:44 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hU8oU-0004aQ-IG; Fri, 24 May 2019 13:56:42 +0200
Message-ID: <df53f969297fea1f3c8101cd2c1571a957985d2a.camel@sipsolutions.net>
Subject: Re: [RFC 0/8] nl80211: add 6GHz band support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 May 2019 13:56:41 +0200
In-Reply-To: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

On Mon, 2019-05-20 at 14:00 +0200, Arend van Spriel wrote:
> In 802.11ax D4.0 a new band has been proposed. This series contains
> changes to cfg80211 for supporting this band. With 2GHz and 5GHz there
> was no overlap in channel number. However, this new band has channel
> numbers with a range from 1 up to 253.

At the wireless workshop in Prague, we looked at this and sort of
decided that it'd be better to put all the 6 GHz channels into the 5 GHz
"band" in nl80211, to avoid all the "5 || 6" since they're really the
same except for very specific places like scanning.

The channel numbers problem came up, of course, but for nl80211 it's not
that relevant since we deal with frequencies only, and we thought inside
the kernel it'd be better to disambiguate them with operating classes,
where needed - only few places really deal with channel numbers to start
with.

Do you have any reason to think that it's better as a separate band enum
(which I notice you put before 60 GHz thus breaking the API/ABI :P)?

Thanks,
johannes


