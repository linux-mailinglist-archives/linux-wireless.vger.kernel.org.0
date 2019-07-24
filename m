Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1635972B7E
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 11:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfGXJfP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 05:35:15 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:50096 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfGXJfP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 05:35:15 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hqDg1-0002n1-TL; Wed, 24 Jul 2019 11:35:13 +0200
Message-ID: <fbacce3dd78c2154ee21c4f26f76a18a18349f45.camel@sipsolutions.net>
Subject: Re: [RFC V2 0/8] nl80211: add 6GHz band support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 24 Jul 2019 11:35:11 +0200
In-Reply-To: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

After all the discussion, I think we want this? Care to resend?

I think I want it at least because we shouldn't advertise HT/VHT on 6
GHz as is (just as part of HE) and that's easier if we have a different
band enum, for the capability storage...

> The only place I could find an
> issue with this is in cfg80211_wext_freq(). Not sure how to deal with
> that so it is not part of this series.

Just finally break wext and say if you want to use 6 GHz you need to use
nl80211? :)

johannes

