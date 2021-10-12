Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585B342ABC6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Oct 2021 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhJLSVK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 14:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLSVI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 14:21:08 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E46BC061570
        for <linux-wireless@vger.kernel.org>; Tue, 12 Oct 2021 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xqjShfXp8Z6QyX/dnqnYsM4PS/BNil5sdN8XlnolJaA=; b=DZ0tPr6Y/JkSUJveY5oyzZHXrc
        Ly7dAmXVm/+MC9qQ9QACAraeQPW9Wi/xHr4x0iZ9NScFraomLj8RvG+DNylnkNqreoZjxrNfUbEWQ
        5SZsVsNoKXn3RKk4qcpeAduJiLN3ZjGilj9QFj5Ta6D6/5dvBc7vmhvX44tWb8mt/1io=;
Received: from p4ff1322b.dip0.t-ipconnect.de ([79.241.50.43] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1maMMY-0005f8-LZ; Tue, 12 Oct 2021 20:18:54 +0200
Subject: Re: pull request: mt76 2021-10-11
From:   Felix Fietkau <nbd@nbd.name>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <f32b6609-b5bb-2da7-8971-b5c00b0f1d70@nbd.name>
Message-ID: <014f0b2e-36fa-91cd-fec5-d4c7d429d003@nbd.name>
Date:   Tue, 12 Oct 2021 20:18:54 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f32b6609-b5bb-2da7-8971-b5c00b0f1d70@nbd.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-12 15:33, Felix Fietkau wrote:
> Hi Kalle,
> 
> here's my first pull request for 5.16
Please disregard, I think there was an issue during the last rebase.
Will send v2.

- Felix
