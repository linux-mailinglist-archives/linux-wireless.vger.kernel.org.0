Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD05E25A5A0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 08:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIBGhT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 02:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBGhT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 02:37:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74AC061244
        for <linux-wireless@vger.kernel.org>; Tue,  1 Sep 2020 23:37:19 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kDMOQ-00EZmB-Ik; Wed, 02 Sep 2020 08:37:14 +0200
Message-ID: <6ead6cbadacd476600fc80eb209681c219834aef.camel@sipsolutions.net>
Subject: Re: mac80211_hwsim crash
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 02 Sep 2020 08:36:58 +0200
In-Reply-To: <5252d41eae98ad26b0be91ec602da969ab8e7c8e.camel@gmail.com> (sfid-20200902_000333_211507_BFB2FC83)
References: <5252d41eae98ad26b0be91ec602da969ab8e7c8e.camel@gmail.com>
         (sfid-20200902_000333_211507_BFB2FC83)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-01 at 15:03 -0700, James Prestwood wrote:
> 
> [ 1335.541174] CPU: 0 PID: 982 Comm: hwsim Not tainted 5.8.0 #1
> [ 1335.553946] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.13.0-2.fc32 04/01/2014
> [ 1335.588370] RIP: 0010:hwsim_cloned_frame_received_nl+0x141/0x2c0

It'd help if you could run ./scripts/decode_stacktrace.sh or use gdb or
something like that.

johannes


