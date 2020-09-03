Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2284025C8AB
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Sep 2020 20:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgICSYF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Sep 2020 14:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgICSYE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Sep 2020 14:24:04 -0400
X-Greylist: delayed 1575 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Sep 2020 11:24:04 PDT
Received: from mxout012.mail.hostpoint.ch (mxout012.mail.hostpoint.ch [IPv6:2a00:d70:0:e::312])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928BC061244
        for <linux-wireless@vger.kernel.org>; Thu,  3 Sep 2020 11:24:03 -0700 (PDT)
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1kDtUV-000F7K-Cr; Thu, 03 Sep 2020 19:57:43 +0200
Received: from [2a02:168:6182:1:cc67:a302:1515:9064]
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1kDtUV-000MML-A1; Thu, 03 Sep 2020 19:57:43 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
Subject: Re: [PATCH v2 0/1] Updating RTL8192CU firmware
To:     linux-firmware@kernel.org
Cc:     linux-wireless@vger.kernel.org
References: <20200323024500.4090-1-code@reto-schneider.ch>
 <20200323225809.11594-1-code@reto-schneider.ch>
From:   Reto Schneider <code@reto-schneider.ch>
Autocrypt: addr=code@reto-schneider.ch; prefer-encrypt=mutual; keydata=
 mDMEXsRRExYJKwYBBAHaRw8BAQdAvw3GH8aeA8Pay1QqPdjlETAUDAa8WmHHXZRDk5a0DHa0
 J1JldG8gU2NobmVpZGVyIDxtYWlsQHJldG8tc2NobmVpZGVyLmNoPoiYBBMWCgBAFiEEP2/t
 baSDn9KAkTQyv7k+j0IlhuAFAl7EURMCGwMFCQWjmoAICwkNCAwHCwoFFQoJCAsEFgMCAQIe
 AQIXgAAKCRC/uT6PQiWG4IsVAP9xonMRrcrTBWFxPMjEYVWUMHi8BssqkzMdc1QQXwpCKwEA
 qdBF1odOUr4SUHVQmadIE5eRpF9MbyBMQdR3ms8DrQ64OARexFETEgorBgEEAZdVAQUBAQdA
 6PW5+rUjfrKbl3623SR35Drobzij2XjkGFY6zswMz3EDAQgHiH4EGBYKACYWIQQ/b+1tpIOf
 0oCRNDK/uT6PQiWG4AUCXsRREwIbDAUJBaOagAAKCRC/uT6PQiWG4IyHAQCqmjwBTGyVAfLZ
 OVQSUPqSlu/RGcCWPQFEXP+Be2mdNQEA05ScK4+GgAShVE8wUObbpjdl/u5djZF8hEGQR3Ke Vws=
Message-ID: <2dcb37a5-7d55-716c-bedf-d1270700efab@reto-schneider.ch>
Date:   Thu, 3 Sep 2020 19:57:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200323225809.11594-1-code@reto-schneider.ch>
Content-Type: multipart/mixed;
 boundary="------------A04EF9B4F11FD0BE0C4473A9"
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------A04EF9B4F11FD0BE0C4473A9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 3/23/20 11:58 PM, Reto Schneider wrote:
> Before this update, with version 80 of the firmware, the USB interface
> of the RTL8192CU WLAN controller often locked itself up:
>  usb 1-2: device descriptor read/64, error -110
>  usb 1-2: device not accepting address 4, error -110
>  usb 1-2: device not accepting address 5, error -110
>  usb usb1-port2: unable to enumerate USB device
>  usb 2-2: device descriptor read/64, error -110
>  usb 2-2: device descriptor read/64, error -110
> 
> On ARMv5 based GARDENA smart gateway running Linux 4.19.78, this can
> be reliably reproduced by rebooting (warm) the gateway multiple times
> (max. 50 attempts needed).
> Unlike users having this issues on a USB Wi-Fi dongle, resetting of the
> chip by replugging is not an option on this gateway due to the lack of
> any power cut functionality. Therefore, a (cold) reboot of the whole
> gateway is needed.
> 
> Updating the firmware of the RTL8192CU WLAN controller from version
> v80.0 to v88.2 (as per output of rtl8xxxu, which was used temporarily)
> seems to resolve this issue. The problem did no show up anymore for 1000
> restarts.
> Please note that only rtl8192cufw_TMSC.bin has been tested.
> 
> Unrelated of this USB problem, another issue still remains: Using the
> rtl8192cu driver, scanning for available SSIDs yields no more results
> after a few hundred scans (iw wlan0 scan).
> 
> Also, the Realtek drivers containing v88.2 of the firmware
> (v4.0.1_6911.20130308 to v4.0.9_25039.20171107) have some changes
> compared to the version v3.4.2_3727.20120404, for which I am unsure of
> whether they need to be reflected in rtl8192cu and/or rtl8xxxu.
> What I could spot for sure however, is that some tables have been
> updated:
>   https://github.com/rettichschnidi/linux/commit/0c865ba26aba907b601b3b73c82111dd10e59ffe
> 
> I am unsure if this changes are relevant and how the best way would be
> to ensure that this commit does not break old drivers out there.
> 
> Reto Schneider (1):
>   rtlwifi: v88.2 firmware files for RTL8192CU
> 
>  WHENCE                       |   6 ++++++
>  rtlwifi/rtl8192cufw_A.bin    | Bin 16116 -> 16126 bytes
>  rtlwifi/rtl8192cufw_B.bin    | Bin 16096 -> 16096 bytes
>  rtlwifi/rtl8192cufw_TMSC.bin | Bin 16116 -> 16126 bytes
>  4 files changed, 6 insertions(+)
> 

Is there anything left I need to do in order to get this patch merged?

Reto

