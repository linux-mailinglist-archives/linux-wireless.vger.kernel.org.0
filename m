Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D82FCFE14
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 17:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfJHPtF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 11:49:05 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:41988 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfJHPtE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 11:49:04 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iHrjS-00038n-WA; Tue, 08 Oct 2019 17:49:03 +0200
Message-ID: <764782a00ba58b895add84ca87cc42db491c4e17.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 08 Oct 2019 17:49:02 +0200
In-Reply-To: <2cf6ce4c-e9b7-9927-0f6f-52433ab3c66b@gmail.com> (sfid-20191008_173841_311495_63A9CFAA)
References: <20190913195908.7871-1-prestwoj@gmail.com>
         <20190913195908.7871-2-prestwoj@gmail.com>
         <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
         <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
         <fa09d946e85a637d7b49e208714945dcbcc23f76.camel@sipsolutions.net>
         <2cf6ce4c-e9b7-9927-0f6f-52433ab3c66b@gmail.com>
         (sfid-20191008_173841_311495_63A9CFAA)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> I concur that scanning should be checked as
> if (sdata->local->scanning).  So Johannes you're right that the polarity 
> is reversed.  However, __ieee80211_start_scan seems to check for 
> local->scan_req instead to take deferred scans into account.  So I 
> wonder if that is a better approach.

Hmm. I don't think it's necessary.

We basically only get to that kind of state if ieee80211_can_scan()
returned false - then we assign local->scan_req and defer until
ieee80211_run_deferred_scan() is called.

But in the meantime, nothing in the scan requests references the MAC
address.

It does mean that we should grab local->mtx though for these checks, and
then all around the interface change, so that we can be sure we don't
actually start scanning in the middle of the changes here.

johannes

