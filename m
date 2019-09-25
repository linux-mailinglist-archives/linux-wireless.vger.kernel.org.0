Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85BABE801
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 00:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfIYWCG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 18:02:06 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:44315 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfIYWCF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 18:02:05 -0400
Received: by mail-io1-f45.google.com with SMTP id j4so902662iog.11
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2019 15:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCcAzd6Z7ElskfExBZEyGfeAJwj95b2M+EiN9jWXIwY=;
        b=COnVmrEq5QWpZEcj5Nwu7/j2eIyCMWFEx4KTHhCx4Txz9Bh/apiElvnr5RQQh7Qr4C
         JwcoD0d6zhq381yNqrOl1Zb80KMvGI5u1I0kRm2UL9m+wFqhEJRvtCAymnyIgzTHbmij
         KGi2YZXbZv+DZeWqEG4hqs7bJ98aH5F5uOWmdDe9BpKCkKD2nLrD86rn9iYbiwF2lOou
         jnJqsriWWNM5AP/gI4ypjpv0usPLwgpNMZIi/jSGRQU7HoWYb8RAwP8UqetJyLfFkbEx
         JVd3Zr67rMD8cU62zfXl1BWHuyFDw7W1/dW1elS8Xe0L3tafKXOFiXS/TFRhM8abuIle
         tIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCcAzd6Z7ElskfExBZEyGfeAJwj95b2M+EiN9jWXIwY=;
        b=J7p3QvxLX+8aO2pfsaRaTkq+paNgbwF45zhS1bB78Apu7nxxfsWbqySL2zl0X22exs
         iS4/g5HXcgcm19m4g72wug5x10cb4w524UERsveYS6/gFWulsTEg1wleNFwPQFRKYO0v
         NFVwzdDwMh4+IQH/fEkz8qcEAqxWHYsB6I40LP23PEBL5fOc1wCmyX7O60QgzCxlE++G
         9HPbeCdVhpWwfkvtyQbETiG4PfzP+WpdusP+XlFTSCmBD+IVEW3t90751F9tOcncAI9U
         +MjvSJFPk8y7cTTC9iY4BxitdYTjuoQi5LdSmrpg18z30pQjR87Ya23MuVs1Js2zzixe
         oZ5A==
X-Gm-Message-State: APjAAAW8lUCuqLptI/XXeh4tQgXfLocckzQ9itLLV9gMLTm+SFwqstOj
        nvMfc5su+IUvgrrBNEe4J2RcLPdY9fvj6piqRKk=
X-Google-Smtp-Source: APXvYqwp5HiW7JDDWEy7+fq8FsoOgu/X8J57/yWYLebz68xIIkdiSo3YfWSAZbSy+DeqHDC1Y5s1Gs8ufNJ4JpgWcfo=
X-Received: by 2002:a6b:8dd2:: with SMTP id p201mr212790iod.206.1569448923568;
 Wed, 25 Sep 2019 15:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAKKzd-8jgQWTO2w589gMVJm3CaU-15wUER+fsqpYJJSeZL4RPg@mail.gmail.com>
 <CALLGbRKUZmZzBh9=YpJ+r_ts8aY+HXy159oviihSgqMEofOCRQ@mail.gmail.com>
 <CAKKzd-8aRFtdkK+E4-sXBid9jP_sAr0bGbdLYJ=sjb4iCsTAcw@mail.gmail.com> <7158fc76fe5ec091633b36b3218a8586960c19e2.camel@redhat.com>
In-Reply-To: <7158fc76fe5ec091633b36b3218a8586960c19e2.camel@redhat.com>
From:   David Ho <davidkwho@gmail.com>
Date:   Wed, 25 Sep 2019 15:01:50 -0700
Message-ID: <CAKKzd--xon+8DY0=6pYF536SfGU9iXQeMvQ3huhT=8=Ap2bCBw@mail.gmail.com>
Subject: Re: Linux wireless times out at Google Starbucks location
To:     Dan Williams <dcbw@redhat.com>
Cc:     Steve deRosier <derosier@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Steve, Dan,

I have scouted the neighborhood (San Diego, CA) and visited 6
Starbucks.  I found another one with the same issue, so 2/6.  This
appears to be a systemic issue (Not one-off).

I'm wondering if there is anything that you believe I can try at this
point.  There is nothing unusual about these stores.  Everyone is
happily connected on their Macs, and Windows notebooks.

Can you offer any advice or point me to an expert who can help?

Regards,
David


