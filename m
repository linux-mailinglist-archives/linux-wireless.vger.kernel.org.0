Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7A69EBFB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 01:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBVAdB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 19:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBVAdA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 19:33:00 -0500
Received: from titan.fastwww.net (titan10.fastwww.net [198.27.78.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D49A44BF
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 16:32:58 -0800 (PST)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=A7Zf3xawm3I4Z8DBkeFQH4o7SlAc7fnSSs42U+qGEij1fOietgCNYL1LENojFAtYFELNR6tOW3/1CoOpgR4n6/ov/7MLqcllH1/xRRwVoxmrYvZ2YcsaoSd28JQgdtjAy2aHKH6cAK74CrLg/fvHUAtclSW/4u7m8tFBAvBEQAfd6rFyAugTHOUIYZebZqnzkj/ndvuy4EBmGa0tfnP+JOcKKnCVnYuIFKeYKftnDS1C/fTy6jBSVSalIrxpGv/kqUMAGg4IUUIrqu5D6Pmo2yr909PkjR9SY74qhOokd50SxIMBaDBzUT5Htw6P4mg04sb/XO4IrlimBTQAsCUcDA==;
  h=Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=lockie.ca; h=message-id
        :date:mime-version:subject:to:references:from:in-reply-to
        :content-type:content-transfer-encoding; s=default; bh=X01/S4+lF
        +hTybq8kYVvgGCAA7s=; b=oJSvcuBbJUL6XdFV7xDNhM46M8m6s8+59/ocB4yxS
        gwRO5fuzTU8LWQm21aqyPPcIHf/ymwhIQ/J57GVbQWC/XgP/OBr5FIwCphvQmZpA
        U6JtGaj9wc5YZ4vbmLTAAGeGZH1YK2JzQv4nWDvJXq5wkZ1D/eQXRqbg+HdmTXGa
        4p6B0+c8y493E7yJeN8/NhKjuUYC9A6Oa007nAg9b5DQJHc1q2UhK5sZqqe46m+J
        0/9GzIVG1jMqJ46Y9/1iuht3XH/yNb+e9hzzUKFIxN953/9vbQVAM520XDhfkJei
        88rJFoXNzJo4JGYoq3nZFgzK3KF0B+3kWSDZuRGkq8oYA==
Received: (qmail 20876 invoked by uid 108); 22 Feb 2023 00:32:56 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 22 Feb 2023 00:32:56 +0000
Received: from [192.168.68.80] ([98.124.13.21])
        by titan.fastwww.net with ESMTPSA
        id i1LIGLhi9WOKUQAApSktOw
        (envelope-from <bjlockie@lockie.ca>); Wed, 22 Feb 2023 00:32:56 +0000
Message-ID: <f3039ab6-25f4-d003-059a-c0a75aa24127@lockie.ca>
Date:   Tue, 21 Feb 2023 19:32:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Bug report about ath9k
Content-Language: en-US
To:     Vincent Danjean <vdanjean@debian.org>,
        linux-wireless@vger.kernel.org
References: <ad820d2e-c984-8603-9821-e6c1d426c4f8@debian.org>
From:   James <bjlockie@lockie.ca>
In-Reply-To: <ad820d2e-c984-8603-9821-e6c1d426c4f8@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Try disabling power saving.
w dev wlanX set power_save off
Maybe that command.
