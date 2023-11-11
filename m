Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C77E8C1D
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Nov 2023 19:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjKKS3c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Nov 2023 13:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKS3b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Nov 2023 13:29:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D5385C
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1699727352; x=1700332152; i=wahrenst@gmx.net;
        bh=Ezn04tbMJPB0ULBtak0APzTueOcJfqR2nARbR0srsQA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=SXjSAXDrwPsKquf7MTLF+djVY6Y1rda3bVLX9poO0t5Y9MkdmMDhJ0wLtSHIcZkZ
         nTdsSdugt3ENXybTZFQ/Rkm0bqcEgaL/pcq4kprT5iBoRafIlq0ZMXhb0jSuidpUk
         vSFyC9UT644G0jmOQrIP3fpwr90RH8UPTsK1DYNIZ9V6fMxv0mXezJqKnX81mXM+o
         0pEbMlsvNpRVS3OoDFA54UXoGvVc459NrjTbzAzPi4is36Dx5xowwgJYI32HObRHD
         cOT+QyHeoh3MPjTlvKY6FeuKMZKHvPxT/xyqGLSmjYfL5WZ0RA+iu2g/6eevyNcGi
         4ZMoGNUv6FSnSKMwlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMfW-1rE1ng1elw-00EP8C; Sat, 11
 Nov 2023 19:29:12 +0100
Message-ID: <cb07408d-af14-4b01-bd96-15c480989643@gmx.net>
Date:   Sat, 11 Nov 2023 19:29:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Hector Martin <marcan@marcan.st>,
        Kalle Valo <kvalo@kernel.org>
References: <d9c9336a-6314-4de9-aead-8b865bb30f05@gmx.net>
 <18bbf6acf10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Language: en-US
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <18bbf6acf10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c71vQ9H9aivdA7LihBkVFSikuIF/2ilgYHY6mQ2wBGV8T2+gbpK
 jEA3/brGL9P43HQVeCfSyCNXc0yoLpcLWCbh0RIDM8Exs+A5ReHf4RM2DhFszPYXlWK24o3
 6vL7Y7rfc2yLN27gdDm6WE6rmLceQnO+5MEPtd0SrBBXWLwKvBmyJ8VDn5PAQ80NrrXuea8
 wygCtwJWwrgzFb2W4c/xg==
UI-OutboundReport: notjunk:1;M01:P0:xeTrXLSXzBw=;8YnIzexYyC3MkcCIDIeG+57z/WL
 U8J/l7PRvIcT/u8wuvrPdncxjkxIp7uSGJmRkWLOJHPX06oJvlHBgL+EXmAuumDHVIZyRr51T
 JumhCvBozt8hrIjq0orj9v2FgeG3l6hM6eGpSArrENj1t1iVMFQYofDlFSlNbIjZczr55xC/E
 keWEizLKF729V/pJva1dKd1ZxF6BQN8n/1V6zfy9ZPqizHrv5AX5zETqjdfc7mCOUl4KVLQAu
 gnHbUkNTOVuDfQCYIgcKx/w7WMFJ6laovW9fjeeXZtGTkMreQpsMxaLd2XBldQbvPqQfXNWiO
 noiPep0SlyYTmpJjltpDXps/6wjCE41Utigf4yQOaKntzQGoj6161UeC6bBmxZp5mhLKMEUWw
 7/I9y30wGKIZAy3fEqrnbplpWxl5FkPWm7qCmvFFk1jLJWAgXdAhQUPyuWFfTQrCFVOeLf4Yw
 Tehob999xZD0dsonTHpsExnyxwJCTVBuiFc6cTTfofiBmRcIucvkRgObT9so0VLTPyJymim+5
 oQKE90AZ2tVnJR0FLmruO/NEOc1mPUYGq3KzhCIR5L8f/HJsOG/S8RO50QkGA9N0jg8UO2NmA
 u72Y9sElT2lxsOPXt5tKDONVw6z5jEa9uF60MQp0IICD9dnjBZnBlxygIHIy17OPc5+BQphXF
 Ry+5ch/p+JfsdhbOFDoyzoHe6tvx+BYFtPCF37c3HA6XnfNTZ67vl0W0CfHko3gqZMvYBc/eM
 OKaieJe53HAcob/x2UUsEbSX9vaYfK54UrPckhbXdjMUApRLxzqCuEyKsaOQC7I+wOc5a8JBr
 8pcCBiDoARQtCZiDpde1E56pJaJjqz4osVwwuDYRWvLaRFqOr8cr9ODxLQds2/HTN0c+fLEus
 376zZaCaV6oR/o6GPb6/xwhTIAKV/o+qp3vbU+DVOXu+o9Y8wM83wVdSt+R+GhL3/E0XzjQOL
 NYnFZ5S0vgOSKSwD3zQPgYUPFHY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 11.11.23 um 18:25 schrieb Arend Van Spriel:
> On November 11, 2023 5:48:46 PM Stefan Wahren <wahrenst@gmx.net> wrote:
>
>> Hi,
>>
>> almost one year ago, i reported [1] about annoying log messages from
>> brcmfmac. After commit "wifi: brcmfmac: avoid handling disabled channel=
s
>> for survey dump" [2] the periodic messages disappeared, which is great.
>>
>> Unfortunately there is a different scenario, which still trigger them a=
t
>> least on the Raspberry Pi 3B+ (arm/multi_v7_defconfig). I tested Linux
>> 6.3, 6.6 and recent mainline.
>>
>> Used firmware:
>> Firmware: BCM4345/6 wl0: Jan=C2=A0 4 2021 19:56:29 version 7.45.229 (61=
7f1f5
>> CY) FWID 01-2dbd9d2e
>>
>> Scenario:
>> - start Raspberry Pi 3B+ with graphical interface
>> - wpa_supplicant successful connects automatically to WPA2 network
>> - disconnect from WPA2 network (no brcmfmac error messages until now)
>> - re-connect successfully to WPA2 network again (trigger error messages
>> once)
>>
>> Example output from current mainline:
>> [=C2=A0=C2=A0 87.449903] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
22 fail,
>> reason -52
>> [=C2=A0=C2=A0 87.559928] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
26 fail,
>> reason -52
>> [=C2=A0=C2=A0 87.669940] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
2a fail,
>> reason -52
>> [=C2=A0=C2=A0 87.779964] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
2e fail,
>> reason -52
>> [=C2=A0=C2=A0 89.539921] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
90 fail,
>> reason -52
>> [=C2=A0=C2=A0 89.540316] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
95 fail,
>> reason -52
>> [=C2=A0=C2=A0 89.540653] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
99 fail,
>> reason -52
>> [=C2=A0=C2=A0 89.540985] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
9d fail,
>> reason -52
>> [=C2=A0=C2=A0 89.541326] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
a1 fail,
>> reason -52
>> [=C2=A0=C2=A0 89.541662] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
a5 fail,
>> reason -52
>
> Again look like these are disabled channels. At least chanspec 0xd022
> is 5G channel 34. You say you get this only once so not every 60 seconds=
?
I get this everytime i trigger a reconnect to the wifi network, so not
periodically (checked that). Strangely the initial automatic connect
doesn't trigger this errors.

Regards
>
> Regards,
> Arend
>
>> Best regards
>>
>> [1] -
>> https://lore.kernel.org/linux-wireless/2635fd4f-dfa0-1d87-058b-e455cee9=
6750@i2se.com/
>>
>> [2] -
>> https://lore.kernel.org/linux-wireless/2635fd4f-dfa0-1d87-058b-e455cee9=
6750@i2se.com/
>>
>
>
>

