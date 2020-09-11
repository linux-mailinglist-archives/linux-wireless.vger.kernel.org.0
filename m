Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C75B2664B1
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 18:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgIKQoT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 12:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgIKPIW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 11:08:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF3C0617AB
        for <linux-wireless@vger.kernel.org>; Fri, 11 Sep 2020 08:07:25 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id h20so6567858ybj.8
        for <linux-wireless@vger.kernel.org>; Fri, 11 Sep 2020 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IrVHvJfj05ef4jdSB6CE9rWQZXSQ95PnLmOBdePEPZA=;
        b=SBM9b0qr6BoQiuLwNPLu3vty6eP+1TzYpDZ+U0RVMZzVdrjIf9rVXnyfFVdNM8F+MF
         Dzw5tdLzDdIAZoF1NbCfh0QbyD4BaZ+jB7GlULEAX9ksL4e4rTzZS9LPualV69x9gert
         x+0Tfj08IfgWq95yhPiAscitRgTRauawMHRHlWhYLH2+1PqVDhccJkC1TFrgC4RF3d8m
         PbwO6FuYnhxvPHmZrK7AlFML1MEhseYivEEdBu96nDRBPX40WbNniZokh3wGuPjXPHPG
         8aSJz+emuqf+vheG1JoDzI5OzEnuHZg9K+9EmDN0ooOmSqMm7hedPlMnTodz7cjZiaYG
         n4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IrVHvJfj05ef4jdSB6CE9rWQZXSQ95PnLmOBdePEPZA=;
        b=emD0md71gKnmI9jO7P1hMMTVvkdw7OE6KzuzACYqXdNEnY+UWznpCOkIXqQRPgThiJ
         THQhBz55Qy9ehSjwDMNY9MYYg9wFnaMsFZA3pGT6TOHg1fj3xbl4BBaTwMDEJPcj86FL
         tuEjgMg83B/SMJpIrbkXm9kD6EcPfYmXGs08tqkc/IZOTlvkJ4bcH6v8SYK4Pkv3VM8I
         OKLQ5P+FSPLY7C9rannziLtza6oCT4XNWtEigEzgStExC8LKZDnVSEnjl+jEUKCds+LJ
         F2nhmtasBpa5lLaB1OFFNARddSY9Mvrm+CUzsnhz5HNHfe/liEw477KFhDlFxs5K9Sqa
         pz7w==
X-Gm-Message-State: AOAM530tkyg/0Gg4B0/2dUcuukrxAUVhokMjgGRdL789mXQnWBU4067u
        y8Ibe1qn6Kbf6vMH28GqwMc3ey82ysdfBxrFTwU=
X-Google-Smtp-Source: ABdhPJzDYlVsJbIzchF7w8uT/GakWDXeaV4M+aCIzvATySOTYLF7ZrCjW+tJ0P41EoBxbAGSC4U1T5epFeTEe1shN/4=
X-Received: by 2002:a25:317:: with SMTP id 23mr3008768ybd.233.1599836843106;
 Fri, 11 Sep 2020 08:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAD_iCC8EyWV8bLdJ+VsRdMHOa6ccOOOOUMM6nMwDk16LtMppcg@mail.gmail.com>
 <PR2PR08MB464983615CFB2AF2B3BCD644D12E0@PR2PR08MB4649.eurprd08.prod.outlook.com>
 <CAD_iCC-=rvC6mC8pOKNKqrrWQv2wt9BXVMQB2DR1QKcGp_KbiQ@mail.gmail.com>
 <CABPxzYJ=vJB4pnCC__G6Luhdp_m51Z_nKq80HFxEfN6cdsKQbw@mail.gmail.com>
 <CAD_iCC-koZwPCew4+n4nk8Ou_jWC2BxxcSDy_rf9KnO4Q=MO=g@mail.gmail.com>
 <CABPxzY+tfkjKETjdKJE7AjY6ELFfsLw4utVWOfXwxuV4C+RK8w@mail.gmail.com>
 <CAD_iCC-=9XU-DbfUorUtSRzCOEW=gr83T8ZSMvJn_xFgoMWvew@mail.gmail.com>
 <CABPxzYJmL7x1Hfx9Yf+4XT6xngWNmYC9ZGGvDYqLo7y2bNtCow@mail.gmail.com>
 <CAD_iCC9Vu55FG5vHSWF=H8v-ZZKQoyin8B-1zBtaJ+2MeJqCjg@mail.gmail.com>
 <CABPxzYKVK3OK6nKMrLrBfdy-Yz1v_bbyhHHLCkxnFzWtFBSGaA@mail.gmail.com>
 <CAD_iCC8XDNXfDmghhXyK8auFg5WinqaACpbpbiZ4g0toaDoeiw@mail.gmail.com>
 <CABPxzYK-HN-Q3wREn+6qAkiHAnkuyqz-g6m9XpUtaMd8ckHQPg@mail.gmail.com>
 <CAD_iCC-LMnDeL-e-i2GPYe9fRruWxkKvHEsNGDERv2j8eN1YFw@mail.gmail.com>
 <CABPxzYJVwjPGrHitstWkgiL+kEB9AeTMy_e5nu7FNXVv4ZNk-A@mail.gmail.com>
 <CAD_iCC_1TV_wQK+xOWk48eaJhWo82CZgTL-g4jg7tOdVxvqEZw@mail.gmail.com>
 <CABPxzY+2OO6nptyE+oH+COLe3pVgKhji=H1trP7m_bcpVqEe7Q@mail.gmail.com>
 <CAD_iCC-x9J4UB5aVR85WNi4OwaXQiU28+4B1AD176zDu8DBhwQ@mail.gmail.com>
 <CABPxzY+oy=p4QLHfyVMprigHOpTJEJGsJ-Bsti5b9Ly=eDy+cQ@mail.gmail.com>
 <CAD_iCC-mCo58fs1v+bqyB=NRXkQDTa20R=NGe+SwTP2s7NPfOA@mail.gmail.com>
 <CABPxzYKckJ94+96YsTY4Y7D7_z-Pk=b+T1tvu5BzaoVjVi0apw@mail.gmail.com> <CAD_iCC8StVW7Yh9f8fm2Da7LcN6LQzR=ssp+1E8-=YYCM-5tOQ@mail.gmail.com>
In-Reply-To: <CAD_iCC8StVW7Yh9f8fm2Da7LcN6LQzR=ssp+1E8-=YYCM-5tOQ@mail.gmail.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Fri, 11 Sep 2020 20:37:10 +0530
Message-ID: <CABPxzYKFUN-hyhJnxG_-EcD0L0bsp8rn+b+tyt_ReAf11vzKng@mail.gmail.com>
Subject: Re: Configuring WiFi6 in hostapd
To:     Sugandh Huthanahally Mohan <sugandhgowda@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     Cedric Izoard <Cedric.Izoard@ceva-dsp.com>,
        "Hostap@lists.infradead.org" <Hostap@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 11, 2020 at 8:25 PM Sugandh Huthanahally Mohan
<sugandhgowda@gmail.com> wrote:
>
> On Fri, Sep 11, 2020 at 7:33 PM Sugandh Huthanahally Mohan
> <sugandhgowda@gmail.com> wrote:
> >
> > On Wed, Sep 9, 2020 at 2:18 AM Sugandh Huthanahally Mohan
> > <sugandhgowda at gmail.com> wrote:
> > >
> > > On Wed, Sep 9, 2020 at 12:27 AM Sugandh Huthanahally Mohan
> > > <sugandhgowda at gmail.com> wrote:
> > > > >
> > > > > I have captured connection between a WiFi6 AP and a WiFi6 STA in =
wireshark.
> > > > >I have attached a wireshark pcap file.
> > > > > I could see HE capabilities exchange in Association request and r=
esponse.
> > > > Yes, this looks fine to me except for VHT IEs in the probe and
> > > > association response in 2.4GHz.
> > > > Maybe this is what is confusing, can you please disable ieee80211ac=
=3D0
> > > > in the hostapd.conf and try?
> > > I disabled iee80211ac and I am not seeing VHT capabilities in Associa=
tion
> > > frames but the data rate remains the same.I am attaching wireshark ca=
pture.
> > okay, thanks.
> > > > The iw phy output is below. I couldn't see HE connection in this ou=
tput.
> > > >
> > > > $iw dev wlp3s0 link
> > > > Connected to 8c:c6:81:69:86:65 (on wlp3s0)
> > > >     SSID: WiFi_AX200
> > > >     freq: 2437
> > > >     RX: 27838 bytes (199 packets)
> > > >     TX: 13319 bytes (97 packets)
> > > >     signal: -34 dBm
> > > >     rx bitrate: 26.0 MBit/s MCS 3
> > > >     tx bitrate: 2.0 MBit/s
> > > >
> > > >     bss flags:    short-slot-time
> > > >     dtim period:    2
> > > >     beacon int:    100
> > > >
> > > > > The link doesn't show any specific details related to HE other th=
an
> > > > > the MCS which can vary, try running
> > > > > an iperf to see HE MCSes in a clean channel.
> > >
> > > Could you please explain what this means.
> > > I want to know what clean channel means and where actually I can see =
HE MCSes.
> >
> > > Sure. The link command doesn't printout any in capability information=
 explicitly
> > > except for the MCS details. And figuring out the mode of connection (=
11n/11ax)
> > > from the MCS is tricky as the MCS varies across depending on the rate
> > > control algorithm
> > > (for iwlwifi: hardware). So, I was suggesting to use iperf (the more
> > > data you pass, more
> > > chance of the rate control algo to go to higher MCSes) and also by
> > > "clean channels" I was
> > > referring to quieter channels where there are no other BSSes or no
> > > other traffic.
> > Okay. I tried running iperf for long period of time between AP and STA
> > (injected incremental traffic ,like running more parallel connections b=
etween
> > iperf server and iperf client ) and  I did not see any changes in MCSes=
.
> > It remained the same throughout the time I ran the iperf test.
> > Okay, this was to rule out any rate control issues but as it turned out=
 to be
