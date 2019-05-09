Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E641894B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 13:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfEILyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 07:54:37 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46739 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfEILyh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 07:54:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id a130so1597784ywe.13
        for <linux-wireless@vger.kernel.org>; Thu, 09 May 2019 04:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WP0bLcCMNhbDrikns73eGACwFVs6dA5eEIoy+HuF4cY=;
        b=c46N9UpyXRs7elWpZBhfIGkWYVIfXcB3l9sFtfMCafyuL9ibb+wPKo7M0VBYvlRyTq
         vwMf9eXd3hJ+keEs0nXu0aS4AWls3FkGSrARTiXdHVuhxmab4hrsXQTZbhussjjRXhgC
         WQBcEmBnuZP/bR2nxK7/imzEZSCiUeRj2CKyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WP0bLcCMNhbDrikns73eGACwFVs6dA5eEIoy+HuF4cY=;
        b=JFxNbUNKrNOswVvySoPL6Bty+mHr6bhYtBqdpJJFJ00l4LkWrDU6ENELRx8fwlX4lB
         /qcbfuZ0AnB+XuhbQcHXr7CpfK9VaMhwath9mH0FVbfTTsM57Tblwu5YL6tV2OWdUaHW
         H73Ug/nt12+y8wbejY6avykARr+bs7/hqe3u6aCi0oGylty2KQEALitf+R51W4FNYIHW
         Xa/3zsgBdf243eYGpi8+oXZaICkPjLbCYgLA5QGLyDhxSYbCBp7TpmDpmsq8Ag6vg6c1
         PZv5HkJ0bgfsENpBPUfse385YajigDCoGlIMlo7QWN5ve6hLyVdwmN8R0Js/PbCvhIOc
         kOgg==
X-Gm-Message-State: APjAAAXXOsQanw6GrYYm7iFKOUJWu9TVHvn8wwvcALgbze9ygUAsJotJ
        VPnaOJtv3aToVAWfQwO5PoVnNw==
X-Google-Smtp-Source: APXvYqyScgHB03Fm7d+gQ6CcgDOqyzGuziHrDngx9SmS3BWlqeNq4cPX2bzbjStSdMS/pGmudbmRIA==
X-Received: by 2002:a5b:d0e:: with SMTP id y14mr2005473ybp.103.1557402876614;
        Thu, 09 May 2019 04:54:36 -0700 (PDT)
Received: from [10.230.40.234] ([192.19.215.250])
        by smtp.gmail.com with ESMTPSA id i13sm517290ywl.22.2019.05.09.04.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:54:35 -0700 (PDT)
Subject: Re: [PATCH 2/6] brcmfmac: send port authorized event for 802.1X 4-way
 handshake offload
To:     Stanley Hsu <Stanley.Hsu@cypress.com>
Cc:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>, Jouni Malinen <j@w1.fi>
References: <1546582221-143220-1-git-send-email-chi-hsien.lin@cypress.com>
 <1546582221-143220-2-git-send-email-chi-hsien.lin@cypress.com>
 <d89b1304-471d-f064-02f1-6a9fab0ca25d@broadcom.com>
 <20190509085836.GB74912@aremote06.aus.cypress.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <8062d7c7-332c-8a10-40bd-9eadf682493f@broadcom.com>
Date:   Thu, 9 May 2019 13:54:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509085836.GB74912@aremote06.aus.cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Jouni

On 5/9/2019 10:58 AM, Stanley Hsu wrote:
> On Mon, Jan 07, 2019 at 10:44:01AM +0100, Arend Van Spriel wrote:
>> On 1/4/2019 7:11 AM, Chi-Hsien Lin wrote:
>>> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
>>>
>>> With 4-way handshake offload for 802.1X authentication, a port
>>> authorized event should be sent to user space after the completion of
>>> 4-way handshake. It is used to indicate that a connection is authorized
>>> and 802.1X authentication is no longer required.
>>
>> It had been a while since I had looked at our offload code
>> (basically since the initial implementation for the nl80211 work) so
>> I was unsure why this would be needed.
>>
>> So initially we added a PORT_AUTHORIZED *attribute* in the nl80211
>> api and later on the PORT_AUTHORIZED *event* was introduced and
>> 4-way hs offload support in wpa_supplicant is ignoring the
>> *attribute* and only handling the *event*. I think this information
>> is important enough to add to this commit message with a reference
>> to commit 503c1fb98ba3 ("cfg80211/nl80211: add a port authorized
>> event") which "broke" the functionality in brcmfmac.
> 
> Thanks a lot for the feedback.
> After looking further, it is observed that the connection state will be
> set to WPA_COMPLETED in wpa_supplicant after it sets PMK to the driver.
> So no need to have this change. Let's drop it form the series.

In my opinion wpa_supplicant does set WPA_COMPLETED too early. If we 
were to use eapol-over-nl80211 and set the netdev carrier when the 
connection is authorized it would be kinda ok and we would not need the 
event. Added Jouni to chime in on this.

Regards,
Arend
