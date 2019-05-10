Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5EFD1A383
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 21:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfEJTvZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 15:51:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40349 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfEJTvY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 15:51:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so9110677wre.7
        for <linux-wireless@vger.kernel.org>; Fri, 10 May 2019 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=zRo1Vv56bYSY0jXjoSgPnE3JBNs/RHIITg6JDVG8UXc=;
        b=eZqZA+0HDCbil6hEkIhpHLlXv9oxVC/xH2L3WSEiljFwv3B698E8fD2lwfc7yDI44j
         kMC9NNhuJ9vNGDNjxe/ThzustnZt2chY3UKP/I4oYUKdnqZq7WTds4vDuN8BS3NIdTIJ
         WNIZPUc3zVDFIKIJ9yoau8nZtHL/sfVDEaRaMEyTEZ19P86AJyi/RWliFavdXGw2iH6O
         LCm+I01y+FiKfEkR4kMr7QMGQpNgcSZ3zK6JdWm04mTj+SSZ/8RxWFET4c0xFatTUu7D
         Kkf3tBVwLdAEvzjbs57duYqKrVu0QjlgxnkGEUXaw5OcTgXOXvjyQAV3kM9qy8blFRvs
         iVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=zRo1Vv56bYSY0jXjoSgPnE3JBNs/RHIITg6JDVG8UXc=;
        b=Iy71DfTeWvTZ36azdXxB8BbJqSMohCGbLjRq49N+5A8DRFGOfuA/UdG82B8fR3X0u9
         yZWSfF0KMZDJSMPllNAB2eLi0xVA7IAWc/zO6gWfWdQY3wqWgwH3ayHLJEEEO+GemeMa
         DpYltRwPStp5m5bknD7gZpgxDqqsIkMOIp2BIqlbw3ZvDBHOFXFMXweq+NMnHgf1gE08
         R305kJvM75I1FRFnqajQ+RPFnOBrvOHJiMmkqwgH8XJifJfYFxwfjIFAwgWOCqz8RatV
         XhYhcpqhjExWhIDqZFbKVx/t+I4vOH9eVeDy7TWG2GRiyzTwhnJ7HdQQaJLwpqQytdt+
         74Hg==
X-Gm-Message-State: APjAAAXcHO2lZ6shODfbUNZKB/18zvKBZZGurWKCgnp8aH9Ayai5O4YS
        o84+oLd6R6fIHORlsetwePBvejl/ITs34F5jyxfnrA9D
X-Google-Smtp-Source: APXvYqyEnmFiCW9JkIwrWVcMIWuX0bihHAuDJ+WmbrdED3Gr+5yt7pWK6JsxlhOOjUN7r/As69UVNgAk3Q5SBJuOWDQ=
X-Received: by 2002:a5d:518d:: with SMTP id k13mr7792301wrv.285.1557517881932;
 Fri, 10 May 2019 12:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <CA+icZUX1N9zK_SGN-OyDVbZ1Jq9EjRxpOfQ0Oe0iSDwuEaJRfg@mail.gmail.com> <20190510164030.GG9224@smile.fi.intel.com>
In-Reply-To: <20190510164030.GG9224@smile.fi.intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 10 May 2019 21:51:05 +0200
Message-ID: <CA+icZUVxHXz+tOUvOOEd=Fm+96=+mKzbpqjzb0XiR4-yVAspiQ@mail.gmail.com>
Subject: Re: ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Samuel Ortiz <sameo@linux.intel.com>, linux-nfc@lists.01.org,
        linux-wireless@vger.kernel.org,
        Cristian Sovaiala <cristian.sovaiala@nxp.com>,
        jgeslin <jeremy.geslin@nxp.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 10, 2019 at 6:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> (+Cc: Oleg)
>
> On Fri, May 10, 2019 at 09:43:29AM +0200, Sedat Dilek wrote:
> > On Thu, May 9, 2019 at 3:46 PM Sedat Dilek <sedat.dilek@gmail.com> wrot=
e:
> > >
> > > Hi,
> > >
> > > I am here on Debian/buster AMD64 and Linux v5.1 final.
> > >
> > > I have successfully installed and tested the NXP NFC driver from
> > > Lenovo under Windows 10 as a first step (see [1] and [2]).
> > >
> > > As a testcase I used my YubiKey which was recognized via NFC and I
> > > could automatically register at the YubiKey demo website.
> > >
> > > Under Linux v5.1 I have activated all sort of CONFIG_NFC_XXX as
> > > modules if available (see below and attached files).
> > >
> > > I am not sure if I need to load the PN544 (I2C) driver?
> > >
> > > I can see in /sys ...
> > >
> > > # cd /sys/bus/i2c/devices/i2c-NXP1001:00
>
> > > The NXP NFC Windows driver lists (I have both firmware files copied t=
o Linux)...
> > > [Firmware.CopyFiles]
> > > NXPPN548FW.DAT
> > > NXPPN547FW.DAT
>
> First of all it seems the driver lacks of ID. And the ID seems odd.
> Looking for this ID in tables I see mention of NXP NPC100. The driver is
> drivers/nfc/nxp-nci for it.
>