> > a functional issue, we can ignore this for now.
> Okay
>
> >
> > > >But, before we go into debugging data path, I still don't understand
> > > >why wpa_supplicant
> > > >isn't saying it is a HE association?
> >
> > > > Ah, After staring at the code and using blame, a crucial fix missed
> > > > out hostap-2.9 windows,
> > > > the fix was to properly validate the HE capabilities, I was looking=
 at
> > > > the latest cod and
> > > > everything looked fine, hence took time.
> >
> > > > hostap_2_9-> 7th August
> > > >0497e4148197fb8fdf92b5c901ce06df1bfa548c ->13th August
> > > >
> > > > Please use the latest HEAD of hostap.git, you need to compile it
> > > > manually and try the
> > > > test and let me know how it goes. (make sure all proper configs are=
 enabled)
> > > >
> > > > Previously I was using hostapd version 2.9 and with this version I =
could
> >  > >connect STA's to AP with the hostapd.conf which I had shared earlie=
r.
> > >
> > >  Now I pulled the latest HEAD and compiled it with proper flags enabl=
ed.
> > >  When I run hostapd now , the WiFi6 STA's(AX200) are not able to esta=
blish
> > >  solid connection to AP. In other words, I could see they are connect=
ing but
> > > hostapd is deleting the station. Below are the log pertaining to that
> > >
> > >  nl80211: NL80211_CMD_SET_STATION result: -5 (Input/output error)
> > > wlp3s0: STA 8c:c6:81:69:ac:80 IEEE 802.11: Could not set STA to kerne=
l driver
> > >  nl80211: sta_remove -> DEL_STATION wlp3s0 8c:c6:81:69:ac:80 --> 0 (S=
uccess)
>
> > First of all, the original problem is resolved, I can see he_capabs
> > now, but unfortunately
> > , the problem moved to the kernel :). There are many reasons why the
> > mac80211/iwlwifi
> > might return EIO, Could you please also share the dmesg as well when
> >this happens?
>
> Then, the hostapd version 2.9 may not be establishing a HE connection
> but the latest HEAD I used is  trying to establish one.
Yes, that was the hypothesis and it is now confirmed.
>
> dmesg is below:
>
> $dmesg
<snip...>
> [  217.159617] RIP: 0033:0x7f8e708f55b7
> [  217.159619] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00
> 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74
> 24 10
> [  217.159619] RSP: 002b:00007ffffed54048 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002e
> [  217.159621] RAX: ffffffffffffffda RBX: 0000557df150a5e0 RCX: 00007f8e7=
08f55b7
> [  217.159621] RDX: 0000000000000000 RSI: 00007ffffed54080 RDI: 000000000=
0000005
> [  217.159622] RBP: 0000557df1514bd0 R08: 0000000000000004 R09: 000000000=
0000000
> [  217.159622] R10: 00007ffffed54164 R11: 0000000000000246 R12: 0000557df=
1508aa0
> [  217.159623] R13: 00007ffffed54080 R14: 0000000000000000 R15: 000000000=
0000000
> [  217.824610] iwlwifi 0000:03:00.0: Applying debug destination EXTERNAL_=
DRAM
> [  217.993230] iwlwifi 0000:03:00.0: FW already configured (0) - re-confi=
guring
> [  228.315161] iwlwifi 0000:03:00.0: Microcode SW error detected.
> Restarting 0x0.
> [  228.315276] iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
> [  228.315281] iwlwifi 0000:03:00.0: Status: 0x00000040, count: 6
> [  228.315285] iwlwifi 0000:03:00.0: Loaded firmware version: 48.4fa0041f=
.0
> [  228.315290] iwlwifi 0000:03:00.0: 0x00002078 | ADVANCED_SYSASSERT
> [  228.315294] iwlwifi 0000:03:00.0: 0x00A0A200 | trm_hw_status0
> [  228.315297] iwlwifi 0000:03:00.0: 0x00000000 | trm_hw_status1
> [  228.315300] iwlwifi 0000:03:00.0: 0x004F8E3C | branchlink2
> [  228.315303] iwlwifi 0000:03:00.0: 0x004E4FF4 | interruptlink1
> [  228.315307] iwlwifi 0000:03:00.0: 0x004E4FF4 | interruptlink2
> [  228.315310] iwlwifi 0000:03:00.0: 0x07000101 | data1
> [  228.315313] iwlwifi 0000:03:00.0: 0x48308403 | data2
> [  228.315316] iwlwifi 0000:03:00.0: 0x00000005 | data3
> [  228.315319] iwlwifi 0000:03:00.0: 0x00000000 | beacon time
> [  228.315322] iwlwifi 0000:03:00.0: 0x009FA807 | tsf low
> [  228.315326] iwlwifi 0000:03:00.0: 0x00000000 | tsf hi
> [  228.315329] iwlwifi 0000:03:00.0: 0x00000000 | time gp1
> [  228.315332] iwlwifi 0000:03:00.0: 0x00A01170 | time gp2
> [  228.315335] iwlwifi 0000:03:00.0: 0x00000001 | uCode revision type
> [  228.315338] iwlwifi 0000:03:00.0: 0x00000030 | uCode version major
> [  228.315342] iwlwifi 0000:03:00.0: 0x4FA0041F | uCode version minor
> [  228.315345] iwlwifi 0000:03:00.0: 0x00000340 | hw version
> [  228.315348] iwlwifi 0000:03:00.0: 0x00489000 | board version
> [  228.315351] iwlwifi 0000:03:00.0: 0x802CFC09 | hcmd
> [  228.315354] iwlwifi 0000:03:00.0: 0x24020000 | isr0
> [  228.315357] iwlwifi 0000:03:00.0: 0x61000000 | isr1
> [  228.315360] iwlwifi 0000:03:00.0: 0x18F00002 | isr2
> [  228.315363] iwlwifi 0000:03:00.0: 0x00C1FFCC | isr3
> [  228.315366] iwlwifi 0000:03:00.0: 0x00000000 | isr4
> [  228.315369] iwlwifi 0000:03:00.0: 0x0405001C | last cmd Id
> [  228.315372] iwlwifi 0000:03:00.0: 0x00016D22 | wait_event
> [  228.315375] iwlwifi 0000:03:00.0: 0x00000000 | l2p_control
> [  228.315379] iwlwifi 0000:03:00.0: 0x00018034 | l2p_duration
> [  228.315382] iwlwifi 0000:03:00.0: 0x0000003F | l2p_mhvalid
> [  228.315385] iwlwifi 0000:03:00.0: 0x00CB0000 | l2p_addr_match
> [  228.315388] iwlwifi 0000:03:00.0: 0x00000009 | lmpm_pmg_sel
> [  228.315391] iwlwifi 0000:03:00.0: 0x00000000 | timestamp
> [  228.315394] iwlwifi 0000:03:00.0: 0x00004894 | flow_handler
> [  228.315452] iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
> [  228.315455] iwlwifi 0000:03:00.0: Status: 0x00000040, count: 7
> [  228.315459] iwlwifi 0000:03:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATA=
L
> [  228.315462] iwlwifi 0000:03:00.0: 0x00000000 | umac branchlink1
> [  228.315465] iwlwifi 0000:03:00.0: 0xC008CC3C | umac branchlink2
> [  228.315468] iwlwifi 0000:03:00.0: 0x8048D0E6 | umac interruptlink1
> [  228.315472] iwlwifi 0000:03:00.0: 0x8048D0E6 | umac interruptlink2
> [  228.315475] iwlwifi 0000:03:00.0: 0x00000400 | umac data1
> [  228.315478] iwlwifi 0000:03:00.0: 0x8048D0E6 | umac data2
> [  228.315481] iwlwifi 0000:03:00.0: 0x00000000 | umac data3
> [  228.315484] iwlwifi 0000:03:00.0: 0x00000030 | umac major
> [  228.315487] iwlwifi 0000:03:00.0: 0x4FA0041F | umac minor
> [  228.315490] iwlwifi 0000:03:00.0: 0x00A01180 | frame pointer
> [  228.315493] iwlwifi 0000:03:00.0: 0xC0886284 | stack pointer
> [  228.315496] iwlwifi 0000:03:00.0: 0x003B050F | last host cmd
> [  228.315499] iwlwifi 0000:03:00.0: 0x00000000 | isr status reg
> [  228.315530] iwlwifi 0000:03:00.0: Fseq Registers:
> [  228.315543] iwlwifi 0000:03:00.0: 0xE0000101 | FSEQ_ERROR_CODE
> [  228.315555] iwlwifi 0000:03:00.0: 0x00290011 | FSEQ_TOP_INIT_VERSION
> [  228.315568] iwlwifi 0000:03:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
> [  228.315581] iwlwifi 0000:03:00.0: 0x0000A503 | FSEQ_OTP_VERSION
> [  228.315594] iwlwifi 0000:03:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSIO=
N
> [  228.315606] iwlwifi 0000:03:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> [  228.315619] iwlwifi 0000:03:00.0: 0x00100530 | FSEQ_CNVI_ID
> [  228.315632] iwlwifi 0000:03:00.0: 0x00000532 | FSEQ_CNVR_ID
> [  228.315644] iwlwifi 0000:03:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
> [  228.315659] iwlwifi 0000:03:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
> [  228.315674] iwlwifi 0000:03:00.0: 0x05B0905B |
> CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> [  228.315689] iwlwifi 0000:03:00.0: 0x0000025B |
> CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> [  228.315833] iwlwifi 0000:03:00.0: Collecting data: trigger 2 fired.
> [  228.315842] ieee80211 phy0: Hardware restart was requested
> [  228.315867] iwlwifi 0000:03:00.0: FW error in SYNC CMD ADD_STA
> [  228.315877] CPU: 2 PID: 3471 Comm: hostapd Tainted: P           OE
>    5.4.0-42-generic #46-Ubuntu
> [  228.315879] Hardware name: LENOVO 20FXS1FA00/20FXS1FA00, BIOS
> R07ET91W (2.31 ) 12/11/2019
> [  228.315880] Call Trace:
> [  228.315893]  dump_stack+0x6d/0x9a
> [  228.315918]  iwl_trans_pcie_gen2_send_hcmd+0x3de/0x3f0 [iwlwifi]
> [  228.315924]  ? wait_woken+0x80/0x80
> [  228.315944]  iwl_trans_send_cmd+0x55/0xc0 [iwlwifi]
> [  228.315965]  iwl_mvm_send_cmd_status+0x38/0xd0 [iwlmvm]
> [  228.315983]  iwl_mvm_send_cmd_pdu_status+0x53/0x70 [iwlmvm]
> [  228.316002]  iwl_mvm_sta_send_to_fw+0x1ca/0x310 [iwlmvm]
> [  228.316017]  iwl_mvm_mac_sta_state+0x3e1/0x6e0 [iwlmvm]
> [  228.316023]  ? __switch_to_asm+0x40/0x70
> [  228.316060]  drv_sta_state+0x96/0x3f0 [mac80211]
> [  228.316094]  sta_info_move_state+0x276/0x370 [mac80211]
> [  228.316134]  sta_apply_auth_flags.isra.0+0x73/0x140 [mac80211]
> [  228.316170]  sta_apply_parameters+0x34c/0x690 [mac80211]
> [  228.316204]  ieee80211_change_station+0x130/0x340 [mac80211]
> [  228.316244]  ? nl80211_parse_sta_wme.isra.0+0x50/0xc0 [cfg80211]
> [  228.316278]  nl80211_set_station+0x365/0x440 [cfg80211]
> [  228.316286]  genl_family_rcv_msg+0x1b9/0x470
> [  228.316291]  genl_rcv_msg+0x4c/0xa0
> [  228.316301]  ? _cond_resched+0x19/0x30
> [  228.316304]  ? genl_family_rcv_msg+0x470/0x470
> [  228.316307]  netlink_rcv_skb+0x50/0x120
> [  228.316311]  genl_rcv+0x29/0x40
> [  228.316314]  netlink_unicast+0x187/0x220
> [  228.316317]  netlink_sendmsg+0x222/0x3e0
> [  228.316323]  sock_sendmsg+0x65/0x70
> [  228.316326]  ____sys_sendmsg+0x212/0x280
> [  228.316331]  ___sys_sendmsg+0x88/0xd0
> [  228.316336]  ? __wake_up_common_lock+0x8a/0xc0
> [  228.316340]  ? __wake_up+0x13/0x20
> [  228.316346]  ? tty_write_unlock+0x31/0x40
> [  228.316352]  ? __cgroup_bpf_run_filter_setsockopt+0xae/0x2c0
> [  228.316354]  ? _cond_resched+0x19/0x30
> [  228.316359]  ? aa_sk_perm+0x43/0x170
> [  228.316364]  __sys_sendmsg+0x5c/0xa0
> [  228.316369]  __x64_sys_sendmsg+0x1f/0x30
> [  228.316375]  do_syscall_64+0x57/0x190
> [  228.316379]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  228.316383] RIP: 0033:0x7f8e708f55b7
> [  228.316388] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00
> 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74
> 24 10
> [  228.316390] RSP: 002b:00007ffffed54048 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002e
> [  228.316394] RAX: ffffffffffffffda RBX: 0000557df150a5e0 RCX: 00007f8e7=
08f55b7
> [  228.316396] RDX: 0000000000000000 RSI: 00007ffffed54080 RDI: 000000000=
0000005
> [  228.316398] RBP: 0000557df1514bd0 R08: 0000000000000004 R09: 000000000=
0000000
> [  228.316399] R10: 00007ffffed54164 R11: 0000000000000246 R12: 0000557df=
1508aa0
> [  228.316401] R13: 00007ffffed54080 R14: 0000000000000000 R15: 000000000=
0000000
> [  228.966456] iwlwifi 0000:03:00.0: Failed to trigger RX queues sync (-5=
)
> [  228.992214] iwlwifi 0000:03:00.0: Applying debug destination EXTERNAL_=
DRAM
> [  229.161947] iwlwifi 0000:03:00.0: FW already configured (0) - re-confi=
guring
Urgh...a LMAC firmware crash in the sta_add. I will leave this to the
Intel guys.
+ Linux Wireless
I am still not sure if this a genuine issue or just an
incompatibility, I would suggest you to
switch to iwlwifi-next.git with corresponding latest iwlwifi firmware.
>
>
>
> >
> > Also I could see multiple Association requests and responses. On the
> > other hand I am
> > able to connect WiFi4(802.11n) STA's to AP. I am attaching the hostapd =
logs
> > with debugs enabled and also wireshark captures.
> This is in line with the logs, as Set-STA is failing association
> request will not go through.
>
> >
> > > > On Wed, Sep 2, 2020 at 3:39 PM Krishna Chaitanya
> > > > <chaitanya.mgit at gmail.com> wrote:
> > > > >
> > > > > On Wed, Sep 2, 2020 at 6:38 PM Sugandh Huthanahally Mohan
> > > > > <sugandhgowda at gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > Well, not necessarily, but hostap side it looks fine, so,
> > > > > > > > we need to see why the STA isn't responding well, probably =
a
> > > > > > > > different draft implementation. At the very least we should=
 start
