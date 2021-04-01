Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7751135195C
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Apr 2021 20:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhDARxC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Apr 2021 13:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbhDARrM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Apr 2021 13:47:12 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A704C03114B
        for <linux-wireless@vger.kernel.org>; Thu,  1 Apr 2021 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NsWTNB0+vljiTVhpT7XopXbq3xQdRf2JnOJz4xm977E=; b=fVgN44m19DWTq7MzZ5CqgftEtk
        M3BlAur/YAKbJF5bbeaRoxkBOQ4K47JTr+FPCcfBBFqL+TT0WipsZtyCtDYRAqJ84lDu736c1gPip
        6C5ctFm0KtWzWLRZ6fJeP5UPxmiqqKfB1hJERVlpfMM09s10QjniLGu9OcUqIWXIjld4=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lS0Py-0002Ao-FG; Thu, 01 Apr 2021 18:43:38 +0200
Subject: Re: [PATCH] mac80211: fix time-is-after bug in mlme.
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
References: <20210330230749.14097-1-greearb@candelatech.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <1b60f9ab-6605-d595-acce-51c5cee41871@nbd.name>
Date:   Thu, 1 Apr 2021 18:43:35 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330230749.14097-1-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-03-31 01:07, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> This fixes commit:  mac80211: optimize station connection monitor
> which came in in the 5.10 kernel.
> 
> This incorrect timeout check caused probing to happen when it did
> not need to happen.  This in turn caused tx performance drop
> for around 5 seconds in ath10k-ct driver.  Possibly that tx drop
> is due to a secondary issue, but fixing the probe to not happen
> when traffic is running fixes the symptom.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
Acked-by: Felix Fietkau <nbd@nbd.name>

- Felix
