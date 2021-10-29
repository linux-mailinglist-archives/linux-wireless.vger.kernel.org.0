Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0243FEFE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 17:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhJ2PHj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Oct 2021 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhJ2PHe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Oct 2021 11:07:34 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Oct 2021 08:05:05 PDT
Received: from simonwunderlich.de (unknown [IPv6:2a01:4f8:c17:e8c0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00721C061766
        for <linux-wireless@vger.kernel.org>; Fri, 29 Oct 2021 08:05:05 -0700 (PDT)
Received: from [IPv6:2003:c5:973a:b0b8:1f6e:7eaa:c693:97eb] (p200300c5973aB0B81F6e7eAAC69397EB.dip0.t-ipconnect.de [IPv6:2003:c5:973a:b0b8:1f6e:7eaa:c693:97eb])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by simonwunderlich.de (Postfix) with ESMTPSA id 3A4A7FA152;
        Fri, 29 Oct 2021 16:55:18 +0200 (CEST)
Subject: iw reg get Not showing 6GHz channels in Germany
From:   Sharadanand Karanjkar <sk@simonwunderlich.de>
To:     luciano.coelho@intel.com
References: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de>
Cc:     linux-wireless@vger.kernel.org, se@simonwunderlich.de
Message-ID: <dd512568-9d9f-289a-bc7b-9b6dfc1c0c8a@simonwunderlich.de>
Date:   Fri, 29 Oct 2021 16:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Hi Luca,
>
> Greeting of the day!!
> We are using Intels "ax210ngw" card with "iwlwifi-ty-a0-gf-a0-66.ucode"
> firmware, we are using the kernel from "5.15.0-rc7" tag.
> The problem we are facing is we are not able to enable 6GHz channels 
> for Germany region. Following is the output for "iw reg get"
>
> country DE: DFS-ETSI
>     (2400 - 2483 @ 40), (N/A, 20), (N/A)
>     (5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
>     (5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
>     (5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
>     (5725 - 5875 @ 80), (N/A, 13), (N/A)
>     (5945 - 6425 @ 160), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
>     (57000 - 66000 @ 2160), (N/A, 40), (N/A)
>
> phy#0 (self-managed)
> country DE: DFS-UNSET
>     (2402 - 2437 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, 
> NO-80MHZ, NO-160MHZ
>     (2422 - 2462 @ 40), (6, 22), (N/A), AUTO-BW, NO-80MHZ, NO-160MHZ
>     (2447 - 2482 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS, 
> NO-80MHZ, NO-160MHZ
>     (5170 - 5190 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW, 
> IR-CONCURRENT, NO-HT40MINUS, PASSIVE-SCAN
>     (5190 - 5210 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW, 
> IR-CONCURRENT, NO-HT40PLUS, PASSIVE-SCAN
>     (5210 - 5230 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW, 
> IR-CONCURRENT, NO-HT40MINUS, PASSIVE-SCAN
>     (5230 - 5250 @ 160), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW, 
> IR-CONCURRENT, NO-HT40PLUS, PASSIVE-SCAN
>     (5250 - 5270 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, 
> PASSIVE-SCAN
>     (5270 - 5290 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, 
> PASSIVE-SCAN
>     (5290 - 5310 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, 
> PASSIVE-SCAN
>     (5310 - 5330 @ 160), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, 
> PASSIVE-SCAN
>     (5490 - 5510 @ 220), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, 
> PASSIVE-SCAN
>     (5510 - 5530 @ 220), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, 
> PASSIVE-SCAN
>     (5530 - 5550 @ 220), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, 
> PASSIVE-SCAN
>     (5550 - 5570 @ 220), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, 
> PASSIVE-SCAN
>     (5570 - 5590 @ 220), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, 
> PASSIVE-SCAN
>     (5590 - 5610 @ 220), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, 
> PASSIVE-SCAN
>     (5610 - 5630 @ 220), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, 
> PASSIVE-SCAN
>     (5630 - 5650 @ 220), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, 
> PASSIVE-SCAN
>     (5650 - 5670 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, 
> NO-160MHZ, PASSIVE-SCAN
>     (5670 - 5690 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS, 
> NO-160MHZ, PASSIVE-SCAN
>     (5690 - 5710 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40MINUS, 
> NO-160MHZ, PASSIVE-SCAN
>     (5735 - 5755 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, NO-160MHZ
>     (5755 - 5775 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS, NO-160MHZ
>     (5775 - 5795 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, NO-160MHZ
>     (5795 - 5815 @ 80), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS, NO-160MHZ
>     (5815 - 5835 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS, 
> NO-80MHZ, NO-160MHZ
>
> The iw phy# info also shows that the 6GHz channels are not enabled. We 
> have found one commit which is included in the "5.15.0-rc7" tag which 
> indicates that 6Ghz channels are now supported in the driver.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/commit/?id=cdf854d2ddca01bf126ac138a8ee3e5d6320086f 
>
>
> From "iw reg get" output it looks like the intel firmware may not be 
> supporting the 6GHz channels.
> When we can we expect the support for 6GHz channels for Germany?
>
> Warm regards,
> Sharadanand Karanjkar
>