Hi Andy,

what do you mean by "the driver lacks ID"?
Do you mean VendorID and ProductID?
How to get these informations?
Do I need to modify the linux kernel sources?

Thanks.

Regards,
- Sedat -

> > > Last question: Do I need these firmware files installed?
> > > Rename them?
> > > Which directory - /lib/firmware?
> > >
> > > I ran out of ideas...
> > >
> > > Do you need more informations?
> > >
> > > I have attached my linux-config and the dmesg output.
> > >
> > > Thanks in advance.
> > >
> > > Kind regards,
> > > - Sedat -
> > >
> > > [1] https://pcsupport.lenovo.com/us/de/products/laptops-and-netbooks/=
thinkpad-t-series-laptops/thinkpad-t470/downloads
> > > [2] https://download.lenovo.com/pccbbs/mobiles/n1qnb04w.txt
> > > [3] https://github.com/NXPNFCLinux/linux_libnfc-nci
> > > [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/Documentation/nfc/nfc-hci.txt
> > > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/Documentation/nfc/nfc-pn544.txt
> > >
> > > P.S.: Some interesting outputs and files
> > >
> > > [ LINUX-CONFIG ]
> > >
> > > $ grep NFC /boot/config-5.1.0-1-amd64-cbl-asmgoto | sort
> > > CONFIG_IP_VS_NFCT=3Dy
> > > CONFIG_MLX5_EN_RXNFC=3Dy
> > > CONFIG_NFC_DIGITAL=3Dm
> > > CONFIG_NFC_FDP_I2C=3Dm
> > > CONFIG_NFC_FDP=3Dm
> > > CONFIG_NFC_HCI=3Dm
> > > CONFIG_NFC=3Dm
> > > CONFIG_NFC_MEI_PHY=3Dm
> > > CONFIG_NFC_MICROREAD_I2C=3Dm
> > > CONFIG_NFC_MICROREAD=3Dm
> > > CONFIG_NFC_MICROREAD_MEI=3Dm
> > > CONFIG_NFC_MRVL_I2C=3Dm
> > > CONFIG_NFC_MRVL=3Dm
> > > CONFIG_NFC_MRVL_SPI=3Dm
> > > CONFIG_NFC_MRVL_UART=3Dm
> > > CONFIG_NFC_MRVL_USB=3Dm
> > > CONFIG_NFC_NCI=3Dm
> > > CONFIG_NFC_NCI_SPI=3Dm
> > > CONFIG_NFC_NCI_UART=3Dm
> > > CONFIG_NFC_NXP_NCI_I2C=3Dm
> > > CONFIG_NFC_NXP_NCI=3Dm
> > > CONFIG_NFC_PN533_I2C=3Dm
> > > CONFIG_NFC_PN533=3Dm
> > > CONFIG_NFC_PN533_USB=3Dm
> > > CONFIG_NFC_PN544_I2C=3Dm
> > > CONFIG_NFC_PN544=3Dm
> > > CONFIG_NFC_PN544_MEI=3Dm
> > > CONFIG_NFC_PORT100=3Dm
> > > CONFIG_NFC_S3FWRN5_I2C=3Dm
> > > CONFIG_NFC_S3FWRN5=3Dm
> > > CONFIG_NFC_SHDLC=3Dy
> > > CONFIG_NFC_SIM=3Dm
> > > CONFIG_NFC_ST21NFCA_I2C=3Dm
> > > CONFIG_NFC_ST21NFCA=3Dm
> > > CONFIG_NFC_ST95HF=3Dm
> > > CONFIG_NFC_ST_NCI_I2C=3Dm
> > > CONFIG_NFC_ST_NCI=3Dm
> > > CONFIG_NFC_ST_NCI_SPI=3Dm
> > > CONFIG_NFC_TRF7970A=3Dm
> > > # Near Field Communication (NFC) devices
> > >
> > > [ WINDOWS 10 INF DRIVER ]
> > >
> > > $ cat NxpNfcClientDriver.inf
> > > =EF=BF=BD=EF=BF=BD;
> > > ; NxpNfcClientDriver.inf
> > > ;
> > >
> > > [Version]
> > > Signature=3D"$Windows NT$"
> > > Class=3DProximity
> > > ClassGuid=3D{5630831C-06C9-4856-B327-F5D32586E060}
> > > Provider=3D%ManufacturerName%
> > > CatalogFile=3DNxpNfcClientDriver.cat
> > > DriverVer=3D03/30/2018,12.0.3.0
> > >
> > > [Manufacturer]
> > > %ManufacturerName%=3DStandard,NTamd64
> > >
> > > [Standard.NTamd64]
> > > %DeviceName%=3DMyDevice_Install,ACPI\NXP1000
> > > %DeviceName%=3DMyDevice_Install,ACPI\NXP1001
> > > %DeviceName%=3DMyDevice_Install,ACPI\NXP1002
> > > %DeviceName%=3DMyDevice_Install,ACPI\NXP1003
> > > %DeviceName%=3DMyDevice_Install,ACPI\NXP7471
> > > %DeviceName%=3DMyDevice_Install,ACPI\NXP8013
> > > %DeviceName%=3DMyDevice_Install,ACPI\NXP3001
> > >
> > > [SourceDisksNames]
> > > 1=3D%DiskName%
> > >
> > > [SourceDisksFiles]
> > > NxpNfcClientDriver.dll=3D1
> > > NXPPN548FW.DAT=3D1
> > > NXPPN547FW.DAT=3D1
> > >
> > > ; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D UMDF Devi=
ce =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > [MyDevice_Install.NT]
> > > CopyFiles=3DUMDriverCopy,Firmware.CopyFiles
> > > AddReg=3DNxpNfpProviderProximityCustomValuesRegister
> > >
> > > [MyDevice_Install.NT.hw]
> > > AddReg=3DNxpNfcClientDriver_AddReg
> > >
> > > [MyDevice_Install.NT.Services]
> > > AddService=3DWUDFRd,0x000001fa,WUDFRD_ServiceInstall
> > >
> > > [MyDevice_Install.NT.CoInstallers]
> > > AddReg=3DCoInstallers_AddReg
> > >
> > > [MyDevice_Install.NT.Wdf]
> > > UmdfService=3DNxpNfcClientDriver,NxpNfcClientDriver_Install
> > > UmdfServiceOrder=3DNxpNfcClientDriver
> > > UmdfDirectHardwareAccess=3DAllowDirectHardwareAccess
> > > UmdfFileObjectPolicy=3DAllowNullAndUnknownFileObjects
> > > UmdfImpersonationLevel=3DImpersonation
> > >
> > > [NxpNfcClientDriver_Install]
> > > UmdfLibraryVersion=3D2.0.0
> > > ServiceBinary=3D%12%\UMDF\NxpNfcClientDriver.dll
> > > UmdfExtensions=3DNfcCx0102
> > >
> > > [NxpNfcClientDriver_AddReg]
> > > HKR,FirmwareMap,"8",0x00020000,"%%SystemRoot%%\System32\NXPPN547FW.da=
t"
> > > ; HW version of PN547 is 8
> > > HKR,FirmwareMap,"10",0x00020000,"%%SystemRoot%%\System32\NXPPN548FW.d=
at"
> > > ; HW version of PN548 is 10
> > > HKR,NxpNfcClientDriver, "RfConfigData",            0x00000001, 00
> > > HKR,NxpNfcClientDriver, "EEPROMConfigBlob",        0x00000001, 00
> > > HKR,NxpNfcClientDriver, "RfSessionMgmt",           0x00010001, 1
> > > HKR,NxpNfcClientDriver, "KeepRfData",              0x00010001, 1
> > >
> > > ; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D custom registry sections=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > [NxpNfpProviderProximityCustomValuesRegister]
> > > HKLM,"SYSTEM\CurrentControlSet\Proximity\","Dummy",0x00000010,0
> > >
> > >
> > > [NxpNfpProviderProximityCustomValuesRegister.Security]
> > > "D:P(A;OICI;GA;;;LS)(A;;GA;;;BA)(A;;GA;;;SY)"
> > >
> > > [WUDFRD_ServiceInstall]
> > > DisplayName=3D%WudfRdDisplayName%
> > > ServiceType=3D1
> > > StartType=3D3
> > > ErrorControl=3D1
> > > ServiceBinary=3D%12%\WUDFRd.sys
> > >
> > > [CoInstallers_AddReg]
> > > HKR,,CoInstallers32,0x00010000,"WUDFCoinstaller.dll"
> > >
> > >
> > > [DestinationDirs]
> > > UMDriverCopy=3D12,UMDF ; copy to Drivers\UMDF
> > > Firmware.CopyFiles=3D11
> > >
> > > [UMDriverCopy]
> > > NxpNfcClientDriver.dll,,,0x100
> > >
> > > [Firmware.CopyFiles]
> > > NXPPN548FW.DAT
> > > NXPPN547FW.DAT
> > >
> > > [ControlFlags]
> > > ExcludeFromSelect=3D*
> > >
> > > ; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Generic =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > [Strings]
> > > ManufacturerName=3D"NXP Semiconductors"
> > > DiskName=3D"NxpNfcClientDriver Installation Disk"
> > > WudfRdDisplayName=3D"NxpNfcClientDriver"
> > > DeviceName=3D"NxpNfcClientDriver"
> > >
> > > - EOT -
> >
> > [ CC Cristian and Jeremy of NXP ]
> >
> > What Linux-kernel configs do I need that PN544 I2C NFC driver works?
> >
> > Additionally, I have set CONFIG_I2C_GPIO=3Dm.
> >
> > What else is important to be activated?
> >
> > Thanks.
> >
> > - Sedat -
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
