Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43DECE8B79
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 16:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389855AbfJ2PI1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 11:08:27 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:15383 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389730AbfJ2PI1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 11:08:27 -0400
X-Greylist: delayed 671 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Oct 2019 11:08:26 EDT
Received: from [10.1.14.125] (vpn.streamunlimited.com [91.114.0.140])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 472Zj46xyQz5tl9;
        Tue, 29 Oct 2019 16:08:24 +0100 (CET)
Subject: Re: [PATCH] wireless-regdb: Create entry for united European region
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
References: <bf327181-521b-e1ce-c5c8-81b828fc65b6@streamunlimited.com>
 <20190907235636.GA8256@ubuntu-xps13>
 <a5bdfce7-e974-37bb-c1d1-956d4572703c@streamunlimited.com>
 <39933518-6a65-fab3-4a66-8f44fc319d57@streamunlimited.com>
 <76f464e9-8806-ecbf-2dc8-67bb4190ecc7@streamunlimited.com>
 <20191029130853.GN30813@ubuntu-xps13>
From:   Emil Petersky <emil.petersky@streamunlimited.com>
Openpgp: preference=signencrypt
Message-ID: <31a00c5d-bb58-d423-d625-9ba4ebd177cc@streamunlimited.com>
Date:   Tue, 29 Oct 2019 16:08:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029130853.GN30813@ubuntu-xps13>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Seth,

it seems, that EU domain is advertised by APs/Routers here in Europe.
I know, that many clients use EU domain (at least internally in firmware) as well.
I would like to add it and use it along with setting for individual EU members.

I've made statistic of one WiFi scan in an apartment house in Vienna (Austria).
Results are:
35 x EU (Mostly UPC/Ralink Access points)
30 x no region info
 7 x AT
 3 x DE
 2 x NL

Thanks and best regards,

Emil





On 29/10/2019 14:08, Seth Forshee wrote:
> On Tue, Sep 17, 2019 at 11:55:07AM +0200, Emil Petersky wrote:
>> Create entry for united European region, as usage of frequency bands
>> is harmonized over EU and almost all CEPT countries as well.
>>
>> All EU countries and almost all CEPT countries accepted decisions
>> 2005/513/EC (5GHz RLAN, EN 301 893)
>> and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
>>  EU decision 2005/513/EC:
>> https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
>>  EU decision 2006/771/EC:
>> https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
>> Harmonized CEPT countries:
>> https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
>> Such decision make sense to create united European region (EU) in regdb
>>
>> United region for EU in regdb will enable much easier handling of proper
>> wlan parameters on embedded devices sold across the Europe.
> I'm a little curious about this one. I do agree that it would simplify
> things, but is an EU contry code something standard that wireless APs
> generally will advertise, or that clients will understand?
>
> And we do still have all the individual countries to maintain. Maybe it
> would make sense to define an EU region as rules that countries could
> inherit, and then have rules for any deviations from the common EU
> rules. Thoughts?
>
> Thanks,
> Seth


-- 
Emil Petersky

________________________________________________________________________

StreamUnlimited Engineering GmbH
High Tech Campus Vienna, Gutheil-Schoder-Gasse 10, 1100 Vienna, Austria
Office: +43 1 667 2002 4679 Fax: +43 1 667 2002 4401
Mail to: emil.petersky@streamunlimited.com
Visit us: www.streamunlimited.com

Meet us at:
CES - Las Vegas, 7 - 10 January, Westgate Hotel
ISE - Amsterdam, 11 - 14 February

