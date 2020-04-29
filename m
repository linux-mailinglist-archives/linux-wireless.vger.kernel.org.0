Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C31BE11D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 16:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgD2Od2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 10:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2Od1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 10:33:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDC4C03C1AD
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 07:33:27 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jTnm9-001x5y-P9; Wed, 29 Apr 2020 16:33:25 +0200
Message-ID: <faba71a22ecf46d3b2caf0166943ec4e2dc1c6c5.camel@sipsolutions.net>
Subject: Re: [PATCH 06/10] mac80211: add HE 6 GHz Band Capability IE in
 assoc. request
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 29 Apr 2020 16:33:24 +0200
In-Reply-To: <1587768108-25248-7-git-send-email-rmanohar@codeaurora.org>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
         <1587768108-25248-7-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-04-24 at 15:41 -0700, Rajkumar Manoharan wrote:
> Construct HE 6 GHz band capability element (IEEE 802.11ax/D6.0, 9.4.2.261)
> for association request and mesh beacon. The 6 GHz capability information
> is passed from driver through iftypes caps.

Oh. I had some patches for this too but Luca never sent them out...

I'll have to check the differences to see if either of us missed
something :)

johannes

