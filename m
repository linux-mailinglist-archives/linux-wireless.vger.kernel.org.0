Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 026F6190E22
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 13:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgCXMw5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 08:52:57 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40233 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgCXMw4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 08:52:56 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id DF15EFF806;
        Tue, 24 Mar 2020 12:52:53 +0000 (UTC)
Message-ID: <6eaebae26615eaefa30817456d8d2b49bd12a5fc.camel@hadess.net>
Subject: Re: [PATCH resend 3] staging: rtl8188eu: Add rtw_led_enable module
 parameter
From:   Bastien Nocera <hadess@hadess.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
Date:   Tue, 24 Mar 2020 13:52:53 +0100
In-Reply-To: <20200324124845.GB2401396@kroah.com>
References: <97d2ef68a6bcb7d1ece978eef6315e95732ca39d.camel@hadess.net>
         <20200324113840.GA2322042@kroah.com>
         <7aa74127978a73359ae95cd193bb3092d4536118.camel@hadess.net>
         <20200324123229.GD2348009@kroah.com>
         <9e67f1dd615b810e1725b13003fbb5d9000cd7c0.camel@hadess.net>
         <20200324124845.GB2401396@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0 (3.36.0-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-24 at 13:48 +0100, Greg Kroah-Hartman wrote:
> 
<snip>
> Huh?  Why not fix this properly, as that's the only way this driver
> is
> ever going to be fixed up correctly and get out of staging at all.

Because, unfortunately, I have limited free time.

