Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9231F32A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 14:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfEOMLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 08:11:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:43796 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfEOMLE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 08:11:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 05:11:03 -0700
X-ExtLoop1: 1
Received: from ozhuraki-desk.fi.intel.com (HELO [10.237.67.35]) ([10.237.67.35])
  by fmsmga005.fm.intel.com with ESMTP; 15 May 2019 05:11:01 -0700
Subject: Re: [PATCH 1/2] NFC: nxp-nci: Clarify on supported chips
To:     Sedat Dilek <sedat.dilek@credativ.de>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        =?UTF-8?Q?Cl=c3=a9ment_Perrochaud?= 
        <clement.perrochaud@effinnov.com>, linux-nfc@lists.01.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190515120233.19159-1-sedat.dilek@credativ.de>
From:   Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Message-ID: <f794b70e-2614-9779-0768-e6b8ebdc302a@intel.com>
Date:   Wed, 15 May 2019 15:10:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515120233.19159-1-sedat.dilek@credativ.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/15/19 3:02 PM, Sedat Dilek wrote:
> This patch clarifies on the supported NXP NCI chips and families
> and lists PN547 and PN548 separately which are known as NPC100
> respectively NPC300.

LGTM and thanks!

Regards,
Oleg
