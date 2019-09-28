Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDB0C114D
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2019 18:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfI1Qbv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Sep 2019 12:31:51 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:43795 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfI1Qbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Sep 2019 12:31:51 -0400
Received: by mail-ot1-f50.google.com with SMTP id o44so4908833ota.10
        for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2019 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H7m0fm1dDkQKsckFZQlkp6nGgnhRwFlF+pRogLWLdQI=;
        b=Ppmu2jseBbNr1hhyz9WMIsJXh247oyVgBH0KJ677sAmKL6bnnN6kqf8msMX5BfJw9p
         CL/h6lCZ9M79uygcK13qvYMSBMDeLsb0LNeV0I0AgBp+QWLngCFwihK7H+j60QapsPMP
         M+SIKtf5cysT+6DdWJlw5ADfIJSMAip8acZMzLTysku95Fmk48Kp6bmCG5afVU+RwGNK
         AEJhFG4QP4hUm+kGMMhZlcLh31zW9j6HUy5DEh1/7geoUHUgrhQrn7HiHsb+oV6N9/xy
         +V8r81RwpOdU9bfbIAm54eGrmgvE5nTc8F5oTSaN6lVtZXafvgVvtB168AtIjz1bbNSR
         zjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H7m0fm1dDkQKsckFZQlkp6nGgnhRwFlF+pRogLWLdQI=;
        b=q9fqwNd6hYLMXKSmucC4tJzqB5oY4jDd8uQZv93DA6f/motTUEg+mW5dYpPrMJ6EB5
         kFuwF6JQ8I6/FmQY09rdc+bJ/NaVheOX38LG66kxTSEcmR8deuJx+oQtIjlWL8SHq4Ng
         CSS/whZ6Cr+FFiv7AiYISlg+NCtbijNtqzcnQOICu8aNTHYY8ou7lMTxYQ6DbwNrxG9o
         CDsByNqG2V7806kREdk1Dm4cvip5R5CkGA03TfQ7WVacw/cYDLXS4lQVbHSVh+p5oedo
         wAL9zkz3R5zw8Fk4bSqB6zK3yQ8IqlkxWDF5CcLhIbO1n8TTs+9NMoo9xQikC0JgkQpx
         h8pw==
X-Gm-Message-State: APjAAAVXn/QZaGazsmNCDw4FAYYTPQbKIuWxdXw9mcBoJk4R24cWAEeV
        KWG/VdJCEs0nzvSWHcMgPkSyQ5p4
X-Google-Smtp-Source: APXvYqx65CdpFh8uiqMyQ3wtEAef5OndXIvMfXjJCvxubJ+bJ80FU84hXKGCoJ0yJOnn8DO8ILKArQ==
X-Received: by 2002:a9d:193:: with SMTP id e19mr7465155ote.107.1569688309406;
        Sat, 28 Sep 2019 09:31:49 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id i4sm2020080oto.43.2019.09.28.09.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2019 09:31:48 -0700 (PDT)
Subject: Re: [Linux Realtek Wi-Fi support] rtl8192ee related bug
To:     Sergey Kharitonov <haritonovsb@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CAHmv74wK2NYuj2JuDUz-og5w+e=H1=ef9eCSMTbO6otaYQatKg@mail.gmail.com>
 <9172166a-eb77-a508-ba54-08fdf96912fc@lwfinger.net>
 <CAHmv74wNOM1QKUPp2Vax2Z+-JyoFC81WHVZ+XbYgiRMUGxCFUQ@mail.gmail.com>
 <9492be2d-abd1-0e1d-5d80-1a72b0250749@lwfinger.net>
 <CAHmv74x008FvhDztqOq-EC=d7fSXN7=kEOhQm3TPZn1PDZP=fQ@mail.gmail.com>
 <9b6f5c4c-2775-a5c2-0372-f8eb7ec18628@lwfinger.net>
 <CAHmv74x7VozPiC3D1c+hXbPPaiAQwaQ1Cpx7tqQFtpuWstj39Q@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <bef95201-9934-fc6c-416d-815ead3d2aa6@lwfinger.net>
Date:   Sat, 28 Sep 2019 11:31:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHmv74x7VozPiC3D1c+hXbPPaiAQwaQ1Cpx7tqQFtpuWstj39Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/28/19 6:51 AM, Sergey Kharitonov wrote:
> Dear Mr. Finger!
> Today's upgrade to linux 5.3.1 made the OEM Realtek driver (from
> rtl8192ee_revised_5.x.tar.xz) unusable.
> Current rtlwifi_new master and extended branches still contain old
> code which results in a high ping.
> Can you please somehow add your changes described above to git or wherever?

Those patches were mostly cosmetic and will not affect performance, b ut I will 
apply them.

This mailing list should be discussing the driver in the kernel, not an external 
one. Does the in-kernel version not work?

In addition, "unusable" is not a very descriptive term for a failure.

Larry
