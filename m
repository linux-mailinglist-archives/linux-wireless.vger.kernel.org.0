Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388EC26FAFE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRKzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRKzN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:55:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D94C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:55:13 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJE2p-006CwM-GZ; Fri, 18 Sep 2020 12:55:11 +0200
Message-ID: <ea4b21deafb0ee642668e867cc710a19ec3e4eac.camel@sipsolutions.net>
Subject: Re: [PATCH v2 15/22] mac80211: don't calculate duration for S1G
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 18 Sep 2020 12:55:10 +0200
In-Reply-To: <d922fa0215d8617c92948e1ddee5d23f77610723.camel@sipsolutions.net> (sfid-20200918_125252_194118_6EAB3BB0)
References: <20200831205600.21058-1-thomas@adapt-ip.com>
         <20200831205600.21058-16-thomas@adapt-ip.com>
         <d922fa0215d8617c92948e1ddee5d23f77610723.camel@sipsolutions.net>
         (sfid-20200918_125252_194118_6EAB3BB0)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Oops, sorry. I just realized I've been replying to v2, while *looking*
at v3 in patchwork ...

I'll continue on v3, but this seems mostly the same.

johannes

