Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4D3EB689
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbhHMOJR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 10:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbhHMOJR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 10:09:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D94C061756
        for <linux-wireless@vger.kernel.org>; Fri, 13 Aug 2021 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ehp8QVXrAvoNWo7feuIvdyhoR1bCsHv5aFy82Lmft0c=; b=d29drEZoc4LcAxSYYCvx/XZHqh
        jdGQ07ks9cUE/riKPBDARs6Y/b/uVgeALUbGyauuQxDLWk5Oo9RtP9SwMcEonScyPOBMqXd6hVAex
        0k0euZbTZxNH8iZMubkXnb35C71QSfs2ge1UIS1w/nwExADs1WUkT1I1hf5wgFDgyD5A=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mEXrZ-0001CP-Sq; Fri, 13 Aug 2021 16:08:45 +0200
To:     Ben Greear <greearb@candelatech.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <9f5b0cf6c4296d3a9e78a95516cf26d1db4baba9.1627696765.git.ryder.lee@mediatek.com>
 <04c61f83-e4ce-536f-7030-9050d8edfe78@nbd.name>
 <44c91410-49db-b829-a69a-f9826c8ff3ee@candelatech.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v4 1/2] mt76: mt7915: fix hwmon temp sensor mem
 use-after-free
Message-ID: <1c4ab69a-21ad-f3fb-12b9-e1664dcc735d@nbd.name>
Date:   Fri, 13 Aug 2021 16:08:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <44c91410-49db-b829-a69a-f9826c8ff3ee@candelatech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-13 15:54, Ben Greear wrote:
> On 8/13/21 3:15 AM, Felix Fietkau wrote:
>> 
>> On 2021-07-31 04:17, Ryder Lee wrote:
>>> From: Ben Greear <greearb@candelatech.com>
>>>
>>> Without this change, garbage is seen in the hwmon name
>>> and sensors output for mt7915 is garbled.
>> Where does the use-after-free bug come from? It's not obvious to me why
>> using KBUILD_MODNAME instead of wiphy_name() fixes it.
>> I still think the phy name should probably be part of the prefix.
> 
> We rename phy devices as part of our normal operation, I think maybe
> that helps trigger the bug.
> 
> It appears that the hwmon logic does not make a copy of the incoming string,
> but instead just copies a char* and expects it to never go away.  But,
> I did not actually verify that.
That makes sense. It seems that thermal copies the string internally,
but hwmon does not.
How about using devm_kstrdup on the wiphy name instead of using
KBUILD_MODNAME? If you really don't want to use the initial phy name,
there's also the option of using dev_name(dev->mt76.dev)

- Felix