> > > > > > > > with a sniffer capture of the association b/w the stations =
to check
> > > > > > > > the IEs.
> > > > > > >
> > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > I am observing that the STA is connecting and disconnecting w=
hen
> > > > > > > I try to connect STA to AP.
> > > > > > I guess this is a new STA with wpa_supplicant, right? Is it als=
o AX200 based
> > > > > > chipset? In the STA mode, the kernel adds the HE IEs (either ma=
c80211
> > > > > > or the driver),
> > > > > > so, but interestingly in your previous dmesg, I don't see any m=
ac80211 logs.
> > > > > >
> > > > > > So, need dmesg logs that capture the connection (look for mac80=
211 logs).
> > > > > > >
> > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally Mohan
> > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Krishna,
> > > > > > > > >
> > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > Is it necessary for hostapd?
> > > > > > > >
> > > > > > > > Well, not necessarily, but hostap side it looks fine, so,
> > > > > > > > we need to see why the STA isn't responding well, probably =
a
> > > > > > > > different draft implementation. At the very least we should=
 start
> > > > > > > > with a sniffer capture of the association b/w the stations =
to check
> > > > > > > > the IEs.
> > > > > >
> > > > > > Yes this is a new STA connecting AP with wpa_supplicant.
> > > > > > It is also an AX200.
> > > > > > I don=E2=80=99t see mac80211 logs on the STA dmesg.
> > > > > > I am attaching dmesg of the station.
> > > > >
> > > > > These are from mac80211:
> > > > > [  152.255545] wlp3s0: authenticate with 8c:c6:81:69:86:65
> > > > > [  152.258347] wlp3s0: send auth to 8c:c6:81:69:86:65 (try 1/3)
> > > > > [  152.283971] wlp3s0: authenticated
> > > > > [  152.286624] wlp3s0: associate with 8c:c6:81:69:86:65 (try 1/3)
> > > > > [  152.293456] wlp3s0: RX AssocResp from 8c:c6:81:69:86:65
> > > > > (capab=3D0x411 status=3D0 aid=3D1)
> > > > > [  152.299672] wlp3s0: associated
> > > > > [  152.364843] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link become=
s ready
> > > > >
> > > > > I was hoping to see some prints disabling HE, but looks fine. So,
> > > > > still, nothing from the logs
> > > > > to say why HE is disabled in the STA (why it isn't sending HE IEs=
 in
> > > > > assoc resp).
> > > > >
> > > > > Only Sniffer should tell us without resorting to Whitebox debug.
> > > > > >
> > > > > > On Wed, Sep 2, 2020 at 1:26 PM Krishna Chaitanya
> > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Well, not necessarily, but hostap side it looks fine, so,
> > > > > > > > > we need to see why the STA isn't responding well, probabl=
y a
> > > > > > > > > different draft implementation. At the very least we shou=
ld start
> > > > > > > > > with a sniffer capture of the association b/w the station=
s to check
> > > > > > > > > the IEs.
> > > > > > > >
> > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > I am observing that the STA is connecting and disconnecting=
 when
> > > > > > > > I try to connect STA to AP.
> > > > > > > I guess this is a new STA with wpa_supplicant, right? Is it a=
lso AX200 based
> > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (either =
mac80211
> > > > > > > or the driver),
> > > > > > > so, but interestingly in your previous dmesg, I don't see any=
 mac80211 logs.
