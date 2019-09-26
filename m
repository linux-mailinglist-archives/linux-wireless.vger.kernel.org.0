Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5C0BEAA0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 04:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfIZCdM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 22:33:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfIZCdL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 22:33:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 36CF96122D; Thu, 26 Sep 2019 02:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569465191;
        bh=Kn5XeDVTMK5lvLFi7xSrIIhJA3qP1OwTwlM7EIYMiZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oaoTRsByeJI0eJ2PgIYnSY6FAaCQvTguHzPe/O1nOJiqeSP2FQoFsG+gOSeCw+iq4
         m+6mjycwnzUrigMjLnmG+KveRIw/0MDIniTfc7i0vnkoq1+yEPj/Fbh5J+g678tCxa
         zM4wvJdT4Oh6UZe3JLWEjpbqN4eAh4S0V7V3epCc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9F94A60C72;
        Thu, 26 Sep 2019 02:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569465190;
        bh=Kn5XeDVTMK5lvLFi7xSrIIhJA3qP1OwTwlM7EIYMiZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nf9HPXjNtdUSHRXYSSzhJn6ALFXnDa3rR1KGWVb4lkfGRBtJoASkKq0V48uRvD51F
         0y9krXGuPCTOTwy0tifttti2F8iR9qv21gbc6i8Vuv+C6aunKAQHYlOYQ+fxFOTj3R
         HNzkXPDBHp/rYsX7HMsX5KFCHnjVMVOGE2qFmOec=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Sep 2019 10:33:10 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 0/8] ath10k: improve throughout of tcp/udp TX/RX of
 sdio
In-Reply-To: <11062c4e1659ac759cb73af7d46a6db2@codeaurora.org>
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
 <87sgon8inp.fsf@codeaurora.org>
 <11062c4e1659ac759cb73af7d46a6db2@codeaurora.org>
Message-ID: <7f5d822f2dd1f98ba26a8fdecb5dc011@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-24 20:32, Wen Gong wrote:
> On 2019-09-23 17:29, Kalle Valo wrote:
>> Wen Gong <wgong@codeaurora.org> writes:


patch v6 ath10k: improve throughout of RX of sdio has sent
new patch v6 only have 3 patches, the left patches will also sent later

Alagu Sankar (1):
   ath10k: enable RX bundle receive for sdio

Wen Gong (2):
   ath10k: change max RX bundle size from 8 to 32 for sdio
   ath10k: add workqueue for RX path of sdio

https://patchwork.kernel.org/patch/11160247/
https://patchwork.kernel.org/patch/11160245/
https://patchwork.kernel.org/patch/11160241/
