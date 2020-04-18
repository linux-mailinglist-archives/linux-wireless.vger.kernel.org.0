Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57491AF4F6
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDRUk5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbgDRUk5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 16:40:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35D3C061A0C
        for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2020 13:40:56 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jPuGj-00AYsE-PA; Sat, 18 Apr 2020 22:40:53 +0200
Message-ID: <04a2ef8ec78815779fd36f98a134e1f9c4b900c2.camel@sipsolutions.net>
Subject: Re: [PATCH v2] cfg80211: change internal management frame
 registration API
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>
Date:   Sat, 18 Apr 2020 22:40:51 +0200
In-Reply-To: <1718a2f5ce0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> (sfid-20200418_000902_720641_98B61D53)
References: <20200417124300.f47f3828afc8.I7f81ef59c2c5a340d7075fb3c6d0e08e8aeffe07@changeid>
         <1718a2f5ce0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
         (sfid-20200418_000902_720641_98B61D53)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2020-04-18 at 00:08 +0200, Arend Van Spriel wrote:
> On April 17, 2020 12:43:09 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> 
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Almost all drivers below cfg80211 get the API wrong (except for
> > cfg80211)

Oops, now that I re-read this, of course that latter "cfg80211" should
be "mac80211".

johannes

