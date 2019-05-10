Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824BE1A32D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfEJS4J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 14:56:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:24630 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbfEJS4J (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 14:56:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 11:56:08 -0700
X-ExtLoop1: 1
Received: from ozhuraki-desk.fi.intel.com (HELO [10.237.67.35]) ([10.237.67.35])
  by FMSMGA003.fm.intel.com with ESMTP; 10 May 2019 11:56:06 -0700
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     sedat.dilek@gmail.com
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
From:   Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Message-ID: <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com>
Date:   Fri, 10 May 2019 21:55:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi Sedat,

I would like to help you, but at the same time not to mislead, as it’s been a time since I touched that.

So take everything with a grain of salt and correct me where I might be wrong/forgot.

> I am not sure if I need to load the PN544 (I2C) driver?

Yes, the driver is needed, for PN547 it’s NXP NPC100, the driver is drivers/nfc/nxp-nci.

> Do I need these firmware files installed?

To start with, i.e. for a simple signal through like reading a tag, most likely not (the chip is usually provisioned with some FW).

Regards,
Oleg
