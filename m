Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E6A740320
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjF0SXP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jun 2023 14:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjF0SXO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jun 2023 14:23:14 -0400
Received: from titan.fastwww.net (titan2.fastwww.net [198.27.78.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DFE196
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jun 2023 11:23:13 -0700 (PDT)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=w5EuI70T1iOa5h2gFaNnugVwweG9VFk0T0ydqcB0HVcEe9LdjqgYXMRJTC+HFe03jHrayMhI22bo8+ZIaXQ7CUd0+ugiqR4ZyBx6CwJFSuM6rRqvU0R8iyi/WG+7RfGWFfM1m/9mZdZcXZTY+bvDa1j2iGMrB6f4lwgQmJ0uFbUI/5nmjBw8nzpkJCUxZbIi+93b+J67WFC8m1aB5vGUhsclHyHLfUw5pEOdO6M3pA4rGpLO0sf7bVadV9OCWRWWp53qAYErsIV+f58+78CLEzqy8j9l0k/euQxm0q155it9DnmVkuoWwTzsRjVtXAlGs6rk3LbtlZzKam7+juV3fg==;
  h=Received:Received:Received:Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Correlation-ID;
Received: (qmail 56956 invoked by uid 108); 27 Jun 2023 18:23:12 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 27 Jun 2023 18:23:12 +0000
Received: from dummy.faircode.eu ([76.75.107.155])
        by titan.fastwww.net with ESMTPSA
        id nw5TFxApm2Rv3gAApSktOw
        (envelope-from <bjlockie@lockie.ca>); Tue, 27 Jun 2023 18:23:12 +0000
Date:   Tue, 27 Jun 2023 14:23:11 -0400 (EDT)
From:   James <bjlockie@lockie.ca>
To:     Giulio Paci <giuliopaci@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Message-ID: <c4b24c16-788b-4f15-ae68-8df44e60a27d@lockie.ca>
In-Reply-To: <CA+zRt5GTSbKBjARaD19V7oQEkXUJJz_pvYO1fOXA9hPrzPS1sg@mail.gmail.com>
References: <CA+zRt5HKvOQihOwoSj_G1eKFQ5ap9L4uRK2hvtV_SxOqwn-2Dw@mail.gmail.com> <e02fe1f4-d837-4124-b53e-cf8b28105a17@lockie.ca> <CA+zRt5GTSbKBjARaD19V7oQEkXUJJz_pvYO1fOXA9hPrzPS1sg@mail.gmail.com>
Subject: Re: Realtek 8822ce connection is very unstable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Correlation-ID: <c4b24c16-788b-4f15-ae68-8df44e60a27d@lockie.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Jun. 27, 2023 12:13:48 Giulio Paci <giuliopaci@gmail.com>:

> On Tue, Jun 27, 2023 at 6:04 PM James <bjlockie@lockie.ca> wrote:
>> I would try a different distro.
>
> Any detail about why you would try a different distro and how much
> should they differ?
>
> Actually when I tried Debian Bullseye wifi seemed more stable
> (although I did not use that system long enough to be sure that it was
> working without issues), but touchpad was not supported by that
> system.
>
> Do you have any specific suggestion?
Just something to try.
I have no ideas.
