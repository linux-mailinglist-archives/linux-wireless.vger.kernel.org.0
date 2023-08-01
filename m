Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6935A76BAC3
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 19:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjHARG4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 13:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjHARGl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 13:06:41 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780DC49DA
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 10:05:46 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56c74961e0cso3089673eaf.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Aug 2023 10:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909497; x=1691514297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RURpMdOyyzFQ2LKbyBE+9hUjS3T3kV+p6/BxVXrJb4Q=;
        b=infonfbgWje01UPT850fIuZ7CAmo+gSDkEmRzHeObrH78qCqDU3MrjxgWUwfqThuJC
         w1BGq8Kp2prk/L0oqWkkNhn0AaK+Qti8QUuULHymjBfjmsqgr8pUsrbeaierdYyghG//
         rE00HUgGtVcNzFp4kxGXou+6FlyMOLykvl7Abgwm0s1hbZ9reKTJm2MNSjA0GC2zmnMF
         rj01XYGdLBF9p6baTvkvZ2f1S58333Ta+Nuyy9zgY2NkanYb8ADW92+5BKDKgEp4PO8X
         U336g6I5mxUZ5xvAZovNbyTpMa3KKT6sUUiygOgitk/SR7DVCOZklUE+9i+o7PliWTnO
         kKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909497; x=1691514297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RURpMdOyyzFQ2LKbyBE+9hUjS3T3kV+p6/BxVXrJb4Q=;
        b=cam7MyEST4ZGYN4Gc7xFgrbCmomTt9F7ud8aGvRsrgOLp2hYOXWkBtxAEYfnJ25V2w
         NQ2eykppyT4SXMW6iHXaeMJ4pb/iJFRELZfrfOpqQuzAfyZTEyvRajVMY78iSGdBl5o3
         QVnJMIP/gewmhQkOn8fWe4XZEMqUerAY/DFPoIfiH2K4UPNejjhKWUN7jddUmuCOygF9
         LHeKI8rcLt/FVYUFutITI3JhufZ/J8VbtjMGROJI8//tGo9tVYL3Gr5ME6dY+2pnezZG
         EoZy6qHiBCv+Uzz61L+wm2CZ0SCR9z2jNlQf2adS1Hbjl1LM69bHVx2QAcSq/TPzMrUv
         6NJA==
X-Gm-Message-State: ABy/qLbNqJzWZCTz6AKrE70TM4MVWbvJcu+zhLnOdAShmEuS6Jd5Jpzl
        VjPnRc3ZMCmnbzDaGGFChzo=
X-Google-Smtp-Source: APBJJlERyZNEMhM2T1U07rga+h8MSUOETb9a5wwzSXWWlG4O0C5nxNnix4kTztKIioVw4tyhGl53tg==
X-Received: by 2002:a54:4692:0:b0:3a3:6244:2b0a with SMTP id k18-20020a544692000000b003a362442b0amr13394048oic.23.1690909497042;
        Tue, 01 Aug 2023 10:04:57 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id s35-20020a05680820a300b003a7408343bcsm1599770oiw.47.2023.08.01.10.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 10:04:56 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <92233d7c-9595-9223-39e1-6df68b13d474@lwfinger.net>
Date:   Tue, 1 Aug 2023 12:04:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: MAINTAINERS: rtl8187 wireless driver
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Ping-Ke Shih <pkshih@realtek.com>,
        linux-wireless@vger.kernel.org,
        Herton Ronaldo Krzesinski <herton@canonical.com>,
        Hin-Tak Leung <htl10@users.sourceforge.net>
References: <20230608095051.116702-4-dmantipov@yandex.ru>
 <168664510862.24637.10587241603155144086.kvalo@kernel.org>
 <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru> <87h6rad3fp.fsf@kernel.org>
 <bccf723a-9f57-73a7-37af-badc6c156daa@yandex.ru> <87cz1vbulk.fsf@kernel.org>
 <2e78d1f5-4dc5-9665-e3a1-ee00dcc41630@yandex.ru>
 <fe6b1abc-d529-c20f-3fcb-43d891091080@lwfinger.net>
 <87v8dzxg5l.fsf_-_@kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87v8dzxg5l.fsf_-_@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/1/23 04:31, Kalle Valo wrote:
> + Herton, Hin-Tak
> 
> Larry Finger <Larry.Finger@lwfinger.net> writes:
> 
>> On 6/16/23 05:20, Dmitry Antipov wrote:
>>> Note MAINTAINERS marks drivers/net/wireless/realtek/rtl818x/rtl8180 as
>>> orphaned but drivers/net/wireless/realtek/rtl818x/rtl8187 as maintained.
>>
>> Driver rtl8187 is certainly maintained, not that it gets many bug
>> reports. Devices that support 802.11g are not used very often, but at
>> least once a year I use my device to get online to retrieve the
>> drivers for a fancier wifi card that does not have a driver in Linux
>> or Windows. Drivers for the USB-based 8187A and 8187B have been in
>> Linux since version 2.6.38 (December 2010), and also in Windows 7, if
>> not in older versions.
> 
> So this is what we have in MAINTAINERS right now:
> 
> RTL8187 WIRELESS DRIVER
> M:	Herton Ronaldo Krzesinski <herton@canonical.com>
> M:	Hin-Tak Leung <htl10@users.sourceforge.net>
> M:	Larry Finger <Larry.Finger@lwfinger.net>
> L:	linux-wireless@vger.kernel.org
> S:	Maintained
> W:	https://wireless.wiki.kernel.org/
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
> F:	drivers/net/wireless/realtek/rtl818x/rtl8187/
> 
> In the git history the last activity from Herton is from 2010 so I think
> we should remove him.
> 
> Is Hin-Tak still active? The last activity is from 2020.
> 
> Also the git tree is outdated so that should be removed.

Kalle,

I removed Herton and Hin-Tak as Maintainers for rtl8187 and updated the tree 
entries for rtl8187 and rtl8180. Patches are submitted.

Larry



