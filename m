Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0C835710E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbhDGPvf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353883AbhDGPvZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 11:51:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A532C06175F
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 08:51:15 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUASQ-008ckl-R4; Wed, 07 Apr 2021 17:51:06 +0200
Message-ID: <043656c28804db4f8c3dfc9eae5a599ac3a357c7.camel@sipsolutions.net>
Subject: Re: [PATCH] net: wireless: convert WARN_ON() to pr_warn() in
 cfg80211_sme_connect
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Du Cheng <ducheng2@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-wireless@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+5f9392825de654244975@syzkaller.appspotmail.com
Date:   Wed, 07 Apr 2021 17:51:05 +0200
In-Reply-To: <YG3UGW+rLM52/t2V@carbon> (sfid-20210407_174743_958166_F348F0E2)
References: <20210407021903.384158-1-ducheng2@gmail.com>
         <YG1JDsaRpws1FkzI@kroah.com> <YG3UGW+rLM52/t2V@carbon>
         (sfid-20210407_174743_958166_F348F0E2)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> I have spent some time to understand the netlink subsystem as a IPC mechanism.
> What I have now is a reliable sequence of steps to reproduce the crash, by
> condensing the syzkaller C reproducer:
> [link to reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=1414c997900000]
> 
> * hwsim80211_create_device (sendmsg: HWSIM_CMD_NEW_RADIO)
> * nl80211_set_interface (sendmsg: NL80211_CMD_SET_INTERFACE)
> * set_interface_state (ioctl: SIOCSIFFLAGS)
> * nl80211_join_ibss (sendmsg: NL80211_CMD_JOIN_IBSS)
> * sendmsg: NL80211_CMD_SET_INTERFACE
> * 1st sendmsg: NL80211_CMD_CONNECT
> * 2nd sendmsg: NL80211_CMD_CONNECT <- this triggers the WARN_ON(wdev->conn)
> * (if kernel not panic yet) more sendmsg: NL80211_CMD_CONNECT ...
> 
> If the code skips WARN_ON() and instead returns -EINPROGRESS, user application
> will receive error from the following recv(sock, ...). User application can hence
> choose to handle this error accordingly while kernel soldiers on without panicking.
> 
> If dev_warn() is added, for every subsequent NL80211_CMD_CONNECT, the console is
> flooded with the printout.
> 
> Maybe it is ok to silently return -EINPROGRESS for the 2nd NL80211_CMD_CONNECT
> and beyond.
> 

Yeah, I think the right thing to do is to just drop the WARN_ON
entirely. In fact, I can't really seem to figure out now why it was
added there (even if I probably did that myself), nothing else seems to
prevent getting to this code path multiple times directly one after
another.

johannes