> > > > > > >
> > > > > > > So, need dmesg logs that capture the connection (look for mac=
80211 logs).
> > > > > > > >
> > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally Mohan
> > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Krishna,
> > > > > > > > > >
> > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > >
> > > > > > > > > Well, not necessarily, but hostap side it looks fine, so,
> > > > > > > > > we need to see why the STA isn't responding well, probabl=
y a
> > > > > > > > > different draft implementation. At the very least we shou=
ld start
> > > > > > > > > with a sniffer capture of the association b/w the station=
s to check
> > > > > > > > > the IEs.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Thanks,
> > > > > > > Regards,
> > > > > > > Chaitanya T K.
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Thanks,
> > > > > Regards,
> > > > > Chaitanya T K.
> > >
> > >
> > > On Tue, Sep 8, 2020 at 9:55 PM Krishna Chaitanya
> > > <chaitanya.mgit at gmail.com> wrote:
> > > >
> > > > On Wed, Sep 9, 2020 at 12:27 AM Sugandh Huthanahally Mohan
> > > > <sugandhgowda at gmail.com> wrote:
> > > > >
> > > > > I have captured connection between a WiFi6 AP and a WiFi6 STA in =
wireshark.
> > > > > I have attached a wireshark pcap file.
> > > > > I could see HE capabilities exchange in Association request and r=
esponse.
> > > > Yes, this looks fine to me except for VHT IEs in the probe and
> > > > association response in 2.4GHz.
> > > > Maybe this is what is confusing, can you please disable ieee80211ac=
=3D0
> > > > in the hostapd.conf and try?
> > > >
> > > > > The iw phy output is below. I couldn't see HE connection in this =
output.
> > > > >
> > > > > $iw dev wlp3s0 link
> > > > > Connected to 8c:c6:81:69:86:65 (on wlp3s0)
> > > > >     SSID: WiFi_AX200
> > > > >     freq: 2437
> > > > >     RX: 27838 bytes (199 packets)
> > > > >     TX: 13319 bytes (97 packets)
> > > > >     signal: -34 dBm
> > > > >     rx bitrate: 26.0 MBit/s MCS 3
> > > > >     tx bitrate: 2.0 MBit/s
> > > > >
> > > > >     bss flags:    short-slot-time
> > > > >     dtim period:    2
> > > > >     beacon int:    100
> > > > >
> > > > The link doesn't show any specific details related to HE other than
> > > > the MCS which can vary, try running
> > > > an iperf to see HE MCSes in a clean channel.
> > > > >
> > > > > On Wed, Sep 2, 2020 at 3:39 PM Krishna Chaitanya
> > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 2, 2020 at 6:38 PM Sugandh Huthanahally Mohan
> > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Well, not necessarily, but hostap side it looks fine, so,
> > > > > > > > > we need to see why the STA isn't responding well, probabl=
y a
> > > > > > > > > different draft implementation. At the very least we shou=
ld start
> > > > > > > > > with a sniffer capture of the association b/w the station=
s to check
> > > > > > > > > the IEs.
> > > > > > > >
> > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > I am observing that the STA is connecting and disconnecting=
 when
> > > > > > > > I try to connect STA to AP.
> > > > > > > I guess this is a new STA with wpa_supplicant, right? Is it a=
lso AX200 based
> > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (either =
mac80211
> > > > > > > or the driver),
> > > > > > > so, but interestingly in your previous dmesg, I don't see any=
 mac80211 logs.
> > > > > > >
> > > > > > > So, need dmesg logs that capture the connection (look for mac=
80211 logs).
> > > > > > > >
> > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally Mohan
> > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Krishna,
> > > > > > > > > >
> > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > >
> > > > > > > > > Well, not necessarily, but hostap side it looks fine, so,
> > > > > > > > > we need to see why the STA isn't responding well, probabl=
y a
> > > > > > > > > different draft implementation. At the very least we shou=
ld start
> > > > > > > > > with a sniffer capture of the association b/w the station=
s to check
> > > > > > > > > the IEs.
> > > > > > >
> > > > > > > Yes this is a new STA connecting AP with wpa_supplicant.
> > > > > > > It is also an AX200.
> > > > > > > I don=E2=80=99t see mac80211 logs on the STA dmesg.
> > > > > > > I am attaching dmesg of the station.
> > > > > >
> > > > > > These are from mac80211:
> > > > > > [  152.255545] wlp3s0: authenticate with 8c:c6:81:69:86:65
> > > > > > [  152.258347] wlp3s0: send auth to 8c:c6:81:69:86:65 (try 1/3)
> > > > > > [  152.283971] wlp3s0: authenticated
> > > > > > [  152.286624] wlp3s0: associate with 8c:c6:81:69:86:65 (try 1/=
3)
> > > > > > [  152.293456] wlp3s0: RX AssocResp from 8c:c6:81:69:86:65
> > > > > > (capab=3D0x411 status=3D0 aid=3D1)
> > > > > > [  152.299672] wlp3s0: associated
> > > > > > [  152.364843] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link beco=
mes ready
> > > > > >
> > > > > > I was hoping to see some prints disabling HE, but looks fine. S=
o,
> > > > > > still, nothing from the logs
> > > > > > to say why HE is disabled in the STA (why it isn't sending HE I=
Es in
> > > > > > assoc resp).
> > > > > >
> > > > > > Only Sniffer should tell us without resorting to Whitebox debug=
.
> > > > > > >
> > > > > > > On Wed, Sep 2, 2020 at 1:26 PM Krishna Chaitanya
> > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > > >
> > > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > > I am observing that the STA is connecting and disconnecti=
ng when
> > > > > > > > > I try to connect STA to AP.
> > > > > > > > I guess this is a new STA with wpa_supplicant, right? Is it=
 also AX200 based
> > > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (eithe=
r mac80211
> > > > > > > > or the driver),
> > > > > > > > so, but interestingly in your previous dmesg, I don't see a=
ny mac80211 logs.
> > > > > > > >
> > > > > > > > So, need dmesg logs that capture the connection (look for m=
ac80211 logs).
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally Moh=
an
> > > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Krishna,
> > > > > > > > > > >
> > > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Thanks,
> > > > > > > > Regards,
> > > > > > > > Chaitanya T K.
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks,
> > > > > > Regards,
> > > > > > Chaitanya T K.
> >
> >
> > On Wed, Sep 9, 2020 at 12:53 AM Krishna Chaitanya
> > <chaitanya.mgit@gmail.com> wrote:
> > >
> > > On Wed, Sep 9, 2020 at 2:18 AM Sugandh Huthanahally Mohan
> > > <sugandhgowda@gmail.com> wrote:
> > > >
> > > > On Wed, Sep 9, 2020 at 12:27 AM Sugandh Huthanahally Mohan
> > > > <sugandhgowda at gmail.com> wrote:
> > > > > >
> > > > > > I have captured connection between a WiFi6 AP and a WiFi6 STA i=
n wireshark.
> > > > > >I have attached a wireshark pcap file.
> > > > > > I could see HE capabilities exchange in Association request and=
 response.
> > > > > Yes, this looks fine to me except for VHT IEs in the probe and
> > > > > association response in 2.4GHz.
> > > > > Maybe this is what is confusing, can you please disable ieee80211=
ac=3D0
> > > > > in the hostapd.conf and try?
> > > > I disabled iee80211ac and I am not seeing VHT capabilities in Assoc=
iation
> > > > frames but the data rate remains the same.I am attaching wireshark =
capture.
> > > okay, thanks.
> > > > > The iw phy output is below. I couldn't see HE connection in this =
output.
> > > > >
> > > > > $iw dev wlp3s0 link
> > > > > Connected to 8c:c6:81:69:86:65 (on wlp3s0)
> > > > >     SSID: WiFi_AX200
> > > > >     freq: 2437
> > > > >     RX: 27838 bytes (199 packets)
> > > > >     TX: 13319 bytes (97 packets)
> > > > >     signal: -34 dBm
> > > > >     rx bitrate: 26.0 MBit/s MCS 3
> > > > >     tx bitrate: 2.0 MBit/s
> > > > >
> > > > >     bss flags:    short-slot-time
> > > > >     dtim period:    2
> > > > >     beacon int:    100
> > > > >
> > > > > > The link doesn't show any specific details related to HE other =
than
> > > > > > the MCS which can vary, try running
> > > > > > an iperf to see HE MCSes in a clean channel.
> > > >
> > > > Could you please explain what this means.
> > > > I want to know what clean channel means and where actually I can se=
e HE MCSes.
> > >
> > > Sure. The link command doesn't printout any in capability information=
 explicitly
> > >  except for the MCS details. And figuring out the mode of connection =
(11n/11ax)
> > > from the MCS is tricky as the MCS varies across depending on the rate
> > > control algorithm
> > > (for iwlwifi: hardware). So, I was suggesting to use iperf (the more
> > > data you pass, more
> > > chance of the rate control algo to go to higher MCSes) and also by
> > > "clean channels" I was
> > > referring to quieter channels where there are no other BSSes or no
> > > other traffic.
> > >
> > > But, before we go into debugging data path, I still don't understand
> > > why wpa_supplicant
> > > isn't saying it is a HE association?
> > >
> > > Ah, After staring at the code and using blame, a crucial fix missed
> > > out hostap-2.9 windows,
> > > the fix was to properly validate the HE capabilities, I was looking a=
t
> > > the latest cod and
> > > everything looked fine, hence took time.
> > >
> > > hostap_2_9-> 7th August
> > > 0497e4148197fb8fdf92b5c901ce06df1bfa548c ->13th August
> > >
> > > Please use the latest HEAD of hostap.git, you need to compile it
> > > manually and try the
> > > test and let me know how it goes. (make sure all proper configs are e=
nabled)
> > >
> > > > > On Wed, Sep 2, 2020 at 3:39 PM Krishna Chaitanya
> > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 2, 2020 at 6:38 PM Sugandh Huthanahally Mohan
> > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Well, not necessarily, but hostap side it looks fine, so,
> > > > > > > > > we need to see why the STA isn't responding well, probabl=
y a
> > > > > > > > > different draft implementation. At the very least we shou=
ld start
> > > > > > > > > with a sniffer capture of the association b/w the station=
s to check
> > > > > > > > > the IEs.
> > > > > > > >
> > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > I am observing that the STA is connecting and disconnecting=
 when
> > > > > > > > I try to connect STA to AP.
> > > > > > > I guess this is a new STA with wpa_supplicant, right? Is it a=
lso AX200 based
> > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (either =
mac80211
> > > > > > > or the driver),
> > > > > > > so, but interestingly in your previous dmesg, I don't see any=
 mac80211 logs.
