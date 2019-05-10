Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCDA21A1B1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 18:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfEJQks (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 12:40:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:2811 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfEJQks (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 12:40:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 09:40:33 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 10 May 2019 09:40:31 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hP8ZS-0005uv-7S; Fri, 10 May 2019 19:40:30 +0300
Date:   Fri, 10 May 2019 19:40:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Samuel Ortiz <sameo@linux.intel.com>, linux-nfc@lists.01.org,
        linux-wireless@vger.kernel.org,
        Cristian Sovaiala <cristian.sovaiala@nxp.com>,
        jgeslin <jeremy.geslin@nxp.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: ThinkPad T470 and NXP PN5xx (PN547 or PN548)
Message-ID: <20190510164030.GG9224@smile.fi.intel.com>
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <CA+icZUX1N9zK_SGN-OyDVbZ1Jq9EjRxpOfQ0Oe0iSDwuEaJRfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUX1N9zK_SGN-OyDVbZ1Jq9EjRxpOfQ0Oe0iSDwuEaJRfg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(+Cc: Oleg)

On Fri, May 10, 2019 at 09:43:29AM +0200, Sedat Dilek wrote:
> On Thu, May 9, 2019 at 3:46 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Hi,
> >
> > I am here on Debian/buster AMD64 and Linux v5.1 final.
> >
> > I have successfully installed and tested the NXP NFC driver from
> > Lenovo under Windows 10 as a first step (see [1] and [2]).
> >
> > As a testcase I used my YubiKey which was recognized via NFC and I
> > could automatically register at the YubiKey demo website.
> >
> > Under Linux v5.1 I have activated all sort of CONFIG_NFC_XXX as
> > modules if available (see below and attached files).
> >
> > I am not sure if I need to load the PN544 (I2C) driver?
> >
> > I can see in /sys ...
> >
> > # cd /sys/bus/i2c/devices/i2c-NXP1001:00

> > The NXP NFC Windows driver lists (I have both firmware files copied to Linux)...
> > [Firmware.CopyFiles]
> > NXPPN548FW.DAT
> > NXPPN547FW.DAT

First of all it seems the driver lacks of ID. And the ID seems odd.
Looking for this ID in tables I see mention of NXP NPC100. The driver is
drivers/nfc/nxp-nci for it.

> > Last question: Do I need these firmware files installed?
> > Rename them?
> > Which directory - /lib/firmware?
> >
> > I ran out of ideas...
> >
> > Do you need more informations?
> >
> > I have attached my linux-config and the dmesg output.
> >
> > Thanks in advance.
> >
> > Kind regards,
> > - Sedat -
> >
> > [1] https://pcsupport.lenovo.com/us/de/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t470/downloads
> > [2] https://download.lenovo.com/pccbbs/mobiles/n1qnb04w.txt
> > [3] https://github.com/NXPNFCLinux/linux_libnfc-nci
> > [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/nfc/nfc-hci.txt
> > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/nfc/nfc-pn544.txt
> >
> > P.S.: Some interesting outputs and files
> >
> > [ LINUX-CONFIG ]
> >
> > $ grep NFC /boot/config-5.1.0-1-amd64-cbl-asmgoto | sort
> > CONFIG_IP_VS_NFCT=y
> > CONFIG_MLX5_EN_RXNFC=y
> > CONFIG_NFC_DIGITAL=m
> > CONFIG_NFC_FDP_I2C=m
> > CONFIG_NFC_FDP=m
> > CONFIG_NFC_HCI=m
> > CONFIG_NFC=m
> > CONFIG_NFC_MEI_PHY=m
> > CONFIG_NFC_MICROREAD_I2C=m
> > CONFIG_NFC_MICROREAD=m
> > CONFIG_NFC_MICROREAD_MEI=m
> > CONFIG_NFC_MRVL_I2C=m
> > CONFIG_NFC_MRVL=m
> > CONFIG_NFC_MRVL_SPI=m
> > CONFIG_NFC_MRVL_UART=m
> > CONFIG_NFC_MRVL_USB=m
> > CONFIG_NFC_NCI=m
> > CONFIG_NFC_NCI_SPI=m
> > CONFIG_NFC_NCI_UART=m
> > CONFIG_NFC_NXP_NCI_I2C=m
> > CONFIG_NFC_NXP_NCI=m
> > CONFIG_NFC_PN533_I2C=m
> > CONFIG_NFC_PN533=m
> > CONFIG_NFC_PN533_USB=m
> > CONFIG_NFC_PN544_I2C=m
> > CONFIG_NFC_PN544=m
> > CONFIG_NFC_PN544_MEI=m
> > CONFIG_NFC_PORT100=m
> > CONFIG_NFC_S3FWRN5_I2C=m
> > CONFIG_NFC_S3FWRN5=m
> > CONFIG_NFC_SHDLC=y
> > CONFIG_NFC_SIM=m
> > CONFIG_NFC_ST21NFCA_I2C=m
> > CONFIG_NFC_ST21NFCA=m
> > CONFIG_NFC_ST95HF=m
> > CONFIG_NFC_ST_NCI_I2C=m
> > CONFIG_NFC_ST_NCI=m
> > CONFIG_NFC_ST_NCI_SPI=m
> > CONFIG_NFC_TRF7970A=m
> > # Near Field Communication (NFC) devices
> >
> > [ WINDOWS 10 INF DRIVER ]
> >
> > $ cat NxpNfcClientDriver.inf
> > ��;
> > ; NxpNfcClientDriver.inf
> > ;
> >
> > [Version]
> > Signature="$Windows NT$"
> > Class=Proximity
> > ClassGuid={5630831C-06C9-4856-B327-F5D32586E060}
> > Provider=%ManufacturerName%
> > CatalogFile=NxpNfcClientDriver.cat
> > DriverVer=03/30/2018,12.0.3.0
> >
> > [Manufacturer]
> > %ManufacturerName%=Standard,NTamd64
> >
> > [Standard.NTamd64]
> > %DeviceName%=MyDevice_Install,ACPI\NXP1000
> > %DeviceName%=MyDevice_Install,ACPI\NXP1001
> > %DeviceName%=MyDevice_Install,ACPI\NXP1002
> > %DeviceName%=MyDevice_Install,ACPI\NXP1003
> > %DeviceName%=MyDevice_Install,ACPI\NXP7471
> > %DeviceName%=MyDevice_Install,ACPI\NXP8013
> > %DeviceName%=MyDevice_Install,ACPI\NXP3001
> >
> > [SourceDisksNames]
> > 1=%DiskName%
> >
> > [SourceDisksFiles]
> > NxpNfcClientDriver.dll=1
> > NXPPN548FW.DAT=1
> > NXPPN547FW.DAT=1
> >
> > ; =================== UMDF Device ==================================
> >
> > [MyDevice_Install.NT]
> > CopyFiles=UMDriverCopy,Firmware.CopyFiles
> > AddReg=NxpNfpProviderProximityCustomValuesRegister
> >
> > [MyDevice_Install.NT.hw]
> > AddReg=NxpNfcClientDriver_AddReg
> >
> > [MyDevice_Install.NT.Services]
> > AddService=WUDFRd,0x000001fa,WUDFRD_ServiceInstall
> >
> > [MyDevice_Install.NT.CoInstallers]
> > AddReg=CoInstallers_AddReg
> >
> > [MyDevice_Install.NT.Wdf]
> > UmdfService=NxpNfcClientDriver,NxpNfcClientDriver_Install
> > UmdfServiceOrder=NxpNfcClientDriver
> > UmdfDirectHardwareAccess=AllowDirectHardwareAccess
> > UmdfFileObjectPolicy=AllowNullAndUnknownFileObjects
> > UmdfImpersonationLevel=Impersonation
> >
> > [NxpNfcClientDriver_Install]
> > UmdfLibraryVersion=2.0.0
> > ServiceBinary=%12%\UMDF\NxpNfcClientDriver.dll
> > UmdfExtensions=NfcCx0102
> >
> > [NxpNfcClientDriver_AddReg]
> > HKR,FirmwareMap,"8",0x00020000,"%%SystemRoot%%\System32\NXPPN547FW.dat"
> > ; HW version of PN547 is 8
> > HKR,FirmwareMap,"10",0x00020000,"%%SystemRoot%%\System32\NXPPN548FW.dat"
> > ; HW version of PN548 is 10
> > HKR,NxpNfcClientDriver, "RfConfigData",            0x00000001, 00
> > HKR,NxpNfcClientDriver, "EEPROMConfigBlob",        0x00000001, 00
> > HKR,NxpNfcClientDriver, "RfSessionMgmt",           0x00010001, 1
> > HKR,NxpNfcClientDriver, "KeepRfData",              0x00010001, 1
> >
> > ; ============== custom registry sections ==================
> >
> > [NxpNfpProviderProximityCustomValuesRegister]
> > HKLM,"SYSTEM\CurrentControlSet\Proximity\","Dummy",0x00000010,0
> >
> >
> > [NxpNfpProviderProximityCustomValuesRegister.Security]
> > "D:P(A;OICI;GA;;;LS)(A;;GA;;;BA)(A;;GA;;;SY)"
> >
> > [WUDFRD_ServiceInstall]
> > DisplayName=%WudfRdDisplayName%
> > ServiceType=1
> > StartType=3
> > ErrorControl=1
> > ServiceBinary=%12%\WUDFRd.sys
> >
> > [CoInstallers_AddReg]
> > HKR,,CoInstallers32,0x00010000,"WUDFCoinstaller.dll"
> >
> >
> > [DestinationDirs]
> > UMDriverCopy=12,UMDF ; copy to Drivers\UMDF
> > Firmware.CopyFiles=11
> >
> > [UMDriverCopy]
> > NxpNfcClientDriver.dll,,,0x100
> >
> > [Firmware.CopyFiles]
> > NXPPN548FW.DAT
> > NXPPN547FW.DAT
> >
> > [ControlFlags]
> > ExcludeFromSelect=*
> >
> > ; =================== Generic ==================================
> >
> > [Strings]
> > ManufacturerName="NXP Semiconductors"
> > DiskName="NxpNfcClientDriver Installation Disk"
> > WudfRdDisplayName="NxpNfcClientDriver"
> > DeviceName="NxpNfcClientDriver"
> >
> > - EOT -
> 
> [ CC Cristian and Jeremy of NXP ]
> 
> What Linux-kernel configs do I need that PN544 I2C NFC driver works?
> 
> Additionally, I have set CONFIG_I2C_GPIO=m.
> 
> What else is important to be activated?
> 
> Thanks.
> 
> - Sedat -



-- 
With Best Regards,
Andy Shevchenko


