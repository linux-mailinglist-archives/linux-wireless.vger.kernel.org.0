Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4188B6F23E8
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Apr 2023 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjD2Jmf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Apr 2023 05:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjD2Jmd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Apr 2023 05:42:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA19CE44
        for <linux-wireless@vger.kernel.org>; Sat, 29 Apr 2023 02:42:32 -0700 (PDT)
Message-ID: <cab66a9d-9a66-7cd1-408b-91e8cd9d8a9c@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682761350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Li+5LKSaQ8ko2VUJ7yQvbg+9v2lE7QFJj70MRZ5tbY=;
        b=cHrchnseD1yB6yrALkGIadow5Aq1azM3ynn65tROzYqbRgn8rgucjS28Dac0NAQOvrqb3r
        LEIGYe3N/zDnhdlYNJSLS2cgDyVG510z1amLdOqL40wJKPp9/lqQf8FuEAx+mU7us44nAG
        yc689cIDGey76XVJf6+M5fmnGRDvtR9eZLeVkPA7berdehoNEWclD/N95SM0i1maU5KJly
        mXzfp8Ywd6WNXBp6CZbNRqOIkWNTgdZQ+Ag7S8giGnAjC9emOryi+jASjHqNh00EJfDcNO
        VowMLX4ZWgA+3lUSZ0lPhBXXMGKAG0XQH9g0r+dO6tM0g+0tLucQlz7vJqvmLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682761350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Li+5LKSaQ8ko2VUJ7yQvbg+9v2lE7QFJj70MRZ5tbY=;
        b=90VntxXIQCG90FJ5DHXHogGeRvBr0RbEBsqmDfrxUvj7kgBQW2xNedPChdlLQ5eCUrmpqR
        xPSSeWMsMxZ7+0Dw==
Date:   Sat, 29 Apr 2023 11:42:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192cu: Remove driver
Content-Language: de-DE, en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20230428182933.19157-1-Larry.Finger@lwfinger.net>
From:   Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <20230428182933.19157-1-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 28.04.23 um 20:29 schrieb Larry Finger:
> The functionality of these devices has been replaced by the rtl8xxxu
> driver, thus the version under rtlwifi can be removed.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Things to keep in mind:
- rtlwifi offers AP mode support for rtl8192cu devices, rtl8xxxu doesn't 
(yet) do that. Should be relatively easy to add that on top of [1], though.
- The rtl8192cu devices are currently hidden behind 
CONFIG_RTL8XXXU_UNTESTED in the rtl8xxxu driver with the comment "Still 
supported by rtlwifi".


[1] 
https://lore.kernel.org/linux-wireless/20230428150833.218605-1-martin.kaistra@linutronix.de/
