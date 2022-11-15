Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5199C62AE23
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Nov 2022 23:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiKOWVV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Nov 2022 17:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiKOWVT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Nov 2022 17:21:19 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58B812AC4
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 14:21:18 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id q2-20020a4a3302000000b0049ee5fe3ab7so2242143ooq.8
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 14:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IGiK9jQ2kDET5N1ZJzhD4ShgA9nmWosz3ww7KWWIEDg=;
        b=DHs5QDjvGCacYiewWiDFU2US6MpEDyhvVikBIXoX0Js9rTGf6Zkf6ea2P7dWb9XfzI
         NA2mqay8oLCck9i6MAiv0A8BYjcP4agrGeC4Ioqocd6aEeZDnYBpjgIQzqmxX2Fwb4ZX
         5hV3+i6g0v4VdqbMstpbWc/IEqqb7r48qOYb21GDVfiLR9QiGtkt2HOIojpBqiHAc8a8
         +hajleqXqEhV2mp/WbKpN0G0vPz/u1wrUkA5B2X4B7sPWO6qTJg0DIVpBGAbEnFiaIJb
         KG/OTBBr2FkL3nnVnjt4A5QazD4c5pdUGUMy39Mt9apA5TeW5vQMBfvqUmWl+/T/TGlM
         gnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGiK9jQ2kDET5N1ZJzhD4ShgA9nmWosz3ww7KWWIEDg=;
        b=oXAec/5yHbo2y7HYutUp7gU9jMSwFOHS1BRn5rIH215hcp4eYA4zLNTmMkXjZNGxQg
         5lwxG0Pf0VM5xFayUz/IfcM9dQKJKMx2lDIxDsUz52Ei0zp27nx7aRT6d7pLApsJSq1q
         1FRBzlakRjQxmYrOiLh6sWe378RsaAiEyQOZzA3+XnHnSxk2kVrs02dHgpEwM7On5pk9
         3qHE9m9jdPykBtjP8M24ode3a5JDOQzu2ncs8CapE3fLyLNW707FYz9ls7pI5+mNmuMZ
         1O89jIk9LVYLmg931vuxuJcqTm9ivRc9ql0bRFTNSr8kBbGrEviP+XCY/nh+m5prM3k0
         HpaA==
X-Gm-Message-State: ANoB5pkse7sD8SFZ9PyUYYTJCFSEuVGDS7UOb46N6CeHUyqnh68xNsPH
        hyaImMqcxwg+1asAGvpxhiq92ymiD0Q=
X-Google-Smtp-Source: AA0mqf6MfZMQx897Ym0kPN/+6vG7XyHtu9gc13n/Z+BPIYtb02GqQWWy81sKesVuuromjGnLz6DlpA==
X-Received: by 2002:a4a:ba85:0:b0:475:7520:c3f0 with SMTP id d5-20020a4aba85000000b004757520c3f0mr8541661oop.40.1668550878213;
        Tue, 15 Nov 2022 14:21:18 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id y20-20020a4ade14000000b0049bd96ec131sm5280281oot.8.2022.11.15.14.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 14:21:17 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <61c69be4-daa3-95d5-47a7-856a5624fa9a@lwfinger.net>
Date:   Tue, 15 Nov 2022 16:21:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: rtlwifi: RTL8188EE: Unable to connect to Wifi network
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org, it+linux-wireless@molgen.mpg.de
References: <eb1885f2-abd9-1f1f-1c3e-c879372d8db0@molgen.mpg.de>
 <4899c9d3-acad-6cc0-e1ec-ab4b27754ecb@molgen.mpg.de>
 <fd317fc1-70e3-44bd-912a-07ce9aec0b86@lwfinger.net>
 <1f635ca8-28df-8762-4484-2b5daf896bb7@molgen.mpg.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <1f635ca8-28df-8762-4484-2b5daf896bb7@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/15/22 11:47, Paul Menzel wrote:
> 
> Thank you for checking. Just a quick update, the user reported back, that Wifi 
> is working fine at here home. So it must be some incompatibility with our 
> institute Aruba access points/Wifi.
> 
> Hopefully I have more time next week to gather more logs.

One thing that would be useful would be the in-the-air packets captured with 
WireShark. That way we could see the actual probe and response.

Larry


