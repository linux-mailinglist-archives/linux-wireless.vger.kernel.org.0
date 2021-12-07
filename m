Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5178946BD88
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 15:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhLGO1w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 09:27:52 -0500
Received: from tynnyri.adurom.net ([51.15.11.48]:56512 "EHLO
        tynnyri.adurom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhLGO1w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 09:27:52 -0500
X-Greylist: delayed 1482 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2021 09:27:51 EST
Received: from localhost ([::1] helo=tynnyri.adurom.net)
        by tynnyri.adurom.net with esmtp (Exim 4.92)
        (envelope-from <kvalo@adurom.com>)
        id 1muazg-0005zN-N1; Tue, 07 Dec 2021 15:59:03 +0200
From:   Kalle Valo <kvalo@adurom.com>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 03/12] iwlwifi: properly support 4-bit MAC step
References: <20211204063555.769822-1-luca@coelho.fi>
        <iwlwifi.20211204083238.64d2ea8b61f2.Ia5287e37fb3439d805336837361f6491f958e465@changeid>
        <87a6hcttpu.fsf@codeaurora.org>
        <f82d3481495a371aaa993b73598f36869a014976.camel@coelho.fi>
Date:   Tue, 07 Dec 2021 15:58:56 +0200
In-Reply-To: <f82d3481495a371aaa993b73598f36869a014976.camel@coelho.fi> (Luca
        Coelho's message of "Tue, 07 Dec 2021 15:49:19 +0200")
Message-ID: <87k0ggo6sf.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam_score: -2.9
X-Spam_bar: --
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Tue, 2021-12-07 at 15:44 +0200, Kalle Valo wrote:
>> Luca Coelho <luca@coelho.fi> writes:
>> 
>> > From: Mike Golant <michael.golant@intel.com>
>> > 
>> > Properly support 4-bit MAC step by refactoring all the current
>> > handling of the MAC step/dash.
>> 
>> What is 4-bit MAC step?
>
> Maybe a bit bad wording.  We have a MAC component (which is inside the
> SoC) and it has several different HW steps.  3 bits used to be enough
> but now we need 4-bits to represent all the different steps.
>
> Do you want me to reword the commit message?

Yeah, please add what you wrote above to the commit log so that people
outside Intel understand what this is about.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
