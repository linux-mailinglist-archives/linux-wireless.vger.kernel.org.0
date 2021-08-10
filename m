Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448023E5999
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 14:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbhHJMFP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 08:05:15 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14299 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhHJMFP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 08:05:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628597093; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=w4YQaQH2LBKxBMptHGZhvdKN7L2B42qvUJiqZuTkJnQ=;
 b=LNJPVadVu4O6M7WYZVI8ba6QOjfbzSOa21vQBEFcpIaRL0X9FFdKcDnNiOOou98RQ0Se/mjN
 /3b8PTueGL+sJE7krwQOwrHR6uPeAIjxS1CTBbA9hb921ofJOLpfGZJjy9i674XZQUl6GT8T
 0aye4XwZHdY3DzoOI5RxaLb2PPU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61126ac891487ad520068350 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Aug 2021 12:02:16
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A0D2C433D3; Tue, 10 Aug 2021 12:02:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E492C433F1;
        Tue, 10 Aug 2021 12:02:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Aug 2021 17:32:15 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 1/3] nl80211: Add support for beacon tx mode
In-Reply-To: <7eaa665c-7f9b-268c-5297-4d3851e10e43@nbd.name>
References: <1628585783-21139-1-git-send-email-mkenna@codeaurora.org>
 <1628585783-21139-2-git-send-email-mkenna@codeaurora.org>
 <7eaa665c-7f9b-268c-5297-4d3851e10e43@nbd.name>
Message-ID: <f96e91618142c34172d12954f2f08ce9@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-10 15:44, Felix Fietkau wrote:
> On 2021-08-10 10:56, Maharaja Kennadyrajan wrote:
>> User can configure the below beacon tx mode
>> 1. Staggered mode and 2. Burst mode while bring-up the AP
>> or MESH.
>> 
>> Beacons can be sent out in burst(continuously in a single shot
>> one after another) or staggered (equally spread out over beacon
>> interval) mode.
>> 
>> Set the beacon_tx_mode as 1 for Staggered mode and 2 for
>> burst mode.
> What's the advantage of one over the other? When and why would the user
> choose a different mode other than the default?
> 
[Maha]: In the multi-vap scenario and default or staggered mode,
tx failure of the packets will happen if the packets duration
is greater than the beacon interval between the two vaps.
In case of burst mode it works, where during retry it transmits
the packet.
> - Felix