--------------A04EF9B4F11FD0BE0C4473A9
Content-Type: application/pgp-keys;
 name="0xBFB93E8F422586E0.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0xBFB93E8F422586E0.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mDMEXsRRExYJKwYBBAHaRw8BAQdAvw3GH8aeA8Pay1QqPdjlETAUDAa8WmHHXZRD
k5a0DHa0J1JldG8gU2NobmVpZGVyIDxtYWlsQHJldG8tc2NobmVpZGVyLmNoPoiY
BBMWCgBAFiEEP2/tbaSDn9KAkTQyv7k+j0IlhuAFAl7EURMCGwMFCQWjmoAICwkN
CAwHCwoFFQoJCAsEFgMCAQIeAQIXgAAKCRC/uT6PQiWG4IsVAP9xonMRrcrTBWFx
PMjEYVWUMHi8BssqkzMdc1QQXwpCKwEAqdBF1odOUr4SUHVQmadIE5eRpF9MbyBM
QdR3ms8DrQ6JBDMEEAEKAB0WIQSFisjcAbXygLdCF5idCQqRW3uL0QUCXugG0wAK
CRCdCQqRW3uL0bVEIACky49htfjxJs5UEZjFEiPH2e8vVngQ1Tczr4w6ZITcenht
qpBhEL1rtO8AabYsoG1JIwfsj9mRrxsN42ELcRr9fltsDdkJZkeUkx2MeTEQQE+1
COK7LR919pB+JtJYTId0+PnMgQ1ZOm42h1ihw9GKn66lJcBwYo46g7gKqwZte60P
VSZd72IbxeI9DFKstl17LbIg5wTkps63H3RImIgbPVjwzZQv8DDG1fZAaV2F1wwc
+orEfi75IT4SgVJEPID5o/zccEOR4C0CijCCrwpy4NckmdVYS4BFKmwFNoXeuzTz
Ha/RBUB4EWwbxHjPv36gJ791N7/9rk1CEz03oALCDp+JgvjZ3XsoMwPLn/NIL8aH
GMxv6At++zmm2SnYNOpQ+Ax+4sS/wULfubLZnEQqV+sTxko7mReEEjtMtucth935
KzGXzpR6EAqy+7EwwezOS2H4i8G7Po67BVCBmYQSjgYHJBmSPZdd6G0sftRqh+RE
tzbxk467rLn+OYVXWBH6rp0lsyJ17fwmcJkqgK9cOgmGbFHWSzOBFB9c6og8mJ3V
+xGvDzINqDUQjKAz+vVEgh2hto5FHZpBpYVzPYL7k/IcKvMi3H6rXrh4LEGLirIL
BUChQ3+UCTo2vKTgva0w/sPJit5vN9TyZaCADfiDP1N74YIHI452MRgQyxlnWM2G
8eUSJxsWF8tqjZTlB9IZEFmKevtI7dlIZEclth3eKhHZQz1GW4LPc4WTsRwKwhBR
J5h8u54lIuM/RiZB1VYEIc9toM7E2SIdN4Fl59V8S1XABOciGmw0VizAmi5pG63l
vxQlD0a08uF/7BEOdTxG3SHucf2A60BNmZFXOd+zYdpTBUQmjEf0zCdwg1jl+O5m
LRyeezvGY9QTUK0SmHWg9BwQfYm09QJffxnS8kZk3DHaQd7uJHIcmuw5B7Syq7xG
23VVrFcOWHpaAFI95tJ0HunkxufEVLmn/RMdnZBEW41l2CFeLlFeoQgNhYcH+/Tw
ZTDoKEcTY44Ol/XhEsGC/TMavCEOOCThCVjfAapBgMlop6M0nw0e+wcGQQi1t8ci
zIvyfP3+0TKZrGv2BHNfrBEgh1yohCPoU9lBQu7JUUt2XZmt7lICeE5XbMAg7IJ7
4eK7NYStzeRKfgtP6sTiRAKjy9wiQCARjAb/LtxOLQqWIIPT/Jc444Vm+daWimsG
f2Usmzt8KiaWnRaFtrwyF4aQSNKuSTmtOz0ItJANPchfYFadS1E1rOYeffQQnyzW
mvLp8tjyYYs4r5Y5d5PEWypQpgJg9a+i2gmXHQJ7cQmHEBVn8WfDJP0R3QXAuvG3
EoR5sSz6ieSdcXktDgNKTMNENjYlwLGEJN357Z8wuDgEXsRRExIKKwYBBAGXVQEF
AQEHQOj1ufq1I36ym5d+tt0kd+Q66G84o9l45BhWOs7MDM9xAwEIB4h+BBgWCgAm
FiEEP2/tbaSDn9KAkTQyv7k+j0IlhuAFAl7EURMCGwwFCQWjmoAACgkQv7k+j0Il
huCMhwEAqpo8AUxslQHy2TlUElD6kpbv0RnAlj0BRFz/gXtpnTUBANOUnCuPhoAE
oVRPMFDm26Y3Zf7uXY2RfIRBkEdynlcLuDMEXsRXsRYJKwYBBAHaRw8BAQdAIzDP
pDZujB6IFAWcsPBbsAEJq5NC5ots3abKu6FhysGIfgQYFgoAJhYhBD9v7W2kg5/S
gJE0Mr+5Po9CJYbgBQJexFexAhsgBQkFo5qAAAoJEL+5Po9CJYbg3RIA/jPYc3vk
04vxT6os5ZNA0cFb55kKMQ6+EdXSeEfpm4TlAP0cn300BJOpEYkklTo8E+lpNp5b
XpxTgY94Its7BZwpBw==
=1Ttn
-----END PGP PUBLIC KEY BLOCK-----

--------------A04EF9B4F11FD0BE0C4473A9--
