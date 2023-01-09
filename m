Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4F662C91
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 18:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjAIRYA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 12:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbjAIRX6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 12:23:58 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4653FCB0
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 09:23:55 -0800 (PST)
Received: (Authenticated sender: chainofflowers@neuromante.net)
        by mail.gandi.net (Postfix) with ESMTPSA id CF16740008;
        Mon,  9 Jan 2023 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=neuromante.net;
        s=gm1; t=1673285034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eP0VWOISEuxwTDSWLqYV3+4v7bduOFCVpDQcKvbp8MU=;
        b=SCDSCplUlhXlNTIUSljyinMPfUwLtJxM42pC+r7MtRQzkUBcr6LIENZZLQt+SOeFynoOcf
        Ojk0b01D2/wBWdjA8tz3/O7jWwBp07ymMARA9uO1EMnAzUq6sp1pFNoD1UXIPeJeq2QQNE
        oPS4RDOdEVsk5GYihV1PZl+kWZX6Vr90nTP1lmD2J5l8Vst1t5RwxH5YxwwK8OWXT7pO+G
        TbjOVuTPsMtAfhKs82cuNP1tgC2ox8y8accW/UfvuIoYeoWOJUsIInilAOjlrpaQsPvnYl
        +83JGLnb30ZCWEJPxLW9vdJCxfGASv0A9BE+fVa8wQRDUzRqkabpgwxZrmuPtA==
Message-ID: <dd675714-c148-2810-3a19-1fc8104a5774@neuromante.net>
Date:   Mon, 9 Jan 2023 18:23:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] brcmfmac: return error when getting invalid
 max_flowrings from dongle
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        chainofflowers <chainofflowers@posteo.net>, ian.lin@infineon.com
Cc:     Double.Lo@infineon.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
References: <4781984.GXAFRqVoOG@luna>
 <3c470a48-e971-9991-e096-3adfe1cc4468@broadcom.com>
Content-Language: en-US
From:   chainofflowers <chainofflowers@neuromante.net>
In-Reply-To: <3c470a48-e971-9991-e096-3adfe1cc4468@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 09.01.23 09:52, Arend van Spriel wrote:
> 6.2 is not formally released so I suppose you are an early adopter and 
> aware of the risk that implies ;-) There is no real debugging needed. I 
> will figure out what a sensible value would be and come up with a patch. 

I am on 6.1. Version 6.1.1 works, 6.1.3 does not.
Will this patch be provided with 6.1.4? Or shall I wait until 6.2.0?

> If you can test that that would be great. Will let you know.
Sure! :)

