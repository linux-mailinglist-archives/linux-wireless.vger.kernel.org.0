Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09847279733
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Sep 2020 08:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgIZGLZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Sep 2020 02:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIZGLZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Sep 2020 02:11:25 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D01C0613CE
        for <linux-wireless@vger.kernel.org>; Fri, 25 Sep 2020 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5gwIJnnMXJba7wdPCTxp6TSFlUWgDShyecYwWjfec0o=; b=TKELmNf9HgYzuPC1fCwa5ij+bZ
        DSvAYwBDB1zFrJ6Ev0aSXJWGTphWOcCOEQChR5BFJl4QIZOGOrFvnALxvSEB/UX2cxdTrEnouZdlc
        +8afJTOhQxYHLXt+LGdaXxjmE9Ar+NK2PRZJcPZiSeuS2tcJpXt9HEuHuB8Z2HKhxWe0=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kM3QU-0006ch-QE; Sat, 26 Sep 2020 08:11:18 +0200
To:     Georgi Valkov <gvalkov@abv.bg>
Cc:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        openwrt-devel@lists.openwrt.org
References: <20200922102434.42727-1-nbd@nbd.name>
 <FD88F09D-5FEA-4A15-B586-95843830F737@abv.bg>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v2] mac80211: fix regression in sta connection monitor
Message-ID: <3762d906-31ff-8386-b9ea-d7b06ea07397@nbd.name>
Date:   Sat, 26 Sep 2020 08:11:17 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <FD88F09D-5FEA-4A15-B586-95843830F737@abv.bg>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi Georgi,

thanks for testing and for your insight into this issue.

On 2020-09-26 06:41, Georgi Valkov wrote:
> Hi Felix!
> 
> With your latest suggestion, it takes between 10 and 17 hours for the connection to drop, then long five minutes to reconnect.
> Notice the order of code execution in the original code of ieee80211_sta_tx_notify():
> probe_send_count is always cleared when ack is true. But before clearing probe_send_count, we need to check if ieee80211_is_any_nullfunc() returns true and probe_send_count > 0: if yes, we must call ieee80211_queue_work(). You cleared probe_send_count ahead of time, so the condition to run ieee80211_queue_work() will never be met.
The condition in ieee80211_sta_tx_notify may not be met, but
ieee80211_queue_work is called from ieee80211_tx_status_ext in that
case. Any idea why that is not enough?

> To spare your time, I did spend one week to find the cause, then another learning every detail about the code and testing various solutions, including those you proposed. While I do not have experience with mac80211’s design, I’m quite good at preserving the exact behaviour during large scale refactoring. And in my fix I tried changing as little as possible to keep the patch small, preserving both your changes and the original design behaviour.
And the reason I'm still proposing changes to it is because your patch
does not take into account no-skb or 802.3 tx status.
I'll try to make a v3 patch that leaves more of the original code intact
at the cost of a little more duplication.

- Felix
