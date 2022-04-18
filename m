Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B7505C01
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Apr 2022 17:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbiDRPzp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Apr 2022 11:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345925AbiDRPzZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Apr 2022 11:55:25 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0423326C8
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 08:42:50 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id t202so68663vst.8
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqHR0ImHwibt6Y6o1QCx2/fKCQEMa6EyUc6UvVMJ+Hw=;
        b=cRDHbz0O9ZpM4OKWlxmCnXq1sqezyoD4H0IoEg7fvbN5nD06uHZgjAR8koBHKZYkLs
         4wPhLtRPTszrjKhiOGClhG4hDuJ0HVr7YXCANbWabJdwVlZic3nYLBG6usuRFMROMdYV
         kCJO1p4sjhvn4wnRVrOQxAL8eSNDuhDa+ijQT6HVtz080cV6j4YPj/tpWWEDtDDAbDoa
         r8KjbDB2+03vVPvvPb2MJ+sNKNcRfVP83g2vsHzreNCJl94aB6ZRaHkeX2CVZoWdn2+r
         9kGuk9In2hc/D1F5NY3eaae9qLLBNW5A6mYh/cKliUCChBhB3euKkgluZxDkWSQwWUVs
         fCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqHR0ImHwibt6Y6o1QCx2/fKCQEMa6EyUc6UvVMJ+Hw=;
        b=Eqng5rEJO987R/ilfF+fK0ObsJAZ82IHGDcmA+af4R+0rKl4m/aFll7+P4vIw3qh0P
         ZowlRaDnhnPdq6L/TYuzr57FDLqYmD4OLrprmYXIE56WFAFo/7fsLocOLy8zXna3ot0c
         rro5kMKq7A6OFkt9g48c5EiYHxowsAueP3zuvhyeQcxHVhIgjrE2gMhYcXEA6GAGL1oh
         nqDRu876PwxwIcnZ5v3ajiW9z1NLZQeBqhWgyIlkUl1D6Ihg9C/h2Zgoah4aXN2+drT9
         0c1cJGoHoDBTKxHXmJ/VlRIb1Tg4f2uVAvoQ64lxw18I0lRQsJzV5TEGW84mTwO6MYPg
         Spkg==
X-Gm-Message-State: AOAM532Gb/2Ujs2F4YNIbPdC38/P9KpP6ikTwq7f1VLckWkcOKaG8df2
        oFFr1SdCbwAQWodhytQ+F8jCvbzlZ+M009THVyiYapTWnVo=
X-Google-Smtp-Source: ABdhPJyxeWq6xOgq8cewGCYVxa0bNYYedGRh+A5v6brUa2KfCCn2WD7RCvTLuJJHwEJPA/ZytddgAs33HDmGAXQDF3A=
X-Received: by 2002:a05:6102:a8e:b0:325:aa27:35a7 with SMTP id
 n14-20020a0561020a8e00b00325aa2735a7mr2839149vsg.50.1650296569875; Mon, 18
 Apr 2022 08:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220402153615.9593-1-ryazanov.s.a@gmail.com> <87v8vps4jg.fsf@kernel.org>
In-Reply-To: <87v8vps4jg.fsf@kernel.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Mon, 18 Apr 2022 18:42:39 +0300
Message-ID: <CAHNKnsSbjD_ok+qxj4=HnyNCEKWey34xNQwZwe1gYCKwYmxtAw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] ath10k: add encapsulation offloading support
To:     linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 4, 2022 at 10:15 AM Kalle Valo <kvalo@kernel.org> wrote:
> Sergey Ryazanov <ryazanov.s.a@gmail.com> writes:
>> Hello,
>>
>> this series introduces driver support for hardware encapsulation
>> offloading feature.
>>
>> The main goal of the series is an overall improvement of system
>> performance. On a QCA9563+QCA9888-based access point in bridged mode,
>> encapsulation offloading increases TCP 16-streams DL throughput from
>> 365 to 396 mbps (+8%) and UDP DL throughput from 436 to 483 mbps (+11%).
>>
>> The series consist of three patches, the first two prepare the code, and
>> the last one introduces the offloading support itself. The first patch
>> reworks transmission status reporting to make it flexible enough to
>> support 802.11 and Ethernet encapsulated frames reporting. The second
>> patch reworks the module parameter that configures the main
>> encapsulation format of frames that are passed from the driver to the
>> hardware. It makes it possible to configure more encapsulation methods
>> than just raw or not-raw. And, as stated before, the third patch
>> actually introduces offloading support. It changes a couple of frame
>> analysis places along the xmit path and starts reporting offloading
>> support to mac80211 via the corresponding hw attribute.
>>
>> The new feature has been extensively tested with QCA9888 and works well,
>> but it may introduces some regression for other untested chips. So the
>> series is just an RFC for now.
>
> This looks very good to me. But the testing part concerns me as well, it
> would be good to have some quick testing at least with QCA6174/QCA9377
> PCI devices to make sure we don't break those. Preferably also
> QCA6174/QCA9377 SDIO devices should be tested, they work somewhat
> differently. Can anyone help?

Is any brave tester trying to improve the performance of their system
with this change? Can I resend it as a regular patch?

-- 
Sergey
