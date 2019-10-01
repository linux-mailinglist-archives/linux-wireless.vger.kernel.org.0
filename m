Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED049C31E4
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfJAK7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 06:59:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJAK7R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 06:59:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 21D936081C; Tue,  1 Oct 2019 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569927557;
        bh=iH+bHk9YNb+SDR51Y0QiL2vVXFJFJVavPQIC/mQurFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o6dR18Mdu/W8qaH17dL/VAkoObWjWEo0f1J6ApZBj5iimLL6VfUezvH/k5mVy5msg
         LQ/pTpdKFc08YuPKJ382+NbcnkJMNQrRelYePjQ4/rVIbSOr5HgzY8Tsry2+r14YLl
         Si1i5Tu8UDXWMWAbrLW0JnmEOWJwsqhyWtuT45iY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BB5DC6016D;
        Tue,  1 Oct 2019 10:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569927556;
        bh=iH+bHk9YNb+SDR51Y0QiL2vVXFJFJVavPQIC/mQurFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kNo3gg+2oDOUvpgKENR32dmJNKFUBzpq3371JrhvZNDfUFESgkaOkz1Ke+O00oMf5
         ZUruhwOnuJjDytDDHkLE7GxM4n4qosMh/KPEoOWipPNbt/OW6bPTuDUp9SfKmglTcn
         FPDVNHaaNmeY/8FdyAcnTdL0mAJ+QxRPz46DZYt4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Oct 2019 18:59:16 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V3 0/4] Enable virtual time-based airtime scheduler
 support on ath10k
In-Reply-To: <20985660fd0872db1511948bd42cd925cef13cee.camel@sipsolutions.net>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org>
 (sfid-20190923_092024_747005_B4B11EDF)
 <20985660fd0872db1511948bd42cd925cef13cee.camel@sipsolutions.net>
Message-ID: <e710a18d65ecaf2168a27556c85dada8@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-01 18:19, Johannes Berg wrote:
> On Mon, 2019-09-23 at 15:19 +0800, Yibo Zhao wrote:
>> This series fix some issues when enabling virtual time-based airtime 
>> scheduler on ath10k.
>> 
> Given the lengthy discussion here and also over in the related thread
> about AQL, I'm assuming you're going to repost this eventually.

Yes, will repost once Toke have updated "mac80211: Switch to a virtual 
time-based airtime scheduler" with his new ideas.
> 
> johannes

-- 
Yibo
