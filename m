Return-Path: <linux-wireless+bounces-9316-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E48C0910DFC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 19:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D706B209ED
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65511AF6A1;
	Thu, 20 Jun 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MVbwBXxx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4961AE875
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903086; cv=none; b=rt4Q3G/PpJuQxxxU9u1FAUtgdfy8ElN8Zk2Dekp5yi2SuDOmHyd31OY76p2h88hMIWeWZTDdxUqqr7qc7Nw71FoMzLTj8NgIOsrqGiJ1f4B1ckgXPYaIO8gAy6BfJdN/Oo1vE5SRVrkU4yn2myQ7XNkGcX1qjqanVsqV7cU3fMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903086; c=relaxed/simple;
	bh=xbJ9v2IfNpDkUV2B2UGZ1RunE8rpslX5uJMki/ceCaE=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Znz0FLaPsgU7FlEd2YKxa4fcUGoH7R3iNWWeHOEalnEbpye99V154NfXtZMHffhs0k0eiXrkBVR/zIrcwTUoA/AFYb2ePyIndvpfvp9JeeGW2BpoIKLnhzcSYndBCwnO1oxf6tHENpVeUGlQBA7VKZDsdW80/p3AhLfiebIq0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MVbwBXxx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f09b457fdso121843666b.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718903083; x=1719507883; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWKcWJHSm7a5JIbGX249WQDTP2I/vCwsB18uAinuTZI=;
        b=MVbwBXxxM9S7I6jHthuhwYEKuXG5i+o3kh6L6W66QP1HssdcKSYyxQJqAcLuhkeXqh
         shIdU7/V7QVbJeRl6iu7AKVQN3xv4GMVLfS97esaU5yhtrAuI82xTaxeeqNtd9iD47Cb
         Y/KwlTJ9DB1zVSoMFV2FZruRf01kduqRW5Zbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718903083; x=1719507883;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWKcWJHSm7a5JIbGX249WQDTP2I/vCwsB18uAinuTZI=;
        b=Pc2cIg0kpMt+I3LdUgmlzXlg52Td3L/7MWvJx5u3BeH9h92KI0ypAHU+VTIj3vVDxv
         I29U7GMwYISlBUxNpEFroLnimPtpaFgupR07yQxAOnoRooaAHq1dY6R4qV9rgp0kvK31
         Ejfp09fwJexqfWHFZJ3hxxmWCg/1TjOuVrq8Ux2z+TgYhIAkHjQy5lcviK4sM+NXzKF1
         Yb06RXY+NG3p9JUpqQCWNx9gJhVe+JlVY/V9zr0/19ygUg7B5ttF65CAX+nwJO55Vdv9
         Smmon01rkNDHIyg8MQ1mwVxmrGiN2sN6ukmpA/i0FSd/5qmh76NvOz+eutNeyU1eTbvB
         n2dA==
X-Forwarded-Encrypted: i=1; AJvYcCVlfW4LuQ3IMZ26iJy/7dK2Jpwz/YpuCWlM2DrjXGrByrofazKVTs6d85W9H4vIdOsaIpI2z8Ltve+M5Cv/U5CXgOTa7vRa2KLi/YS5Ov4=
X-Gm-Message-State: AOJu0YwjZ86+jR2DBmHz48zQ63xS/I7pVAtIKvexDTmWtPSQIYb1/+aW
	CMRaE3UsP5Q/LDNGKehJWgGqoaSSmED0i0DtjvyFGJQN8qYALsGVWMTwuXNAMQ==
X-Google-Smtp-Source: AGHT+IEl/1o2pt8N1B5OyLEYGoj5X0yy/yK3Tk64mObbSQoCLEbHn1J4DrtuK3+ovpyDQFaEqK5X0g==
X-Received: by 2002:a17:907:a684:b0:a6f:6078:6e71 with SMTP id a640c23a62f3a-a6fab6072edmr532897066b.8.1718903083044;
        Thu, 20 Jun 2024 10:04:43 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5bafsm787499966b.50.2024.06.20.10.04.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 10:04:42 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>
