Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173534DCC18
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 18:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiCQRKo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 13:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiCQRKn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 13:10:43 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E1D1126
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 10:09:26 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x205-20020a627cd6000000b004f6e1b97b45so3771913pfc.18
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:date:subject:from:to:cc;
        bh=G7nfCQp+1soHMDZ67O7N+rQ+xoQf+ezYH13/Wqbxtng=;
        b=qCj2CD0WZxeiLEv/v0qKs9eZsBP0uN/CTIOw3Udszmps5FkppTW0ucomxgYqH07IfQ
         uRWPPpMZzSJrfm/w0ClCApUo+J/xoZoSugtpT8DWUqmXoUYaQmN6bUB6zutarcmhQCLQ
         9dRwgT+RKYWP2CRoGfibTrCKCGPw6lk6ln9fCqlSSbsY2jtAi/N8C2jkWmsyRmZFIjDX
         3NwcBNPaBxisNL3zvyBTPw7SqwJVoS6yN+gJBZiI09P8MPdmTzW4VaoV6M1w2CxSZ/UV
         u0Z7rTWB1zwy5rsJWo5I+kSaZcbitmcidld6jxriZbOySXoFS5brrpDjWCHOkv7F2bgc
         tLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to:cc;
        bh=G7nfCQp+1soHMDZ67O7N+rQ+xoQf+ezYH13/Wqbxtng=;
        b=RklRrqyPIWRnuWAh69ti6zS7WXOenqXwy9sUHJXY5t0MbtJoXsU72WjebmtSm4p3ka
         6cgQ8038a0ae3R4sK1/06lapG9JCJnqdfkew2mIVBMICOywkxV4IB1DtVabtWKFuqmzh
         45SZhyKvUWXqb62nPSRYPYOju4M8kH21Se5vPHE73093ueeUM/1g4jr33wfGiXcf7djq
         02X9qQ1u+vm62bTKafORiLoKYZxDSmWRtyicbsHrFiqJ+jHFvHNlWawbyBvz5QReBa1z
         ogit7n31/TgBZK48z3EK0gQlWv3UO+MRXAvPUOWYRvDjeZuzJExnIF0d24hF8Ax1kMTz
         M4eA==
X-Gm-Message-State: AOAM531Va+L0KcZKSlYwidkL9cmgNo0Rp5zAR0X3qIiwFTtYpzOHPuuh
        dr2TBZJF7vAGAR0Uyu5YDVrJDvLt9dDHqgAUo54=
X-Google-Smtp-Source: ABdhPJxdqAhcXFIiWnpLLploDy9wku2R4P5OqBmEgTe2wbRNwTcLg63GVv4cYXp8TrWkEMD1HdWNaBoOovPcUdoRqAQ=
MIME-Version: 1.0
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a17:902:d482:b0:153:12b0:60b5 with
 SMTP id c2-20020a170902d48200b0015312b060b5mr6093103plg.105.1647536966081;
 Thu, 17 Mar 2022 10:09:26 -0700 (PDT)
Message-ID: <0000000000009e9b7105da6d1779@google.com>
Date:   Thu, 17 Mar 2022 17:09:26 +0000
Subject: [BUG] deadlock in nl80211_vendor_cmd
From:   <willmcvicker@google.com>
To:     Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I wanted to report a deadlock that I'm hitting as a result of the upstream
commit a05829a7222e ("cfg80211: avoid holding the RTNL when calling the
driver"). I'm using the Pixel 6 with downstream version of the 5.15 kernel,
but I'm pretty sure this will happen on the upstream tip-of-tree kernel as
well.

Basically, my wlan driver uses the wiphy_vendor_command ops to handle
a number of vendor specific operations. One of them in particular deletes
a cfg80211 interface. The deadlock happens when thread 1 tries to take the
RTNL lock before calling cfg80211_unregister_device() while thread 2 is
inside nl80211_pre_doit(), holding the RTNL lock, and waiting on
wiphy_lock().

Here is the call flow:

Thread 1:                         Thread 2:

nl80211_pre_doit():
  -> rtnl_lock()
                                      nl80211_pre_doit():
                                       -> rtnl_lock()
                                       -> <blocked by Thread 1>
  -> wiphy_lock()
  -> rtnl_unlock()
  -> <unblock Thread 1>
exit nl80211_pre_doit()
                                       <Thread 2 got the RTNL lock>
                                       -> wiphy_lock()
                                       -> <blocked by Thread 1>
nl80211_doit()
  -> nl80211_vendor_cmd()
      -> rtnl_lock() <DEADLOCK>
      -> cfg80211_unregister_device()
      -> rtnl_unlock()


To be complete, here are the kernel call traces when the deadlock occurs:

Thread 1 Call trace:
    <Take rtnl before calling cfg80211_unregister_device()>
    nl80211_vendor_cmd+0x210/0x218
    genl_rcv_msg+0x3ac/0x45c
    netlink_rcv_skb+0x130/0x168
    genl_rcv+0x38/0x54
    netlink_unicast_kernel+0xe4/0x1f4
    netlink_unicast+0x128/0x21c
    netlink_sendmsg+0x2d8/0x3d8

Thread 2 Call trace:
    <Take wiphy_lock>
    nl80211_pre_doit+0x1b0/0x250
    genl_rcv_msg+0x37c/0x45c
    netlink_rcv_skb+0x130/0x168
    genl_rcv+0x38/0x54
    netlink_unicast_kernel+0xe4/0x1f4
    netlink_unicast+0x128/0x21c
    netlink_sendmsg+0x2d8/0x3d8

I'm not an networking expert. So my main question is if I'm allowed to take
the RTNL lock inside the nl80211_vendor_cmd callbacks? If so, then
regardless of why I take it, we shouldn't be allowing this deadlock
situation, right?

I hope that helps explain the issue. Let me know if you need any more
details.

Thanks,
Will
