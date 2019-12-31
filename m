Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F105812D792
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2019 10:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfLaJho (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Dec 2019 04:37:44 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:16592 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbfLaJho (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Dec 2019 04:37:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577785064; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=y5y18m8BZe1GRBDlNusUsV0+XWeFRukqPLy2F+ycHek=;
 b=j+ySj4xQRifMFCHJvNWdqbxfkDxEcP3pmg55etbE+r/wxEmhfTFri5Tj4tOZRrsHW0NTNwDp
 +0+oGSe5nAUypxM0zz2ExjmYBif9u0W69RUrO//e+bTGnzZvT9ApKVEm9LlJcmfaMeloBsW0
 dcm7HxINLh6+/vAzdsaWwDP9sbU=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0b16e1.7f42fc4d8ed8-smtp-out-n03;
 Tue, 31 Dec 2019 09:37:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8DC87C447A0; Tue, 31 Dec 2019 09:37:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48411C43383;
        Tue, 31 Dec 2019 09:37:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Dec 2019 17:37:37 +0800
From:   wgong@codeaurora.org
To:     Justin Capella <justincapella@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ath10k: add refcount for ath10k_core_restart
In-Reply-To: <CAMrEMU-p3+HRZYW6TzXwZSwhxj9oJ9JW1Rg=ZysJ3fr0rm45Ng@mail.gmail.com>
References: <20191225120002.11163-1-wgong@codeaurora.org>
 <20191225120002.11163-2-wgong@codeaurora.org>
 <CAMrEMU-p3+HRZYW6TzXwZSwhxj9oJ9JW1Rg=ZysJ3fr0rm45Ng@mail.gmail.com>
Message-ID: <5f6eb95de0f877b86b90d0c32d458d43@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-25 23:14, Justin Capella wrote:
> This does not only effect SDIO.
> 
> Why a semaphore / count? Could the conf_mutex be held earlier, or
> perhaps change the state to ATH10K_STATE_RESTARTING first?
> ath10k_reconfig_complete is also called in mac.c when channel is 
> changed so
patch v2:
https://patchwork.kernel.org/patch/11313853/
https://patchwork.kernel.org/patch/11313859/
