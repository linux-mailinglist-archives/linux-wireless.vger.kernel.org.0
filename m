Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 739DC11451F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 17:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfLEQtx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 11:49:53 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:58228 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbfLEQtx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 11:49:53 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icuK4-004CAO-MO; Thu, 05 Dec 2019 17:49:48 +0100
Message-ID: <2e01fb1d5b8ff3335220231251f893c01c6c22d3.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 05 Dec 2019 17:49:46 +0100
In-Reply-To: <49288397-55b3-f49a-e277-5197d7c1bea3@candelatech.com>
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         <49288397-55b3-f49a-e277-5197d7c1bea3@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-12-05 at 08:37 -0800, Ben Greear wrote:

> > All this seems to mean that the TCP stack isn't feeding us fast enough,
> > but is that really possible?
> 
> Does UDP work better?

Somewhat, I get about 1020-1030 Mbps. But still a TON of "TXQ of STA ...
is now empty" messages. Say this run got about 15 per second of those.

> or pktgen?

I haven't really tried, the setup is a bit complicated ... and it's
nowhere near me either :)

johannes