> > > > > > >
> > > > > > > So, need dmesg logs that capture the connection (look for mac=
80211 logs).
> > > > > > > >
> > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally Mohan
> > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Krishna,
> > > > > > > > > >
> > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > >
> > > > > > > > > Well, not necessarily, but hostap side it looks fine, so,
> > > > > > > > > we need to see why the STA isn't responding well, probabl=
y a
> > > > > > > > > different draft implementation. At the very least we shou=
ld start
> > > > > > > > > with a sniffer capture of the association b/w the station=
s to check
> > > > > > > > > the IEs.
> > > > > > >
> > > > > > > Yes this is a new STA connecting AP with wpa_supplicant.
> > > > > > > It is also an AX200.
> > > > > > > I don=E2=80=99t see mac80211 logs on the STA dmesg.
> > > > > > > I am attaching dmesg of the station.
> > > > > >
> > > > > > These are from mac80211:
> > > > > > [  152.255545] wlp3s0: authenticate with 8c:c6:81:69:86:65
> > > > > > [  152.258347] wlp3s0: send auth to 8c:c6:81:69:86:65 (try 1/3)
> > > > > > [  152.283971] wlp3s0: authenticated
> > > > > > [  152.286624] wlp3s0: associate with 8c:c6:81:69:86:65 (try 1/=
3)
> > > > > > [  152.293456] wlp3s0: RX AssocResp from 8c:c6:81:69:86:65
> > > > > > (capab=3D0x411 status=3D0 aid=3D1)
> > > > > > [  152.299672] wlp3s0: associated
> > > > > > [  152.364843] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link beco=
mes ready
> > > > > >
> > > > > > I was hoping to see some prints disabling HE, but looks fine. S=
o,
> > > > > > still, nothing from the logs
> > > > > > to say why HE is disabled in the STA (why it isn't sending HE I=
Es in
> > > > > > assoc resp).
> > > > > >
> > > > > > Only Sniffer should tell us without resorting to Whitebox debug=
.
> > > > > > >
> > > > > > > On Wed, Sep 2, 2020 at 1:26 PM Krishna Chaitanya
> > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > > >
> > > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > > I am observing that the STA is connecting and disconnecti=
ng when
> > > > > > > > > I try to connect STA to AP.
> > > > > > > > I guess this is a new STA with wpa_supplicant, right? Is it=
 also AX200 based
> > > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (eithe=
r mac80211
> > > > > > > > or the driver),
> > > > > > > > so, but interestingly in your previous dmesg, I don't see a=
ny mac80211 logs.
> > > > > > > >
> > > > > > > > So, need dmesg logs that capture the connection (look for m=
ac80211 logs).
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally Moh=
an
> > > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Krishna,
> > > > > > > > > > >
> > > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Thanks,
> > > > > > > > Regards,
> > > > > > > > Chaitanya T K.
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks,
> > > > > > Regards,
> > > > > > Chaitanya T K.
> > > >
> > > >
> > > > On Tue, Sep 8, 2020 at 9:55 PM Krishna Chaitanya
> > > > <chaitanya.mgit@gmail.com> wrote:
> > > > >
> > > > > On Wed, Sep 9, 2020 at 12:27 AM Sugandh Huthanahally Mohan
> > > > > <sugandhgowda@gmail.com> wrote:
> > > > > >
> > > > > > I have captured connection between a WiFi6 AP and a WiFi6 STA i=
n wireshark.
> > > > > > I have attached a wireshark pcap file.
> > > > > > I could see HE capabilities exchange in Association request and=
 response.
> > > > > Yes, this looks fine to me except for VHT IEs in the probe and
> > > > > association response in 2.4GHz.
> > > > > Maybe this is what is confusing, can you please disable ieee80211=
ac=3D0
> > > > > in the hostapd.conf and try?
> > > > >
> > > > > > The iw phy output is below. I couldn't see HE connection in thi=
s output.
> > > > > >
> > > > > > $iw dev wlp3s0 link
> > > > > > Connected to 8c:c6:81:69:86:65 (on wlp3s0)
> > > > > >     SSID: WiFi_AX200
> > > > > >     freq: 2437
> > > > > >     RX: 27838 bytes (199 packets)
> > > > > >     TX: 13319 bytes (97 packets)
> > > > > >     signal: -34 dBm
> > > > > >     rx bitrate: 26.0 MBit/s MCS 3
> > > > > >     tx bitrate: 2.0 MBit/s
> > > > > >
> > > > > >     bss flags:    short-slot-time
> > > > > >     dtim period:    2
> > > > > >     beacon int:    100
> > > > > >
> > > > > The link doesn't show any specific details related to HE other th=
an
> > > > > the MCS which can vary, try running
> > > > > an iperf to see HE MCSes in a clean channel.
> > > > > >
> > > > > > On Wed, Sep 2, 2020 at 3:39 PM Krishna Chaitanya
> > > > > > <chaitanya.mgit@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 2, 2020 at 6:38 PM Sugandh Huthanahally Mohan
> > > > > > > <sugandhgowda@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > > >
> > > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > > I am observing that the STA is connecting and disconnecti=
ng when
> > > > > > > > > I try to connect STA to AP.
> > > > > > > > I guess this is a new STA with wpa_supplicant, right? Is it=
 also AX200 based
> > > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (eithe=
r mac80211
> > > > > > > > or the driver),
> > > > > > > > so, but interestingly in your previous dmesg, I don't see a=
ny mac80211 logs.
> > > > > > > >
> > > > > > > > So, need dmesg logs that capture the connection (look for m=
ac80211 logs).
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally Moh=
an
> > > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Krishna,
> > > > > > > > > > >
> > > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > >
> > > > > > > > Yes this is a new STA connecting AP with wpa_supplicant.
> > > > > > > > It is also an AX200.
> > > > > > > > I don=E2=80=99t see mac80211 logs on the STA dmesg.
> > > > > > > > I am attaching dmesg of the station.
> > > > > > >
> > > > > > > These are from mac80211:
> > > > > > > [  152.255545] wlp3s0: authenticate with 8c:c6:81:69:86:65
> > > > > > > [  152.258347] wlp3s0: send auth to 8c:c6:81:69:86:65 (try 1/=
3)
> > > > > > > [  152.283971] wlp3s0: authenticated
> > > > > > > [  152.286624] wlp3s0: associate with 8c:c6:81:69:86:65 (try =
1/3)
> > > > > > > [  152.293456] wlp3s0: RX AssocResp from 8c:c6:81:69:86:65
> > > > > > > (capab=3D0x411 status=3D0 aid=3D1)
> > > > > > > [  152.299672] wlp3s0: associated
> > > > > > > [  152.364843] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link be=
comes ready
> > > > > > >
> > > > > > > I was hoping to see some prints disabling HE, but looks fine.=
 So,
> > > > > > > still, nothing from the logs
> > > > > > > to say why HE is disabled in the STA (why it isn't sending HE=
 IEs in
> > > > > > > assoc resp).
> > > > > > >
> > > > > > > Only Sniffer should tell us without resorting to Whitebox deb=
ug.
> > > > > > > >
> > > > > > > > On Wed, Sep 2, 2020 at 1:26 PM Krishna Chaitanya
> > > > > > > > <chaitanya.mgit@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > > > <sugandhgowda@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Well, not necessarily, but hostap side it looks fine,=
 so,
> > > > > > > > > > > we need to see why the STA isn't responding well, pro=
bably a
> > > > > > > > > > > different draft implementation. At the very least we =
should start
> > > > > > > > > > > with a sniffer capture of the association b/w the sta=
tions to check
> > > > > > > > > > > the IEs.
> > > > > > > > > >
> > > > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > > > I am observing that the STA is connecting and disconnec=
ting when
> > > > > > > > > > I try to connect STA to AP.
> > > > > > > > > I guess this is a new STA with wpa_supplicant, right? Is =
it also AX200 based
> > > > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (eit=
her mac80211
> > > > > > > > > or the driver),
> > > > > > > > > so, but interestingly in your previous dmesg, I don't see=
 any mac80211 logs.
> > > > > > > > >
> > > > > > > > > So, need dmesg logs that capture the connection (look for=
 mac80211 logs).
> > > > > > > > > >
> > > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > > <chaitanya.mgit@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally M=
ohan
> > > > > > > > > > > <sugandhgowda@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Krishna,
> > > > > > > > > > > >
> > > > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > > > >
> > > > > > > > > > > Well, not necessarily, but hostap side it looks fine,=
 so,
> > > > > > > > > > > we need to see why the STA isn't responding well, pro=
bably a
> > > > > > > > > > > different draft implementation. At the very least we =
should start
> > > > > > > > > > > with a sniffer capture of the association b/w the sta=
tions to check
> > > > > > > > > > > the IEs.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Thanks,
> > > > > > > > > Regards,
> > > > > > > > > Chaitanya T K.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Thanks,
> > > > > > > Regards,
> > > > > > > Chaitanya T K.
>
> On Fri, Sep 11, 2020 at 4:36 PM Krishna Chaitanya
> <chaitanya.mgit@gmail.com> wrote:
> >
> > On Fri, Sep 11, 2020 at 7:33 PM Sugandh Huthanahally Mohan
> > <sugandhgowda@gmail.com> wrote:
> > >
> > > On Wed, Sep 9, 2020 at 2:18 AM Sugandh Huthanahally Mohan
> > > <sugandhgowda at gmail.com> wrote:
> > > >
> > > > On Wed, Sep 9, 2020 at 12:27 AM Sugandh Huthanahally Mohan
> > > > <sugandhgowda at gmail.com> wrote:
> > > > > >
> > > > > > I have captured connection between a WiFi6 AP and a WiFi6 STA i=
n wireshark.
> > > > > >I have attached a wireshark pcap file.
> > > > > > I could see HE capabilities exchange in Association request and=
 response.
