Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670B448485B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jan 2022 20:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiADTNT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jan 2022 14:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiADTNS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jan 2022 14:13:18 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45981C061761
        for <linux-wireless@vger.kernel.org>; Tue,  4 Jan 2022 11:13:18 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f5so152367612edq.6
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jan 2022 11:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=uLWU2kAC9/lpUhLh3yvTIcB8Vh86j85qIHlZ+84XM1U=;
        b=k/yPdttxibP0/wvnnkHakFmndQ3tW+LAE37xWJEjlsOXESKRM+3Zpq+KIejSKvpKvs
         Az+OVxVQm2XtWOA5dZijh7qqxjQ3Kdyn0Yyp27MW8J8R6jpkNodqAVcY+dkEBYP+m9oW
         uOVOzNk3k2C/1vPNmi485ROvB4WEiVkU0b27cqJ0pBBMADS3sisgnIcKZfZrMGCqOrm1
         gEVWN9WjYQDTikgjGmt2QkIG9HLnC3MuQT2MOQmUCDf3QOX5/mLbvYOaWUpG5XKbvC6i
         XaKGHQt29ljZP0CTv9Ib/7VbKrTthgJhSbOy61w8YLcWgeRhbSuqTyAlbUZjPQmetbM2
         7YJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=uLWU2kAC9/lpUhLh3yvTIcB8Vh86j85qIHlZ+84XM1U=;
        b=gMxlLQYE3xAfkUZUJNbMWVAxfllB2dA0fzx8e2yyhTDhocA+/1DM/88dLrim+EJKaQ
         XaS0bnz25dTh4iZAKqvKjyHdcvGyITRfMJtU6rVCwxDGQFYE48avCjSUbcC+riBtKwlF
         aXQluXfpcdyymkLvcizh58/0ZDAh7GZ5OUlfvUWhkJJ2htiIHbBt9GQkiP36LB0nwX/8
         f+vOwQ3JgcVriO3SlCFQUl5y4uGpIEzT64kTPo/rOB1qZENM/YOSiRt+ZPpyXuiGQnm0
         GG4KQnEDIGmil1/DPqw0jdThHQZoiiISKQF4LiruSLb1zPVI/sWTX2kmMCoGUOQgGVP7
         g4Ng==
X-Gm-Message-State: AOAM530QFnaV3c6eTqqOXpucRTGTms5jYZ1BRTVzbhgaIT0C81C4wTS+
        nTNfcy5whvCxQChq1kE2gB+HqWAV1HY=
X-Google-Smtp-Source: ABdhPJwoKVvuLh+/WLUdHaue6WN/uCqNDid1aLQFHElzOrjOoDisryeD/OypyMAvf58LnRItfJOwNA==
X-Received: by 2002:aa7:dad0:: with SMTP id x16mr50339278eds.404.1641323596768;
        Tue, 04 Jan 2022 11:13:16 -0800 (PST)
Received: from [192.168.0.74] ([178.233.26.119])
        by smtp.gmail.com with ESMTPSA id gn15sm11609642ejc.184.2022.01.04.11.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 11:13:16 -0800 (PST)
Message-ID: <994addcb-a203-d718-fc92-c7f1d9ef05fb@gmail.com>
Date:   Tue, 4 Jan 2022 22:13:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: rtw88: EDCCA makes Wi-Fi unusable with a USB 3.0 SSD connected
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have a laptop with a rtw_8822be wireless card and boot Debian on it
from an external USB 3.0 SSD. I also configured the wireless regulatory
domain as TR (DFS-ETSI). Things worked fine this way until the v5.16-rc
releases where I have been practically unable to use Wi-Fi. The network
shows as connected but I can't load any website, pings to my router
mostly fail with "Destination Host Unreachable".

I tracked it down to commit 7285eb9693a2 ("rtw88: support adaptivity for
ETSI/JP DFS region"), tried the debugfs toggle mentioned in that commit,
and found a few more things that also work:

- echo 0 | sudo tee /sys/kernel/debug/ieee80211/phy0/rtw88/edcca_enable
- Connecting the SSD through a USB 2.0 hub
- Connecting the SSD to the port on other side of the laptop
- Putting my phone next to the display, "shielding" it from the ports

All combined lead me to think it's interference from USB 3.0 that's the
real cause of my problems.

I also see this mail on a previous version of the patch [1]:

> As mentioned in commit message, the debugfs is expected to be used when debugging
> in noisy environment. In that case, we think all rtw88 devices will probably
> be affected. Besides, we believe that turning EDCCA off is a temporary state under
> debugging.

[1]
https://lore.kernel.org/linux-wireless/61a242c186bf453d80820d81e1c48464@realtek.com/

So I'm not sure what to think and wanted to ask here. Is EDCCA
working-as-intended in my case, meaning I should fix my "noisy
environment"? Or is something wrong with the implementation that should
be debugged? I think it'll be very easy for other people to run into
this issue, maybe it should be disabled by default, or turned into a
module option?

Thanks in advance.
