Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A85823DCCC
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Aug 2020 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgHFQz7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Aug 2020 12:55:59 -0400
Received: from pop31.abv.bg ([194.153.145.221]:39572 "EHLO pop31.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgHFQlP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Aug 2020 12:41:15 -0400
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop31.abv.bg (Postfix) with ESMTP id 51B201805D3F;
        Thu,  6 Aug 2020 14:34:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1596713698; bh=fEanfQHTLeoCEFY2iUpK0DmYNAcIKLmOTVFmX1WtktY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=iSl01t9b+qxRm01qqbR0HBZwuBuBQX9Czpsvoy418PyUFBGor3Pucdy35TH/TF2m0
         KH5+OG5BUILlPRKp6ME5D1QpOMj2H11VxA3rm6i695U6Xi0soBd6zN4KO7Sb9JbZ8N
         WJCc/QVA/DS8T3e9t/qmQHhjcXq7mIAe2TKugyus=
X-HELO: [192.168.1.110]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=buboleck@abv.bg
Received: from 46-249-79-198.net1.bg (HELO [192.168.1.110]) (46.249.79.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Thu, 06 Aug 2020 14:34:58 +0300
Subject: Re: RTW88 poor reception
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
References: <af8abf99-0cb0-ae18-e905-7bbf57270c82@abv.bg>
 <d9aa9251-cc63-1199-c011-5f34aaee5735@lwfinger.net>
From:   Dimitar Kosev <buboleck@abv.bg>
Message-ID: <3fd0fde7-8423-f2db-7ffb-92720442fe94@abv.bg>
Date:   Thu, 6 Aug 2020 14:34:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d9aa9251-cc63-1199-c011-5f34aaee5735@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Larry,

Please excuse my wrong wording. Below are outputs of iw dev wlan0 scan | 
egrep "signal|freq|SSID:", HUAWEIP10 is phone sitting next to the laptop:

 From rtw88:

         freq: 2462
         signal: -110.00 dBm
         SSID: HUAWEIP10

 From 8821ce:

         freq: 2412
         signal: -60.00 dBm
         SSID: test
         freq: 2412
         signal: -85.00 dBm
         SSID: TP-Link_B4EF
         freq: 2412
         signal: -82.00 dBm
         SSID: Kokiche
         freq: 2412
         signal: -84.00 dBm
         SSID: Crangon
         freq: 2412
         signal: -84.00 dBm
         SSID: 1e541423
         freq: 2412
         signal: -88.00 dBm
         SSID: Petya
         freq: 2417
         signal: -100.00 dBm
         SSID: TP-Link_84B4
         freq: 2427
         signal: -100.00 dBm
         SSID: gogolino
         freq: 2432
         signal: -79.00 dBm
         SSID: A1_0440
         freq: 2432
         signal: -88.00 dBm
         SSID: D_C
         freq: 2437
         signal: -72.00 dBm
         SSID: TP-LINK_25
         freq: 2437
         signal: -86.00 dBm
         SSID: Bi
         freq: 2437
         signal: -86.00 dBm
         SSID: p@co
         freq: 2447
         signal: -88.00 dBm
         SSID: DeathStar
         freq: 2447
         signal: -84.00 dBm
         SSID: M-Tel_577D
         freq: 2457
         signal: -92.00 dBm
         SSID: SHULEVI
         freq: 2462
         signal: -75.00 dBm
         SSID: linksys
         freq: 2462
         signal: -48.00 dBm
         SSID: HUAWEIP10
         freq: 2457
         signal: -86.00 dBm
         SSID: lonibo
         freq: 2462
         signal: -59.00 dBm
         SSID: GANEVI
         freq: 2462
         signal: -88.00 dBm
         SSID: WNO
         freq: 2472
         signal: -92.00 dBm
         SSID: Venci
         freq: 5180
         signal: -63.00 dBm
         SSID: 5G
         freq: 5200
         signal: -86.00 dBm
         SSID: bol-ml-yan
         freq: 2412
         signal: -87.00 dBm
         SSID: RADULOV
         freq: 2422
         signal: -100.00 dBm
         SSID: MLADOST
         freq: 2427
         signal: -80.00 dBm
         SSID: Alex
         freq: 2432
         signal: -88.00 dBm
         SSID: PetyaG
         freq: 2437
         signal: -84.00 dBm
         SSID: Tenda_2E0238
         freq: 2437
         signal: -87.00 dBm
         SSID: TP-LINK
         freq: 2457
         signal: -87.00 dBm
         SSID: MT4209
         freq: 2462
         signal: -90.00 dBm
         SSID: TatianaVulkova
         freq: 2467
         signal: -94.00 dBm
         SSID: A1_A1D815
         freq: 2472
         signal: -86.00 dBm
         SSID: All50_EXT
         freq: 2417
         signal: -88.00 dBm
         SSID: Jamal
         freq: 2432
         signal: -86.00 dBm
         SSID: VIVACOM_NET
         freq: 2462
         signal: -84.00 dBm
         SSID: Vivacom_wifi
         freq: 2462
         signal: -88.00 dBm
         SSID: TP-LINK_2136

Kind regards,

On 8/5/20 10:13 PM, Larry Finger wrote:
> On 8/5/20 2:00 AM, DImitar Kosev wrote:
>> Hello,
>>
>> I have RTL8821CE card and with this driver I get poor perception on 
>> 5GHz (2-3 meters max to the router) and only 30-50cm to the router on 
>> 2.4GHz. I'm currently using this driver 
>> https://github.com/tomaspinho/rtl8821ce that works fine but I 
>> understand it will be deprecated once RTW88 goes into the kernel.
>
> I think the word you want is reception not perception.
>
> Please quantify how bad your reception really is by running the 
> following commands and posting the output:
>
> iw dev | grep Interface
> sudo iw dev <DEVICE> scan | egrep "signal|freq|SSID:"
>
> where <DEVICE> is the interface name from the first command.
>
> Larry
>
>
