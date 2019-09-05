Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22637AABAD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 21:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390548AbfIETCy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 15:02:54 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42278 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbfIETCy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 15:02:54 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i5x1w-0001u3-8u; Thu, 05 Sep 2019 21:02:52 +0200
Message-ID: <bf856e90e1a90f88f69365000dc24d29c025ec70.camel@sipsolutions.net>
Subject: Re: iw scan dump for /AX attributes?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 05 Sep 2019 21:02:50 +0200
In-Reply-To: <8afa882e-64de-7c8b-49f4-ac318f395102@candelatech.com> (sfid-20190905_202028_732652_DDD7D06C)
References: <8afa882e-64de-7c8b-49f4-ac318f395102@candelatech.com>
         (sfid-20190905_202028_732652_DDD7D06C)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-09-05 at 11:20 -0700, Ben Greear wrote:

> Is anyone working on getting iw to print out /AX (HE) related
> info?

Good question, I wonder why we didn't do that. But no, we're not working
on it as far as I know, and I haven't seen anything from anyone else
either.

johannes

