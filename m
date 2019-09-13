Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D649B233B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403913AbfIMPVY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 11:21:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35883 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391426AbfIMPVV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 11:21:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id 67so29793573oto.3
        for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2019 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FKi6wuJV6kd7NjXzqG4bqGjU+sqHECm8FbEsfvUTAog=;
        b=vSM7UJN43IqaQ8GHwxtHyetocJGfen3/sjwbcMsECYESJ4wYGGcXz8E7aPQqGdRXnL
         6hrmlHQB6v+ALSCTbkwDe/nDXwfzs+stpvb3GGR0d4g6Kck9shH23iepFydiRrVgIC74
         6xJtD4QSLCbN5RdMh0mdOKmOaYyOgHAlZFfo/y6cfQUtTTuc6Y8vVxw/+IjtS+aOT7Dx
         oIvbsrx0QMTAPJKRmc6BDPusOBGlQOiAKz3eZ/NJjQUQsL7EAO0kZV9WSrluV4BTQ7YB
         5ItLnada8+0RPPBdOsPs9B9TuUObovZtkfha/5nVyBLog/vrH7/aqxIgJyhzbjmLn2Gg
         4xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FKi6wuJV6kd7NjXzqG4bqGjU+sqHECm8FbEsfvUTAog=;
        b=dYB3xS12bWmU9q5poDQ5/BxMf6TUzRXr159p8cI4/KUsAgUklWIRoaJ4qmhKM/ALI1
         /+JNS7TMwKycsMmBU+I7k/M+EaklF+MRXlzo71iwm+OILpB27FPFTAbaOZQoO4RyTkgc
         MNMNOeazn2gKCb5pDlg92svl2bUY2zwLmy1TSbyPlWJUWfjabuJq6fZ/vzs7H34yQskZ
         wr1ttweg2/REgyCqai7+UERIwRC0QCNEjedAKXjXUGzaa9jsJLQNfLSJczJm84wZLZjd
         eCWEMZh7G7jZaLobXpDUx7mw9k21pZYnJe96Jvff+AOabSLuVJP5bnBjpuwOgxrFjoQ0
         jtXw==
X-Gm-Message-State: APjAAAXp3L3gO7PHlFTBgvmIRxzCDcMzjchECRoo675YAxIRs5VnEteF
        hnIZIpfF5NZvMqrYrijY26U=
X-Google-Smtp-Source: APXvYqyKlMYFC3kP+C3eNwBgOVYlk3Se5T3Ew4jFNKgygQoj5LERUHPVIZWG8drDebvncoaa/2nYqw==
X-Received: by 2002:a05:6830:4bc:: with SMTP id l28mr36321061otd.361.1568388080877;
        Fri, 13 Sep 2019 08:21:20 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id i2sm6727994otf.19.2019.09.13.08.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 08:21:20 -0700 (PDT)
Subject: Re: [PATCH 04/11] wil6210: fix PTK re-key race
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Alexander Wetzel <alexander@wetzel-home.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
References: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
 <20190910132315.D7AC7602F2@smtp.codeaurora.org>
 <7b636313-fa4a-5ee4-935a-ba2ed5dde1e5@wetzel-home.de>
 <2c6bc637-62c2-020c-ab83-d2e1677d96b2@gmail.com>
 <5716f475-856e-7fd2-637b-67927f4f78bc@wetzel-home.de>
 <74c0e328-320c-0999-836e-1bfb0fa224ff@broadcom.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <13f699ef-16c2-3ba7-79a0-0934f5e39368@gmail.com>
Date:   Fri, 13 Sep 2019 09:33:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <74c0e328-320c-0999-836e-1bfb0fa224ff@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend, Alexander,

> Basically, we now have two bypass methods dealing with the same/similar 
> issue:
> 
> 1) bypass the QDISC.
> 2) bypass network stack entirely with CONTROL_PORT.

It also raises the question in my mind as to why we have two ways of 
doing the same thing?  From the discussion so far it also sounds like 
each requires somewhat different / special handling in the driver. 
Wouldn't it make sense to deprecate one and encourage drivers to 
implement the other?

CONTROL_PORT was added specifically to take care of the re-keying races 
and can be extended with additional attributes over time, as needed 
(perhaps for extended key id, etc).  Also note that in our testing 
CONTROL_PORT is _way_ faster than PAE socket...

Regards,
-Denis
