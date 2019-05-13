Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AEA1B687
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 14:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfEMM4g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 08:56:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:51249 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfEMM4g (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 08:56:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 05:56:35 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2019 05:56:33 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hQAVM-0001rE-RD; Mon, 13 May 2019 15:56:32 +0300
Date:   Mon, 13 May 2019 15:56:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment?= Perrochaud 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
Message-ID: <20190513125632.GU9224@smile.fi.intel.com>
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
 <CA+icZUUu6NmQoKS-2x32Fz388Q_ahXyYzLLf5JNm=mZR+r-0kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUUu6NmQoKS-2x32Fz388Q_ahXyYzLLf5JNm=mZR+r-0kQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 01:43:12PM +0200, Sedat Dilek wrote:
> On Mon, May 13, 2019 at 12:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

> > Sedat, would be nice if you can compile kernel with this patch series applied
> > and test on your laptop.

> I have tested Andy's v2 series on my ThinkPad T470 successfully with
> Linux v5.1.1.
> 
> Additionally, I had the NFC patch "NFC: fix attrs checks in netlink
> interface" from Andrey Konovalov (see [1]).
> 
> sdi@iniza:~/src/linux-kernel/linux$ git log --oneline v5.1.1..
> 729d291510c2 (HEAD -> 5.1.1-1-amd64-gcc8-ldbfd) Merge branch
> 'for-5.1/nfc-nxp-nci' into 5.1.1-1-amd64-gcc8-ldbfd
> f083f056830c (for-5.1/nfc-nxp-nci-v2) NFC: nxp-nci: Convert to SPDX license tags
> 132b5681e074 NFC: nxp-nci: Remove 'default n' for tests
> 840b1df28cab NFC: nxp-nci: Remove unused macro pr_fmt()
> 5b55e26db0c2 NFC: nxp-nci: Drop comma in terminator lines
> 0a1edd5ce3bb NFC: nxp-nci: Drop of_match_ptr() use
> acae10451393 NFC: nxp-nci: Constify acpi_device_id
> 07648528dae3 NFC: nxp-nci: Get rid of useless label
> 38b8c38f2187 NFC: nxp-nci: Get rid of code duplication in ->probe()
> 446f5aef4522 NFC: nxp-nci: Add GPIO ACPI mapping table
> 813d4243c563 NFC: nxp-nci: Convert to use GPIO descriptor
> 1e5187ddb944 NFC: nxp-nci: Get rid of platform data
> 775a4fa8fb68 NFC: nxp-nci: Add NXP1001 to the ACPI ID table
> db79db400c5b Merge branch 'for-5.1/nfc' into 5.1.1-1-amd64-cbl-asmgoto
> e1c37435140f (for-5.1/nfc) NFC: fix attrs checks in netlink interface
> 
> With neard (daemon) and neard-tools packages from Debian/buster AMD64
> I am able to access, list and poll from my NFC (nfc0) device.
> 
> root@iniza:~# systemctl status neard.service
> ● neard.service - LSB: NFC daemon
>    Loaded: loaded (/etc/init.d/neard; generated)
>    Active: active (running) since Mon 2019-05-13 13:14:12 CEST; 16min ago
>      Docs: man:systemd-sysv-generator(8)
>   Process: 810 ExecStart=/etc/init.d/neard start (code=exited, status=0/SUCCESS)
>     Tasks: 1 (limit: 4915)
>    Memory: 1.6M
>    CGroup: /system.slice/neard.service
>            └─885 /usr/lib/neard/neard
> 
> Mai 13 13:14:12 iniza systemd[1]: Starting LSB: NFC daemon...
> Mai 13 13:14:12 iniza neard[877]: NEAR daemon version 0.16
> Mai 13 13:14:12 iniza neard[810]: Starting NFC daemon: neard.
> Mai 13 13:14:12 iniza systemd[1]: Started LSB: NFC daemon.
> 
> root@iniza:~# nfctool --list
> nfc0:
>           Tags: [ tag0 ]
>           Devices: [ ]
>           Protocols: [ Felica MIFARE Jewel ISO-DEP NFC-DEP ]
>           Powered: Yes
>           RF Mode: Initiator
>           lto: 150
>           rw: 15
>           miux: 2047
> 
> root@iniza:~# nfctool --poll -d nfc0
> Start polling on nfc0 as initiator
> 
> Targets found for nfc0
>   Tags: [ tag1 ]
>   Devices: [ ]
> 
> Thanks to all involved people.
> 
> Please, feel free to add any credits you think are appropriate.
> 
> A big Thank you from North-West Germany.

Thank you for testing. I hope Samuel will take this soon to his tree.

> [1] https://patchwork.kernel.org/patch/10339089/

-- 
With Best Regards,
Andy Shevchenko