CC: Peter Robinson <pbrobinson@gmail.com>, Julian Calaby <julian.calaby@gmail.com>, Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>
Date: Thu, 20 Jun 2024 19:04:42 +0200
Message-ID: <190369b8c10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAG17S_NBO=tTBp9GX=S9C4REbT-Gx634n66+7JERcWbe-KXt-g@mail.gmail.com>
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
 <CALeDE9O7DCPhoxdMyHmYFOjwdkPRepiaaC92QorzSTXCduZ+xQ@mail.gmail.com>
 <CAGRGNgWH9U3XeatXA9xpkLz76COuL1xjYcfXQYLTGKBxvy=M-A@mail.gmail.com>
 <CALeDE9M78so=roEFion9GGo4tV7c+M885=ZNZgi9zKyBur+iMQ@mail.gmail.com>
 <190355aedf0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NBO=tTBp9GX=S9C4REbT-Gx634n66+7JERcWbe-KXt-g@mail.gmail.com>
User-Agent: AquaMail/1.51.3 (build: 105103473)
Subject: Re: [PATCH] wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b170b4061b554f0f"

--000000000000b170b4061b554f0f
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On June 20, 2024 5:44:30 PM KeithG <ys3al35l@gmail.com> wrote:

> On Thu, Jun 20, 2024 at 6:14 AM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On June 20, 2024 11:53:12 AM Peter Robinson <pbrobinson@gmail.com> wrote:
>>
>>> On Thu, 20 Jun 2024 at 10:46, Julian Calaby <julian.calaby@gmail.com> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> On Thu, Jun 20, 2024 at 7:19 PM Peter Robinson <pbrobinson@gmail.com> wrote:
>>>>>
>>>>> Hi Arend,
>>>>>
>>>>>> After being asked about support for WPA3 for BCM43224 chipset it
>>>>>> was found that all it takes is setting the MFP_CAPABLE flag and
>>>>>> mac80211 will take care of all that is needed [1].
>>>>>
>>>>> Testing this on a Raspberry Pi 4 [1] against a UniFi U6Pro AP I can't
>>>>> connect to my WPA3 only SSID, it works fine with the SSID that's
>>>>> WPA2/WPA3 on the same AP. It doesn't connect and I get a whole lot of
>>>>> the following errors while it tries:
>>>>>
>>>>> [  155.988865] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
>>>>> reason -52
>>>>> [  156.100906] brcmfmac: brcmf_set_channel: set chanspec 0xd034 fail,
>>>>> reason -52
>>>>> [  156.108597] brcmfmac: brcmf_set_channel: set chanspec 0xd038 fail,
>>>>> reason -52
>>>>> [  156.116317] brcmfmac: brcmf_set_channel: set chanspec 0xd03c fail,
>>>>> reason -52
>>>>
>>>> The Raspberry Pis' WiFi chipsets use the brcmfmac driver and this is a
>>>> patch to the brcmsmac driver. This driver is for older and simpler
>>>> WiFi chipsets than the ones on the Raspberry Pis.
>>>
>>> Right you are, completely missed that :)
>>
>> The devil is in the details ;-) Good that you tested. Maybe we can look
>> into the WPA3-only problem. Are you using wpa_supplicant? Can you share
>> supplicant log file and kernel log with brcmfmac debug modparam set to 0x1416.
>>
>> Regards,
>> Arend
>
> The RPis and the brcmfmac cards.
> The current RPiOS for 32 bit and 64 bit OS have firmware which loads
> on the 5Ghz capable Pis (3b+, 4, 5, 02W) which advertise WPA3
> capability (this is a Pi5, but others are similar) This firmware is
> from 2021:
> # dmesg | grep brcmfmac
> [    2.112735] brcmfmac: F1 signature read @0x18000000=0x15264345
> [    2.114202] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [    2.117274] usbcore: registered new interface driver brcmfmac
> [    2.335211] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
> available (err=-2)
> [    2.335581] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> wl0: Apr 15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID
> 01-996384e2
>
> # iw list
> Wiphy phy0
> ...
>    Supported extended features:
>        * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>        * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in station mode
>        * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in station mode
>        * [ DFS_OFFLOAD ]: DFS offload
>        * [ SAE_OFFLOAD ]: SAE offload support
>        * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>        * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>
> # uname -a
> Linux pi5 6.6.31+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.31-1+rpt1
> (2024-05-29) aarch64 GNU/Linux
>
> I am pretty sure I am fully up to date.
>
> I set up hostapd running an WPA3 SAE config on my desktop with an
> intel card and can connect to it from my phone.
> I cannot connect to it from the Pi5:

