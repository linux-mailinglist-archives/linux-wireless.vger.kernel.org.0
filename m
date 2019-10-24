Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58A8E3144
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 13:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfJXLrr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 07:47:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40760 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfJXLrr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 07:47:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A579560FA9; Thu, 24 Oct 2019 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571917666;
        bh=LfGiwVxrMzUStWIoM2oBebXlGcBXWkl0A8nDI7xnslg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E13VwwwLrN5VNZ/Vnp9mQPhOOHN91m5Uq45ahgnyZJJ8mxQKhxYUFqwOhrKX6xlna
         7Fa1d0YnsLLKz+MTJ1EmGYDoFGTO0rA5KR380LpNFC4AljT8i5tkgtVesAsJeMUUsf
         uSLW86A56zouCTQ16ArjB4Q3KCiRVpdzuB4ra6qE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 32EBB60DA6;
        Thu, 24 Oct 2019 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571917666;
        bh=LfGiwVxrMzUStWIoM2oBebXlGcBXWkl0A8nDI7xnslg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E13VwwwLrN5VNZ/Vnp9mQPhOOHN91m5Uq45ahgnyZJJ8mxQKhxYUFqwOhrKX6xlna
         7Fa1d0YnsLLKz+MTJ1EmGYDoFGTO0rA5KR380LpNFC4AljT8i5tkgtVesAsJeMUUsf
         uSLW86A56zouCTQ16ArjB4Q3KCiRVpdzuB4ra6qE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 17:17:46 +0530
From:   Govind Singh <govinds@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: bindings: add dt entry flag to skip SCM call for
 msa region
In-Reply-To: <87a79qk431.fsf@codeaurora.org>
References: <20191023094014.28683-1-govinds@codeaurora.org>
 <20191023094014.28683-2-govinds@codeaurora.org>
 <87a79qk431.fsf@codeaurora.org>
Message-ID: <94b02ec85c272d9d195572c40fcc3c09@codeaurora.org>
X-Sender: govinds@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 2019-10-24 12:44, Kalle Valo wrote:
> Govind Singh <govinds@codeaurora.org> writes:
> 
>> Add boolean context flag to disable SCM call for statically
>> mapped msa region.
>> 
>> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> 
> Oddly this didn't apply, but 3-way merge did work. Please double check
> the result in the pending branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=6f308524cf602ed9a0dbb0b0b50ba625b9091879

Change looks good to me.


BR,
Govind
