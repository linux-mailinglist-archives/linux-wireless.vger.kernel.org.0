Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46FF47A78B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 11:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhLTKCC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 05:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLTKCC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 05:02:02 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071F7C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 02:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=acER/jxD2dYeqtxBrweSWPe6DVMc51lEq/5660g8xSc=;
        t=1639994522; x=1641204122; b=kv8GWD6JXlyIv8wTS7HqWI0xip9+dEO5wvxYQ4k9Gb4y+fB
        05NbX5ypDEQ5VzBMDykNKWbKfEmesrGHG8VTQJDCQS0HGij0O9LzhJEKcOEdVP82jMJ14/D8kcfc6
        A0MAyT4skJ+XWhBAWAI9C1+u6f/ogv2v6Y/0gDuvOd/jnVsbXQWRXfsqD2PurV7RfJ3UZhuks32pq
        DkfePoSxc7EuxA45L3EFCctAs5V9NDQphOgLpdvmqQ49cyxgf5hZOb339lU0Mb7++DQ281t6mYQgP
        1rn5V6TzEMPgs3jwTArsCc6mAhjvwa/w7XZehanD0Qv0Yl32aI/THV22VEswmpjw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mzFUW-00E3Tk-AB;
        Mon, 20 Dec 2021 11:02:00 +0100
Message-ID: <59896f7e6382ddb34a63e78b489b2ded7bb1e980.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: disable BSS color collision detection in
 case of no free colors
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Lavanya Suresh <lavaks@codeaurora.org>
Date:   Mon, 20 Dec 2021 11:01:59 +0100
In-Reply-To: <1639307483-8055-1-git-send-email-quic_ramess@quicinc.com>
References: <1639307483-8055-1-git-send-email-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,


>  include/net/cfg80211.h |  28 +++++++------
>  net/mac80211/cfg.c     |  16 ++++++--
>  net/wireless/nl80211.c | 109 ++++++++++++++++++++++++-------------------------
>  3 files changed, 82 insertions(+), 71 deletions(-)
> 

This is now a fairly big cfg80211 change, and not much mac80211. Can you
please split it?

But you didn't really address why we need to do this via element change
detection, rather than letting hostapd do this via the
NL80211_ATTR_HE_BSS_COLOR attribute even in change_beacon?

johannes
