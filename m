Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47596397A74
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 21:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhFATJu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 15:09:50 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:56250
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233397AbhFATJt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 15:09:49 -0400
Received: from outmx-113.london.gridhost.co.uk ([31.170.120.72])
        by : HOSTING RELAY : with ESMTP
        id o9jGlGsMmSM4yo9jGlVCuz; Tue, 01 Jun 2021 12:07:06 -0700
X-CMAE-Analysis: v=2.4 cv=HP0Gqqhv c=1 sm=1 tr=0 ts=60b6855a
 a=bR/twgNARhSa9iBq87+eLA==:117 a=bR/twgNARhSa9iBq87+eLA==:17
 a=IkcTkHD0fZMA:10 a=r6YtysWOX24A:10 a=xVuscgmnAAAA:8 a=lyDDaxLlA-2f4OJZ0zcA:9
 a=QEXdDO2ut3YA:10 a=vnkFwwgN4siT8HrQ9gDI:22
X-SECURESERVER-ACCT: alfonso@el-magnifico.org
Received: from localhost (localhost [127.0.0.1])
        by outmx-113.london.gridhost.co.uk (Postfix) with ESMTP id EAE6326EAFA2D
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 20:07:05 +0100 (BST)
X-Virus-Scanned: amavisd-new at example.com
Received: from outmx-113.london.gridhost.co.uk ([127.0.0.1])
        by localhost (outmx-113.london.gridhost.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qR-TECZLwhMT for <linux-wireless@vger.kernel.org>;
        Tue,  1 Jun 2021 20:07:05 +0100 (BST)
Received: from [192.168.1.99] (unknown [47.61.36.231])
        (Authenticated sender: alfonso@el-magnifico.org)
        by outmx-113.london.gridhost.co.uk (Postfix) with ESMTPA
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 20:07:05 +0100 (BST)
Subject: Re: rtl8822ce no bluetooh at all
To:     linux-wireless@vger.kernel.org
References: <6d9bc41f-cdfc-2ee5-22ff-72510e084dac@el-magnifico.org>
 <8a315442-db34-e3de-4455-dbc9a2891408@lwfinger.net>
From:   Alfonso <alfonso@el-magnifico.org>
Message-ID: <7bfef0a5-6bcd-a8fd-3f0b-f66bc09287d7@el-magnifico.org>
Date:   Tue, 1 Jun 2021 21:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8a315442-db34-e3de-4455-dbc9a2891408@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TSO-Authenticated: 
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4xfCmk//jLzkV+sHix1hJRJAZHHN64PcrkXpa8egG18LZm0lwCya5kmfRPhejTowzoWJfv5DOH2v18pan3GZuXc72EJWmd64DCODeNqeDmmObqpf7lQ+OH
 saCLCNpfi025QTlP/pKa8HDsu2BZi7Oae5p27scrK7sYv0vFVCDOfmVmVDa5JSJbhokqiFFpA5sgr+edbL40+D+ij/ZcQI2nqXg+S9Kby8XCm0AYriv8HxTr
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


El 1/6/21 a las 20:08, Larry Finger escribió:
> On 6/1/21 11:41 AM, Alfonso wrote:
>>
>> I have been fighting with this HP 250 G7 laptop for weeks, with no luck.
>>
>> It spors a combo wifi/bluetooth rtl8822ce 
>> (https://linux-hardware.org/?id=pci:10ec-c822-103c-85f7&page=3#status)
>>
>> Wireless works fine, but bluetooth is not detected, no hcix devices 
>> comes up, and obviously bluetooth utilities (hciconfig, rfkill) do 
>> not work.
>>
> Your dmesg and lsmod outputs do not show a BT driver loading. It is a 
> separate device from the wifi unit.
>
> Please reply with the output of 'lsusb'.

Sorry, but I sent a mere lsusb without -v flag. Please, check the 
attached verbose output.



