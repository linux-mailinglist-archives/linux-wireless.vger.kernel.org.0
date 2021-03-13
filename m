Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB10F339EE9
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Mar 2021 16:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhCMPXJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Mar 2021 10:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCMPW5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Mar 2021 10:22:57 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5DAC061574
        for <linux-wireless@vger.kernel.org>; Sat, 13 Mar 2021 07:22:56 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lL66N-00Fegy-Dg; Sat, 13 Mar 2021 16:22:51 +0100
Message-ID: <2d419a7d1d10067760fcc553582e87fb3ca4a34a.camel@sipsolutions.net>
Subject: Re: [PATCH 5.12 regression fix] brcmfmac: p2p: Fix recently
 introduced deadlock issue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Date:   Sat, 13 Mar 2021 16:22:50 +0100
In-Reply-To: <20210313143635.109154-1-hdegoede@redhat.com> (sfid-20210313_153800_338272_9A5AD47E)
References: <20210313143635.109154-1-hdegoede@redhat.com>
         (sfid-20210313_153800_338272_9A5AD47E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2021-03-13 at 15:36 +0100, Hans de Goede wrote:
> Commit a05829a7222e ("cfg80211: avoid holding the RTNL when calling the
> driver") replaced the rtnl_lock parameter passed to various brcmf
> functions with just lock, because since that commit it is not just
> about the rtnl_lock but also about the wiphy_lock .
> 
> During this search/replace the "if (!rtnl_locked)" check in brcmfmac/p2p.c
> was accidentally replaced with "if (locked)", dropping the inversion of
> the check. This causes the code to now call rtnl_lock() while already
> holding the lock, causing a deadlock.
> 
> Add back the "!" to the if-condition to fix this.

Ouch, sorry about that, and thanks for the fix!

johannes

