Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B2D6DB755
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Apr 2023 01:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjDGXkh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Apr 2023 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDGXkg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Apr 2023 19:40:36 -0400
Received: from titan.fastwww.net (titan10.fastwww.net [198.27.78.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC359C7
        for <linux-wireless@vger.kernel.org>; Fri,  7 Apr 2023 16:40:35 -0700 (PDT)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=0NxtahNy4Jul/Z7lhnhnoAB4yJVVs8YHhIL2FQq29nYzxt4dNRzXSTFiJUr1S9JHCu0d7gSrJe3ygbdgN4yrE2IvJCaSdsLVEflEGBRpebxZOU8SaqhRRZxOK6lNC3sJ5E9pvspXGB3Y+c/YkT3HbKetROut/lbunwd7eqIK7Abj3FuY4o0KXnEGPW9a64vL1YgeITGsb3b7dUzqUNvDIlwPUVEDZklKPzd4Y/wJooMsTnDtgDAkYVe91ZyzXIoqPn7WJLxGOb8KLfl9difnls/0/ig/SYp0USyJ9A2dmRjy7FdSzZmkyMq7o/TLdG4FpUqSg5yobFkimb0V5n6khg==;
  h=Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=lockie.ca; h=message-id
        :date:mime-version:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding; s=default; bh=0dQEQ2LgR
        7YIkr9qgxepUH94QLA=; b=ScmK0VrcXWS2thnWsxeQPbnRRSkX45dA0OuuTlbVY
        IT66cJ/sQxHOtpjBJfMZ8i+pCh9X8it7OF62Fv5O5olxXPV9gU34cA62woLvS3vA
        vKVQtBJpwrx33s9VNOl+fTPcs7BGsJZOj5lVSQeoiylGJNd/vYHXN+qEHNtyivJC
        U8ApJ08E9zPyaklF6Rp+OkXiBtpCKQ1PeoMbPbQy9DKX2wwDU6t47Vzc4WgOew4B
        uFGsUwN7cdnsqUpnoFkj44cCCU5IlOIRIWUcHmv/a6GlXYqD+dpUUKgzI3HKz4LP
        zoE5x1r7ouaLdswtv4G7jITCSFs7wwVDxPqqsDn9rNk2w==
Received: (qmail 26196 invoked by uid 108); 7 Apr 2023 23:40:34 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 7 Apr 2023 23:40:34 +0000
Received: from [192.168.68.73] ([98.124.53.137])
        by titan.fastwww.net with ESMTPSA
        id tPkyCvKpMGRQZgAApSktOw
        (envelope-from <bjlockie@lockie.ca>); Fri, 07 Apr 2023 23:40:34 +0000
Message-ID: <76605abc-17a6-61cd-23e9-23a7274f00d1@lockie.ca>
Date:   Fri, 7 Apr 2023 19:40:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: ax204/Intel NUC13 i9
Content-Language: en-US
To:     Aaron Dewell <aaron.dewell@woods.net>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <13DCAA8A-77E2-4BB1-94C8-9E57B382D60A@getmailspring.com>
 <E582DF8E-7FC2-4E6D-B076-A0A5F75308E0@getmailspring.com>
From:   James <bjlockie@lockie.ca>
In-Reply-To: <E582DF8E-7FC2-4E6D-B076-A0A5F75308E0@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

https://www.google.com/search?client=firefox-b-d&q=iwlwifi%3A+No+config+found


I suspect a firmware problem.

Do you know how to install the latest firmware from git?

I would copy it to /lib/firmware if that is your distro keeps it:

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

