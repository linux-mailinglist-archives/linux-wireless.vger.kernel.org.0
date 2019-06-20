Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8238F4DB16
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfFTUVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 16:21:51 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45214 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfFTUVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 16:21:51 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1he3Z7-0004xJ-P2; Thu, 20 Jun 2019 22:21:49 +0200
Message-ID: <cc4f1755ee5f27c72cbac344988bcb91a1a835f3.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] nl80211: Include wiphy address setup in NEW_WIPHY
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 20 Jun 2019 22:21:47 +0200
In-Reply-To: <144f36779085498bdc1b2f7ac0d0c267d431f51d.camel@sipsolutions.net> (sfid-20190620_220949_979394_9648D591)
References: <20190619223606.4575-1-denkenz@gmail.com>
         <20190619223606.4575-3-denkenz@gmail.com>
         <ec1ca95a5789f9001e89e603633b20316d687721.camel@sipsolutions.net>
         <7da9b924-78c7-ba72-fecc-a11700a34ff4@gmail.com>
         <44923833f1068e360b1f9534a9bbd37be41e4833.camel@sipsolutions.net>
         <427f488f-98f5-f888-f079-e2bbbb6eedf3@gmail.com>
         (sfid-20190620_220528_438291_AA97E7A5) <144f36779085498bdc1b2f7ac0d0c267d431f51d.camel@sipsolutions.net>
         (sfid-20190620_220949_979394_9648D591)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-06-20 at 22:09 +0200, Johannes Berg wrote:
> 
> Sure, but you don't really need to know *everything* about the events
> right there ... you can already filter which ones you care about
> (perhaps you know you never want to bind hwsim ones for example) and
> then request data on those that you do need.

Btw, you can send a filter down when you do request the data, so you
only get the data for the new wiphy you actually just discovered.

So realistically, vs. your suggestion of sending all of the data in
multiple events, that just adds 2 messages (the request and the data you
already had), which isn't nearly as bad as you paint it.

johannes

