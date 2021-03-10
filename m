Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4E7334702
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 19:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhCJSnT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 13:43:19 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:17889 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhCJSnN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 13:43:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615401793; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=zWdA1/qwcLwTHVILF0u8OCFo2xoTuL1GRG3lSJyRzSk=;
 b=XD+NqqnVVdrCDhozNk3+Am6x7nq9uQyOY1izXPDqy9QOLOI2FER04iNz204xQ1yFa0mFn+8l
 yW6JmE/PS6gfWNtiHDMxwvcYUInB3TRSp2/5E1t6rm7TISdRxCP8YkRnIBNXH+StS/2RzJww
 XI9l5rgah+un89msybuEri3aozE=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 604913310c7cf0f56ce4ae59 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Mar 2021 18:42:57
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41111C433C6; Wed, 10 Mar 2021 18:42:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5BD5EC433CA;
        Wed, 10 Mar 2021 18:42:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Mar 2021 10:42:55 -0800
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH V5 1/2] ath11k: add WMI calls to manually
 add/del/pause/resume TWT dialogs
In-Reply-To: <20210309105025.72246C43462@smtp.codeaurora.org>
References: <20210222192651.1782-2-alokad@codeaurora.org>
 <20210309105025.72246C43462@smtp.codeaurora.org>
Message-ID: <347ccb1006ce48ff6da270560c867c06@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-03-09 02:50, Kalle Valo wrote:
> Aloka Dixit <alokad@codeaurora.org> wrote:
> 
>> These calls are used for debugging and will be required for WFA
>> certification tests.
>> 
>> Signed-off-by: John Crispin <john@phrozen.org>
>> Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
>> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> 
> This patchset had new warnings:
> 
> drivers/net/wireless/ath/ath11k/debugfs.c:16:15: warning: symbol
> 'debugfs_ath11k' was not declared. Should it be static?

This patch-set doesn't add any reference to 'debugfs_ath11k', so
don't know why this warning came up.

> drivers/net/wireless/ath/ath11k/wmi.c:7143: char * array declaration
> might be better as static const
Will remove this array as per your other comment regarding
adding a helper function.
