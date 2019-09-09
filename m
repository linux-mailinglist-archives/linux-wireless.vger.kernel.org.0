Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA7DADC39
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 17:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbfIIPiH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 11:38:07 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43952 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbfIIPiH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 11:38:07 -0400
Received: by mail-ot1-f48.google.com with SMTP id b2so12847328otq.10
        for <linux-wireless@vger.kernel.org>; Mon, 09 Sep 2019 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K1xwi8+JOCMR2E8JkZppzCdMLdyqRwmm4CxCMDZeHO0=;
        b=qet3NXCtw+8vuwQdsL0WdyKQFseT/OvWmtTTNNZObZIMvWCIpp6MEaaFbEBUKuExJV
         djS5wLBsi9b7NR6Si+kwBltTtnO2Ea08sF5Cl0J3j/TnTuhURaR6d1sNzkJnqQBD49xb
         KYhrTODESyNrkIO3/Cid6wuZNyNl7YNxaXTilvuWxCUNcQVUnLf1yoCEC9F+nNEG8PuF
         bk7jIsDPJX3U2jB9RIZYV/wzSHt/KcfHChzraTMwhPhI+1rTbLIYLo65nrA2OUNjPZqg
         C1dhqsYZhrDzaDYwR8xnbXMqYtgyQO72uiSaXXNtiGvIl1gHXMjzDtVhzGGUZhtEfmJO
         MB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K1xwi8+JOCMR2E8JkZppzCdMLdyqRwmm4CxCMDZeHO0=;
        b=XUZWWuzmGEkJf9w8wAlyMIJzNUxVEis+mUEzAUG2tn3hUMMTBrY0QkadxBGnXWva5l
         hF1SULc8iP8WF+lU/NALEY28ISLPcuCbRciwSsOfu7N7PQoQ+VPggNp4MgFbQLDVXLv9
         OadTWVRBLKVr5l9b0el5ZUHEeXgIdabBW6NB1EUEnEFerBXEfsVivSQWdgUP2PqXvcD5
         d+cA0lpFp7ODsIIVJ3d+dos5414OH120FrBwpXEXrZJbGR8ppa1/lpp+L69YJ/NxtJMh
         PE+MLqNdTUBUq1E8EEecL7jHpy/GAPByDV72YRlyHL9xsWLwZEIZ20N3d6nvX7WAdSxh
         ad3g==
X-Gm-Message-State: APjAAAVoNHxQkUup1VR2snpWZr0b8gCbrVHUK6oCI3c5Dgr2PfN7UJIj
        QSr+IWcLF7tP4G1tTJsAZSW51lMu
X-Google-Smtp-Source: APXvYqwGgW5GDz+cVgim42KMyGUub+AmR/B9B2Zff5WHtR/pGURECji3c5XmnPa+HeL54qcDJ52pCg==
X-Received: by 2002:a05:6830:1643:: with SMTP id h3mr4362844otr.170.1568043485975;
        Mon, 09 Sep 2019 08:38:05 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k2sm4555789oih.38.2019.09.09.08.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 08:38:05 -0700 (PDT)
Subject: Re: Fwd: Asus x540m - RTL8723befw.bin and rtl8723befw_36.bin
To:     Joerg Kampmann <kampmann@ibk-consult.de>,
        linux-wireless@vger.kernel.org
Cc:     kyle@kernel.org
References: <ql15114vjvsd2m1ywuv1u1b1.1565285708045@email.android.com>
 <12353dc2-5beb-7d65-54ee-5dd6cdd4fc47@ibk-consult.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <746c6c58-04a1-42b6-9657-197677d173cd@lwfinger.net>
Date:   Mon, 9 Sep 2019 10:38:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <12353dc2-5beb-7d65-54ee-5dd6cdd4fc47@ibk-consult.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/9/19 9:32 AM, Joerg Kampmann wrote:
> Hallo I just posted a remark on Github concerning the above firmware! I applied 
> it on Debian 10 (buster) Linux ... Any idea on the causes of the fault? 
> *firmware is too big*
> 
> The machine is a notebook from ASUS: X540M - this notebook has only 3 USB-slots 
> no LAN, no CD drive -- Debian buster requires during installation: rtlwifi/

No. Both those firmware files work just fine on my openSUSE system.

The md5sums for the firmware are as follows:
1850c1308fbcd95e9f6a7f58ede1e35f  /lib/firmware/rtlwifi/rtl8723befw_36.bin
a2c544e90d41fa9097b18ba86f11bec9  /lib/firmware/rtlwifi/rtl8723befw_36.bin.xz
bc828ddc6cd700abb79a8df5794bcf04  /lib/firmware/rtlwifi/rtl8723befw.bin
7c310f301623cf16211ef5b4a3a3078d  /lib/firmware/rtlwifi/rtl8723befw.bin.xz

The sizes for the uncompressed modules are:
31762 /lib/firmware/rtlwifi/rtl8723befw_36.bin
30746 /lib/firmware/rtlwifi/rtl8723befw.bin

Larry



