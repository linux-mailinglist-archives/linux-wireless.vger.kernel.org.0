Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A01273DD1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgIVI4R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 04:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIVI4R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 04:56:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42D6C061755
        for <linux-wireless@vger.kernel.org>; Tue, 22 Sep 2020 01:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kESNWF1ZBvp7P9WcL2yM/4SksmAQ+lF3sr0+wy7IryE=; b=R4YMkzq5SKdew6eFd1lfdCoUHf
        T9e4iiYsHW3PDihwVBYzkuAOr3GVlPBxPy+7IfEZXFCUO3ilcOSVmucoFo/5HnDlJDzJN9hB1hd3F
        3o/YHoiwgnvwkdEJnpXJ1vwv1jVjGZgSj8/rhJMXKwChOwTgutjGhEWBmRMf4ef63adk=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kKe5t-0000Fg-Kb; Tue, 22 Sep 2020 10:56:13 +0200
To:     Georgi Valkov <gvalkov@abv.bg>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        openwrt-devel@lists.openwrt.org
References: <20200921154545.91971-1-nbd@nbd.name>
 <7A099B27-5278-4D2A-91A1-6B795CB0E221@abv.bg>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] mac80211: fix regression in sta connection monitor
Message-ID: <099b1679-87c4-1ac5-978b-a1110db93f54@nbd.name>
Date:   Tue, 22 Sep 2020 10:56:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <7A099B27-5278-4D2A-91A1-6B795CB0E221@abv.bg>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-22 09:28, Georgi Valkov wrote:
> Hi Felix!
> 
> In the original code before the regression, as well as in the fix I
> proposed, probe_send_count was always reset if ack is true, while in
> your fix it will not be reset when non-null frames are received. The
> connection failed again after 10 hours and the STA remained offline for
> two minutes instead of two seconds. I should also note that I spent
> multiple days testing the fix I proposed and I had no disconnects.
> Please revise your fix again!
Thanks for the info. Handling non-null frames in that function is
incomplete, because it does not cover the 802.3 tx status path.
I'll make v2 patch that checks the timestamp of the last ACK in
ieee80211_sta_work instead.

- Felix
