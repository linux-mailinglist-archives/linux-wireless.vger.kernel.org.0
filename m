Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E06F1784DF
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 22:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbgCCV2B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 16:28:01 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:34910 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbgCCV2B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 16:28:01 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j9F54-00DnIh-Pb; Tue, 03 Mar 2020 22:27:58 +0100
Message-ID: <8445336f5d71533acf17b6c53fcc88e7faeab3bf.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] nl80211: add monitor mode scan feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org
Date:   Tue, 03 Mar 2020 22:27:57 +0100
In-Reply-To: <20200303115017.9845-1-markus.theil@tu-ilmenau.de>
References: <20200303115017.9845-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-03 at 12:50 +0100, Markus Theil wrote:
> Back in 2007 "mac80211: don't allow scanning in monitor mode"
> (f27b62d3e7ec) disabled scanning in monitor mode, because hw
> controlled by the zd1211rw driver got confused during this operation.
> 
> Nevertheless, it can be useful to scan in monitor mode, e.g.
> when building a tool which processes scans, channel surveys and
> monitors the channel passively in monitor mode.

Hmm. I'm not really sure that this makes sense.

You're in monitor mode, so you won't get any scan processing as such
(you will not be able to use nl80211 to retrieve the results!), and
there will be a lot of confusion over sending probe requests (the code
now looks like it would in fact attempt to do so ... but how?).

johannes