> > > > > Yes, this looks fine to me except for VHT IEs in the probe and
> > > > > association response in 2.4GHz.
> > > > > Maybe this is what is confusing, can you please disable ieee80211=
ac=3D0
> > > > > in the hostapd.conf and try?
> > > > I disabled iee80211ac and I am not seeing VHT capabilities in Assoc=
iation
> > > > frames but the data rate remains the same.I am attaching wireshark =
capture.
> > > okay, thanks.
> > > > > The iw phy output is below. I couldn't see HE connection in this =
output.
> > > > >
> > > > > $iw dev wlp3s0 link
> > > > > Connected to 8c:c6:81:69:86:65 (on wlp3s0)
> > > > >     SSID: WiFi_AX200
> > > > >     freq: 2437
> > > > >     RX: 27838 bytes (199 packets)
> > > > >     TX: 13319 bytes (97 packets)
> > > > >     signal: -34 dBm
> > > > >     rx bitrate: 26.0 MBit/s MCS 3
> > > > >     tx bitrate: 2.0 MBit/s
> > > > >
> > > > >     bss flags:    short-slot-time
> > > > >     dtim period:    2
> > > > >     beacon int:    100
> > > > >
> > > > > > The link doesn't show any specific details related to HE other =
than
> > > > > > the MCS which can vary, try running
> > > > > > an iperf to see HE MCSes in a clean channel.
> > > >
> > > > Could you please explain what this means.
> > > > I want to know what clean channel means and where actually I can se=
e HE MCSes.
> > >
> > > > Sure. The link command doesn't printout any in capability informati=
on explicitly
> > > > except for the MCS details. And figuring out the mode of connection=
 (11n/11ax)
> > > > from the MCS is tricky as the MCS varies across depending on the ra=
te
> > > > control algorithm
> > > > (for iwlwifi: hardware). So, I was suggesting to use iperf (the mor=
e
> > > > data you pass, more
> > > > chance of the rate control algo to go to higher MCSes) and also by
> > > > "clean channels" I was
> > > > referring to quieter channels where there are no other BSSes or no
> > > > other traffic.
> > > Okay. I tried running iperf for long period of time between AP and ST=
A
> > > (injected incremental traffic ,like running more parallel connections=
 between
> > > iperf server and iperf client ) and  I did not see any changes in MCS=
es.
> > > It remained the same throughout the time I ran the iperf test.
> > Okay, this was to rule out any rate control issues but as it turned out=
 to be
> > a functional issue, we can ignore this for now.
> > >
> > > > But, before we go into debugging data path, I still don't understan=
d
> > > > why wpa_supplicant
> > > > isn't saying it is a HE association?
> > >
> > > > Ah, After staring at the code and using blame, a crucial fix missed
> > > > out hostap-2.9 windows,
> > > > the fix was to properly validate the HE capabilities, I was looking=
 at
> > > > the latest cod and
> > > > everything looked fine, hence took time.
> > >
> > > > hostap_2_9-> 7th August
> > > > 0497e4148197fb8fdf92b5c901ce06df1bfa548c ->13th August
> > >
> > > > Please use the latest HEAD of hostap.git, you need to compile it
> > > > manually and try the
> > > > test and let me know how it goes. (make sure all proper configs are=
 enabled)
> > >
> > > Previously I was using hostapd version 2.9 and with this version I co=
uld
> > > connect STA's to AP with the hostapd.conf which I had shared earlier.
> > >
> > > Now I pulled the latest HEAD and compiled it with proper flags enable=
d.
> > > When I run hostapd now , the WiFi6 STA's(AX200) are not able to estab=
lish
> > > solid connection to AP. In other words, I could see they are connecti=
ng but
> > > hostapd is deleting the station. Below are the log pertaining to that
> > >
> > > nl80211: NL80211_CMD_SET_STATION result: -5 (Input/output error)
> > > wlp3s0: STA 8c:c6:81:69:ac:80 IEEE 802.11: Could not set STA to kerne=
l driver
> > > nl80211: sta_remove -> DEL_STATION wlp3s0 8c:c6:81:69:ac:80 --> 0 (Su=
ccess)
> > First of all, the original problem is resolved, I can see he_capabs
> > now, but unfortunately
> > , the problem moved to the kernel :). There are many reasons why the
> > mac80211/iwlwifi
> > might return EIO, Could you please also share the dmesg as well when
> > this happens?
> > >
> > >
> > > Also I could see multiple Association requests and responses. On the
> > > other hand I am
> > > able to connect WiFi4(802.11n) STA's to AP. I am attaching the hostap=
d logs
> > > with debugs enabled and also wireshark captures.
> > This is in line with the logs, as Set-STA is failing association
> > request will not go through.
> > >
> > > > > On Wed, Sep 2, 2020 at 3:39 PM Krishna Chaitanya
> > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 2, 2020 at 6:38 PM Sugandh Huthanahally Mohan
> > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Well, not necessarily, but hostap side it looks fine, so,
> > > > > > > > > we need to see why the STA isn't responding well, probabl=
y a
> > > > > > > > > different draft implementation. At the very least we shou=
ld start
> > > > > > > > > with a sniffer capture of the association b/w the station=
s to check
> > > > > > > > > the IEs.
> > > > > > > >
> > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > I am observing that the STA is connecting and disconnecting=
 when
> > > > > > > > I try to connect STA to AP.
> > > > > > > I guess this is a new STA with wpa_supplicant, right? Is it a=
lso AX200 based
> > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (either =
mac80211
> > > > > > > or the driver),
> > > > > > > so, but interestingly in your previous dmesg, I don't see any=
 mac80211 logs.
> > > > > > >
> > > > > > > So, need dmesg logs that capture the connection (look for mac=
80211 logs).
> > > > > > > >
> > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally Mohan
> > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Krishna,
> > > > > > > > > >
> > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > >
> > > > > > > > > Well, not necessarily, but hostap side it looks fine, so,
> > > > > > > > > we need to see why the STA isn't responding well, probabl=
y a
> > > > > > > > > different draft implementation. At the very least we shou=
ld start
> > > > > > > > > with a sniffer capture of the association b/w the station=
s to check
> > > > > > > > > the IEs.
> > > > > > >
> > > > > > > Yes this is a new STA connecting AP with wpa_supplicant.
> > > > > > > It is also an AX200.
> > > > > > > I don=E2=80=99t see mac80211 logs on the STA dmesg.
> > > > > > > I am attaching dmesg of the station.
> > > > > >
> > > > > > These are from mac80211:
> > > > > > [  152.255545] wlp3s0: authenticate with 8c:c6:81:69:86:65
> > > > > > [  152.258347] wlp3s0: send auth to 8c:c6:81:69:86:65 (try 1/3)
> > > > > > [  152.283971] wlp3s0: authenticated
> > > > > > [  152.286624] wlp3s0: associate with 8c:c6:81:69:86:65 (try 1/=
3)
> > > > > > [  152.293456] wlp3s0: RX AssocResp from 8c:c6:81:69:86:65
> > > > > > (capab=3D0x411 status=3D0 aid=3D1)
> > > > > > [  152.299672] wlp3s0: associated
> > > > > > [  152.364843] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link beco=
mes ready
> > > > > >
> > > > > > I was hoping to see some prints disabling HE, but looks fine. S=
o,
> > > > > > still, nothing from the logs
> > > > > > to say why HE is disabled in the STA (why it isn't sending HE I=
Es in
> > > > > > assoc resp).
> > > > > >
> > > > > > Only Sniffer should tell us without resorting to Whitebox debug=
.
> > > > > > >
> > > > > > > On Wed, Sep 2, 2020 at 1:26 PM Krishna Chaitanya
> > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > > >
> > > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > > I am observing that the STA is connecting and disconnecti=
ng when
> > > > > > > > > I try to connect STA to AP.
> > > > > > > > I guess this is a new STA with wpa_supplicant, right? Is it=
 also AX200 based
> > > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (eithe=
r mac80211
> > > > > > > > or the driver),
> > > > > > > > so, but interestingly in your previous dmesg, I don't see a=
ny mac80211 logs.
> > > > > > > >
> > > > > > > > So, need dmesg logs that capture the connection (look for m=
ac80211 logs).
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally Moh=
an
> > > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Krishna,
> > > > > > > > > > >
> > > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Thanks,
> > > > > > > > Regards,
> > > > > > > > Chaitanya T K.
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks,
> > > > > > Regards,
> > > > > > Chaitanya T K.
> > > >
> > > >
> > > > On Tue, Sep 8, 2020 at 9:55 PM Krishna Chaitanya
> > > > <chaitanya.mgit at gmail.com> wrote:
> > > > >
> > > > > On Wed, Sep 9, 2020 at 12:27 AM Sugandh Huthanahally Mohan
> > > > > <sugandhgowda at gmail.com> wrote:
> > > > > >
> > > > > > I have captured connection between a WiFi6 AP and a WiFi6 STA i=
n wireshark.
> > > > > > I have attached a wireshark pcap file.
> > > > > > I could see HE capabilities exchange in Association request and=
 response.
> > > > > Yes, this looks fine to me except for VHT IEs in the probe and
> > > > > association response in 2.4GHz.
> > > > > Maybe this is what is confusing, can you please disable ieee80211=
ac=3D0
> > > > > in the hostapd.conf and try?
> > > > >
> > > > > > The iw phy output is below. I couldn't see HE connection in thi=
s output.
> > > > > >
> > > > > > $iw dev wlp3s0 link
> > > > > > Connected to 8c:c6:81:69:86:65 (on wlp3s0)
> > > > > >     SSID: WiFi_AX200
> > > > > >     freq: 2437
> > > > > >     RX: 27838 bytes (199 packets)
> > > > > >     TX: 13319 bytes (97 packets)
> > > > > >     signal: -34 dBm
> > > > > >     rx bitrate: 26.0 MBit/s MCS 3
> > > > > >     tx bitrate: 2.0 MBit/s
> > > > > >
> > > > > >     bss flags:    short-slot-time
> > > > > >     dtim period:    2
> > > > > >     beacon int:    100
> > > > > >
> > > > > The link doesn't show any specific details related to HE other th=
an
> > > > > the MCS which can vary, try running
> > > > > an iperf to see HE MCSes in a clean channel.
> > > > > >
> > > > > > On Wed, Sep 2, 2020 at 3:39 PM Krishna Chaitanya
> > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 2, 2020 at 6:38 PM Sugandh Huthanahally Mohan
> > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > > >
> > > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > > I am observing that the STA is connecting and disconnecti=
ng when
> > > > > > > > > I try to connect STA to AP.
> > > > > > > > I guess this is a new STA with wpa_supplicant, right? Is it=
 also AX200 based
> > > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (eithe=
r mac80211
> > > > > > > > or the driver),
> > > > > > > > so, but interestingly in your previous dmesg, I don't see a=
ny mac80211 logs.
> > > > > > > >
> > > > > > > > So, need dmesg logs that capture the connection (look for m=
ac80211 logs).
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally Moh=
an
> > > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Krishna,
> > > > > > > > > > >
> > > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > >
> > > > > > > > Yes this is a new STA connecting AP with wpa_supplicant.
> > > > > > > > It is also an AX200.
> > > > > > > > I don=E2=80=99t see mac80211 logs on the STA dmesg.
> > > > > > > > I am attaching dmesg of the station.
> > > > > > >
> > > > > > > These are from mac80211:
> > > > > > > [  152.255545] wlp3s0: authenticate with 8c:c6:81:69:86:65
> > > > > > > [  152.258347] wlp3s0: send auth to 8c:c6:81:69:86:65 (try 1/=
3)
> > > > > > > [  152.283971] wlp3s0: authenticated
> > > > > > > [  152.286624] wlp3s0: associate with 8c:c6:81:69:86:65 (try =
1/3)
> > > > > > > [  152.293456] wlp3s0: RX AssocResp from 8c:c6:81:69:86:65
> > > > > > > (capab=3D0x411 status=3D0 aid=3D1)
> > > > > > > [  152.299672] wlp3s0: associated
> > > > > > > [  152.364843] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link be=
comes ready
> > > > > > >
> > > > > > > I was hoping to see some prints disabling HE, but looks fine.=
 So,
> > > > > > > still, nothing from the logs
> > > > > > > to say why HE is disabled in the STA (why it isn't sending HE=
 IEs in
> > > > > > > assoc resp).
> > > > > > >
> > > > > > > Only Sniffer should tell us without resorting to Whitebox deb=
ug.
> > > > > > > >
> > > > > > > > On Wed, Sep 2, 2020 at 1:26 PM Krishna Chaitanya
> > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Well, not necessarily, but hostap side it looks fine,=
 so,
> > > > > > > > > > > we need to see why the STA isn't responding well, pro=
bably a
> > > > > > > > > > > different draft implementation. At the very least we =
should start
> > > > > > > > > > > with a sniffer capture of the association b/w the sta=
tions to check
> > > > > > > > > > > the IEs.
> > > > > > > > > >
> > > > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > > > I am observing that the STA is connecting and disconnec=
ting when
> > > > > > > > > > I try to connect STA to AP.
> > > > > > > > > I guess this is a new STA with wpa_supplicant, right? Is =
it also AX200 based
> > > > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (eit=
her mac80211
> > > > > > > > > or the driver),
> > > > > > > > > so, but interestingly in your previous dmesg, I don't see=
 any mac80211 logs.
> > > > > > > > >
> > > > > > > > > So, need dmesg logs that capture the connection (look for=
 mac80211 logs).
> > > > > > > > > >
> > > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally M=
ohan
> > > > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Krishna,
> > > > > > > > > > > >
> > > > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > > > >
> > > > > > > > > > > Well, not necessarily, but hostap side it looks fine,=
 so,
> > > > > > > > > > > we need to see why the STA isn't responding well, pro=
bably a
> > > > > > > > > > > different draft implementation. At the very least we =
should start
> > > > > > > > > > > with a sniffer capture of the association b/w the sta=
tions to check
> > > > > > > > > > > the IEs.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Thanks,
> > > > > > > > > Regards,
> > > > > > > > > Chaitanya T K.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Thanks,
> > > > > > > Regards,
> > > > > > > Chaitanya T K.
> > >
> > >
> > > On Wed, Sep 9, 2020 at 12:53 AM Krishna Chaitanya
> > > <chaitanya.mgit@gmail.com> wrote:
> > > >
> > > > On Wed, Sep 9, 2020 at 2:18 AM Sugandh Huthanahally Mohan
> > > > <sugandhgowda@gmail.com> wrote:
> > > > >
> > > > > On Wed, Sep 9, 2020 at 12:27 AM Sugandh Huthanahally Mohan
> > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > >
> > > > > > > I have captured connection between a WiFi6 AP and a WiFi6 STA=
 in wireshark.
> > > > > > >I have attached a wireshark pcap file.
> > > > > > > I could see HE capabilities exchange in Association request a=
nd response.
> > > > > > Yes, this looks fine to me except for VHT IEs in the probe and
> > > > > > association response in 2.4GHz.
> > > > > > Maybe this is what is confusing, can you please disable ieee802=
11ac=3D0
> > > > > > in the hostapd.conf and try?
> > > > > I disabled iee80211ac and I am not seeing VHT capabilities in Ass=
ociation
> > > > > frames but the data rate remains the same.I am attaching wireshar=
k capture.
> > > > okay, thanks.
> > > > > > The iw phy output is below. I couldn't see HE connection in thi=
s output.
> > > > > >
> > > > > > $iw dev wlp3s0 link
> > > > > > Connected to 8c:c6:81:69:86:65 (on wlp3s0)
> > > > > >     SSID: WiFi_AX200
> > > > > >     freq: 2437
> > > > > >     RX: 27838 bytes (199 packets)
> > > > > >     TX: 13319 bytes (97 packets)
> > > > > >     signal: -34 dBm
> > > > > >     rx bitrate: 26.0 MBit/s MCS 3
> > > > > >     tx bitrate: 2.0 MBit/s
> > > > > >
> > > > > >     bss flags:    short-slot-time
> > > > > >     dtim period:    2
> > > > > >     beacon int:    100
> > > > > >
> > > > > > > The link doesn't show any specific details related to HE othe=
r than
> > > > > > > the MCS which can vary, try running
> > > > > > > an iperf to see HE MCSes in a clean channel.
> > > > >
> > > > > Could you please explain what this means.
> > > > > I want to know what clean channel means and where actually I can =
see HE MCSes.
> > > >
> > > > Sure. The link command doesn't printout any in capability informati=
on explicitly
> > > >  except for the MCS details. And figuring out the mode of connectio=
n (11n/11ax)
> > > > from the MCS is tricky as the MCS varies across depending on the ra=
te
> > > > control algorithm
> > > > (for iwlwifi: hardware). So, I was suggesting to use iperf (the mor=
e
> > > > data you pass, more
> > > > chance of the rate control algo to go to higher MCSes) and also by
> > > > "clean channels" I was
> > > > referring to quieter channels where there are no other BSSes or no
> > > > other traffic.
> > > >
> > > > But, before we go into debugging data path, I still don't understan=
d
> > > > why wpa_supplicant
> > > > isn't saying it is a HE association?
> > > >
> > > > Ah, After staring at the code and using blame, a crucial fix missed
> > > > out hostap-2.9 windows,
> > > > the fix was to properly validate the HE capabilities, I was looking=
 at
> > > > the latest cod and
> > > > everything looked fine, hence took time.
> > > >
> > > > hostap_2_9-> 7th August
> > > > 0497e4148197fb8fdf92b5c901ce06df1bfa548c ->13th August
> > > >
> > > > Please use the latest HEAD of hostap.git, you need to compile it
> > > > manually and try the
> > > > test and let me know how it goes. (make sure all proper configs are=
 enabled)
> > > >
> > > > > > On Wed, Sep 2, 2020 at 3:39 PM Krishna Chaitanya
> > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Sep 2, 2020 at 6:38 PM Sugandh Huthanahally Mohan
> > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > > >
> > > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > > I am observing that the STA is connecting and disconnecti=
ng when
> > > > > > > > > I try to connect STA to AP.
> > > > > > > > I guess this is a new STA with wpa_supplicant, right? Is it=
 also AX200 based
> > > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (eithe=
r mac80211
> > > > > > > > or the driver),
> > > > > > > > so, but interestingly in your previous dmesg, I don't see a=
ny mac80211 logs.
> > > > > > > >
> > > > > > > > So, need dmesg logs that capture the connection (look for m=
ac80211 logs).
> > > > > > > > >
> > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally Moh=
an
> > > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Krishna,
> > > > > > > > > > >
> > > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > > >
> > > > > > > > > > Well, not necessarily, but hostap side it looks fine, s=
o,
> > > > > > > > > > we need to see why the STA isn't responding well, proba=
bly a
> > > > > > > > > > different draft implementation. At the very least we sh=
ould start
> > > > > > > > > > with a sniffer capture of the association b/w the stati=
ons to check
> > > > > > > > > > the IEs.
> > > > > > > >
> > > > > > > > Yes this is a new STA connecting AP with wpa_supplicant.
> > > > > > > > It is also an AX200.
> > > > > > > > I don=E2=80=99t see mac80211 logs on the STA dmesg.
> > > > > > > > I am attaching dmesg of the station.
> > > > > > >
> > > > > > > These are from mac80211:
> > > > > > > [  152.255545] wlp3s0: authenticate with 8c:c6:81:69:86:65
> > > > > > > [  152.258347] wlp3s0: send auth to 8c:c6:81:69:86:65 (try 1/=
3)
> > > > > > > [  152.283971] wlp3s0: authenticated
> > > > > > > [  152.286624] wlp3s0: associate with 8c:c6:81:69:86:65 (try =
1/3)
> > > > > > > [  152.293456] wlp3s0: RX AssocResp from 8c:c6:81:69:86:65
> > > > > > > (capab=3D0x411 status=3D0 aid=3D1)
> > > > > > > [  152.299672] wlp3s0: associated
> > > > > > > [  152.364843] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link be=
comes ready
> > > > > > >
> > > > > > > I was hoping to see some prints disabling HE, but looks fine.=
 So,
