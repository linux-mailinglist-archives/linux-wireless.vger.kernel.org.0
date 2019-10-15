Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BB5D77CB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbfJON4Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 09:56:24 -0400
Received: from esa2.hc3102-66.iphmx.com ([139.138.57.83]:19097 "EHLO
        esa2.hc3102-66.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732310AbfJON4Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:24 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Oct 2019 09:56:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=jax.org; i=@jax.org; q=dns/txt; s=selector1;
  t=1571147783; x=1602683783;
  h=arc-seal:arc-message-signature:
   arc-authentication-results:from:to:subject:thread-topic:
   thread-index:date:message-id:accept-language:
   content-language:x-ms-has-attach:x-ms-tnef-correlator:
   authentication-results:x-originating-ip:
   x-ms-publictraffictype:
   x-ms-office365-filtering-correlation-id:
   x-ms-traffictypediagnostic:x-ms-exchange-purlcount:
   x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
   x-forefront-prvs:x-forefront-antispam-report:
   x-ms-exchange-senderadcheck:x-microsoft-antispam:
   x-microsoft-antispam-message-info:
   x-ms-exchange-transport-forked:content-type:mime-version:
   x-originatororg:
   x-ms-exchange-crosstenant-network-message-id:
   x-ms-exchange-crosstenant-originalarrivaltime:
   x-ms-exchange-crosstenant-fromentityheader:
   x-ms-exchange-crosstenant-id:
   x-ms-exchange-crosstenant-mailboxtype:
   x-ms-exchange-crosstenant-userprincipalname:
   x-ms-exchange-transport-crosstenantheadersstamped:
   content-transfer-encoding:ironport-sdr;
  bh=dGljLiAw5Af95CWx8j6A9pWDDDyX4/0s/JGfc5ig1/E=;
  b=bYo6d8M+0czFZ0o7tqs9OqUg61vaN87hCVSD98BTkMEmlNyJkPkQcO3y
   d8wQ+ONF87IXO4hQhsQpp922F3XmkaDakrZTOuXxVn6t/5JXt1e+y53tr
   h78HmlQM6LXvnPmf+di7wF29/D8M2UQY4WEKtqM6sG6q4wnZSA+/6XEhS
   o=;
IronPort-SDR: 5QrYQiSG/P8c/4J/op19yjcx/Ops4c9ajK1FYHk4f4nXjIogNTMjEUKhE0gtA3L1+IJ+23Ehnn
 h4nEqJIFC1z7ydI2RNE8wPC22omDLIHZ6DxzU0u5XK472hEF8y+xFqFeLm7/9bXTzos96lYRAM
 i6oI4mvcGi1Aihj5rRxP9oAobtdjbpH1SNwH2Rttr9xyE3SeM4nv0gu2m8eTUSViuC6rRbohVs
 bhQ/h0l025WWrZfzDUkUhy8sObCHfyB4i1sdxgYYOy+pJDab0vOfl7s1MB28DQv2xXSq/D8omF
 qhA=
Received: from mail-sn1nam01lp2052.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.52])
  by ob1.hc3102-66.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 18:49:16 +0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa2BexA8RcQjvrstsGXjk43nXcTQznEv326pqdS+esC2cmJjSxiL/Zm3qhTT2y4NhYrbOuCUAFlqr/BbofmdxzidoccHRcncCXS6tJzaVG/6rmMzaQ16TCLDMW2jerb+1X1/fGSTktVC05MvAD3Z2KYgbDNfb9SiHH1KS0RI2IcmUS3sLBGLv1PwXyzT7rHNkBgSdbc5ZIoATSXEGAEI7IQklr1vKQY0INWf+J4TCCGqdzezZyhJG782dfzZ58ZVZjD9/AU0BPNdL9XY7Uw9UsmToZKWH9rU9aGAKVXb8fyLoCgpf/PiLp5qDhJXZffS7TwPn5INXkXRSNof4pUyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laLqo12TIgnLyhxDegAuxbBBVCfaAkdATPDCjd8h5Zc=;
 b=TTOBpS+KSQtLCHIwIqh5CPFrEaAW53qyzSr53m+li/SX89cSipQHKCtUqqQzER3eGcRFnZ4/9cKMeOQruHsRsLUR8oi9W3AeOdITWFEt2xaNlgQRnsRc0OrCG2fKgoGUFSC8Cwm8nntf4Uyfjaa1JoueyVe9asf6BEtTXTCWYZlCCfWRsngAXjCsER0sxS7u+D9J7nbWWNzBDJOmAAlHrHpkGYJD4FMOs5+UlggFrjcEnfS2+pOntONjghqfCHEMJoKUICl52Lg1O2IJNmfHMTdgY28fGkgteHWpJvxmwHcT9O9OpHVo9GcSrU2z4xKa3nqyDtE0rRV5CO5K5ReJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jax.org; dmarc=pass action=none header.from=jax.org; dkim=pass
 header.d=jax.org; arc=none
