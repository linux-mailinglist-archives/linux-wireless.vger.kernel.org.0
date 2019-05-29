Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36592D8A8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 11:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE2JJL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 05:09:11 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:51022 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2JJL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 05:09:11 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hVua5-0003pL-NY; Wed, 29 May 2019 11:09:09 +0200
Message-ID: <f3847d4efe6822bba3948993ddc4cde31615436f.camel@sipsolutions.net>
Subject: Re: FYI: vendor specific nl80211 API upstream
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Wed, 29 May 2019 11:09:07 +0200
In-Reply-To: <c7912523-ef79-9ac2-c465-80de189551a6@gmail.com> (sfid-20190528_193645_252220_40C340E7)
References: <c138fac51c7f49bbcd8617ae0a2c750d78abb35d.camel@sipsolutions.net>
         <c7912523-ef79-9ac2-c465-80de189551a6@gmail.com>
         (sfid-20190528_193645_252220_40C340E7)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-05-28 at 12:36 -0500, Denis Kenzior wrote:
> 
> I'm guessing that you guys considered and rejected the idea of pushing 
> these out to a separate, vendor specific genl family instead?

We do actually use that internally (though mostly for cases where we
don't have a cfg80211 connection like manufacturing support), but vendor
commands are there and people do like to use them :-)

The idea with formalizing this is that they actually get more
visibility, and I hope that this will lead to more forming of real
nl80211 API too.

johannes

