Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845B730480D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 20:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbhAZFwS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 00:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbhAYJpv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 04:45:51 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8198C061354
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 01:44:23 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l3yPn-00BMyh-1x; Mon, 25 Jan 2021 10:44:07 +0100
Message-ID: <768b8297801ed3987d97efd6d55ed6a9ad1c7598.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: Save the regulatory domain with a lock
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hans de Goede <hdegoede@redhat.com>, Luca Coelho <luca@coelho.fi>,
        "Peer, Ilan" <ilan.peer@intel.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 25 Jan 2021 10:43:50 +0100
In-Reply-To: <d839ab62-e4bc-56f0-d861-f172bf19c4b3@redhat.com>
References: <iwlwifi.20210105165657.613e9a876829.Ia38d27dbebea28bf9c56d70691d243186ede70e7@changeid>
         <d839ab62-e4bc-56f0-d861-f172bf19c4b3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Hans,

> So I'm afraid that I have some bad news about this patch, it fixes
> the RCU warning which I reported:

Uh. Just spoke with Ilan and we realized this was the staging driver,
doing things the wrong way.

Could you test this?

https://p.sipsolutions.net/235c352b8ae5db88.txt

johannes

