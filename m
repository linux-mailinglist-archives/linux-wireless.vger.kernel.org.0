Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1C42A12B1
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 02:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgJaBaT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 21:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJaBaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 21:30:19 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A80C0613D5
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 18:30:19 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i18so2558564ots.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 18:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OP7ewtSP6Fctoq4MSF0rcQn3CGYEJO3Ossdg5uQQTjI=;
        b=VA4tsJb55Q3aZFmQRkDMXau64moTicPdG2/qIROvzcGtNB3FbMiahC1L34mEt7I81h
         Kc7pAZztZowd+ZbCUJkQhUa0hgoab2+ty7lKGonXz6qnd6jg6x+M6u4PDrwaw/wsFTPA
         BgBV1HCrHU3oFPj4i/uZS7M/BPOfAjxdkBzqvI6dlQ8IIh9/T/efJd9nWPu9YZ58Vyet
         7G5WgjPKh4i5QvemrABs5Zhv1t0vqq04CmFM00COEfpHSow4WZ6WdnLcSqPzXwxJWQxq
         KjfVjg4k0S56BXfpYkUOL7vwftpt+USWiof0bTqyBVAZyKOtAiH2IpafnYDzk7HI5htt
         dOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OP7ewtSP6Fctoq4MSF0rcQn3CGYEJO3Ossdg5uQQTjI=;
        b=XhvSQnegojxwEzZbTsGsgAENE6+uD9hULGF3KdnIPbFjWEZsYTwsREhJB7oXRH1arR
         2U7dvke3mQV/Z2OKb42zz1GzLPX2YsSNnhA8v+ns0IbhpNSxXFBmejQ6vcLECURwzYkF
         CfYVxScuK6nzp8273S8d/kPZQkQaLkaVsalka5WaEd5MiJi58CnhoYVXPU0iMSrkUelo
         HTjCapNYztb+HHn//oBe8lJ0n1leibRZEPGSio0XY+0PfXQpZ1LYJ/rDmcoQkLw2Jp3O
         lQfg+vqa0RTspe7rFOhtOjwQMh9wcIF+UntOTgHex4Gx583YIkLG4eNKfuz9+KRTcafc
         R/dw==
X-Gm-Message-State: AOAM5315EEA+WWpkDnS8exss2Mue752B2puRJA4XHqs4wKnIudkqpVH7
        3N1c0qHoVMriUcwMlfykJcZgwz9giHc=
X-Google-Smtp-Source: ABdhPJxaVxiX5MFcCcWLWbT6ku41daOZuzWZZzz6HB/1UHyDLFy72gv2kDAQLvO0EJjVNG7GqE6f6w==
X-Received: by 2002:a9d:bec:: with SMTP id 99mr3968618oth.103.1604107818131;
        Fri, 30 Oct 2020 18:30:18 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x13sm1762109oot.24.2020.10.30.18.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 18:30:17 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: rtw_8821ce driver in kernel 5.9.1: wifi module inactive
To:     Michal TOMA <michaltoma@sicoop.com>
Cc:     linux-wireless@vger.kernel.org
References: <6173742.tiux6Xeah1@linux-9g0r.site>
 <3c2baab8-bdcf-0679-b396-b42a05a0ef38@lwfinger.net>
 <2483828.eKyWTE2oqM@linux-9g0r.site>
Message-ID: <5712da17-6f45-247a-e9ea-a13c6b9b683c@lwfinger.net>
Date:   Fri, 30 Oct 2020 20:30:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2483828.eKyWTE2oqM@linux-9g0r.site>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Michal,

My rtl8822ce works fine with 5.10.0-rc1 and 5.9.1 from openSUSE TW.

Larry