So let's dive in

> I tried using a config file and connecting with wpa_supplicant and it did not:
> # cat /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> ctrl_interface=DIR=/run/wpa_supplicant GROUP=netdev
> update_config=1
> network={
>  ssid="deskSAE"
>  sae_password="secret123"
>  proto=RSN
>  key_mgmt=SAE
>  pairwise=CCMP
>  ieee80211w=2
> }

That looks sane to me.

> # ifconfig wlan0 up
> root@pi5(rw):~# iwlist wlan0 scan | grep deskSAE
>                    ESSID:"deskSAE"
> # wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
> Successfully initialized wpa_supplicant
> wlan0: WPA: Failed to select authenticated key management type
> wlan0: WPA: Failed to set WPA key management and encryption suites
> (never returns command prompt)

The supplicant remains running in the foreground so that is normal. Could 
you retry with -ddt on the command line. Also having brcmfmac loaded with 
debug=0x1416 while testing. Finally, can you share the hostapd.conf file?

Regards,
Arend

>
> I tried using wpa_cli as well and it also fails:
> <3>CTRL-EVENT-NETWORK-ADDED 1
> <3>CTRL-EVENT-SCAN-STARTED
> <3>CTRL-EVENT-SCAN-RESULTS
> <3>WPS-AP-AVAILABLE  "deskS
> <4>Failed to initiate sched scan
> <3>CTRL-EVENT-NETWORK-NOT-FOUND
>> set_network 0 ssid "deskSAE"
> OK
>> set_network - key_mgmt SAE
> OK
>> set_network 0 ieee80211w 2
> OK
>> set_network 0 sae_password "secret123"
> OK
> <3>CTRL-EVENT-SCAN-STARTED
> <3>CTRL-EVENT-SCAN-RESULTS
> <3>WPS-AP-AVAILABLE
> <4>Failed to initiate sched scan
> <3>CTRL-EVENT-NETWORK-NOT-FOUND
> <3>CTRL-EVENT-SCAN-STARTED
>> enable 0
> OK
> <3>CTRL-EVENT-SCAN-RESULTS
> <3>WPS-AP-AVAILABLE
> <4>Failed to initiate sched scan
> <3>CTRL-EVENT-NETWORK-NOT-FOUND
> <4>WPA: Failed to select authenticated key management type
> <4>WPA: Failed to set WPA key management and encryption suites
> <3>CTRL-EVENT-SCAN-STARTED
> <3>CTRL-EVENT-SCAN-RESULTS
> <3>WPS-AP-AVAILABLE
> <4>WPA: Failed to select authenticated key management type
> <4>WPA: Failed to set WPA key management and encryption suites
> <3>CTRL-EVENT-SCAN-STARTED
>
> Would love it if there were a way to get wpa3 to work with the
> brcmfmac cards on RPI.
>
> Keith




--000000000000b170b4061b554f0f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDIdLxTqy0OUIFD/HmY
Vmchy4Ns3hJMiOjmLT0hDJ5J3DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDA2MjAxNzA0NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJVOabUmiK6I4I2F7bLY0QsYIbmOxrqJDb/pu
SUE6tCgFDZ+lX/c2UBGubGiqHbuNUQIvN4ToMXwbhacXDchNwqDDaUgEscOe1vXrQfbE3gELwmSJ
+PPD5EyDqDI09FIMxjDFii7p7uTQGwc7cnaeukWh0WhGmkbl7C7pdRrAJDExU7oejDYLP+UjzWv9
rhjyrzdCfrl1VMXxLOxQIbYocf+Ox3ify4CgzkjdWfup0TthYjAMFe+VIXRxZ0qi/S4LzikngHGu
Lm1tG9vy2ParsPBOahZIWl85RhI1JGtot7/rkMRLp4L64I6Y+Ti1dRNS72MdtY0yRr/0lo8z6j0i
mQ==
--000000000000b170b4061b554f0f--

