Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F160B19231C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 09:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCYIqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 04:46:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36007 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCYIqY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 04:46:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so1814664wrs.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2020 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ea//MdWzRUi+AZ3X+Dhlj3y3RUpDbFAMM3S37MCEuew=;
        b=AYMYgOaZcxp/rzn/EwWCCrJ1+XXyxthftKXYtMsFpGDPP6mF3eA1+NCjl+xqjSbsyi
         eAgwnemgQ9jhnLHhOatOMf8afZuVdtxboY/Y7antth9WLOG4a//iZS4bDlukHNCjZpVv
         9GUgY5ro5ig/i0TzCqu7jeDiWOyvkE8cvP0rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ea//MdWzRUi+AZ3X+Dhlj3y3RUpDbFAMM3S37MCEuew=;
        b=PIXu52J9GANA/i7Bw07BMeQlcntSvM2ZiUfmyVeAwxgYxocTT4iHVY5aWq5pfrxQpd
         hEhh3f3Y6HIR7P+h2hvCUC4sEcsqJav1/O6ZIt2Rw6m+cA11oOnUxmwjexL7j7789n7y
         ELzJOK2Hx9tjLcSACvui+kWsoQ5lERhB2A06RwdRfKE6YjW0yWZyz2sJcwtLiMX/7osz
         nSd7icR7K8zG78YYCAFAHAKUcZTcyS/2O2/IRpY7TcMcWEcnDHFn6fvP0zRyRqXpGXoI
         /22a9udqGNB28PHPXP16FGTMpdXGKOlkxy8TKEcFhrt0yb7tko2Cn09T/uf9S4XSsMRY
         MQ4A==
X-Gm-Message-State: ANhLgQ1LQ5oMpoi9c8tpWjOXBQuQqhi3qmCFFd1HhPiCq9metmBosPpn
        9yTlV66yV6SEY6fSmS05DZ2QEg==
X-Google-Smtp-Source: ADFU+vvHKdpTt5+C5HS1Z8veZlyXJvZjHAX05cv+0XRhdKBUyu2+1poV+PTbY1iJk0tzpMaiU51Oyw==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr2320811wrw.41.1585125982372;
        Wed, 25 Mar 2020 01:46:22 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id k84sm8346795wmk.2.2020.03.25.01.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 01:46:21 -0700 (PDT)
Subject: Re: [PATCH V3 6/6] brcmfmac: To support printing USB console messages
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Raveendran Somu <raveendran.somu@cypress.com>
References: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
 <1585124429-97371-7-git-send-email-chi-hsien.lin@cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <0c2f05cf-552d-ad29-4115-f6880bc69c59@broadcom.com>
Date:   Wed, 25 Mar 2020 09:46:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1585124429-97371-7-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 3/25/2020 9:20 AM, Chi-Hsien Lin wrote:
> From: Raveendran Somu <raveendran.somu@cypress.com>
> 
> This change is to add support for printing the firmware
> console messges of a USB interface chip to the host.
> To enable this feature, build option '-msgtrace' should be

Given this description I expected a feature flag would be added in the 
driver. Can we detect it on driver side?

Regards,
Arend