> > > > > > > still, nothing from the logs
> > > > > > > to say why HE is disabled in the STA (why it isn't sending HE=
 IEs in
> > > > > > > assoc resp).
> > > > > > >
> > > > > > > Only Sniffer should tell us without resorting to Whitebox deb=
ug.
> > > > > > > >
> > > > > > > > On Wed, Sep 2, 2020 at 1:26 PM Krishna Chaitanya
> > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Well, not necessarily, but hostap side it looks fine,=
 so,
> > > > > > > > > > > we need to see why the STA isn't responding well, pro=
bably a
> > > > > > > > > > > different draft implementation. At the very least we =
should start
> > > > > > > > > > > with a sniffer capture of the association b/w the sta=
tions to check
> > > > > > > > > > > the IEs.
> > > > > > > > > >
> > > > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > > > I am observing that the STA is connecting and disconnec=
ting when
> > > > > > > > > > I try to connect STA to AP.
> > > > > > > > > I guess this is a new STA with wpa_supplicant, right? Is =
it also AX200 based
> > > > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (eit=
her mac80211
> > > > > > > > > or the driver),
> > > > > > > > > so, but interestingly in your previous dmesg, I don't see=
 any mac80211 logs.
> > > > > > > > >
> > > > > > > > > So, need dmesg logs that capture the connection (look for=
 mac80211 logs).
> > > > > > > > > >
> > > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally M=
ohan
> > > > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Krishna,
> > > > > > > > > > > >
> > > > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > > > >
> > > > > > > > > > > Well, not necessarily, but hostap side it looks fine,=
 so,
> > > > > > > > > > > we need to see why the STA isn't responding well, pro=
bably a
> > > > > > > > > > > different draft implementation. At the very least we =
should start
> > > > > > > > > > > with a sniffer capture of the association b/w the sta=
tions to check
> > > > > > > > > > > the IEs.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Thanks,
> > > > > > > > > Regards,
> > > > > > > > > Chaitanya T K.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Thanks,
> > > > > > > Regards,
> > > > > > > Chaitanya T K.
> > > > >
> > > > >
> > > > > On Tue, Sep 8, 2020 at 9:55 PM Krishna Chaitanya
> > > > > <chaitanya.mgit@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 9, 2020 at 12:27 AM Sugandh Huthanahally Mohan
> > > > > > <sugandhgowda@gmail.com> wrote:
> > > > > > >
> > > > > > > I have captured connection between a WiFi6 AP and a WiFi6 STA=
 in wireshark.
> > > > > > > I have attached a wireshark pcap file.
> > > > > > > I could see HE capabilities exchange in Association request a=
nd response.
> > > > > > Yes, this looks fine to me except for VHT IEs in the probe and
> > > > > > association response in 2.4GHz.
> > > > > > Maybe this is what is confusing, can you please disable ieee802=
11ac=3D0
> > > > > > in the hostapd.conf and try?
> > > > > >
> > > > > > > The iw phy output is below. I couldn't see HE connection in t=
his output.
> > > > > > >
> > > > > > > $iw dev wlp3s0 link
> > > > > > > Connected to 8c:c6:81:69:86:65 (on wlp3s0)
> > > > > > >     SSID: WiFi_AX200
> > > > > > >     freq: 2437
> > > > > > >     RX: 27838 bytes (199 packets)
> > > > > > >     TX: 13319 bytes (97 packets)
> > > > > > >     signal: -34 dBm
> > > > > > >     rx bitrate: 26.0 MBit/s MCS 3
> > > > > > >     tx bitrate: 2.0 MBit/s
> > > > > > >
> > > > > > >     bss flags:    short-slot-time
> > > > > > >     dtim period:    2
> > > > > > >     beacon int:    100
> > > > > > >
> > > > > > The link doesn't show any specific details related to HE other =
than
> > > > > > the MCS which can vary, try running
> > > > > > an iperf to see HE MCSes in a clean channel.
> > > > > > >
> > > > > > > On Wed, Sep 2, 2020 at 3:39 PM Krishna Chaitanya
> > > > > > > <chaitanya.mgit@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Sep 2, 2020 at 6:38 PM Sugandh Huthanahally Mohan
> > > > > > > > <sugandhgowda@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Mohan
> > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Well, not necessarily, but hostap side it looks fine,=
 so,
> > > > > > > > > > > we need to see why the STA isn't responding well, pro=
bably a
> > > > > > > > > > > different draft implementation. At the very least we =
should start
> > > > > > > > > > > with a sniffer capture of the association b/w the sta=
tions to check
> > > > > > > > > > > the IEs.
> > > > > > > > > >
> > > > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > > > I am observing that the STA is connecting and disconnec=
ting when
> > > > > > > > > > I try to connect STA to AP.
> > > > > > > > > I guess this is a new STA with wpa_supplicant, right? Is =
it also AX200 based
> > > > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (eit=
her mac80211
> > > > > > > > > or the driver),
> > > > > > > > > so, but interestingly in your previous dmesg, I don't see=
 any mac80211 logs.
> > > > > > > > >
> > > > > > > > > So, need dmesg logs that capture the connection (look for=
 mac80211 logs).
> > > > > > > > > >
> > > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally M=
ohan
> > > > > > > > > > > <sugandhgowda at gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Krishna,
> > > > > > > > > > > >
> > > > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > > > >
> > > > > > > > > > > Well, not necessarily, but hostap side it looks fine,=
 so,
> > > > > > > > > > > we need to see why the STA isn't responding well, pro=
bably a
> > > > > > > > > > > different draft implementation. At the very least we =
should start
> > > > > > > > > > > with a sniffer capture of the association b/w the sta=
tions to check
> > > > > > > > > > > the IEs.
> > > > > > > > >
> > > > > > > > > Yes this is a new STA connecting AP with wpa_supplicant.
> > > > > > > > > It is also an AX200.
> > > > > > > > > I don=E2=80=99t see mac80211 logs on the STA dmesg.
> > > > > > > > > I am attaching dmesg of the station.
> > > > > > > >
> > > > > > > > These are from mac80211:
> > > > > > > > [  152.255545] wlp3s0: authenticate with 8c:c6:81:69:86:65
> > > > > > > > [  152.258347] wlp3s0: send auth to 8c:c6:81:69:86:65 (try =
1/3)
> > > > > > > > [  152.283971] wlp3s0: authenticated
> > > > > > > > [  152.286624] wlp3s0: associate with 8c:c6:81:69:86:65 (tr=
y 1/3)
> > > > > > > > [  152.293456] wlp3s0: RX AssocResp from 8c:c6:81:69:86:65
> > > > > > > > (capab=3D0x411 status=3D0 aid=3D1)
> > > > > > > > [  152.299672] wlp3s0: associated
> > > > > > > > [  152.364843] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link =
becomes ready
> > > > > > > >
> > > > > > > > I was hoping to see some prints disabling HE, but looks fin=
e. So,
> > > > > > > > still, nothing from the logs
> > > > > > > > to say why HE is disabled in the STA (why it isn't sending =
HE IEs in
> > > > > > > > assoc resp).
> > > > > > > >
> > > > > > > > Only Sniffer should tell us without resorting to Whitebox d=
ebug.
> > > > > > > > >
> > > > > > > > > On Wed, Sep 2, 2020 at 1:26 PM Krishna Chaitanya
> > > > > > > > > <chaitanya.mgit@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Sep 2, 2020 at 3:16 PM Sugandh Huthanahally Moh=
an
> > > > > > > > > > <sugandhgowda@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > > > <chaitanya.mgit at gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Well, not necessarily, but hostap side it looks fin=
e, so,
> > > > > > > > > > > > we need to see why the STA isn't responding well, p=
robably a
> > > > > > > > > > > > different draft implementation. At the very least w=
e should start
> > > > > > > > > > > > with a sniffer capture of the association b/w the s=
tations to check
> > > > > > > > > > > > the IEs.
> > > > > > > > > > >
> > > > > > > > > > > I am using wpa_supplicant in STA to connect  to AP.
> > > > > > > > > > > I am attaching hostapd logs and wpa_supplicant logs.
> > > > > > > > > > > I am observing that the STA is connecting and disconn=
ecting when
> > > > > > > > > > > I try to connect STA to AP.
> > > > > > > > > > I guess this is a new STA with wpa_supplicant, right? I=
s it also AX200 based
> > > > > > > > > > chipset? In the STA mode, the kernel adds the HE IEs (e=
ither mac80211
> > > > > > > > > > or the driver),
> > > > > > > > > > so, but interestingly in your previous dmesg, I don't s=
ee any mac80211 logs.
> > > > > > > > > >
> > > > > > > > > > So, need dmesg logs that capture the connection (look f=
or mac80211 logs).
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Sep 1, 2020 at 10:09 PM Krishna Chaitanya
> > > > > > > > > > > <chaitanya.mgit@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Sep 2, 2020 at 1:23 AM Sugandh Huthanahally=
 Mohan
> > > > > > > > > > > > <sugandhgowda@gmail.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Krishna,
> > > > > > > > > > > > >
> > > > > > > > > > > > > Currently I am not running wpa_supplicant.
> > > > > > > > > > > > > Is it necessary for hostapd?
> > > > > > > > > > > >
> > > > > > > > > > > > Well, not necessarily, but hostap side it looks fin=
e, so,
> > > > > > > > > > > > we need to see why the STA isn't responding well, p=
robably a
> > > > > > > > > > > > different draft implementation. At the very least w=
e should start
> > > > > > > > > > > > with a sniffer capture of the association b/w the s=
tations to check
> > > > > > > > > > > > the IEs.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Thanks,
> > > > > > > > > > Regards,
> > > > > > > > > > Chaitanya T K.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Thanks,
> > > > > > > > Regards,
> > > > > > > > Chaitanya T K.
