Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F4B2B351B
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Nov 2020 14:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgKONyy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Nov 2020 08:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgKONyx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Nov 2020 08:54:53 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5735CC0613D1
        for <linux-wireless@vger.kernel.org>; Sun, 15 Nov 2020 05:54:53 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id q7so7366293qvt.12
        for <linux-wireless@vger.kernel.org>; Sun, 15 Nov 2020 05:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=5fD1twQ80zn/CuCyvLR0CDLRE2pdz9Qyt6MqFgzzZyU=;
        b=u8s76leSl47qY+ly7iWjqZxmb5lEEaGR2s/bxTd9m1c8zjTf8KxWuTZq64yfx2pNTI
         1/amG8PJzqCRUcd5PN9Iu/gC6pZ1AML9tpC/c5WwRUODUXISYgVm0qOVROJMKOPmbeg8
         e6WEneIv9jzUe8jkGN6VcQ7Ipy4b3vNhFR/0Zc61GLeT97/SVAwqJh2J4M413vpvnFTX
         hj5KY5FE9+jvCOcJjp5iJ2zgOlTFDIoK2ow8fx0tIyAXRHtVUghG9pDwOfQldcNMbazQ
         caYsHIYoG/s7hWgnrqdTEOeYWGOD7B+3GsagvxPty1IlsdRvtJd/YsAcnI0/RiDobdjB
         ZJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=5fD1twQ80zn/CuCyvLR0CDLRE2pdz9Qyt6MqFgzzZyU=;
        b=r2uMShrbG6qwbqe2/TmoRFBZ821KuKrmsibhT+UobqEvvEEhHwQB5Oz4Hj/I0aTz88
         1yyH9bddwYEmbJm3VVzUN0KVwBBZQehenzeOC8PvvhwTAjyPCDM/WVtudf2Z3WSGZh8R
         jgYXiLWSrIcAGcVyMsV0dPhDrwIClkHtuGI0KMKio6CzBLvrIBVr2PdzDeUWwWOSpGag
         WExve6D7BskrgL5zuA0GIw4f7X2JJwR3F02y83/J1ckPNjSfZJ+5JWP4A9gFQy1VHTPu
         8OWtxB2huf18YHFUOX/HeGBiQr7Nfm9yo7EnIcv3BfxyAz97KG4F/KnSwmzMbegekgQo
         P4Gg==
X-Gm-Message-State: AOAM5321ne3Jhl2PCSkHilTUGswZujrj3v5ioqXLOVCBRSVdHQEZwdIo
        RNuzml9LprnOdwdjzIA4paWwqdIsBPY+pQ==
X-Google-Smtp-Source: ABdhPJxoRIyORr1p4K9Mz46pud+giYm3ZejFLhhRSeNpJPAYfcOpuWE/oqApifqbiHlw6Uxkilylkg==
X-Received: by 2002:a0c:f607:: with SMTP id r7mr11123470qvm.47.1605448492327;
        Sun, 15 Nov 2020 05:54:52 -0800 (PST)
Received: from [192.168.1.12] ([168.0.128.4])
        by smtp.gmail.com with ESMTPSA id n4sm10538080qkf.42.2020.11.15.05.54.50
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 05:54:51 -0800 (PST)
To:     linux-wireless@vger.kernel.org
From:   =?UTF-8?Q?Jo=c3=a3o_Luis?= <jmrguesrec@gmail.com>
Subject: Modelo: W-U3300mL. V1.1
Message-ID: <1ec850b6-0663-7c09-2c4e-38d08c6d0a31@gmail.com>
Date:   Sun, 15 Nov 2020 10:54:28 -0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bom dia!

Esse modem est installation premed no chm forborne aces so a red WiFi.

Modelo: W-U3300mL. V1.1

Sistema operacional Linux Debian