Received: from BN6PR06MB3411.namprd06.prod.outlook.com (10.174.235.157) by
 BN6PR06MB3012.namprd06.prod.outlook.com (10.173.140.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 13:49:15 +0000
Received: from BN6PR06MB3411.namprd06.prod.outlook.com
 ([fe80::eddd:8895:5383:2a8c]) by BN6PR06MB3411.namprd06.prod.outlook.com
 ([fe80::eddd:8895:5383:2a8c%7]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 13:49:15 +0000
From:   Josh Marshall <Josh.Marshall@jax.org>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [unconfirmed bug] missing firmware configuration
 `brcm/brcmfmac43602-pcie.txt`
Thread-Topic: [unconfirmed bug] missing firmware configuration
 `brcm/brcmfmac43602-pcie.txt`
Thread-Index: AQHVg19VevBeY8xXu06GAGf5lszCWA==
Date:   Tue, 15 Oct 2019 13:49:15 +0000
Message-ID:  <BN6PR06MB34116E25E9D86A98C7872988E9930@BN6PR06MB3411.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Josh.Marshall@jax.org; 
x-originating-ip: [162.221.11.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd1e6248-e67f-4671-07e5-08d7517677d7
x-ms-traffictypediagnostic: BN6PR06MB3012:
x-ms-exchange-purlcount: 11
x-microsoft-antispam-prvs:  <BN6PR06MB3012D74CFFA2EE1927DE5A3CE9930@BN6PR06MB3012.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report:  SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(102836004)(6506007)(2906002)(81156014)(81166006)(256004)(14444005)(8936002)(8676002)(476003)(6116002)(99286004)(486006)(2501003)(186003)(3846002)(316002)(786003)(76116006)(66066001)(66476007)(66556008)(64756008)(66446008)(66946007)(26005)(7696005)(71200400001)(71190400001)(966005)(6436002)(5660300002)(7736002)(4001150100001)(86362001)(5640700003)(74316002)(55016002)(9686003)(6306002)(33656002)(305945005)(25786009)(16799955002)(52536014)(14454004)(6916009)(478600001)(2351001)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3012;H:BN6PR06MB3411.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: jax.org does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  +Cf/Ol/OODHlm6mzQJBqlzvsn2mRLke+gAPDtSFhFFbn2Logs5unsF3+lLiBeLC5FfcdZoV8VkR+OWJ7/y7GhAsodTeX41ftRQZRR+fTo83MyqRi1ptvizFchKNCvPLefyf8q7JRBzzaP1U3X91GzFUryGTlFunWrou9Pod8V6nlyLe3GCyfM2+2qf4KjdJNfDKGj2rARPZrrJLyDk3xQhGuzboP2zD6VjQMOm56McAKMPKLvGzMzqjBcjfUMgOPXJFYTBt/Ds1EzkZ7inyUODVQzyfn+Xc1I6tzk6OdhEN4k7zDjjdALsyWtl52Nz0+sEqSaW5OlT5VQ7IDIxids+bUXmY7Qv4iAtQSMnCiVGvrNfP51VbM9qOCOyDvziZlBheUdWc3ILoP/4QkCW878/sbm51D42U7Xp/AkI1Z5etUmS/imyxsAR6IkKkkEgKeGnqvrLZfvTTVdGnk02DWgQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: jax.org
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1e6248-e67f-4671-07e5-08d7517677d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 13:49:15.3896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d665caa-d62e-4678-9f5f-e707cf9ecbd1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ucuq53UQ5fZKU6tANqgPRv8oVQAUy0WpaUdTivBfQ3S292b8SzfkXXaJjCmIKNxiHqMDkKGmqeUq9PWxE9AaBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3012
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 Hello,

First time contacting a kernel mailing list.

I've been trying to fix the wireless on my laptop ( MacBookPro12,1 ).  It h=
as very weak signal strength.  I have at least partially read through the f=
ollowing:

    https://askubuntu.com/questions/775011/macbook-pro-16-04-wifi-driver-in=
stalled-but-not-available
    https://askubuntu.com/questions/1064442/wifi-not-working-with-bcm43602-=
on-ubuntu-18-04
    https://askubuntu.com/questions/622988/wifi-issues-with-macbook-pro-ret=
ina-early-2015-12-2-on-ubuntu-15-04
    https://wiki.debian.org/brcmfmac
    https://ubuntuforums.org/showthread.php?t=3D2354365
    https://askubuntu.com/questions/884291/ubuntu-14-04-wireless-not-workin=
g-on-macbook-pro-dual-boot
    https://www.mail-archive.com/linux-wireless@vger.kernel.org/msg17229.ht=
ml
    https://www.mail-archive.com/search?l=3Dubuntu-bugs@lists.ubuntu.com&q=
=3Dsubject:%22%5C%5BBug+1693521%5C%5D+Re%5C%3A+brcmfmac%5C%3A+Direct+firmwa=
re+load+failed%22&o=3Dnewest
    https://bugs.launchpad.net/ubuntu/+source/linux-firmware/+bug/1772624
    https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware=
.git/plain/brcm/

I created empty files at `/lib/firmware/{brcmfmac43602-pcie.Apple\ Inc.-Mac=
BookPro14\,2.txt,brcmfmac43602-pcie.txt}`

```
$ dmesg | grep brcm
[    5.305998] usbcore: registered new interface driver brcmfmac
[    5.433599] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43602-p=
cie for chip BCM43602/2
[    5.435140] brcmfmac 0000:02:00.0: loading /lib/firmware/brcm/brcmfmac43=
602-pcie.Apple Inc.-MacBookPro14,2.txt failed with error -22
[    5.435142] brcmfmac 0000:02:00.0: Direct firmware load for brcm/brcmfma=
c43602-pcie.Apple Inc.-MacBookPro14,2.txt failed with error -22
[    5.435358] brcmfmac 0000:02:00.0: loading /lib/firmware/brcm/brcmfmac43=
602-pcie.txt failed with error -22
[    5.435359] brcmfmac 0000:02:00.0: Direct firmware load for brcm/brcmfma=
c43602-pcie.txt failed with error -22
[    5.781881] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43602-p=
cie for chip BCM43602/2
[    5.781910] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (e=
rr=3D-2), device may have limited channels available
[    5.782927] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43602/2 wl0: N=
ov 10 2015 06:38:10 version 7.35.177.61 (r598657) FWID 01-ea662a8c
[    5.828561] brcmfmac 0000:02:00.0 wlp2s0: renamed from wlan0
```

What I think may need to happen is to have a particular configuration added=
 like https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmwa=
re.git/plain/brcm/brcmfmac43430-sdio.raspberrypi,3-model-b.txt as `brcmfmac=
43602-pcie.txt` in order to make the full range of channels available, and =
by that improve signal strength, but this is only a shot in the dark.
---

The information in this email, including attachments, may be confidential a=
nd is intended solely for the addressee(s). If you believe you received thi=
s email by mistake, please notify the sender by return email as soon as pos=
sible.

