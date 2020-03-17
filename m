Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD61889B8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 17:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgCQQDx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 12:03:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43660 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQQDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 12:03:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id l13so17850247qtv.10;
        Tue, 17 Mar 2020 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=1cq61pMKrXnE/8ZgHPZoRI5nasAc/Gz5oZHWr1Wic8E=;
        b=sCqQM4hmv6145mTEPmet3o0Tv8fHUfT2SJ2jUgYxjyqHesDKwMrZMju/OqsGJ0KkUy
         Zb8goI+G07BzcmChJSPGxgc0JO1adCIwbLtyLmrdlfP+y69SolfWTYipGyNYJWZngUgo
         9/fFLBnjNH+njW6YDJY4ELS80/jIqjhJircFhujElwB6HiuMs/UJgZzrDyw90jrMNgyV
         72LtRXZvRNBQLqAzZbwUBqPrxAI4hHj2pbSEzixtYzJfJF7ntJ3zDWg3GxEhDE5wOges
         DMuWktybl8vpQKEWR25hXv2ITdLUyW2kck/j2ahjPVwdeWs9RM1Bu4bbe8v8HWhRBf5d
         sxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=1cq61pMKrXnE/8ZgHPZoRI5nasAc/Gz5oZHWr1Wic8E=;
        b=g4wriJL2WGl97qBIJJ2UbFu5NpMo/Q9wfuMuRDyw6m0bxB2PwhnPHDQvX8PwKXcgSu
         /nlDshhLdG8dXgJFL0xb/cTHsTJ5fkYUqIPtF0BgD2Rb4DcKs2vRnvzyOKDwM8fCx2OR
         YhcBV5S2jgz7T87D3pxNoaHl1KYntNCaVkQywiO2bzayOcV03hd6kyCIXQIyuVjUDhgm
         fAytFwz7/tBoDsOzqcJcx7zqac99Mxbo28Qz9NbX/SidZxEcIoixlfPWasmae9yBPXAa
         hSODuYAOjUu7aJ6HtaZAOMHNQmS9mqV+lVozSyxdgJBhutXmWtMTlrL039FLvRyxSQYD
         QihA==
X-Gm-Message-State: ANhLgQ1qoOQVZyn86uSOztWxSopYQOISeRkC50oRSZW9qFSu73kLeHBH
        KUmdYBmCPe0a9QRHhZzAzCA=
X-Google-Smtp-Source: ADFU+vt7FKNB0A6TEbsFTVfek3+MsRk98Sx7N8uZNFeebxxE9XulpOQvjLTKwJGXOtQ+xV1zLn8qEQ==
X-Received: by 2002:ac8:3671:: with SMTP id n46mr6298448qtb.33.1584461031859;
        Tue, 17 Mar 2020 09:03:51 -0700 (PDT)
Received: from ?IPv6:2620:cc:8000:1c83:c194:7ea1:d9a4:fef8? ([2620:cc:8000:1c83:c194:7ea1:d9a4:fef8])
        by smtp.gmail.com with ESMTPSA id 31sm2418634qta.56.2020.03.17.09.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 09:03:51 -0700 (PDT)
Date:   Tue, 17 Mar 2020 12:03:48 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <9ae33061-1595-4387-5767-79437b2ff2ae@lwfinger.net>
References: <C9F34A4B-E3F3-4D7A-B870-058C8D4871B9@gmail.com> <9ae33061-1595-4387-5767-79437b2ff2ae@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: PROBLEM: 5.6.0-rc6 + Realtek RTL8188CUS wifi dongle: 8051 reset failed!
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        linux-wireless@vger.kernel.org
CC:     kernel list <linux-kernel@vger.kernel.org>
From:   AC <achirvasub@gmail.com>
Message-ID: <0B600F12-BD49-446B-9B4B-F6E873FB91B0@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On March 17, 2020 10:52:14 AM EDT, Larry Finger <Larry=2EFinger@lwfinger=
=2Enet> wrote:
>
>Please bisect this problem=2E No one else has reported it, thus it may
>depend on=20
>some specific configuration of your system=2E
>

I will try=2E

>Was 5=2E6=2E0-rc5 OK?
>

rc5 showed the same dmesg noise=2E

