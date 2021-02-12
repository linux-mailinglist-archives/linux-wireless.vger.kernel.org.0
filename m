Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2030F319C3E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 11:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhBLKAa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 05:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhBLKA1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 05:00:27 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5578C06178A
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 01:59:42 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lAVEj-001nc4-4c; Fri, 12 Feb 2021 10:59:41 +0100
Message-ID: <f3d282b396e0756c89230b08b13cb9f8c7234484.camel@sipsolutions.net>
Subject: Re: [PATCH V7 0/4] mac80211: add multiple bssid support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 12 Feb 2021 10:59:40 +0100
In-Reply-To: <c3b48c141c763e0cc1beb74482cd0bb4fbc546aa.camel@sipsolutions.net>
References: <20210120005120.32424-1-alokad@codeaurora.org>
         (sfid-20210120_015542_749517_52354F67) <c3b48c141c763e0cc1beb74482cd0bb4fbc546aa.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-02-12 at 10:59 +0100, Johannes Berg wrote:
> Hi,
> 
> > John Crispin (4):
> >   nl80211: add basic multiple bssid support


And since I rebased that already - here's a copy:

https://p.sipsolutions.net/59ffc0425476edfe.txt

johannes

