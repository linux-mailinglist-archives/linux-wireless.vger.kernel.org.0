Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC926FC08
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 14:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIRMFJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 08:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRMFJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 08:05:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B10C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 05:05:08 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJF8U-006Erg-0J; Fri, 18 Sep 2020 14:05:06 +0200
Message-ID: <f44add4463a8b171e8e207517f3ceae0542d23e2.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: add support to configure HE MCS for beacon
 rate
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 18 Sep 2020 14:05:04 +0200
In-Reply-To: <1600143587-25327-1-git-send-email-rmanohar@codeaurora.org>
References: <1600143587-25327-1-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-09-14 at 21:19 -0700, Rajkumar Manoharan wrote:
> This allows an option to configure a single HE MCS beacon tx rate.

This breaks the ap_beacon_rate_legacy2 hwsim test but I'm not sure why,
please check.

johannes

