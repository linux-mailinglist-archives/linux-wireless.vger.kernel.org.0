Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52503E5815
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 12:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbhHJKPP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbhHJKPO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 06:15:14 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153BCC061798
        for <linux-wireless@vger.kernel.org>; Tue, 10 Aug 2021 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MRkyqAjudaPjK5MEKe1nWN6xUtd1nJUe4QcpBNSpDGo=; b=n9Ky1IdFAkLwVUwSjFcimJMKNr
        k8qzdAj4BufsThlKVVv5mGQ8MiVPLom5fPgVVyIwB6liwbB956RGEXzw3PrZfO2bAqGoxr/c+iaBy
        RKb14GVzJl8lM6WaUaZLsUiziI4LHjDpinhFn2k3Shmw88FgvKeBUQuRRt8fNi+Fr5yA=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mDOmU-0006mP-AH; Tue, 10 Aug 2021 12:14:46 +0200
Subject: Re: [PATCH v5 1/3] nl80211: Add support for beacon tx mode
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1628585783-21139-1-git-send-email-mkenna@codeaurora.org>
 <1628585783-21139-2-git-send-email-mkenna@codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <7eaa665c-7f9b-268c-5297-4d3851e10e43@nbd.name>
Date:   Tue, 10 Aug 2021 12:14:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1628585783-21139-2-git-send-email-mkenna@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-08-10 10:56, Maharaja Kennadyrajan wrote:
> User can configure the below beacon tx mode
> 1. Staggered mode and 2. Burst mode while bring-up the AP
> or MESH.
> 
> Beacons can be sent out in burst(continuously in a single shot
> one after another) or staggered (equally spread out over beacon
> interval) mode.
> 
> Set the beacon_tx_mode as 1 for Staggered mode and 2 for
> burst mode.
What's the advantage of one over the other? When and why would the user
choose a different mode other than the default?

- Felix
