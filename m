Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5641CF272A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 06:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfKGFfj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 00:35:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfKGFfj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 00:35:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F1295607C6; Thu,  7 Nov 2019 05:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573104938;
        bh=26ykYDqmtDxoAycqng84TtKK+rxROkJb5Fp3DS74CAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Isxu0JSfBqjsviah5iXwttdM53JQlBRv/6yxrb8qNCPBhzzlldJZ5FtteEJLJzx5W
         vBCc8RsTGRh5Al78XILMlMIN5s9V5VfNhRPfIuqrMC1dIhzSHhXE7XHu5Ud4GyR5nL
         nrciUp4BZa78+MsZ8sQYAY6qY2p+sIwAQGDpL0kc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9343060610;
        Thu,  7 Nov 2019 05:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573104937;
        bh=26ykYDqmtDxoAycqng84TtKK+rxROkJb5Fp3DS74CAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cCwpznkRQ5/Zv7Qkqg3WBYpCSW08sWxTbvIpnQah1dSf/zhf9mIV5uGCCpkSamQ1F
         H8geSjEaxHEGsebTgueiwnpM66O5ChsN9Pylf1aM0pAOUnInNne8OyEjoj1LRZMUe+
         vARkRwkiqUGXy5Xy28KbD/eZU145Tovcx0afL0aM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Nov 2019 13:35:37 +0800
From:   zhichen@codeaurora.org
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
In-Reply-To: <CAKR_QVL9QLE72y0HBD_miLYAD4qx73u3FK33=oNCHp_S8H6JOw@mail.gmail.com>
References: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
 <CAKR_QVLDFBVMDDP4mPYVNdpT9TA3podNeQMpVJQwE7A5eG=0kA@mail.gmail.com>
 <9bb484b94c43f7c9aa08345ad89d7b2c@codeaurora.org>
 <CAKR_QVL9QLE72y0HBD_miLYAD4qx73u3FK33=oNCHp_S8H6JOw@mail.gmail.com>
Message-ID: <a60168b26275f4400434e72fabac244b@codeaurora.org>
X-Sender: zhichen@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-11-06 18:01, Tom Psyborg wrote:
> On 30/10/2019, zhichen@codeaurora.org <zhichen@codeaurora.org> wrote:
>> On 2019-10-22 18:07, Tom Psyborg wrote:
>> 
>>> What about main and 10x firmware branch?
>> 
>> There is no code changes in firmware. It's a configuration change of
>> host memory access.
>> 
>> Zhi
>> 
> 
> Please change it for main and 10x branch too. Dumping hw1.0 regs with
> QCA driver shows DMA burst value set to 1

Looks some old chips have different definitions of DMA burst size. We 
are discussing internally to change it for 10.4 only because we only 
tested 10.4.  On the other hand we are waiting for HW team to explain 
the differences.

Zhi
