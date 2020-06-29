Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2C120D81B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 22:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgF2Tfs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 15:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733188AbgF2Tfo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 15:35:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79560C03E979
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 12:35:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jpzZ7-00ELy0-CN; Mon, 29 Jun 2020 21:35:41 +0200
Message-ID: <99ae192566a7c5ae91c6ee92b8c4ddb41a29e34e.camel@sipsolutions.net>
Subject: Re: RFC: Remote Off-Channel CAC for DFS
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>,
        linux-wireless@vger.kernel.org
Date:   Mon, 29 Jun 2020 21:35:40 +0200
In-Reply-To: <c49513d5-9da7-5545-02e1-ff368f9f6961@tu-ilmenau.de> (sfid-20200629_203549_647727_9A89A56D)
References: <c49513d5-9da7-5545-02e1-ff368f9f6961@tu-ilmenau.de>
         (sfid-20200629_203549_647727_9A89A56D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, 2020-06-29 at 19:40 +0200, Markus Theil wrote:
> When using DFS channels, it would be nice, if I could dedicate a small
> amount of interfaces only to CAC checking channels and set them
> available or unavailable on multiple other remote APs/Mesh Points in
> order to use them, when switching to lower utilized channels without
> going through a full CAC.
> 
> Whats the opinion on the mailing list about adding a new command to
> nl80211 in order to set the DFS state of a currently not used channel
> after a Off-Channel CAC on another device nearby, but not on the same
> host? The parameters would roughly be the same as for a channel switch
> and an additional DFS channel state. Internally, I would trigger the DFS
> state sync code between multiple interfaces.

But wait, don't we already sync this within the kernel?

johannes

