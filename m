Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E3B1E61F2
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbgE1NP2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 09:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390161AbgE1NP2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 09:15:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55971C05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 06:15:27 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeINZ-004s53-0c; Thu, 28 May 2020 15:15:25 +0200
Message-ID: <3c7314e43ea74e036d8b0bf17d0df6c21e4d7c2d.camel@sipsolutions.net>
Subject: Re: [PATCH v3 06/11] mac80211: handle HE 6 GHz Capability in HE STA
 processing
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 28 May 2020 15:15:24 +0200
In-Reply-To: <1e313010dd85af086dc0922a3faeaa0e1c6cc44f.camel@sipsolutions.net> (sfid-20200528_114406_171255_9AD653B2)
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
         <1589399105-25472-6-git-send-email-rmanohar@codeaurora.org>
         (sfid-20200513_214550_120836_C3C5E2B4) <1e313010dd85af086dc0922a3faeaa0e1c6cc44f.camel@sipsolutions.net>
         (sfid-20200528_114406_171255_9AD653B2)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-05-28 at 11:43 +0200, Johannes Berg wrote:

> I'd prefer for *mac80211* to add the 6ghz capa sub-struct to the station
> and use that while parsing, I think that should still be reasonable from
> the driver's POV. You'll see I didn't change ieee80211_sta_he_cap, and I
> am thinking now that it shouldn't change.

Actually. I had this patch too, sending it out soon.

johannes

