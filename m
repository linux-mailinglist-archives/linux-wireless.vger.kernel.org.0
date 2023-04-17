Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594C26E47F7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 14:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjDQMjJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 08:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjDQMjF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 08:39:05 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED1191
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 05:38:56 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:8212:0:640:cefe:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 224315E732;
        Mon, 17 Apr 2023 15:38:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pcaxmEtDeuQ0-L7XZqdLJ;
        Mon, 17 Apr 2023 15:38:51 +0300
X-Yandex-Fwd: 1
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass
Message-ID: <59bfee53-12c7-cde4-e9c8-1adcefff459f@16depo.xyz>
Date:   Mon, 17 Apr 2023 15:38:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [wireless-regdb] [PATCH] Update regulatory info for Russia (RU)
 on 6GHz
Content-Language: en-US
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
 <ZDtXkCWhUQnYlNMm@ubuntu-x1>
From:   Kirill <me@16depo.xyz>
In-Reply-To: <ZDtXkCWhUQnYlNMm@ubuntu-x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

You're right.

The main document that describe current regulatory rules is 
https://docs.cntd.ru/document/902048009?marker=65E0IS, with last version 
from 10 march 2017, but since than all changes in there are regulated 
and amended by decisions of "Main Radio Frequency Center", last one is 
https://docs.cntd.ru/document/1300597464, with status "Действующий" 
("Current").

List of all amendments are here: 
https://docs.cntd.ru/document/902048009?section=operative


On 16.04.2023 05:04, Seth Forshee wrote:
> On Sat, Mar 25, 2023 at 04:04:37AM +0300, Kirill wrote:
>> Update regulatory info for Russia on 6GHz in
>>   accordance with current regulatory rules.
>>
>> Source: https://docs.cntd.ru/document/1300597464?section=text
>>
>> Signed-off-by: Kirill Matvienko <me@16depo.xyz>
> 
> Thanks for the patch.
> 
> Based on the document I think the rule is right. My only question is
> whether or not this change is in effect yet. I ask because when I look
> at [1], which is the document amended by the document you linked to, I
> don't see this change. I'm not familiar with the process in Russia, so I
> just want to confirm that the change is in effect before we update the
> database.
> 
> Thanks,
> Seth
> 
> [1] https://docs.cntd.ru/document/902048009
> 
>> ---
>>   db.txt | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/db.txt b/db.txt
>> index 915a3b9..7f338b2 100644
>> --- a/db.txt
>> +++ b/db.txt
>> @@ -1500,11 +1500,12 @@ country RS: DFS-ETSI
>>   	# 60 GHz band channels 1-4, ref: Etsi En 302 567
>>   	(57000 - 66000 @ 2160), (40)
>>
>> -# Source: https://docs.cntd.ru/document/902048009?section=text
>> +# Source: https://docs.cntd.ru/document/1300597464?section=text
>>   country RU: DFS-ETSI
>>   	(2400 - 2483.5 @ 40), (20)
>>   	(5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, DFS
>>   	(5650 - 5850 @ 160), (100 mW), NO-OUTDOOR, DFS
>> +	(5925 - 6425 @ 160), (100 mW), NO-OUTDOOR
>>   	# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order
>> №129_22042015.pdf
>>   	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
>>
>> -- 
>> 2.34.1
