Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE0326F9FE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIRKLZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRKLY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:11:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B2C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:11:24 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJDMR-006BTQ-0y; Fri, 18 Sep 2020 12:11:23 +0200
Message-ID: <af858cc36e4b6ba26a1cc8db4d72e7c7046f8f67.camel@sipsolutions.net>
Subject: Re: [PATCH v4 07/14] mac80211: remove tx status call to
 ieee80211_sta_register_airtime
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Fri, 18 Sep 2020 12:11:21 +0200
In-Reply-To: <20200908123702.88454-8-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
         <20200908123702.88454-8-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-08 at 14:36 +0200, Felix Fietkau wrote:
> All drivers using airtime fairness are calling ieee80211_sta_register_airtime
> directly

This really wanted some documentation updates ... I've done some.

johannes

