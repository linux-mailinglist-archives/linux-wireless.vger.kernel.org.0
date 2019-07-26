Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5929E75F90
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 09:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGZHSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 03:18:46 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44258 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfGZHSq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 03:18:46 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hquV1-0006fG-VW; Fri, 26 Jul 2019 09:18:44 +0200
Message-ID: <3dc55975efed3f48625d3741408d0242d992e1b4.camel@sipsolutions.net>
Subject: Re: Bug in iw ... scan  output for Ad-Hoc (IBSS) output
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bill Unruh <unruh@physics.ubc.ca>, linux-wireless@vger.kernel.org
Date:   Fri, 26 Jul 2019 09:18:42 +0200
In-Reply-To: <alpine.LMD.2.03.1907251251170.5032@physics.ubc.ca> (sfid-20190725_221110_893806_9B5DB0EE)
References: <alpine.LMD.2.03.1907251251170.5032@physics.ubc.ca>
         (sfid-20190725_221110_893806_9B5DB0EE)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-07-25 at 13:04 -0700, Bill Unruh wrote:
> The output of iw .. scan output for Ad-Hoc (IBSS) does not have a carriage
> return running it into the next access point output
> 
> 
> BSS f6:63:9f:d1:f9:17(on wlp58s0)
>          TSF: 0 usec (0d, 00:00:00)
>          freq: 2437
>          beacon interval: 100 TUs
>          capability: IBSS ShortPreamble (0x0022)
>          signal: -69.00 dBm
>          last seen: 6040 ms ago
>          Information elements from Probe Response frame:
>          SSID: hpsetup
>          Supported rates: 1.0* 2.0* 5.5* 11.0*
>          DS Parameter set: channel 6
>          IBSS ATIM window: 0 TUsBSS 34:31:c4:39:63:ef(on wlp58s0)
> 
> Note the last line-- that is the BSS of the next access point output of iw

Thanks for the report, pushed a fix.

johannes

