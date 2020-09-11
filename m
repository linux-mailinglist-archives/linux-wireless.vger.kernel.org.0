Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21B2669B8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 22:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgIKUpd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 16:45:33 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:55518
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbgIKUpZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 16:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599857124;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=GsgOsneOwnmBmII1UmWpvxkwmpL3MLGfND7lHyBDtWk=;
        b=j1XVhZEJdKX6lx7XmUyz5YhTnW3y7eGh3YUHCQkoWiug5cvM1htLFeL6hfY+BFI+
        W9SU5BxdffnTyFVguB8TanY0C3mSMSDWWQtM5mh74RzaCvQgNamXqBHZ9FyvSQib9ig
        uR04TxVOjk6Xmr7e4LdMbYWnqjzP/5IxaMRcxfNk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599857124;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=GsgOsneOwnmBmII1UmWpvxkwmpL3MLGfND7lHyBDtWk=;
        b=bK+xFS/ZuFX8ymapuzxAHtygi/ohire5wZKiYbPucOV4BseUGzisd4+w1RHoTDHZ
        wv78Ut355VvwzeIGYfz9d62kgX4ho6FbfLZfJMw6npMgj5RI6Nfw4sau2PTL+9db0eS
        j08GUb/S4mdZPdfgebJcNkP2BvRpgWMxpMRaJm14=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Sep 2020 20:45:24 +0000
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [RFC] mac80211: Add radiotap channel flag option for 6GHz band
In-Reply-To: <5225561f9f5c104bc84ab6e7f183de0ab5e0ea6d.camel@sipsolutions.net>
References: <010101747ee4b985-86863ec8-33e2-4f78-9d9b-93110bfa29fc-000000@us-west-2.amazonses.com>
 <5225561f9f5c104bc84ab6e7f183de0ab5e0ea6d.camel@sipsolutions.net>
Message-ID: <010101747eea64fa-83d17384-b161-40d6-8b9d-9dd3bbbe89b4-000000@us-west-2.amazonses.com>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-11 13:39, Johannes Berg wrote:
> On Fri, 2020-09-11 at 20:39 +0000, Aloka Dixit wrote:
>> Radiotap header needs a new channel flag for 6GHz packets.
>> This change uses value 0x200 for new enum balue for 6GHz which was
>> previously used for passsive scan flag but has since been removed.
> 
> You can't just add to radiotap in a kernel patch ...
> 
> But also, just today I replied elsewhere saying that we don't really
> need a flag at all?
> 
> johannes

Somehow your reply to other patch didn't show up on the patchwork, don't 
know why :-)
What do you mean by we cannot add to radiotap in a kernel patch?
Thanks.
