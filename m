Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D523E1B4E5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 13:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfEML2N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 07:28:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:55647 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728563AbfEML2N (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 07:28:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 04:28:12 -0700
X-ExtLoop1: 1
Received: from ozhuraki-desk.fi.intel.com (HELO [10.237.67.35]) ([10.237.67.35])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2019 04:28:11 -0700
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     sedat.dilek@gmail.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com>
 <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
 <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com>
 <CA+icZUWJ0kZSqogg18LdP2YkNXk=_SNnT7-ufkd_Xp1ak7uchg@mail.gmail.com>
 <2b1bd56f-8797-fb90-e2af-218edaedd089@intel.com>
 <CA+icZUVMjCWwuC-ee1-+EPU6+mYqFZ7w4ai4t4EJcrsvZ2_BYg@mail.gmail.com>
From:   Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Message-ID: <3b7065a2-694f-63bf-fba3-a1641a03ea76@intel.com>
Date:   Mon, 13 May 2019 14:28:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+icZUVMjCWwuC-ee1-+EPU6+mYqFZ7w4ai4t4EJcrsvZ2_BYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi Sedat, Andy,

Andy, thanks a lot for extending and cleaning that up.

> Unsure, why the pn544_i2c NFC driver shipped with the Linux v5.1.1
does not work.

I briefly looked into drivers/nfc/pn544, that seems like an HCI based chip (as opposed to NCI based PN547).

It might be that changes that Andy posted are already sufficient for PN547 to just work with neard (if I am not missing anything).

# sudo apt-get install neard neard-tools
# man nfctool

Regards,
Oleg
