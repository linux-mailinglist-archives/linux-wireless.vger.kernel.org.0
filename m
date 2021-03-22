Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D412343D31
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Mar 2021 10:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCVJqr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Mar 2021 05:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhCVJqd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Mar 2021 05:46:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBCFC061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Mar 2021 02:46:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lOH8n-001foA-Gs; Mon, 22 Mar 2021 10:46:29 +0100
Message-ID: <e338e57075680c4a9e1323c7f4d6bfff1268d4e2.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: don't apply flow control on management frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     mbizon@freebox.fr, linux-wireless@vger.kernel.org
Date:   Mon, 22 Mar 2021 10:46:28 +0100
In-Reply-To: <5f037c3f8485a8c929548be6a153290ba9ae4f13.camel@freebox.fr>
References: <20210319232800.0e876c800866.Id2b66eb5a17f3869b776c39b5ca713272ea09d5d@changeid>
         <5f037c3f8485a8c929548be6a153290ba9ae4f13.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, 2021-03-22 at 10:43 +0100, Maxime Bizon wrote:
> > Short-circuit the processing of management frames. To keep the
> > impact minimal, only put them on the frags queue and check the
> > tid == management only for doing that and to skip the airtime
> > fairness checks, if applicable.
> 
> After your patch, what are the actual effects of HW_STA_MMPDU_TXQ and
> HW_BUFF_MMPDU_TXQ ?

Well, my patch doesn't change the effect of those significantly.

The idea for iwlwifi was that it doesn't actually like ->tx() to get
called, but much prefers a TXQ where the frame is, and then it can pull
it whenever it can transmit it.

This was the key requirement here, and it doesn't change: instead of
tx() getting called with the frames, the frames go to the TXQ instead
and wake_tx_queue() is called, and then the driver later pulls the
frames and pushes them to the hardware.

What does change is that management frames are no longer subject to
codel and inter-flow issues, and also note that the hash of a management
frame isn't actually well-defined.

johannes

