Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46651E22E9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgEZN2N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 09:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEZN2N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 09:28:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D6CC03E96D
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 06:28:13 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdZcp-003Rf8-AT; Tue, 26 May 2020 15:28:11 +0200
Message-ID: <e069424913bcc720263b124e112d6b6a33b81f13.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] nl80211/mac80211: add tx status for ctrl port
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 26 May 2020 15:28:10 +0200
In-Reply-To: <20200508144202.7678-1-markus.theil@tu-ilmenau.de> (sfid-20200508_164223_606493_38A9ADF5)
References: <20200508144202.7678-1-markus.theil@tu-ilmenau.de>
         (sfid-20200508_164223_606493_38A9ADF5)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Markus,

Generally, this seems fine.

I have applied the cfg80211/nl80211 bits in my tree (currently in
mac80211-next pending branch), and recombined the patches for that.

I've also modified the nl80211 code to return the cookie in the extack
message, rather than a separate message, which is much nicer. That means
you'll have to modify the hostapd changes for this.

The mac80211 changes seem overly complex, I'll reply in detail.

johannes

