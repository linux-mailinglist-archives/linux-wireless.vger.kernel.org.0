Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E4B1C971
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfENNaT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 09:30:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:58232 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfENNaT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 09:30:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 06:30:18 -0700
X-ExtLoop1: 1
Received: from ozhuraki-desk.fi.intel.com (HELO [10.237.67.35]) ([10.237.67.35])
  by orsmga002.jf.intel.com with ESMTP; 14 May 2019 06:30:16 -0700
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
To:     sedat.dilek@gmail.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Cl=c3=a9ment_Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
 <CA+icZUV_g5mJnmHQKZgtcPj3YfZSYp1DQJT9tmi+892AzRCm3A@mail.gmail.com>
 <20190513123751.GS9224@smile.fi.intel.com>
 <CA+icZUUA8TfU--6b+RwXMf=ui7ww0DK=EurzdMeDUkGvwcJ_rg@mail.gmail.com>
 <2d39b39b-27eb-abef-747f-400433daefee@intel.com>
 <CA+icZUW6vttB8EvgBZYi3kT7uhcbQr+baYbif_V6D78ZNEDbHQ@mail.gmail.com>
From:   Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Message-ID: <4f297fa0-257d-5036-8a1a-0f5434bb5d26@intel.com>
Date:   Tue, 14 May 2019 16:30:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+icZUW6vttB8EvgBZYi3kT7uhcbQr+baYbif_V6D78ZNEDbHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


OK, thanks!

On 5/14/19 3:03 PM, Sedat Dilek wrote:

> It's good to keep both informations - preferable put them into the
> Kconfig help text?

Sure, it's best to keep them both.

Regards,
Oleg
