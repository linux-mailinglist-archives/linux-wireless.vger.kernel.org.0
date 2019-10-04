Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C25CC322
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 20:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfJDS4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 14:56:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33674 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJDS4z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 14:56:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01D6560A0A; Fri,  4 Oct 2019 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570215414;
        bh=HddhwGwkCeWXSrQOE0ffx19+ae4C50NE2JNj4YM9ugg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lzefUBgE0PhGPUibXYpZiTua4u5DLXTFv2LEe5cEXOHvfpmujiljmw57uwXiSXSvj
         Qc6I/+2rKtzWAVdQhGwJeQNvbGuw/Egt9vxC5sLik5attnuC/WZA/qqUsXCAJOU+/A
         bjgQ8bpa7jEwZCdFOw2pSh6lPg9OcyNLghB2lOJM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8744760C5F;
        Fri,  4 Oct 2019 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570215411;
        bh=HddhwGwkCeWXSrQOE0ffx19+ae4C50NE2JNj4YM9ugg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dDQTCFGVlr5ubij2d+p0i3/3dU/rtNif/w2BzQP88xLgj9tpoC7kn+Mxrz04HXAon
         BitBHnQAnrEm0zetbeigHu96HoEN3Vqq9HT2Qc+eKWv/4OHiDTiNY0/Ib7FePrVFr/
         CVNIsnKtwdDf6fOxvCuthlB9i1VExI/EDpWYEHKo=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 04 Oct 2019 11:56:51 -0700
From:   Jeff Johnson <jjohnson@codeaurora.org>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 5/5] ath10k: pull_svc_rdy code-style fix
In-Reply-To: <CAKR_QVK=XwLtaGgoLeU5-+XQP_-jVvAdWfkGvdyV9WNK_5QUng@mail.gmail.com>
References: <1569268165-1639-1-git-send-email-pozega.tomislav@gmail.com>
 <1569268165-1639-5-git-send-email-pozega.tomislav@gmail.com>
 <87d0fq5kic.fsf@codeaurora.org>
 <CAKR_QVK=XwLtaGgoLeU5-+XQP_-jVvAdWfkGvdyV9WNK_5QUng@mail.gmail.com>
Message-ID: <998c7ce60b99865835f619dee86b301b@codeaurora.org>
X-Sender: jjohnson@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-24 00:49, Tom Psyborg wrote:
> On 24/09/2019, Kalle Valo <kvalo@codeaurora.org> wrote:
>> Tomislav Požega <pozega.tomislav@gmail.com> writes:
>> Actually I prefer the original style, so that we first check the data 
>> in
>> skb is valid and only then assign the data to ev.
>> 
>> --
>> Kalle Valo
>> 
> 
> It came to my mind that this might be the reason why the current
> driver did not give me warning about too short service ready event,
> but there was no warning about event length in either case.
> I even tested this with compat wireless from 2013. and there the
> situation was the opposite: in both cases there was warning about
> service ready length.

Hmmm, my understanding of the way the TLV WMI is supposed to work is 
that the individual data structures are extensible, and in the case 
where a data structure is received with a "short" length the recipient 
is supposed to zero-extend to the expected length, and then handle the 
"zeroed" field(s) appropriately. This is supposed to hold for both 
host=>firmware and firmware=>host. Since the wmi_service_ready_event has 
been extended over time this behavior is necessary in the case of a host 
built with the current format interfacing to a firmware built with an 
earlier version of the format. I'm not sure why ath10k isn't supporting 
this since the QTI "out of tree" driver (my area of focus) has that 
support.
