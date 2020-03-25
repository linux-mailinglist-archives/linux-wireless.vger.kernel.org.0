Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19336192B8A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 15:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgCYOxt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 10:53:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32848 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYOxt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 10:53:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so3549479wrd.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2020 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=KV0TZCjWWTeWjmW9AXwA1pkwpWe1fDh8FQHa+37H9Vo=;
        b=MWAVIOL/BLIT0DJsSBq3RN75zT41s9bRIfA+zSJFIwTxL+Tg5ulf/KCeifvTDcNRc5
         jvM0ver5iYEndGOhdMnoQ6+6V2RGNtv8ntJf21Pql8rta/m26c8mlzMLDYoj+24xrsZm
         Nue+dVVSU6Zqzu2ORVl37ZKmIgw8pVd79HbSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=KV0TZCjWWTeWjmW9AXwA1pkwpWe1fDh8FQHa+37H9Vo=;
        b=SHzQzAuZ4kjOm2W/4Wxnf7R0diMQPfkaQcqZ7w0oCMVl+gldjSd/DTjvyD/SO4CnYq
         uzyQv9xk9G/PmsmBxVAD2QPx2eyRNVFzCmEVGAKNNyPVsCabYwDaqwjAulOUsTv+dZQa
         /jK1+TO+w8rCtW2Cz058i5Tsvxd32rIl3iMbdeSqLjBaTrSiyLabgowN72hsxe6n7iv/
         zz+15fVVMhyBB1l95atlKmZTubSHZAcgyE0JZ2UW17nv979Sx4+op4WMZH/RORArxA4b
         4LMEQDRH81JimQtSAiyclp3u2peNCyt4qFJDxX+SsUcN29RXfQ4jk1R8pG94uTdds/AE
         lE4g==
X-Gm-Message-State: ANhLgQ1/A1MiyLGmcOxIe7CA70z2ltk3EUFtdGlCdlk4T8pJYBDbkacu
        7eg7Cj98QLodk31d8mwPQLI0kQ==
X-Google-Smtp-Source: ADFU+vvAhGDH99ahq3WM92YZ31JF1yO0v8RSHE/7eJLVBlSdC3h1Eb6prV6ADW64et3HxkO3pB52Qg==
X-Received: by 2002:adf:82c5:: with SMTP id 63mr896631wrc.312.1585148027153;
        Wed, 25 Mar 2020 07:53:47 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id a13sm34746294wrh.80.2020.03.25.07.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:53:45 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Tejun Heo <tj@kernel.org>, Wright Feng <wright.feng@cypress.com>
CC:     <franky.lin@broadcom.com>, <hante.meuleman@broadcom.com>,
        <kvalo@codeaurora.org>, <chi-hsien.lin@cypress.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>
Date:   Wed, 25 Mar 2020 15:53:43 +0100
Message-ID: <171122f50d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20200325140814.GI162390@mtj.duckdns.org>
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-4-git-send-email-wright.feng@cypress.com>
 <40e33702-d37f-085d-a5a7-7f09ae9e2629@broadcom.com>
 <241fd81b-a252-ed86-b93e-6796cf1bce23@cypress.com>
 <20200324182358.GD162390@mtj.duckdns.org>
 <02b42d9f-7ba3-bb7e-36a6-5e141d37d75d@cypress.com>
 <20200325140814.GI162390@mtj.duckdns.org>
User-Agent: AquaMail/1.23.0-1556 (build: 102300002)
Subject: Re: [PATCH 3/3] brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a module parameter
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On March 25, 2020 3:08:18 PM Tejun Heo <tj@kernel.org> wrote:

> On Wed, Mar 25, 2020 at 12:29:44PM +0800, Wright Feng wrote:
>> If that's incorrect, would you please give me a hint how to set
>> __WQ_ORDERED(internal use flag) and WQ_HIGHPRI flags at the same time?
>
> Wouldn't alloc_ordered_workqueue(NAME, WQ_HIGHPRI, ...) do what you want?

That was my initial suggestion. Can WQ_HIGHPRI be used together with 
WQ_MEMRECLAIM?

Regards,
Arend


