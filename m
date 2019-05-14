Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA71C482
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 10:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfENIRQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 04:17:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40894 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfENIRP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 04:17:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so18101516wre.7
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 01:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qhb/41FDEzVVSG2oq29fq+V0J1c955oqN4XMOiOUcJ0=;
        b=oe/9iARiGFwDztr5sO0EsirHAkk0ywLQj50w1bbOOQPCwvBd0SH1vj4a0B03mmmZ7t
         mR2fkTeYHXCWL5fncr5FYG43vWq/d3X65k3ZuWKVJYVzlMWM89EWj6MAO4TJQVbYkkA/
         CbnWOW6PRTKom7m+Arq3UB0VJxUHiNy85H81Kmx9I9ek/LpoifKm2nP6xCOofjwb3jSP
         GgrgCpXoYWm8+sHnKCPWLJmdQMc87UmG6oW0O6eNqguRbENG+ES+6KMo9cDooV6HdNVA
         XaRv3N73ltAAJ+djFRktZPSMHBeDDltzIw5goxVXr1MqBgRt8eRNUaMfFcYHvo2E2DRz
         WXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qhb/41FDEzVVSG2oq29fq+V0J1c955oqN4XMOiOUcJ0=;
        b=G7q/+kkqBEcf/j5lVkmXmlaBQlV0lfXtk5qlRODMfySJCfmwwkROAYWu2/7UKJWM/u
         arUYfs5PSpe8FoWSIImZQYVNkVFUrzWsZBL8DnQY/0NqV8KsI1tBpRh5U7Gp8ZhiOqag
         RsyvbQ7M+toVobKXsIe3XqyGmmsKxuLCH9RYQvONnU21xPFbTNACQ4w1ismYHG4XW0z9
         Oj/VkFS64a9KTCA4jYonWRhSZXib+kv1VOi/CafkEGvnmgx0yKTQ2lHIhLs+wqMABDbJ
         4JnnCV7W4ai/m2hEr8ReFI52FdPG2Ri5W3NW2k10Q0btJNEGxVSs73maeIr4jc2ztiXK
         GQbg==
X-Gm-Message-State: APjAAAXl1EUWtl1pKPaFx6cFg6Xln+G+QN7C00GlevWW/EYNzIEqFbzj
        OjSFrk026lX+NRLIczLbDzupYA==
X-Google-Smtp-Source: APXvYqx6bebFATEneaIDaQrTJuzF1tbRVVXqzquT7I64QS8c1tlnE7SIYT3a+ChSxVT3Y5NE5cPeIw==
X-Received: by 2002:adf:fb47:: with SMTP id c7mr6059253wrs.116.1557821834201;
        Tue, 14 May 2019 01:17:14 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id h15sm10686086wru.52.2019.05.14.01.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 01:17:13 -0700 (PDT)
Subject: Re: NXP NFC version and ACPI
To:     sedat.dilek@gmail.com
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        oleg.zhurakivskyy@intel.com, clement.perrochaud@effinnov.com,
        charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
 <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org>
 <CA+icZUXDLQKyTH-_pPi7A2=Bu5ratwab930Fcecrdr4NtMnFcw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <27f2ce02-8deb-384f-af10-7737b703770a@linaro.org>
Date:   Tue, 14 May 2019 10:17:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+icZUXDLQKyTH-_pPi7A2=Bu5ratwab930Fcecrdr4NtMnFcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14/05/2019 09:49, Sedat Dilek wrote:
> On Tue, May 14, 2019 at 8:43 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> [...]
> 
>> The nxp-nci kernel module is loaded and neard is installed.
> 
> You have to...
> 
> # modprobe -v nxp-nci_i2c
> 
> # lsmod | egrep 'nfc|nci|nxp|i2c' | sort
> i2c_algo_bit           16384  1 i915
> i2c_dev                24576  0
> i2c_i801               32768  0
> nci                    77824  2 nxp_nci,nxp_nci_i2c
> nfc                   131072  16 nci,nxp_nci
> nxp_nci                16384  1 nxp_nci_i2c
> nxp_nci_i2c            16384  0
> rfkill                 28672  10 nfc,bluetooth,thinkpad_acpi,cfg80211

I have the same modules except 'rfkill'

> # modinfo nxp_nci_i2c
> filename:
> /lib/modules/5.1.1-1-amd64-iniza/kernel/drivers/nfc/nxp-nci/nxp-nci_i2c.ko
> author:         Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
> author:         Clément Perrochaud <clement.perrochaud@nxp.com>
> description:    I2C driver for NXP NCI NFC controllers
> license:        GPL
> alias:          i2c:nxp-nci_i2c
> alias:          acpi*:NXP7471:*
> alias:          acpi*:NXP1001:*
> alias:          of:N*T*Cnxp,nxp-nci-i2cC*
> alias:          of:N*T*Cnxp,nxp-nci-i2c
> depends:        nci,nxp-nci
> retpoline:      Y
> intree:         Y
> name:           nxp_nci_i2c
> vermagic:       5.1.1-1-amd64-iniza SMP mod_unload modversions

Same result for the modinfo.

-----

So the first time I run:

[mark]
nfctool -d nfc0 -p
Start polling on nfc0 as initiator

With an error in syslog/dmesg:
nci: nci_ntf_packet: unknown ntf opcode 0x0


The second time:

nfctool -p -d nfc0
Protocol error

With an error in syslog/dmesg:
nci: nci_start_poll: failed to set local general bytes

Then I do:

nfctool -0 -d nfc0

it returns to point [mark]




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

