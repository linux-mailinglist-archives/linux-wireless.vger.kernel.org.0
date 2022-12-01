Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1090B63F164
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 14:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiLANRg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 08:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLANRd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 08:17:33 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2445C9E478
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 05:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GtasZR1uBKFw0fcu6JvRhtN7gTIgthZTwSqtwAFkhkI=; b=Wix5FPyuj244PU432Nt6X9LoTc
        hKMyM3jvOhiSAPDp/hK+8sftjjXrGHn2p3tH0GIss/l0cVwxxlg0RMl2Qjjzzm5BrYdmccW0CK+02
        /gTAoxIfdZ+NOkS81EMkir+dPmGTlEKbKjn6ZccCcYX6CRNUtbIEU0FECz7eRjHvd3es=;
Received: from p200300daa7225c08186973351f2f7021.dip0.t-ipconnect.de ([2003:da:a722:5c08:1869:7335:1f2f:7021] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1p0jRQ-005fbt-9l; Thu, 01 Dec 2022 14:17:28 +0100
Message-ID: <f5713079-8283-165b-b745-0b16e9883a0e@nbd.name>
Date:   Thu, 1 Dec 2022 14:17:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: pull request: mt76 2022-11-28
Content-Language: en-US
To:     Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <b305eea9-3dd5-0e5e-7726-0eb7c6d0e242@nbd.name>
 <166989085154.28651.16470485299307034951.kvalo@kernel.org>
 <f2226065-b307-1312-61f1-827bb709cf92@green-communications.fr>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <f2226065-b307-1312-61f1-827bb709cf92@green-communications.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 01.12.22 14:13, Nicolas Cavallari wrote:
> On 01/12/2022 11:34, Kalle Valo wrote:
>> I see two problems with Fixes tags:
> 
> Sorry about that.
> 
> It's hard to reference commits from a branch that gets rebased.
Not your fault. For fixes to commits that haven't made it to Kalle's 
tree, I usually fold them in instead of keeping them as separate 
commits. I overlooked some this time and the scripts didn't warn me.

- Felix
