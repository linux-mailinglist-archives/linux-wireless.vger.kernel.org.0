Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6E397A68
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 21:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhFATHP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 15:07:15 -0400
Received: from a2nlsmtp01-01.prod.iad2.secureserver.net ([198.71.224.24]:44676
        "EHLO a2nlsmtp01-01.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233853AbhFATHO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 15:07:14 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jun 2021 15:07:14 EDT
Received: from outmx-113.london.gridhost.co.uk ([31.170.120.72])
        by : HOSTING RELAY : with ESMTP
        id o9ZWl6zM7UBP4o9ZWlsI6a; Tue, 01 Jun 2021 11:57:02 -0700
X-CMAE-Analysis: v=2.4 cv=I6+g+Psg c=1 sm=1 tr=0 ts=60b682fe
 a=bR/twgNARhSa9iBq87+eLA==:117 a=bR/twgNARhSa9iBq87+eLA==:17
 a=IkcTkHD0fZMA:10 a=r6YtysWOX24A:10 a=xVuscgmnAAAA:8 a=lyDDaxLlA-2f4OJZ0zcA:9
 a=QEXdDO2ut3YA:10 a=vnkFwwgN4siT8HrQ9gDI:22
X-SECURESERVER-ACCT: alfonso@el-magnifico.org
Received: from localhost (localhost [127.0.0.1])
        by outmx-113.london.gridhost.co.uk (Postfix) with ESMTP id 2AD2B26EAFA38
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 19:57:02 +0100 (BST)
X-Virus-Scanned: amavisd-new at example.com
Received: from outmx-113.london.gridhost.co.uk ([127.0.0.1])
        by localhost (outmx-113.london.gridhost.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dKM3Rn9hiYoS for <linux-wireless@vger.kernel.org>;
        Tue,  1 Jun 2021 19:57:01 +0100 (BST)
Received: from [192.168.1.99] (unknown [47.61.36.231])
        (Authenticated sender: alfonso@el-magnifico.org)
        by outmx-113.london.gridhost.co.uk (Postfix) with ESMTPA
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 19:57:01 +0100 (BST)
Subject: Re: rtl8822ce no bluetooh at all
To:     linux-wireless@vger.kernel.org
References: <6d9bc41f-cdfc-2ee5-22ff-72510e084dac@el-magnifico.org>
 <8a315442-db34-e3de-4455-dbc9a2891408@lwfinger.net>
From:   Alfonso <alfonso@el-magnifico.org>
Message-ID: <6a09991d-9e8e-fa31-ff6f-8b27f11e98f0@el-magnifico.org>
Date:   Tue, 1 Jun 2021 20:57:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8a315442-db34-e3de-4455-dbc9a2891408@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TSO-Authenticated: 
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4xfIr8dcQuXVUtdwpLJTnJGk6y1kfM4o5auMM+d+2muSNaBUrAwxD+Mc+qgpWgGBwcwRCXVh1dSzv9E2bSEkEX46vWpcSbSjxi+8xSuFB1vItAZJEmAjQA
 fmxP9g5R+XQGoM4Y9/RuWRg1FZqz/W8xm6NaZeADV5d2nKF2+09ykd8/gIMjnpgaLMGvh89c6b6VfYm0NgBYkmcdcmn04IigqIvHb+NQcbe2LfoEMSJ8L8HX
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
>>
>
> Your dmesg and lsmod outputs do not show a BT driver loading. It is a 
> separate device from the wifi unit.
>
> Please reply with the output of 'lsusb'.


Here you are:

Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 0408:5365 Quanta Computer, Inc.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

(I even suspected there is not a working bluetooth chip, but it works 
when I boot the preinstalled Windows 10)


