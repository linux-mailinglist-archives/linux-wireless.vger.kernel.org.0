Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827FF689A03
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Feb 2023 14:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjBCNqy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Feb 2023 08:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjBCNqx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Feb 2023 08:46:53 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9D88AC0E
        for <linux-wireless@vger.kernel.org>; Fri,  3 Feb 2023 05:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pwF4r/Z65S2heAtBhFj5cOqgMbvpb/ygwnJ2rHOYLpk=; b=L3NSv4km67iWGd8w/18RQEu0IL
        9tnwETr+/Jv9uYbQDrGK9+PE4cA65jBMBniOy9wfZ1JiNVrM+QQL/PbSgFDgWtVkqGPOfBP5uIZVy
        tF7YsgGDZlLBell/bTzt6iAq6zTpQ6bdvQ+aTHHgxF3hVSmJF8oF1VZ2soww1uiRyI7k=;
Received: from p200300daa717ad088514d6b2ab605d8d.dip0.t-ipconnect.de ([2003:da:a717:ad08:8514:d6b2:ab60:5d8d] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pNwOx-004hf2-90; Fri, 03 Feb 2023 14:46:51 +0100
Message-ID: <82630502-9283-c754-ede4-bf5d861fa748@nbd.name>
Date:   Fri, 3 Feb 2023 14:46:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: pull request: mt76 2023-02-02
Content-Language: en-US
From:   Felix Fietkau <nbd@nbd.name>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <ef57e746-9a5f-9908-ed4f-d63722ffd6e7@nbd.name>
In-Reply-To: <ef57e746-9a5f-9908-ed4f-d63722ffd6e7@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 02.02.23 14:25, Felix Fietkau wrote:
> Hi Kalle,
> 
> here's my first request for 6.3
Please disregard this one. I need to drop one commit from it, and I will 
include extra pending patches that depended on the net-next update.

- Felix
