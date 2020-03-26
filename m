Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A93193AC1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 09:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgCZIYO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 04:24:14 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43166 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgCZIYN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 04:24:13 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jHNoB-00Aiyz-D8; Thu, 26 Mar 2020 09:24:11 +0100
Message-ID: <1f9123cc49768db30115c364358ea4898bcfff9d.camel@sipsolutions.net>
Subject: Re: Geoffroy LETOURNEUR: Samsung AX200 system integration on Nvidia
 Nano.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Geoffroy Letourneur <g.letourneur@samsung.com>,
        Matthias May <matthias.may@neratec.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
Cc:     Gilles Mazars <g.mazars@samsung.com>,
        Martin Bourreau <m.bourreau@samsung.com>
Date:   Thu, 26 Mar 2020 09:24:09 +0100
In-Reply-To: <6AA2E7A5-70C5-4A5D-A934-0D0DDCA024FD@samsung.com> (sfid-20200326_091919_381402_6D138FEE)
References: <CGME20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba@uscas1p1.samsung.com>
         <8096A04E-8692-4DC3-A8D0-8F85FF972799@samsung.com>
         <04b77faf-2862-22a4-c7e1-1163219e76e9@neratec.com>
         <6AA2E7A5-70C5-4A5D-A934-0D0DDCA024FD@samsung.com>
         (sfid-20200326_091919_381402_6D138FEE)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-03-26 at 08:19 +0000, Geoffroy Letourneur wrote:
> Hello Matthias,
> 
> The AX200 module seems to support AP mode it works with 2.4GHz Wifi
> 802.11n mode, I tested it. But maybe it could not support this mode in
> 802.11ax. 

2.4 GHz should be OK - 5 GHz is generally limited on those devices due
to regulatory restrictions.

johannes

