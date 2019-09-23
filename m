Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45172BB29C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 13:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393188AbfIWLHJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 07:07:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51862 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393136AbfIWLHJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 07:07:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5C6C5601D4; Mon, 23 Sep 2019 11:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569236828;
        bh=5w4p+WkGhNuqALfdt08qtRD6ACq41am2Wjdpc1pa590=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QiIsZadxxVC4Xje7qCX/z5fp5fSJky1x1mSLBvTX8lMYNzcydVrnB8I6MxGnPbjCF
         gHVwAW2XuL6CbENlQHi9Qyj/AVkHMM1PiMYmwTJzqVFfcO1Gr1q1Kx6c7Xlkb+wRqt
         wX4sKd0QK4nAVZLMeEXUJrplOTJA6dvq5d6HHINI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0307A6021C;
        Mon, 23 Sep 2019 11:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569236828;
        bh=5w4p+WkGhNuqALfdt08qtRD6ACq41am2Wjdpc1pa590=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QiIsZadxxVC4Xje7qCX/z5fp5fSJky1x1mSLBvTX8lMYNzcydVrnB8I6MxGnPbjCF
         gHVwAW2XuL6CbENlQHi9Qyj/AVkHMM1PiMYmwTJzqVFfcO1Gr1q1Kx6c7Xlkb+wRqt
         wX4sKd0QK4nAVZLMeEXUJrplOTJA6dvq5d6HHINI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Sep 2019 19:07:07 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: add fw coredump for sdio when firmware assert
In-Reply-To: <878sqhc25h.fsf@codeaurora.org>
References: <1567132338-7407-1-git-send-email-wgong@codeaurora.org>
 <878sqhc25h.fsf@codeaurora.org>
Message-ID: <706142499b2f13de278262f3c52c2047@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-21 19:35, Kalle Valo wrote:
> 
> The commit log tells nothing about fast, it should always document the
> design decisions. Why this fast dump, what's the benefit? Why not 
> always
> use the fast dump and forget the slow dump (or vice versa)? There needs
> to be really good reasons to have all this complexity to support both
> slow and fast dumps.
fastdump is new added in fimrware of sdio, so if it is use old firmeare, 
then it will
not support fastdump, then it need to use slow dump type.
it is to compatibility for old/new version firmware.
> 
>> +	ath10k_err(ar, "check fw reg : %x\n", param);
>> +}
> 
> This is a debug message, not an error. And debug messages should use
> format "sdio hi_option_flag2 %x\n".
