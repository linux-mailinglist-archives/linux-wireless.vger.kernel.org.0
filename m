Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79C54BE631
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 22:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392918AbfIYUMH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 16:12:07 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:60104 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbfIYUMH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 16:12:07 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iDDdt-0004Vl-S6; Wed, 25 Sep 2019 22:12:06 +0200
Message-ID: <eeb9aec02f195dd9586aaeff7903b01f7ff904d7.camel@sipsolutions.net>
Subject: Re: Virtual interfaces intel AX200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bruno Antunes <baantunes@gmail.com>, linux-wireless@vger.kernel.org
Date:   Wed, 25 Sep 2019 22:12:03 +0200
In-Reply-To: <CABUTiXX6D=Hoaue2pLPvctdQy2Pv_Pdjj2ysXp5QE3138DTZEw@mail.gmail.com> (sfid-20190920_173448_526464_42707D15)
References: <CABUTiXX6D=Hoaue2pLPvctdQy2Pv_Pdjj2ysXp5QE3138DTZEw@mail.gmail.com>
         (sfid-20190920_173448_526464_42707D15)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-09-20 at 16:34 +0100, Bruno Antunes wrote:
> Hello,
> 
> Does anyone knows if the new intel AX200 or intel AX201 have support
> for multiple virtual interfaces?
> Is there any intel Wi-Fi device that does support it?

TBH I'm not really sure what exactly it does now, but the driver does
contain code to advertise the limits.

I think it's basically P2P + normal client.

johannes

