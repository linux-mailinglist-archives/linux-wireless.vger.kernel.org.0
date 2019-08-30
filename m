Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB77A3513
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 12:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfH3Klq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 06:41:46 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34642 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfH3Klq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 06:41:46 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3eLg-00046D-7h; Fri, 30 Aug 2019 12:41:44 +0200
Message-ID: <6222b9d9d125c4c3a9f60cc0fe73cef2011b9959.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: Add new helper function for channels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Amar Singhal <asinghal@codeaurora.org>, jouni@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, jjohnson@codeaurora.org,
        rmanohar@codeaurora.org
Date:   Fri, 30 Aug 2019 12:41:43 +0200
In-Reply-To: <01082dca-8d71-c674-1f61-ab5d7e07c007@broadcom.com> (sfid-20190830_124022_495117_5F33303B)
References: <1567115381-7831-1-git-send-email-asinghal@codeaurora.org>
         <01082dca-8d71-c674-1f61-ab5d7e07c007@broadcom.com>
         (sfid-20190830_124022_495117_5F33303B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-08-30 at 12:40 +0200, Arend Van Spriel wrote:

> > +EXPORT_SYMBOL(ieee80211_channel_op_class_to_frequency);
> 
> The function ieee80211_operating_class_to_band() uses ranges within 
> switch statement, eg.:
> 
>          case 128 ... 130:
>                  *band = NL80211_BAND_5GHZ;
>                  return true;

No that you remind me - how is this new function not just a composition
of the existing ones?

i.e. just convert the op_class to band first, and then (band, channel)
to freq?

johannes

