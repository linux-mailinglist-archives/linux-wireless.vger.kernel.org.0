Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B208324F901
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 11:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgHXJkE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 05:40:04 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:15473 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729655AbgHXJkD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 05:40:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598262002; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/W60DV+q7apLS9fQPMek5ErShgRw9F/dCNveL9AWUOE=;
 b=Zn8GoZBsTXrFad3ffkKLJR3CkNdDV9AH/Z5T59iWIq1/79cKkjNN0EOocsZnwfOJSaUoGuob
 ZhHd/0vUHdrWRW41QwohIG84DTpTCPtHBouBk/TS6McpwdYkCTiI1e5yJBuHVTRu66yxn2z3
 mNr2ZepNQWreGJfZFlCUB0wApxA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f438af06704ba80965d41ef (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Aug 2020 09:40:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85EBAC433CA; Mon, 24 Aug 2020 09:39:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D42FC433C6;
        Mon, 24 Aug 2020 09:39:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Aug 2020 17:39:58 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath10k: add flag to protect napi operation to avoid
 dead loop hang for SDIO
In-Reply-To: <CABPxzYLjys+cXXRM5J680ZOs+6VrYt=_3rWv-gqkCod=-A1VrA@mail.gmail.com>
References: <1598243612-4627-1-git-send-email-wgong@codeaurora.org>
 <CABPxzYLjys+cXXRM5J680ZOs+6VrYt=_3rWv-gqkCod=-A1VrA@mail.gmail.com>
Message-ID: <fd98989a87f2a50655dc95bdcd535c0d@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-24 16:35, Krishna Chaitanya wrote:
> On Mon, Aug 24, 2020 at 10:03 AM Wen Gong <wgong@codeaurora.org> wrote:
>> 
>> It happened "Kernel panic - not syncing: hung_task: blocked tasks" 
>> when
>> test simulate crash and ifconfig down/rmmod meanwhile.
>> 
...
>> 
>>  #ifdef CONFIG_PM
> Even though your DUT is SDIO based we should be doing this in general
> for all, no?
> core_restart + hif_stop is common to all.
this patch does not have core_restart.
I dit not hit the issue for others bus(PCIe,SNOC...), so I can not 
change them with a
assumption they also have this issue.