On Tue, Sep 17, 2019 at 2:01 PM Dan Williams <dcbw@redhat.com> wrote:
>
> On Tue, 2019-09-17 at 13:25 -0700, David Ho wrote:
> > On Tue, Sep 17, 2019 at 12:07 PM Steve deRosier <derosier@gmail.com>
> > wrote:
> > > I will tell you I did go look and you don't have sufficient and
> > > useful
> > > information for us to help you. We need to know the wifi chipset
> > > you're using, the drivers involved, what network subsystems you're
> > > using, the methodology of your connection, and the kernel logs
> > > themselves would all be helpful.
> > >
> >
> > Hi Steve, pls let me know if you need anything else, David.
>
> If you're able to get the wpa_supplicant logs, that would be useful as
> well.
>
> sudo dbus-send --system --print-reply --dest=fi.w1.wpa_supplicant1
> /fi/w1/wpa_supplicant1 org.freedesktop.DBus.Properties.Set
> string:fi.w1.wpa_supplicant1 string:DebugTimestamp variant:boolean:true
>
> sudo dbus-send --system --print-reply --dest=fi.w1.wpa_supplicant1
> /fi/w1/wpa_supplicant1 org.freedesktop.DBus.Properties.Set
> string:fi.w1.wpa_supplicant1 string:DebugLevel variant:string:"msgdump"
>
> will start spewing out tons of information to wherever the supplicant
> sends log information on Ubuntu (systemd, syslog, etc).
>
> Dan
>
> > High level: Google Starbucks Wifi connection, Unencrypted AP (see AP
> > info below)
> > Connection method: NetworkManager, wpa_applicant (see exerpt from
> > /var/log/syslog below)
> >                    (see also iw event -f below)
> > Linux kernel: 5.0.0-27
> > Network subsystem: mac80211, cfg80211 (not sure)
> > Wifi chipset: RTL8822BE 802.11a/b/g/n/ac (see below)
> > Kernel driver in use: rtw_pci (see below)
> > Kernel modules: rtwpci, r8822be (see below)
> > Kernel log: see /var/log/kern.log exerpt below
> >
> > Problem detail
> > ------------------
> >
> > I had trouble connecting my Ubuntu 18.04.3 LTS laptop to one specific
> > Starbucks location in my neighborhood, (Note that it works for 2/3
> > Starbucks and another public wifi location so this is an outlier;
> > However, I have been coming to this Starbucks at least 30 times in
> > the
> > past and it worked 100% for my Windows laptop and Andriod phone, and
> > I
> > have never seen customers with iPhones/MacBooks complaining, thus it
> > is being handled routinely by other major OS's)
> >
> > I have been tracking down this problem for three days and I believe I
> > have a good handle on what the problem may be.
> >
> > The event log below shows that after successfully authenticated,
> > association timed-out after 3 tries (seen in the kernel log in
> > /var/log/syslog). The next attempt to associate with the AP was
> > denied
> > because the WTA (my laptop) has been associated according to the AP.
> > Thus I believe the client timed out before the association response
> > from the AP reaches the WTA.
> >
> > I looked over the Linux wireless user's doc, but I didn't find a way
> > to tweak the configuration to test my hypothesis. Perhaps the
> > wireless
> > subsystem folks can shed some lights on this problem to help with
> > this?
> >
> > davidkwho@mumble15:~$ iw event -f
> > wlo1 (phy #0): scan started
> > wlo1 (phy #0): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447
> > 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320
> > 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785
> > 5805 5825, ""
> > wlo1 (phy #0): scan started
> > wlo1 (phy #0): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447
> > 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320
> > 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785
> > 5805 5825, "Google Starbucks" ""
> > wlo1: new station 24:de:c6:cb:2a:d8
> > wlo1 (phy #0): auth 24:de:c6:cb:2a:d8 -> 48:5f:99:bc:ab:b9 status: 0:
> > Successful [frame: b0 00 3c 00 48 5f 99 bc ab b9 24 de c6 cb 2a d8 24
> > de c6 cb 2a d8 10 c5 00 00 02 00 00 00]
> > wlo1: del station 24:de:c6:cb:2a:d8
> > wlo1 (phy #0): assoc: timed out
> > wlo1 (phy #0): scan started
> > wlo1 (phy #0): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447
> > 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320
> > 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785
> > 5805 5825, "Google Starbucks" ""
> > wlo1: new station 24:de:c6:cb:2a:d0
> > wlo1: del station 24:de:c6:cb:2a:d0
> > wlo1 (phy #0): auth 24:de:c6:cb:2a:d0 -> 48:5f:99:bc:ab:b9 status:
> > 17:
> > Association denied because AP is unable to handle additional
> > associated STA [frame: b0 00 3c 00 48 5f 99 bc ab b9 24 de c6 cb 2a
> > d0
> > 24 de c6 cb 2a d0 20 0b 00 00 02 00 11 00]
> > wlo1 (phy #0): scan started
> > wlo1 (phy #0): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447
> > 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320
> > 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785
> > 5805 5825, ""
> > wlo1 (phy #0): scan started
> > wlo1 (phy #0): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447
> > 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320
> > 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785
> > 5805 5825, ""
> > wlo1 (phy #0): scan started
> > wlo1 (phy #0): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447
> > 2452 2457 2462 2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320
> > 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785
> > 5805 5825, ""
> >
> > Wireless AP info
> > $ iw dev wlo1 scan
> > BSS 24:de:c6:cb:2a:d8(on wlo1)
> > TSF: 2927364433352 usec (33d, 21:09:24)
> > freq: 5765
> > beacon interval: 100 TUs
> > capability: ESS SpectrumMgmt ShortSlotTime (0x0501)
> > signal: -41.00 dBm
> > last seen: 320 ms ago
> > Information elements from Probe Response frame:
> > SSID: Google Starbucks
> > Supported rates: 6.0* 9.0 12.0* 18.0 24.0* 36.0 48.0 54.0
> > DS Parameter set: channel 153
> > Country: US Environment: Indoor/Outdoor
> > Channels [36 - 64] @ 36 dBm
> > Channels [100 - 140] @ 30 dBm
> > Channels [149 - 165] @ 36 dBm
> > Power constraint: 0 dB
> > TPC report: TX power: 23 dBm
> > BSS Load:
> > * station count: 7
> > * channel utilisation: 2/255
> > * available admission capacity: 30937 [*32us]
> > HT capabilities:
> > Capabilities: 0x9ce
> > HT20/HT40
> > SM Power Save disabled
> > RX HT40 SGI
> > TX STBC
> > RX STBC 1-stream
> > Max AMSDU length: 7935 bytes
> > No DSSS/CCK HT40
> > Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
> > Minimum RX AMPDU time spacing: 16 usec (0x07)
> > HT RX MCS rate indexes supported: 0-15
> > HT TX MCS rate indexes are undefined
> > HT operation:
> > * primary channel: 153
> > * secondary channel offset: below
> > * STA channel width: any
> > * RIFS: 0
> > * HT protection: 20 MHz
> > * non-GF present: 0
> > * OBSS non-GF present: 0
> > * dual beacon: 0
> > * dual CTS protection: 0
> > * STBC beacon: 0
> > * L-SIG TXOP Prot: 0
> > * PCO active: 0
> > * PCO phase: 0
> > Extended capabilities:
> > * BSS Transition
> > WMM: * Parameter version 1
> > * u-APSD
> > * BE: CW 15-1023, AIFSN 3
> > * BK: CW 15-1023, AIFSN 7
> > * VI: CW 7-15, AIFSN 2, TXOP 3008 usec
> > * VO: CW 3-7, AIFSN 2, TXOP 1504 usec
> >
> > davidkwho@mumble15:~$ uname -a
> > Linux mumble15 5.0.0-27-generic #28~18.04.1-Ubuntu SMP Thu Aug 22
> > 03:00:32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
> >
> > davidkwho@mumble15:~$ sudo lspci -nn -s 02:00.0
> > 02:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd.
> > RTL8822BE 802.11a/b/g/n/ac WiFi adapter [10ec:b822]
> >
> > davidkwho@mumble15:~$ sudo lspci -vv -s 02:00.0
> > 02:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822BE
> > 802.11a/b/g/n/ac WiFi adapter
> > Subsystem: Hewlett-Packard Company Device 831b
> > Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> > Stepping- SERR- FastB2B- DisINTx-
> > Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > Latency: 0, Cache Line Size: 64 bytes
> > Interrupt: pin A routed to IRQ 17
> > Region 0: I/O ports at 3000 [size=256]
> > Region 2: Memory at b1000000 (64-bit, non-prefetchable) [size=64K]
> > Capabilities: [40] Power Management version 3
> > Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> > PME(D0+,D1+,D2+,D3hot+,D3cold+)
> > Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> > Address: 0000000000000000  Data: 0000
> > Capabilities: [70] Express (v2) Endpoint, MSI 00
> > DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
> > ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit
> > 10.000W
> > DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> > RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> > MaxPayload 128 bytes, MaxReadReq 512 bytes
> > DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> > LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency
> > L0s <2us, L1 <64us
> > ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
> > LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
> > ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
> > LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
> > BWMgmt- ABWMgmt-
> > DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF
> > Via message/WAKE#
> > DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF
> > Disabled
> > LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> > Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
> > ComplianceSOS-
> > Compliance De-emphasis: -6dB
> > LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,
> > EqualizationPhase1-
> > EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
> > Capabilities: [100 v2] Advanced Error Reporting
> > UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> > MalfTLP- ECRC- UnsupReq- ACSViol-
> > UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
> > MalfTLP- ECRC- UnsupReq- ACSViol-
> > UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
> > MalfTLP+ ECRC- UnsupReq- ACSViol-
> > CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> > CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> > AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> > Capabilities: [148 v1] Device Serial Number 00-e0-4c-ff-fe-b8-22-01
> > Capabilities: [158 v1] Latency Tolerance Reporting
> > Max snoop latency: 3145728ns
> > Max no snoop latency: 3145728ns
> > Capabilities: [160 v1] L1 PM Substates
> > L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> > L1_PM_Substates-
> > L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> >
> > L1SubCtl2:
> > Kernel driver in use: rtw_pci
> > Kernel modules: rtwpci, r8822be
> >
> > davidkwho@mumble15:~$ modinfo rtwpci
> > filename:
> > /lib/modules/5.0.0-27-
> > generic/kernel/drivers/net/wireless/realtek/rtw88/rtwpci.ko
> > license:        Dual BSD/GPL
> > description:    Realtek 802.11ac wireless PCI driver
> > author:         Realtek Corporation
> > srcversion:     4B7E47842DAA873E20D1238
> > alias:          pci:v000010ECd0000C822sv*sd*bc*sc*i*
> > alias:          pci:v000010ECd0000B822sv*sd*bc*sc*i*
> > depends:        mac80211,rtw88
> > retpoline:      Y
> > intree:         Y
> > name:           rtwpci
> > vermagic:       5.0.0-27-generic SMP mod_unload
> > signat:         PKCS#7
> > signer:
> > sig_key:
> > sig_hashalgo:   md4
> >
> >
> > davidkwho@mumble15:~$ modinfo r8822be
> > filename:
> > /lib/modules/5.0.0-27-
> > generic/kernel/drivers/staging/rtlwifi/r8822be.ko
> > description:    Realtek 802.11n PCI wireless core
> > license:        GPL
> > author:         Larry Finger <Larry.FInger@lwfinger.net>
> > author:         Realtek WlanFAE <wlanfae@realtek.com>
> > author:         lizhaoming <chaoming_li@realsil.com.cn>
> > description:    PCI basic driver for rtlwifi
> > license:        GPL
> > author:         Larry Finger <Larry.FInger@lwfinger.net>
> > author:         Realtek WlanFAE <wlanfae@realtek.com>
> > author:         lizhaoming <chaoming_li@realsil.com.cn>
> > firmware:       rtlwifi/rtl8822befw.bin
> > description:    Realtek 8822BE 802.11n PCI wireless
> > license:        GPL
> > author:         Larry Finger <Larry.Finger@lwfinger.net>
> > author:         Realtek WlanFAE <wlanfae@realtek.com>
> > description:    Realtek 802.11n PCI wireless core
> > license:        GPL
> > author:         Larry Finger <Larry.FInger@lwfinger.net>
> > author:         Realtek WlanFAE <wlanfae@realtek.com>
> > description:    Realtek 802.11n PCI wireless core
> > license:        GPL
> > author:         Larry Finger <Larry.FInger@lwfinger.net>
> > author:         Realtek WlanFAE <wlanfae@realtek.com>
> > srcversion:     486B19E09315807AE50AE2D
> > alias:          pci:v000010ECd0000B822sv*sd*bc*sc*i*
> > depends:        mac80211,cfg80211
> > staging:        Y
> > retpoline:      Y
> > intree:         Y
> > name:           r8822be
> > vermagic:       5.0.0-27-generic SMP mod_unload
> > signat:         PKCS#7
> > signer:
> > sig_key:
> > sig_hashalgo:   md4
> > parm:           debug_level:int
> > parm:           swenc:Set to 1 for software crypto (default 0)
> >  (bool)
> > parm:           ips:Set to 0 to not use link power save (default 1)
> >  (bool)
> > parm:           swlps:Set to 1 to use SW control power save (default
> > 0)
> >  (bool)
> > parm:           fwlps:Set to 1 to use FW control power save (default
> > 1)
> >  (bool)
> > parm:           msi:Set to 1 to use MSI interrupts mode (default 1)
> >  (bool)
> > parm:           dma64:Set to 1 to use DMA 64 (default 0)
> >  (bool)
> > parm:           aspm:Set to 1 to enable ASPM (default 1)
> >  (int)
> > parm:           debug:Set debug level (0-5) (default 0)
> > parm:           debug_mask:Set debug mask (default 0) (ullong)
> > parm:           disable_watchdog:Set to 1 to disable the watchdog
> > (default 0)
> >  (bool)
> >
> > excerpt from /var/log/kern.log
> >
> > Sep 17 10:04:10 mumble15 kernel: [ 3027.669072] rtw_pci 0000:02:00.0:
> > stop vif 48:5f:99:bc:ab:b9 on port 0
> > Sep 17 10:04:11 mumble15 kernel: [ 3028.363198] rtw_pci 0000:02:00.0:
> > start vif 48:5f:99:bc:ab:b9 on port 0
> > Sep 17 10:05:05 mumble15 kernel: [ 3082.392651] wlo1: authenticate
> > with 24:de:c6:cb:2a:d8
> > Sep 17 10:05:05 mumble15 kernel: [ 3082.891812] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 10:05:05 mumble15 kernel: [ 3082.893326] wlo1: authenticated
> > Sep 17 10:05:05 mumble15 kernel: [ 3082.895705] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 10:05:05 mumble15 kernel: [ 3082.999946] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 2/3)
> > Sep 17 10:05:05 mumble15 kernel: [ 3083.108066] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 3/3)
> > Sep 17 10:05:06 mumble15 kernel: [ 3083.212065] wlo1: association
> > with
> > 24:de:c6:cb:2a:d8 timed out
> > Sep 17 10:05:10 mumble15 kernel: [ 3087.321806] wlo1: authenticate
> > with 24:de:c6:cb:2a:d8
> > Sep 17 10:05:10 mumble15 kernel: [ 3087.820063] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 10:05:10 mumble15 kernel: [ 3087.923790] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 2/3)
> > Sep 17 10:05:10 mumble15 kernel: [ 3088.027966] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 3/3)
> > Sep 17 10:05:10 mumble15 kernel: [ 3088.131991] wlo1: authentication
> > with 24:de:c6:cb:2a:d8 timed out
> > Sep 17 10:05:15 mumble15 kernel: [ 3092.637001] wlo1: authenticate
> > with 24:de:c6:cb:2a:d0
> > Sep 17 10:05:15 mumble15 kernel: [ 3093.135834] wlo1: send auth to
> > 24:de:c6:cb:2a:d0 (try 1/3)
> > Sep 17 10:05:15 mumble15 kernel: [ 3093.141686] wlo1:
> > 24:de:c6:cb:2a:d0 denied authentication (status 17)
> > Sep 17 10:05:20 mumble15 kernel: [ 3097.661509] wlo1: authenticate
> > with 24:de:c6:cb:2a:d8
> > Sep 17 10:05:20 mumble15 kernel: [ 3098.159806] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 10:05:21 mumble15 kernel: [ 3098.263955] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 2/3)
> > Sep 17 10:05:21 mumble15 kernel: [ 3098.273381] wlo1: authenticated
> > Sep 17 10:05:21 mumble15 kernel: [ 3098.279772] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 10:05:21 mumble15 kernel: [ 3098.384004] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 2/3)
> > Sep 17 10:05:21 mumble15 kernel: [ 3098.496082] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 3/3)
> > Sep 17 10:05:21 mumble15 kernel: [ 3098.604080] wlo1: association
> > with
> > 24:de:c6:cb:2a:d8 timed out
> > Sep 17 10:05:23 mumble15 kernel: [ 3100.190473] wlo1: authenticate
> > with 24:de:c6:cb:2a:d0
> > Sep 17 10:05:23 mumble15 kernel: [ 3100.691844] wlo1: send auth to
> > 24:de:c6:cb:2a:d0 (try 1/3)
> > Sep 17 10:05:23 mumble15 kernel: [ 3100.694973] wlo1:
> > 24:de:c6:cb:2a:d0 denied authentication (status 17)
> > Sep 17 10:14:24 mumble15 canonical-livepatch[985]: Client.Check
> > Sep 17 10:14:24 mumble15 canonical-livepatch[985]: error in livepatch
> > check state: check-failed
> > Sep 17 10:14:24 mumble15 canonical-livepatch[985]: Checking with
> > livepatch service.
> > Sep 17 10:14:24 mumble15 canonical-livepatch[985]: No payload
> > available.
> > Sep 17 10:14:24 mumble15 canonical-livepatch[985]: during refresh:
> > cannot check: cannot send status to server: cannot send request: Put
> > https://livepatch.canonical.com/api/machine/d34ed7a7967e44fab3d249a4160a5e66:
> > dial tcp: lookup livepatch.canonical.com: no such host
> > Sep 17 10:14:54 mumble15 canonical-livepatch[985]: Client.Check
> > Sep 17 10:14:54 mumble15 canonical-livepatch[985]: error in livepatch
> > check state: check-failed
> > Sep 17 10:14:54 mumble15 canonical-livepatch[985]: Checking with
> > livepatch service.
> > Sep 17 10:14:54 mumble15 canonical-livepatch[985]: No payload
> > available.
> > Sep 17 10:14:54 mumble15 canonical-livepatch[985]: during refresh:
> > cannot check: cannot send status to server: cannot send request: Put
> > https://livepatch.canonical.com/api/machine/d34ed7a7967e44fab3d249a4160a5e66:
> > dial tcp: lookup livepatch.canonical.com: no such host
> > Sep 17 10:27:55 mumble15 kernel: [ 4452.196761] wlo1: authenticate
> > with 24:de:c6:cb:2a:d8
> > Sep 17 10:27:55 mumble15 kernel: [ 4452.695694] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 10:27:55 mumble15 kernel: [ 4452.696900] wlo1: authenticated
> > Sep 17 10:27:55 mumble15 kernel: [ 4452.699665] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 10:27:55 mumble15 kernel: [ 4452.803715] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 2/3)
> > Sep 17 10:27:55 mumble15 kernel: [ 4452.919898] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 3/3)
> > Sep 17 10:27:55 mumble15 kernel: [ 4453.023876] wlo1: association
> > with
> > 24:de:c6:cb:2a:d8 timed out
> > Sep 17 10:28:09 mumble15 kernel: [ 4467.040008] wlo1: authenticate
> > with 24:de:c6:cb:2a:d0
> > Sep 17 10:28:10 mumble15 kernel: [ 4467.539834] wlo1: send auth to
> > 24:de:c6:cb:2a:d0 (try 1/3)
> > Sep 17 10:28:10 mumble15 kernel: [ 4467.540985] wlo1:
> > 24:de:c6:cb:2a:d0 denied authentication (status 17)
> >
> > excerpt from /var/log/syslog
> >
> > Sep 17 09:15:41 mumble15 NetworkManager[893]: <info>
> > [1568736941.1707] device (wlo1): supplicant interface state: ready ->
> > scanning
> > Sep 17 09:15:44 mumble15 wpa_supplicant[892]: wlo1: SME: Trying to
> > authenticate with 24:de:c6:cb:2a:d8 (SSID='Google Starbucks'
> > freq=5765
> > MHz)
> > Sep 17 09:15:44 mumble15 kernel: [  121.844764] wlo1: authenticate
> > with 24:de:c6:cb:2a:d8
> > Sep 17 09:15:45 mumble15 kernel: [  122.343740] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 09:15:45 mumble15 NetworkManager[893]: <info>
> > [1568736945.1620] device (wlo1): supplicant interface state: scanning
> > -> authenticating
> > Sep 17 09:15:45 mumble15 wpa_supplicant[892]: wlo1: Trying to
> > associate with 24:de:c6:cb:2a:d8 (SSID='Google Starbucks' freq=5765
> > MHz)
> > Sep 17 09:15:45 mumble15 kernel: [  122.344991] wlo1: authenticated
> > Sep 17 09:15:45 mumble15 kernel: [  122.348006] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 09:15:45 mumble15 NetworkManager[893]: <info>
> > [1568736945.1793] device (wlo1): supplicant interface state:
> > authenticating -> associating
> > Sep 17 09:15:45 mumble15 kernel: [  122.452300] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 2/3)
> > Sep 17 09:15:45 mumble15 kernel: [  122.556317] wlo1: associate with
> > 24:de:c6:cb:2a:d8 (try 3/3)
> > Sep 17 09:15:45 mumble15 kernel: [  122.664332] wlo1: association
> > with
> > 24:de:c6:cb:2a:d8 timed out
> > Sep 17 09:15:45 mumble15 NetworkManager[893]: <info>
> > [1568736945.5173] device (wlo1): supplicant interface state:
> > associating -> disconnected
> > Sep 17 09:15:45 mumble15 dbus-daemon[1671]: [session uid=1000
> > pid=1671] Activating via systemd: service
> > name='org.gnome.zeitgeist.Engine' unit='zeitgeist.service' requested
> > by ':1.72' (uid=1000 pid=2152 comm="zeitgeist-datahub "
> > label="unconfined")
> > Sep 17 09:15:45 mumble15 systemd[1645]: Starting Zeitgeist activity
> > log service...
> > Sep 17 09:15:45 mumble15 dbus-daemon[1671]: [session uid=1000
> > pid=1671] Activating via systemd: service
> > name='org.gnome.zeitgeist.SimpleIndexer' unit='zeitgeist-fts.service'
> > requested by ':1.73' (uid=1000 pid=2161
> > comm="/usr/bin/zeitgeist-daemon " label="unconfined")
> > Sep 17 09:15:45 mumble15 dbus-daemon[1671]: [session uid=1000
> > pid=1671] Successfully activated service 'org.gnome.zeitgeist.Engine'
> > Sep 17 09:15:45 mumble15 systemd[1645]: Started Zeitgeist activity
> > log service.
> > Sep 17 09:15:45 mumble15 systemd[1645]: Starting Zeitgeist full-text
> > search indexer...
> > Sep 17 09:15:45 mumble15 zeitgeist-daemon[2161]:
> > #033[31m[16:15:45.840283 WARNING]#033[0m zeitgeist-daemon.vala:127:
> > Unable to parse version info!
> > Sep 17 09:15:45 mumble15 zeitgeist-daemon[2161]:
> > #033[31m[16:15:45.840478 WARNING]#033[0m zeitgeist-daemon.vala:127:
> > Unable to parse version info!
> > Sep 17 09:15:45 mumble15 zeitgeist-daemon[2161]:
> > #033[31m[16:15:45.851906 WARNING]#033[0m zeitgeist-daemon.vala:127:
> > Unable to parse version info!
> > Sep 17 09:15:45 mumble15 zeitgeist-datah[2168]:
> > zeitgeist-datahub.vala:227: Unable to get name
> > "org.gnome.zeitgeist.datahub" on the bus!
> > Sep 17 09:15:45 mumble15 dbus-daemon[1671]: [session uid=1000
> > pid=1671] Successfully activated service
> > 'org.gnome.zeitgeist.SimpleIndexer'
> > Sep 17 09:15:45 mumble15 systemd[1645]: Started Zeitgeist full-text
> > search indexer.
> > Sep 17 09:15:46 mumble15 NetworkManager[893]: <info>
> > [1568736946.1109] device (wlo1): supplicant interface state:
> > disconnected -> scanning
> > Sep 17 09:15:49 mumble15 wpa_supplicant[892]: nl80211:
> > send_and_recv->nl_recvmsgs failed: -33
> > Sep 17 09:15:49 mumble15 wpa_supplicant[892]: wlo1: SME: Trying to
> > authenticate with 24:de:c6:cb:2a:d8 (SSID='Google Starbucks'
> > freq=5765
> > MHz)
> > Sep 17 09:15:49 mumble15 kernel: [  126.781671] wlo1: authenticate
> > with 24:de:c6:cb:2a:d8
> > Sep 17 09:15:50 mumble15 NetworkManager[893]: <info>
> > [1568736950.0994] device (wlo1): supplicant interface state: scanning
> > -> authenticating
> > Sep 17 09:15:50 mumble15 kernel: [  127.280174] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 09:15:50 mumble15 kernel: [  127.384202] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 2/3)
> > Sep 17 09:15:50 mumble15 kernel: [  127.488275] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 3/3)
> > Sep 17 09:15:50 mumble15 kernel: [  127.592303] wlo1: authentication
> > with 24:de:c6:cb:2a:d8 timed out
> > Sep 17 09:15:50 mumble15 NetworkManager[893]: <info>
> > [1568736950.4335] device (wlo1): supplicant interface state:
> > authenticating -> disconnected
> > Sep 17 09:15:50 mumble15 dbus-daemon[1671]: [session uid=1000
> > pid=1671] Activating via systemd: service name='org.gnome.Terminal'
> > unit='gnome-terminal-server.service' requested by ':1.77' (uid=1000
> > pid=2199 comm="/usr/bin/gnome-terminal.real " label="unconfined")
> > Sep 17 09:15:50 mumble15 systemd[1645]: Starting GNOME Terminal
> > Server...
> > Sep 17 09:15:50 mumble15 dbus-daemon[1671]: [session uid=1000
> > pid=1671] Successfully activated service 'org.gnome.Terminal'
> > Sep 17 09:15:50 mumble15 systemd[1645]: Started GNOME Terminal
> > Server.
> > Sep 17 09:15:51 mumble15 NetworkManager[893]: <info>
> > [1568736951.4267] device (wlo1): supplicant interface state:
> > disconnected -> scanning
> > Sep 17 09:15:54 mumble15 wpa_supplicant[892]: wlo1: SME: Trying to
> > authenticate with 24:de:c6:cb:2a:d8 (SSID='Google Starbucks'
> > freq=5765
> > MHz)
> > Sep 17 09:15:54 mumble15 kernel: [  132.102375] wlo1: authenticate
> > with 24:de:c6:cb:2a:d8
> > Sep 17 09:15:55 mumble15 kernel: [  132.599927] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 09:15:55 mumble15 NetworkManager[893]: <info>
> > [1568736955.4232] device (wlo1): supplicant interface state: scanning
> > -> authenticating
> > Sep 17 09:15:55 mumble15 kernel: [  132.704246] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 2/3)
> > Sep 17 09:15:55 mumble15 kernel: [  132.808252] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 3/3)
> > Sep 17 09:15:55 mumble15 kernel: [  132.912292] wlo1: authentication
> > with 24:de:c6:cb:2a:d8 timed out
> > Sep 17 09:15:55 mumble15 NetworkManager[893]: <info>
> > [1568736955.7536] device (wlo1): supplicant interface state:
> > authenticating -> disconnected
> > Sep 17 09:15:57 mumble15 NetworkManager[893]: <info>
> > [1568736957.2508] device (wlo1): supplicant interface state:
> > disconnected -> scanning
> > Sep 17 09:16:00 mumble15 wpa_supplicant[892]: wlo1: SME: Trying to
> > authenticate with 24:de:c6:cb:2a:d8 (SSID='Google Starbucks'
> > freq=5765
> > MHz)
> > Sep 17 09:16:00 mumble15 kernel: [  137.921958] wlo1: authenticate
> > with 24:de:c6:cb:2a:d8
> > Sep 17 09:16:01 mumble15 NetworkManager[893]: <info>
> > [1568736961.2395] device (wlo1): supplicant interface state: scanning
> > -> authenticating
> > Sep 17 09:16:01 mumble15 kernel: [  138.420186] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 1/3)
> > Sep 17 09:16:01 mumble15 kernel: [  138.426618] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 2/3)
> > Sep 17 09:16:01 mumble15 kernel: [  138.433025] wlo1: send auth to
> > 24:de:c6:cb:2a:d8 (try 3/3)
> > Sep 17 09:16:01 mumble15 kernel: [  138.439447] wlo1: authentication
> > with 24:de:c6:cb:2a:d8 timed out
> > Sep 17 09:16:01 mumble15 wpa_supplicant[892]: wlo1:
> > CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="Google Starbucks"
> > auth_failures=1 duration=10 reason=CONN_FAILED
> > Sep 17 09:16:01 mumble15 NetworkManager[893]: <info>
> > [1568736961.2927] device (wlo1): supplicant interface state:
> > authenticating -> disconnected
> > Sep 17 09:16:03 mumble15 NetworkManager[893]: <warn>
> > [1568736963.8164] device (wlo1): Activation: (wifi) association took
> > too long, failing activation
> > Sep 17 09:16:03 mumble15 NetworkManager[893]: <info>
> > [1568736963.8165] device (wlo1): state change: config -> failed
> > (reason 'supplicant-timeout', sys-iface-state: 'managed')
> > Sep 17 09:16:03 mumble15 NetworkManager[893]: <info>
> > [1568736963.8172] manager: NetworkManager state is now DISCONNECTED
> > Sep 17 09:16:03 mumble15 NetworkManager[893]: <warn>
> > [1568736963.8186] device (wlo1): Activation: failed for connection
> > 'Google Starbucks'
> > Sep 17 09:16:03 mumble15 NetworkManager[893]: <info>
> > [1568736963.8202] device (wlo1): state change: failed -> disconnected
> > (reason 'none', sys-iface-state: 'managed')
> > Sep 17 09:16:03 mumble15 dbus-daemon[1124]: [session uid=121
> > pid=1124]
> > Activating service name='ca.desrt.dconf' requested by ':1.13'
> > (uid=121
> > pid=1139 comm="/usr/bin/gnome-shell " label="unconfined")
> > Sep 17 09:16:03 mumble15 dbus-daemon[1124]: [session uid=121
> > pid=1124]
> > Successfully activated service 'ca.desrt.dconf'
> > Sep 17 09:16:03 mumble15 gnome-shell[1824]: An active wireless
> > connection, in infrastructure mode, involves no access point?
> > Sep 17 09:16:03 mumble15 gnome-shell[1139]: An active wireless
> > connection, in infrastructure mode, involves no access point?
> > Sep 17 09:16:08 mumble15 NetworkManager[893]: <info>
> > [1568736968.2980] device (wlo1): supplicant interface state:
> > disconnected -> inactive
>
