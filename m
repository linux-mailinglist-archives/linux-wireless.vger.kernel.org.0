Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFFF3DB6D2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jul 2021 12:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbhG3KGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Jul 2021 06:06:16 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34394 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238370AbhG3KGP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Jul 2021 06:06:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627639571; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jf9fsBbuEZby6oMpl/uX07+OTMiKf9yOt0Zn5mriWOY=;
 b=S7p9JgLJVC6+HPCNSZUhhBH0WTysyiRrlCoFA56jc5FykQXx0ww20wKPKFU4qRhvReiZ3mPI
 +raQkiuc+9cnadL5ke8LLt6Wy6fMLP/Arxd0mO7NSdFqFeu9l0xNQ+lPOOL0FSpaoEUUTEqU
 HPpL9EjXAo6ziJS16Q9NeJthYuA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6103cf08e81205dd0a4c4cc5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Jul 2021 10:06:00
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B3E76C43144; Fri, 30 Jul 2021 10:06:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51C3FC4360C;
        Fri, 30 Jul 2021 10:06:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 30 Jul 2021 18:06:00 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 5/9] cfg80211: save power spectral density(psd) of
 regulatory rule
In-Reply-To: <4647af4472b14452347a0817c25c3f61d174bf5e.camel@sipsolutions.net>
References: <20210517201932.8860-1-wgong@codeaurora.org>
 <20210517201932.8860-6-wgong@codeaurora.org>
 (sfid-20210517_222029_223410_9F039F8A)
 <4647af4472b14452347a0817c25c3f61d174bf5e.camel@sipsolutions.net>
Message-ID: <b405fd6772b6ca1333230128335b8b38@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-07-23 17:27, Johannes Berg wrote:
> On Mon, 2021-05-17 at 16:19 -0400, Wen Gong wrote:
>> The power spectral density(psd) of regulatory rule should be take
>> effect to the channels. This patch is to save the values to the
>> channel which has psd value.
> 
> It seems to me you should also add provisions to allow regdb file from
> userspace to have the PSD value?
> 
> johannes
This can be added in future.
Also anyone who need the interface can add it :)
